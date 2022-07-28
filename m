Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA153583A55
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiG1I0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiG1I0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579225A899;
        Thu, 28 Jul 2022 01:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F115D61BB0;
        Thu, 28 Jul 2022 08:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1499C433D6;
        Thu, 28 Jul 2022 08:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658996773;
        bh=BE1Uf+u1Zq72ZASnCeBKBLimp68pHrCgnFdgo08tN54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpNAlTLjLV4qOnyUNzXseY2L3I4tIZRxIiIHi304cDyWHFa1ZfCLGo22Rz/hworxb
         2mr8AxqZLRaAqGvt+l6JNKNQxgXXc4Zklo/UXQxUfWQKV/WNwisSKUeNhChEAEkd/f
         g/NXEjIk6kfIzf+bfvGD3ZjW9ZWdFe//6UrahDRY=
Date:   Thu, 28 Jul 2022 10:26:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xingrui Yi <yixingrui@linux.alibaba.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: remove old FONT ioctls definitions in uapi
Message-ID: <YuJIIl/LwGwuYdib@kroah.com>
References: <20220722061133.7765-1-yixingrui@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722061133.7765-1-yixingrui@linux.alibaba.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 02:11:33PM +0800, Xingrui Yi wrote:
> As was demonstrated by commit ff2047fb755d ("vt: drop old FONT ioctls"),
> old font ioctls like PIO_FONT have been deleted and KDFONTOP ioctl is used
> for years instead.
> 
> However, unused definitions of these ioctl numbers and "strut
> consolefontdesc" still exist in a uapi header. They could have been removed
> since no userspace was using them. Otherwise they will become a
> misleading for users, and users will fail with ENOTTY with wrong call.
> 
> We are moving old font ioctl numbers definitions here to guide users to
> use KDFONTOP.
> 
> Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
> ---
>  include/uapi/linux/kd.h | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
> index ee929ece4112..d739b17fc942 100644
> --- a/include/uapi/linux/kd.h
> +++ b/include/uapi/linux/kd.h
> @@ -6,19 +6,6 @@
>  
>  /* 0x4B is 'K', to avoid collision with termios and vt */
>  
> -#define GIO_FONT	0x4B60	/* gets font in expanded form */
> -#define PIO_FONT	0x4B61	/* use font in expanded form */
> -
> -#define GIO_FONTX	0x4B6B	/* get font using struct consolefontdesc */
> -#define PIO_FONTX	0x4B6C	/* set font using struct consolefontdesc */
> -struct consolefontdesc {
> -	unsigned short charcount;	/* characters in font (256 or 512) */
> -	unsigned short charheight;	/* scan lines per character (1-32) */
> -	char __user *chardata;		/* font data in expanded form */
> -};
> -
> -#define PIO_FONTRESET   0x4B6D	/* reset to default font */
> -
>  #define GIO_CMAP	0x4B70	/* gets colour palette on VGA+ */
>  #define PIO_CMAP	0x4B71	/* sets colour palette on VGA+ */
>  

Did you rebuild a distribution like Debian to verify that these values
and structure are not used anywhere?

thanks,

greg k-h
