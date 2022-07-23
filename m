Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5485857ED3B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiGWJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiGWJm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:42:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422733A03;
        Sat, 23 Jul 2022 02:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfDXWITCNgda6Xipw+ITwEq+3FkbxK2TJQhXUIbmvvWP5ACclhOCPBkpXuJVTTVW4MWjrr81UbCxhoR99vkv9/EI5MLf2t+IUWd5YqAZh63PP2xuaCK4tBdN82GF6jVM8QhWTbVhg+xTM70g9mpbOK3GRZzCTesaWP/uGyuqbrK4VyuXUdiYtUwEtr1u8eGd4ln0nsJpC+WBdQkTJ0wj30oc3nSwUqbOzahDDx9ZduPUhU/FjaVFiLAkngSC8797ktwCCa1G2ZuN6pZAsvMyTKcii6TZWemwT9+Cfn3o9ttmO9gkYcA8K/nKgXGWVBP7EIicNvX3ehnaq0mpDHMOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBW7XEQsQ2I/hDdqNutQ5GodoJZZnKdaa12JmYsIxdI=;
 b=VU7yY9KxXhQIF7IhyVpPQidA6VF9hU+ljBKiFRg9zfUBe+FlraKLLM+ztbVhb9bIoqL3S8vUkY+YgH9BF6W/MMJ+p25gUUqZBqjG0ZrF7XiBAhjSI8H69SQugu5cmKGA/OakNdopBWzCX1ScHg/q0FSGaPsrW0hQvR/MYQaQJUiD9snbiTU0FnXwmSOh/M/0ekw8cgCbL5rREdltAa32Uxz4Hp8rVqlksGesqG9Pq3Wyy7JcqfZ6xIyaCgkP6dFtu5nhmJl/gauroliqW8P54Nl4GcBnhdewpJ7MnsaByoqdFTbyvbH3QdU3jcouPfJUXBdFtMHH8E+bwVI3RaZ9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBW7XEQsQ2I/hDdqNutQ5GodoJZZnKdaa12JmYsIxdI=;
 b=UZ48RQEpZlvsy3xhF3s9WfQz7SgIfzoFYSi7XYgkOVDbHeXpsGCCRi3dHfsJPhiMpm4oesZqAMENZzZu23LpDeGPQ2QYHJ4pROZhcYbowoPBKTWogs97wlCE9ldogpbKKz4IQqHzlIYEQYj82Q3mrTBGG+ZzlCDcN4CzwCfBKNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3685.eurprd04.prod.outlook.com (2603:10a6:209:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Sat, 23 Jul
 2022 09:42:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 09:42:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        festevam@gmail.com, ping.bai@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/9] dt-bindings: pinctrl: imx: scu: use minItems for fsl,pins
Date:   Sat, 23 Jul 2022 17:43:33 +0800
Message-Id: <20220723094335.3577048-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2a45080c-beb7-4c4c-42f8-08da6c8fa621
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3685:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqBls9HRfmjOfcT5Xxi+yiQOiRXhql5V8uOVmTOuloVEmzq7JdDZ8ns0SiW2gkganN4PwuCZQHlOhYebdlqtAo7y9pLh5CWQGVIdpgUPXzUR7JbgqKTBA3ct7egzWuF2KTlkZvrWlgBYFwt3RVlWmVLa0HBBaiETRmK2SdNHtnCyV5X48x9L7pcaLLsxF7J4HA8gh1Kb944esjWii0KH+aXXRNS5EzkUbEwan+Q4GlzyeKI1Wd4j12Exn2I+slO+74l+r6/gtdHO0MymhcvsT3f++hadM9JP4rxsXKkKzD5IRSthIL19lMf4c9n8boPHzqTAleuI2vY09Qinqn1cMvB/jow9REDHkIxgywsHI8dpLWv1NdV+RiNwXPmSTyvcPkKupbrDKfJyy8mxPyvcdZepf0vTJjIu6Fx8lBb3GkJvIyR1Z2NIsTIW3armkz1q1ePcNLJWgDqwjEeDuL59zJF8XZqa9oL0/88nk8bTiQojHEr6BE8RMA49Y/Yr/nzwdz7dimhT81yF4UXbV07tNlBDif9XrQB5XezdLh243K5quSe/HQxs1OIkuZxcpps3AqGNHtARdW42vdm7+DEdXuafHRgQTCzy8xfLiTWV8lo3eYmkr5P0RlIBic2w12XESFioGmUkdZCMlLNg49SJ0yEr57L1Z+5tBK8NMFVs51/ClfjXUR66iDBEwOesOfQaqp5zfbjE8NWv7pzYbgul8Y2YnN3C+gzuoWklBNZGtQMJDObxizXVSAUk5WESDvP1k1B726ad+3qTZ7eaezUyg8VoZyc1aGOaei3/q6O0KnZToqXhyGEtAZNmR3pPFLI0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(316002)(5660300002)(66476007)(4326008)(8936002)(6506007)(7416002)(6512007)(186003)(2906002)(66946007)(66556008)(8676002)(86362001)(52116002)(4744005)(38100700002)(38350700002)(478600001)(6666004)(1076003)(6486002)(26005)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zdolNHx2xDyTfaodtNUcY+GBdCigUxOGvZJ9CKYIP3n5h7BcMY8HuMVSAcsC?=
 =?us-ascii?Q?YLTsOvjZv2tJ2GWXgJe9P+xe4nDUqDlaAvtkAJbfoFulNyydbpsaOPpzwBvS?=
 =?us-ascii?Q?LxNYTLZPg0so0yTqj3SxVUDBD85YyJ5N4ugMpeduk6JQ8Y9PdIzmPqF4CpVC?=
 =?us-ascii?Q?xDZvayOKihIXDsMQOSla0nmIbvKMKzTC14lKtcKRemnx0uBjykU0NqA9h2kx?=
 =?us-ascii?Q?Din7GfNdqn7nP9q+Yl6CkZ4p7GGz1mxN57ZpAKuKTno7gO3qhwIxsqmnuuUK?=
 =?us-ascii?Q?u4Mzm9lWeX4Ha+py/gapXxa9hbn7EK8aZ5qaFsI9SH48n5b0s30g/hTTK6hr?=
 =?us-ascii?Q?wjuQIUjj61U68JGi2uYjlpNoBEyqiG8fd2Zd0k1PTwHGyjZ0uBNxV0LnCoAz?=
 =?us-ascii?Q?/cCtiPPhMThtQb19R6YqchctJycebDT7yh44bhvcsusM884xt1z9W39PVug2?=
 =?us-ascii?Q?SsrGKsXJDOf+i81GaujvULUKPmQTP73tlag5CJ9SAvKXQwGPkUilTp1rLs+Y?=
 =?us-ascii?Q?QIa6ik43H+CkiLzcM5PhbjvYhcF2Xhc3eTdkrlnzSnvaqp4kLXEcvIMqm4aW?=
 =?us-ascii?Q?tb5KsbfZ4QOpwCR7UQ3m0bLyFIBZaQRndAqKVvCXpDMq5Ort9BEfSzJakgiz?=
 =?us-ascii?Q?hxDIVfd2WTGZ1TA8mRJCYC/5xlAQSwyD91uUYRbn9b9wAUkCyHFzriubqIws?=
 =?us-ascii?Q?lFcB3F3sIHe+3B6qUNJQ5ovU2vf4BSA39SAnZReRwwTDhY/6cAZQ9caU9AXx?=
 =?us-ascii?Q?nxKMgAzCpWiZ0jW7QNpnjkryvzUGPRoZEfT5tNKvXLwlxaYUBML+hAzLQSCZ?=
 =?us-ascii?Q?9BwHUQCghFZGq6dupuG8fyr/6tuQnVpc1nSVKc+kpLfkdJEYMQEhFyvoNSDv?=
 =?us-ascii?Q?4Deoc4f47Nxw6R0SimNv5cVyCqP5mkgiqMGk2SBRym245q9WgupYvMkV5tA0?=
 =?us-ascii?Q?yfmTv4E6s3SQ5tikQ0RKsYKftIk5S3U5vkTDom34Mv+HzbHiwftXKncxMRJv?=
 =?us-ascii?Q?hENDlWUu4/4Z8cUMWL5a2WXrl4BOVGdAVngnWPxJOgTguk8IIO77FurJVyTE?=
 =?us-ascii?Q?1+j6n5awe+aTaxn8YyZ5kvUqzZld+ozeSM+dtmqJQHFLe7CvwZQu4FfbYEdn?=
 =?us-ascii?Q?EWH4svlToUAf3DZV9j4ZEHZB3UkC0GYu0/gTL6aUsFqnRPIP8Q7Jek6c4v1w?=
 =?us-ascii?Q?xRmdgKKt3FMl9AC8ZyDHywJHgiftVj56DWzfEhYLs4A4rb30lawNFMBENIfJ?=
 =?us-ascii?Q?u4ZLr9ymZaDqJ6ClWxNNw30dVsGqccjHYyKa1RC8UaNs4/0pwp8FGiJI0W8+?=
 =?us-ascii?Q?RzY9ktsV8R4HoNEuH9Lzb5z283yL9q5Mpd8kz10LgDainHyHnFrEkW3ycuAv?=
 =?us-ascii?Q?Vyrh3CF9PI5uBx9SNCq9IBotNxmL6u6qVypcFtMjMsjIsiv1OgmRBAfHWM9L?=
 =?us-ascii?Q?INUUqc/Va5rnsuN2NftPKoXAcDpC2R9T4wQSKdkXB1clVN2MSoUdMQ8JFyCY?=
 =?us-ascii?Q?WsUKUptUPEiFuhOcC8W8go+dBLlpoFC05cbLR91scVehP8kQ7T+aAAHt2wgw?=
 =?us-ascii?Q?viW4u4wwWWqE9srVQOubquJJihgH246RpZvGlS6Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a45080c-beb7-4c4c-42f8-08da6c8fa621
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 09:42:25.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIncC59a0JcXoo591uZe2hTNNef9e6i8a+KMyg7TnqDNEm1Sz/qA5+RGlR+mklxHkne/QFWBSJU16mA4sl14nw==
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

Fixes: aeb871d67988 ("dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
index 45ea565ce238..793e9e9cb597 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
@@ -49,6 +49,7 @@ patternProperties:
                 "mux_val" indicates the mux value to be applied.
             - description: |
                 "pad_setting" indicates the pad configuration value to be applied.
+          minItems: 1
 
     required:
       - fsl,pins
-- 
2.25.1

