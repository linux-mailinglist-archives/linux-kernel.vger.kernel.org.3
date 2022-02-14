Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBEE4B5656
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356423AbiBNQfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:35:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbiBNQfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:35:36 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137E3B67;
        Mon, 14 Feb 2022 08:35:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lks8EOCOgbpw4Uuv/l+QA+MkcU0Hw6ekOYV3LV3C4vc3L5MvC6VafcDiBtVdcx0x+BPACjIW4/Hf7U/C9tt5MIB3YkHzM2p5/aYRE3puF4/BHn3ZVg65htPD3Yax2/wP8VbkaJP5a+ipJbcUKuGmZmLoX74YlSi8u+bVDr0G2/+rc+lHY2lug2x3m4sYtW5+QpfJaQeNm4dW3/KZuK1rqPXhzt5aHkCebUeUdOPYrWcG0e7ronsuoM0VDSs2AEcdEMdGp/o0Rf1nB8SSqI0OiiJyqOLyg9hzs4QbxFCYBJhUYisYDv8qmJpWkaGvPhbiLYi7G+8ZNL1rCuDcKdTtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ajfaLd01c4gzZjVHjwYNdGYQqOIe8nKcnlS8OJiOcc=;
 b=l8wjx3wAwbQUNtfwbe9xq20Qa0q9VONJUL0VI1B0xD+kekXmUBSiT8xb/QYTzmUrXRI48zIrAU0RPkHncOnD5UTDxGJLsYvPoGC4i6IYQdtNHWhmQcSSQpu31wxEc18qX8VQAzOBNSqcTy5+n6zaNo06noxWeGeROrt/BrOldthlnZ1xVUXB4pCtK6FbybGqja7Mjl/Ff0N47nbkcBY76/XitLfIBAKuJ/LaA//wnELQ3LPfi0xkHghQk1mD849Y/TRSki0b+ecryLVeefAd3L6mF+OAGZpn48rggEmwM3YKbuqbBf+1vcp9deRAkDvICmdU4OtnX3DC554f8TAtCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ajfaLd01c4gzZjVHjwYNdGYQqOIe8nKcnlS8OJiOcc=;
 b=cne9z9dVPKh3KUzl1ln0H8hMzHNb9r5JH7nDPBpU+gA6jYeHxQ6iRdZkCnmmIpoC9j66ysZZJ32iVup+5lwoAaIRQW4vvmxdJ0SbZe6pzDsx2One7ahccZQz+H7kCDvOfvhG/yNQ+Mw9oMNskX/p1e9htL3D2aoBR2NKeAyKVfv7K4yUo0PKGjaergmyr2oYlkSQfAkNG4JnLZj0kpRR5JlWpQPWTmZh9xgnWy/ZWf5jxTHIIRf4KyCLHLYlbvI1sADyihlDq2P7l8qHIsPrT8a+mVw8H0R6KAMgDxVw0PVD6xe+/1kIQtB8qSpo2aGxU3n3dyWDx+dptyE/h85l3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3834.eurprd03.prod.outlook.com (2603:10a6:5:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 16:35:26 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 16:35:26 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 2/2] doc: nvmem: Update example
Date:   Mon, 14 Feb 2022 11:35:13 -0500
Message-Id: <20220214163514.435142-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214163514.435142-1-sean.anderson@seco.com>
References: <20220214163514.435142-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::8) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 021b96ce-3a0c-490a-9ac4-08d9efd8015f
X-MS-TrafficTypeDiagnostic: DB7PR03MB3834:EE_
X-Microsoft-Antispam-PRVS: <DB7PR03MB38343C26786343161AF16F6196339@DB7PR03MB3834.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/LJESXIs4E9AclCGtTMCAjkIqPY35E5Edt8xAlCGXfo2qOPTgpemPVEZq5WJ6Zb2xb+L906uEcm5Huj6YHJGHim12ddyTpZ1/9+GAQXfPx+iJFgZRpUxFXwqjwlRby1mrSO4XoUVtVDY7C4CfZGIfXiSPe10jtE1Jz3TlbTMtJQz5PTWSwmBkbrDRV7p1XHrE6Xix+nCT3kSwOcVbPt8QR6p4oWyP/lw34cIEAiPvABkoIgXlMr+eIf1evSHqDplkr7eOgeN6a9U5HH6/jZ0s0BbSCN38CeuF4nv6y+PRm8B1gJbjG0Vyjqv7JwFqiPsgMonAQ80kFQGCM2L7EhYiRCo6FhFoMc3v596hrDfAbVoCbrZPVZ14J79/iPAWMJmmXWO9kI9fR9vwMQftJm1ujl5HnT0eMZVEw6unXfTKwgL4h+96JJlpysKQOIyOYabahxA1mA8GYIzXR/ziCO5bRucqchUmtTuUzawRelDMNx94v0zPIMsu/yqX8E7+8vYRUvP5IIYuGOnhBQ8OLmXTGULIz9faFO6wbTZ1CzCpYyc5xFrNFP02iqz/Fv2dVPQl8IPVVh3qy9PCLgvkDAvfJDI1EbfeF7hlakLe+2xeR9bkbfEP3qs51+ZF3h8wZUp/ricPcJzMotjXUCreOesRm0hBAadXulnrqb7AVmRYoGPqS7hpcHCxvvQgr7FNIx2ltYGqi9BxMVKjPcy7UM+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(6486002)(86362001)(8676002)(6506007)(4326008)(66476007)(66556008)(66946007)(508600001)(8936002)(6512007)(54906003)(26005)(44832011)(186003)(83380400001)(316002)(2616005)(5660300002)(2906002)(1076003)(107886003)(15650500001)(6666004)(38350700002)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMMHKwBnWtKNbLPaZzh395jefc/l4DJDjuYa1yw3zVHAD3+MjuJeJGaffnak?=
 =?us-ascii?Q?G1GE/H/V6frlsTK+LRq9eUfm8HukWBsoTD85dEkRS5IOK1Cbaql7N2TmwXTv?=
 =?us-ascii?Q?EC1D92FIw5eNCuHIImVbI8OGwdJLvPjsKj4sKmQ8AlTaUA6iYSZ3SUcGV+1T?=
 =?us-ascii?Q?ADk8WwzrDpxKwCcnKVNiEm+52joaQnY/8gOnKFRVXHLcE5HWboBMU9C9cZmq?=
 =?us-ascii?Q?ThJAf7qjevF4UCGZ90AOtVGNubBqDLciNtdlUKyWK0jxosjXr4emrBRpYCbx?=
 =?us-ascii?Q?v2h9Wm7c2z4ds0HbY+4ohrErbJ93E3iRDXN7Je+LApOy4hpcjxrJTbMEPPe2?=
 =?us-ascii?Q?djwr68gOzw/fdEreITBEfRIgzjkRCTZUwdsvX83QiFBFfxj6IyegRWcXZeh+?=
 =?us-ascii?Q?dFC1rlTO6+omlHSVK4Zzg7O6sPNny2d6IYUpCOlIpBzmkvdW6VDh+fhpAklf?=
 =?us-ascii?Q?DSuWAJ9mcc7KnER+yztvx00wWcv7FM96bPOzdsCZIzSfgBu2Hq385Bo6ZVIJ?=
 =?us-ascii?Q?+zgRzWVEuObkDIAcUeba7+hU8U2g1EjyPedtRhcmUqmy0PihO9qvBpeUtZnf?=
 =?us-ascii?Q?R9x121tHkbhQoMOiNFPOHs1fHoszcPcQ+THnV3m55ncLtGMNUGkN5OcW+ZxD?=
 =?us-ascii?Q?1IdT5eVhl4oxqk8WEP1gZm/ZwUbQCJaknOwQOBDADHp1Y1ITKCNpSaTzzhhQ?=
 =?us-ascii?Q?+eAXqL+BlRAj9vkjHkkGvVUW31TMo/Ea634gQmK1l4a/+Q7F9NedXQudSx1E?=
 =?us-ascii?Q?bYTWraSlFXsVWsRfdrSudYy0yJH7hkYMZvUm2Y5Glhu6Hk5i6Fdk9fI4Q+au?=
 =?us-ascii?Q?TLMQ2f3Fwm/XKWZ7FYOUOifOmSpdb+Vym9lE4PkInm523LtcVezaqgHEpY61?=
 =?us-ascii?Q?hbxSGkEFMa1N5f7LqKwoA2LERwyR/0VZS7hAUHwG4pTQiFubLjJ0NHBr2KWO?=
 =?us-ascii?Q?rJRE1fFQJIuFk/tbqN7v1O8mUe2EcKX7+ai9mcU0d4Np4vrVzgSHyu6PFgFy?=
 =?us-ascii?Q?J38OzMrZWrqW6IXQQI/T1ENZgBAdQGZ5EcrN0VuGYB5MdSjq7+SR+LMYfpni?=
 =?us-ascii?Q?d1jfYrEc8DS7DMSuDAKXFYsNCcb5vLvWJGQ6pRxnjbs7NmkM4jvCOZzrPGGn?=
 =?us-ascii?Q?3RorrTFgCibN7AU6A/KQmOQAowQf/6X7Npo2nQK1OXG0/17UxPLxUHCN/jXx?=
 =?us-ascii?Q?gYaSE/zIFn25I4p7W30Wzn1BuWJ3rTGws32+f//id+izFrkUMvUp2PydFk2Y?=
 =?us-ascii?Q?4d2tmk+zlxOASM8/9T8NpsJO4tvf2TCpUNt/XAcfXzyYToKUCcsTkZt2W/IC?=
 =?us-ascii?Q?E8c3EbAQbqLZh7SY7tLJHVWs2Rrrb4/FRwRZq4mQRChviwvZS6Ph1x5A+3ta?=
 =?us-ascii?Q?rDTJhbGqt332AlHrTh6qHVk/ek4r0xjnmNMYFMS4fr5enGIcPf/mrs3ReosG?=
 =?us-ascii?Q?hW4Ni4QFBhnWRcrfolBPvH4MbljrVAqTI90e5g2ymEO2FyXnks3ehE5pNGoj?=
 =?us-ascii?Q?2KW/rOfhpyPtChBwX6ODyNsDUXy7ZgcA7AtuUCaW5cuGbGGJEHhjn2oR7jLn?=
 =?us-ascii?Q?CQFL/U123U9/yMkzyDA7LIAEXG0rb89WE8ugdJq2buL5CvEUimf/VihzhlgU?=
 =?us-ascii?Q?D1GAoV87Bo0em7BWvaymGAY=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021b96ce-3a0c-490a-9ac4-08d9efd8015f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 16:35:26.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6UuUNgYh/xGdqKQTXkEJDBHwdCp1GHxjUQzWPk2j+UwYgoMHCG42Q4NDm3Wj+vCUS1BOVJ9NedP0KrbhIa3Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3834
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the example to reflect the new API. I have chosen the brcm-nvram
driver since it seems to be simpler than the qfprom driver.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v3:
- Split into two patches as requested
- Fix one missing conversion of econfig to config

 Documentation/driver-api/nvmem.rst | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index 56352ad1b1b0..e3366322d46c 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -43,19 +43,20 @@ nvmem_device pointer.
 
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
+	devm_nvmem_register(&config);
   }
 
 Users of board files can define and register nvmem cells using the
-- 
2.25.1

