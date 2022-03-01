Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0084C90C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbiCAQsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiCAQrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:47:41 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351448306
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:46:58 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id i1so13002813ila.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+1diemf3MRoXdblNNavyGZGnh4l9BWi+2yg35q/w2I=;
        b=fZzouo8Gq4lZgktfrleVNOZJgE7AAveGDRPW5fk+Y2hAGgIwA66+3FomMB4cLs+w8V
         U9QyWzk7IircTiOz7sIgxqqwq2uB86JSHs84Roy4ZE/xcD1rg1/K2jxn3QMud3EINs8G
         MvxPZvP7qy+PBCo/7GB4xNa675NiFtSeu3al+TEiaV8Ol9KByxYskONt9Gl74piL2sPe
         tls31NghJiSek1de4mUm7xgKA3JzEBz5F3BY4KLbfokTiBbfeKZFZboEdGanaPPY6nO0
         dRV5SIb/uMqg2+3TfKK3olU3HlO/5b+PnLjiDlw99GeQywftdZxM6zxD9Zg0FqSViFyu
         Z1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+1diemf3MRoXdblNNavyGZGnh4l9BWi+2yg35q/w2I=;
        b=sVW+oiW3xYfJ88X/QN9y943DQ6P99t2F+345mYDX9xDOh6X+76qxkgDcJ+qKhIl+vh
         izm8MiToTCzUipLvdhudNqTOCjaLTtMmMfZ0n50v7Zx4XLvcLLtOOmuBdNrOpHLAPtFa
         JxBFeVui7uQxr3lKMZWBCdCAWJcBhMQVSm5GKP/KI242nzyBbbKGGyeHhcMlKy3LJ9LR
         nSdNWBvVDQtAA0/sRPP8PnSLHEs4UmZrG/HqIw1m0yttSG8XlzispozKnDBvDrwxIsW3
         9s/uK73OzbzpiYZY6p2nmw9W7GoOtRCgWz9HwvxjCPisifFuQ+X30Z1J4pMEd/NYJHMr
         KEig==
X-Gm-Message-State: AOAM530wtwKhRUAoWFncmUURQQgGiwI2+o0cfGv6SpRtXQeWHsbZ4LjJ
        PUmhT23k5z9Ah4sDH3ybcB4=
X-Google-Smtp-Source: ABdhPJwf7VxPkYrrRG/vET57AY/ByM1ZpdNgjy505b5OX+6OmR5WWqWAqy/trwzf4yd2fyO7wN3M4A==
X-Received: by 2002:a92:b009:0:b0:2c2:c409:1252 with SMTP id x9-20020a92b009000000b002c2c4091252mr15603632ilh.8.1646153218282;
        Tue, 01 Mar 2022 08:46:58 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id o3-20020a6b5a03000000b00640a33c5b0dsm7272411iob.17.2022.03.01.08.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 08:46:58 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 11/13] drm_print: prefer bare printk KERN_DEBUG on generic fn
Date:   Tue,  1 Mar 2022 09:46:27 -0700
Message-Id: <20220301164629.3814634-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301164629.3814634-1-jim.cromie@gmail.com>
References: <20220301164629.3814634-1-jim.cromie@gmail.com>
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

