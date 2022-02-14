Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9984B5657
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356418AbiBNQfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:35:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiBNQfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:35:36 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88953B0C;
        Mon, 14 Feb 2022 08:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMOxRCy4fTcxnZSaoOn6iF4Dz8RfmoXTwcTzsIS3ByjiAd0pjjVy4+Ju38qJpXFvHF34IgV4+maCWZaPQ9752pVHDZ41XFEVMFdMR/Bfz39nXRcXpj4BQsDsbp+2A/hY3WSblgrYd3zniewOcJLq8IckaU5pgrT3tCVN4f6298rt0oZhyhFLZA00slCMCOxsgB4fV+/jDqj0nREAGIZtBsIHcxxbwsduancVOoww/y/kGEhjd/Js5J9zuokIJ0sy8CHPGch7B1Anx2Bzjesexq1XwpQuUx2W4D1RNOyjWQIyWbqfspKPsEyz5ADS+fALS3UWZTFnMYbYLCweEhnw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeBHySC8SsiahYw9CgJkq9Q3godafw2ncpyIHlBnJqo=;
 b=N3yKla0sX1hmqm/AbIhvYEadLk3Op19dkJmcw6vgBsEB0PX4ChBj5h2qb/vEyW99T8LNJO75JDG7qbZgqPkvDn0A67rVbDPyrVAAbDg5aPVmxap3gFQB8STWvaGUuylLapju0w4w66RRYg766+ArfLBP251fJ/+WyEr1AWj6txabJFZs3nOfjVLXjdXoEzhQWUvXRSenNwXwFZ87XPy0y4Utha6WlzcjSVXbZ7j0/Fmg6651xMPkbuglt3EEt44/ro7fKczTkEKZBs800cMzVRWBbmrPPyqxV8M25pLjsCNqB4a6hztrcK2yOsSmasGttvAGn0P678SUCiG38lUB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeBHySC8SsiahYw9CgJkq9Q3godafw2ncpyIHlBnJqo=;
 b=IW3rELGh5wMAxSjbWc/AYZAgyMwPeX3XyRYwv0wlkTDG2gqf7+WAT+3By77bnsOKQTfyrX4meg0/SxuymPDRoUaZEAoxeWwIEMC6qqGf1VUqcgUXcGS84vGAzYgD5rTpovbFrH3Tyre3+7ZSnQ89mhrZHic13O4QlYGr7bxOpap2Wv2vsPd1C6ufZb9KHlRcdJAk6hXDmMMIZEEQB8vbkQoZHtu7vPcLQYj+yQkrYnFeuSuS8k3ZfbrbVcvZqm4ABqmXbf1XeNK6qzw8Xd1yQYqE9ODb12bV9MnOebIsJ0h7i0VwxFG0SKgtr3KVXNtFH7UBCcGET/ZLQGgjIvU4Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3834.eurprd03.prod.outlook.com (2603:10a6:5:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 16:35:25 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd%4]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 16:35:25 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 1/2] doc: nvmem: Remove references to regmap
Date:   Mon, 14 Feb 2022 11:35:12 -0500
Message-Id: <20220214163514.435142-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::8) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56c4628c-6cf7-443a-0acc-08d9efd80089
X-MS-TrafficTypeDiagnostic: DB7PR03MB3834:EE_
X-Microsoft-Antispam-PRVS: <DB7PR03MB3834D4F6CD4998F1D2FDDDAE96339@DB7PR03MB3834.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhXDp7VbVt90SEMaF0HEKtn4irwQKHxFQ9cIO99DKONtL/U+3Ew58T5Rqkjeo6PRO04hatV2Xe/DHt39gyCiWD84O4jWWWNmJpC7a64X+WN5xhkjTUcZGpSedwIeJxv8cU+/TmP6J5DePMQbc1umjVy6AFpxbLxeVTUT+P8pTA6LBn+hDM9xUE0RG7BTgoo2pMaWJK2ujy1YBjzuLFNgNGZmubQIv4IjDm1OnU5sk2BCnhCsCkFWTgfvTIYtd9PClQpBdYPPLsWZblObStJY8LGwdkUVXqJKJTJIYl44bbRh31bPAaqG1gyLrvldW3oGK6hbtahEqP/93fPR/Uxb4GWmiaLymCV/YGO5NqmseJEphOu1QFDpF1BFLojqE0o4lQysJxQlPi1j6zwQ1CHJeVjfAFS5KETUo7sWgkEPHtAmAaB4GNngKb3jdABJTMJ04UdqeLjVpRfrVW265/aYkMpKk4aiTG7F05/GiwKdoEZg+pLA3UERUfoPohTatTSKBVkoD/VDCFjzkVbtw5kGnB2LemFs2PxzlhqrSpM4d1CrUNy5gzPYCEHhBhtgiEF7viWvtDw+W1PPGjWCAVssYKXBu/2c5fc3KRO76VOl1sVCdl3wmTSxptdH7XoUMPavpcxo1BFQhMTY47aw92u3Z6t8vdW4nxLzIKEotnDBLNBEc1Vuqs0lKsUtNJFDczNxTbWDyWOejPa6S6a4ACs45Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(6486002)(86362001)(8676002)(6506007)(4326008)(66476007)(66556008)(66946007)(508600001)(8936002)(6512007)(54906003)(26005)(44832011)(186003)(83380400001)(316002)(2616005)(5660300002)(2906002)(1076003)(107886003)(6666004)(38350700002)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IxOS/GhWnWW6xl/JkjcLWwsoi4+gm1SkvWHf8SR2El/7yeydpGGdbwyq0Xxw?=
 =?us-ascii?Q?5z+n8i+XjHQgKfORbDOArz8kvm3Eq30uj5C3/LpUCqgcCBVFDBccqcVF1mse?=
 =?us-ascii?Q?vnSbrxB6GMBE5bLtNLc1Ok0vrfG6kGjePm7kneJI1XiX/TWN3/HPoWLpQG6k?=
 =?us-ascii?Q?NJYnoq4O6+8n9yWIvL7Yxwt5jIpI2jcyj9TKC2djY+rmvsTiAzMq+fX3pEWI?=
 =?us-ascii?Q?8YEmF02CyZIQazgXet+VZ/YkJl5w3l+Cu464qCVlU+MoBYfbQpsYta/vL5gr?=
 =?us-ascii?Q?bEp0E4aN7ZWz/++PBFVDTMt6FaItQpkcskWPijVF1bFcajcxoy1Lma1LoiOj?=
 =?us-ascii?Q?s9Glvhdlpv+LMZxsPaC5D5i+qAu/7iV0mfOC6bvx/2HHGEw+/aBqL4Am8ByG?=
 =?us-ascii?Q?wSK+GwKNCE6gM+c4q0y0Bm3aCfZlqeBxb2/vLqKD8OIS3dskYJ+aNKS1PC4z?=
 =?us-ascii?Q?HZme8wwHRRHPA7mzzHTM0YZFlLN8+Qkv6oyk+JZCEzDT9jASwLew1hkhIfHu?=
 =?us-ascii?Q?eKhaIkY8up41d8z5Va9sXIBz/zRWVkiaKLLUxNpICW8VBnljNdbvwGGNegL6?=
 =?us-ascii?Q?K5rgy80hx3lRqsQueblwnqVp3oWBjvItzpiwZYWW1C99mpSgQAiG11RXmL5m?=
 =?us-ascii?Q?ZhR7a2yHlm6ARpY23mcYKgkfhoOoU3SC+6TGnJtjnN8iDsd+ztCtBAy7bp2V?=
 =?us-ascii?Q?4TFu6uxamZ7VFynWO/BMQ2l7+KonxDCsMVHmvGMrRMU0VG1C0RdNvTnvzIxm?=
 =?us-ascii?Q?IqdeSWqCR7Eb5dsdrV9NLxV6nEArM2Oo/eemEZM8//AeZWl+cjLuyzD/S+5F?=
 =?us-ascii?Q?5Z2P+HVAEVkn294j0M6LOC4wqBoiFfcpuSuw47jOH0btv6M6dXshs83YGFgZ?=
 =?us-ascii?Q?zd3t8OicAeW5jQdrj4szE9JhJv//h1wBjdax8XnkppprJmICTZc3nE7UpufY?=
 =?us-ascii?Q?v8RRNIFEV3vTiizuKNyIasRbV49w+Sl3Kje/IB37jWIviubyMCKNckxRDSn0?=
 =?us-ascii?Q?3QgeRVuAozGN6S3+Qoyt4fc0U31BcJ1efVxDXCrYb6kjcSfiAtEz7MowlN6E?=
 =?us-ascii?Q?1tef3wxywWCIhLfB5DRgN2w4UXC7PfyenpePASW6cvaFDPhbURhEF70O3BRI?=
 =?us-ascii?Q?rR80a7pi33bUrfQV0ytCOpyCCEoNt05opA43n4GsszICvlvdRR7ZeXcTARcD?=
 =?us-ascii?Q?x8/Wky3oEk0nI0+E0//E/Q5d93YyoXUYx1C7ZgPrhR4nrWPceX1jn4FpNuKA?=
 =?us-ascii?Q?nIA7Lap00wjzZSkQOrjaaMPbXHNo11JFqLAkPohc3FfiX6jfAUsBta0xFXoR?=
 =?us-ascii?Q?UyT/bkEfJmrF8je6i40/3zqXp7CWcQjrWAJqC/KZacdH00kdbynZD1xR9Hid?=
 =?us-ascii?Q?0/KlR+usaKBnBkqfpL7LjddNL4IZaCheSiIbaLMMN6hSIoGXvmre4uarIqUS?=
 =?us-ascii?Q?Xf6Su8QsPc2gNML6t4sguL103beZN/uMTKmI/3yYfrx1kG9AmDd2buy90IoV?=
 =?us-ascii?Q?kqexnSuaZTONhw2PhYx/QwMS9NbliemhFOPhJ6P4XFK1VHRG/XPUB3PtuXMv?=
 =?us-ascii?Q?zdF7kvmo7ZZ+rUuZruDFcfkTbtXChmLuOa7s6rokHUFykPik0FB1UHbzNijf?=
 =?us-ascii?Q?lfS6Ub4qxWbSg6UQ/UP6KOY=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c4628c-6cf7-443a-0acc-08d9efd80089
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 16:35:25.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTNPoei2vpFmVOIA5LBGwrA5T7BDOx0NM6LvXa42JNBS+KGOUsT7qBewxNp09sIixZ0dyTcYinpta/uaHpODfg==
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

Since commit 795ddd18d38f ("nvmem: core: remove regmap dependency"),
nvmem devices do not use the regmap API. Remove references to it from
the documentation.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v2)

Changes in v2:
- Replace spaces with tabs

 Documentation/driver-api/nvmem.rst | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index 287e86819640..56352ad1b1b0 100644
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
@@ -60,9 +58,6 @@ For example, a simple qfprom case::
 	...
   }
 
-It is mandatory that the NVMEM provider has a regmap associated with its
-struct device. Failure to do would return error code from nvmem_register().
-
 Users of board files can define and register nvmem cells using the
 nvmem_cell_table struct::
 
-- 
2.25.1

