Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A0F54A24E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiFMWzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFMWzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:55:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182F32C64B;
        Mon, 13 Jun 2022 15:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUnPZaFbwMH/+NemFRW1ehs0dXe7iMlHi2sbQj5MjzI3i6m1F4DWsaBS8qiJPhjIrKotIj8saplA3kBdmLJO+g26JWX/toVExmBefG9ZBvcTOoUkAEHJ++w8xlsn5Yt+umwdd0cmndYFLsPSS3VcLnePAIcBXu1/JzWVm2kl2EEPAnqfypmrSfffdCvVCapJgoLJ1csc/RQ02FzuCfhoZEZBxf/10uJUqc9s1kodHH4Awf/ipBEWixE01bWt2GwUpulpn6N+n4iHwI3RmZsrv9Vm/aNr+RgA6bg+T7bA9mlkegIA5pbcbXYs4R6thXOZkSjPVhDV+aOqaotVHF5tTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1peEdIuzVN/6A+er6r7jHsim5mtpbGbhi8voFswPMw=;
 b=jScUY1gnaCuExCU/EchSPyO+XQ1rxswyQL0gdluN3fs1fCQSpcg0rG5UVgXMg1/srcXOB1HU8CMWJ6ATv0mRpx+t3yXHYci7jFelYf0plu8HtGmOeNOP6a/vpQGndUWREkTKa70Wk2Hu5KutNBRaJs0y3bT6PgMKMTeonTsdbnRdtOv27534NFxwIJlERqJNWHEOH6cjZSFiWF/owrOjytNOnub0wimV+Wg0fhT3rldB/jE08YICpxuXSXZaN9/UxynamN7K7lWKTLQunzfdPIS41b7XcqoBZKab6lnsw65VQHvCn1biJ2SmV6jQbVWhuBx1rodxT+Au3OV3F0JFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1peEdIuzVN/6A+er6r7jHsim5mtpbGbhi8voFswPMw=;
 b=wGhImL3fRITKCcXcFiBOvg6DDTHpqVq4T3gMQJrVvG3W7tpJghfL0IA89cc3tTlMTgwHDRfwicDglEzM3DoAjDEvvXhx2IEW5afay80e+xFXQbtqnEGmefRFCouhk4vtN8mI+4/xYrd8MHiRj3D51eMv0FXx3K2w2ANE4jAiGgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB1801.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:349::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 22:55:06 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a%7]) with mapi id 15.20.5332.017; Mon, 13 Jun 2022
 22:55:06 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 1/3] dt-bindings: marvell: Document the AC5/AC5X compatibles
Date:   Tue, 14 Jun 2022 01:53:22 +0300
Message-Id: <20220613225338.393-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613225338.393-1-vadym.kochan@plvision.eu>
References: <20220613225338.393-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::21) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a8bc320-992b-46be-dab4-08da4d8fc262
X-MS-TrafficTypeDiagnostic: DU0P190MB1801:EE_
X-Microsoft-Antispam-PRVS: <DU0P190MB180107740C50E4277C59432095AB9@DU0P190MB1801.EURP190.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUNac7KE+u0tvQvKkXAqH1Wt5ywE1CllnLbwahI8qs/FVu6c3TSu34nUlIk4B19oEftwuordx05aTdKFF3jXQ0ohIBvEzBe12jVyr8BQlzuCjSdZLH0piO/fJa17St1YLxPCkIP9E8edYux/2Bvn8eRg1/KCLlgNBMf7a5dL8BmnAfMfMtyeMAPr+T0F0+zGEddMAI9Wu9ymi/KKXCqw/Q7IWLHtIH50EL3S/1RPjtK96PzFSxTvSmpvEdmipv9/2HZW4G4zFa5McnFUN3UItDdWg0VUtsBXhkZKFymrfEkKK9x/H1tbYos7wDo39KpOyc7IejZ3FJYnj6/W936kvjxTSiAEz6TqWpA+rvweElBSZVBjPAwN1iX4GAkQz072zcL6PCiIp8KPRhidA/tq9M67ZlVW/99A5cUn7UnvfiTtgXwlRrnXfkpKz8pQ8vXWPqU+oisrS0hNsSSS6x1AaM73D3Um1bdkhCPVmfm0dqLHaf6h14SOY1cNkMbrrSIrBYDjmE0uOc6rVa0+tV7WgiGqbHFZH4FN9rnEIgwAze3X7qjGQWA/6E6vGRUS9OF3gtqz4BGkQ5gVQuapPe3nWWaB4Kti9dGqggNGIKOhOqBCIFQW9Z0xLkrf2sK3tblqVNRBOiFjWWSe1c+2A4UfGnJs8E8Nx9oVzFAaz0WU8ajKJYA5vz69ekmsH7yLW4YIwUDD4k5jVhYaFP5T6zsnkpM4uEV7yAbRth5zwkOQ34KoSzjNwjI13BH+Dy/sTzFiJrxLHgjdjKjzazsSnNHuG/nLIrQ7zv3kYrhiRxfwcs6bxwoR8StJYlO6/5Voef+q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39830400003)(396003)(366004)(316002)(7416002)(5660300002)(66476007)(8676002)(66946007)(66556008)(8936002)(44832011)(508600001)(86362001)(6486002)(966005)(38100700002)(6506007)(38350700002)(6666004)(26005)(6512007)(52116002)(2616005)(2906002)(110136005)(36756003)(41300700001)(1076003)(186003)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J0YoUEefjgmD7qECrFZ2IbnXlGyHCHjcGu8DtXfCNCKxmC1g3qVT1cc4kdF+?=
 =?us-ascii?Q?SqFkGHQAdk8yTlw+VZbny63tZDQcW31g5ME9z6K3DiK7uoJZg3tTV+tZKCgd?=
 =?us-ascii?Q?pl7oWH9YUOwcydMmO/pJuNFn4M9uNdmRmIFvTH0fs9QW+vcbSdGTdzT4LQuu?=
 =?us-ascii?Q?VroQma5vvSt0zB5kI0OEq2I2jIybQDTuakpmE/s6CluwJE013WsTjXlwR7fP?=
 =?us-ascii?Q?OM2iJkxvUqyThp2VkmivQ/XS0uduyIn8qqH80syWmHkkKHEnZaHA2MFnTjkZ?=
 =?us-ascii?Q?v1CEdtaZIkMHDEPVk2vy6uw7eIIdKzxdsK9d3CaA9RzE+t0JfA70D8ZuhpXB?=
 =?us-ascii?Q?IZOHk0Xq5HtVm4Ay+Gcn1pveYQrpyIq/Xd0nNt22odoP8uDTWwWGu+GtxIJc?=
 =?us-ascii?Q?4D+HG0fZvGI97WqXm8qJHN3DK7hyMW2eQKRdWSfKkv4sEdGijyhjnp4ksi2+?=
 =?us-ascii?Q?FXXdCGQp0Y1pqD1+6eIObufdEZEZjiqB8N/l0EkR+DBmfVqZr9frl+aLQY42?=
 =?us-ascii?Q?8M4NsUzhO4QGSn6jbAlmZpnnnolgDjMvVK3hgaxrjpPQdFjasXuC/vGdK5iM?=
 =?us-ascii?Q?vWKVgqYG61MpiNwBTPrv15vs1eWnS/tJ75NyYyqvGdbiy7PGeqtNTzbXAFVz?=
 =?us-ascii?Q?I4EER+JkBgh/nsCwU06gYR9GoCE6trRXesQGlHfX9xVlG3F8D3MpsFYlMxTL?=
 =?us-ascii?Q?+glggEchJ9EB7ZRIJ6p8URaIr1v2C7S6AuHE23YO72bQ+alN+3PdcdBKJ/C1?=
 =?us-ascii?Q?u8gegrfomjJs8xSn/dCrJcu6Aa8PagasEGmS5miTt0pgcRAQNr3ktxIb15VT?=
 =?us-ascii?Q?MfExRrVLnXFJbz0s9klwRWasbxzuXRSO4p8JzzxfnvK8Vdchg2IExlx+3INg?=
 =?us-ascii?Q?52pqNmtdSEhv1xKpNZD/GtCjLf1lOOsUTTm9aLQIsm26GvhISTmxY6/eZOh0?=
 =?us-ascii?Q?emTPdKdLf2q3/dYB2qWbK25HFZWptIAWUFjqZbSCA96yFSeoXF95unxuApma?=
 =?us-ascii?Q?fpzK7MZI3BhVIgGg7MFuWo6MnkcbiZIujAa4xHuzXZRF0NEGwBHAha2DRFLh?=
 =?us-ascii?Q?1rUuBPFCiDYLuQUAPiO0ZfVzy1jgujdUR+hcOJKqu72rRw96elX7kgh5K4nm?=
 =?us-ascii?Q?miZyKR3wMEgTefIqsgKCrgf2pot30P5/tZfSOQu+b/o0elPSq7YZSdan5qNv?=
 =?us-ascii?Q?SZ03urLQZZbB+AUK5PhKwvSNDqFw8SyI9uPGbsUN4iQk+Oc4keauVFnbVGzw?=
 =?us-ascii?Q?ryFwE2pH0vWCmiZ2o9IsY1HQg1TWyFX7iHtjLphGRJoY4VUQrJv6BKGWOoby?=
 =?us-ascii?Q?DLTOVKQRBjXAywIbqn8IUPbAarCvsBX8b0aVa7Pn+E/Z0F8sv3L+azOvIb47?=
 =?us-ascii?Q?pzUo0+dzHccYS/VMIM6Wb5GvEwoHiM7Fgrb7s+USX4i/7MEf2owb5V9iIQYI?=
 =?us-ascii?Q?Fu8syBIJf/ilXzRTehYXvp5QUgtvPVQFoq9f6I5TmhXiv0tFsHt6fP/OE+nz?=
 =?us-ascii?Q?Bcsw2zDShpkUAg3pcOVqrr6dBVdfHgxXd+hehT9FXy9JpxIi+qvqMksUNcZS?=
 =?us-ascii?Q?QbpJ3UZwvxdVHqbS7Wlp2W/asY6vJ2gc/k5qFlkrv74jr73KRiOpykAIprBz?=
 =?us-ascii?Q?WS1MzNbv1ycnv5KY+DMng6I2Jk4qjtve2htNj07OA7EjSz0TQ6mvZiN7K18t?=
 =?us-ascii?Q?QzFUxVxHn4dDv+TVt0LLgWC5x1llOvoLXIRiNOTdpv7tz0fz1Pz9AZ7zjT7O?=
 =?us-ascii?Q?KCDqUXBOpoq7p91C4sQjiEs08cEahGM=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8bc320-992b-46be-dab4-08da4d8fc262
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:55:06.5298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcYfa30LNE/lWeCh7Xki6JqusDoLN+pqDB6h+9oOT/1VZqTmWWzBxdgbd1kDERSWYfae9JDHS6FIcGjMMbZ/va8382eVht+gEBnyIDTXSGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1801
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

Describe the compatible properties for the Marvell Alleycat5/5X switches
with integrated CPUs.

Alleycat5:
* 98DX2538: 24x1G + 2x10G + 2x10G Stack
* 98DX2535: 24x1G + 4x1G Stack
* 98DX2532: 8x1G + 2x10G + 2x1G Stack
* 98DX2531: 8x1G + 4x1G Stack
* 98DX2528: 24x1G + 2x10G + 2x10G Stack
* 98DX2525: 24x1G + 4x1G Stack
* 98DX2522: 8x1G + 2x10G + 2x1G Stack
* 98DX2521: 8x1G + 4x1G Stack
* 98DX2518: 24x1G + 2x10G + 2x10G Stack
* 98DX2515: 24x1G + 4x1G Stack
* 98DX2512: 8x1G + 2x10G + 2x1G Stack
* 98DX2511: 8x1G + 4x1G Stack

Alleycat5X:
* 98DX3500: 24x1G + 6x25G
* 98DX3501: 16x1G + 6x10G
* 98DX3510: 48x1G + 6x25G
* 98DX3520: 24x2.5G + 6x25G
* 98DX3530: 48x2.5G + 6x25G
* 98DX3540: 12x5G/6x10G + 6x25G
* 98DX3550: 24x5G/12x10G + 6x25G

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---

Notes:
    Changes in v9:
    - Renamed $id with "ac5" prefix
    Changes in v8:
    - Add review from Krzysztof
    Changes in v7:
    - Add rd-ac5 and rd-ac5x boards to binding.
    - Rename to armada-98dx25xx.yaml
    Changes in v6:
    - New

 .../bindings/arm/marvell/ac5-98dx25xx.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/ac5-98dx25xx.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/ac5-98dx25xx.yaml b/Documentation/devicetree/bindings/arm/marvell/ac5-98dx25xx.yaml
new file mode 100644
index 000000000000..1d8dd7c00c1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/ac5-98dx25xx.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/ac5-98dx25xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Alleycat5/5X Platforms
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Alleycat5 (98DX25xx) Reference Design
+        items:
+          - enum:
+              - marvell,rd-ac5
+          - const: marvell,ac5
+
+      - description: Alleycat5X (98DX35xx) Reference Design
+        items:
+          - enum:
+              - marvell,rd-ac5x
+          - const: marvell,ac5x
+          - const: marvell,ac5
+
+additionalProperties: true
+
+...
-- 
2.17.1

