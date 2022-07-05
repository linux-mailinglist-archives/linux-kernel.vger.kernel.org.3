Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B734C566501
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiGEI1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiGEI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:27:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B2D13DF2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657009622; x=1688545622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pk/nLLbRif9CyhqZ57jXCfpvtviOivRYEd3l24T9MmM=;
  b=fiGbEpPaKxuAHWalLnLmZTkhYJwhj9Jr1HQvEr1VtfL3jJpmxyGQltvN
   JvMiEcvseI9Z5Y5evP5gdzKY1HwmUpgLq+LpmC3wU9q7shTm+r1XHI/bn
   Ce4xC2mtchM3cM5yG9aOuy5hJCsZjswqZjGejklNdcSVLCeTGo/Le/ai+
   XXVGdlO84o89tOx6Cd+Z52IjTEbNgAT787mz1kUIXNKvirIWt5HzzDvQh
   MNiqk2R1F2BtFtBknpz9qqFBdPjvpDf2s2efk5hCg6X5R4Scn4vKBnSdF
   +Sz9ofzLvSxdwpSqsqLWqLNUJz94ZjOiSQWdOS5ix4T9fJ0YKoeaEPDcl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263713129"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263713129"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 01:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="592834136"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2022 01:27:00 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/6] intel_th: msu-sink: Potential dereference of null pointer
Date:   Tue,  5 Jul 2022 11:26:33 +0300
Message-Id: <20220705082637.59979-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705082637.59979-1-alexander.shishkin@linux.intel.com>
References: <20220705082637.59979-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

The return value of dma_alloc_coherent() needs to be checked.
To avoid use of null pointer in sg_set_buf() in case of the failure of
alloc.

Fixes: f220df66f676 ("intel_th: msu-sink: An example msu buffer "sink"")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu-sink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/intel_th/msu-sink.c b/drivers/hwtracing/intel_th/msu-sink.c
index 2c7f5116be12..891b28ea25fe 100644
--- a/drivers/hwtracing/intel_th/msu-sink.c
+++ b/drivers/hwtracing/intel_th/msu-sink.c
@@ -71,6 +71,9 @@ static int msu_sink_alloc_window(void *data, struct sg_table **sgt, size_t size)
 		block = dma_alloc_coherent(priv->dev->parent->parent,
 					   PAGE_SIZE, &sg_dma_address(sg_ptr),
 					   GFP_KERNEL);
+		if (!block)
+			return -ENOMEM;
+
 		sg_set_buf(sg_ptr, block, PAGE_SIZE);
 	}
 
-- 
2.35.1

