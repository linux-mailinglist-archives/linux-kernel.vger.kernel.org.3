Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386484D2D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiCIKlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiCIKlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:41:47 -0500
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2092.outbound.protection.outlook.com [40.107.23.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4E17307E;
        Wed,  9 Mar 2022 02:40:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO7zEBxJRqMu0JmjhpQF9pnaYYShHj4wRZvAsY5RqQ2Fv5N1TT2X1qpGHG6fsch1TvCQtgMf0wv58ZiZ1RV03InkmUaL8Shf2VaD9ey2LHHMNHuNFuUpVUOuRKZuJaRgopWmaka9fWhnte4MFaJRW5ORREUQcVuXmkJwZ9nenG74j1r2Br39E+W5i5AFKvLhifsk4T7aZfDy8qq4tDcXp2y7pGqRE4Edfj4S51toAH934N2ikpSwVIZCP/gskin+2TG1iccXAblAT2y2ZMLrPtyFdE3U441jiFCvjMARnHhub4fiO6fDz/FXEbEr37hHTktbEyB9Elz7d57ttPpeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uD1/4Gq9DAank3lB+nLKJNfgqkbifHL7AgqWO2oPd4=;
 b=douNxSM3rtBUn2V5ftj518G0Nc1LZvIkrPO9ZI3EhW3VA1Kaw+Ol8uJCWZEZVhr6uorgz0oIAkQGn/NO07ug1pUiNrepOs8Wb085jNQESeOnLavJKq7OsU0rJGIcR6m4pyPpThMcIqJXkU8yogsyha10NprQ5b66uKpQa8B6qzUs5+QLQ+KLPPYiQ4Uth/sAv6Cw/2hPy+RHCRejcT/3gnk6KnI91DUnnuk/+1AHcG0yBwaLVxC54An5ESMfk8fNqJaO6TOZwh93Cp9M7ehLQXR4RbvenkQG9dEiGOmRKN6DNhpYG8mFXZS7UO136XAlXO/EaXrjetMwWVW0SK8Eag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netmodule.com; dmarc=pass action=none
 header.from=netmodule.com; dkim=pass header.d=netmodule.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector2-netmodule-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uD1/4Gq9DAank3lB+nLKJNfgqkbifHL7AgqWO2oPd4=;
 b=X/OYDV0U9VzhFKaAke1FHW3OwRsiO4FXWbeZzIsDJjmoJATqm+QEfDhBS4TqkCEc+h0UO13IoI+Sr/IZZ/EyoHGs4z1USXTQQb6MvRe3DZO1lsr3qVdCh82wHgjh+R9Z0yrznah97Ut/Ik9WLZcD5SCJDGucbqZjZwmhxx8+d3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netmodule.com;
Received: from ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1a::12)
 by GV0P278MB0949.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 10:40:47 +0000
Received: from ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1132:a401:5946:ee88]) by ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1132:a401:5946:ee88%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 10:40:47 +0000
From:   Marc Mattmueller <marc.mattmueller@netmodule.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marc Mattmueller <marc.mattmueller@netmodule.com>
Subject: [PATCH 1/2] mmc: core: update life time and pre eol info values on sysfs read
Date:   Wed,  9 Mar 2022 11:40:20 +0100
Message-Id: <5fe56c7fe12d48996ba557596b16b1cd0adca6a2.1646820083.git.marc.mattmueller@netmodule.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e84f0d6-ac2d-4b32-5e86-08da01b94558
X-MS-TrafficTypeDiagnostic: GV0P278MB0949:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB0949FE50773EAB6FCAA04205850A9@GV0P278MB0949.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9PcgFc6PKEwL4yNJ3VXMDE3pLdKUPqXTPlETJ4OJnFmKSNwS5bCP6SiSRixumcAEIrZNIrb+RRY2zvmDOQD9LJmXEPcZRm+TE2BnQaEGcp5DP+94C8QaUeENrewXlDiUx3Re4tl6xuiJfIdX1+fmTTVsxCG6Ca7tYC9cLD+fCV0KofrDuLww6XAN4Y2FAK7etrrkfqgQd3CNk+ewR4AXOmvfVdI1jUNQjB0iM+qj7IxQ2tUlraL3LpMaWTYGD3EHi/yF626rdVVxu6IhP+d4jv8XPvkreRXwF++kobqmqJiBB1IVg2cWWVttqKfNeFrc56evKSU9I0OvHJq8YYVOlLdxUM7v6HEAWl9EKiMSdAniMoYwwvWQpOJjtxroK+5NU3x20Pa4+z/Iht5yj21rA05ODaHX1FChvJ5l550ndxMgNawpDSZMbzuoYrsjFytVs/WLVL1aJq1wIZLVYof5zyvIx3BN1UGQFHBmhz03rWHquLVAYbw8gUip0jyJDay6pj8F3pciWCMY5gurw2uczZ9L/+9Hp15FvX4SlCOgcDI5HhMgGKIlyFFcDeuUEWEw04olAdWwy25pSZJNEt4IKzpNnI9RE8peWGkEt/uy+MSqTiTJdgh6qgMmHrbpsr+0KR30fYrREfHI1QjsYgpKv0xknPG6KdwXlTulRmKzPOUqxrdGPkZyJ/JGD2WV/Ic033rOv92Ou+F7ch1JhdAww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(136003)(39830400003)(396003)(366004)(52116002)(107886003)(508600001)(2616005)(186003)(26005)(316002)(83380400001)(6512007)(36756003)(6486002)(6506007)(6666004)(2906002)(66476007)(66556008)(5660300002)(8676002)(4326008)(38100700002)(66946007)(38350700002)(44832011)(15650500001)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aM/RTbNfmgq6aiyixkC07j+ZJFueNX9/UdRqjlM830PnedscGEOuUX/sKwcc?=
 =?us-ascii?Q?LOSoF1mBwae2NB/wrwQ1TR6uufs46Cch4Lxgn1CeelcYbAn6XQaSUpdStJTH?=
 =?us-ascii?Q?u/9Mx29dgG/b0LYfC2ib32vYsLP9FMrMISGBLVVK/TE9UtcggyehfjdxbwOU?=
 =?us-ascii?Q?6D2T5oP4TUvXaheqZIbk5zDUeZtlZoQSI6fQx8i8GNqRyIL1kZsFT5MzhXMX?=
 =?us-ascii?Q?s1sMBwv/u7lQhsM7WRCMFdSjgisePSfKDq0M+zogMkeFlsurUbb3eBw1bMMn?=
 =?us-ascii?Q?0QBGZqjU5CXIfX9KZZy/Sg7UP0IJuvygpNLpAOJ10umhdhYjUWyp69LhMwYs?=
 =?us-ascii?Q?WfWUyLenyT46bjK1Lrbp06BX19mttOUI26oqMSiY3cmBmH3uw4ehO+KMm8tE?=
 =?us-ascii?Q?/iqEiBKpx5jaoZmMKYt/sSt2oRYhR2kmiglB0CpYTHuvlfhoFa79W8z5q427?=
 =?us-ascii?Q?AjEw3gpkorCBNNag0iN6XvN9S7KEP6mjkZ4Qx4oWT3c0gHWXYaE5zvSSJaiQ?=
 =?us-ascii?Q?PsNWx/VuSJTd4Fg30u2bpUS5dCbL6sdN5XbVvS13DsCrZzOJfBLc/O/tea93?=
 =?us-ascii?Q?nbMxW8TPri17mWmwqT2SeL0+sabVEXOduzx7/gFf6BCDDQSkP2/Wy8QlTrBw?=
 =?us-ascii?Q?92eCrE6Bbb0+9PVYSjxV43EF/wH0HxZybRk9OPjRHHIb0wAY5tZYa1A10PvL?=
 =?us-ascii?Q?jNQFCR/5U3Pc1S3b3BoO78C+igJf8/kCkPTJQzHGvoPa8JI100SVf5vktuJz?=
 =?us-ascii?Q?tA0LxP03RDaeFz+1hjQiCziolXpeBQMjxMaozSoVJCG++Mrqbqlh4w0rWRqo?=
 =?us-ascii?Q?hcLNLRRMtgRucv6U84YTM30pYNuXRa558MOlIAFC8kORN71wkXJxb/2xxp0V?=
 =?us-ascii?Q?uHOpru2WGu4Fs9jTDlv+BhMLNLFeA+Ng8Uo0NgqozHiXDaSjIWiloqBEIbS7?=
 =?us-ascii?Q?JoG/jktomMQeywhXQW6fsPH0vwy81W6icL6ldGUPjSnVLtfCIyJ3CkEigPkB?=
 =?us-ascii?Q?0m9PwJIMtxOcz4Y6HGF75F1UB/x0hptqosvZqzzf3u/CKjXEmZ6+q1wWUDN9?=
 =?us-ascii?Q?OT+uQWlRwFrqdxFKCvDmv8GrLyAkS+SunYltytKyMAB3O3CY9DktFioX0Lsr?=
 =?us-ascii?Q?J9Uo2hAf7qcEVq5T0D5yuRiBlTBk6ci2paQnHNvId+w+DWL6lSkEeQMdvP7Z?=
 =?us-ascii?Q?+3ds1nS0KSFJPh0nnV1g4/+VLyGzLO17ABb0y4UpBc3fm9bBSUdpurgYfKph?=
 =?us-ascii?Q?jVNzKzuBT6AnHMxw5fekZsB9TqVqpifT1Cjf+F1ZUub7wVlBhTh9f456qLIs?=
 =?us-ascii?Q?bccu9J569W544lKeiHeTsxOWc8Tf279AGX2OEVB9fPcAaGlqp90uW8KH0usP?=
 =?us-ascii?Q?3bhyPaKZO/l8l0zHFyAXekB69xaa9HLapF1Sv6GrUC18NPD37OK3osfmrWp3?=
 =?us-ascii?Q?NqQ3dOdxWiRf0NZUVORq2+jYBSIHcRard6OQ90tE6lJ1y0bSCXAxJVxsYaz5?=
 =?us-ascii?Q?OMWGgR/YzSWWNbA880zcYsgO0lOllhA5g2Qz3P9XBltnicDr/7dsQ/2XYyMo?=
 =?us-ascii?Q?GTMwaMfXT5Co+wL576pEJZDg+CbBpXc/glb0TcGXXDrEmp5rBllnM/Qv5uXV?=
 =?us-ascii?Q?JvtSzj5ZUTCbsF+xV5eJ+gn/LRL55RFPCACvbRcOmDqqRGvZVpG64KH8Plhq?=
 =?us-ascii?Q?G/dPpw=3D=3D?=
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e84f0d6-ac2d-4b32-5e86-08da01b94558
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 10:40:47.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6KL9RKGaEeyCm/0YOO+H5P5eV7J+ZX/iFtz6v3bPy4V725BQMup4FLb1Oqjycc9E8xqypbLeDLF5RIrNHnOfD9d1/5Ll6EJ1QhlrJk4P/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0949
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmc estimated life time values and pre-eol info values were
only read at start-up and were not updated on sysfs read.
Thus, added update of the ext_csd structure on sysfs read of
device_life_time_est_typ_a, device_life_time_est_typ_b and
pre_eol_info.

Signed-off-by: Marc Mattmueller <marc.mattmueller@netmodule.com>
---
 drivers/mmc/core/mmc.c | 87 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 43d1b9b2fa49..d9537c894e33 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -357,6 +357,25 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
 /* Minimum partition switch timeout in milliseconds */
 #define MMC_MIN_PART_SWITCH_TIME	300
 
+/*
+ * Update extended CSD parameters changing during runtime.
+ */
+static int mmc_update_ext_csd_runtime_params(struct mmc_card *card, u8 *ext_csd)
+{
+	int err = 0;
+
+	/* eMMC v5 or later */
+	if (card->ext_csd.rev >= 7) {
+		card->ext_csd.pre_eol_info = ext_csd[EXT_CSD_PRE_EOL_INFO];
+		card->ext_csd.device_life_time_est_typ_a =
+			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A];
+		card->ext_csd.device_life_time_est_typ_b =
+			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B];
+	}
+
+	return err;
+}
+
 /*
  * Decode extended CSD.
  */
@@ -367,6 +386,16 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	struct device_node *np;
 	bool broken_hpi = false;
 
+	/*
+	 * After once having initialized the ext_csd structure, we want to
+	 * update only the changing parts. To check this the revistion is
+	 * taken.
+	 */
+	if (card->ext_csd.rev != 0) {
+		err = mmc_update_ext_csd_runtime_params(card, ext_csd);
+		goto out;
+	}
+
 	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
 	card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
 	if (card->csd.structure == 3) {
@@ -791,10 +820,6 @@ MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);
 MMC_DEV_ATTR(rev, "0x%x\n", card->ext_csd.rev);
-MMC_DEV_ATTR(pre_eol_info, "0x%02x\n", card->ext_csd.pre_eol_info);
-MMC_DEV_ATTR(life_time, "0x%02x 0x%02x\n",
-	card->ext_csd.device_life_time_est_typ_a,
-	card->ext_csd.device_life_time_est_typ_b);
 MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
 MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
 		card->ext_csd.enhanced_area_offset);
@@ -807,6 +832,60 @@ MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
 MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
 MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
 
+static int mmc_update_csd(struct mmc_card *card)
+{
+	int err = 0;
+
+	mmc_claim_host(card->host);
+	err = mmc_read_ext_csd(card);
+	mmc_release_host(card->host);
+	return err;
+}
+
+static ssize_t life_time_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	int err = 0;
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	/* before eMMC v5 */
+	if (card->ext_csd.rev < 7)
+		return sprintf(buf, "%s\n", "-");
+
+	/* eMMC v5 or later */
+	err = mmc_update_csd(card);
+	if (err)
+		return (ssize_t)err;
+
+	return sprintf(buf, "0x%02x 0x%02x\n",
+				card->ext_csd.device_life_time_est_typ_a,
+				card->ext_csd.device_life_time_est_typ_b);
+}
+
+static DEVICE_ATTR_RO(life_time);
+
+static ssize_t pre_eol_info_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	int err = 0;
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	/* before eMMC v5 */
+	if (card->ext_csd.rev < 7)
+		return sprintf(buf, "%s\n", "-");
+
+	/* eMMC v5 or later */
+	err = mmc_update_csd(card);
+	if (err)
+		return (ssize_t)err;
+
+	return sprintf(buf, "0x%02x\n", card->ext_csd.pre_eol_info);
+}
+
+static DEVICE_ATTR_RO(pre_eol_info);
+
 static ssize_t mmc_fwrev_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
-- 
2.20.1

