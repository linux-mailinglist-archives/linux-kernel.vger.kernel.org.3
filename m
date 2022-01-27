Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533E749EC3B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbiA0UHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:07:22 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:8578
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343902AbiA0UHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:07:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llf+gDyCWOIZHdj765edeAA4vG9tjagm+SseFz7bO9r+/Q5PVcoGPx7hiVDhfYc4YX+eNuisrhlw1158GxgRpIgIEJztelHVfa2/hUdfq4i+5Wt1D88xJ53TLatYHaMTrxsITrctHTp3GAwzOMn6g+wR6UYm5QoIbu4NYlO8adboobOPtJpf+lLNPyBP+4wVlP48aWB511PO5wnPR04n84hHShwb0eqgGyMewT3mzJFwcxO8V/mB4WLVtsjMxHR2nsVGtGRVFiSl+d2z1+o8tbGFhsY+8EP4+YVJ+XfSnXK/K+CsA55qD2klDLttsxkwl48NjmLHC4AmWkbZsLnkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgBwSh0kQq7dSSkSCgEhzJKq5a2+wi2LkqjAXYiKt/M=;
 b=XIi7MG/SbNBq5KhUUKX5VhN1mxtH1TrE2dysERDoD09XQ8E5Bkq+ehTsFQ7bIGM/PgYgyjOP0oheHSJmqk+qzpCFbozPDxjLY8kCDKL+Qrp+Jj3XvPrnaFghnrS3mBVB18Kb3P4swczIaqNw6UnIxZs4xJpasq8ma90dCH3kDrm5DMK5+pZf42ygAr7cBeopVxtTc+CcczY3eohVdTS2k9Ym04foLE8nxMsiJ7ATOGD6oyWQRQrlDlwV+QMUinPZH72BHKjzciM/YTAxYReAOfVO4+G9g+qUo95HmXgwylesdShQTW5kuqUv3t0+3/KgzJHB4QnKxtiKVW8P6sYbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgBwSh0kQq7dSSkSCgEhzJKq5a2+wi2LkqjAXYiKt/M=;
 b=ZzKJk+e5MdHQhyHbk3fBpALA47vqqfLk1rCmNat7NjzVvu6sK0+WxKO3AGfA3X8MRKjZdHPVPrTjGBCfALexmnOHLOWE8MU04CaQHGelJ6viH4TiJ6pd+BUsAzGpbhgYJqJUb4zHaVgHFgHQCfvxGrt3QOrOe+RLEhS3E4fREKtlvvAB8OhibC2QuKUErPDaVoneFPVKBzS1yQOr1vK7h4fFuQj/vTSnuiMhYEhgzSP7x2z41dZueQxlEKSohxUUgQeMjH1AsJJbjmMpwOO1TNgIQDQsOiK2WgomJgsqeBdlNiJDnHweueZ8npT81fA09FkZKe1HGoQUAAudNtJK9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB3747.eurprd03.prod.outlook.com (2603:10a6:208:4f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 27 Jan
 2022 20:06:55 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 20:06:55 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz property for ACPI
Date:   Thu, 27 Jan 2022 15:06:34 -0500
Message-Id: <20220127200636.1456175-6-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127200636.1456175-1-sean.anderson@seco.com>
References: <20220127200636.1456175-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:208:a8::43) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99d50b98-d9b6-48fe-b3e5-08d9e1d09125
X-MS-TrafficTypeDiagnostic: AM0PR03MB3747:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB3747FB5439A45E2052CC6BC496219@AM0PR03MB3747.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dspQIfBrcZ0gBLHUVNBkjCwK9+B5iTJRKZr2y1H1PXwFHayDa52BqXdvzdcgYALQ2BdWMajA+qgr/WOYDTt1IDpmRie3VRROXhqi3Pch76mKLzu8BxOxY9d1SMDsv2ge1f0wzk89qJUy+kPzXU8JzxLaFyVr8ACMSBG0sqOWh2nphZyBbMLPq8seZ6bZnusouo8SB7DQf+DmtntHYo+/h91df1PeOH16/qoB239tus8SOkwOjb4ERKhALtCvWAjwFSuMxYgWS/6KDIY2X0m7ib9HYIHiBpq1AUaQq3rdhwkYQQmZXj2SSBXrBMSqlayfxiap1h3XHXd3Ksie5K1s79J9bJd5H7kPvOrWEx2iizd53uGWa46S22kVmrSpqui+u0cHrq6AyI808bVUkwb+Ud2D7m9MSCAnA5FQsp3odoDizZQZUZrF1QaMmBHbMtNKnJWaWuZEG69I138MOPQnlAM5I3stuLn6PCjP+XFVUffo51cnqw/XUK8zinMVUoE/fmGbLjhMTBzY2h/K7E2VUfQbYzthrPexcMfqEcZGxWemaUuOODdOCeMFYNNMon83dYcm3qVkO2YkKpCQDPtOtG/5tuwM8hm4zi4zEzzgiTao11lz02N7stbqE8F/a+pINwaWZgiUlE8lYcCc7FePdZgLzYNl0ZPBpihALKkvjX4PYKCTHtuRg93RnzDHcZrtF776isZdrSae66bmYg0Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(36756003)(52116002)(6666004)(6512007)(6506007)(107886003)(2616005)(186003)(26005)(1076003)(5660300002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(2906002)(44832011)(54906003)(86362001)(6486002)(316002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mZgAfBxBiDZxwFaMqTz1YSIg51R5P/SXNhZPsS35CkCks+l1KLnjKePC/MAy?=
 =?us-ascii?Q?0RvPfF7HcajHUcRMdQ8h9j3bq1zNDdMRmAnpNy+0zeSgokjZ8J0V+wdrsJpt?=
 =?us-ascii?Q?sVHsPd1TneV5qThQ7Jx1J5kFKGxhBCIhd8zEaB8NtfSH4ZylHZaBEyvQcdBR?=
 =?us-ascii?Q?1jEEa7Kia9ZHtAkpIX72wVjozzOa71cYFfBdKfhqz4mNDIs6JUn/6P2Fl8EY?=
 =?us-ascii?Q?/h3mWSgNQHYt7hFFa/wbLps8KnUGpYCV6mj07F0ULNvkMZi5rbFfDc7+6qnW?=
 =?us-ascii?Q?oyKJHUx3SOO/hzXZmVzyFuq8X+aVDJiFkwFv0yns6Qvcatq925SdaramsaZG?=
 =?us-ascii?Q?vrv4qsN1pOyK8t8VYPyeXgRF2FSt6n4EdP5FMOvJr+4ze5E+z9fBHUw9Wa5D?=
 =?us-ascii?Q?8YpvW5cQNCLR1238C84hLfC87Zi+MzGHuCUb7xGv9c+p7mVD28i4KCdMZ3Bk?=
 =?us-ascii?Q?ARMzM2QMO2pv8twrfWOQB8udxxR/DBTvcw3t9M5dBakeov1XQqMocep+EqTw?=
 =?us-ascii?Q?a72mRMQmo7N30U/YHwwoGC4zXZs9RF5OHoalMyyNShx/EoZxGLZqY/GOsSFx?=
 =?us-ascii?Q?a/sfTym5CoNpsEdCtllyb4KenUcUhSTNTUCzEffPTN4F8Q4U6Ka0N9uccxaY?=
 =?us-ascii?Q?8+QtQ6TSl3kEPi3JeZcWhDYQHua6s4OETrrAfeIG3S0gSso2MT+uE8AnNgnn?=
 =?us-ascii?Q?bQFB3yzSO8PJlAjxEC1TdKNu0lgzgNxoUUOWXjoiXVczoL3edAy5WRCxgiLl?=
 =?us-ascii?Q?DJq7y5w5qXuGlU1xNfJbbhtY7V06v5qa9Ug+0PmkyNzVCr3SgIZ47hEUAxDX?=
 =?us-ascii?Q?Zb+XVQzMPdgmEfot4FWenuaeI7VyrZmyGpX/Lge++g4YR6tmEzerw0WnfSqr?=
 =?us-ascii?Q?LMYW9ux6aYTOEzQg/l5ExxskHzC59+WwYpFCzIPrzQIhPquoiE4THbFA4kKT?=
 =?us-ascii?Q?ROHZOXrDdM2z94lI13z/LWe2vE01dDxxqWYyyAtf+kAt5p0BfjBi3d9CU0kv?=
 =?us-ascii?Q?I8UzUhs6dpYobn2dlmc/TkhXLZCCXr73tbEWinHaREi98wYv2mpnwnZC5W33?=
 =?us-ascii?Q?Xl3eRxRa1z+WdtUKZLlDTC7G2NnFeyaZbKfJD8L97NrAb8HZKI9pC5araoJz?=
 =?us-ascii?Q?saw2rqJM3TiL5iBdn6Smz1EtP4urh8WMewbu8lEoU7eFKcspYinZRJlmsQtF?=
 =?us-ascii?Q?uMtTUELsVmSfgdYjMggO7yjL99r7Fb9Dgr8L5Fuh1l2WUQqq0STpm1v6BeIw?=
 =?us-ascii?Q?XVvFdNfbU0mr+4oKA3RC5ts5PrI2miXhqazFMnn5fAL8Rd3kV55v6jOB5xeL?=
 =?us-ascii?Q?DZudkljIgo34N/Q13F0tyIU0duys2a2CNnOhrne0U0MYDKz6/dMWCKMQwNNQ?=
 =?us-ascii?Q?SUsjjYvFXZN8h4rsfTC+eRulX+dKLsthjaWEHmZS7uTHuOx4mALYXLPXrNDj?=
 =?us-ascii?Q?zk9H9Hifu2VYS7LWUAhpxmuANxf3i73XJezQ/5zwe7jqqAKqsbG5WlkJzfLi?=
 =?us-ascii?Q?+n9a2BaRHZF9CaF3rCm93Q/6tP5LAFkEPClKNP6DBQ1RCkURXW9cQiwYVAUT?=
 =?us-ascii?Q?ESAqkqnOTPjwffIrS8JejlEZFMhjkM2gVGRD5St1+aay9iF+FNFqt8rD+4jm?=
 =?us-ascii?Q?AViQFKP681YVKnUzOjvKxP8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d50b98-d9b6-48fe-b3e5-08d9e1d09125
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:06:55.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MJVvwmRkoryj2stIr66PPEFCdjUPMU5807mCr7gvcGabCjEgZ2U6a4WKABj5Kk8FWjp5LAqSwLhK4c0+IeLZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3747
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property allows setting the reference clock frequency properly for
ACPI-based systems. It is not documented under dt-bindings, since it is
not intended for use on DT-based systems. DT-based systems should use
the clocks property instead.

Frequency is preferred over period since it has greater precision when
used in calculations.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v2)

Changes in v2:
- New

 drivers/usb/dwc3/core.c | 6 ++++--
 drivers/usb/dwc3/core.h | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 18adddfba3da..c1b045121672 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -353,8 +353,8 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	unsigned long rate;
 	u32 reg;
 
-	if (dwc->ref_clk) {
-		rate = clk_get_rate(dwc->ref_clk);
+	if (dwc->ref_clk || dwc->ref_clk_freq) {
+		rate = clk_get_rate(dwc->ref_clk) ?: dwc->ref_clk_freq;
 		if (!rate)
 			return;
 		period = NSEC_PER_SEC / rate;
@@ -1497,6 +1497,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				 &dwc->fladj);
 	device_property_read_u32(dev, "snps,ref-clock-period-ns",
 				 &dwc->ref_clk_per);
+	device_property_read_u32(dev, "snps,ref-clock-frequency-hz",
+				 &dwc->ref_clk_freq);
 
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eb9c1efced05..00a792459fec 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -988,7 +988,8 @@ struct dwc3_scratchpad_array {
  * @regs: base address for our registers
  * @regs_size: address space size
  * @fladj: frame length adjustment
- * @ref_clk_per: reference clock period configuration
+ * @ref_clk_per: reference clock period; deprecated in favor of @ref_clk_freq
+ * @ref_clk_freq: reference clock frequency to use if @ref_clk is missing
  * @irq_gadget: peripheral controller's IRQ number
  * @otg_irq: IRQ number for OTG IRQs
  * @current_otg_role: current role of operation while using the OTG block
@@ -1171,6 +1172,7 @@ struct dwc3 {
 
 	u32			fladj;
 	u32			ref_clk_per;
+	u32			ref_clk_freq;
 	u32			irq_gadget;
 	u32			otg_irq;
 	u32			current_otg_role;
-- 
2.25.1

