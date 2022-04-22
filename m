Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE850BAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448942AbiDVOzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446549AbiDVOy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:54:58 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408645BE7E;
        Fri, 22 Apr 2022 07:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU8qwXMJL1hJVnBwj1dP5mrZ+wgo6BEKFfUjX1gckx7DI20Gfjic6/URrOEnudqxu8G5IUtw/IJuXhma06I0yWhF4NeG5/wwZPWAh0asrIf4wFtRfIYEotY6jDiIGyYS3TK8w8chAQNd3xci1pI9aS41slEhcm47cpfVTTj3mwqxwqKTBKlQnoVXTuf0+8NYiGFkUAlpQ7pWY6DZPxIuGojUatNTSCTF1qGIi29He/aqQW0Q7WSyE6kO5xafkuEZkmkAfqR6jj73bB/5jDv99lOz/zMJknTYX8iM+9rjXkWMnM7EQpWL3+69CzZ0S4FHqV7wGvzd3XFKDsIxtdJdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYCbLcah//OkAMJ1+1xbviNQnll6w0JOGqWuS+eEyuU=;
 b=hzw6NvnYL0h3tOzCyN+RpaXD2pUKXSieDZGpv1P8uk9ICG/wBW/+p34tdxbXZKQ0yprFF38Lpb5efVspyhOwwU8/PGh2TRMPHqksyP6qgZtiCT99QvxblbttLYDY2/bNnQvkQ/Bu/0kcbee6RMjqfO4VZAy0rR/JptS3P6EEAevbQw/K6Z8K4n0qLEXErhATUh65WyurLVfNvohwUQT4ZmcF+P1jzjGDf+yYXRZsxdpNeoZr/K/Wkhvv4f/ExgT8HFOXpRTO7mJ+LVFy8fj1ltdl2zln5/lyjZv+rads6O33tFukhu4UuFcOBiLQVaSDft8IzS1xOItQAEdJZUEagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYCbLcah//OkAMJ1+1xbviNQnll6w0JOGqWuS+eEyuU=;
 b=0U1K01TUun9FS73yMa9mR/mZAnbkq5jqUxURyH880P7hbn0QK9VH9PNpWu8zSlGJGj2v3ceS2OWPWqHqjl+l22UoJJwgcc/15f1PdLolCiFGRhaa2c0OufTKXh5MqwYsmE60knBcBgSphwZzsKB8FjmDdf7S+PPjznJhDRVr8ad8W7V04s7RmLxOkalVbmpqqqKcm/vQQyqScsiLfaQ2SXuG/bgundNAw7SpNUCScUdjSUdJg9k/UB1n6EzWe9nzf2NoiBNVIYpAKLZlHoPYc1p+ycxLdgVQZNW1uzVoOIg+fUAiMFgEbvVcXWAZqNsqvjVAQjOpbxSSh4EH0vWw6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB6PR0302MB2792.eurprd03.prod.outlook.com (2603:10a6:4:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:52:00 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:52:00 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 1/9] dt-bindings: nvmem: sfp: Fix typo
Date:   Fri, 22 Apr 2022 10:51:39 -0400
Message-Id: <20220422145147.2210587-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220422145147.2210587-1-sean.anderson@seco.com>
References: <20220422145147.2210587-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e28cf30-56fd-4113-21d2-08da246fa7b8
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2792:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0302MB2792E8FC27499018F575847396F79@DB6PR0302MB2792.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jG4iR+5DfOBklsVOQwWN5l80Zer/IClfM50ZV8gENOCBJ7k6wkM78FqFWegNt2LW2ukylljkSK+mt3+UPLeERKhoFfppDc2F7cfjMYXb+1vUABFSaPdZHJn5vZ+KvtL//A236pS6UfgLXt/prqR9jUC0Q3JD3/aGBBRIVFfyosytg7rlIIMkxAxTYceBnSODdb5yKioOB/HmEy5okY66PMLBRrnEWA/dTabzEAZCK7USddlsYPsIz2VNO+DC1984mUxW6G7JQIL17v1Ic8+tLZmKydaWFtTbVhXWZfELmfy7lwV9RxWGAIVNbQIKMzuwtvCyXhJgo222FBy//Yr7L1OIbKB7mo3rcxZc3oSo0ypsUPiAAl5e/Nae4vsbBLg31x57RgzBc9TdxeLGaEnhOSP791l6BAwgCoWnhNvePlgr7r0xRpBfN1PAE2Zpf8GtPlnTFNpWFJUg1BFcreeCSwvY12vF2t/idiHQakOcUZZYicloIlCMN6baXMA1mEGY4K0a9CMY6EwNJrYMPpsB3wF20u0S9Gu85hx/WFOyAjL9QzeLYnWwUG3QhqnfwLkpNFuRj2g0UTgM9jrTjBZBK1H8BdIEwr9kJf2lkUCFccoJBF0UG8JucckXJVcksWcIsAcjuhEFVJttz5E8BuwKAk+PLg1BTY8Vusm4iDwrQXEjQHsaOnxPe5oXNYLjZRS/SfGpCWs+6DF7X1tJmFqhMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(36756003)(6486002)(508600001)(186003)(38100700002)(52116002)(83380400001)(8676002)(4326008)(66556008)(66946007)(66476007)(6512007)(86362001)(6506007)(316002)(2616005)(8936002)(26005)(1076003)(107886003)(54906003)(44832011)(7416002)(4744005)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C0X92PPFlUrt3pqpWx/ttVUmRN8FL/lJooQP9nbMBN2sAF/FBgqRHH6o1HnE?=
 =?us-ascii?Q?f9iUBrFTAtJaMtp5D2KqU9s+iCWuBbnneE90pT9+VUaqGk3yKnUB+DMq90rp?=
 =?us-ascii?Q?C++ww+aiHSjfKdonJrhHJUMtUIMKwYIlW0xVwkbEZh7StfMgvYai+ZzPMH82?=
 =?us-ascii?Q?u7NPWYmScpwXPWizlprKYaXpTB9FD/lcRRmHAi4MhmCTzHhkHph7p6WzfM6O?=
 =?us-ascii?Q?4bUhho3LitYy5jA9ds7fvbC8icIQyV2yPbQehv2iNQm2gLUOGab/FxmvjN9N?=
 =?us-ascii?Q?UbWTyXQTM6AG9QkIbzgG+OU1SKbelv5PPeePksNRj3YWLmHpb3gfvMXZIKe9?=
 =?us-ascii?Q?gppFmsYb9hl4W6gLxZHP3N9utl4qBYIx2ZsA/4TFWR+KRsB0ER68V5YcMcWD?=
 =?us-ascii?Q?rnXHhdWDFIcMjFMHdk9TXd2veByeHOSSLzIH7VmxW9zQgnj4+CMDUeiOYVVa?=
 =?us-ascii?Q?/aCaURZKaAzjZsvC+OoP4uNMx5D8ewUkXlsPZfNMOrP6SPf6kefz+5vdsA0h?=
 =?us-ascii?Q?ldYP23TNKJq8FQhcU+63DQJF999PyJqyqz4/o4YM58X7MfrtI2n4FEtG0/2c?=
 =?us-ascii?Q?eF1GoJ2VnvG6n1zjzk3K4WWJwnOxyEjRv9b5IwNE+d9gRlKL8no2RVlEQ7KH?=
 =?us-ascii?Q?OETeh0LCDiNqAGvOcnbv1m2HhgsLWOt01WeBrjFHS5kKmfw/Vmiw9Z61aP2a?=
 =?us-ascii?Q?GNFggGMY+uHseWkHWCPyvJjMhugf5GhE0no8uyGiNUdHOTebc1ZsF2sLaSho?=
 =?us-ascii?Q?uvQiVWln/m4nPA1MVY6H8CMsBwu5zssnzckmElWk7ZJEqKY3sQNrKz2FRdTt?=
 =?us-ascii?Q?JIJqdllau/sb7hditwmQlE5PyIvW0YOu3fzRfq5+EUq4VXIKB+J2DC7Zy2HN?=
 =?us-ascii?Q?xY+gj5IvrHRyIWDVh6o5d/yI0H8MyuwxBx/3yNXzEsvlg2ia+oIf3N9Ph4zZ?=
 =?us-ascii?Q?WW0/Uj44DzutQnQSJHbxaxeA8nzfmctc96pIMUFD5qDVbrRa3ebisxCaT28O?=
 =?us-ascii?Q?pyf2DRnbH9ko1jW6gzNEvpLA8YMOYF8SXougl+DWJxPBgWiFQ5TV+dHYIkVa?=
 =?us-ascii?Q?o8sDyVoGNSJx70PBWPtEVfjRV20e+lcTj6S5Br9J9VL6EpuWgFVtA1rC/A2O?=
 =?us-ascii?Q?LbAM75cjbMdJSEa5Z6QvyYIGfDI3EyYbO8Z3LobiREhSOwI6LSbFpmV8yBSA?=
 =?us-ascii?Q?TA0QVy/MSe5XsTu84YG+nzahKaHSh0uBTOCUDR5T0UBoS4jLXSvDU1Tp8vIN?=
 =?us-ascii?Q?LLa6+b/JxAnT48QV4RehPywu0NZeHjhFYdp0/1U+u3cjveYIhgfdO1f6qXUf?=
 =?us-ascii?Q?ZgjPjAp5DY25bJ33ovzBf0T3Qb8gwxUGehwwxYr9SWcTuhuh8WI2p1V9Yj3D?=
 =?us-ascii?Q?nJ/Byfvcb4gpDLqcfg+N53jAKQMhagO9BBteJuyBNTr50WaQhyy36BFI5Gnp?=
 =?us-ascii?Q?zxkGfITw8vdWR5uP+AmTQOReTmSMN1Eqw89DNd3UOU2zdSPBP82tcMpPr+Th?=
 =?us-ascii?Q?gEwmNsah8OR6bQIjNZ/Wygguhzo9sZKQ7S7BZe99MPAeT8XS+mzSLgvJ2rPN?=
 =?us-ascii?Q?1JILAFXTkG5nxH+lECzYmgEyHq/V9OEk78xHqLS1A735uGb6FrNNAX5D1ZHV?=
 =?us-ascii?Q?95YZsQiGBWkQljNdPbnqhw7uHSq/sWdZyMYEtqOomt5D1qxcLaue3vRvMZPV?=
 =?us-ascii?Q?eev70Xk3sADBaXAk5qSHgcQsxzwsWSpTlcnfRYNQKhnsCJJgDcpMc/hAPGrs?=
 =?us-ascii?Q?MudHk9C9CusrVkBxCwmbtMuEdNUbiLE=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e28cf30-56fd-4113-21d2-08da246fa7b8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:52:00.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usGUA8yn0OJFixidSh6v9c/1xfhXWwP+lBmSbVKD5KS3YYzPU+N0nZbMgMjAP9Ig8zIePxaBEOpz6DDh4C2hXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2792
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

