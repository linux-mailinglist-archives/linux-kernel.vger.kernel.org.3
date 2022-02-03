Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAC84AAD45
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 01:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358883AbiBFArR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 19:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbiBFArQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 19:47:16 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5A8C061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 16:47:15 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id ba1c05f4-8538-11ec-ac19-0050568cd888;
        Thu, 03 Feb 2022 21:32:02 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id BB2CE194B78;
        Thu,  3 Feb 2022 22:31:02 +0100 (CET)
Date:   Thu, 3 Feb 2022 22:31:00 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 10/21] fb: Delete fb_info->queue
Message-ID: <YfxJlH2NDnLk/GUw@ravnborg.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-11-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-11-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:05:41PM +0100, Daniel Vetter wrote:
> It was only used by fbcon, and that now switched to its own,
> private work.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
I would merge this with the patch that drops the usage

> ---
>  include/linux/fb.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 02f362c661c8..a8a00d2ba1f3 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -449,7 +449,6 @@ struct fb_info {
>  	struct fb_var_screeninfo var;	/* Current var */
>  	struct fb_fix_screeninfo fix;	/* Current fix */
>  	struct fb_monspecs monspecs;	/* Current Monitor specs */
> -	struct work_struct queue;	/* Framebuffer event queue */
>  	struct fb_pixmap pixmap;	/* Image hardware mapper */
>  	struct fb_pixmap sprite;	/* Cursor hardware mapper */
>  	struct fb_cmap cmap;		/* Current cmap */
> -- 
> 2.33.0
