Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C248F321
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiANXjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:39:49 -0500
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:11872
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230186AbiANXjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:39:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8v7oaaRZTr/RPp4drhO5vqBaN2iYaLOykCUUeBmnc8bV+roO1IQSac5D+BYCyHSPYilwmBRGVYbxYhcYv6nsJs9j050uaQaOntaop7B1jVJv9DqwEB3a+RE6KDxwuKvJUwfvJzFU490TfM7ibSoNm/JvhUrqYs5RCH06xnQ5jifLkYFRwJ5TFHtY6meu1PT6NOOFkUZHijLe/yQ2sRfRgPubDSkLZFIxem7pU3Ia39+p1N+VT4+LUimPoD1FO8UvIBG2zzU/A20J/iKBV/pHSpu0X9wqDY840zsx9ziRgGOYaSpwOSEFQ6zDAcU+CSSBGHNMQ/AryWGAVt7cAHdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbewwoyQ4DCRu+Tclw2otCY4m5qz33JtZQJc5pz93yk=;
 b=K4k6ms3jYWoiq4tFYjWlU+WrTFyfpIs8Z7OZ4UWi3DQmWM9XvZQDiBSyb+pBW/ceJiyOkj7YlsBKKMJ+O8XHXIVvHTLA7WNEdXXvOUt8gXZpj/mQU163b4xFq4Iwj4ImJEj7EmZSotBiGa8dgHSfrYN+F93kyX17HhJobqyi7Gy02haFn8vNDt8X7mWvYVRmntcU0gNxrppuK1kM9iOL20QCTeJpBv1T3K1R36gCJz52g1zRaKGpadgkl52PHz1cE7bmgfNpWq4vBFrSwWo46QYGlXHuwQF3ri7leyL9IrRJKVJ+e+c59yFWs1YcOmEwGGJa1q2pqmVuRtHRYKntRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbewwoyQ4DCRu+Tclw2otCY4m5qz33JtZQJc5pz93yk=;
 b=hg0yMAWTD4c9nAwpMHVDnqRHjNpDjRHYNtFvqWUBp6Vk9hYV6s7u7XsyDHbG4Ns1CNbSfCANVHo4Ky1ptv4ZTfJ0vaftzE3Jnge3XlPhDTsY+pL850mFhZ2V1tGdtCodGRGCUh7WuzlfN31kaACBOhN594nWJ7opg3KhedY6PZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by VI1PR03MB4336.eurprd03.prod.outlook.com (2603:10a6:803:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 23:39:44 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 23:39:44 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: ipq6018: Use reference clock to set dwc3 period
Date:   Fri, 14 Jan 2022 18:39:04 -0500
Message-Id: <20220114233904.907918-7-sean.anderson@seco.com>
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
X-MS-Office365-Filtering-Correlation-Id: b95f44f8-ca17-41fd-7714-08d9d7b7249f
X-MS-TrafficTypeDiagnostic: VI1PR03MB4336:EE_
X-Microsoft-Antispam-PRVS: <VI1PR03MB43360EE263B4B721ABD86FFB96549@VI1PR03MB4336.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 48lEyK/i5xmXQxvSBX+92y7XpX8sWD3OsFNcXgpMmICcAtNiPLwvbpPmND0JkUgg1HLgOqPPUasSzmzMP/I8prfhckYB5OaDh5ScODL13mNgaNNeb/E2jdccoD8U+ojQq2tY7XpGz9YWDHXiRnDeGwXOeaiJetvRcVIguTpUkbklVzbZClP34Ixnl55qsrCTIJE6mr+8SNrlEhpTnZF336ymcj93kSER+3TlMJVohSsLV/1NHOYj+QbvDhScY10/yNGP566MVNBfl5+rjyWJdm1YXCtuUEWrJ31d8COd6T7jTu54oI3wZIPNTxfSAmPpVg1B7buI/rucPG/fv10NgLP3QA2K4bnQh4jP7Z1zPeIdGWImLgcv+kdNpRc1uD7sH0vsMbW83RW0jqpr4FY1SNHt69ZiubC4jpyVbfp5WX8euI5j7QaFOuHTDlt/UgV7sexOTNptOTXj4+UVg/Z6N2ME+jfp9aDQuIsK7t+GhZYVL7yzCosoY4OLbRvL+pf79KV8DyatrCiTA7Nx0wfzoUwGnH+fLDdapHsLexjbhQRSa63GGSi0UPxMdslB+TJFTBo2hskR9XTLie/+4IJ6YlVUWuQSoIlzrRnkG+bze6ERv7/MOh0uU2o2qt9T3BIx/mbwuPL2MRsO1J8dFtZvgCGxyuZZ+lcQZEawLs1E/0QS9iWfnUKSU7esdy4WcQmMy7gv8ECR8WE62fsxxGLUTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(8676002)(6486002)(44832011)(54906003)(83380400001)(38350700002)(66476007)(52116002)(2616005)(7416002)(66946007)(6506007)(86362001)(38100700002)(186003)(6666004)(2906002)(36756003)(5660300002)(316002)(1076003)(508600001)(26005)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZaWFxlIXJo0ZowgzT/Lsa+8gbMvuTRMVqPee4+HbkDSznM1vT0jSpeHcENU/?=
 =?us-ascii?Q?ZzHjIMLT+imZ0zgkpkIgxfo3+a43q9gTRc2zOOwwT8LRhLkeRGfUPbSaq3hZ?=
 =?us-ascii?Q?c241TKia5TQsGdN1RwdwMdUiCfVAfCDP09XDI4zyoIYy7Holusxn3+8K8y8u?=
 =?us-ascii?Q?qenKT/B4vnWoGo1QtZF3rp5TUoa5Vg78opaE2Rp+x1gnBu32qnqXLRfQrdpZ?=
 =?us-ascii?Q?ZAq4w8HCN1Zh4V3fqOFgHx51dmr9ipf9IysRQqByg/0K/H8yDhLXdcGNoR3R?=
 =?us-ascii?Q?FDwrxQ37FSmTW9jzm/RP+UQxS3+p890A5gV382niMtTGluuBz0cn6lxnDEPL?=
 =?us-ascii?Q?0Vqx6ILlBXtIcLSODP+Y9MxOZ0OFcT8Fbt14f3JtqgspvVLIqZMWI6DFCTlw?=
 =?us-ascii?Q?+kLRRYdCNmgkknoPK3vsbRYdugL5P4ohaa6OxC74ME/uErtQGkDlCsCysPVu?=
 =?us-ascii?Q?N78aHawFq0VESP+gJMosx6+sBdx1AwkGJL7KRodtyAfl3XIBoRxIpv7tE5xk?=
 =?us-ascii?Q?GVZKwWVd+xWI41MCnqSaMPY2nNgZtKbiAS5P2CRniYPgWQ68p0Lm+GV/WJls?=
 =?us-ascii?Q?xGDz6DPq5aP6DvW2H4fnx+k4smV/r9HZW9U3+lya1RBCFAwuCRPoziEMU4RW?=
 =?us-ascii?Q?osddx4MqHp5GOUbKIa701ime733cmYZmB0rawWEn3lC+l+wF7MobVXD5/WSI?=
 =?us-ascii?Q?W0P/a/4Zd2vfTPG9zquGRfkCC4O6hKb4cNMm0mtP6QuTwNAbJcq+dxSLx7du?=
 =?us-ascii?Q?UhA4cE9JqdV6sY3d8DcLWlAapCXst5f65hmbbA+MoFFwXKLIvEW6TKuobaGh?=
 =?us-ascii?Q?gmxmJy/jyzL2IOaqQks2dzgONVRwYPVGspwcrbtQIwj+q1ZRl85xKqxPTLbs?=
 =?us-ascii?Q?kf27fiLcv+MLVmw1tHM8x8weYI7+Raaa+qaVwTFLaWwC7VDPo8CpV/3d0Njr?=
 =?us-ascii?Q?AkXZ9WMIql4k45aGnGSeuVeOZK7GBvX2fuTv+P3dx7xOCYkOMtCXlstslLbU?=
 =?us-ascii?Q?zpY8umQgrBwb1vNdG5gWloAQ0KFkH6go8G5BXpOtfdmXK8U4oJWoglyQ/WRr?=
 =?us-ascii?Q?h5qp8IIpXfpZxUZb8hS/NUrvQJ5PqsItkoSM6a41n9M+Til73TDW7V36eaFK?=
 =?us-ascii?Q?AkMuEa0UGISwdj8gJ1V66ynbs/SEPXWmsIbhvLRdy3wl4gROpKceo0vIuU4g?=
 =?us-ascii?Q?6Cvog4BAwPAz1eVm8XCgNc9Izcfv+5pBAozO2AkMICyarbheFOTh5NgXJuWi?=
 =?us-ascii?Q?3NXxCnneuBoQQYL4nr5HOPIRnhd7ac98X3fW8h/6OuROHMdjLaVlQOsLvici?=
 =?us-ascii?Q?AM0EIHsoc2eBN2d4bZZK3MX6ivUlP2k7JnrgQ1tYTiX768WnHsQh5vGbMUHQ?=
 =?us-ascii?Q?W6Ey77KPcJleaI4kV6VrZemTRdQl97l+A1z+w8zik+IXVMVNG65Tje+GAKd9?=
 =?us-ascii?Q?cl7xZFczcN4RKUmfJSlNsVSM9jJ5+lTCp2kSWUKmjjsVfeQGfp6kFiEd5GDg?=
 =?us-ascii?Q?GhTrO0qEhJgLy3vo14VpTx0695Jz2VYSVr2uzo3JoWQZ2pEIVw/oGV966Yaj?=
 =?us-ascii?Q?80qKJHsxTk8HI8eRC3x5tDOxGvMCZ15YMJTRUCopMkBZ03EjmdPXXZA+iQl0?=
 =?us-ascii?Q?Lr4Bkne0i9DnG30poo1whTk=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95f44f8-ca17-41fd-7714-08d9d7b7249f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 23:39:44.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AP99iGZSuyL/ZquGAy+CUFwSul+6DXR7ksA3E5H34vqND2Vo248VcQ6b5GWcR8wtleAmZTh3oxHFgVi1rZVFGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of manually setting snps,ref-clock-period-ns, we can let the
driver calculate it automatically from the "ref" clock. I haven't
reviewed this board's schematics, so please let me know if this is the
wrong 24MHz clock to use.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

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

