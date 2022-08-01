Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65813586812
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiHALZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiHALZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:25:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2050.outbound.protection.outlook.com [40.92.42.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FDA654C;
        Mon,  1 Aug 2022 04:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAEOzmPW9OC4nsiiIDWcDzb59D1V2sUJQjPTlckjt/1ymOYUH+HyFkB810Y7k8IeowOy9SwMCvLo5fguuiHMyS+73N36oN1pyACI9sc2UVEZGmDmNRdqMtS0odrxTF6W+GFDXyzrddYErz7dbO6QnccsiSNCjCSdx3xNqHJa+aPH61PIb9sVfNeydKaFzOrrEejwjR8nqMZlCgasO9cYvm7cRfcbK7EEm/TCBLCuF3VoVHvGjTIofGAmlJNFUTdcWyAVBmQRK+su2UbQ1ohhjpRIkCbFT3QpoqrMOPrLyBX78k0B85o3Z43PveJ1TVlVWYr4hMMxd1uKL2gHf4Dsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7kSi4pHVJY6wSG/AP03jq9sGvJsawA6UGyGY+TFVJQ=;
 b=CzvB/yDh+sZF3eRdOwbmF5odPKk/mRhjnE0LIS5gjTelEIJOhMYX0PJo1pAb0oYRp7aFGYWRrJvUvpfFS9j3EuEbvQ155ZxTjG5Yj4taya/0oiQEpBu0EmqoNmL3TH0x5yUk056wv5ey2E4cvWm2nJ4gKhYFlBUwvsDAFVqmpBL68dIPonPyrRayFJlHYuKR26VJmsCg9hdC5J1xpYsfqIg4IUGsoKERV9HBEq0vvRahsPWDdBRcIzuk3EL5TgwoS955w797lwf/oXicXPvOg+qE6QWoPAQYzxMWbrZDsyfI55nGVHVyte9v4wbm/7+1qN+Z7xj4rCNg/AA5WEyYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7kSi4pHVJY6wSG/AP03jq9sGvJsawA6UGyGY+TFVJQ=;
 b=eDPQ7gUKhyauCqtuqxG28ZXILKpJY3HKRLvIIGLbmapI9yk1tjAdYr8xK1x0meSmFRmw6LH+Ne88LPIp38kSocYgdm3VX/KScT6WZKKoNDNh6eXS6GfsW23tzv7MugLhfDZcLPxhodb4qk0VDQVCk9r0Oi/XYn3GVouvw8fvtDqOSVGiKIheV5akEuoV3ZbZVbSy2s46FyTLdpNTWW7RE4gQVGxSTvAKjCl0etivrspJL5o1zXQY8Mppoz5E6QAj/gJdcolifR+8MgDhgXun3yYsQ4I0oxS94PBZ5fYvf0OIWOEGdsjm6W1cE707LV9JoRC2fT7Z+wlCYvfNQH34JQ==
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by BN8PR02MB6001.namprd02.prod.outlook.com (2603:10b6:408:b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 11:25:33 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%8]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 11:25:33 +0000
From:   Joel Selvaraj <joel.selvaraj@outlook.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joel.selvaraj@outlook.com>
Subject: [PATCH v2 1/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: rename to sdm845-xiaomi-beryllium-tianma.dts
Date:   Mon,  1 Aug 2022 16:55:10 +0530
Message-ID: <BY5PR02MB700963FB9273AA8FEDDC5899EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801112512.209047-1-joel.selvaraj@outlook.com>
References: <20220801112512.209047-1-joel.selvaraj@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [lV/VZbkQ7V6vPIA9uEbBkI+r51cHKGcurxVg0QHAnvt3VcK2zqWdgbD8HM4PwL1v]
X-ClientProxiedBy: PN2PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::22) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220801112512.209047-2-joel.selvaraj@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cf0322f-8bc8-4467-c4c6-08da73b08c8a
X-MS-Exchange-SLBlob-MailProps: tBYDyRQCPckhYfnxUdDn+O6zSuD/K+SSA9BxXpuUcupOYnl5FiVJmpz+wn37EJ76/kxfE//j5bOO13Duk/KOaPI83X4f4b94zrJ9RvJcvNZ91JWHll4iyuxK7MtYCQiWoMkIUZEAmRaMskkCdG66C8eaEw3XR/ew0uNwyURGf5QMZBH99IBXv0wh6yfYuqun3P55V2lrhTGLnufcC3HuOcwrKW+hIX0HPFAto62MzKXYfGlCDk5Pb167AjVJeo7qUG4OKgBTbFUdwEFx0CabXKtSDxOn/SibjUBFBEKdqBZyY/s7JxChLxs6dHBzz54vKlejHEXyP+zcdjZA/eAa/FTFbn9ZAQko1H/1gDedX9GssdSwDEEf0eD2T3wTfGprOHrXiUc9j2z7yfGOsWDsv3X+s55inbtrbVrlwXI8ZYHOukX88Jtdyjvcw2x5JbiRDbvJMxWHSJdv/JkdRnk9AmDxqkvjSyreLBWaFzGlGEbYWqCisV6x1as+pS33uteTMdOpIYltXvJzNWrOUtYSEwu6qOB5n8EdEyHHy0ECCnFn5snXbuaEeOPrcDpUap4LdFwo1FWKC7ZqakHlvQQfRJsDqlz6swxpYMdDfbvF3l+mrOy1Vbvbyb2fRJ7SK5LZ9xbvmI44MGY+x4hWqChL+I8e/T+Z8yr0BQ2+osOLhcVKZO5Y83zaWxoBDygrriWycUShLOHFmOPGdf6x2S+Z3ip4vr9pF77m1ptllwFxxrTp3SC0eXrl68dwZIFl/8uXcyVAanM2OIM=
X-MS-TrafficTypeDiagnostic: BN8PR02MB6001:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efSaKeH3hT/Vewy8h0b8EbdtwAIUr4U9aNZFJbYoWPiyLYn9aGLhm3edZedqlxRU5RPiUUmimwnH7o4JewG4kycDRIpBCPWUZJqa6XJu1S6UfhhiMZdxFP3IKTM/cOL3rbFoM01dXb/k50BBj8ILsse934xzqkhX+LIyFBlnRXHJaOolLslw+8pY+KOpYNxSB9/rVvLikCQ6VcW+gIqHnj7bgnTw0LG0eXOY39KDnezTd6onyhfEs0wrFtI3HLgoh9lS8nwRWT0I2xUoEOF8TrYEmK6c6rJ8BFGQImYUsw8O8KcN6PMk/Wv0jAoIz16fDbCfBFL7hl4+epPnDywcj3iRaoSSNT51zGOptOXMuZGsoQZeOrP9uMozkGWbSf0PXCYVePXMJXghWKUZEbVZvW3YcvGjqOk3PgnnKttjmfRQEIcFAULrFUuo1cU3UdG0zjTkohdrZjyzRFlZV0cATjmC9oxSCnBcP89VpR/+hmlwIkGt9S0Y6wTC94+WqTTQjf4hC8PcVJymhib2WKuVGhiYUC4kYeguwIvQDcYBw411PRUblq8x77Y6V96+IblBQ77dCgfZcAfbAJ3RP5+EqN4VAvBbZ9da/1QUVUjUr3DXYiE+AVxscoeAFwtDkR8LKEV0GhFf8lhSo0FOSju/FA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t4NAzvV2dl9Zj8BzikUY0LChnPKEQb1CgJfkHa+6UIj3d5I9b9KZqOE1raTB?=
 =?us-ascii?Q?4bna2Jo/m9VegrY+PmHtnRYCxFiBO48X/DplyJsL6va8uOun6Z2Pl2YM+Jik?=
 =?us-ascii?Q?xMDPhG7Z/7YpQm4275y+b2pF19HMGHqoMKRvlDOdKlkf5s0usrIh4cPRfz6r?=
 =?us-ascii?Q?JlE4m8K8kuySdDibI+UZlc3d0lylDMBIrA3NTDmw6aviCLzX6k5D8Bslz/zn?=
 =?us-ascii?Q?wNyDe1ekaWC0Cu9IKyKver8bTOMoiOvvasPCG5Aa3ICyGIQOlVGldwKxfJSk?=
 =?us-ascii?Q?wjEXQUmMicvlzUgkdv9XrZJ4b8LBsyfOZEnIeW3VsygAhgfbASQRO5G0AX71?=
 =?us-ascii?Q?ycqbGZNGL7YA5Dk9dMSCVVqhEhcnLsxgVGLHldCKS/lLM0cSgp701opqvVXt?=
 =?us-ascii?Q?srVCP5scP9gjJClWCTvInIZY7fHyHnzzB+wqRh89zLGU7hF6tvWRGKuK9OKf?=
 =?us-ascii?Q?UjI9w9Tc3VreGNu+Ch8gsCDFAN06i5LJn4132J26ljjBhgYA4ljNwAzS96Ns?=
 =?us-ascii?Q?MYRicFwgk2ZwXMT9Iy9DHpYUrCtzK+1QDGwPX4Jw4pPNf+X4QuwRgUAJ3Izx?=
 =?us-ascii?Q?93V0ciG3F6rzUr/ek2mrfqzMatJGPO7bk0xqznm9D5Wbmrn3CXsOr5yjyqRV?=
 =?us-ascii?Q?AFYX7e7F6P6Qvo/Y4y8z1Y9inRMhprUOijkNOeK0eBofhDuulqCU5Mu8regD?=
 =?us-ascii?Q?CjRX38J/FW2Xo/XJFYLwAvsOoYM9zZwc7CAIpXL8oChe9zIZfUfGhODIWs25?=
 =?us-ascii?Q?es0/uVHz2aODvB7WrodZOPwtupzL5DX3RRKuTzB5KRShSiGkXHXf/FgGRZ/p?=
 =?us-ascii?Q?JXz7dcuuC0V2NugkDwkclOQ/Tsjx0ymXl9cITV7aDxjrVED0jJAIudwO+HcA?=
 =?us-ascii?Q?/xBHVMysuGHzzSyH2wIoUxMTYDvrGcS6y+orKCQn2rklb34LJ3/u9FuWpX/N?=
 =?us-ascii?Q?UonYwGtaJfqUKAVQ+MynnWLmQ6E709H/h48uOvqUxSqDEg2DXqeCZDEcEIuG?=
 =?us-ascii?Q?oP9wr9qlf0dIyMUhGdjDntCuSyx83q1UupfJf+kgqJ0E9YjwyZe4d513vDHj?=
 =?us-ascii?Q?MCmsje/hYyi7tOdHVpeHy9ILizgzVH0wHtvJW3pTrFLPJUfHkrg7kYSSO/gq?=
 =?us-ascii?Q?gGv8aAR5UdXJnONh8Dj9L9zGA5mJFvqyF7Ve349hNQe19XBkpwNAZa9hRuGJ?=
 =?us-ascii?Q?ES6VSqVvyPHHq8lTKay6Qb1ugsXM8kV2GuIJTzGyRKvx5AyrFolbJoKo15Ec?=
 =?us-ascii?Q?Wy67KWkw2OwS13WSfItAgtjojwx0rMP7sPbc2lJJiQcWBS9xnjABoBe+bVvo?=
 =?us-ascii?Q?QvGSILC1SYnKS0Eo/vHoSFivgsYLLhopTifWeDTAdB9SFw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf0322f-8bc8-4467-c4c6-08da73b08c8a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 11:25:33.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB6001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two panel variants of Xiaomi Poco F1. Tianma and EBBG panel.
The existing sdm845-xiaomi-beryllium.dts supports the Tianma panel variant.
Thus, rename it to sdm845-xiaomi-beryllium-tianma.dts to be more specific.

Signed-off-by: Joel Selvaraj <joel.selvaraj@outlook.com>
---
 arch/arm64/boot/dts/qcom/Makefile                               | 2 +-
 ...-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-tianma.dts} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-tianma.dts} (100%)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 2f8aec2cc6db..02db413b228c 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -106,7 +106,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
similarity index 100%
rename from arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
rename to arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
-- 
2.37.1

