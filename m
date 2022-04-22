Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1086450BBE2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449569AbiDVPp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449520AbiDVPpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:45:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2090.outbound.protection.outlook.com [40.92.20.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD2B5D651;
        Fri, 22 Apr 2022 08:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIoxMcwU5BoDEtvkzOWs9XBB/ewJtlseByBls8pKhpEJextsv7X3I/vKZ/Yj/uAJTuBJrxi8FPGXQYQf1QO4JT/cVvZeeR82Z7/UhDGiB2U9tVPbAKA6gI3mODxZi6dTbV8WeSS+bXQUVlCKN/TaO+RYpfYsx7QsTuoBYIOOZTDjW/9B0OeeOQnVvxyFlHKoXfJyt2D/FRoLz7YSWU2/mFv9FfGgBpYSRnKmwIQXgtoT0onBW5Sa4xzY4f/doo80gjfEZoo/cF/LE7qITD5XEb/cY7pkg5+6cyMel6OZhXVuCZ0U4hm0wUx1Qv6TpWS5OYCweLK6spQQjh6OUbr4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCJv3sE3XNbnk/UUAdvq92kDPFgE70WnhuKfmeGCiFc=;
 b=encjmf1DFlpaCkRwqpi0GU9jiaXfnNZy6kPEY8en0MzdxM1l9Ppi1swXUz4SGSrJdOulUbpoZZ1NJ/zx+KGwlQq8I07zwCYuQH8CARb61peuE5GWiil69N80J4EtBoP+UVeadH8R0O6VQ3ydw3/q8+Zl3xKMjJAaOJJ9fuDzQtpBQt8COFc/fjLFo6dgMXJP81adgUNbK+M8CrEy4zWwb1z7YKQK4jM0nSam6LdhcrX3XX2XWj/hqViCFUjrONQV2YZg4jWiyIaavsXAjxd4VkyV888k37ERKuC69BJGyI5OJ3CBw/CpztGjXs2WzwMgKDJ2xnnBAaE9/0RHPbWQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCJv3sE3XNbnk/UUAdvq92kDPFgE70WnhuKfmeGCiFc=;
 b=rsd7EQ198nVUK/weVORUOHZAy7CAXf2UYvI0YHcE3LQY3uSCQoaKmOv1hd1rK5ZBhT4jg80NDRxTHFopJAYRzk+ZyooGNB+2Utk5wTXF68uJR4oNHySprsOOGMOvOc5ADSy1hQ7TQFNAwWko/4NC11EhfO3rt+QOT+/MXAhA7q2e2veOh+CJ30fXWDsFUTYgdMuSPSqq2ezcE1WrkSg58Z6YsoFGGeEAPgKvLbCOyEJGA6zfOojRZZXKRs6gmPUAAfvmBJ2L5t5HLM+Ktk7RHYDc0DFukfDtn3Xepcrq0bL9RET9n39/tIHCkwpUJmBxfSlUHfdaynnBi4qxhpbEhA==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by SJ0PR20MB3642.namprd20.prod.outlook.com (2603:10b6:a03:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:42:28 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:42:28 +0000
From:   icenowy@outlook.com
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 07/12] dt-bindings: mmc: sunxi-mmc: add R329 MMC compatible string
Date:   Fri, 22 Apr 2022 23:41:10 +0800
Message-ID: <BYAPR20MB2472B6F7D9AFD3BA6338A79ABCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Htdd/v9LkJkHBCm++s9FvAzzFujUIMV+]
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422154115.1068642-5-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0d51956-5930-472d-a01c-08da2476b4cf
X-MS-TrafficTypeDiagnostic: SJ0PR20MB3642:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DH+zYkCKj2K8lcUBIe6vL2buGN8Bz6qcubMBd7mhdMnIFXzkjukZ428HKw5bBZs73f5Li6LIO4laoBGvZHZ7DbkZvJt13wNbRBEZ3LL2polrwsnsMWQRkAQoSMqGwXbHKF1e+jMV5kH3mVbodNWD3Zyf9/Y8V9K/8KM73gTeU11RFRbo/l5gM7j2oNC91rFVxwN1jbph93zG/InNxUS8qDfLnQAdVrFdn/KUyaYhYam4xERm7mLmnnqk9FvVJWYPSK4MgaPKk8JPMPV8NhLzjw76Mw9mrIq9TvY7doFY9HiVN2FTdUQ6VH4ZSWJ4kV2+207/ozO1X3lu+piySeYn0RmgiTj12cQTMWO1BDhbKEoT0iGHkIuryDjrM/VXo3IKsui/6iD2hNEwKOkwNeFOKXm8t1U37b2Lxy36Synmr1zsi70+fMskcP0gwslqCsFQmnQFw0DaVeyt32dOa9CaGw0xf+r1c1+mtvMbeuVto/fev5XtRyTruOFdbBYmc0akq0O31NtzAfUYbpuu8EZKJQXzVNJ4HR4M6W1c8V6kT+aNC949/lytez+EMffzMcPKXd0y+UfPtZdvO/LrSpPiQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m18dafE5S0iIYO3wWtM6w/Rc1pl7xcFe3yNEJsr2pbaG2VX0NBopRXfWlOYk?=
 =?us-ascii?Q?dFDDHK30+ovIoRtfR5MYdcIAO45s2Rcb1KQwCf7TS8h0/wHMWS6rPtGlOjPQ?=
 =?us-ascii?Q?RDOUEFp+yrm37StUgqMUu2/oVkDqMhtPkcCAgJfmb9WOFr1tOZuyZ3+2LTlX?=
 =?us-ascii?Q?hU0D7vEha9kP+mcVhxRkY1e4tU3BQxU5osafshkogRk50z4Sk0vUOhdkyRyk?=
 =?us-ascii?Q?X2BHRZlDY4FA/nkrDXH17hlZ3OIDGYQD6MZFG5Vx9IooY97cLkaBV72xaUlu?=
 =?us-ascii?Q?+b1lruNPmFJ9wbGt2I7Xb6ZjIJdgj8T4VtIKguhFXfDVSW0tbxdIEQB24Y2R?=
 =?us-ascii?Q?hLrbrwVl+TczzulE5ZBSg/FcnkG90eisdyV8Zm43pMbjyt4rT+PhRCaQFNJl?=
 =?us-ascii?Q?WolfhmaNsTxUmUhHvnuNTqy6OVQljPwNY2xFpvu23nDwgaIpUmrcB7lCUQl5?=
 =?us-ascii?Q?T8YR8n+RTXziZXnUtIfHIdcDt1OcC7w8kXsqB9dMlRoE2bBgGsto0uCB8+Sy?=
 =?us-ascii?Q?XHORpH55tfkN2/MOIwLaZ+6sqz4g+7bkiDvIAs2OLstaDjQtZw0OAuBn9T+C?=
 =?us-ascii?Q?ACOGcDDoSF1wU1j9xbrptJ1wa59uPcilvjVE5FVlqZ29kCNm+rx8+8WVVXfz?=
 =?us-ascii?Q?dN9tDi+wJa39sBW5RSo0jRJ7FL37E7pDS28F5EMaEXkMMH7Z65rO1QwkDH9x?=
 =?us-ascii?Q?sbYgF85Ih4yPyGE59vWgXn63ccZmBABcFHYhEIhSKv7fwY/m+buSFvxH2W4K?=
 =?us-ascii?Q?329FW+hKB1u7NFAEZuqVPoqF/70SQ2n2BmVrwT6jL4gxwSGU5DWzuK+95Gl6?=
 =?us-ascii?Q?VDF5gaD7hP5MQVHXYS9izCTQH6jGnOOJbry+Rpp5YA4qdIG1qzQzShmJ9cmc?=
 =?us-ascii?Q?c6tf+9C47Bs7pzAm4ORz1vyMr/9FDvBmlVqVLGU2i5swor4uWN3qiqMEMgxJ?=
 =?us-ascii?Q?64kQYmNKp+Dl+J9kQ5sy6NuJ8B7lRgsXg9c/BV0YolKAW02TX1LHhwYfODX4?=
 =?us-ascii?Q?dWvAzj8DAvBtE+ETHAcBykF7cEvx+aAYmkR1nn54bXlFvpPP3gbtrY8UN1zr?=
 =?us-ascii?Q?1QKu9ltn74++8rhxa8sDUzb+N2e2RLrlIAw8rgbmSiVGn/ciFTANu70Gthwg?=
 =?us-ascii?Q?b3RLij9WtnDpnHcYhNuQ/k3kuktKu21TvSEkYWJDf9H0D+W9Gu86MBX+0IR+?=
 =?us-ascii?Q?FlcgaKPA0IryHjtLBzupC+k1qTU62wjs0r5ph3EIjpgeSeh+3zWHLkpG2fPY?=
 =?us-ascii?Q?4NPHBxtccBrWdWmvMcFRRLSzfJROAZxXF2VG40LKu/jjQIaxUK6nnckfAjge?=
 =?us-ascii?Q?s9X7LsU2MjwzJduRC/ySGPdmnstKb/+48H8GqHvcCtokxJyquqzHGC77TC6S?=
 =?us-ascii?Q?MwEar3kEA0zCR2PLUtl/9RB/IIVb8az/Y51pHWoOJS31dwd7xF4A4yYV2NmW?=
 =?us-ascii?Q?WRKKFv9XtCw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d51956-5930-472d-a01c-08da2476b4cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:42:28.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB3642
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

R329 SoC has two MMC controllers similar to ones in the previous
Allwinner SoCs. However, as R329 has no eMMC controller, the two MMC
controllers look like a mixture of previous SoCs' ordinary MMC
controller and eMMC controller.

Add a compatible string for R329 MMC controllers.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index 7803597b6366..afc380dae776 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -29,6 +29,7 @@ properties:
       - const: allwinner,sun50i-a64-mmc
       - const: allwinner,sun50i-a100-emmc
       - const: allwinner,sun50i-a100-mmc
+      - const: allwinner,sun50i-r329-mmc
       - items:
           - const: allwinner,sun8i-a83t-mmc
           - const: allwinner,sun7i-a20-mmc
-- 
2.35.1

