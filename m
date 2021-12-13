Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874014725E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbhLMJrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:47:18 -0500
Received: from mail-psaapc01on2094.outbound.protection.outlook.com ([40.107.255.94]:59174
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233200AbhLMJnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:43:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjYUZAmBm07VSqhFfVhdN1JNznIgFM0cN25ASjuRUIUUjUHyBpXSKKcw/lNiRLReKgQ6J+Il6XRP0U1LAjVnyQpcrcLExXUr0yTbfon/+VNYkMRC7NErDrMbjM+NONf7gPoAZMVVphCANnrAmsXfZ7oh/unAwV7wv1cvtLHJA7uvnZCYsiapyGXuBw8OEcoZqTMx2NRt0VDbBY9FjEBIAAujegt4Vma+9EoaVQykVpLiH09oJgon8Is68ZcO/co0nSSvj5JK63C1kK79RBovVC/KxYa9zVfONd0RuGLg4DVivcCphwRNOhH46jlgXcRKygp7+rTZaYU8wQHLFb+l9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFf/CKQtY8A3SocRp2YWe1YEXizDpWTAvvgJguFpp2Y=;
 b=WA4x16oLpUJrcNPgFFNrlUSs21RLhwUCdlJHMsfVqTJ9FhBaDg4C2GfPBx/yeqyc7g4s+uSX5TtHO2eILd7iQCuivDMn40hMB6jMDvSC30DJHnap/fclBq5nrR7jxMV4ACqWjVK2qmReksoHJbZ4pFJd9USa2++VL4BTW19YkJQSBSIDOLuhhcNR0USnjUZtWvSWkuXXemCQWESs/Cbmy02RRS3vXiBpS0NLsTKBOWHagsej6xzvTDcKmq5g0wKLycXwvfYCEjT8c4agmetBw+9qHxVhvScwNqJ4U6zLLbv+oBctfV34p170qm8k6kcoRZ+h3FXrKlnSZLZS67SbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFf/CKQtY8A3SocRp2YWe1YEXizDpWTAvvgJguFpp2Y=;
 b=P4s91Ui5p3uRA9iRY5SytrOsJWBy9roRs1LAtDUuN1xt/r8Ji9bD4yph73P2fVJoFi7nupmMfEP4/lJUeHhWiXL6Qy0cw1ViIN262i3x0ZzSDMKI8y3Bmo61n9HqqOdkuNWC5rJSf1xDclae59S9grtz5cBgvyiZgyDShleIxHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3179.apcprd06.prod.outlook.com (2603:1096:100:3a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 09:42:36 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:42:36 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Paul Walmsley <paul@pwsan.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] arm: mach-omap2: add missing of_node_put before break and return
Date:   Mon, 13 Dec 2021 01:42:24 -0800
Message-Id: <1639388545-63615-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f75e8720-15ef-430d-b6c0-08d9be1ce511
X-MS-TrafficTypeDiagnostic: SL2PR06MB3179:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3179E35094C75C35084F43DFBD749@SL2PR06MB3179.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3v+1UiJgJlim/wmZdQZRFcIJfMIpgWvKre5b+IHVH8VdOe8jbuAaGa16u1t29PNWeMFb7zb0CsjJEdShkqIsF8xXuu4JXUooiDPmpyjYfO/eI7TFKkeKFel1J/djp9XHyJxq7XcQrfyQq9C/d14JuwzUESINjOOfqo1q81TLudTV+tlM1u2FvJnPmG+wOKOa5ybQVN31yfKdhxrtq1nBG2eEHY4NRR8En+Al8QnfChG000yNAvwgEvLNVSL1XLfi9y1qD7FNGv1AfA6zwbBvAJQq4fD/u51yz+3hpKBtnX1dwgtg40AIo4jyn7v/rsq9SQpQMrtqCp5jTr3perjJqboB+KmHBM/FWnPKa3/mTg5sNl+6Iki6Lxuno4/fZVwBJulIG/9z1zouDl4XSYs8DlDHViac9lo/2qXXyiRVm/+XY0ur3T5/BTRI2KlGj4FihA8uReWIRdbr6Sqt7MKwjfpSyZBy+7MxvDnTreCEEWE6iTMl2/J6Z6SJJ4Nh1WedpjF+GMBVbYB2xHmuWA5stC0DZHMJ7P8LQCqTxRjW36wgZ5DI+jgofpR6cHCQjfOPlMYox5t4KuS8pvf6hrSGURWfw1Az+XUSjdnAEdz6DmC6Upw0C659WaLzBtS6sQPX4Fh/8m/nFnNchhpvwrZIPBqvPz4fHJnYWkG/Ebxm9z9PemmqoLZjwt5FlbJXMUIQ5LUAahQHtcoFZCGypBUOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(107886003)(6512007)(38350700002)(2906002)(110136005)(66556008)(66476007)(186003)(36756003)(86362001)(316002)(6486002)(5660300002)(8676002)(66946007)(508600001)(8936002)(2616005)(4326008)(83380400001)(52116002)(26005)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rg0pNo5IpZhg7talNYSbW0FNz1KDtkfRCNHLIKBUkkBLblZnJ3nAfyWOdNHl?=
 =?us-ascii?Q?fbkTGTM+sT+gJEF/GdjDf19VkKX30GodFhE5BGczB3pwMioXOrmI6UPKkzIh?=
 =?us-ascii?Q?kKO3LcGkdh1C0uHTaPhxiNxKzJ2mNWKoNZ3iGKgmeiWDQZWt0EBvY3sGUor2?=
 =?us-ascii?Q?8cXNShLp4VcCypGPXMewMzeGuqJTznn1BpYCcwNwi//ZtozPNUjDcGMJxZJM?=
 =?us-ascii?Q?uPEKwi6qoJYywq5lBu3WuSzKdYsdbLbIMLXJt1vXvQOdOQOkOgHlKImDOj4v?=
 =?us-ascii?Q?RcqW1In5qQm4/1QfxkA44cAgaQsmyoY2NNGPKFgO7l66+fUFLNkKljIRfoQs?=
 =?us-ascii?Q?E8kEmVP6nzvkiN1H17/Dw5JEaf8nHLla7dxu1juJV5kh+6T+R0t1WxrslTT1?=
 =?us-ascii?Q?VcLKLfpVkiV+ZLv2JxVGAmiNr6xEuXbe11usihkgT3Hj8rV+hK5kJ2BV2nnX?=
 =?us-ascii?Q?/X2lcTHAC4t+W87db+lBw9ObUD2N9Q4ht/+MxLfvYb3BbinlP6prGvAgbIAE?=
 =?us-ascii?Q?PLKF36nAyq7AcdF96K0bM5nV7wPCUwEptx2KqnWVL2mLeWn9GzwB+znzzQM7?=
 =?us-ascii?Q?Lhk7Ktdyq1H0RkphN1PgVEPSDx/9MkR/bwnAiFLGYy5FDObkl9Vc+FnmvNma?=
 =?us-ascii?Q?/a2N4XfBm0JZ8r7mIHnxPx3wsr6x6wMlUDoGEv83RzWxPjwnjy719xoTFTo6?=
 =?us-ascii?Q?o2Od90nNQW3n0gXZp7US8I0KcYjyQOliRzBmlF1H1Mu7MdU/0AOwEk0HYObh?=
 =?us-ascii?Q?50rlffSO/T93gYTD6ZupY9impLDkMN2pEf9TAfKms/UQjKzNfNEh8xcfZUp0?=
 =?us-ascii?Q?3O9AdnMHf4DuI2liKBiADOD3MtI/ABl7+NIieQC6tirMROMmSxtCxYXv4NvO?=
 =?us-ascii?Q?aH1t3U4nGhd7K6oDum9HQPVVGzwmPH4GTd/1k/ufJe78gfTzvwbWDazLMfSl?=
 =?us-ascii?Q?FG7GfpC1c4w5AEFFSnxK4tigoGyoQvH+ToWB+TfObRQ1T0qQQMd43Gly+Vv3?=
 =?us-ascii?Q?l/EXsWpunoxyspNXy1tzefqS57b3Fq1YlxA9VugBb4JCe32rSrWnsAlFKYci?=
 =?us-ascii?Q?7xPWwv45CXZ5t4ncU4+A9nX0R27ovugmlc4rPswOSCpmCs/g9oGzGGrk6hj6?=
 =?us-ascii?Q?nv/jvsM+ieJV25UUo1QhZZuJX3x8cB05V/Jn9fS/4Fbzt/SJnqFvOUbh3T1A?=
 =?us-ascii?Q?SfhKzLZmNwku3OkLjO4349nbcHmoMGxpHONB+olZaK6Uye7fVhlRGOtkkW71?=
 =?us-ascii?Q?xpND4LThGiOeV2yF5lYdCY+7lxhbeJAzjnYzVHEfFDqDM/i9PWKmDeogwNGw?=
 =?us-ascii?Q?2PF/+GtfwSd5Dfzgg853WwNGYGQjdX9VYpallrmcEzwbVbrrUCdsP8hqV4zU?=
 =?us-ascii?Q?tnszjPvDZ5p0CV1OdGDaSLbPjbqYoatjCz0CY2H6vKDfNjwsRfszLINuOC1U?=
 =?us-ascii?Q?WPa73wDgGffL5S9E8fVdTtJ2Zoez2h0Jh+MYKMrdsuzeAZP/H6ynqhDINuoS?=
 =?us-ascii?Q?Pc4Ij+SpQO7q3tpXKY7OCL/jgD4lI3MqrgtYha4IAs5Cj6ior/Y4CnVjlzpO?=
 =?us-ascii?Q?ouPs2wVxyCdTCwetCFXpeYOyibgzQj3T9jeu0MWZzUjXKEH5YfA6PgARy8Fn?=
 =?us-ascii?Q?onaCdsVXiNp47VJIAnk0vew=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75e8720-15ef-430d-b6c0-08d9be1ce511
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 09:42:36.3629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nB+7CxYg08AjSVUNMmzF4fBTWYpEUPGDwoB73d0ZDcEqfj5zgE/kwk+kE4KS+mBsdjjddungJsgi7rJZnyK7qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Fix following coccicheck warning:
WARNING: Function "for_each_matching_node_and_match" 
should have of_node_put() before return.

Early exits from for_each_matching_node_and_match should decrement the
node reference counter.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm/mach-omap2/cm_common.c  |  8 ++++++--
 arch/arm/mach-omap2/control.c    | 19 ++++++++++++++-----
 arch/arm/mach-omap2/omap_hwmod.c |  4 +++-
 arch/arm/mach-omap2/prm_common.c |  8 ++++++--
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index e2d069f..87f2c2d
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -320,8 +320,10 @@ int __init omap2_cm_base_init(void)
 		data = (struct omap_prcm_init_data *)match->data;
 
 		ret = of_address_to_resource(np, 0, &res);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			return ret;
+		}
 
 		if (data->index == TI_CLKM_CM)
 			mem = &cm_base;
@@ -367,8 +369,10 @@ int __init omap_cm_init(void)
 			continue;
 
 		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 
 	return 0;
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 062d431..c514a96
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -769,8 +769,10 @@ int __init omap2_control_base_init(void)
 		data = (struct control_init_data *)match->data;
 
 		mem = of_iomap(np, 0);
-		if (!mem)
+		if (!mem) {
+			of_node_put(np);
 			return -ENOMEM;
+		}
 
 		if (data->index == TI_CLKM_CTRL) {
 			omap2_ctrl_base = mem;
@@ -810,22 +812,24 @@ int __init omap_control_init(void)
 		if (scm_conf) {
 			syscon = syscon_node_to_regmap(scm_conf);
 
-			if (IS_ERR(syscon))
-				return PTR_ERR(syscon);
+			if (IS_ERR(syscon)) {
+				ret = PTR_ERR(syscon);
+				goto of_node_put;
+			}
 
 			if (of_get_child_by_name(scm_conf, "clocks")) {
 				ret = omap2_clk_provider_init(scm_conf,
 							      data->index,
 							      syscon, NULL);
 				if (ret)
-					return ret;
+					goto of_node_put;
 			}
 		} else {
 			/* No scm_conf found, direct access */
 			ret = omap2_clk_provider_init(np, data->index, NULL,
 						      data->mem);
 			if (ret)
-				return ret;
+				goto of_node_put;
 		}
 	}
 
@@ -836,6 +840,11 @@ int __init omap_control_init(void)
 	}
 
 	return 0;
+
+of_node_put:
+	of_node_put(np);
+	return ret;
+
 }
 
 /**
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ccb0e37..31d1a21
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -752,8 +752,10 @@ static int __init _init_clkctrl_providers(void)
 
 	for_each_matching_node(np, ti_clkctrl_match_table) {
 		ret = _setup_clkctrl_provider(np);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			break;
+		}
 	}
 
 	return ret;
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 65b2d82..fb2d48c
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -752,8 +752,10 @@ int __init omap2_prm_base_init(void)
 		data = (struct omap_prcm_init_data *)match->data;
 
 		ret = of_address_to_resource(np, 0, &res);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			return ret;
+		}
 
 		data->mem = ioremap(res.start, resource_size(&res));
 
@@ -799,8 +801,10 @@ int __init omap_prcm_init(void)
 		data = match->data;
 
 		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
-		if (ret)
+		if (ret) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 
 	omap_cm_init();
-- 
2.7.4

