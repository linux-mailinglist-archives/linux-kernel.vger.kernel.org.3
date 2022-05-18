Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754E152B3CE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiERHt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiERHtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:49:18 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D780C11E4B6;
        Wed, 18 May 2022 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652860158; x=1684396158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rOYdWmdQCnEpAHcJFCYdRtOeaAOYF7eoFxilIXHP6Bo=;
  b=f76IxhdMGRpcFIVZl4IoTOvtiIGxMgmbcF5O68qO3WRp3t0i5EFlC3nQ
   GP2f97x2etzlO2ZE3TygF0xsWdZsNTQTcZEDjgvE+cYvxJvuRuRLVpGse
   YjdmChiVaYpg0oHfvMguDJ/JPDTve9Qy17U7qma1wL+izhjsTabITBwxt
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 May 2022 00:49:17 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 00:49:17 -0700
Received: from blr-ubuntu-185.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 00:49:09 -0700
From:   Vivek Kumar <quic_vivekuma@quicinc.com>
To:     <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <axboe@kernel.dk>,
        <rafael@kernel.org>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <len.brown@intel.com>, <pavel@ucw.cz>, <paulmck@kernel.org>,
        <bp@suse.de>, <keescook@chromium.org>, <songmuchun@bytedance.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <pasha.tatashin@soleen.com>, <tabba@google.com>, <ardb@kernel.org>,
        <tsoni@quicinc.com>, <quic_psodagud@quicinc.com>,
        <quic_svaddagi@quicinc.com>,
        Vivek Kumar <quic_vivekuma@quicinc.com>,
        Prasanna Kumar <quic_kprasan@quicinc.com>
Subject: [RFC 2/6] PM: Hibernate: Add option to disable disk offset randomization
Date:   Wed, 18 May 2022 13:18:37 +0530
Message-ID: <1652860121-24092-3-git-send-email-quic_vivekuma@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kernel parameter to disable the disk offset randomization
for SSD devices in which such feature is available at the
firmware level. This is helpful in improving hibernation
resume time.

Signed-off-by: Vivek Kumar <quic_vivekuma@quicinc.com>
Signed-off-by: Prasanna Kumar <quic_kprasan@quicinc.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 kernel/power/swap.c                             |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 666ade9..06b4f10 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5192,6 +5192,17 @@
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
 
+	noswap_randomize
+			Kernel uses random disk offsets to help with wear-levelling
+			of SSD devices, while saving the hibernation snapshot image to
+			disk. Use this parameter to disable this feature for SSD
+			devices in scenarios when, such randomization is addressed at
+			the firmware level and hibenration image is not re-generated
+			frequently.
+			(Useful for improving hibernation resume time as snapshot pages
+			are available in disk serially and can be read in bigger chunks
+			without seeking)
+
 	retain_initrd	[RAM] Keep initrd memory after extraction
 
 	rfkill.default_state=
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 91fffdd..8d5c811 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -44,6 +44,7 @@ u32 swsusp_hardware_signature;
  */
 static bool clean_pages_on_read;
 static bool clean_pages_on_decompress;
+static bool noswap_randomize;
 
 /*
  *	The swap map is a data structure used for keeping track of each page
@@ -1616,3 +1617,11 @@ static int __init swsusp_header_init(void)
 }
 
 core_initcall(swsusp_header_init);
+
+static int __init noswap_randomize_setup(char *str)
+{
+	noswap_randomize = true;
+	return 1;
+}
+
+__setup("noswap_randomize", noswap_randomize_setup);
-- 
2.7.4

