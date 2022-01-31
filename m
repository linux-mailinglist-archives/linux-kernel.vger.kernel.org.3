Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC4D4A510C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381163AbiAaVHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379703AbiAaVGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF4AC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso497871wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fEFT7RaLl3MIWyBeJu8+YbW4+Kc4zGdBG2ByELA82FY=;
        b=GUAHnoGJ2g60XQIxA1S0UBTEjmAhGsZ5SnXwaSbMm4WguOGFJ080okWbKoG6WuelXb
         voQq0GCXWqeAxlMSnqXUzcMTJe09M5cg5JRDYNy2F4304We++p19+m+1PzPGP4OK3sng
         CMHb0eixfCd0LaM62LMEll+iAEqIn9PA0TosA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEFT7RaLl3MIWyBeJu8+YbW4+Kc4zGdBG2ByELA82FY=;
        b=DHzjtmJnVTPkRkcsFXZxrtZJ9+heYsK/boPdYfuBkoMHZ1RuUi1TW5jymdTw/CT+lN
         d1v04YRtuHFPyFs64UC7qzwfJECf5FDjNsTLxTzRYld27/dv+VCiqr4k+4JYbY1setxV
         an7J5g7/rF4nP8noTKnQ83vrJ1gxeuPfXbzzqygLRH+3SYjtT+fJcWCoe1vq1xBDVqzJ
         XrNGKYzw7U7Tij6RNLPtdtmiq6MOle1Xw0r/qWsrgRM+aHVeeBrWgAq/sjfLTLCXGjP/
         s0X+SnguinGPJJVg6aulc1/BKdR0kW0+tj32cOsnYw0qtkrycgo7tVXNQLEr7Reeedfk
         FFSA==
X-Gm-Message-State: AOAM532Nle6fMD3fPld/YqwrT4ysF3OGy2JbiwMetZeil8xFjtXn5FY1
        j2xkdf1JSTE4+fW/lQ96Dhb4Nw==
X-Google-Smtp-Source: ABdhPJwadVtgHupBXYfEY4Bh9lTcVc2T1fYq6ymL+YzCfw4JZaBt+O2KULSz2DRwEILgsDakrL0ghg==
X-Received: by 2002:a05:600c:1f15:: with SMTP id bd21mr28339002wmb.145.1643663204166;
        Mon, 31 Jan 2022 13:06:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:43 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 10/21] fb: Delete fb_info->queue
Date:   Mon, 31 Jan 2022 22:05:41 +0100
Message-Id: <20220131210552.482606-11-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was only used by fbcon, and that now switched to its own,
private work.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 include/linux/fb.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 02f362c661c8..a8a00d2ba1f3 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -449,7 +449,6 @@ struct fb_info {
 	struct fb_var_screeninfo var;	/* Current var */
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */
-	struct work_struct queue;	/* Framebuffer event queue */
 	struct fb_pixmap pixmap;	/* Image hardware mapper */
 	struct fb_pixmap sprite;	/* Cursor hardware mapper */
 	struct fb_cmap cmap;		/* Current cmap */
-- 
2.33.0

