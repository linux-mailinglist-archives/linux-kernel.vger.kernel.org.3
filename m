Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C97C4ADE4F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383182AbiBHQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbiBHQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:25:26 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7FC061576;
        Tue,  8 Feb 2022 08:25:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuPUWv+3xlTeG6w//8poKr2lwxTaza4kZGQsEni0O3oBVXqHZYmT+g8G+vJ85j3xXDPskCN9zWEqrIhoZmi/JYuneVKMCaZg1nYEmZ51xNB0DZQLUh1NymYhe8PmLuxLdzWDVibaPGMe4oDM2Hqyr8aEr+QzwiXeg9TnsGUsV8K9mBbuZ26K8NwWKKp9Awd4w+K8iQBkiaP49Z86egptbAHwcbMNetgSrVUVFaLNUJvqeXkFCH+BEkI6hi1vm0kaEMHLdtG46SeokBtFCwX/rDNTwF4TMxZyL+sJ0WNjEo8Tnsvn8qoX3wCE2vw6hG7IqywxqHMN1hHqJv7kTpNezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6lDYFscE1bA9n8ONQaMgNh2vpNOs/ufVuW8naytbWk=;
 b=ecipCmAwB1cYRfNTepaStalV2Nn2kJ174z+5fMr93Li5lb5kFEtJrBt4mjSSLmlDqyoXR1Sm1JGt26ITIarD5PgBMD1Ny533ql4xgfUgEGvBFjQlKTpkatlGJ/aGSycApZjD4Y0wCKfC/cIgSoAjFCkWrzQsuOHk45/hW08rf3dIRu7uUSITMSHizPeZzkH9bKudjedDzi3vFOtsp7BftXXa/1siL1jw9wB/S4HcSTAkNwtDCDr73VsrGuMHOspfMWXIXn0slmCXeWlCB2uURWWFLb3ThRjvd9f5YlYt6i8GFdq4m1XhT3eZcaRGS4AqX+TvywKbE4t6GCed6j+CGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6lDYFscE1bA9n8ONQaMgNh2vpNOs/ufVuW8naytbWk=;
 b=mSk3Ur3YRUBoZdXrF9oF4WMyO+613FjAtaG1pfIj98iu1Lj/g2vjFetz3ownw7dCt7N1pyJgHjHHpXKyjw6rb0eh+i855Z6xWlBm1PJb4w+DyIZ28/TR2JzT5CM88Duw1iarsa4/5l4/dwJPbjU0Ezn6oq/u/NkMbhnokjGbgfJ/XLzRGY7H9UU/dU5TH27J/cw9A0mc2W2kV4OMX/iP43DLuGLn/BudoqCExoySJ6iPkD0dGPLb+CX7NO0nrGnT30kn7FzyTD4BAAg8X02XjrKYh9dcnNxI9ytvf47etKUVRzYkzeNoMxVGSRoBXvu39QL2wx91Kx3VJNZKNYePvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by VI1PR0301MB6654.eurprd03.prod.outlook.com (2603:10a6:800:190::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 16:25:21 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 16:25:21 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] doc: nvmem: Remove references to regmap
Date:   Tue,  8 Feb 2022 11:25:05 -0500
Message-Id: <20220208162505.723769-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0326.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::31) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2ed3378-1b0d-420e-085c-08d9eb1f9a58
X-MS-TrafficTypeDiagnostic: VI1PR0301MB6654:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0301MB66543594C6C0669284F21109962D9@VI1PR0301MB6654.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OHuHye3CHrvt/FuPIyzrczRmyQimCnvXwiysityOZ9aO6bQqIkORkZh5IbKYEnGFCYm5fZOa2NlQIplojBqjWvhJuJLPqtyXUPXEFV6O0bBXMXsFLl4dtAF+ImzQQbIfU8yRFPnJGFqXgvGPZVKB2TxnGoWzNgGUv4+jaoqfWyT9KCnotfj5PXF/XpoqlzlxJvNmEmzGLEW8X3tn4a9F/w/982myZXA8dPq4lpapv7EhdCLqK0BCZTBkrjW6E6+dp7Gknpkqol93eKsRkD3maVbYTCc0QMq3sCoaxvwCEqTxRY+SFs4nJZJ2+Y10EHIxF0jPh2QRegqJYUBxGflrHos6BDx9ZhO8GUhWabHHJmk+LW7FGxJHBbPu+CRknzOVhbOfNRZ/EJpKNvZopRc6jKbaZHPrDmqS7RYkfphDd3ZeORUls4ZoeCnVciUzNtVciUb6bRlGsCoCC9bHqGGeZVELjsFChCjhPCKLTrfEmnmPPKDKVA9o9RC1sqnPL0bqI+i69GnJXkUIJQkblh/2W1vFXbV6DHbwsDOnHiSHV/Iocvz+VnmypiNkNXGwc9SheMlBpQR3GL0E+uOq8p33VRNXppsGAqDwskHxb1+ngPnMuNob3qMfAEhcpGd1x20Kq7OP9TUfgzryYlrheQCu1bhzjJxCe6KS3VQoMwIpHguwLCDHZOl6JcKYaKuQCddU4eSNzqHVGSoM0R4uTYY1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38350700002)(316002)(86362001)(6666004)(6506007)(6512007)(52116002)(107886003)(6486002)(186003)(2616005)(54906003)(508600001)(66476007)(38100700002)(5660300002)(44832011)(66946007)(4326008)(2906002)(36756003)(66556008)(8676002)(8936002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/f4BY7dfyL6ofEUlLF1NPDHbDeH1N6bIG+VJmiorkm1lTkcpHgBVVVwhlcAG?=
 =?us-ascii?Q?u0sePqFunT5L1NK6oXY8F8h2nXzuhV1ZZfaUDKNJdlAt1NZTVJzvKFirpeea?=
 =?us-ascii?Q?F0XcP944yngMHkr0rMMpGMwpMTmxV92Gjd2FnHnONtlX7CMmR3XJxT6TdvZ+?=
 =?us-ascii?Q?85SejzpbV3HdR1vm6DdEB6J65D9uZ8qc6FxOiL6uWMukgiVERFmMbzw66ELK?=
 =?us-ascii?Q?raEFAPPslaUNoQ3hCtl5O2jJ8zAaU1e9GrdMvGs+xVfg/oNjtkHLCUL5Yvie?=
 =?us-ascii?Q?PPWD3onwSZ3q8Vgbrfq1E1z+7LbTrFUge1Btf6G7Y0SAKkd8VaHuQDsMCCH6?=
 =?us-ascii?Q?Kqr/rUm97BllMR053Q1PJMNiUgPfoW5tqSMOTRUKgSc1iBFAawFdwkljf+6e?=
 =?us-ascii?Q?85ygqvrhbEq+K3qzpXRFTrAyTmxGEy3Nqc/7tPlRD9jWImm8qzfGa1FeXdd3?=
 =?us-ascii?Q?loRLBbQTLoNHfY4RdkmF/x/TcTmbzMy/x1/CrdshOmvUn/+Kw9t/nArUR58f?=
 =?us-ascii?Q?Zihh0gl5UBbbqymO8sz3VtzvQ4GRYtp5ouhyZgnXXiE5D7NJ5xGGs23QJLIO?=
 =?us-ascii?Q?rwPWZSa6VDB1AnYOBrM5o1fyhHf2n7U1ahtXXmjUhzyF563hv7OMiA9U0eVL?=
 =?us-ascii?Q?R1pMo4ZcrhVOJzSwM359rkEfTW4L29xW19J8EVtAxszmTUSEEf/ihYVK5N/H?=
 =?us-ascii?Q?XP6Z1dbjuQZoOppa0jEGMM6GGGQ5Vmniu77FKXZY70yndLr0Rxg5zF0BwByN?=
 =?us-ascii?Q?SP6I7O18Jem0dLtKQ7YgD5Pspbmfiswrwr1Xd7h8j+s9sYbNcDmSde+59WMV?=
 =?us-ascii?Q?WX1tlMdjEVWExg+EfbdcQmtmafsOZJ8G3DF313oW47SblufccqVr3DAG/g5k?=
 =?us-ascii?Q?O94P/qjRbf+07LwcmGwqOS1D4L6nihX0lHQLO1D1AsYl78Zvs2tHHm9KPIIx?=
 =?us-ascii?Q?3hMHelA+DvMgspj/VdTstkUpemtYDc6zP4pIjmYLoJPQZkIG6ZONqhotOhVZ?=
 =?us-ascii?Q?bEpent99p+G6ld/or2xwxjLnZyCypW5B8GU0Bs1CBLXEqbahr15ljOijOceX?=
 =?us-ascii?Q?0eIpCBYp1b0iR1twkAzewKwlLgplqhkEi6DiFTQxgmxQUl98szf0gqpJDO0t?=
 =?us-ascii?Q?5h6n55SiztNTqQqlT81A3dDH+GFBK06/ejvk27WFtKao+/uzUIW9ZtG/gKKd?=
 =?us-ascii?Q?wSGJ5auUJey+lIejxwKiST0yVdWL3KF9C3s3NqIDsmcHckgVQz89GyMrXO8G?=
 =?us-ascii?Q?YWoNV8rfe4IzYjTccQ4geETyj1EIXRobs4ddqKlN+saQ+2ZntnCCIAIzhTYF?=
 =?us-ascii?Q?iBixzuvM4UTuTneUNYYhMO6jkN9fqO94LyLMZP9HFGBezXicTMKXfe4e2CXw?=
 =?us-ascii?Q?ajh5DXV3f7PLFzuJz77DffQCglBnjgiw5LHb/xTwZBYaw7dg6goI72HyzwMq?=
 =?us-ascii?Q?ws06eW8EtgEGpmmDc7yMQteaHZgB5NeOiP1EnrKtbHhukvdzdy4Fa7ZSQOcq?=
 =?us-ascii?Q?i9HTgHAEJ0lLXys86s3IJDM0wzbQ71ksF6AlKLkl5BFpkqLnbjLcCtvmMRS0?=
 =?us-ascii?Q?wM2aUDF6s+qOML4hJy68ocglZBCGpvG/GxPiWUZXXK0CGxlxBhfr5bPuI6Nn?=
 =?us-ascii?Q?Ip0mkQNtNKTwPyOq7UGv+yY=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ed3378-1b0d-420e-085c-08d9eb1f9a58
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 16:25:21.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R021yxubm26q92XwDzP5CjFMusm1+5Mrm73yuENRjqyJomReBDLF6C71y/1krztq/176ME7pX4pycEPPy4mlxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB6654
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

 Documentation/driver-api/nvmem.rst | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index 287e86819640..f5435771cbeb 100644
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
+        struct nvmem_config config = {
+                .name = "brcm-nvram",
+                .reg_read = brcm_nvram_read,
+        };
 	...
-	econfig.dev = &pdev->dev;
-	nvmem = nvmem_register(&econfig);
-	...
+	config.dev = &pdev->dev;
+        config.priv = priv;
+        config.size = resource_size(res);
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

