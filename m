Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED4D513B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350895AbiD1SUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350698AbiD1SUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:20:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A2C580EB;
        Thu, 28 Apr 2022 11:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xjgkst2/BC9JO8//KJpyx4vn1jdoV6dOJmdV27e4hHNnrAar7FBHJLddk541TpW9Tebw7umfXDhWxKgS3pfjxMEyli87K1WQrv40VKHod+i2reqwo1R6XFXE8KxI5f4Od5TyWxnZFWoyxup4y5EbQz7naUSX89YF/BIhyDMTThFbXZGxlA8Io+hxTaFdw17jlbw/q56KyruoZQ32+Abjvk+osAc1zc1Yazmez1cDY9q1RnqP81l4J3N/VKTlWeeJhyO2D0OBdAZBDrYsn+b2tw5eBRCNSdpMuyCnQuEFBBdetKgYuQhBlESfFIXat8l7ESfiBwC1g96LUL0zNk/9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX1pSpga6zicaQolIXfNW0Ey/UDwT94lgv+D6hQ53+U=;
 b=QvQBFYrAvNdfdC68oi4cmiFNPJSDdMerydNRfvhci1hm4raLtF/C0qdVpAXXn5jZlaDeL1JyXhhJT0v/rbGX9kEAnt/FA0dRv0xwFDSOZsHtDzLxt7IAXtFLriV4Irg2oP3eEnjNYOh8WM02LBoj+hiC6bPkPCsIr0ir1v4DAdbwWqaqJCH35d4JSXIXm7tV64gPa5q7dcFXikqoIfktV3ESwHZXzv+nQ7DQkp37Oon8hK4bZfUxUSY/2NtCJeOcJkT+Ksd7LD1GjCEFbF47MYujaW/rA2PLDS3ltWRNUkHy9ZmoOsSAMNex4t0SEvWFcOXDSFesxhmZbOdJF25IRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX1pSpga6zicaQolIXfNW0Ey/UDwT94lgv+D6hQ53+U=;
 b=s7wHB0mwEfHCQTps3Ir/PMydvYmO5ZcYV0TBkqOSOdqVCnLctopyekJbVIr8bIUsZucQZn+tkN8C9Y2/DP2nca3FzwptWpnGg2p/iab77Zes2M2khH2OgebPq7ZqhL5Lt5GuSlkrV3wLYIszpFozIYfB7Pg45yK0oVca8UzjttoGnaB/0Nr+SUTsr1HkYqeACBJG1/7QrMuQ1294AkGDAD4yXSXlctE1M05Y+3HrkIBzLQMaVKeof604rwb9vaGG/taCuhMjIk2/0vdCN9MIsRW7lP2ZAZHfQrfviawVv2cvt1mpHhYuIHCZVCaHo0U+9luPjgQmjCRK8teX7Xi7FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 18:17:15 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c%5]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 18:17:15 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 1/9] dt-bindings: nvmem: sfp: Fix typo
Date:   Thu, 28 Apr 2022 14:16:55 -0400
Message-Id: <20220428181703.2194171-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220428181703.2194171-1-sean.anderson@seco.com>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1994d1d-4112-4299-c700-08da294352ad
X-MS-TrafficTypeDiagnostic: AS8PR03MB6775:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB677567A574234F86344F6E9E96FD9@AS8PR03MB6775.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEYLZ6t/K/8VaH8k2rewfGwFvIVKQkddbNejkiDsRTp+gE+BjL1QUXUkjLPABY8XZzfp6K0jlfjhv77Zw41ThnQHM+UcYE9F5qkLcWpdSLYkIa4MwNSMhMaSekkjQxB1CwQc7sOmEBJ/OKZgbZ/AuTpAw8GKgHGhIP6p5xTiyetCw0qPurZUb23Pi0qh4qFl+w3eJydCL1fqIz9sVWPRNHnyo2V3pG9kjQMU1WYru2nTIRgizBgjHqksTZAfGhVYlFjscSWFXkUzIeqq1FTYRndDW9H+/EwZnZ4KHl+E8bfmpGyBkY80FxXpAXMhZlmI7V+3G9GrZwLVWp0KZx10MOcleK8XYvckGfC7lS2eAAQ/Bww7JUY+43Msz3xr/lCNMtgEpzI7D1YHsSpq1FWEfDkJHnoKZHwwe8xYf/NN6YAQ99SadP16cMlzGtJix0rq+HbPlmRsnfz++L2km5/iuNhUgfwcvPwvcNY4scvTRHNG/qitS2u5xpfrn6MPShWOA0s395L+3p1ra1bHhiLTnqZPrkvuatZgVNzFj/ee3ammMrtCjvdxFbmCxsh76G/uHom5FMFUEOPN+38ZaKY153GW6QWCNbMQpo7R2ujrbgoJ3Q9Q+MfE5jehn5IRbPMJqF1c+k2R19ysUtP0DoaGfUTQtp1C9uXWKNj27TPBS68GoBBRjOA2Y8GUa5R3mcizsMyWFFohX8+DsvozC5yfgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(6486002)(86362001)(6666004)(2906002)(44832011)(4744005)(1076003)(38350700002)(508600001)(7416002)(83380400001)(38100700002)(316002)(66946007)(186003)(66476007)(8676002)(66556008)(4326008)(36756003)(6506007)(54906003)(2616005)(107886003)(6512007)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bixwC2188Zv5kYoeVgifpIvZlwO60P3XAVycW0j7m/NRdCSIkMQwK51Ebajy?=
 =?us-ascii?Q?cOtwGXro3TwZRO9KpARYB2wtcKq3lQURCuDR/FQa8fnREW8lzSAaX/nZi2HY?=
 =?us-ascii?Q?HnORMOO+v3BhnOT5Kem86R//VtB2Rdjd56UWbgMnwHb3YfyDcmKu18LF8VPI?=
 =?us-ascii?Q?ROPj4vtSoZw+PC8OeULoCRhwxV7zQJhTBqT6Ec8lRTlTNJq/LGnB7SyktQIn?=
 =?us-ascii?Q?YQz3lUExBrSbFFWNMSu3OFkS8oxCTsHUWHfduZdqwrc+WiBhKEQrKZFvRuaW?=
 =?us-ascii?Q?0mUWgjfxktf+cNrOvpZFkU1/ZcjKjXoFFI/Updh21UKD4OIXEXtiADKu82iv?=
 =?us-ascii?Q?OEuR3PU9LQevNyyZbiqHsUAl0YX65iL7VqeCoi2coFBKPEabF9ug+2gsVxpp?=
 =?us-ascii?Q?yc+qdnBKG4gHT6nloBy1o5MqScAGP79Chqwx8nP9O7qrcIzNbcxBWGndbKPN?=
 =?us-ascii?Q?1dsE3p0dOVkSHmbr6P7ig93qdWyqfIUQUNevjcJm45Kishnut/l8pKBCQMgC?=
 =?us-ascii?Q?UUgEOU3/VyjmSW5V+zQ80Bp1Ot9aJU8aVVZ81NT7NhyRmEh4s8BTIEEiky2h?=
 =?us-ascii?Q?Wamx/lydZi2u4TeyUaR01Lopsj+m7zosL+nrkADShB9xpMVAJVAINCB2zYuC?=
 =?us-ascii?Q?HXiIDMXO6SpnvS5uW/4m7ezLdvvlkYDVCR4ySvXtVQCdR3RIjA4LLM/oIwtd?=
 =?us-ascii?Q?kC08SxAzxgZq8Y9/5hnFJX7VjCeNoIlpbd9iRcQxUCsfk979MaUsvNbD8ylD?=
 =?us-ascii?Q?s3x3nya+3tWnHCz+qIBZs3kayWjfJHOraYm8Ehg9aqWGS8B7NcQQSqDPf6xN?=
 =?us-ascii?Q?0e/GAsWh69j7cl2f3C5Q/dz06ljLBFtDj6wTYHWoIqNPMGriPoYiR16s0FYg?=
 =?us-ascii?Q?fm5ZKx8uGgbEEcquQsxUfMFzPcO2IK0zsF6ecvx34RuIkuEbNhcEm97y7RjJ?=
 =?us-ascii?Q?WNlEm3STwp8mGR26q9lmDyvFdqlL2ezBDDPR0KUZyh73d3dgEC++Kn0Shmqh?=
 =?us-ascii?Q?RmTOxYHsX9/v9uIMDeTQYjuczs1C9LNWRZFqhcRom8qOdWD7jlsHOF624Hhb?=
 =?us-ascii?Q?zgTj5yfF1rsStWh/OWXBREcQrAWwXR+hwIh/THzes6pEMFAC4MftvdBRBn9V?=
 =?us-ascii?Q?zKdGfmtChyYL2sWgXDSy3kYFYH8ronalzRiADuSDo/dzwPZ1SkRFUJ8W+Flk?=
 =?us-ascii?Q?wT+aHvzPfAw/2JkC6EhIKPqUsp6aLB9mb1Hsp0OPgFMEKGlUnUt1sVOm7k0J?=
 =?us-ascii?Q?Vtt/+4L0cABY+sYl6Scvft6qTj5bHHYt0yjeMxIam6+7/MjkgvfgiYXe9LMZ?=
 =?us-ascii?Q?TkYT21gjcBpTTGnqPglIpvNUUKDc/IrMwTkOmUWNg9Snc3i8JEztTONX45SH?=
 =?us-ascii?Q?Q+s7942cDvS12HY2UXN4WSpLSXUh7iAwl92YUk2pxgZ86tEEu7nZNhBQSnUH?=
 =?us-ascii?Q?3T9euJ6Q5TjWp6h8yyfjz3igj5O3m7sedgjt5268ZLJTfyyNlrbDGeW6JQm9?=
 =?us-ascii?Q?w3PBM5qlae4oH+/LFATzajua1fsE+yme7red6fXr9pmXV1IhIDxYnXNUSmsq?=
 =?us-ascii?Q?qPaf4PKvhxrAOAhVkO/yvQ6p1FiYQlx4JSGWyxL2IEkIAf61GOK0MPOBDCRX?=
 =?us-ascii?Q?MpeoGZFyCxewOoWnE06JngR6z9wt2+s6xTr0kiSZUoIbWrSIEye106rM2Gbx?=
 =?us-ascii?Q?DObetH5KdM6yCKbn8qHmg6YdEassSn2MhZbEqyVnM72RYm1ruBTMWiXnbn0q?=
 =?us-ascii?Q?qG6YyWjd+qluB64yY3NRYnbSj8SY49Y=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1994d1d-4112-4299-c700-08da294352ad
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:17:15.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcacK+WTNjyfHaNawozzdCExl8RtVSmgHecSwAxkW/E8iFEcstQEL0qbqyN5Uy2dkF6YeinFWaPMuNjNautrag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a small grammatical error in the description. Fix it.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

(no changes since v1)

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

