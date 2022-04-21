Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2F509CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387994AbiDUKC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388008AbiDUKCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:02:38 -0400
Received: from ZXBJCAS.zhaoxin.com (zxbjcas.zhaoxin.com [124.127.214.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07D921250;
        Thu, 21 Apr 2022 02:59:48 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXBJCAS.zhaoxin.com
 (10.29.252.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Apr
 2022 17:43:37 +0800
Received: from zx-HX001EM1.zhaoxin.com (10.29.8.9) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 21 Apr
 2022 17:43:37 +0800
From:   Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
To:     <damien.lemoal@opensource.wdc.com>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ahci: Add PxSCTL.IPM control on actual LPM capability
Date:   Thu, 21 Apr 2022 17:43:37 +0800
Message-ID: <1650534217-14052-3-git-send-email-RunaGuo-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
References: <1650534217-14052-1-git-send-email-RunaGuo-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.9]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platform, when OS enables LPM by default (eg, min_power),
then, DIPM slumber request cannot be disallowed if ahci's CAP.PSC
is set to '1' and CAP.SSC is cleared to '0', which may cause ahci
to be an uncertain state (same for Partial).

In ahci spec, when CAP.PSC/SSC is cleared to '0', the PxSCTL.IPM
field must be programmed to disallow device initiated Partial/
Slumber request.

Adds support to control this case on actual LPM capability.

Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
---
 drivers/ata/libata-sata.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 7a5fe41..e6195cf 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -394,9 +394,19 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	case ATA_LPM_MED_POWER_WITH_DIPM:
 	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
 	case ATA_LPM_MIN_POWER:
-		if (ata_link_nr_enabled(link) > 0)
+		if (ata_link_nr_enabled(link) > 0) {
 			/* no restrictions on LPM transitions */
 			scontrol &= ~(0x7 << 8);
+
+			/* if controller does not support partial, then disallows it,
+			 * the same for slumber
+			 */
+			if (!(link->ap->host->flags & ATA_HOST_PART))
+				scontrol |= (0x1 << 8);
+
+			if (!(link->ap->host->flags & ATA_HOST_SSC))
+				scontrol |= (0x2 << 8);
+		}
 		else {
 			/* empty port, power off */
 			scontrol &= ~0xf;
-- 
2.7.4

