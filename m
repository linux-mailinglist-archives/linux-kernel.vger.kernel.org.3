Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6A49EC39
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343835AbiA0UHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:07:16 -0500
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:55685
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343771AbiA0UHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:07:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/dH1L7M5oHWFt2np+IwFAdbr8HAEJ9YZznAChWhzkOCz12YPoyPC84aUIbqR4res68Jt3DgS+1sObWsXLlqGwHPgsu+fWKWhNqu54eI9TgIwhGCGKQNzlQuyqrW6QQiPmaJaHj5pC27aLc6XLmrl2xXnUYwcWOQrKO63vB7wk9ATm8sakP2cP8nrjS/bYSoD7TbJsuo2H+NxjjKw6WHveOSiuvP+35DwA/sD3KYpvItJu7eISra5FsNH00X3dat7qdRC+tGETS79uVAgge1Tq+qPFJbHzbOT7MZpqwHEKaEqh3OQFGBvPBXZKVltmqKGHq2rqO64+UnrHP0rWk2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iTbNcgMHKQDn2UQ5Q4s8qZrx9GE3+86V4LoAq9OCT8=;
 b=EcR4e+HTN3XD7nK8XvN0+dCvAgrkLnOUwTZbQniHr850JsJneqnEs6KkfY6D1tK8zuch+IZ/0+DdHl5xwp8OGI9kqAPbWtyg28PBZtn5+USXFWImOx0GK6MBmC8no2ouV6ZOihEj+0bAHPT2cvbiLT4SXxXhdGoHte7jVF6D9YlSZ0+EyJWjPTiMyCTkKgZ/sWhEVfLeHwQ9sKq3KM/Xxy4Z74SJrlq9CKINKTF1fpPd5+/uz4gNHGB3Z7dNhaQ34WmLFLO0X0rV4K952rHKYGg+gJdoKVsq4Oxf/yrq6T/son59mj/LWRdq9ztZxLmMhCln02kAHbn3GN5g0Gv9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iTbNcgMHKQDn2UQ5Q4s8qZrx9GE3+86V4LoAq9OCT8=;
 b=ofWqgLpIm5IBi4sdAlHuU6SlRpRFsSy+mBr7pbzTe7PZZIBqxklSSWv9O0HcvtbR6fiowjE+WUI1qoUgljZLeNHzXIkbWHAiIqQ+b0XpT4a1fvTA+WeHkDaE7k+9ZnpuLhRD0eWGBdSsDRw1097gqyG+F0odhSIRP2xaPPabPS/S/sp4Bj+9aXKVjoIq7P5ep2jD98Lhn8EzHMgQFTDsshTA7hyhp0EHvl1sbctWEgQoxDVBoA1fGmmsGQWgnGjBsgFX1Gq90OYtc9n6uHHGC5XQksI7xRmxrGQaPUmqID6Oavm72Xo+BDizf9V7iQGok800yzhAMX+bgm5K6NIPLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by PA4PR03MB8158.eurprd03.prod.outlook.com (2603:10a6:102:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Thu, 27 Jan
 2022 20:06:59 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 20:06:59 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 7/7] arm64: dts: ipq6018: Use reference clock to set dwc3 period
Date:   Thu, 27 Jan 2022 15:06:36 -0500
Message-Id: <20220127200636.1456175-8-sean.anderson@seco.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0bb5a1d-bfd0-43a7-2ca6-08d9e1d09370
X-MS-TrafficTypeDiagnostic: PA4PR03MB8158:EE_
X-Microsoft-Antispam-PRVS: <PA4PR03MB815899999552346995EA33BE96219@PA4PR03MB8158.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohq+/+qv55S2m2TaDdx+ErPAjnC9Lf8Jxq9QH6MLqNsX66V0KAS6AfCWVJ6A5/S2FVyZ8FxMHrKTS4VdDCqJtbMCE5M9aX9/oFXXR4YCAlejWiONGUN6by7GgtinYTix+YMzDXrPm9I5fUZxQAlKkimQOWHctNIMOOOgGalmlm3T9RzMF8xQeJycs+A6n1wABI+hEHzVLVlrzQfIvm+FYEzApqmzrupnVBqM3TTW3qtGHQPtdF52MvGqVFY+3znR+ovb1gBfl/BSks4veA5tRzd8b/kMiMGa1uIN5oWGiYEbmc7MTxkLAUj1UzEJN8z5tg+5tnVSIOu9btFSr9Z74zBehamE3lH3KNEovHk29Tff5Gz5um9z6rCfRda+v8fMocNkEQt/GiksAKP8vKj9jF4D8PXYD/ZmSWgJf0Y6mwpA88z2/2POn+rtmEiSP5B7eoD8pLu9BOwaPYI7ZQB3lPpTBNlt/H+xqiaNsY8iFJryBCOW7ty7Mx6r25UhE73NpIc44CAFPyamvvihBe11lujB8WTH8IztH1QOOVGMTLj8SRxu598wq1Vm+qwCUTX4ZUGb2lygTqL0DfC1X7SCgHxNYhP2t/C8GfmFYzQVKFkzRu/GLKHednyuGHyCHMyRBDg7Yi5aiZBRM5S0tT1vxrpe/qFtO+dRUtoPKL+JlSU+L9/CE1Eng7SDGtPMgZ/HpC1EKW2zu8IbVsyKZk4GXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(36756003)(6512007)(86362001)(2906002)(52116002)(8676002)(8936002)(6666004)(6506007)(83380400001)(66556008)(66946007)(66476007)(44832011)(508600001)(2616005)(316002)(6486002)(4326008)(38100700002)(1076003)(38350700002)(26005)(7416002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V5WJRXL12av9C2EtNvlRZqYapFR9OwNU+dwr99XSvXkc/lazya6ZcOGCT2p/?=
 =?us-ascii?Q?Y8/c7SoYDnjiaVCun5dtSHB+9HncvlItMel6MQN/Bm/28QyR9PRjJuzIC3ra?=
 =?us-ascii?Q?73WlGVA/ILwf5R02paSxdcDRt2zQ8CnGSn6/UgJlOPkD5gG4z3HNmsSw0I0s?=
 =?us-ascii?Q?hzcmQcQeunl9dlYwwSPOU2dTyycL9e+II9mv6+GgvOzxQPU45aYiDypo9Rhq?=
 =?us-ascii?Q?RTcD5dDdpdawZYN64900rH9Y7fo5tQUMbStHzuUvIURxLK+TPMUaE2epYZi5?=
 =?us-ascii?Q?owxPBtbxdvdyBUYhpw5OFqLF4jDSB/8i0535fTzE+gHWTR8GjD5taBC/nHq/?=
 =?us-ascii?Q?GdLKTCV7N/eo4GNDLPUrh1jKn9b/O9XbmTuRL8Gjgey+Gyuay/glC4OBF+25?=
 =?us-ascii?Q?Nj4EFv7Cl2s/Dybnyq0Fj9JXeiTGgnwcFZCIPX4PT7s+JHQY4UF21ylSmYJv?=
 =?us-ascii?Q?wCrb9iu1vehyE9MLlqie++zD0K8tJXK7pPXzhCre7BFDCXlTinqlyhRJMZ9c?=
 =?us-ascii?Q?wvBVXbvm1YDmnEQYnqHAcL4AQMF3WFZYWpfHivdH45iZv0BJX+d95uhiefl/?=
 =?us-ascii?Q?KSA7wPmUk8PAF2atgCZRCSsfCKaJWw4cGsVXx/UEHLELOjm+J07KmaJDO4jQ?=
 =?us-ascii?Q?Nwj8y1iMt0ZWC0Fsy+zgspb/mgFVSGZhnRKBPTI7RUVOeMIW3vu0TkTR4u5D?=
 =?us-ascii?Q?HLS1eEmS0ttQsFoYLPhvGYMeB0uUeJE5/z7JCuNYICPl5w+T+PzllqAaXb3o?=
 =?us-ascii?Q?rzxFOG7jH18gRJZBikL21+WMXaZDGANyiGp6oMXVX25tH964NW9L/EHiBihF?=
 =?us-ascii?Q?E/Xd8CDbdKoczRqFCiuH0TZgmMzHFLmfkjtKn+cemwkAbXAS+eYLEg2lHQVP?=
 =?us-ascii?Q?fQM+uYq42BK+KbPZmjwuco7LIa0NmkgFszc/UrLXKaNVBZRto0N/5VA0YfeA?=
 =?us-ascii?Q?66PWNcS8bZtVn1S23F/GF/PGFA8xulCywWhfqxWq/mIK+Zt3CnfgHKOpNrEs?=
 =?us-ascii?Q?FBoNkoZyIH9dHfI4BvOaT1EBEIZ+gxL770yc2y2rIeptQzYdcTg0H0CEbUGp?=
 =?us-ascii?Q?x4nq2FZBUo1e+8PSXCJU6pqvrMS7dJML6vvM9q9BVudwduVJKvZ/2Uu1Fl0y?=
 =?us-ascii?Q?zj5MwbY73G0VJUEMqiIfmfVb/WrjUPkWs0D0bReFMuoVW4qDOLwARHrQv0Hx?=
 =?us-ascii?Q?xIT6xWKmY1y7KDHDNcqYLy2swAagxVhiNHduENRzbFNZ4tXXGDd1sI8LwCF1?=
 =?us-ascii?Q?geXIvvGavbsQHEWzFxS1DdqxTla2TxF0Hh3euCQWQ7oPOpCZ0oz2DGF9q1Hx?=
 =?us-ascii?Q?3fBQ0WwByrbnPCWQvVKe/U5WFn596cIzODtN3v21t2fcpVlNOT6TxmB/j9Hm?=
 =?us-ascii?Q?ewdAuabnTlouXdk50nV5307ea9kfsXopX2eKZ8lPOLWSzZ2fecfLTJRvJ957?=
 =?us-ascii?Q?0U/dNnEPbVT6DcnVigJGU4BmG4STC0XizUcEF8rr2W0ho5hscEVte+Au5ntl?=
 =?us-ascii?Q?1XJn+adY57+TrEZ/MDD2+IBOsQEpt3jXGU0VCIwYS8rbiHNDDpJULBpmNKIp?=
 =?us-ascii?Q?smsD3OKc5mBMTMA3c8TQr1Hwy7ph99VQ4mscvpFA2Vxa96x+TJXzZ1jzw/q0?=
 =?us-ascii?Q?bS6eHUrKNrKpFUKdTL5c0hI=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bb5a1d-bfd0-43a7-2ca6-08d9e1d09370
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:06:59.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSl/+SIB4QP5kL9VptxEG1rZuT6a/DV4TT2eTxhnpUIkgxOcp5CvRh9rpQ8SSqWb+JQ8/i3a4zI7V+jdV5ioTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB8158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of manually setting snps,ref-clock-period-ns, we can let the
driver calculate it automatically from the "ref" clock. I haven't
reviewed this board's schematics, so please let me know if this is the
wrong 24MHz clock to use.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 66ec5615651d..a614b9f73e2c 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -743,12 +743,13 @@ dwc_0: usb@8A00000 {
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_0>, <&usb0_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
+				clocks = <&xo>;
+				clock-names = "ref";
 				tx-fifo-resize;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_u3_susphy_quirk;
-				snps,ref-clock-period-ns = <0x32>;
 				dr_mode = "host";
 			};
 		};
-- 
2.25.1

