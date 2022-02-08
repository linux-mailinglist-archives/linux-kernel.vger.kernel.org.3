Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C144ADE58
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383349AbiBHQ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbiBHQ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:27:13 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA5DC061578;
        Tue,  8 Feb 2022 08:27:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAcnpG8ColMku2LHhnWmEHg6xdfBNXSuaOd7Mct86m6ogKMXIFvHwF++MrI/HNdO0Vlu08Tqodonfkmv7cZWm/WJIWJOt2RuFARiSjuOkjDEiKjIrP+Q1Rmqe/7FbrA4mkn+1kB5t+AlWJNpvkg1DR9UgzxTqLomBW/nHNet5G6kZkuNd+z3kScDlH0pZI8iJ6jutbdoz0zJsGFbVy27R3i/PTxKRlyQ2ldmiZaTMh4K+eZLhVJ2ZJCY0M4BQ+S781GEIGTuUZf3JQxoZirvaa11GeC8B97UaaG2ULobDr15gHGC9U+SsyXLgJv+tNmjnJPbzb2bXUum2+WXtQ01aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApcpdNYhzbiDgY83yyMwYcoNlgzjaYlGfFny+L5eCu4=;
 b=KPIyzxO+ftLd1tXJsKcTYAJ2bxUR26fLcpH0WSrdckB1ZW/ft+FCbHfwBZdmHDtOTUQlqKNOiDSBWT9tw5x2M/8Il/goEN2gokVr9CsI5XIR/0jesBSbrFOzBBNBQHg/5mk0YzLM9Ma3hnsR/XtHA2G0WXdaeXPlxIGUHGs4Xfv7inYPeuprBoS09J6wXAlUBzAYCpD9hp90NuJyG7szFamAmvy/qNm0Fxt/ZfmqcgETCAYyoLrEEEhss13FtcQ1NCeQET4kf4GASk9qLI+oMAduHMfirGD67saupAJ8tvfKoMW590Co+L5Eo0JeyaH8JZniAl/Bg0Yht2zd4mZtCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApcpdNYhzbiDgY83yyMwYcoNlgzjaYlGfFny+L5eCu4=;
 b=WAiCARJfLDnFMysor8FgyqdsbVxcKx4PBll5MqcFT9bAukNqvG99XWNY3kJgf2+wQga/DoWauHVUqI3tDevZVqNM9pXwYKYTYqQnIKhnMwmZrnQGZPoqm5Wtce44huY//fWt3woekvLtyzQ+R87UwM09A2tmrr+Oyi9izi+91zOjdccixslb7KinCnTJelxN2CXELDtuWzO4ywYdheXJVxoAN9qPZ1Ib4khU3uqZTCBTu50mTZODsC6t9SFdP9N0Wn4N27GnRNC2qznf+0HTkO9Je31eHyTToA/CGoItNSiCMfBe53WIn7uJjeXOf3kkxeYxJj+bIL5eO8xOpp7Yvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by VI1PR03MB3133.eurprd03.prod.outlook.com (2603:10a6:802:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 16:27:09 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 16:27:09 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2] doc: nvmem: Remove references to regmap
Date:   Tue,  8 Feb 2022 11:26:57 -0500
Message-Id: <20220208162657.724119-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0244.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::9) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fed9347a-465c-4994-9dc4-08d9eb1fda60
X-MS-TrafficTypeDiagnostic: VI1PR03MB3133:EE_
X-Microsoft-Antispam-PRVS: <VI1PR03MB313361D65452F6F3DCBE5ECF962D9@VI1PR03MB3133.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tbZr0LRkD+JCS8UPSGZl2jn/63SYAkQ+9q5HGc0N0/WUNhOfoO5iDvx7h3glMtlVV4okBMQgE60RDs9gctkA9btWwncQ7XCrMQqWghsQv0Een3rDwGRs5DDzcxNyUVxlzoKBaH8LA9r40tQTov8An5MhibrQfQTHQShMRI+PzERUKXEVc//MDnCqhjUCFgeiO/EGwoHoggiPKE8BB1lnT+4fZyeYHAUH3siFxPrfu9PhPg3Wgl6zlwSm8LXFFpGG0QJ7cBhDvzspOSWrUUrr4jJ4tmjBmXaSdxfRXf9SjaV2W2WZqvITiDwv8TUzu4dbvVsQV1qgSFCABRH9kjQPvFAt36F6E3QWnKctaE1hUN2i0z27eFhtnOoqstPrAb7BHLtQlknBwJN4ujEvF572VnaGE3+2GoO0I0EHDzuPj8X5P+qVezp0+t83KyuAzEUrtCKA4tG/d/MDp+3Lpxbd449cShXUVHcLJP+UJqzp2adkfbmXxyXnyeInG6cdcqARiV17eX6/t+15xAoTfp1ahZL1uFHYHVy7CoCFVRPMdU35S80Isv8dFOHgFmjF5/6XNV6nue0gIVokzKQwHJva3vU9tsQfxkUDJ5WY7ifqFZ23WIEf9rF4rV3yfapKauLGCWohq7V5fWphZSXk2UxHeEkUXIcs1ZvW4Z0mwy0om/q0iWebJz7mlA1arPLFyGTOh6R6fQ8P0aSwleMfPoONQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(38100700002)(83380400001)(36756003)(26005)(1076003)(186003)(2906002)(5660300002)(38350700002)(44832011)(2616005)(508600001)(54906003)(6486002)(6506007)(86362001)(66476007)(66556008)(66946007)(316002)(52116002)(107886003)(6666004)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?csMY0wF0vsPIGU8arqj5YqWcsvC/OvwxSWSfOgGHqqSsdCS6ysQdZ+MSmawP?=
 =?us-ascii?Q?Pd+Lv/pnUH9PES02nbJovMDaKKu45NsKBZbSGCptu3GeCrn8p8NQO1GibFGZ?=
 =?us-ascii?Q?v795GmAnic9znZiWL/c7QEeapsw4gC1ELl9b24AizIHx2kWD8buSvoO3zJuo?=
 =?us-ascii?Q?dg0TUeZy1m73rNnZb118GWYW4/JumuAiPCsaHFy/NX6UB0jRnIA3YWfk9dpd?=
 =?us-ascii?Q?1ItjcV233EYruKbMXFG0C49a9D3RpB3JdiAEE6MBz1p7K1OhiL1KzrMGCYWH?=
 =?us-ascii?Q?OqcxzCQH6/tnXGJwGY2hfxlGF3VA7B57RkvdvXZuxeuFLYPpf1qhe46D+8AG?=
 =?us-ascii?Q?+OGml6HLt1MM9OB0KHXEBgs5wSrOwguM1ozUpTfhalcw15voOz48s4035x2X?=
 =?us-ascii?Q?dvTryNHLKgGoHIceTPphr9dBrtSMGleXtvGO7v7uGm0e+P8xX3aC+c7/anfb?=
 =?us-ascii?Q?M87gC3tHIOt4oEENsbfWmDCKqrV136lFRnqxKvdDjpV6OfQK55Kvln0H3asN?=
 =?us-ascii?Q?fwDq+UYgPsSIyZjM0tv7OXcbIGhmzfHY7mm5WjI/acdvUspo0tYZwbvkuFEp?=
 =?us-ascii?Q?WFNSOVVn27WF+ZyGe+S7Kfs7mTnTFeCiOu6AhdlIGvlDBEwaFcGcVKsbSLJS?=
 =?us-ascii?Q?SgwsuIfrxcmyKZcqpR9jZ2GOoN0X2ZwN3qyH3oCfoGl1QjlB4QAwLalLFE0Z?=
 =?us-ascii?Q?+nrCimMW5v0l4YFPBebNmSkBvcsx4V15VJsMSkUYVXVDQLOwFSVG9wtN9fkk?=
 =?us-ascii?Q?7bIysh+yhVruf/KP5vxoyokkTCoyJ9sG/fFdw4oiv0/mpvDar6g7ChR0kWgL?=
 =?us-ascii?Q?FtmVwyEXzLPFS1yU36Ezn2KCAyZ98tzpVnJpzHgOKwqK3whoFLrb2+Ll6rSV?=
 =?us-ascii?Q?J6pW0InNHor+k6MXJEHnQDTZPOV/kc4+mW74B50pKKELTudIZW8GSwnve9IN?=
 =?us-ascii?Q?XrIzZpqnI0S4D1PSP0P2vfO6B01QFUdIKTaCVCE+k58RJagatv2HPBWfNcjf?=
 =?us-ascii?Q?yJ7dlXJQtY4+pS1tqeCnRIMy9IaEql0t0+22GU8eXbDOH44HTnNRgH69CGR/?=
 =?us-ascii?Q?AFndNtK55MDB04Ry/7T35vErCEN7jKw4iKMgK/NKzph21d8Rs2v0tcRjJu0u?=
 =?us-ascii?Q?WPeOs+iq8YMendmOBVXSdU/liQEHCdSZeqPZn39Vt95YkpUPDRWShC9oZV1F?=
 =?us-ascii?Q?Ac9zhlA4GZSRg9DUEeaW4RX7JFL2zZq7b1KH4BYOy1uXpPPIl8Ia6MB99/OG?=
 =?us-ascii?Q?AZZ9mz3WC2jYy5THZHZ0byLc+7C4gDRzEpb73EJHn4VJKS+3XyUJg8gzsjFY?=
 =?us-ascii?Q?wRLWCd6XQAPRaQWZoNEG4Bf+LTCb140eB/tBHgqBG6H1+RldNHt0Cd7bgo23?=
 =?us-ascii?Q?Y+a4RWrR/QHjmCGkWQErXROIYD+oi7EKUQ5muf4LwINnzuKk3UsqL+7ah8j2?=
 =?us-ascii?Q?hcuIF2a18Lw6amz6TD4WU/EodHvmsh8m+JamaUN7LpKRF7LJr2hUTb715qDp?=
 =?us-ascii?Q?hxehjaAt/sE6QFt8SwOEiekRSWRbXR8zTUjhDLlU5EiDirC+Oue/MSLo1fLI?=
 =?us-ascii?Q?Y9XaZgJPgs6JzP+ESyQFN5elpb7ORff8bHJHYK9g/EvQyeFY9EOXDf+qrxQD?=
 =?us-ascii?Q?rX8OHsRA8TA81rny8lKQDEo=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed9347a-465c-4994-9dc4-08d9eb1fda60
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 16:27:09.1320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdX6QzPIo1CeZEzPclIUqIpOr+GIB7m2+hJhkPFNZ2p9YjI8EULQND9L3ayBHJopeCoTGqRHdp9IIShavyPwRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 795ddd18d38f ("nvmem: core: remove regmap dependency"),
nvmem devices do not use the regmap API. Remove references to it from
the documentation. Additionally, update the example to reflect the new
API.  I have chosen the brcm-nvram driver since it seems to be simpler
than the qfprom driver.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v2:
- Replace spaces with tabs

 Documentation/driver-api/nvmem.rst | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index 287e86819640..a8a58b61709b 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -26,9 +26,7 @@ was a rather big abstraction leak.
 
 This framework aims at solve these problems. It also introduces DT
 representation for consumer devices to go get the data they require (MAC
-Addresses, SoC/Revision ID, part numbers, and so on) from the NVMEMs. This
-framework is based on regmap, so that most of the abstraction available in
-regmap can be reused, across multiple types of buses.
+Addresses, SoC/Revision ID, part numbers, and so on) from the NVMEMs.
 
 NVMEM Providers
 +++++++++++++++
@@ -45,24 +43,22 @@ nvmem_device pointer.
 
 nvmem_unregister(nvmem) is used to unregister a previously registered provider.
 
-For example, a simple qfprom case::
+For example, a simple nvram case::
 
-  static struct nvmem_config econfig = {
-	.name = "qfprom",
-	.owner = THIS_MODULE,
-  };
-
-  static int qfprom_probe(struct platform_device *pdev)
+  static int brcm_nvram_probe(struct platform_device *pdev)
   {
+	struct nvmem_config config = {
+		.name = "brcm-nvram",
+		.reg_read = brcm_nvram_read,
+	};
 	...
-	econfig.dev = &pdev->dev;
-	nvmem = nvmem_register(&econfig);
-	...
+	config.dev = &pdev->dev;
+	config.priv = priv;
+	config.size = resource_size(res);
+
+	devm_nvmem_register(&econfig);
   }
 
-It is mandatory that the NVMEM provider has a regmap associated with its
-struct device. Failure to do would return error code from nvmem_register().
-
 Users of board files can define and register nvmem cells using the
 nvmem_cell_table struct::
 
-- 
2.25.1

