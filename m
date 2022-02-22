Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2D4BF761
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiBVLlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiBVLlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:41:31 -0500
Received: from out203-205-251-73.mail.qq.com (out203-205-251-73.mail.qq.com [203.205.251.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E12136EFC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645530063;
        bh=699eMzBA/qyobrvCuYrfTZQ0V28mV755xfbax2dpsmg=;
        h=From:To:Cc:Subject:Date;
        b=PtpOlma8LoDZw0wyTeq9JOrrneAZ7R+FHE4nKfBbJatDh6VEz2u05izKLKOXsdDdo
         s2YsHkWL6TERSHrx/6KVVaXyv2GAV6ECodzKytkivXUhuJjdCMTuXmqXVcfcisn3gl
         JUtsJiLy3Q1gLpP41T9dSdv+j5ZKSw6T4ZgXKq8c=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id A3BA16B2; Tue, 22 Feb 2022 19:40:59 +0800
X-QQ-mid: xmsmtpt1645530059tml951xhj
Message-ID: <tencent_7E4716854F78B812C4FF16C83573486E1806@qq.com>
X-QQ-XMAILINFO: NqN/wpVFVRYX9w3UoN3kG1OGR3IqIo7RMgu5GU/ntuck/574TWNUhjq96ugm1Y
         5L6KId2msDcc/H2U/ZAuaF50TNsGkr7fjSKvBSNOGlwxOPfN1Bmjosl806djxmlX3Hze+xoUWFW6
         dLiFW5OK2t7YH1j9bVqIDhvOdrWp6s4w4KxDSuaYYzeDHwo9WMmM1kEZ9iPc5LflLt9Suqwt5xFM
         60yQnTtkINfVDgu1ryYvxmSPONSh+a51U4m+ZgeXoBFPA6AvZ3dXZq4fW2DtObvn0W2YtkwjdXqu
         Ku6Cq+cUKF3W9Afa0UqfEmWivSAzVMasAOeZnSqyagv5InYx2wx7F8I+nvWbxRMocgOooUA8q9Oz
         GE1rZXEgMS+HbC57eZkAMANrhfWxZb2vZi0I8F8FLa94ZJCYtWurACvMl+mpjoGkwugdV6U2n1mv
         Hq+Q2Zm9c4QMj2d66nBfTX+7EMasRqui9e+ReRyJ/ZEdVeY/qBp1lsD0s8Y3WEQviGJKGwvStb4q
         KVvyMtm7tZXabMXSyXBMfEpsC3pcDzxSvcBXef4okGezeacwKEPK2drnfSzB1GtW6v38hrqKiBOS
         rzgTZLCMLfE+WWlPuPtGRDpy2pd0z386jSP/Cqi85V2Y6vzAhcjuwMyhlYuygIClzkR+2w567jAX
         xM7gD4ubadA+Av7PYJKWTozPVo46zSdXCt/ffXVKgUa0iGP1GYY8dgfl9ZnuB0J/G8a6OXsSjM+j
         AI9IDmlw40zc7YSlGD1PzduhBr2MAZtSuZqvu8V+H5J/6b2Q/dFO89eXs0d3/hDD753C2KeBVvHH
         YI+OpRKw3/QQkLBqYrcnh6LvydG4jbDOeGqRA+ZAWQZEZa7NipGdOIyd56lgROTtDktaoEdzk5fh
         1tedJh/4Hk6rWLQdtW0jP+YLTzQE+ZNFL+clwK4zSZgkyoHGUBYf4oJxHqmOIz2Q==
From:   xkernel.wang@foxmail.com
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] drm/i915/selftests: check the return value of kstrdup()
Date:   Tue, 22 Feb 2022 19:40:28 +0800
X-OQ-MSGID: <20220222114028.3947-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kstrdup() is a memory allocation function which can return NULL when
some internaly memory errors happen. It is better to check the return
value of it to prevent further wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/gpu/drm/i915/selftests/i915_selftest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index 484759c..1bcd065 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -246,6 +246,9 @@ static bool apply_subtest_filter(const char *caller, const char *name)
 	bool result = true;
 
 	filter = kstrdup(i915_selftest.filter, GFP_KERNEL);
+	if (!filter)
+		return false;
+
 	for (sep = filter; (tok = strsep(&sep, ","));) {
 		bool allow = true;
 		char *sl;
-- 
