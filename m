Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEBB4D2D41
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiCIKmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiCIKls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:41:48 -0500
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2092.outbound.protection.outlook.com [40.107.23.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357B976E37;
        Wed,  9 Mar 2022 02:40:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQWFhMPy/psNl/sFTmwqDEfVe0HJgPSKJ1Jedba1wFN/OZ5RMO75Lu1Z6DwuCXdkB/c+EjssqezA+BVDY0dXJL5KtRFIEyzazpVgSMtb068oH3KgaOYv+4nVphMcfXKIOOGslzAUZBUD+1uxdhiabsZb/5VdCx9RoRYFDzsV3DkRT/OjOj/BZ38dhJtlCpFi9evbELEStUji0RrbpUYccyuPNYSgH23u97BBC96NB4E1VXw4WV9S0r/8/XKU1vnvnaiBdmT3V6MyiMf7VcRObvmaXHOkNRFpV2GfGj2ibJx4BW8MilEcI4FU/3+EcRuE+FfXqGGABIHF3E8alZuKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03tsBzrBNZts1+8g5MU/lOY0z2f0yh3fK7Ci/FDeFqQ=;
 b=k0AnZRfV/hd/kGH/xh7k0g0TCjCq2oPGF9qAw7ATSVdNI69sTAimjsvG95sK757IK9fCLTwEXeh0WrM9d+F4d204pd1raxb2MK9deS4wE6SfiRfhg3ZK+zN/kSAh5PPwPkOA01D5jPjD2giWv6gBizFB9ssigtmZzOwZzEIXPE/8WB6FIJ0zVKPldyznWLpUQh6NEOgSoYZTLSb8QyAQvfu8iK5pp41gCptCirPGLAQT7C5ljjSwu6hDU6cxHEjTNWtknl86dN5bziXm4i/J3koaw9G9C7Rj4eVlFaVuUZmFN8aPERKSFHoH9hyCN+AVc+sRijzRhrIUWvy6RzQ7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netmodule.com; dmarc=pass action=none
 header.from=netmodule.com; dkim=pass header.d=netmodule.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector2-netmodule-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03tsBzrBNZts1+8g5MU/lOY0z2f0yh3fK7Ci/FDeFqQ=;
 b=BW/dsrDKYYynOW1SanK8URC/ijSkD+/ZZVHnB7lBjLKJCPTIG3/5ijOJUisUoAQlKmrU1OMSfo5i240ZgJ94S2HSnj86+dzXMlvlOZdVnJWLmSRl5R010X0MnvXh6f9/VLKBX5g/u/BDIZaAzscvqKtZm0v9C5uazGbUub2nF7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netmodule.com;
Received: from ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1a::12)
 by GV0P278MB0949.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 10:40:49 +0000
Received: from ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1132:a401:5946:ee88]) by ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1132:a401:5946:ee88%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 10:40:49 +0000
From:   Marc Mattmueller <marc.mattmueller@netmodule.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marc Mattmueller <marc.mattmueller@netmodule.com>
Subject: [PATCH 2/2] mmc: core: add reliable write setting to sysfs and update on read
Date:   Wed,  9 Mar 2022 11:40:21 +0100
Message-Id: <d68d8c8edda35a050a6e92b0ff1d57dd3e7c61d6.1646820083.git.marc.mattmueller@netmodule.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1646820083.git.marc.mattmueller@netmodule.com>
References: <cover.1646820083.git.marc.mattmueller@netmodule.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0185.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::18) To ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62ca70bb-3f4e-40c3-39eb-08da01b94674
X-MS-TrafficTypeDiagnostic: GV0P278MB0949:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB09498AEA5E4B4FB71D048217850A9@GV0P278MB0949.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w73ULT7TiCy1I3LIwtbFWuzr0O6XoS5H3DVdE2qcT6QopaKKzWTO8DqD+LBCA5Ihs3tzRbhmxX2kuMneA6o3zOfdK7YKjrD1P4+iRNE80G7KrJsNvPJx62p0CNtRtYQNnVD2uUTgIKxWc1tCjtMb63ED+dGM4BilgzGUJB0gaGS5QkNJBswM/4H7dP9O1zu8X+Xpdwb5deo8VGn91YvJZeNydseKRXIrkXEucxBCiwKYNY2yXnBHnJ+x6vBMDS5Li8S4v0aKMxuFChVpMRUcNx2PO7EmKlWHLXqGSB3SxlBs8fPQI15qj9JMQaGpQUGBF133Iv1KPhNu6pkHjaGwbWhGzBk/uOlfnSXhL36DcKojMqr8yb2Qox1IP4vvS0xux5A/xXDRqdETAREf21t/n7IQGxXhoqlka3h+oAYJav9bHLXSEHQ+wicN6dqDS2nlHcgqnHX0d2fGVyyh+Iv1jpy3WzJYeHKE5mJJDqOCN/gvcgwUe/9suyMC60LA6QFynH/DHlO5J+t4QY1e2+6D1bq+vPvW3KRzG229hMeI2bVC+3WyUG3WcsZqw+zf5DTPRcZzh7zs7h4CMoo+ndX76m+lxdwrVjGGvOvPwkmQ+GmijQ00mm5vDhzd4XJjGjE484mLVUx594rENuYQW1/4xaGWuyKpDOfl9sASgqoqI4ZlwM545P0wfz36OSCpNaE4+9NF6Jl/C/WqZsNLa1jTHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(136003)(39830400003)(396003)(366004)(52116002)(107886003)(508600001)(2616005)(186003)(26005)(316002)(83380400001)(6512007)(36756003)(6486002)(6506007)(6666004)(2906002)(66476007)(66556008)(5660300002)(8676002)(4326008)(38100700002)(66946007)(38350700002)(44832011)(15650500001)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cFZfWQ5h298N1mwg0L91NSYvCFSWNjZR4iL0RVcxaFcfZkwA6ILCTBubQbof?=
 =?us-ascii?Q?32ArMQmc+Vjwz+i+L3rvuf1SDh5S0PMnlPGRgzdSRDZn5pDRWRyM8Js7dToF?=
 =?us-ascii?Q?pIBLsYr7+07Xa7n6qWqS1zhS/azx25FkSPndMO1OZofRcKVCSm1p+S123PJo?=
 =?us-ascii?Q?lYkiWOeQn3Pot2c6CUM36rZcSPLhUIPGFT2JckRfI7Doqj6TWZ1PkjQ3Dqxs?=
 =?us-ascii?Q?bdMe1M2Cqy6bTqeLRg48JpDy4ds6Im+yXxBJHPtZ2aX3lmmzH1CdNYG/Hhr6?=
 =?us-ascii?Q?wjcKaHd/vXpYw0Y3GqSLjzNu3EVeizuWQEbRsi/SspYIdsa526wJqSpY5VzI?=
 =?us-ascii?Q?IddRngETq8bvL4JSBdsRMn3dS1cphKKy41PQoAR7aWbG0KKvTKSTi4vdl+8k?=
 =?us-ascii?Q?yho/zBWzL9qrHWdvYggOp064OiVPusiFHEEwjLO6kL0WZvky6Qg/XZSDrzCe?=
 =?us-ascii?Q?QbzTelujG5XO2jCWNsKDG760yMEbEMP3qpVAqtgTDvxGQ0wOZkU4vAH0KFqX?=
 =?us-ascii?Q?HGzJs4Y8bttu1LNP4hU31BioYYjfj9JrxALgq2Y3rCOd5FMG+5Ke4kQw+oV5?=
 =?us-ascii?Q?C2ScDlyMLGsS3pkeqJyqlVoYSD0Cb6MVADttJMeIdnLjK3yXZHdrKk92hPUZ?=
 =?us-ascii?Q?FstPVyVLSW22oaJuj0Vy2M+eKLh0cWm2jwJI/WYyxbByW8K1cRE5+M7GtYZD?=
 =?us-ascii?Q?fq5pUpwNa2GujiX9CvY2vMYg3GiqnFwUoh4rVaalybl9nrXA+naKQsq0Tml7?=
 =?us-ascii?Q?A8LE49CqXg6DfYh6dLszoVBEpD815itJ4U7zLaHm5pbO9rNdHxR0LCE64upx?=
 =?us-ascii?Q?OtYZh/ufF1t5QNZ892hNNLugZcg0wEaSsD01bfty5bGocvo7YE9G+Gyynogd?=
 =?us-ascii?Q?JH7oMocrXS4Bnmm/ZkLbJ/1J54sMImAOFunGgCKN1kPRD1AULg2dpP1W6e1s?=
 =?us-ascii?Q?s6rv+5Ebx5MxAeffo7gmgJwqsFqyDvVnFbKQYKvlmRHVOQGe4jiWKjtZ5pml?=
 =?us-ascii?Q?qmbGXfJAFQ8ewcFS6ocMcCKu+IUgRKiNgb7sztx+AeYH2+i0sym+KA4kVA+Q?=
 =?us-ascii?Q?fmpebzbIVMw5y6XZrNb6pj1sO0gmEYHwTcJHLhHhDNDd+3KLOijfGClYfa4Y?=
 =?us-ascii?Q?1YNC0rSAkTWcCXRxLHvk6I0V5Fvr/hoDp057ybTJ9Ihx1Zm+XcfuziiZNcrx?=
 =?us-ascii?Q?8yVDn3wkHChaLPNlOO+9oPmQCpBypoucLWh6oAQObWFLEaKjf9/JYYNqqfej?=
 =?us-ascii?Q?9/1SdgeqyY88mOzomyjGUfonrgQ0QX+So9gXOWpWb+KVoSGpb+ZHO6DtzsJ8?=
 =?us-ascii?Q?FBrNY8IbRVtxUAEeXfkzsnt/oY/bViREoJ3xmP1YRoH/8nJsMI2SuaxzsX13?=
 =?us-ascii?Q?nMfjvblJECJAreDXjMEayYWSlH1lDcKn13sMft/gA/Bc36JU5iZGA8z8H6Ei?=
 =?us-ascii?Q?iJejFvBRoy2EDC6NZPAybnrn9Rg9uOSGBWFPz5OfYgQps0hvCu5E3XYf3etp?=
 =?us-ascii?Q?4tbfShFapEJnrw2CAD0plf8Enuoj7mv9VeIA8UNPbQy8k4QqZ2qNo2OkjDmr?=
 =?us-ascii?Q?bt70O/S/GBEXsqzwHecD0Wa4xdlgZCASCncraRp4ep1aMT/3RZPOIsCOj5Lc?=
 =?us-ascii?Q?mL9heqvrf1q0LnhL2QUMKjE0zzqsmkIifHDcHQZNH7FXrYCuMsJiWhsyyzzf?=
 =?us-ascii?Q?rH4u8w=3D=3D?=
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ca70bb-3f4e-40c3-39eb-08da01b94674
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 10:40:49.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Px+utMKj1+l4Kg1gDyswrs8kiMHqNV56U5gIFTaUbL1LXFtK0YKyOuVD9KJJlEOpjzhjcg/7cWjSUNezg5uEY3EAl9Apt/Vt0722qSFnwcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0949
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmc reliable write setting (from ext_csd) was not available
on the sysfs.
Thus, added rel_param and rel_write_set to sysfs and added the
update of rel_write_set on sysfs read.

Signed-off-by: Marc Mattmueller <marc.mattmueller@netmodule.com>
---
 drivers/mmc/core/mmc.c   | 29 +++++++++++++++++++++++++++++
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/mmc.h  |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d9537c894e33..a64d1ecb0de9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -364,6 +364,10 @@ static int mmc_update_ext_csd_runtime_params(struct mmc_card *card, u8 *ext_csd)
 {
 	int err = 0;
 
+	/* eMMC v4.41 or later */
+	if (card->ext_csd.rev >= 5)
+		card->ext_csd.rel_wr_set = ext_csd[EXT_CSD_WR_REL_SET];
+
 	/* eMMC v5 or later */
 	if (card->ext_csd.rev >= 7) {
 		card->ext_csd.pre_eol_info = ext_csd[EXT_CSD_PRE_EOL_INFO];
@@ -587,6 +591,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		}
 
 		card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
+		card->ext_csd.rel_wr_set = ext_csd[EXT_CSD_WR_REL_SET];
 		card->ext_csd.rst_n_function = ext_csd[EXT_CSD_RST_N_FUNCTION];
 
 		/*
@@ -820,6 +825,7 @@ MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);
 MMC_DEV_ATTR(rev, "0x%x\n", card->ext_csd.rev);
+MMC_DEV_ATTR(rel_param, "0x%02x\n", card->ext_csd.rel_param);
 MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
 MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
 		card->ext_csd.enhanced_area_offset);
@@ -886,6 +892,27 @@ static ssize_t pre_eol_info_show(struct device *dev,
 
 static DEVICE_ATTR_RO(pre_eol_info);
 
+static ssize_t rel_write_set_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	int err = 0;
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	/* before eMMC v4.41 */
+	if (card->ext_csd.rev < 5)
+		return sprintf(buf, "%s\n", "-");
+
+	/* eMMC v4.41 or later */
+	err = mmc_update_csd(card);
+	if (err)
+		return (ssize_t)err;
+
+	return sprintf(buf, "0x%02x\n", card->ext_csd.rel_wr_set);
+}
+
+static DEVICE_ATTR_RO(rel_write_set);
+
 static ssize_t mmc_fwrev_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
@@ -931,6 +958,8 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_oemid.attr,
 	&dev_attr_prv.attr,
 	&dev_attr_rev.attr,
+	&dev_attr_rel_param.attr,
+	&dev_attr_rel_write_set.attr,
 	&dev_attr_pre_eol_info.attr,
 	&dev_attr_life_time.attr,
 	&dev_attr_serial.attr,
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 37f975875102..21c47893fcb4 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -48,6 +48,7 @@ struct mmc_ext_csd {
 	u8			sec_feature_support;
 	u8			rel_sectors;
 	u8			rel_param;
+	u8			rel_wr_set;
 	bool			enhanced_rpmb_supported;
 	u8			part_config;
 	u8			cache_ctrl;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d9a65c6a8816..42afd442a70a 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -266,6 +266,7 @@ static inline bool mmc_ready_for_data(u32 status)
 #define EXT_CSD_BKOPS_START		164	/* W */
 #define EXT_CSD_SANITIZE_START		165     /* W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
+#define EXT_CSD_WR_REL_SET		167	/* R/W */
 #define EXT_CSD_RPMB_MULT		168	/* RO */
 #define EXT_CSD_FW_CONFIG		169	/* R/W */
 #define EXT_CSD_BOOT_WP			173	/* R/W */
-- 
2.20.1

