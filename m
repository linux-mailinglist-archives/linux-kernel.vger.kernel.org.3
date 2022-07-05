Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4F7566797
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiGEKPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiGEKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:15:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E9C14003
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657016130; x=1688552130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=80UT52teUlq0UkLOZpvKjIETmclXp6E0n/fil5MHPbs=;
  b=mZKxbHnwJWPVjhLrm4j4GrGOdia5an6OVbsxpB9O6+3Whjalpc2Xn6Ey
   nSJxj6i8BZtFQDc4L7Aye2jyGno9G1b7cEBSnVczTQnuxV7xKCDqpyQuC
   q3ct/WcryRm1vrNnGGjqRhjkiJrM00vAAMVJmRo4rxH6CEKTN1SsvSuy+
   8xgtCeoPgi4Rp2VxCvuP3QFxe1oMJnY+2MhCztKJb/x6dVm/OYxpbfLw4
   KLSELbyQRpmxLAoKSHcd0rdZ08tthhwKvX2+2I6+iZq48w7xAeLiHhxe+
   NdIbQcCRpCbQRnZ97ynLzU87BmS4E4k9ag9D1GGAi7aMN9iKXbtxBXB8W
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="280868189"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="280868189"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 03:15:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="650060009"
Received: from aviranz-mobl1.ger.corp.intel.com (HELO localhost) ([10.254.144.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 03:15:27 -0700
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Jianglei Nie <niejianglei2021@163.com>
Cc:     Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH] peci: cpu: Fix use-after-free in adev_release()
Date:   Tue,  5 Jul 2022 12:15:01 +0200
Message-Id: <20220705101501.298395-1-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When auxiliary_device_add() returns an error, auxiliary_device_uninit()
is called, which causes refcount for device to be decremented and
.release callback will be triggered.

Because adev_release() re-calls auxiliary_device_uninit(), it will cause
use-after-free:
[ 1269.455172] WARNING: CPU: 0 PID: 14267 at lib/refcount.c:28 refcount_warn_saturate+0x110/0x15
[ 1269.464007] refcount_t: underflow; use-after-free.

Reported-by: Jianglei Nie <niejianglei2021@163.com>
Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
 drivers/peci/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
index 68eb61c65d34..de4a7b3e5966 100644
--- a/drivers/peci/cpu.c
+++ b/drivers/peci/cpu.c
@@ -188,8 +188,6 @@ static void adev_release(struct device *dev)
 {
 	struct auxiliary_device *adev = to_auxiliary_dev(dev);
 
-	auxiliary_device_uninit(adev);
-
 	kfree(adev->name);
 	kfree(adev);
 }
@@ -234,6 +232,7 @@ static void unregister_adev(void *_adev)
 	struct auxiliary_device *adev = _adev;
 
 	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
 }
 
 static int devm_adev_add(struct device *dev, int idx)
-- 
2.36.1

