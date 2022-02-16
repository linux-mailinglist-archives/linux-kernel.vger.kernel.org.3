Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB854B82B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiBPIQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:16:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiBPIQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:16:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86CA13D3D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644999352; x=1676535352;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mZe1Um7zlEYvfSJSwbgaDtjTEuNMEhb6+5hvoEsUI10=;
  b=NQmL76GEyhrzoQqAzbaKDepd2WTgA5uhjC1FeXoyhRet8ryMxORa5ZSg
   aclVgKrQTk7u1/y7z0lfc0Q4fytMhLtezHU7Cf0z5aCG+gpa9ZtviluAx
   CehuouT/dxzc8/Hy40Ekh+8rV30ezvrcwXUTa5XxtZg2oK1VjwOhD+mbQ
   7ld+DZ/rA5ziDV5xXPIfllhHCoGsiBCEwYyZR13ayndvUia9uMJIEmRGV
   an7TKep76O5ZWzIIA723YaxqF4aJ/9/aL6fdKO9BjkRwQ7OCnGURJ3aeE
   v4xmEKVWKmK06jNUP1HklnztNaQQPzwSDp8UJ/GkjgYpYm4Zw5lAX6OQt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250750868"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="250750868"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 00:15:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="773920851"
Received: from pglc00512.png.intel.com ([10.221.239.204])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2022 00:15:51 -0800
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH] firmware: stratix10-svc: add missing callback parameter on RSU
Date:   Wed, 16 Feb 2022 16:15:13 +0800
Message-Id: <20220216081513.28319-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

Fix a bug whereby, the return response of parameter a1 from an
SMC call is not properly set to the callback data during an
INTEL_SIP_SMC_RSU_ERROR command.

Fixes: 6b50d882d38d ("firmware: add remote status update client support")
Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 29c0a616b317..c4bf934e3553 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -477,7 +477,7 @@ static int svc_normal_to_secure_thread(void *data)
 		case INTEL_SIP_SMC_RSU_ERROR:
 			pr_err("%s: STATUS_ERROR\n", __func__);
 			cbdata->status = BIT(SVC_STATUS_ERROR);
-			cbdata->kaddr1 = NULL;
+			cbdata->kaddr1 = &res.a1;
 			cbdata->kaddr2 = NULL;
 			cbdata->kaddr3 = NULL;
 			pdata->chan->scl->receive_cb(pdata->chan->scl, cbdata);
-- 
2.26.2

