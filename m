Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9E58B1EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiHEV5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241824AbiHEVzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:55:45 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868751181A;
        Fri,  5 Aug 2022 14:54:58 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s16so1983877ilp.3;
        Fri, 05 Aug 2022 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mTUAniGKH6fmmV5gDTiJdss5/weYhXTwv9+PDNZ3RQI=;
        b=S/33lfMSw5q9gypQJIkplRl00GGe67RJ9xa8zCdLhQ0f51/eF5ILkTJXz1xEcGCCKP
         PFby/Cmf3NBTYgJW6LVwYyZSfP0X/1AWFtllsC4tOCudOX0JQXM3v4JpTNrpNEqj6Ne9
         ZeJB0MOUrFC0g5i1hoCbjWgNSHy2m/2h0orKLnqjj6pNxpNFTfcLTT9pdZS/yrAd0W9b
         ZZWZsPjMmNeJkCrdNY/6LSYtmvqbaiBL/3ahA0IkoMu/5gMtxJcBU6ErfuAs/zNFAy51
         GMzU+fGiKPfwpmqz83c4rsCzNcBinBpkwZo0L40634trC5TvFwS/ds9XGXobW185p2h0
         6FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mTUAniGKH6fmmV5gDTiJdss5/weYhXTwv9+PDNZ3RQI=;
        b=c1Bbm/sqJC5wCzQShT+ACBOz/W5JXKTUQ4EDg7JtmZD/dTe96JdKkR4MjQW41zY+xk
         P1Dii29YlucV5TC4GMdRyGzzM7zRPORkpbLR50kYl7LVggSBdrWX4FwvKgw8xOyl0fZ6
         FfsQ0208/owiVjyBHzxGLyiLx1207XhIHKXntCMkbSiw2QStui/ubCNo0hyCp31FROWn
         DCGuj2I2owaC+gHZtvAFr3JRU2DaLXMbeGz+T0QE8qSSKw2PgH/40TRhgmKel6tVTl1E
         vfL6Bzt7ra6g/I/IVb5iEquLo4y+vMju2MhvHXghNwt20hVgy45p0weLyRgn2SSsrU+H
         y59Q==
X-Gm-Message-State: ACgBeo0Z8VDXQIrz9FOB492/mXGuuVTDakMDhBxA9Me+XzHCgUujBRNY
        7d/BfiRXLuR+HBbZVeU76X2+8ETSL/hwRQ==
X-Google-Smtp-Source: AA6agR7p8aLV4AMCuCW7/ITwvchFsSHG706nUxBbukte1XKyqNILQgaJYQtx7T13yN+8siYTRtw0iQ==
X-Received: by 2002:a05:6e02:1a65:b0:2de:fbaf:ada7 with SMTP id w5-20020a056e021a6500b002defbafada7mr3969694ilv.180.1659736497241;
        Fri, 05 Aug 2022 14:54:57 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:56 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 33/33] nouveau: WIP add 2 LEVEL_NUM classmaps for CLI, SUBDEV
Date:   Fri,  5 Aug 2022 15:53:55 -0600
Message-Id: <20220805215355.3509287-34-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
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

clone the nvkm_printk,_,__ macro ladder into nvkm_drmdbg,_,__.
And alter the debug, trace, spam macros to use the renamed ladder.

This *sets-up* (not done yet) to remove the _subdev->debug >= (l)
condition, once the bitmap-param is wired up correctly, and figured
into dyndbg's jump-label enablement.  WIP.

Then undo the 1-line change that reduced count of prdbgs from 632 to 119.

ie: s/NV_SUBDEV_DBG_##l/NV_DBG_##l/

So heres what happened: new symbol is 15 (or 10), and fails this macro
test, so gets compiled out, and the dev_dbg is excluded.

        if (CONFIG_NOUVEAU_DEBUG >= (l) && _subdev->debug >= (l))       \
                dev_dbg(_subdev->device->dev, "%s: "f, _subdev->name, ##a); \

I could hack this, by doing (l + base), but base is pretty distant.

OTOH, the whole CONFIG_NOUVEAU_DEBUG check could be reworked; given
that trace is minumum recommended, theres not that many callsites
elided (SPAM only iirc) at compile-time, and dyndbg means keeping them
has "zero" run-cost (and 56 bytes per callsite).  So this config item
doesnt do much when DRM_USE_DYNAMIC_DEBUG=y.

So this is a useful place to stop and look around, try to guess which
trail to take..

nouveau has additional debug variables to consider:

drivers/gpu/drm/nouveau/include/nvkm/core/device.h
131:	if (_device->debug >= (l))                                             \

drivers/gpu/drm/nouveau/include/nvkm/core/client.h
39:	if (_client->debug >= NV_DBG_##l)                                      \

drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
54:	if (CONFIG_NOUVEAU_DEBUG >= (l) && _subdev->debug >= (l))              \

This is another baby-step, that seems not to break, so lets get a
snapshot.

whats done here:

In nouveau_drm.c, do DECLARE_DYNDBG_CLASSMAP(LEVEL_NUM type) 2x more,
for cli and subdev, right after the drm DECLARE.  Adjust base for
each, to share the 0..30 classid-space.

These declare class-names: NV_CLI_DBG_* NV_SUBDEV_DBG_* accordingly.
Note: class-name-space is flat and wide, so super-generic names like
INFO should be prefixed; who could predict what a generic V3 does
across all modules.

s should be included

adjusting the base to avoid each other, and the 0-10
already mapped to drm-debug-categorys (just above this addition).

In nvkm/core/debug.h, add enums to match the names, with initial
values to match the bases.

In nvkm/core/subdev.h, alter (recently added) nvkm_drmdbg_() to use
NV_SUBDEV_DBG_* instead of NV_DBG_*.

NB: in both classmaps, Ive left FATAL..WARN out, they're not really
optional the way INFO..SPAM are; dyndbg shouldn't be able to turn them off.

bash-5.1# modprobe nouveau
[  966.107833] dyndbg:   3 debug prints in module wmi
[  966.342188] dyndbg: class[0]: module:nouveau base:15 len:5 ty:1
[  966.342873] dyndbg:  15: 0 NV_SUBDEV_DBG_OFF
[  966.343352] dyndbg:  16: 1 NV_SUBDEV_DBG_INFO
[  966.343912] dyndbg:  17: 2 NV_SUBDEV_DBG_DEBUG
[  966.344443] dyndbg:  18: 3 NV_SUBDEV_DBG_TRACE
[  966.344938] dyndbg:  19: 4 NV_SUBDEV_DBG_SPAM
[  966.345402] dyndbg: class[1]: module:nouveau base:10 len:5 ty:1
[  966.346011] dyndbg:  10: 0 NV_CLI_DBG_OFF
[  966.346477] dyndbg:  11: 1 NV_CLI_DBG_INFO
[  966.346989] dyndbg:  12: 2 NV_CLI_DBG_DEBUG
[  966.347442] dyndbg:  13: 3 NV_CLI_DBG_TRACE
[  966.347875] dyndbg:  14: 4 NV_CLI_DBG_SPAM
[  966.348284] dyndbg: class[2]: module:nouveau base:0 len:10 ty:0
[  966.348888] dyndbg:  0: 0 DRM_UT_CORE
[  966.349310] dyndbg:  1: 1 DRM_UT_DRIVER
[  966.349694] dyndbg:  2: 2 DRM_UT_KMS
[  966.350083] dyndbg:  3: 3 DRM_UT_PRIME
[  966.350482] dyndbg:  4: 4 DRM_UT_ATOMIC
[  966.351016] dyndbg:  5: 5 DRM_UT_VBL
[  966.351475] dyndbg:  6: 6 DRM_UT_STATE
[  966.351899] dyndbg:  7: 7 DRM_UT_LEASE
[  966.352309] dyndbg:  8: 8 DRM_UT_DP
[  966.352678] dyndbg:  9: 9 DRM_UT_DRMRES
[  966.353104] dyndbg: module:nouveau attached 3 classes
[  966.353759] dyndbg: 119 debug prints in module nouveau

NOTE: it was 632 with previous commit, switching NV_DEBUG to use
NV_SUBDEV_DBG_DEBUG instead of NV_DBG_DEBUG may be the cause.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../gpu/drm/nouveau/include/nvkm/core/debug.h | 16 +++++++++++++
 .../drm/nouveau/include/nvkm/core/subdev.h    | 17 ++++++++++----
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  7 ++++++
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c    | 23 +++++++++++++++++++
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/debug.h b/drivers/gpu/drm/nouveau/include/nvkm/core/debug.h
index b4a9c7d991ca..6a155a23a3d1 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/debug.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/debug.h
@@ -9,4 +9,20 @@
 #define NV_DBG_TRACE    5
 #define NV_DBG_PARANOIA 6
 #define NV_DBG_SPAM     7
+
+enum nv_cli_dbg_verbose {
+	NV_CLI_DBG_OFF = 10,
+	NV_CLI_DBG_INFO,
+	NV_CLI_DBG_DEBUG,
+	NV_CLI_DBG_TRACE,
+	NV_CLI_DBG_SPAM
+};
+enum nv_subdev_dbg_verbose {
+	NV_SUBDEV_DBG_OFF = 15,
+	NV_SUBDEV_DBG_INFO,
+	NV_SUBDEV_DBG_DEBUG,
+	NV_SUBDEV_DBG_TRACE,
+	NV_SUBDEV_DBG_SPAM
+};
+
 #endif
diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
index 065d07ccea87..ce33c82e5c75 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
@@ -2,6 +2,7 @@
 #ifndef __NVKM_SUBDEV_H__
 #define __NVKM_SUBDEV_H__
 #include <core/device.h>
+#include <core/debug.h>
 
 enum nvkm_subdev_type {
 #define NVKM_LAYOUT_ONCE(t,s,p,...) t,
@@ -18,7 +19,7 @@ struct nvkm_subdev {
 	enum nvkm_subdev_type type;
 	int inst;
 	char name[16];
-	u32 debug;
+	unsigned long debug;
 	struct list_head head;
 
 	void **pself;
@@ -59,9 +60,17 @@ void nvkm_subdev_intr(struct nvkm_subdev *);
 #define nvkm_error(s,f,a...) nvkm_printk((s), ERROR,    err, f, ##a)
 #define nvkm_warn(s,f,a...)  nvkm_printk((s),  WARN, notice, f, ##a)
 #define nvkm_info(s,f,a...)  nvkm_printk((s),  INFO,   info, f, ##a)
-#define nvkm_debug(s,f,a...) nvkm_printk((s), DEBUG,    dbg, f, ##a)
-#define nvkm_trace(s,f,a...) nvkm_printk((s), TRACE,    dbg, f, ##a)
-#define nvkm_spam(s,f,a...)  nvkm_printk((s),  SPAM,    dbg, f, ##a)
+
+#define nvkm_drmdbg__(s,l,p,f,a...) do {				\
+	const struct nvkm_subdev *_subdev = (s);			\
+	if (CONFIG_NOUVEAU_DEBUG >= (l) && _subdev->debug >= (l))	\
+		dev_dbg(_subdev->device->dev, "%s: "f, _subdev->name, ##a); \
+} while(0)
+#define nvkm_drmdbg_(s,l,f,a...) nvkm_drmdbg__((s), NV_SUBDEV_DBG_##l, dbg, f, ##a)
+#define nvkm_debug(s,f,a...) nvkm_drmdbg_((s), DEBUG, f, ##a)
+#define nvkm_trace(s,f,a...) nvkm_drmdbg_((s), TRACE, f, ##a)
+#define nvkm_spam(s,f,a...)  nvkm_drmdbg_((s),  SPAM, f, ##a)
 
 #define nvkm_error_ratelimited(s,f,a...) nvkm_printk((s), ERROR, err_ratelimited, f, ##a)
+
 #endif
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index fd99ec0f4257..864750451dc8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -83,6 +83,13 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_DP",
 			"DRM_UT_DRMRES");
 
+DECLARE_DYNDBG_CLASSMAP(nv_cli_debug_verbose, DD_CLASS_TYPE_LEVEL_NUM, 10,
+			"NV_CLI_DBG_OFF",
+			"NV_CLI_DBG_INFO",
+			"NV_CLI_DBG_DEBUG",
+			"NV_CLI_DBG_TRACE",
+			"NV_CLI_DBG_SPAM");
+
 MODULE_PARM_DESC(config, "option string to pass to driver core");
 static char *nouveau_config;
 module_param_named(config, nouveau_config, charp, 0400);
diff --git a/drivers/gpu/drm/nouveau/nvkm/core/subdev.c b/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
index a74b7acb6832..20cd99cce2a4 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
@@ -26,6 +26,27 @@
 #include <core/option.h>
 #include <subdev/mc.h>
 
+#include <linux/dynamic_debug.h>
+#include <linux/module.h>
+
+#define DEBUG
+
+DECLARE_DYNDBG_CLASSMAP(nv_subdev_debug_verbose, DD_CLASS_TYPE_LEVEL_NAMES, 15,
+			"NV_SUBDEV_DBG_OFF",
+			"NV_SUBDEV_DBG_INFO",
+			"NV_SUBDEV_DBG_DEBUG",
+			"NV_SUBDEV_DBG_TRACE",
+			"NV_SUBDEV_DBG_SPAM");
+
+static struct ddebug_class_param nv_subdev_verbose = {
+	.bits = NULL, // wants &_subdev->debug
+	.flags = "p",
+	.map = &nv_subdev_debug_verbose,
+};
+module_param_cb(debug_subdev, &param_ops_dyndbg_classes, &nv_subdev_verbose, 0600);
+
+
+
 const char *
 nvkm_subdev_type[NVKM_SUBDEV_NR] = {
 #define NVKM_LAYOUT_ONCE(type,data,ptr,...) [type] = #ptr,
@@ -180,6 +201,8 @@ nvkm_subdev_ctor(const struct nvkm_subdev_func *func, struct nvkm_device *device
 	else
 		strscpy(subdev->name, nvkm_subdev_type[type], sizeof(subdev->name));
 	subdev->debug = nvkm_dbgopt(device->dbgopt, subdev->name);
+	nv_subdev_verbose.bits = &subdev->debug;
+	pr_debug("updated bitmap: %px\n", &nv_subdev_verbose.bits);
 	list_add_tail(&subdev->head, &device->subdev);
 }
 
-- 
2.37.1

