Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1410850CADA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiDWN4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiDWN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:56:39 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Apr 2022 06:53:41 PDT
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5956E19C2F
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=DiK8nxAmT5CjsuqAm40aEBUJBBmqvVVGEPk3NssYP10=;
        b=YOIntkTZj1R//lKe47NzRJJXg89UyUGK1bpz517IXiiYqXzBJuDgZCS1rSQKA2hYxMzDC2ySesW67
         M4Tf3LQw8GaUWYZoZUgh8zhqM7ODmCicDYhWczQi1E77WJM86eak06HKCb3Ar1x8GG/q1XFGGF6LH5
         +4+UhmACuEObDb+4U4Fgz7v7X1ohT49GmZDj6HrOShAJTKMZX3dyGrS6nXafaAo1+TY+UuIFJWKPtR
         5EsybSbsEU3MlX2s7wcpFpOQwBlh8Jv4SN0DcaL0XMchI+L9b3+aQ4CuV77d9TMSNv2A/DmfpPa5qo
         vgbqaDnnU3fWXrbYjMPg2er3OTyqYwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=DiK8nxAmT5CjsuqAm40aEBUJBBmqvVVGEPk3NssYP10=;
        b=3FxP/bRo0OofayGaYqrhv1GXum/iei6Z5bGl9JZOETuUd36XHKGVJtTbpKQZ6yocRu6LsB6bt1ler
         vgcNxLEDw==
X-HalOne-Cookie: af45df9e17cb05a2750f22d339417b5f127d72f1
X-HalOne-ID: a1ddb960-c30c-11ec-be69-d0431ea8bb03
Received: from mailproxy2.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id a1ddb960-c30c-11ec-be69-d0431ea8bb03;
        Sat, 23 Apr 2022 13:52:36 +0000 (UTC)
Date:   Sat, 23 Apr 2022 15:52:35 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Tom Rix <trix@redhat.com>
Cc:     daniel@ffwll.ch, deller@gmx.de, tzimmermann@suse.de,
        javierm@redhat.com, cssk@net-c.es, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbcon: change fbcon_*registered_fb variables to static
Message-ID: <YmQEo6FWXOsdhiz5@ravnborg.org>
References: <20220423125618.1916005-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423125618.1916005-1-trix@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 08:56:18AM -0400, Tom Rix wrote:
> Sparse reports these issues
> fbcon.c:106:16: warning: symbol 'fbcon_registered_fb' was not declared. Should it be static?
> fbcon.c:107:5: warning: symbol 'fbcon_num_registered_fb' was not declared. Should it be static?
> 
> These variables are only used in fbcon.c. Single file use variables should
> be static, so change their storage-class specifiers to static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/video/fbdev/core/fbcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index c4e91715ef00..225ac0fe0143 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -103,8 +103,8 @@ enum {
>  
>  static struct fbcon_display fb_display[MAX_NR_CONSOLES];
>  
> -struct fb_info *fbcon_registered_fb[FB_MAX];
> -int fbcon_num_registered_fb;
> +static struct fb_info *fbcon_registered_fb[FB_MAX];
> +static int fbcon_num_registered_fb;
>  
>  #define fbcon_for_each_registered_fb(i)		\
>  	for (i = 0; WARN_CONSOLE_UNLOCKED(), i < FB_MAX; i++)		\
> -- 
> 2.27.0
