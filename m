Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CBE52B404
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiERHtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiERHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:49:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51841207F2;
        Wed, 18 May 2022 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652860175; x=1684396175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=99lVhG/h33c7dvn7i8VK817/c8neC8rVGDsrRyn9LtQ=;
  b=hziupHJXDuE1SsLmTiu5/jMaI/SkNdo/9lvNqRxcvhM1piLfW0Pb8Xq6
   bh+tRMO6G4rfhSTzrpEre1ZPbVWw70ReNx1GJdryyqVOdmZjEVh3bI3sE
   7Ak/8oqQIKTO0XpQjdz2/59rQdj+Tw9Cv9hkGtyl3zFxEAwclVmqMEC0G
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 May 2022 00:49:34 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 00:49:33 -0700
Received: from blr-ubuntu-185.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 00:49:25 -0700
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
Subject: [RFC 4/6] mm: swap: Add randomization check for swapon/off calls
Date:   Wed, 18 May 2022 13:18:39 +0530
Message-ID: <1652860121-24092-5-git-send-email-quic_vivekuma@quicinc.com>
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

Add addtional check on swapon/swapoff sycalls to disable
randomization of swap offsets if GENHD_FL_NO_RANDOMIZE
flag is passed.

Signed-off-by: Vivek Kumar <quic_vivekuma@quicinc.com>
Signed-off-by: Prasanna Kumar <quic_kprasan@quicinc.com>
---
 mm/swapfile.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1c3d5b9..a3eeab6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2474,7 +2474,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	if (p->flags & SWP_CONTINUED)
 		free_swap_count_continuations(p);
 
-	if (!p->bdev || !bdev_nonrot(p->bdev))
+	if (!p->bdev || (p->bdev->bd_disk->flags & GENHD_FL_NO_RANDOMIZE)
+			|| !bdev_nonrot(p->bdev))
 		atomic_dec(&nr_rotate_swap);
 
 	mutex_lock(&swapon_mutex);
@@ -3065,7 +3066,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (p->bdev && p->bdev->bd_disk->fops->rw_page)
 		p->flags |= SWP_SYNCHRONOUS_IO;
 
-	if (p->bdev && bdev_nonrot(p->bdev)) {
+	if (p->bdev && !(p->bdev->bd_disk->flags & GENHD_FL_NO_RANDOMIZE) &&
+				bdev_nonrot(p->bdev)) {
 		int cpu;
 		unsigned long ci, nr_cluster;
 
-- 
2.7.4

