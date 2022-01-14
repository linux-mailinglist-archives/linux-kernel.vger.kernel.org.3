Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1A48F31A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiANXjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:39:36 -0500
Received: from mail-am6eur05on2070.outbound.protection.outlook.com ([40.107.22.70]:56193
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230152AbiANXj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:39:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv7CTnUBj3XJ4SYxiLR4/ElPZNzNZnlNWFsSQbpN48SJleiGUs9g7TCHP4vLgxsGQOrJL4YMO1huzzdtrMm9HMtR4a0KliVUS/nB0y3lwpu8FkcOUUwOPUfHfIkr1kJUZDx88dY2hlNhZnQlc2lE5V2TM6cbMJmAk8tILpTkW5uW/Kp+m+M8GEcRiRJkhZtIX63UkrYyO8QOBWQ9ptdJDN6/ZL899ZCplh7wbVV4CBap6Tl0STUrlFIpOpUt4G+mikoK9cDvyUtCIZJlq5heKGMADIbJz6zjD4WVLbbV5Vo+gAJ8sSDmSjTubogWnp3ysOisSSW38hGvsY+H09+F6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV/fheH5CwCAyZ5SIj6Gl7gtdFwXX7BQIcP5gZ9Kb/U=;
 b=OE5LteTM5qNt0e2Co0pMvz4AySskSzHnxw/G7yMkhsbwHOJ3B3MX7hutB1/E9mpQC0zXnY8yuS7VgFr36gW9PzguSbVPeYskW3ajYK1Jyk3DtBzvGkXQ+EO7rsGGA10qMwJjvFZ1xVQdH2Pj2K8PXf8NSse8PG7l7/6CXTL0o+QRd55b+WqZ6nPEf9Yyok9K4Jq8dWaFBGz/08jl9qlmE60ZdX9Nl2fRiTFtd7ElAK31CR0W30lHL43uhyAlVZcJ6zWtD4uKkqSMYg3+aARhHMNNh1Kj8OCKRjoSZ4duq1p68ebXifi5L7+9VLBPxqk1qRXJ53Cd/5XWpIgJq5uq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV/fheH5CwCAyZ5SIj6Gl7gtdFwXX7BQIcP5gZ9Kb/U=;
 b=DEhYWKdlBXoH1/7EXYq9sZawCpLSLajhn3Tnw4Ifoc54t9cjlbf/84YdVn5XexW+xTFC5/lrBDTKZ4fi840LIWfGWAq/EEZoI0nQ2SKgDRb+MsOd/gwcHe4hQi7LHno5bEfElrUbNh6eEmWso0g4DwWHgdlrZcyr8IcjVTY8RqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by VI1PR03MB4336.eurprd03.prod.outlook.com (2603:10a6:803:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 23:39:26 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 23:39:26 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 4/6] usb: dwc3: Handle fractional reference clocks
Date:   Fri, 14 Jan 2022 18:39:02 -0500
Message-Id: <20220114233904.907918-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114233904.907918-1-sean.anderson@seco.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7a03a77-f35d-411c-ec8b-08d9d7b719be
X-MS-TrafficTypeDiagnostic: VI1PR03MB4336:EE_
X-Microsoft-Antispam-PRVS: <VI1PR03MB4336A4C6E9CD74C4FEB910E496549@VI1PR03MB4336.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vHRMOHIh73Bu9AXwjTTkYm3wkmBswyJb/LCvkhY6D0Qc23smh2vIzA1pj4S/wsGMuOBezlPxobHoc99swY+sTS9GG1CCilAAHr5rShspAY4ffoolSKNO1jjtHL7C62Xmf7Vi6vPvPBVKnYtBdYEp+RK6tY6OwknTXmY0MSVUt8ixF4E0e9+bA1S/Z9SrU89zD62nWbe4wf99F0AfqO9wKopxKt4UBnhKZzCLk/M1P+x2LsLRTrRCIN1ha9F6NcnCiDQ59kS5qCV1inSdK6voRupW50ffEVTCmOLB5yh8HvAzM3XgTHzlJ5az4L4xWsqDjQ9rGqHRMxJqO23ElrM62kwwNwuC+k825tP+6qRgvcnl1Slv27zmdhp5znEdSZuEozyylyZYmg7buFttmQI8ojpR4C9OzhRHToH32+FBzpqlgdpU8WAsekxGsT1cCa/DCdb/b5PuB4b7cMIx29wv7QnZ2NqBajaNLs79rITv3HKw1Of2nF/Uk/nAPi/CAdBkzYw0JP5NhwWYbQ6fwi9Ls4tfhzljxSOEwVKhz5BpIBVsAy1kHpaQWitXZGxmKAGWtNSdfqgQFXm6HMomKJSSdXZg790Zc3d02MV6nuWJ9kitzTSGQf+qrrTlY5eCd2zxwbNJL5O7VDffX20mGkE46w2njYRt8CpDKpB4zRMwkEONYdzL8DFuqNew18ASeAPmsFdRBClZ8tTnI8SPzS7oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(8676002)(6486002)(44832011)(54906003)(83380400001)(38350700002)(66476007)(52116002)(2616005)(66946007)(6506007)(86362001)(107886003)(38100700002)(186003)(6666004)(2906002)(36756003)(5660300002)(316002)(1076003)(508600001)(26005)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GdPwQB/oU8gcIgn7E/h4Xw5NU56C6CtAJ0Fs9uoFecx80I7afnuTmRdwsz3a?=
 =?us-ascii?Q?f3E9J/SHPhABKThEzXZX1zIG8IQYs7TkVPjbbI7tgYWfpB6sLdx2W2Cqk/Z/?=
 =?us-ascii?Q?vR4LW1IoMc4ZGH9n4xMttTq1pdDNqx4pkXZ6uIMUzauN5e6+rqjDrolVgysn?=
 =?us-ascii?Q?yoJ/cBaUwye4ClVHIsCNZy/qmpBX8Rvo3DAYdk1ChLQJpxvtGkY5sRkBmuzK?=
 =?us-ascii?Q?lDhGjRuQKZTCsat+6DtSq+m50UF8o93na6/JHau6/Y1+jwtzMpFr9A32y8Ub?=
 =?us-ascii?Q?S/7mGlGO/wGaFMle1BIeIAR3VrTMTqF3/LntxgQJZ5buw5ISwfmrvPfpd5qE?=
 =?us-ascii?Q?RyNn68n6WKIuINh0MXnpxPU5MlSomfGRN9CGO+2HAOtZToOXarCXU56Js1fw?=
 =?us-ascii?Q?dDHjsP+pBXMfNTxjvIQfRApSsR4/q99rNfdvg9jyF9QqNfJ3WX5MS47EnWWb?=
 =?us-ascii?Q?T7o6FMaLe61yy94CCgd55rXKDyJTz2MjOJcmCXdPn6IbfKG+cTLj0pQx1F/e?=
 =?us-ascii?Q?To9e8qNY8+IEvZzBUyTkmz/ol8dDedneEuveUj+mB0NYCsDaoCiXTZ2IHqzy?=
 =?us-ascii?Q?2gWCBuNX2YqRJ6OZw8AmDBCvio1qqxkype/spSQQtyoykbc1LRUKocYeSrL5?=
 =?us-ascii?Q?nATz9PXQwhSjVf+40kJBmHncR/8F+xhoVDoonz4JS+ZxZpBei+StT4KmaP3u?=
 =?us-ascii?Q?gGbT8doK2LD2hs+OhyK5Z3afx7NQ7BlQOgT7lVVfPMSWXTWdKgidWfV0S2ua?=
 =?us-ascii?Q?85rtPMSOvUHE4m9EGASwyamtZ4nNjcC3p2Qz/92mauN/amKHlOb0fqxghlGf?=
 =?us-ascii?Q?/iYFAcq0IdsM7O/L4hjpuCNJtjDkzmmjUo2Y8NqGFkmhMf/iFWZYNOPYZaeH?=
 =?us-ascii?Q?9uaz1kBV7XFBAwDoJy5Lk+VwUzwJozfgHMVNklQbEiUDeZDw2v/OSQzUIhb1?=
 =?us-ascii?Q?lLfz4+Li3t7WdG7xiDkkSyYhk0aadALGhntECokK62cAPdQ6LmDdCZum23ok?=
 =?us-ascii?Q?Z0oHTz1TFezY5He3uTlAr+kNXKkB9nwrjYthBEMroF5Zi2Z8W6LVpPJdeilG?=
 =?us-ascii?Q?53cMBEAeyZIjQEzpFRwy2f2ALWvBblH159Kev2q5tCU+fpWwbjE8wUuI/TCr?=
 =?us-ascii?Q?NEwAzKmOeLM25d/pdcSHTbxr9sSAeYkCl8+sxscemNsJiO9xyfTj41jd1pAa?=
 =?us-ascii?Q?YOtLOIsf+nNId/PDJUatH4hM3IlInzZRBMgWChd+VbscpbH+UEGIhR7aOJF1?=
 =?us-ascii?Q?TqSbj/SOQYeHd2Q27mRG2Yomzsgg3tMqtY+G4z5ejYMDPeO88fkrGNsqIl/q?=
 =?us-ascii?Q?hnRzhts7FrWkcDQaTaeqrUCJd0Y3gwHJ/a7hCP80GFeKril1MGNIZjaQVW8b?=
 =?us-ascii?Q?HK3H/lhya5AN6mNMmrBzTpgEFkm57+O55J9Jf4+0BLvVy33VuzkgFxYg+bso?=
 =?us-ascii?Q?1Xc1+baOZBbmV4piYJ4lPsaatStbZo1LU60dw0/wEYdv7miN5kvfd8CTG7Vz?=
 =?us-ascii?Q?e6sVhZ5SGMmnwiG1U9EeQTfFBgvF9YwK4t1l6FubhnLE9TMc5i1Pj4Ry7FYP?=
 =?us-ascii?Q?22Lc90+Nn24PnpEpeVsfTyzXNTnjzIfPbibmwXf5bIPIJQJuvdM7dkheV2Ar?=
 =?us-ascii?Q?fxVQgb6VQiU5jGukTgR2fns=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a03a77-f35d-411c-ec8b-08d9d7b719be
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 23:39:26.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cFf9+CBM4d34WH7PGs45aR0j4l8lKlcoY29CxmJb8NUywxbvYf1XrnRBfsE6OL+MrAcqWNamhPIItEJHZqQFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GUCTL.REFCLKPER can only account for clock frequencies with integer
periods. To address this, program REFCLK_FLADJ with the relative error
caused by period truncation. The formula given in the register reference
has been rearranged to allow calculation based on rate (instead of
period), and to allow for fixed-point arithmetic.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/usb/dwc3/core.c | 25 +++++++++++++++++++++++--
 drivers/usb/dwc3/core.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 5214daceda86..48bb3e42cdd0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -348,7 +348,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
 	u32 reg;
-	unsigned long rate, period;
+	unsigned long fladj, rate, period;
 
 	if (dwc->ref_clk) {
 		rate = clk_get_rate(dwc->ref_clk);
@@ -357,16 +357,37 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 		period = NSEC_PER_SEC / rate;
 	} else if (dwc->ref_clk_per) {
 		period = dwc->ref_clk_per;
+		rate = NSEC_PER_SEC / period;
 	} else {
 		return;
 	}
 
+	/*
+	 * The calculation below is
+	 *
+	 * 125000 * (NSEC_PER_SEC / (rate * period) - 1)
+	 *
+	 * but rearranged for fixed-point arithmetic.
+	 *
+	 * Note that rate * period ~= NSEC_PER_SECOND, minus the number of
+	 * nanoseconds of error caused by the truncation which happened during
+	 * the division when calculating rate or period (whichever one was
+	 * derived from the other). We first calculate the relative error, then
+	 * scale it to units of 0.08%.
+	 */
+	fladj = div64_u64(125000ULL * NSEC_PER_SEC, (u64)rate * period);
+	fladj -= 125000;
+
 	reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
 	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
 	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
 	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-}
 
+	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
+	reg &= ~DWC3_GFLADJ_REFCLK_FLADJ_MASK;
+	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj);
+	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
+}
 
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 32dfcf3a83d5..50c094af131d 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -388,6 +388,7 @@
 /* Global Frame Length Adjustment Register */
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
+#define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
 
 /* Global User Control Register*/
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
-- 
2.25.1

