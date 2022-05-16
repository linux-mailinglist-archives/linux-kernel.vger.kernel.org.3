Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA14529483
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350124AbiEPW7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349960AbiEPW5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:35 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246B94615E;
        Mon, 16 May 2022 15:57:35 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s14so11544342ild.6;
        Mon, 16 May 2022 15:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FF9XER8KsVOkO1Gdata3KepQ+J2Lr+NLtjqQThof0Pg=;
        b=QMR7Uv7IGU4dFlQ7XbaLDl8oMTWWGZP8W/kIowrn4M8i2Lw1cKjWfBvIQCyDVsk3K5
         6AUg94ocYqw6aOmdD+JMQJ8X8DPX2rZPU8YSfJbHND7oPm24AfMTT84oH1as3SXEIGb3
         523GC2519SINNOFvGjkI78C+OqFZ8wGoaY9rRVexPvZ8T2hd4jVASyMWJYI9P2/sy21C
         gn6Vwf/lc7O+I2XuHib/dpWz5vH/EfXuoTmNQ+ehHsY1xKFoU1Wo6jL0eSWRiPN4w53C
         15ayP/Cr96VmOumROCuOJoWl2HJ0wDKVYoimLCzzofh4L7znSGAuuSODf1ChhXsHSlpz
         6JdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FF9XER8KsVOkO1Gdata3KepQ+J2Lr+NLtjqQThof0Pg=;
        b=iN5Sp8pHGIwmP9jZhJHcTfdnrDjJqpC1iuiMuUEQY21P/8FsvRR9lKQxHaX584d0Z9
         OWhp5vXewoN48xgrJkBejStWhxMqD7W1Q4Fb+4yA65jSrAOnc17udi8pY/ZXckP2qB8o
         sNWBrS43+Od5AA5sOl6dNoR1YXqRytQuEzf3GBHW1l6SmKlRcquQ1wRoQCUP388eVWn7
         t8b71tTc3jThSnSHx4W5b12+4JP+A+aNEZuQCWW06/PKUF9zFKI/CX1Zfm2uFLXqt+Bi
         vzDVA6GUooneD6jiyj9TY+I/lsBICgzWDf3nT+Bxlk/OUpXIz4G0/9Lu0g69r2EVnBFH
         WvhQ==
X-Gm-Message-State: AOAM533Kd1u7QXOFiyN4cyXenCsqPWMZA+ptGAsFT0rcsDzFeM/UAHR1
        qc6zmcoVPCgxZAMwY1Fkd2k=
X-Google-Smtp-Source: ABdhPJxS9t9CHQ1y5o2+/sKdUJFOmRXlBo10ke52iiCLaoO7cYr11kQ2d2iMU5f/GP5Uh8uwZxF29g==
X-Received: by 2002:a05:6e02:1d1d:b0:2d1:1250:437a with SMTP id i29-20020a056e021d1d00b002d11250437amr5815025ila.35.1652741854834;
        Mon, 16 May 2022 15:57:34 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:34 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, quic_saipraka@quicinc.com,
        will@kernel.org, catalin.marinas@arm.com,
        quic_psodagud@quicinc.com, maz@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v2 27/27] dyndbg/drm: POC add tracebits sysfs-knob
Date:   Mon, 16 May 2022 16:56:40 -0600
Message-Id: <20220516225640.3102269-28-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220516225640.3102269-1-jim.cromie@gmail.com>
References: <20220516225640.3102269-1-jim.cromie@gmail.com>
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

clone DRM.debug interface to DRM.tracebits: ie map bits to
drm-debug-categories, except this interface enables messages to
tracefs, not to syslog.

This reuses dyndbg's register-classes API to add the new sysfs-knob:

drm_drv.h:

[A] 2nd use of DYNAMIC_DEBUG_CLASSES(drm_trace_classes), which
declares and initializes a known-classes map with the same literal
classnames as in the 1st use.  This "shares" the classnames for both
sysfs-knobs, which is necessary because they're manipulating a shared
dyndbg callsite, toggling "p" and "T" flags respectively.

This incurs a tiny waste of constant strings, but its worth it for the
simpler declarative macro.

drm_print.c:

1- declare and export a 2nd bit-vector: __drm_trace, like __drm_debug

2- declare and init a struct ddebug_classes_bitmap_param with:
   __drm_trace [1], drm_trace_classes [A].

3- module_param_cb([2]) - does the sysfs part

drm_drv.c:

register and unregister [A], and missed unregister on drm_debug_classes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_drv.c   |  3 +++
 drivers/gpu/drm/drm_print.c | 10 ++++++++++
 include/drm/drm_drv.h       | 14 +++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 16683fb169aa..ad141c5e29ca 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1039,6 +1039,8 @@ static void drm_core_exit(void)
 	drm_sysfs_destroy();
 	idr_destroy(&drm_minors_idr);
 	drm_connector_ida_destroy();
+	dynamic_debug_unregister_classes(&drm_debug_classes);
+	dynamic_debug_unregister_classes(&drm_trace_classes);
 }
 
 static int __init drm_core_init(void)
@@ -1046,6 +1048,7 @@ static int __init drm_core_init(void)
 	int ret;
 
 	dynamic_debug_register_classes(&drm_debug_classes);
+	dynamic_debug_register_classes(&drm_trace_classes);
 
 	drm_connector_ida_init();
 	idr_init(&drm_minors_idr);
diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 9afb676bda4d..970b6dd46c42 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -44,6 +44,9 @@
 unsigned long __drm_debug;
 EXPORT_SYMBOL(__drm_debug);
 
+unsigned long __drm_trace;
+EXPORT_SYMBOL(__drm_trace);
+
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
 "\t\tBit 0 (0x01)  will enable CORE messages (drm core code)\n"
 "\t\tBit 1 (0x02)  will enable DRIVER messages (drm controller code)\n"
@@ -63,6 +66,13 @@ static struct ddebug_classes_bitmap_param drm_debug_bitmap = {
 	.map = &drm_debug_classes,
 };
 module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
+
+static struct ddebug_classes_bitmap_param drm_trace_bitmap = {
+	.bits = &__drm_trace,
+	.flags = "T",
+	.map = &drm_trace_classes,
+};
+module_param_cb(tracecats, &param_ops_dyndbg_classes, &drm_trace_bitmap, 0600);
 #endif
 
 void __drm_puts_coredump(struct drm_printer *p, const char *str)
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index c2ffe12161b8..596de0addfd5 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -45,7 +45,19 @@ struct drm_printer;
 struct sg_table;
 
 /* these must comport with enum drm_debug_category values */
-DYNAMIC_DEBUG_CLASSES(drm_debug_classes, "*", 0,
+DYNAMIC_DEBUG_CLASSES(drm_debug_classes, 0,
+		      "DRM_UT_CORE",
+		      "DRM_UT_DRIVER",
+		      "DRM_UT_KMS",
+		      "DRM_UT_PRIME",
+		      "DRM_UT_ATOMIC",
+		      "DRM_UT_VBL",
+		      "DRM_UT_STATE",
+		      "DRM_UT_LEASE",
+		      "DRM_UT_DP",
+		      "DRM_UT_DRMRES");
+
+DYNAMIC_DEBUG_CLASSES(drm_trace_classes, 0,
 		      "DRM_UT_CORE",
 		      "DRM_UT_DRIVER",
 		      "DRM_UT_KMS",
-- 
2.35.3

