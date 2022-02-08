Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816824AE4BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387321AbiBHWgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386718AbiBHVIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:08:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA69C0612BA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:08:45 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so2005320wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxmmBkNFc2e7V4ERjxKal7nxxEacNSK1FsSHDJ/tyIc=;
        b=Z09sK1MIQXvHodEW69pcLwZPAC2Jyh1Yq9ldGqdLR7reUraZE7M6u7jdOOeYRDBf89
         UUxkLMzeLBfxd3O4D0f+4VPHvHICjubc4fPRQHDK7GB4hbBxyg8oSXZLVun1qG1/NbkT
         QOvr5w/LmHavg6G1SUwn1zrJxyAMEJXhXZfiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxmmBkNFc2e7V4ERjxKal7nxxEacNSK1FsSHDJ/tyIc=;
        b=mH0hyNblSkMhY4dYGCezzYJJZpQ7piL205VBsArfARf6wBMru1Nn4nxyQfu8Pnbh3U
         Xuw/fw1rqI8Wykl8fq1/RmWDdqL1uRXVPRLElUxP5SUmbBcpUSWx2p0Skc4TkBWwzZ4A
         PRLQ50+N400VF6c0coJR2dV/nVSckrXQlVcLknb1LNlHbLFUIF5gjxi+9trZAC6DJkMY
         /0UouuAtAdsRSyF1Phwa3NwpAhzyX9elQ1LWNpkw2r9NnksYovb3WRX7at2ciiV/bMPL
         UbFmCXlw5BhOqcUTx+YgeG5YIRZCw3mMOEBvfBrPIWeUPl9j169YlRFTHIBcgDNTAM1U
         yPPQ==
X-Gm-Message-State: AOAM531NQRqACVJleV8CAHAxY1tvOefP+IqX7h6jusoflt7bFdLsRibQ
        KeBb6boCsKrIvjmNHaRTRShySw==
X-Google-Smtp-Source: ABdhPJx9Pmbs1AtHCBnIRUQUhg6MOdNihnyQs/peWemRHhguZJlE+pEmulNqns55/ByeHXTnphkZ2g==
X-Received: by 2002:a05:600c:3394:: with SMTP id o20mr2536218wmp.186.1644354524370;
        Tue, 08 Feb 2022 13:08:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:44 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH v2 08/19] fb: Delete fb_info->queue
Date:   Tue,  8 Feb 2022 22:08:13 +0100
Message-Id: <20220208210824.2238981-9-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was only used by fbcon, and that now switched to its own,
private work.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 include/linux/fb.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3d7306c9a706..23b19cf8bccd 100644
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
2.34.1

