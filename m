Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86358855F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiHCBW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiHCBWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:22:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ABD558F2;
        Tue,  2 Aug 2022 18:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/Gs5NPpSDt3o8UF5ANJVojdj8VkxUuUe3KmqickEHbhrQM3FoCkKHh3fEDKY20xPW6oFWbiUJilfr0UgL13Bqn59FdIggIGXdF5pC4ecdyOc+vDNkPmCtX1WQSl9ZALWwaHTnAKRUUBx4oMfnTAtA1EBP7nyokPU3q34s5QuhLEvRQ/4qnSWLPj0txYXIAPD5SrbqoY0DyyldN1wG9yQY6kY23h2LE82fDdAZuhikqNxQvVVv+oKLIGwYUeajcSdaoX2ldZ9ph9icg3oVa7glQXKKi4HqH2ocCjcymMIMFzQ1YAjClz0SnrCgvZMYUq9at0z3JZNM+g03m6X9lkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OENOBlSz6sGIJNb9kCDJs9MgP3gVRqo23cDYRIw7No=;
 b=fX0SSRrXFUvRSaxY2pb/fsrZ0nzxbzVC1gszXQ9so143UNogPXfA12LywqJly14FBlh9YEYUV1kzz+DyjfToCZRKUoDvSgx8hOT8cGZM1hvrjbNFvzXOQfCdSmiGdLE27o3ID/sP3IUHSDvApTnYrAerdjev74X/dM66SEUDPjMLsEGA5JI9G+EpYIm3zqTW7eZjnbfgyP4tUvL5kRmIaLbrtz7/ffBWxN7AcmKLBLtrselgmMEwz9sBwzyT7nPCleIgXA2nb8v22GBZHma/kgmGCifMUJRbU6GliXszoyvT3Y0s2NCiiTvJh+SXSGBHQIVzY7tWt3oQFv9Gs8KVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OENOBlSz6sGIJNb9kCDJs9MgP3gVRqo23cDYRIw7No=;
 b=NqdgGhplAqS4ODtwqeA0ESxpGbJBMkTFf5qUENmYjMNfQXkos7TeDt8X7ynv1zOSplzazKo9vLiydGH/z5OTMTQGORndfX24azXRpoerzBkIGY9lP3fMBEJ5/cqQsDMHap6wYjIPhZm4ctSccpuRFlmblY1hQdi+s4mwVWPccJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB8PR04MB6891.eurprd04.prod.outlook.com (2603:10a6:10:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 01:22:49 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 01:22:48 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 1/3] drivers: bus: simple-pm-bus: Populate simple MFD child devices
Date:   Wed,  3 Aug 2022 09:24:19 +0800
Message-Id: <20220803012421.3410226-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803012421.3410226-1-victor.liu@nxp.com>
References: <20220803012421.3410226-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41a0633d-8756-42b3-0b22-08da74eead60
X-MS-TrafficTypeDiagnostic: DB8PR04MB6891:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrjyZkZoVr7KgHY8wflRmJy647bP2Iu0yd6FHerx1jP3tpJuQle0eq2Xer04vbbNRFsRVr83238eUdqpp7K5etNvd4Y7HWznTLLCXi8jqpIPKDAg2x8TzZRTomaSL/4PQY2PYwUpJSB5WrOrd6iTJtmg+Bc/XUVLkucysPcCNbWzA+YcQXRQATESuWTkWc1ooPML20ZPgXFoJKTXlwyHKHyq2JEi/qrqNN/r5JlYUdlZkzqgxhFm+NOviiGxL0Dh1tBshb+o/bywUsaDbaRahW8aRbN5opgaEJJEsdWs+UOeJZ/wtfRDOtj7wFqaIYh8qBZsooGjeaBHfqsosY77BU9ky7iWw/FbDZlwfKdL7Zped3dQ+BFZfTHVwNKHhsJIWTIuvSxdJoNS/+kSxJDkS37fj218ZKwrAFdkvpOpfFY0VbXO5ljtZbfttt3RJw8D7DYtolplV3npa4v/FY886Qvn3zLt/H2oNK56CQAAIfqvayuMr60b/DOTiroef8Kv93aZfefk9viOftwCOPujUZqBBdFPK+VrCAcF+c9Z+qDJ/KRFXBs44zo17ioP6ua+CAsersj/ywtVrU229XulYk6BPKVgK0yIPCpjsMgAUhF/5SoPfhxjZ0tt2tOWS+J4cfh6Ec3+miNh3eUwcOUtLVKR9XZMQHnOO4n8ti+N16GkRqe/FF5JlMO5pIF7Eki2D3j5ithfBdO9E9dKd2qebNPWIS8mTU4kNG5krIlaA1YhPm3ZKlFeuZCGlrDjyr/N5Cu9AEFQbLqUXbRGOk/40hDl5+hyTXKHndXSBfopvdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(316002)(86362001)(5660300002)(7416002)(8936002)(66556008)(8676002)(66946007)(66476007)(4326008)(26005)(6512007)(1076003)(83380400001)(2616005)(186003)(52116002)(478600001)(6486002)(6666004)(38100700002)(38350700002)(6506007)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/lIn4iT7gFt8TDP9+XXsKDhSkE/xx5E8tOZYbqlrDNx3EkC83pgq/Z4+kztr?=
 =?us-ascii?Q?TaELEw4AmCqXtcITiPqSwSfRCsgfvIvJkQfkoGE+8hGnnx9oIRGeTOiUHCTb?=
 =?us-ascii?Q?cCRLVYhAm+dcisiJBGDjYuMGr0U1FcgKMY5bIakIaLX7Uhe4QdWHN1ejudT6?=
 =?us-ascii?Q?J+jSl6oo/t6H+xsZ3YGm61fYsgsPgBU576oArkCid1zgofcb+mFwz9JmvSja?=
 =?us-ascii?Q?vsuDcnACR0inyoF8UY6hyAyTsHwcfQuPRbSHuWJkg/jzXpWBEay2Qwck6WZn?=
 =?us-ascii?Q?VXavnKZja8IrnkPPsLa4AkDzqRsxZpEiGZfLiAjQGr5ZvKpY00SWdcZvAK0x?=
 =?us-ascii?Q?J76sOzl0FsQVOHacdIqFsZhl34kcBaZzQM0KxrTWXaDCYYq/QVGZQ1gTREcr?=
 =?us-ascii?Q?aIiv7PRdvkTwM95RGQvD6qATEhSid5mVfCsOqZKypiA31v1863VU2C8HMdEw?=
 =?us-ascii?Q?2V5tiEaRGry784WlDLCkUp89abut89rd89qm/Ng3g8cKjdqIQ8Ga2R4B/Fra?=
 =?us-ascii?Q?4/eO5hsz6KhkrYBEBx7Q6S5jZrIrw9IoRGb2fTE/0otzzSIZEe6AG8ZwCvnq?=
 =?us-ascii?Q?9k5S1mDzMs6R1DJ1xIYBjQYsXTXZSukEXqL8F+uX6H7SnTpkhXdfl+Jtryk1?=
 =?us-ascii?Q?FHUCi2xsONAcJSn/CBfP0V28eUmmwuuPv0GAeRXfD35W+I1vUAx9sse55YkG?=
 =?us-ascii?Q?96puk0092XwmPpkNgjlZSdfxGEnKa+hYvZTdIMbuXCMPzv9o41xhuEn4Ht4M?=
 =?us-ascii?Q?FX7ZdPzIagdgm3f5n3mGvw/Dl/WPvZr8RKdSP8h1WF2S+wYRPhBmzy50OV5f?=
 =?us-ascii?Q?pAdRrjuTCDcA+Wrt/M40giiR25WGDsi/lJMxv2lLZ6oM0NxnoNT43Jgt7zTQ?=
 =?us-ascii?Q?STFycp1PsjXqujBZCHru2Ei2+50Bo4xvsmU86YuBGVppGwmfrerfIx8pXxOp?=
 =?us-ascii?Q?e46YpfjEVDHatfXISUeQSAJ2a3z8FYJNlRpzDi/9bqjxib/+XVUNEM50gTdG?=
 =?us-ascii?Q?cVySN1hBFrFYMcuH1DDGvkCBF6OdPOMLtgbOEhOVutfmV8bWmlLD8l2u63SY?=
 =?us-ascii?Q?xIa7rKQu0eGYPcV2T+TyVvQUj3T3jzKpR9wFNcJn7GTilV9obwkqQyDhfEkp?=
 =?us-ascii?Q?UAnlui7qj0ihOceUZCARg8npEjjNrVsCV4OBBnxbBZKCBLzmmVebR71SZrHG?=
 =?us-ascii?Q?sA1ciVkDMT1SEVvc2D6QAMPJpWIEWhtCTYameoL8IvcyN3+OYgVSRDCIrwFU?=
 =?us-ascii?Q?jO0OmXZpOhh1Fb68N7+63uVojFJhEsyBmKVA5DpI0wPoAZdnob6OffQNq8eP?=
 =?us-ascii?Q?l5VEB5fPXBfX4kJk7xZDJfqpQKsIJxtkKvyWiKqF1Orf1oQVEQ2mt/hl0W+m?=
 =?us-ascii?Q?CbeKa3rUvvubUUVn2FePmt1ZqqkA6xeJUApIn46YuplnlCbls07z62a6PCdl?=
 =?us-ascii?Q?DxFDCdg1Tp8OTt1PHQh++DUj8Pve9W+0AXHbBOKUJ+Ol0/kHxSxsfr1YV4vl?=
 =?us-ascii?Q?rWF2b6pYLt6dPwibyLTo4vox6iaP0csnf9hpREEjY/fap12x+r7fXBbuCDeG?=
 =?us-ascii?Q?hUBMlVB/q5+yxs1agNM6E0fHWa+ocOzgPWSqpygG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a0633d-8756-42b3-0b22-08da74eead60
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 01:22:48.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW0schZR3c4rteiE+DAc2rNd36Jq80P0GSfaCVKJ3q7cDbS8iSS3dVL7GC2MudRQZSE5B25bHiFUjpCGesN9/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be simple MFD device(s) connected to a simple PM bus as child
node(s), like Freescale i.MX8qxp pixel link MSI bus. Add a child match
table as an argument to of_platform_populate() function call to specify
the simple MFD devices so that they can be populated.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v1->v2:
* No change.

 drivers/bus/simple-pm-bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 6b8d6257ed8a..ff5f8ca5c024 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -13,6 +13,11 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+static const struct of_device_id simple_pm_bus_child_matches[] = {
+	{ .compatible = "simple-mfd", },
+	{}
+};
+
 static int simple_pm_bus_probe(struct platform_device *pdev)
 {
 	const struct device *dev = &pdev->dev;
@@ -49,7 +54,7 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (np)
-		of_platform_populate(np, NULL, lookup, &pdev->dev);
+		of_platform_populate(np, simple_pm_bus_child_matches, lookup, &pdev->dev);
 
 	return 0;
 }
-- 
2.25.1

