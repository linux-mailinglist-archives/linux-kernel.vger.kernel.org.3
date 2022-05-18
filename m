Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834D252B40F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiERHtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiERHt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:49:26 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA991207DE;
        Wed, 18 May 2022 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652860166; x=1684396166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2p+D/WdtUzo7ZNUrDbOnD9yJq+2AeopkckDysa1nz80=;
  b=tQCfcPvOz6bnrV7muXGxEVPBWt6WJvrrfLTOEre3u2lkQ8TkOCcAx2t7
   XiPj5NJhPPDSdAuaysQOrwJlpYhFBcyE6zrOytBeO5iUKxnCE400PPXo/
   yNShTkQSMcSyekk99XrTz2cqTZQFozC8BfhqwJiwcvL9mT0Qeq/09ywMk
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 May 2022 00:49:25 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 00:49:25 -0700
Received: from blr-ubuntu-185.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 00:49:17 -0700
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
Subject: [RFC 3/6] block: gendisk: Add a new genhd capability flag
Date:   Wed, 18 May 2022 13:18:38 +0530
Message-ID: <1652860121-24092-4-git-send-email-quic_vivekuma@quicinc.com>
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

Add a new genhd capability flag to serialize offsets
for swap partition. This flag is enabled for the gendisk of
the block device which will be used for saving the snapshot
of the hibernation image, based on a kernel parameter
"noswap_randomize". Serializing offset in swap partition
helps in improving hibernation resume time from bootloader.

Signed-off-by: Vivek Kumar <quic_vivekuma@quicinc.com>
Signed-off-by: Prasanna Kumar <quic_kprasan@quicinc.com>
---
 include/linux/blkdev.h | 1 +
 kernel/power/swap.c    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1b24c1f..be094e7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -92,6 +92,7 @@ enum {
 	GENHD_FL_REMOVABLE			= 1 << 0,
 	GENHD_FL_HIDDEN				= 1 << 1,
 	GENHD_FL_NO_PART			= 1 << 2,
+	GENHD_FL_NO_RANDOMIZE			= 1 << 3,
 };
 
 enum {
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 8d5c811..0a40eda 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1526,6 +1526,9 @@ int swsusp_check(void)
 					    FMODE_READ | FMODE_EXCL, &holder);
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
+		if (noswap_randomize)
+			hib_resume_bdev->bd_disk->flags |=
+					GENHD_FL_NO_RANDOMIZE;
 		clear_page(swsusp_header);
 		error = hib_submit_io(REQ_OP_READ, 0,
 					swsusp_resume_block,
-- 
2.7.4

