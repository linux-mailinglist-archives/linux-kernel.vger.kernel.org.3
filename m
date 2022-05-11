Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C223523B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbiEKRBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbiEKRBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:01:01 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EB03D4B3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=CthhuaoXqbko6XshXK+xcu1gXO9c1mU6sdAFETgYJ8A=;
        b=qgnd50kXwQ5+SvNZ/1DmyHrbIjfVttYuUqdExe7VezKD6EW2utqdLl8CxI7LRgETGFCrY/w/qpcE4
         vcBCGIRq4YkCkZj4vODXOpydPykFlQLg2Yd+FRk76aR54rCNoGhmlnWYQefY9r57KMMmXNBZy1tLB1
         CJpXkraAUpUWRu3jchdxDeptn1bRvyAC85JxRQ7vrxKX9EOc/PoLsy6JekjRFyUpzBEKQ6SE6h3mmO
         Ok/tduP2T/9AhMjpzQp0zAay8A4106fVkGf6drF4gUI5Kll+rLphZeKcNDUnHgeRhL2pUcn2BklfCD
         fO0jybTLHKfvMQtSvX4MpPxsAAvMiug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=CthhuaoXqbko6XshXK+xcu1gXO9c1mU6sdAFETgYJ8A=;
        b=DcNFrpcOaBXAFCMtuWqzqZ5wO4r1XoPdsezcW3M7H7vfhOekJ4jGAYV+TIlsu6PFrkm057Lg0B+Xx
         Qgu9cFLDw==
X-HalOne-Cookie: 81577a4a9f2127a7356dca5ca047496006afae08
X-HalOne-ID: eb69835a-d14b-11ec-be6b-d0431ea8bb03
Received: from mailproxy4.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id eb69835a-d14b-11ec-be6b-d0431ea8bb03;
        Wed, 11 May 2022 17:00:55 +0000 (UTC)
Date:   Wed, 11 May 2022 19:00:52 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 7/7] fbdev: Make registered_fb[] private to fbmem.c
Message-ID: <YnvrxICnisXU6I1y@ravnborg.org>
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511113230.1252910-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511113230.1252910-1-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier.

On Wed, May 11, 2022 at 01:32:30PM +0200, Javier Martinez Canillas wrote:
> From: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Well except when the olpc dcon fbdev driver is enabled, that thing
> digs around in there in rather unfixable ways.
> 
> Cc oldc_dcon maintainers as fyi.

Another way to fix this is to mark FB_OLPC_DCON and add a TODO entry to
fix this. We are really not supposed to carry such special code around
to keep staging working.

I know this may not be a popular viewpoint, but just look at the ugly
workarounds required here.

	Sam


> 
> v2: I typoed the config name (0day)
> 
> Cc: kernel test robot <lkp@intel.com>
> Cc: Jens Frederich <jfrederich@gmail.com>
> Cc: Jon Nettleton <jon.nettleton@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Zheyu Ma <zheyuma97@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> (no changes since v1)
> 
>  drivers/video/fbdev/core/fbmem.c | 8 ++++++--
>  include/linux/fb.h               | 7 +++----
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 265efa189bcc..6cab5f4c1fb3 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -50,10 +50,14 @@
>  static DEFINE_MUTEX(registration_lock);
>  
>  struct fb_info *registered_fb[FB_MAX] __read_mostly;
> -EXPORT_SYMBOL(registered_fb);
> -
>  int num_registered_fb __read_mostly;
> +#if IS_ENABLED(CONFIG_FB_OLPC_DCON)
> +EXPORT_SYMBOL(registered_fb);
>  EXPORT_SYMBOL(num_registered_fb);
> +#endif

It is stuff like this I refer to as "ugly" in the comment above.

	Sam
