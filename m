Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7CE4BD673
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345710AbiBUGzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:55:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbiBUGzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:55:03 -0500
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C9AE14
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 22:54:39 -0800 (PST)
X-QQ-mid: bizesmtp65t1645426468t8ck3ryh
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 21 Feb 2022 14:54:22 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000000A0000000
X-QQ-FEAT: Y/4E1fKPEOoHnnNVc6AB9rh2DW/GRe7QnuF/5RjEkyjLmBpOyu7pxCD+MgaYi
        edrAtbETZd5L0Qq2Gjwbi0RuPROK0agkqZzt5Pp1YvKB8//rYoEzvriBtAHlRO45nSk7G90
        kH4A2AWEiDU1OQshBVQHQL79KYpQMb+Ly4T7IxJGcNkGJCzht/36xS4IpixCpzPotOGNVkR
        4vI0ryjjzuD1gVuvh93fahVS497MDBslCX/K6UCuv6sorJeFMVOb2vfNsG0FaDCs6IEf77m
        q8lIdumnsG+0DOSy7qkTCRuC4z4ybtewhec/EF7mGy4kiwmz0W8QCYLG9RrZ2u06eK38Eab
        MGoj5OcAD8rcA49FON/4FY15NHN+8OcsXUonupheNvw4jSLvFc=
X-QQ-GoodBg: 1
From:   tangmeng <tangmeng@uniontech.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] mm/kasan: remove unnecessary CONFIG_KASAN option
Date:   Mon, 21 Feb 2022 14:54:21 +0800
Message-Id: <20220221065421.20689-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mm/Makefile has:
obj-$(CONFIG_KASAN)     += kasan/

So that we don't need 'obj-$(CONFIG_KASAN) :=' in mm/kasan/Makefile,
delete it from mm/kasan/Makefile.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 mm/kasan/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index adcd9acaef61..1f84df9c302e 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -35,7 +35,7 @@ CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 
-obj-$(CONFIG_KASAN) := common.o report.o
+obj-y := common.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
 obj-$(CONFIG_KASAN_HW_TAGS) += hw_tags.o report_hw_tags.o tags.o report_tags.o
 obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o tags.o report_tags.o
-- 
2.20.1



