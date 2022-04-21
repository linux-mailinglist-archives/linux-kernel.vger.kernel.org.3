Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C463C50A78C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391034AbiDUSAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391005AbiDUSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:00:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67D4667E;
        Thu, 21 Apr 2022 10:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byDgtRVSPDohTO1e10QNyzTb8uyW9snQeGh7ZKVWf6qFfOB5PSpELbf3BV/O0z5h3avtyV6nUR1loF4VK2ItwhkcH4joMtx5mAHrm1eJjjin0isgNJh4gFbwRmNUWn4AqKjU5LYoxv+hO6CtcPjAOTd5ewY/E8sY9bICr6eGmqROdt9tVevN+fTSlysgnR9KKJyZUSq3QccNXDt/6Eo5/AXzmGAEkzotkaaQJQQxcZAptSfoHYduYIBT9qsEovMuVQkLYh2nAzNzSsLDlL5uPpUyjchnzWzKmqbyJH0tRgY2xPH1xOsaFSkLMa2VwGpEQ+JarAsSVsQ/1ABien48KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJio3AP08BbUmGSqJmq6fKLrR6KX8iDuF6VvniLeGmo=;
 b=oTe4fSjiiR0xADVa+CNPi03siBppKtMcv0IEuhTzanMRFw/L8cKWHtBFBH1Mmuzm9KF+mS2ELXJ3ZjynBQJMYQRFdisKs2q0UMZSl4cRJJq8d/UvNCHh8biVwmSFI2C+aR/6kfQu6il3nQkunsKFQjeUcfYk/WUFQxzqzY6JEkpWa8EMfmHEVqVemecyp9oFZAk1O8Dn2+SHtfZcw9u4lH6g9nRFVuYKzQiM5hjcVGiWmsaqqioLNYgZojXrTPVz33tGxENlNhzOx8I1uaM5kIkYgzMTbVAXAzSWpXk2kww9hUGNQQaZ9P3bdMOGJSaX56Oljlw7NPlNHk+ykbgEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJio3AP08BbUmGSqJmq6fKLrR6KX8iDuF6VvniLeGmo=;
 b=UNHA44CbB5Hy9aKhv4tfLU2fwbIFUTxmGAU3xURkFNY5QLajffXCYkz0iXZBjvknaWoNeWmxdegbdihFWZRmzi9gO4Crn8WnMvTxmGuU4xBjVS+xNEhZIZHs4fbMTybWF4jonery4jd3b1ZR9ZGeOrwahU0mvkLlgqXg1gm9/yMnCLyjllqZph5EwdcisMOBwNNhh8ikoFbhStnkZcpP+DWIikg8sWx3+AnTHbX890T+SbUtfY1NqjNIIeD4ivafkjO1EdZ/iITeD4KSoicTu9nv45s6IBG9puddJneml5owhOc60zMloE2GExfpf/9QK9+DMW1FmgcqRz+94SR25w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB8101.eurprd03.prod.outlook.com (2603:10a6:20b:444::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 17:57:11 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 17:57:11 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 1/8] dt-bindings: nvmem: sfp: Fix typo
Date:   Thu, 21 Apr 2022 13:56:50 -0400
Message-Id: <20220421175657.1259024-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220421175657.1259024-1-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cbc887a-96a1-4945-8005-08da23c05be1
X-MS-TrafficTypeDiagnostic: AS8PR03MB8101:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB8101689904D5A1CB10EFC46496F49@AS8PR03MB8101.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXv0ijYkENFn7AVgVRfbk73bqKcj8DBh4I552TqdXqeB9DDBRt+iefw/TGwpe/vhCjiWEuMF/b4KCOS3/SVh9Aah9Ke1boRx25Z2nr5kUh28pEx5LStTk/tHbtNUAUClG6Kw7qPSgQLw0j5REApn0boCbKqpErXPNhWbARPfwPmZz+cj12boxvQDIiC8D2TnnNka7JAKC4y+xqtCR3nHzQK1q+Y3pOe03fnNIpigN0wLzfBit2BRlcOJMDaovaVwDR1oaVwjoYNMOaEckb6Xq+q27CAzBxHOSXgWbm3sOVz5oGbQZ4ZN/mGA4uyF+1+lP6HyIioYVGMZCS4AMcQhP+gAWSvMMhKVd0IQi2EsqM7dJvjNvslSRMusqbxGecvlvk0QZ8Q+sKqSYYDLOpK7/qSG3kbhHZ09Lj2Kgr3l7ye+OzzQymzePZLdyr8b9L9JLvnyG9E9UyMMYpCBRj0wTeelc+mtqdUfaEVICtx0WHtf2VXSF3dWaMRbj0C0XGh1eWGoFZjsWuYj/EKLPfa/BgpzcrUggyMEFjAVDdJlZ/vq5YxnqSTj8R8cIRm2C/Tr/9gGkqa9uaPlykwrsw1yel1D4ToJmSusoBQZJZHh13gqno7D7at1xhmfbdx3qy9Xw2yobh478E9XykO+BWHlxv/3Vhy7rPIOczlcH9sJaRKt05Wybjno5kRs6i+lRZqzChb95VVBIBCidyolxkZ5Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52116002)(86362001)(6512007)(2616005)(4744005)(5660300002)(44832011)(6666004)(2906002)(26005)(1076003)(107886003)(8936002)(54906003)(186003)(38100700002)(38350700002)(508600001)(36756003)(6486002)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CO1L8q7TwT2NXoRZ4zU/36QhnWeEN3V7cSRxGMKmLnhQYvILfO4w8ZuHF6V9?=
 =?us-ascii?Q?YbJw/vGFKspcg/haLInfwTPNj4GDRUl3ZtmtZzpnYocZKMzVJBJv/4nIvKMc?=
 =?us-ascii?Q?JWRI2pmIw4/KVUvp0D6MwHb2fGNNUuPN31ni29kvZw82rn4Fc8IEmpYlq1yc?=
 =?us-ascii?Q?soxHiPLxzL+s1kXjv5Yh6EG0vigzFZ5qaiBMsI6wIoeVehsfWW2eIr5cd0xt?=
 =?us-ascii?Q?+qMeL0g+DXWz0oAH3HXnFx9WItC9jLfjwMQUBqdso0kqgQbWh59HNHkAR6G0?=
 =?us-ascii?Q?TlodlfPepGefoncpuAsXUSTiHDkUpQ6Zt0XaZfb3CV+u8m/swja+RzDC8/GP?=
 =?us-ascii?Q?fb/z2Ts0lyI0F0u8I8eVhaoyxyoY0znOHeR4S84e8ramPQm+6xT1tqYNIEiS?=
 =?us-ascii?Q?CQykemZf5kFZGcNyjgwbrnvyiJLRmVFoMDX3yk8MtyWnJcXTH/3idaA8MTDb?=
 =?us-ascii?Q?JGw/NbucarzeAqGJADitm0u3+RX13ul160Pm2YGNIxxLQEyWtWN0ki7aKGML?=
 =?us-ascii?Q?a9FH/62lS1MxbLl33GZY7IWAQOGrph/WbMaCAbPgydYt3+hBZiOWou8qNvyC?=
 =?us-ascii?Q?rBFPjsbD21eiUL5t+u+7Hpmd7PrqyrGty/MFmnb+hZnURJkazXMBYfW+v0N9?=
 =?us-ascii?Q?lHfhrFCyQz1SSZg8cV97kbI+1oUclDr/mZwazzW11ihwv8WTPmoiiMlqfMBN?=
 =?us-ascii?Q?iJNT+zaOyU62No+dEz4EMSXvS+n1yybO7ahY5XHazk3OBZJLK24dCMTpXKY2?=
 =?us-ascii?Q?86qvjTfrk1+jIBliZYB1k6476cNa0qo7ZukvPbpDL9iqaDjOIa3Rhnv2i3EJ?=
 =?us-ascii?Q?4i3xcnjoCHexGPVPEA2Odekc5mgS5m3iujwGVVioSutzm0knVDJgfoRkYNja?=
 =?us-ascii?Q?UUeehrfhRkUOGSUOiBYrcoMma+4mpmZoTpALvfihPOQ/T4sWOu+zP23+U5px?=
 =?us-ascii?Q?g6NnKZlFnneGd55DYF01KH+0s5504kVAgakgOSlJhL6KM8Ee0iDedont+grQ?=
 =?us-ascii?Q?OqSGmvGkzkg8BzxVbckOYGnqiBDZau1vyA+hNsR7Lxoh6jP8gUB8UrVKpo3a?=
 =?us-ascii?Q?WDaGrDjQ5cvpU6drMt1/Kd3T6UlzsADob0JObMuG6P9TiapMb2IuEUouGVOO?=
 =?us-ascii?Q?Suyf1Y9gj51sxJIKLz1GFJXUZKDy4riW1JVYebeqqAuj/FPfsjdNWnp9mnNl?=
 =?us-ascii?Q?lk+s44mMVjesoSTbMGVNrm9Qb98ePl6QOKI1iEy/aX503d/31ZQy0MeuppPU?=
 =?us-ascii?Q?qyYkmpTL1ae+VF/YV5ywkhiS4GvlR6z7ZCz4q/ci4fno0yz8YEAbJHrJMGpK?=
 =?us-ascii?Q?s1+gVevTG/fmxm5Lt8NOysJsHbjVd/xW2/tFUIiEcmwG+XeBIh8CxEODpX+G?=
 =?us-ascii?Q?RXRYHnaT/6mnoQu4J2V4PAt6saKujOBq0apbVYGgkYYAV+o32WxyoHoW2JpE?=
 =?us-ascii?Q?nZj7EdKqbba0OAdd5WsORscLOVzAO9rVZ2Fn9bGQzx5trUG0iYXShfu7NyNv?=
 =?us-ascii?Q?yLTdaf5R0Fyuix7Oynbg9eKBlr9JD6tH9Eo8m4fYASvkEVyEkUBMDuBFcrTI?=
 =?us-ascii?Q?sTaa2ZFXObxjT3NPKYJNzYfmWUf1JvvMIt2GULbO1Du8sVMTwOTMjJhFpJQA?=
 =?us-ascii?Q?RsqyeCWT3G6Z2fv8j+t/YXJ274DqT0PajL5cO72SX3KP4n7gGwcfUirMiAoz?=
 =?us-ascii?Q?37wgLExGmBoOW/kpXew/bnUACJqVdHbM4WdyL9qVi2E9+FKnqCvPtyPwPMdf?=
 =?us-ascii?Q?flc3mFb45LLmX5cIeRVPioA5IQi9e5M=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbc887a-96a1-4945-8005-08da23c05be1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:57:11.1044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiHrv2eCfCQgX9jBa2/oJvNf+WiV8i9VYgX+YQrkL/UWO6w2AUe2sIqtDyfvzS8PN4aOQ4Tl9vcH6/wlVBaIZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a small gramattical error in the description. Fix it.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 80914b93638e..b7798e903191 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Michael Walle <michael@walle.cc>
 
 description: |
-  SFP is the security fuse processor which among other things provide a
+  SFP is the security fuse processor which among other things provides a
   unique identifier per part.
 
 allOf:
-- 
2.35.1.1320.gc452695387.dirty

