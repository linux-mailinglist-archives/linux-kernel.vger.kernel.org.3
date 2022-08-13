Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277515918E4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 07:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbiHMFdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 01:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHMFcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:32:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F1215FEE;
        Fri, 12 Aug 2022 22:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660368769; x=1691904769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bO1ed+Iu091nnqIbMp9C9EKP1YFImbRdXiqtoElAjM8=;
  b=PYKTc34DPaAZhI/ChAct3tPa0eHhtp4ejvQ4Xw7RdjvH5KtEzFgBStnL
   PXMAWH4Q114mZ3ZyNJKlZGS3134Kl0Sksc1lhQ6LoVsSh7zrzwykjr2le
   9xSCf4rXuDZEoVBKlGRzhjtrTKFXePd2KPJiQBVHU7wMkAKkFA1mPCLfE
   EAnHJ17JvB+Mnx53BxrIqUpZ2F/G4xgo88KUCDRkFsNBndHMQEUOsU5n/
   jtHkhRJneUXkCHk/MM7Fy092NSSIvoW/BvB/iqu6hO314vTmnkxiCIR1f
   q9FF2R8YE+M/YFGjsM4HTrgqYVDxwVhTSZZK6ZzOMGe1J+dKDz9dLSIKl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292999046"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292999046"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="695472746"
Received: from jchen8-mobl.amr.corp.intel.com (HELO localhost) ([10.212.10.85])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:48 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [RFC PATCH 3/9] cxl/mem: Clear events on driver load
Date:   Fri, 12 Aug 2022 22:32:37 -0700
Message-Id: <20220813053243.757363-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220813053243.757363-1-ira.weiny@intel.com>
References: <20220813053243.757363-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The information contained in the events prior to the driver loading can
be queried at any time through other mailbox commands.

Ensure a clean slate of events by reading and clearing the events.  The
events are sent to the trace buffer but it is not anticipated to have
anyone listening to it at driver load time.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c            | 2 ++
 tools/testing/cxl/test/mem.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..5f1b492bd388 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -498,6 +498,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	cxl_mem_get_event_records(cxlds);
+
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
 
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index aa2df3a15051..e2f5445d24ff 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -285,6 +285,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	cxl_mem_get_event_records(cxlds);
+
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(dev, cxlmd);
 
-- 
2.35.3

