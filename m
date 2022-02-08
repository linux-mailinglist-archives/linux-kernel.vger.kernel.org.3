Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FDF4AE3B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387371AbiBHWXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386743AbiBHVI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:08:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FEEC0612BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:08:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q7so506885wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NR3Vdl26ogLJ+NN6vOMjLgqKjNNnH/ILBJ7SwyK58u4=;
        b=NngozCg3J7yEp5L8pu/P/IyZeg/re7bovaBC5F+6eL8Vv+gBM4lELsCPvoIG1krc8x
         fn3vBTkvV/mGVP7Iviya7yAY4SMFa6v06yL2bpIDEOR57CQmP1GIorMKxvW2TfxkB9Fh
         5nRE/JTAEFZejtofuDVVxS2+4o5bnY8TkR/2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NR3Vdl26ogLJ+NN6vOMjLgqKjNNnH/ILBJ7SwyK58u4=;
        b=eFSxgCYemPeVxWEMbaHvdG7n1//Wus148mS4p2s/dMi5eaSJUiJaSfD0Zl9Wxo7pQB
         rmWS3QdjQCU5us1f2VXSoMte/+VXdRLGtRZc85lPvAy33tj/8KbqseY9S/janxs+cLiS
         RXL//l/vBKaFo9OoRI8E9nExK7lrizgSJMFa/c43dHgBBPmkUSCyfiJtZlggOcAvMMNf
         /cjyIQpsluaWYWYJIQtioqpnMDwBF0Vvggh2+1IwQxK7qlQfrvuwbRd4LVEwIMPgSNOH
         WCxuFPzyMzxSoI0p6mrhva1danj8QOJk+gR1YsH1W8hYdH3JcNSvHAcLBmOINKl5KWas
         PZBQ==
X-Gm-Message-State: AOAM530g/XI+xFIIOKDtXpCVtOgTB1roeTLUHcw972HLGji/Ecdh9Nv2
        hvErBcWJ3Y+fchQxbbsd7r/+/g==
X-Google-Smtp-Source: ABdhPJyow1dh1qcgGqJFdixNGVvExdy2/GOvui0v1qlnbPgy6uaK5cpmHHHwHze64OPlU3pcDhqIUA==
X-Received: by 2002:adf:a4c8:: with SMTP id h8mr324157wrb.169.1644354534298;
        Tue, 08 Feb 2022 13:08:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:53 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Du Cheng <ducheng2@gmail.com>, Claudio Suarez <cssk@net-c.es>
Subject: [PATCH v2 15/19] fbcon: Move more code into fbcon_release
Date:   Tue,  8 Feb 2022 22:08:20 +0100
Message-Id: <20220208210824.2238981-16-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

con2fb_release_oldinfo() has a bunch more kfree() calls than
fbcon_exit(), but since kfree() on NULL is harmless doing that in both
places should be ok. This is also a bit more symmetric now again with
fbcon_open also allocating the fbcon_ops structure.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Claudio Suarez <cssk@net-c.es>
---
 drivers/video/fbdev/core/fbcon.c | 33 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index abb419a091c6..685b4a9e5546 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -690,6 +690,18 @@ static void fbcon_release(struct fb_info *info)
 	unlock_fb_info(info);
 
 	module_put(info->fbops->owner);
+
+	if (info->fbcon_par) {
+		struct fbcon_ops *ops = info->fbcon_par;
+
+		fbcon_del_cursor_work(info);
+		kfree(ops->cursor_state.mask);
+		kfree(ops->cursor_data);
+		kfree(ops->cursor_src);
+		kfree(ops->fontbuffer);
+		kfree(info->fbcon_par);
+		info->fbcon_par = NULL;
+	}
 }
 
 static int fbcon_open(struct fb_info *info)
@@ -740,18 +752,10 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
 static void con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
 				   struct fb_info *newinfo)
 {
-	struct fbcon_ops *ops = oldinfo->fbcon_par;
 	int ret;
 
 	fbcon_release(oldinfo);
 
-	fbcon_del_cursor_work(oldinfo);
-	kfree(ops->cursor_state.mask);
-	kfree(ops->cursor_data);
-	kfree(ops->cursor_src);
-	kfree(ops->fontbuffer);
-	kfree(oldinfo->fbcon_par);
-	oldinfo->fbcon_par = NULL;
 	/*
 	  If oldinfo and newinfo are driving the same hardware,
 	  the fb_release() method of oldinfo may attempt to
@@ -3315,19 +3319,8 @@ static void fbcon_exit(void)
 			}
 		}
 
-		if (mapped) {
-			if (info->fbcon_par) {
-				struct fbcon_ops *ops = info->fbcon_par;
-
-				fbcon_del_cursor_work(info);
-				kfree(ops->cursor_src);
-				kfree(ops->cursor_state.mask);
-				kfree(info->fbcon_par);
-				info->fbcon_par = NULL;
-			}
-
+		if (mapped)
 			fbcon_release(info);
-		}
 	}
 }
 
-- 
2.34.1

