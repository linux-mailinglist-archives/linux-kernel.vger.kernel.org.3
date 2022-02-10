Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC794B126A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbiBJQMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:12:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244056AbiBJQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:12:14 -0500
X-Greylist: delayed 1845 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 08:12:14 PST
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEE5EB;
        Thu, 10 Feb 2022 08:12:14 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AEAs2P024672;
        Thu, 10 Feb 2022 09:41:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=mtESrcOKgKXQmkilrqoNob9Tn40gKNW7FNM5KPZ6lbo=;
 b=cBhUhcu8iEKk8nz2rzQTprs+Sih8BGTIngMXvcg1E9FKC8h92LC8uHx1c5ZpFNh7j9OA
 mzYyt+VTDYJjfokUbhC2s7xvMMr3TC4BeMQ3vrFM4FswXVgTs16foELemZnhc2A8VaAK
 /2KLJXC+0f5P9KDJYGLmCX2fy7GbGKi1/9OOjuvSxQUL6DXTXgbJqkz49J4gvmC7oH57
 bZuSWAM7QImVrm553/jydiqAJiXTeQlbYutOcNkwgdVDfedHQ5LiFuW3MSi9ClLLlB5s
 CuJKKJi5H3V93T260kgeOeSd7bkdGGi7PJnLK73zMdNQDRIDhvuwbhHtK0EfD5EkyCYl 9g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3e4brb9swy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 09:41:20 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 15:41:18 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 10 Feb 2022 15:41:18 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.19])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BCAC7B10;
        Thu, 10 Feb 2022 15:41:17 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [RESEND v2 0/2] Introduces bypass charge type property
Date:   Thu, 10 Feb 2022 09:41:06 -0600
Message-ID: <20220210154108.641369-1-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SOD0oSYo34xVkkmMOWbF0sFH_5I75OTp
X-Proofpoint-GUID: SOD0oSYo34xVkkmMOWbF0sFH_5I75OTp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series introduces a new POWER_SUPPLY_CHARGE_TYPE for bypass charging
operation.

In fast charging ICs, the bypass operation is used to bypass the charging path
around the charging IC's integrated power converter to its load. This allows
for "smart" wall adaptors (such as USB PPS standard power adaptors) to handle
the power conversion and heat dissipation externally.

Best Regards,
Ricardo

Ricardo Rivera-Matos (2):
  power: supply: Introduces bypass charging property
  power: supply: bq25980: Implements POWER_SUPPLY_CHARGE_TYPE_BYPASS

 drivers/power/supply/bq25980_charger.c    | 2 +-
 drivers/power/supply/power_supply_sysfs.c | 1 +
 include/linux/power_supply.h              | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.25.1

