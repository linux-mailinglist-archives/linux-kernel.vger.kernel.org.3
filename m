Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83364CB7FC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiCCHi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiCCHiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:38:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015B19C0D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 23:37:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E51C2B82372
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27ECC340E9;
        Thu,  3 Mar 2022 07:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646293049;
        bh=BJkNCZO8VweLQb/iuw+uNcHhYzo/oeyZsonYLCZ0vMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asGAnY3yX0TssdtIsJzTeUfBYo5PN8zscaOrtr7l5qJ8d/3+dnAoLJGMNWn24ca8s
         PAQC47RRmyNnpguBfP8GeW9sV8sXuqWccmGzL77zxk2EJHNe8Y5xzQ0csljbmIS9zZ
         dU1hGuZATeAAGWxfzxPJrITx5lrfTj3gtrpFzntM=
Date:   Thu, 3 Mar 2022 08:37:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: vt: consolemap: Add missing kfree() in
 con_do_clear_unimap()
Message-ID: <YiBwNUPTm8zR2BEU@kroah.com>
References: <20220303020630.460257-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303020630.460257-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 10:06:30AM +0800, Jianglei Nie wrote:
> We should free p after con_release_unimap(p) like the call points of
> con_release_unimap() do in the same file.
> 
> This patch adds the missing kfree() after con_release_unimap(p).
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/tty/vt/consolemap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> index d815ac98b39e..5279c3d27720 100644
> --- a/drivers/tty/vt/consolemap.c
> +++ b/drivers/tty/vt/consolemap.c
> @@ -520,6 +520,7 @@ static int con_do_clear_unimap(struct vc_data *vc)
>  		p->refcount++;
>  		p->sum = 0;
>  		con_release_unimap(p);
> +		kfree(p);
>  	}
>  	return 0;
>  }
> -- 
> 2.25.1
> 

How did you test this code?
