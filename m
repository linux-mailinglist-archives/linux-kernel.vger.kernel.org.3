Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DCB5AC71C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiIDVnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbiIDVmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:37 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E866E2E69B
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id c4so5673295iof.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SWtn3j+X9Qv4/8jm3akSHIAKz6ptgqW0K3O3Ay77qY0=;
        b=kdD+2APgzWur66T/Yw0JAUha2OIBdQGSWr5pcgqmIKcw9t0P0ExtxJ+wCGmYlifBWY
         jx4J02H6x5y7Jghzq1hjlLd3x+JlLb3u/xHIEvdFLXebvyF7FseT8Um/rfOTT8sRqkHS
         Kwn5kYLnvRsaaJvK8r60GbVBm4z23vlSxPpIWmtoTyoxwEUVg3LWqMUsG2Yi6iDLoOmG
         BEzbio/nlWqLK6FIxJogNbut2lE5Za4JjbwBPh5poTqO7XvQoIMgS1PV8gDVCvH69rhU
         ccmuPpHwqKxPNGqKrdl4oLgloCvbIqvr5bIuq/7NKCEFQ+QaUBDxXUj6ZrVzTpP227xS
         4kDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SWtn3j+X9Qv4/8jm3akSHIAKz6ptgqW0K3O3Ay77qY0=;
        b=eNnQ7Q45vMkKNtqlUNu0zj5Ht+EpAYFzB1p8Vz66h+aTPIWyRZJAJalKW2Z+DjNqpX
         q7MAoCsyuRHp39iXIB/5WKnpE3WjQArtsDUFcLNaCxDapq/6J8Dcp9c0ZtDaJCniEbLA
         jphyfpmbhEJ+VOUsTJi4/TkOapzT99LwiSnHNQjT1IYeu7x2yLXPs9bnxy4f9G8I1giK
         cAkGAuuFf4OyK7o1lh64iZmodfQKhSYuEpqROUoXJoXoBGznjM7mlym3UaXSLw7A1diJ
         QfdEawUVI6aadSwLQUCb9fhxDnXNANxHYjYBs8/FpAT7s4eLTwQsum3GOHaMU4UtYnJi
         /1Qw==
X-Gm-Message-State: ACgBeo0gmYumVD0LKrh5TcbxMGfCawQnMa47R8NsXNet+qdVn6ecT9fT
        CDBao28OLG3H/a5W+uL5pQs=
X-Google-Smtp-Source: AA6agR41XH/DfG2wtMg0P4XixHVW9m5d5cJuou6QXxyrDYjIbsET4TcIXXSM7OxtuZdeXgbZ6EA6Xg==
X-Received: by 2002:a6b:610c:0:b0:688:820d:bd14 with SMTP id v12-20020a6b610c000000b00688820dbd14mr20274946iob.205.1662327750268;
        Sun, 04 Sep 2022 14:42:30 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 21/57] dyndbg: test DECLARE_DYNDBG_CLASSMAP, sysfs nodes
Date:   Sun,  4 Sep 2022 15:40:58 -0600
Message-Id: <20220904214134.408619-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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

Demonstrate use of DECLARE_DYNDBG_CLASSMAP macro, and expose them as
sysfs-nodes for testing.

For each of the 4 class-map-types:

  - declare a class-map of that type,
  - declare the enum corresponding to those class-names
  - share _base across 0..30 range
  - add a __pr_debug_cls() call for each class-name
  - declare 2 sysnodes for each class-map
    for 'p' flag, and future 'T' flag

These declarations create the following sysfs parameter interface:

  :#> pwd
  /sys/module/test_dynamic_debug/parameters
  :#> ls
  T_disjoint_bits  T_disjoint_names  T_level_names  T_level_num  do_prints
  p_disjoint_bits  p_disjoint_names  p_level_names  p_level_num

NOTES:

The local wrapper macro is an api candidate, but there are already too
many parameters.  OTOH, maybe related enum should be in there too,
since it has _base inter-dependencies.

The T_* params control the (future) T flag on the same class'd
pr_debug callsites as their p* counterparts.  Using them will fail,
until the dyndbg-trace patches are added in.

:#> echo 1 > T_disjoint
[   28.792489] dyndbg: disjoint: 0x1 > test_dynamic_debug.T_D2
[   28.793848] dyndbg: query 0: "class D2_CORE +T" mod:*
[   28.795086] dyndbg: split into words: "class" "D2_CORE" "+T"
[   28.796467] dyndbg: op='+'
[   28.797148] dyndbg: unknown flag 'T'
[   28.798021] dyndbg: flags parse failed
[   28.798947] dyndbg: processed 1 queries, with 0 matches, 1 errs
[   28.800378] dyndbg: bit_0: -22 matches on class: D2_CORE -> 0x1
[   28.801959] dyndbg: test_dynamic_debug.T_D2: updated 0x0 -> 0x1
[   28.803974] dyndbg: total matches: -22

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 125 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 110 insertions(+), 15 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index ba3882ca3e48..8dd250ad022b 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -10,57 +10,152 @@
 
 #include <linux/module.h>
 
-static void do_prints(void); /* device under test */
-
-/* run tests by reading or writing sysfs node */
+/* run tests by reading or writing sysfs node: do_prints */
 
+static void do_prints(void); /* device under test */
 static int param_set_do_prints(const char *instr, const struct kernel_param *kp)
 {
 	do_prints();
 	return 0;
 }
-
 static int param_get_do_prints(char *buffer, const struct kernel_param *kp)
 {
 	do_prints();
 	return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
 }
-
 static const struct kernel_param_ops param_ops_do_prints = {
 	.set = param_set_do_prints,
 	.get = param_get_do_prints,
 };
-
 module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
 
-static void do_alpha(void)
+/*
+ * Using the CLASSMAP api:
+ * - classmaps must have corresponding enum
+ * - enum symbols must match/correlate with class-name strings in the map.
+ * - base must equal enum's 1st value
+ * - multiple maps must set their base to share the 0-30 class_id space !!
+ *   (build-bug-on tips welcome)
+ * Additionally, here:
+ * - tie together sysname, mapname, bitsname, flagsname
+ */
+#define DD_SYS_WRAP(_model, _flags)					\
+	static unsigned long bits_##_model;				\
+	static struct ddebug_class_param _flags##_model = {		\
+		.bits = &bits_##_model,					\
+		.flags = #_flags,					\
+		.map = &map_##_model,					\
+	};								\
+	module_param_cb(_flags##_##_model, &param_ops_dyndbg_classes, &_flags##_model, 0600)
+
+/* numeric input, independent bits */
+enum cat_disjoint_bits {
+	D2_CORE = 0,
+	D2_DRIVER,
+	D2_KMS,
+	D2_PRIME,
+	D2_ATOMIC,
+	D2_VBL,
+	D2_STATE,
+	D2_LEASE,
+	D2_DP,
+	D2_DRMRES };
+DECLARE_DYNDBG_CLASSMAP(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+			"D2_CORE",
+			"D2_DRIVER",
+			"D2_KMS",
+			"D2_PRIME",
+			"D2_ATOMIC",
+			"D2_VBL",
+			"D2_STATE",
+			"D2_LEASE",
+			"D2_DP",
+			"D2_DRMRES");
+DD_SYS_WRAP(disjoint_bits, p);
+DD_SYS_WRAP(disjoint_bits, T);
+
+/* symbolic input, independent bits */
+enum cat_disjoint_names { LOW = 11, MID, HI };
+DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
+			"LOW", "MID", "HI");
+DD_SYS_WRAP(disjoint_names, p);
+DD_SYS_WRAP(disjoint_names, T);
+
+/* numeric verbosity, V2 > V1 related */
+enum cat_level_num { V0 = 14, V1, V2, V3, V4, V5, V6, V7 };
+DECLARE_DYNDBG_CLASSMAP(map_level_num, DD_CLASS_TYPE_LEVEL_NUM, 14,
+		       "V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7");
+DD_SYS_WRAP(level_num, p);
+DD_SYS_WRAP(level_num, T);
+
+/* symbolic verbosity */
+enum cat_level_names { L0 = 22, L1, L2, L3, L4, L5, L6, L7 };
+DECLARE_DYNDBG_CLASSMAP(map_level_names, DD_CLASS_TYPE_LEVEL_NAMES, 22,
+			"L0", "L1", "L2", "L3", "L4", "L5", "L6", "L7");
+DD_SYS_WRAP(level_names, p);
+DD_SYS_WRAP(level_names, T);
+
+/* stand-in for all pr_debug etc */
+#define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
+
+static void do_cats(void)
 {
-	pr_debug("do alpha\n");
+	pr_debug("doing categories\n");
+
+	prdbg(LOW);
+	prdbg(MID);
+	prdbg(HI);
+
+	prdbg(D2_CORE);
+	prdbg(D2_DRIVER);
+	prdbg(D2_KMS);
+	prdbg(D2_PRIME);
+	prdbg(D2_ATOMIC);
+	prdbg(D2_VBL);
+	prdbg(D2_STATE);
+	prdbg(D2_LEASE);
+	prdbg(D2_DP);
+	prdbg(D2_DRMRES);
 }
-static void do_beta(void)
+
+static void do_levels(void)
 {
-	pr_debug("do beta\n");
+	pr_debug("doing levels\n");
+
+	prdbg(V1);
+	prdbg(V2);
+	prdbg(V3);
+	prdbg(V4);
+	prdbg(V5);
+	prdbg(V6);
+	prdbg(V7);
+
+	prdbg(L1);
+	prdbg(L2);
+	prdbg(L3);
+	prdbg(L4);
+	prdbg(L5);
+	prdbg(L6);
+	prdbg(L7);
 }
 
 static void do_prints(void)
 {
-	do_alpha();
-	do_beta();
+	do_cats();
+	do_levels();
 }
 
 static int __init test_dynamic_debug_init(void)
 {
 	pr_debug("init start\n");
-
 	do_prints();
-
 	pr_debug("init done\n");
 	return 0;
 }
 
 static void __exit test_dynamic_debug_exit(void)
 {
-	pr_debug("exiting\n");
+	pr_debug("exited\n");
 }
 
 module_init(test_dynamic_debug_init);
-- 
2.37.2

