Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC6E51E87F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346210AbiEGQYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiEGQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:24:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39D420186;
        Sat,  7 May 2022 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651940458; x=1683476458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/b/+Mr0B5Zhv55WA58zICS5As/BFDYSFtkZY5yJGamg=;
  b=YudgmDP/5Ndca9n+OqqhclBIR3VUXtdzUKtiANrqiPKFIDCCUKI0WxKf
   Qf2R7ehOJTlXpTxvJVFeoOy+e9Yp7DXS3Gy4hCXI/XR800vcvXEYDPNoN
   bQHp0adi6jp5XgYyv8u41tEEZlEwxz5naSGYFJILkZM8fe1cRK0fy2uDK
   WL6hrOtWX/26HusT5F5s1pim18K+X9q+PKbr4Z6lv8rC6dAJjYm65wmIt
   CSCwlV+WsF77DXdzKP5cZK3ERgnXVrwBGPhu6HjECOHxNEm+7mqa+YTY3
   fFxG+iVlEdtRMENs7bcfbSGOoI8Qv5/bBQiei4SjNUOh59K+IJajV5snW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="329278706"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="329278706"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 09:20:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="586552379"
Received: from hmendezc-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.252.138.85])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 09:20:54 -0700
Date:   Sat, 7 May 2022 09:20:53 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Peter Jones <pjones@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] fbdev: efifb: Fix a use-after-free due early fb_info
 cleanup
Message-ID: <20220507162053.auo2idd5twvnxatj@ldmartin-desk2>
References: <20220506132225.588379-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506132225.588379-1-javierm@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 03:22:25PM +0200, Javier Martinez Canillas wrote:
>Commit d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather
>than .remove") attempted to fix a use-after-free error due driver freeing
>the fb_info in the .remove handler instead of doing it in .fb_destroy.
>
>But ironically that change introduced yet another use-after-free since the
>fb_info was still used after the free.
>
>This should fix for good by freeing the fb_info at the end of the handler.
>
>Fixes: d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove")

are these patches going through any CI before being applied? Maybe would
be a good idea to cc intel-gfx mailing list on these fixes to have Intel
CI to pick them up for some tests?

pushed to drm-misc-fixes where the previous patch was applied.

thanks
LUcas De Marchi

>Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>Reported-by: Andrzej Hajda <andrzej.hajda@intel.com>
>Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>---
>
> drivers/video/fbdev/efifb.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
>index cfa3dc0b4eee..b3d5f884c544 100644
>--- a/drivers/video/fbdev/efifb.c
>+++ b/drivers/video/fbdev/efifb.c
>@@ -259,12 +259,12 @@ static void efifb_destroy(struct fb_info *info)
> 			memunmap(info->screen_base);
> 	}
>
>-	framebuffer_release(info);
>-
> 	if (request_mem_succeeded)
> 		release_mem_region(info->apertures->ranges[0].base,
> 				   info->apertures->ranges[0].size);
> 	fb_dealloc_cmap(&info->cmap);
>+
>+	framebuffer_release(info);
> }
>
> static const struct fb_ops efifb_ops = {
>-- 
>2.35.1
>
