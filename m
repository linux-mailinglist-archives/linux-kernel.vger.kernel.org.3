Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8355C4E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiF0OGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiF0OGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F012751
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9831D60C0A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8CAC3411D;
        Mon, 27 Jun 2022 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656338774;
        bh=fWEojwnmuhByQR8ln3ETFFbd1Xw1B+EJieplMRTu8zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWQ+W8GBo4tBpKo2Iy6letizLiAHNCg2rn2SHULXfxIHRYqlt3Ov+YNDho5gLm4Xa
         o7jXNNbmlDceoKj5ge8YIRwSlVB04Q90vABsU7F6Jx+A2UXJD9Ld2Yqq6+30E+ZUuW
         zUcIdbh8CtBQ0aE9Q25ZzvqmHCDapIvknxX1d4kc=
Date:   Mon, 27 Jun 2022 16:06:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhi Song <zhi.song@bytedance.com>
Cc:     vilhelm.gray@gmail.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] isa: put_device after failing to device_register
Message-ID: <Yrm5U0wU7tJPhyp6@kroah.com>
References: <20220615151558.1766067-1-zhi.song@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615151558.1766067-1-zhi.song@bytedance.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:15:58PM +0800, Zhi Song wrote:
> device_register() is used to register a device with the system.
> We need to call put_device() to give up the reference initialized
> in device_register() when it returns an error and this will clean
> up correctly.
> 
> Fixes: a5117ba7da37 ("Driver model: add ISA bus")
> Signed-off-by: Zhi Song <zhi.song@bytedance.com>
> ---
> V1 -> V2: Fix up the changelog text correct.
> V2 -> V3: Add a fixes tag line specifying the commit where this bug was
> introduced.
> ---
>  drivers/base/isa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/isa.c b/drivers/base/isa.c
> index 55e3ee2da98f..cf88f3d77b7d 100644
> --- a/drivers/base/isa.c
> +++ b/drivers/base/isa.c
> @@ -173,8 +173,10 @@ static int __init isa_bus_init(void)
>  	error = bus_register(&isa_bus_type);
>  	if (!error) {
>  		error = device_register(&isa_bus);
> -		if (error)
> +		if (error) {
> +			put_device(&isa_bus);

Did you test this change and notice the kernel log error that happens
when you run it?

If you can really reproduce this in a real-life situation, you need to
do more than just this change.

thanks,

greg k-h
