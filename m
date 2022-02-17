Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564654B9714
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiBQDtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:49:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiBQDtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:49:14 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9958EC5DBC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:52 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id f13so1372390ilq.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+1diemf3MRoXdblNNavyGZGnh4l9BWi+2yg35q/w2I=;
        b=piNFTBhwQ7mhrk0SHb3PWRDl5OjBX/bAyNasGSPh1MsbJOAUlq4M54/Ycs9JEz1OkK
         ajhk18Y44UImCvX03at6dUQBwc5j8vy67kAtnKDCOYHUbW3oNqVu5AQYP1CNBcWAJXyx
         7ATDZmawW4xanGN6qmHekUzUPlIwkViD3xOIQiA9DMIvaFoN//ASa3mFsYgEglo1/2wS
         FriiPIYnPHJvQnETNxtDTyeu0G+YT4qQXT6YzncWfiy55/qVnfJYcUY7uI45Z/ZaMfJ+
         XKf9lW5gCeT4210yp9SCnnt0FkxKMe9FDNoK3D32OZBZfcoopIMU3gCIg3tOjq2EODRt
         hGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+1diemf3MRoXdblNNavyGZGnh4l9BWi+2yg35q/w2I=;
        b=ArRp68a9gGlOgho/48SH/BVVGsBkGXQ1+JUiBYa5QK2nwpKs7Wjqex/aPpNN0GUpa3
         /FZ1A57ufzSlyfxaP/R2AhmEAJV9ECHUzWEXNHZEIPkunhZ19PKj3Mu4uJUxszWHxuvb
         d9SA74sQunyNAWZn+yH3jS2jJCqqRK53493oLGtCbZ5YCDVIfgKp7c0inmU/8Xg3lkse
         y33u3X2MwNrfEnxNIU0JQcvEj9TWGBqqfsDsqGNu1e8HVx6i2gqC4VTYMz59Mez6C4SW
         gx6XnRH0qjebg6bmAGLAZKTzWvK5EMF3WxlgYId+amVa4g25WVNnAQ6Ekq0yjzyaxN99
         RQRg==
X-Gm-Message-State: AOAM530wDIcU3V+6djWyC/pSxXGwEsGYqb7dZkOv3OSLu6h0/avKVZ6g
        Fq1TA7Llb/5+Drqzb1p7jPQ=
X-Google-Smtp-Source: ABdhPJzlC3U68DCLsbYeOcinMvhFhlX0fVCV6UVlgNQZ/JDGtbLNJFcAGBXvUWtwMqJomXO85pvLPw==
X-Received: by 2002:a92:cece:0:b0:2be:a529:d457 with SMTP id z14-20020a92cece000000b002bea529d457mr750693ilq.154.1645069732006;
        Wed, 16 Feb 2022 19:48:52 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::1b19])
        by smtp.googlemail.com with ESMTPSA id l16sm1127874ilc.54.2022.02.16.19.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:48:51 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 11/13] drm_print: prefer bare printk KERN_DEBUG on generic fn
Date:   Wed, 16 Feb 2022 20:48:27 -0700
Message-Id: <20220217034829.64395-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217034829.64395-1-jim.cromie@gmail.com>
References: <20220217034829.64395-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_print.c calls pr_debug() just once, from __drm_printfn_debug(),
which is a generic/service fn.  The callsite is compile-time enabled
by DEBUG in both DYNAMIC_DEBUG=y/n builds.

For dyndbg builds, reverting this callsite back to bare printk is
correcting a few anti-features:

1- callsite is generic, serves multiple drm users.
   its hardwired on currently
   could accidentally: #> echo -p > /proc/dynamic_debug/control

2- optional "decorations" by dyndbg are unhelpful/misleading
   they describe only the generic site, not end users

IOW, 1,2 are unhelpful at best, and possibly confusing.

reverting yields a nominal data and text shrink:

   text    data     bss     dec     hex filename
 462583   36604   54592 553779   87333 /lib/modules/5.16.0-rc4-lm1-00008-ged3eac8ceeea/kernel/drivers/gpu/drm/drm.ko
 462515   36532   54592 553639   872a7 /lib/modules/5.16.0-rc4-lm1-00009-g6ce0b88d2539-dirty/kernel/drivers/gpu/drm/drm.ko

NB: this was noticed using _drm_debug_enabled(), added earlier.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 92e6e18026da..24c57b92dc69 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -23,8 +23,6 @@
  * Rob Clark <robdclark@gmail.com>
  */
 
-#define DEBUG /* for pr_debug() */
-
 #include <linux/stdarg.h>
 
 #include <linux/io.h>
@@ -162,7 +160,8 @@ EXPORT_SYMBOL(__drm_printfn_info);
 
 void __drm_printfn_debug(struct drm_printer *p, struct va_format *vaf)
 {
-	pr_debug("%s %pV", p->prefix, vaf);
+	/* pr_debug callsite decorations are unhelpful here */
+	printk(KERN_DEBUG "%s %pV", p->prefix, vaf);
 }
 EXPORT_SYMBOL(__drm_printfn_debug);
 
-- 
2.35.1

