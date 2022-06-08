Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D5A542333
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiFHE4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiFHEyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:54:53 -0400
X-Greylist: delayed 628 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 18:27:48 PDT
Received: from smtp.ruc.edu.cn (m177126.mail.qiye.163.com [123.58.177.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281E487A36;
        Tue,  7 Jun 2022 18:27:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp.ruc.edu.cn (Hmail) with ESMTPSA id 3DE65800A4;
        Wed,  8 Jun 2022 09:17:17 +0800 (CST)
From:   Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] platform/x86/intel: Fix uninitialized entry in pmt_crashlog_probe
Date:   Wed,  8 Jun 2022 09:17:12 +0800
Message-Id: <20220608011712.2371-1-xiaohuizhang@ruc.edu.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUNLS0pWSh9NTkIYSkgaTh
        0ZVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxA6ERw4Gj08IRcUIzJLDUNK
        SRdPCxxVSlVKTU5PTU5KS0hMQ0lDVTMWGhIXVQMSGhQTDhIBExoVHDsJDhhVHh8OVRgVRVlXWRIL
        WUFZSUtJVUpKSVVKSkhVSUpJWVdZCAFZQUlITkw3Bg++
X-HM-Tid: 0a8140e327092c20kusn3de65800a4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the handling of pmt_telem_probe in commit 2cdfa0c20d58
("platform/x86/intel: Fix 'rmmod pmt_telemetry' panic"), we thought
a patch might be needed here as well.

The probe function, pmt_crashlog_probe(), adds an entry for devices even if
they have not been initialized.  This results in the array of initialized
devices containing both initialized and uninitialized entries.  This
causes a panic in the remove function, pmt_crashlog_remove() which expects
the array to only contain initialized entries.

Only use an entry when a device is initialized.

Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
---
 drivers/platform/x86/intel/pmt/crashlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
index 34daf9df168b..ace1239bc0a0 100644
--- a/drivers/platform/x86/intel/pmt/crashlog.c
+++ b/drivers/platform/x86/intel/pmt/crashlog.c
@@ -282,7 +282,7 @@ static int pmt_crashlog_probe(struct auxiliary_device *auxdev,
 	auxiliary_set_drvdata(auxdev, priv);
 
 	for (i = 0; i < intel_vsec_dev->num_resources; i++) {
-		struct intel_pmt_entry *entry = &priv->entry[i].entry;
+		struct intel_pmt_entry *entry = &priv->entry[priv->num_entries].entry;
 
 		ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns, intel_vsec_dev, i);
 		if (ret < 0)
-- 
2.17.1

