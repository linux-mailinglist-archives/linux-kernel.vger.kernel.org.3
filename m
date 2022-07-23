Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C42A57ED39
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbiGWJmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbiGWJm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:42:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D5232B87;
        Sat, 23 Jul 2022 02:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIAUiEDCCd7nNOqNwKrmNTJyBm3u59bmiJIS14yQyIU33bU/AdsOtBxZX3vutomUfl2xvbSuwKQqp9rDRyDay0i6zRiPt8ot97nYaI52XeIm/DoaqdqzfY9jMv5swByIY574OQu8kiSuyYP9aYXSPTKtvXMr08UEnOZ4D04xxZ0XDOR01lyY7cm8uu8xHL5oDuIWhbioatlrr9tHMMo6d/jWhHZVjfYuFz2B04z1fLu6xdZ7vSCFCsBkDvcLYlgTOlJMM0oaYmGjwC3QFA6YhNcrIXMwhuyED1HycvyTWJrtsd6SOjdoQM/hkXU7eJTLAUlQcEKYY6/bt13pM89DmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=560rwabRYyr/g1s1b5TIPo7SaZwupsFnnxwcsTLxMP4=;
 b=LOsfg4CGw734hxMEFCtJSyRp6eZWP75tQnoE2us7vUBk4185yN/lc521S8vWDAQMS0Tr+DJ+I1rpED8To4itx9DFWz/Ze/5ebPDv/0PmbtrlTl66fhvQQnMf50PZF6qIQUpEsA+mp/IUuQR1k7nQtxmQjftfl6b4wR7p3/JPY881aflGYj5DBhOYWLECA/wV1RPbADZSWcT8FTq8PVMpKy7+tqyFFUa/0LCBbAMNml5qfLOxeNhiaf9SvGWAcGufK8z+Lr8JzJAsGPUCNX9eaRqphS2tFl1xPsZwWE+g4/7qmPS4wVkLhvmy41UGLrrqNeO9auAYMjIDqrPYCfpdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=560rwabRYyr/g1s1b5TIPo7SaZwupsFnnxwcsTLxMP4=;
 b=AFy0mJnqijaUWpLCCgE5j0zs7GiDb0A2BTmNHjSeLakurlHwbWYQNKMFnkfV/Jjsc+lLWlkJbX0YZP7Son5Jqv7INA3oUsF3ValKMap9f3IufwY+YjDLgvlp+rRbUorCx4F90OLKTDqPg+3YEW3EXrc9smOqt2ESWV4Y/2b/bZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3685.eurprd04.prod.outlook.com (2603:10a6:209:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Sat, 23 Jul
 2022 09:42:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 09:42:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        festevam@gmail.com, ping.bai@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/9] dt-bindings: pinctrl: imx93: use minItems for fsl,pins
Date:   Sat, 23 Jul 2022 17:43:32 +0800
Message-Id: <20220723094335.3577048-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4375928-a4ed-4a90-9733-08da6c8fa389
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3685:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVPz6IQNk5GXveTmj0TZlMFqq7HuTVfR3FwvWy7vH8d1c7YOPlf2QpEshcMgD8eVokJyzozIc/x5x3lCiexj+FlbI6hEnuIkx03fGOcFOeqlvzBvV52u8EUhjbSR1dAvbhnED688LKUeUlT2vihhu3W0plihk8qZgkZa+7fOglhJZWFB7CYEvO1b9PprxmuemyN6MRtBtucO2SoLalzCTj8f/0WuekX+96orF9XxTHBgLDqQvDrXuCjDDvAm3yae1tI5jozbQP3cLLSytB9jwFNG1c6Z7flX0EkuUumsQYzGJaf5A27j/g2h2PdsSUJPrb3V91SmM2kqj8roFFYXuCdHoKSxeC0oaAra51VijNdsRIvNBOtqRa2B0WGkN/0j+RQKQFhMpFpw9wrd49uDQKPvDhXqE6/Lsdts7RM3rzsAxgCusThW9uHxk42OXLWsxoZjnzERU4MrfQcG65VCsfPgR410k0bUCx+YAUSnDKmE/xtE5WWiIzkmNUsjm8j2T7Gaz5ksAt6ogt9kByf6uefk7gn739zb5iPkbYida+XmibjVYSjKvGp790oOuEGHxTPP9SjQhi/yAac3jTrlrtlDlzc05P48I2dCrGhxQVzttp8MINhBvK4eeTJuMGeK9gsPtiOfvYpKthbZO3GzjUjAHpLg3Pr9rTZwIZKVZZ0Es6Jpo5QqrMdicfEQx3At38KvWRsbEsCsKb+Bq0eAJR/cTf25HdBF/U4CByfYfD3sO5/x1yXJWIQJXa2tBBRK+GFzSVuJ9gjlSoRnL+vmBRRZj6SnvXQ8GzdEla/4rBXNdjqw3tzDuyYi+1EHucX6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(316002)(5660300002)(66476007)(4326008)(8936002)(6506007)(7416002)(6512007)(186003)(2906002)(66946007)(66556008)(83380400001)(8676002)(86362001)(52116002)(4744005)(38100700002)(38350700002)(478600001)(6666004)(1076003)(6486002)(26005)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W7/c8NjussFVa9SfCDFbB8z09OWOzop/dD6X1dl2lFWYeMxHDbnkF7gKFtX8?=
 =?us-ascii?Q?lzMhJPnsq1tLyByMVm7PQ2I7/19xPl7ni5cy4K9GAJ1Ca2Y5btKQ8tyK8FUd?=
 =?us-ascii?Q?3zDSMnQPceK+FdWZJuCUXY9QOF0uvFq5p0c5AHflafpc7OOIl6OUlKrTT+CH?=
 =?us-ascii?Q?6R/QmepuQ1bc8pvnmWmN4l7ww/FhzkJt3fgcf0qKenqQri3A8Ss24vfepKn4?=
 =?us-ascii?Q?pgvCbb+aVPWqtBTBZwy/P6Kzl5uwjlLUfMiiaA/3xc/PWpDhboV6sGTZVaVr?=
 =?us-ascii?Q?v2atQ1otYXJ3KiFe0nZBWxE27w28FqOhpiMttpKnxwFjHxjFQ3m8w7BIPg3T?=
 =?us-ascii?Q?VvoG5vXaumt2/mrOfcrXMNXXBadNpC5FzHiZFyY6f8S28nH0x+/coL7kIv3u?=
 =?us-ascii?Q?ISpDs+EIsTNsfFS06R841+pMYYcxkNQZU6qT9H5/bLFbVizlXILs02DEiNmq?=
 =?us-ascii?Q?axkqE8Hx6MNyHOmGr51iyoUWhfK3PuCcfCjZ+kvT5kY+2oP+zvuRTByvRXU7?=
 =?us-ascii?Q?I95SWWAUOXpXVeESWO3JFlqTg7z9/UjiN5OunORKIh0tdjv7lZ+TScMkb3k2?=
 =?us-ascii?Q?F2TfsypG0aOTOpxU1zPJULWuGWyZNXQK7hr56oQ0B+WZWMmzZ7/cqg6TTsJg?=
 =?us-ascii?Q?/18qh6IpJuI1W2CZPTNif3xXTD3o3yDkbkde4CXbjCocOq+KKo+sVyrj9dSY?=
 =?us-ascii?Q?4CNIU/MUi+9FnFbBaozIilJ/6//7oLqEcLI9MtkW30gKGYoNO6YoPQnFF7Nq?=
 =?us-ascii?Q?0egO6fFWj0HfOedtposdWgPPS7IUrSu5yA+68CJQdUu72A/mjDAaeG0C8viY?=
 =?us-ascii?Q?HZ4pRneo+2mlhV1h8MqUR83iNCjXAKUmyjkRhQIJZqigf7H7bHB0VsNyJzr/?=
 =?us-ascii?Q?3ObQh8rXcU6WIMxOxuyAsOL6Rv5zdiahFlgDpyQTAitri7eOAyyytuV926K/?=
 =?us-ascii?Q?/j/oU+SFiPEvr/3x2t5Qi+R/h0Ak4QwTAfQLDA5rkf3N9kEsrYkbRERcNA8j?=
 =?us-ascii?Q?a1Gpl0lWbMpY0ooXeZAOa9ayyA6Na5MekC7iZGhlhz6c+/2/5F0Jciigj0AC?=
 =?us-ascii?Q?yfl1muasyB+c5fYrRSaHXpEQB5gg62hhqMor41VO2gWFQRy/m5S9ADkJwJEF?=
 =?us-ascii?Q?CJbp5PI2cHd16uQTUNSaX1L32m1RDlS4TToUF/rZInsV1RbcCgwYYtRa90OR?=
 =?us-ascii?Q?s5Nh+StYKKkxIh+KVfo9PaBJFxjRzmTmL9ByCtipK0qco7FeGCIYJ4wTTsgp?=
 =?us-ascii?Q?GZXYY1apmMh6sC7SQMw3GQkWsiexXRAmy1O+0pF017D9fYFK3ePZEEQ3fZSI?=
 =?us-ascii?Q?06wVfT40QK6imBX106hb8H50QaNVGM1XL3cW65KsvAdaFBgKZUueWkeudjmx?=
 =?us-ascii?Q?xpMsa+wAHmz7C2hCEFjC/QjYCxFHcaICxyAf0qOtpcKsQEY7rSquQAG/dRry?=
 =?us-ascii?Q?+j1jzzykDSFi3f9wPGNPjnwodXwrifWJbAww4Epiof0UtBp7eLY2xDQhYT+w?=
 =?us-ascii?Q?+V9sGXqWw1Nk1I5rMcNqp2XrIrNsZYjiDnx3SEuhFEyg09+dMaK2VNX8vqMg?=
 =?us-ascii?Q?dHtx/Qu8Z9xAykJM5CaCkE7Xt1UhMH+c5U8OaXOg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4375928-a4ed-4a90-9733-08da6c8fa389
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 09:42:20.9453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAhvJByO4idSSOXrjmO9YAER7rQTCKdOBFHe5AnfJswqYDaLGBFc8fnvYnVTn9j6DKL2WORg5abzCH/zCoDWKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use minItems for fsl,pins

Fixes: 4ad8b50da863 ("dt-bindings: pinctrl: imx93: Add pinctrl binding")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
index 66baa6082a4f..ecf31c42999d 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
@@ -55,7 +55,7 @@ patternProperties:
                 "input_val" indicates the select input value to be applied.
             - description: |
                 "pad_setting" indicates the pad configuration value to be applied.
-
+          minItems: 1
 
     required:
       - fsl,pins
-- 
2.25.1

