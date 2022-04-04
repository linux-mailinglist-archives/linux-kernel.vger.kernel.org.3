Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFD94F1EDF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382737AbiDDWKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381078AbiDDVWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:22:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7680E1AF27
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:20:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b6-20020a5b0b46000000b0063dcbfa6dd3so3203152ybr.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DBbP7cPmiHpe5TN1/LJtSaqk7J0plWu8gjlZ5CS5rhk=;
        b=TZ0NkmLInAy4kYp/+n01zKn7zzlAQwYbOYU6jY1KwnR3G5n4mVA4WMp89xHymMNtfP
         0tsioSzKKpVGh67W/c1oyCZw3dCUqaR2fQfw96LIJgjhSjM95BmdvEizNAM9WtPEkVRr
         DtPgeu6pBu0zAl/vnsNkAlAedpxW1AbHCIIlZNKZ5PhYuY4Jiq195R0OGaA2XuKtrUMO
         qnziyHF0S9GwK33CJbi7GF24qNjf1bt3oMgloRa3IvwBBBe70DLX2iqKTlCePVN/MzQT
         72VosHjFPeonT+rgF2nwR4hz9j+vV4BAGXKPlqp54r6c2l1MfTmTcFNXu2qmhZxWkFUO
         UFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DBbP7cPmiHpe5TN1/LJtSaqk7J0plWu8gjlZ5CS5rhk=;
        b=Yj+WgCAk36jtgyOiiW5Jyxz7D0hvA2r4dXuEghq04VZ437PdxGEh5NsdXto6lTn3h2
         QhZXunxXFZUlEaFlwt6v1FdHuNApzI0SF4krqaZgx39NMBgNaMAU04GI4pQ6q2tBJNlg
         grCsSZlXgGPpqojYZ87v9cxTdp2OMEH6AQ4fVO2yr0vJ6wcrFyNrpqGpdpgPdUz1yAV+
         kprOuTlGVYz8Lm3A+22ruY+o2C4Lr81e8w1VNCb4Gn/+TFbCs07vnrOhcAmYszLEK8Sp
         vWXdF8apoRFvV94lJDPytMZMRqFQK3CML69oPqnuv8fefL6fuoFw5V+Nf9tCFRWZ+EfK
         CSHw==
X-Gm-Message-State: AOAM531Q2f5ETZV3+9pGFkhohr8P9VqystvQbFeUNKiCL2xYlEZyhSnb
        ofnQjIkr/B2MUDpagt/lfmTmH0E=
X-Google-Smtp-Source: ABdhPJwynxzOo1uDL3PwMweufxLtr415yHT/T9PLgILZC1tllY8xKXYrs4PdKMB9UD3Be3KOTlIn+Bs=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:e34c:522f:9edd:2978])
 (user=pcc job=sendgmr) by 2002:a05:690c:13:b0:2dc:50bc:c975 with SMTP id
 bc19-20020a05690c001300b002dc50bcc975mr17931ywb.173.1649107144995; Mon, 04
 Apr 2022 14:19:04 -0700 (PDT)
Date:   Mon,  4 Apr 2022 14:18:58 -0700
Message-Id: <20220404211858.968452-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH] arm64: document the boot requirements for MTE
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting the kernel we access system registers such as GCR_EL1
if MTE is supported. These accesses are defined to trap to EL3 if
SCR_EL3.ATA is disabled. Furthermore, tag accesses will not behave
as expected if SCR_EL3.ATA is not set, or if HCR_EL2.ATA is not set
and we were booted at EL1. Therefore, require that these bits are
enabled when appropriate.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/Iadcfd4dcd9ba3279b2813970b44d7485b0116709
---
 Documentation/arm64/booting.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index 29884b261aa9..833af981b667 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -350,6 +350,16 @@ Before jumping into the kernel, the following conditions must be met:
 
     - SMCR_EL2.FA64 (bit 31) must be initialised to 0b1.
 
+  For CPUs with the Memory Tagging Extension feature:
+
+  - If EL3 is present:
+
+    - SCR_EL3.ATA (bit 26) must be initialised to 0b1.
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+    - HCR_EL2.ATA (bit 56) must be initialised to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented
-- 
2.35.1.1094.g7c7d902a7c-goog

