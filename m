Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD2055CEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiF1GJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbiF1GJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3CD19C37
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 685BB61762
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71145C341CB;
        Tue, 28 Jun 2022 06:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656396548;
        bh=NEyQRgpgmXqepB2EtJAob0lZEohaGhqRQtLLlwsmSpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXHC33OJDNb2i9taUS3aAF5coW925aml7LgemTvCafqMV/i1txtY3y5A/Fx3VBA3d
         aPhX0OZhiQ9EOrbGB4H4WfzirGOmPzzidqCpY13tKee0AHAEq75Htwzg1+F275MC4a
         Xq4bnIvCF0fyT/9a2sh4k8XOlotptQceFbhLmnlk=
Date:   Tue, 28 Jun 2022 08:09:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        johannes@sipsolutions.net
Subject: Re: [PATCH v7] devcoredump: change gfp_t parameter of kzalloc to
 GFP_KERNEL
Message-ID: <YrqbAgM6aR8OKpZj@kroah.com>
References: <20220628034458.17384-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628034458.17384-1-duoming@zju.edu.cn>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:44:58AM +0800, Duoming Zhou wrote:
> The dev_coredumpv() and dev_coredumpm() could not be used in atomic
> context, because they call kvasprintf_const() and kstrdup() with
> GFP_KERNEL parameter. The process is shown below:
> 
> dev_coredumpv(.., gfp_t gfp)
>   dev_coredumpm(.., gfp_t gfp)
>     kzalloc(.., gfp);
>     dev_set_name
>       kobject_set_name_vargs
>         kvasprintf_const(GFP_KERNEL, ...); //may sleep
>           kstrdup(s, GFP_KERNEL); //may sleep
> 
> This patch changes the gfp_t parameter of kzalloc() in dev_coredumpm() to
> GFP_KERNEL in order to show they could not be used in atomic context.
> 
> What's more, this patch does not remove the gfp_t parameter in
> dev_coredumpv() and dev_coredumpm() in order that it will not influence
> other new users that are added in other trees.
> 
> Fixes: 833c95456a70 ("device coredump: add new device coredump class")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v7:
>   - change gfp_t parameter of kzalloc in dev_coredumpm() to GFP_KERNEL.
> 
>  drivers/base/devcoredump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index f4d794d6bb8..cf60aacf8a8 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -268,7 +268,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  	if (!try_module_get(owner))
>  		goto free;
>  
> -	devcd = kzalloc(sizeof(*devcd), gfp);
> +	devcd = kzalloc(sizeof(*devcd), GFP_KERNEL);

No, you can't just ignore the flag entirely, that doesn't help anyone
out who tries to set it and is totally confused as to why the field is
ignored.

You need to evolve the function over time to not need the parameter at
all, this just papers over the entire issue, which makes the api lie to
the caller, not something you ever want to do.

thanks,

greg k-h
