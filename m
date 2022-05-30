Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76CE538714
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242415AbiE3SKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242403AbiE3SJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:09:56 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20062.outbound.protection.outlook.com [40.107.2.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DD6A2073;
        Mon, 30 May 2022 11:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0ojoRHarobOC8kKmB23sQecF908sfjxI9dSaF38DtKnKdck2S5h9gU2EjMLi4NPDMTTe+1OhkADkdl/hl5kpG1lS4zPPyre5nH7IZgMCO49lHzsaKAGjBoRXXYC4Pw/T5d6HjV8mGvKiH1YnfJU5CUl+OYykdHD4mQETNW3bXy0B968oaxGXYKjkj5HW3jVi2ccGM5tpT1e9uAAQdUG+RHDVYB80MP8r0NqhMxKp8Jmpb8Y+MZUuSKYN5N0vh5UvgBmfBd60sMkv/jYcl24AQyN5CY3a3SF3iP5ZEUkeHVftkpK8Cb7uFJiIVLiN0RyGkjwNoLKqpdzTwAgNTiCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AdYb1+/KC9VIWXxGZKcoMU+hZqZ+SVXJGjcss9YtPo=;
 b=LUsPFjfk+mlVj93jVTvX35/luiUCUFfCaiCzhVeV1UaaKqSB0wRDUruaZkQO/PAdjYRs/drahbrGDcje8w9LbV4ff8bSHxyISgU+lBWC+MBlA3ois7sQqLFcZRyX/xLyilhnZhR3oFFx6UvBKhmGXeh8uq41OBIm5XrxiCrNW/+ghik2ucorWGhfRx9p1lnVDAz7g8dICKi3bkhCGhAqmncvxHlVITLxnYxTasL4mhCwW6TKSVv6IFTCFI+nYRtEo1KNhWT7kJCAAZ1yD9QMNmhWksQ14NaKJHMDqJ6mfQREn5yKBEOKyFCmsu7NLaH9msU6qHVJ62JjOqI00kYsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AdYb1+/KC9VIWXxGZKcoMU+hZqZ+SVXJGjcss9YtPo=;
 b=IhyQ0D0QtMT7qNuQKZgBBqogA4R1UKrb/9P/0edviSI05YyyEV5WPrd/8B98bNyeNpT/Zy5jzsiZAiHkPiar6Y4yHfPwtYgQK0bsSrdxNLnAW6Rk7QxsdZhzKihZ0xyAI7UGO4BiV/NHI4xbogkb0YrSHgZEEqoYmkcwEIM/tuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by VI1PR04MB4462.eurprd04.prod.outlook.com (2603:10a6:803:65::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 18:09:53 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::1076:5516:ef4:7c6d]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::1076:5516:ef4:7c6d%9]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 18:09:53 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     horia.geanta@nxp.com, gaurav.jain@nxp.com, pankaj.gupta@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        shawnguo@kernel.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        silvano.dininno@nxp.com, V.Sethi@nxp.com
Subject: [PATCH 1/3] dt-bindings: crypto: fsl: add entropy delay property
Date:   Mon, 30 May 2022 23:39:22 +0530
Message-Id: <20220530180924.1792399-2-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530180924.1792399-1-vabhav.sharma@nxp.com>
References: <20220530180924.1792399-1-vabhav.sharma@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To AS1PR04MB9358.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dc::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 216f7356-f8fc-43c4-fbc2-08da426797c6
X-MS-TrafficTypeDiagnostic: VI1PR04MB4462:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4462ABFB0BC27F5079AEBBEAF3DD9@VI1PR04MB4462.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQZDBHJWzJRzNqWVGNUgIQ/Z7olnkmwwPe59iP6i/EM4XvqeA35wHysbOPwysHtIq2Ie+wT1WSnG6rWHxjAjEpNMm6MxnW+dDRVfoLnZOUDoC9yZH8OZn5oo7yZWUXnY3+VtFy/y/6DSpe6+WhqU1Ptuf8zUMb0FlJ5JOrKhz/sl5yxK4Jx9CNejHcPnoI6AVPMc6tYRcJcITLKsaLym1LlpztwuBU5GMpbynTZxndxZa/sb0SlE448Td0BVSLoGHs4wCeDwjB7KFj3sbIYx1S74NK+R2SETSJWP+VPncHHxQqYBAVm+J8pjv+1ZlJmlA+9Atd6B9SlDVwW3ODUuAhGhSl1eRe7+tKP42/FoV/CvjXgcySQ6naOAYTtK/MDJhsQDUauqqx7CyNo0GRoQ/Oj7lfe/YpPvt55wiqd2RJhp3EMVskS6BiBrkydl3QqtNmuYDM6kS7VBcXHZQORsDLuRDoTqEuDVmDYr0L3rDspCFU7WhdDa6d5rJvk+42aXNqQ7oVGhzKAFV/u7sGxUljYAVfC3dstTBtBYdpAmmn60f4WpZYp5IMfr8JeA1JMOOUlGPhRZIS0FATapxqb/T+X0J/nbGDCn3mScPjNMHPyBaedjh73mbBvB+N7mD9RfJgdVKziyTU419Mezn7++jzqbwri2XqgwohZG5TG3h+CaAJ6GXauRmgBQidZv/HqlsgvfksKGmo1iUV8EQO15dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38350700002)(8936002)(36756003)(6486002)(508600001)(44832011)(86362001)(4744005)(5660300002)(38100700002)(4326008)(66946007)(66556008)(66476007)(8676002)(6512007)(26005)(6506007)(6666004)(52116002)(2906002)(55236004)(186003)(2616005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/d/Ia1/dDMXnjzcumII/l/IZuzaUtBZsrsfsmEvXic5aW9vL3Wd+CKIwle/5?=
 =?us-ascii?Q?ozxJDR5NDuDqosQge5V4iyJ0Uj3v3e1GexP5HRK2p27MjwCU8z5vWGDZN54T?=
 =?us-ascii?Q?x3gk5nAIjtapLMq4ZPXHKpKhpjzkak+3DeYWVdwZpdyCi9Nlte36yW4LE2wi?=
 =?us-ascii?Q?m1RfxP1Yw3TKOy0HGkMjUDLLKAu0wkK0XcW7vMPirhSqf5gFD+q76BpmsJIs?=
 =?us-ascii?Q?0siiGD1jIXwhIDCMBP6kYTnTa7kwjx1cvbc895G/4e/EAh6FmhfFiyrCzYd9?=
 =?us-ascii?Q?Go5JPJh+bXHAMVucc01z4MLPtqkNWrZNNLdu1yvoYDG2+tcQr6ap7rzNB7oJ?=
 =?us-ascii?Q?XX/VsXu799K6ITOHWL3Hc0UJ35psbvdKEKl/BxovzdYbYlCfagk2rZCC7RO+?=
 =?us-ascii?Q?WVJsUsRhHFkW3yHnvGkNEpQAI7mE0ET5Ha80PGfgYnJ1G6PZ0LYD6xLWmD8o?=
 =?us-ascii?Q?TKWPW8a2q0UAzMugTLkAbdEK2mrpUKjamb8lIQq4jljOwIl33vlScMI+OAXB?=
 =?us-ascii?Q?ipua/8bSqubmb01lyW3VK4aCcpv4+vA79IXG22CyC0VvKqgP6QXqBU+EYRRQ?=
 =?us-ascii?Q?WzSmb90JNrduYbY95pwYOfm+hIIXh5tuXwFYrbt9jw/XOVxzuZtXd/qvhWcm?=
 =?us-ascii?Q?J88Vcr8H781KeV6aKJrEsEJCA4b5gfP9CQw8tjWetKRStdB+zbZMtb7oJ0Ya?=
 =?us-ascii?Q?ol0IgJZkkswtpH7uftmTG3E+UL0XJDPXwqwcxyL5hruFSfWGyE+ShFM7xdb9?=
 =?us-ascii?Q?99qD145vAv2tQRveLNFnE7rm81kszpaZsp2LvaA1qHgRC4sbfwSDJgontWAJ?=
 =?us-ascii?Q?VYsEPk/8oVw31/GENfn90qgv9pRDwk7tA72v+M0qOOfNOnyM6EkLzj1O0IBd?=
 =?us-ascii?Q?s0mhsk9y5t1AslRnFcGj4ExDxdQMLNA1cqo0Ai+7R5f3hYLm9VidZlpa/rE6?=
 =?us-ascii?Q?JUgsjrasvByS5Nq+sTdBLiHxkUyiSEcPBUNqB4pabLP6rk3RWysE/BQOVe+J?=
 =?us-ascii?Q?LR27wZQOeJN8UcgdK/vn5gy+eAXX+FXedHiLJRDAaYQHJ5/h1blPjRC+i5XS?=
 =?us-ascii?Q?3jWX3Y6/wc8BUnLEcllw3s9UZ8sBSRkmyPCwiuadNM8gpe5E2Lo/6nA3/Rkc?=
 =?us-ascii?Q?IfpNlQycCB7lMKJEspIQ3c/oZDwUf77jL5idT2kWAjm7OFNBAzNbWA1u13zP?=
 =?us-ascii?Q?1BTuiI3DoeNJFokMTaoxUp2UTfVThJwtWzukNrrDDj+uOY1x8FOyacVP6tYx?=
 =?us-ascii?Q?QEsMeWr92m9w+xceOKrPEobxku8eC3pJSAJp/iydXwyAwDmw5pQjh3kKTnTJ?=
 =?us-ascii?Q?0hDftUR6iF0TNyyxUQs61WYhjkhiQkW33E5HZ11bztwVLKsOzqeLzHNUZUAS?=
 =?us-ascii?Q?UyjyGXZss4OLlu7Wf9WEIz8dbmxC+ViJOpzyw1hidL3Q3j5HskqJi2EvZf1n?=
 =?us-ascii?Q?IIckqf+G9r7eyh9TclJQxqyjwWITBZIsgXTPw7p64KGMl7EtAxTG110G3KZY?=
 =?us-ascii?Q?en19adBygGA6RLeTHCll4e4oSZ9M9Tgg0uXR/tev31fLahnNj9k6SPpxck3h?=
 =?us-ascii?Q?dazi3B/ezDWCDyH+7MwmiyGS5K95ZIfwhI0bg0Y8BwNv5h9IPkuDTXjpwGTI?=
 =?us-ascii?Q?aSzhZ+QJKtkavGnf2vE+aBD1T07nb2Bdzid33qvKdZ3eaLaJ1iVOdq5DdZY4?=
 =?us-ascii?Q?Z7gvYWmCMtm3vGAihcaYfyexMUlyOna7PYXUczmKFWdRAEgQJMxFaD0m/xiY?=
 =?us-ascii?Q?VaybgqjNXqiCSW27JffAQiPLzy3yGpE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216f7356-f8fc-43c4-fbc2-08da426797c6
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 18:09:53.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTQxR2hKE52sSRj9XURw21rHfHhe9GVRB2Ch5ExE3mgD/CsVTgvvmYc4Ia1a6xI8eYH1YgZiT233KvP4z/nBvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entropy delay property which defines the length (in system clocks) of
each Entropy sample taken for TRNG configuration.

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
Reviewed-by: Varun Sethi <v.sethi@nxp.com>
---
 Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
index 8f359f473ada..1477294eda38 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
@@ -62,6 +62,12 @@ PROPERTIES
       Definition: A standard property. Define the 'ERA' of the SEC
           device.
 
+   - entropy-delay
+      Usage: optional
+      Value type: <u32>
+      Definition: A property which specifies the length (in system clocks)
+          of each Entropy sample taken.
+
    - #address-cells
        Usage: required
        Value type: <u32>
-- 
2.25.1

