Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54F84C23E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiBXGIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiBXGIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:08:14 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D47268377;
        Wed, 23 Feb 2022 22:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645682864; x=1677218864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KyOwqjIbG0TroSylE/Ycq5BtVWaP9tTR0OCtbJSnzHE=;
  b=zhR0VPpEECz4NRevXBW7O5vzPFptuKhM650LbWr3xI1yIvlwB7S6Xgli
   gITc7GL3RnSPGxQtOlGk2Kxc4QiV6YBbbfGFHQtzraJH1qoT/2Z5FwfcN
   TiBpbkHZsIOim1MZyw5CXKafnvE7miXbJwTkBtgqtinffLjR6Crw5UxPN
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 23 Feb 2022 22:07:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 22:07:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 22:07:43 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 22:07:38 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Marc Zyngier" <maz@kernel.org>
CC:     Trilok Soni <quic_tsoni@quicinc.com>, <quic_psodagud@quicinc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        <coresight@lists.linaro.org>
Subject: [PATCHv10 2/6] coresight: etm4x: Use asm-generic IO memory barriers
Date:   Thu, 24 Feb 2022 11:37:04 +0530
Message-ID: <8e1fe065405c2d9d1e28e3f84880d156c2e887a4.1644824638.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1644824638.git.quic_saipraka@quicinc.com>
References: <cover.1644824638.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per discussion in [1], it was decided to move to using architecture
independent/asm-generic IO memory barriers to have just one set of
them and deprecate use of arm64 specific IO memory barriers in driver
code. So replace current usage of __io_rmb()/__iowmb() in drivers to
__io_ar()/__io_bw().

[1] https://lore.kernel.org/lkml/CAK8P3a0L2tLeF1Q0+0ijUxhGNaw+Z0fyPC1oW6_ELQfn0=i4iw@mail.gmail.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: coresight@lists.linaro.org
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 8 ++++----
 drivers/hwtracing/coresight/coresight-etm4x.h      | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index bf18128cf5de..89ba7bb4c41d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -98,7 +98,7 @@ u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
 	}
 
 	if (!_relaxed)
-		__iormb(res);	/* Imitate the !relaxed I/O helpers */
+		__io_ar(res);	/* Imitate the !relaxed I/O helpers */
 
 	return res;
 }
@@ -106,7 +106,7 @@ u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
 void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
 {
 	if (!_relaxed)
-		__iowmb();	/* Imitate the !relaxed I/O helpers */
+		__io_bw();	/* Imitate the !relaxed I/O helpers */
 	if (!_64bit)
 		val &= GENMASK(31, 0);
 
@@ -130,7 +130,7 @@ static u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
 	}
 
 	if (!_relaxed)
-		__iormb(res);	/* Imitate the !relaxed I/O helpers */
+		__io_ar(res);	/* Imitate the !relaxed I/O helpers */
 
 	return res;
 }
@@ -138,7 +138,7 @@ static u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
 static void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
 {
 	if (!_relaxed)
-		__iowmb();	/* Imitate the !relaxed I/O helpers */
+		__io_bw();	/* Imitate the !relaxed I/O helpers */
 	if (!_64bit)
 		val &= GENMASK(31, 0);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 3c4d69b096ca..f54698731582 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -448,14 +448,14 @@
 #define etm4x_read32(csa, offset)					\
 	({								\
 		u32 __val = etm4x_relaxed_read32((csa), (offset));	\
-		__iormb(__val);						\
+		__io_ar(__val);						\
 		__val;							\
 	 })
 
 #define etm4x_read64(csa, offset)					\
 	({								\
 		u64 __val = etm4x_relaxed_read64((csa), (offset));	\
-		__iormb(__val);						\
+		__io_ar(__val);						\
 		__val;							\
 	 })
 
@@ -479,13 +479,13 @@
 
 #define etm4x_write32(csa, val, offset)					\
 	do {								\
-		__iowmb();						\
+		__io_bw();						\
 		etm4x_relaxed_write32((csa), (val), (offset));		\
 	} while (0)
 
 #define etm4x_write64(csa, val, offset)					\
 	do {								\
-		__iowmb();						\
+		__io_bw();						\
 		etm4x_relaxed_write64((csa), (val), (offset));		\
 	} while (0)
 
-- 
2.33.1

