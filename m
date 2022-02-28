Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE074C6007
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 01:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiB1AEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 19:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiB1ADz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:03:55 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2135.outbound.protection.outlook.com [40.107.223.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628323982E;
        Sun, 27 Feb 2022 16:03:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eENhGiICgU5coeiyqAdfABRlk/Jr1GLGvhdC8f3fBRZjTonlvSh8jGV6dPNQeoy7FgZvkSSko/IzCttOZvfoZFRcYq1a65TcCYThvKlSfcEwFrje4fd9CeaorHJfr/J62TmWba6UbTw4bD2+TV3N8e9XXmxxw5l2SxLZlA+WrCzgVpJAkzhkRG4rrf5djvWU6rM3eo3/EIMv0vEpCWGyRM04p29lAq/izW8LD+DBMOFUSY1WI4tQt+7C6NGBUWLI80P4HgIaIPPlnLhq1zLJB94baiPsnIUsGiN5UDK36uv3PMIP+0tyigRauAmLQ4RsMyuBHmLyeh+JsU7HqrZCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoBas95ja/MV3wW6CR8Crb5HX1yxItTww/S3sNO3vRU=;
 b=C33AMfw9zkoPkKBi61ewJw7aW6B18ATY153R0nG/LCgSbXZPz2a3C+NTI0+xI4aUawcyEDwMmiYzaVx7F0wO5rtBIC50CYetGdGPBzLi615swMuq8OI5G0KFfagl3DhXlWXfdoliLULdclU5EVu+rqvvrRcugvwxe1Ju/F9VSIGv3RshlNVZVtoKCfYSr8D2lFUzf/e4baP3YDAM5Z/RGbFZrQGahNliRXskIUtaR1cq7eUE1iANuKhAv03gm1KrzkPGPEZpwZuKTfKuFHmtJmsL3Q+BdY/Uosm8NmcuWG5hGK567OxjtaTvBcZ+kvxD22txw3cW8ccvne9XAYZiXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoBas95ja/MV3wW6CR8Crb5HX1yxItTww/S3sNO3vRU=;
 b=qlEEXE+8QdHQye3pmSfuFzncU6UKC3Ufv/4bI5zlnIGoNXlz8XXYR/AYQ8siAFmx6ciffgbADmpmz6ePenGuRNv6cHymBytGTI07vCz3XtKZuO+3QUyzpQDwBUsatKCoUtH5+hobAcTXl01/BNjxo1nDJ3Ygv/OrEudyPNxYXns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24) by
 PH0PR01MB6184.prod.exchangelabs.com (2603:10b6:510:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Mon, 28 Feb 2022 00:03:14 +0000
Received: from SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::d9a2:2761:a4c0:1e1c]) by SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::d9a2:2761:a4c0:1e1c%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 00:03:14 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: [PATCH v1 4/5] ARM: dts: aspeed: mtjade: Rename GPIO hog nodes to match schema.
Date:   Mon, 28 Feb 2022 07:02:41 +0700
Message-Id: <20220228000242.1884-5-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220228000242.1884-1-quan@os.amperecomputing.com>
References: <20220228000242.1884-1-quan@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To SJ0PR01MB7282.prod.exchangelabs.com
 (2603:10b6:a03:3f2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83f7e1da-c0e2-4010-f09d-08d9fa4db6f0
X-MS-TrafficTypeDiagnostic: PH0PR01MB6184:EE_
X-Microsoft-Antispam-PRVS: <PH0PR01MB61843B3E689973548FF624B0F2019@PH0PR01MB6184.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkyLPEJV7AAAV3qy5K0nm8xTqh6G4CnUa7nTlaOe/nXvporQEkH106XRwbxHjCPJRoJoIUQKjdVKJ3ycy9ntmfsktwJPqrGaqYYxWKhs8gn7kPQXoiOvplzE/SQX0okndcygBBsI5BEJDo95rxRaDEbPAlcPuwqsX486IbX7IP3EJEnFPqY9arl8/bJ8YY0/DkK0XkfHYfXWxaa3/VkC2elvfRcb+4at3lo/zqm0x9wR0n5FskjoLWXyMoMOHkLvYcpKKoCDUphT5YKAJy16IXlSCx4AWyTzqtLJBahLCbu65sqlCXEC/YRIQMeHp5l8iMRLTw41wPE/3Q1QYdhnLJDUoNch03V2tmBCLgAN5cPXtFWbMHKSqS3PTNhXO9L8NxR1xdwTCGAqbH8RMfQ/Pa+ml8v41fAwnFuQSbPrSh9H9QW2wSeLKcyfAE9d5KJz3v/vGwnk02Gm6BioGCqNPsRM2/6MuMAn0vAWO4GJ3Y5UZVMYulEYEPoVW2XxR7daQU9ByBWBc9wt3m4Jb6mHxfbR/jEG1p9sFRoWjtyzTxX9lwbR9k/rLp4dXSLwxXlclowJ+3zAg4wfiat9DnBhuS1GxMNrT1sC3SThSf2EGvhr/mJ8PqJNR5QU+8n2rB45XGENyvev3laZwTxNkAVWOKU9Vf1w91MgnbamT0rOeElmA6YFBnuscOcMvZWPWUJk1wGbtf/VprCvuwp/Mb6b+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(83380400001)(66476007)(2906002)(6512007)(186003)(54906003)(26005)(38100700002)(38350700002)(110136005)(1076003)(107886003)(2616005)(8936002)(66946007)(52116002)(5660300002)(66556008)(6506007)(4326008)(6486002)(316002)(86362001)(508600001)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h3zSa7vTiymvfMp6bwz2IkYx2WJjLrgVcbQaMOch+kMzPCFpE3cRwEioYxQt?=
 =?us-ascii?Q?dO+5QgGj+/EZXN9bUc09iKiqCDgiltXjP5KjEWlZorXYbW7DNYvUeNwcM7NJ?=
 =?us-ascii?Q?UAQAO+L23ZJ6pxIGA29WYgyVSrmmk761BkTbv1w7F7nOsOCzr+TGxgzd2mCf?=
 =?us-ascii?Q?O9qcFEZrfyXZWr/6TTx6z6Fqs941KV8cfXOU+Vr8c4C9AjiO6OhQqU06NnMr?=
 =?us-ascii?Q?R0X9tRN2D0aBV7qxD5DXa/obsiZWJRE0kCl55b/CdKVzgzbb2m/nSDTCWFVs?=
 =?us-ascii?Q?AXm6YTnOXlw+6zwHJhnsuJ5i0gA7yKv1Od+jaLCj0x3E/9UdEWGu6Cee4T+9?=
 =?us-ascii?Q?BN+lNkrvRr8FXlGfpNfimamxmHBJesIFMFHHGgR9wUoVAFd3cJRZkyVMt/s3?=
 =?us-ascii?Q?eFyczqTI6/oXpxEw6lFdz437++SHwdejiGFOQJgztql+pz7EaOtUeQF141v9?=
 =?us-ascii?Q?7Q9XKed4iQpiaQhb5kqYKjBOhzy8uXBJoWr0ppzJGfbBdIxhbJmQpiWpV9E6?=
 =?us-ascii?Q?AkbD2ajnfM8JpUu5A8oZPoeUKwYfVSoGZFUMN7+VgHW3bCq6glrnwlEBp+/F?=
 =?us-ascii?Q?HlTjCXiT4VKU1WmHuMxasjUvS8OCdZfpqh1iYD54YpPhuzIxZDURJt6YY3Cy?=
 =?us-ascii?Q?inOowEH+w7WXScTyelC1xG8SewSpAUoBWVJTsqPkDsluRv0yOAJ7nObcoa3Y?=
 =?us-ascii?Q?M8dU2Q4EU0UCON/BknVfF8tkfD6QZ1VG/fMZecVV+jsCyAHqFw1w00SoKc8h?=
 =?us-ascii?Q?GDdsAwlw+Pw8HIGm5zKWrp/8a1MEhu16UZdjHRnIR0j9UeabWDhiWRw/NTaA?=
 =?us-ascii?Q?X88aopFrxym69TjHvjg9KssS11Goo0TbTj3QG50Pa7EE8Q1hX6i40oSQqxXQ?=
 =?us-ascii?Q?iHO94Bv0mKWr0VPVcW21lT+oVMCN/h3j4JxDa8Z8qUKoNerKiyi3dHjAmaC+?=
 =?us-ascii?Q?WCySqdtkLCPguO0gHoXz0ttJjdv+3tODzdt+7AtGT4I3Vh3znQy9YkPqNr3+?=
 =?us-ascii?Q?CDCadKKh75tiMZLdLrbM3IR/D0ptX2GyyR082tblNjRjxoUgmdXt/aqzKjuu?=
 =?us-ascii?Q?cLdH0+Jinnm80EXEV8mCBV9XMRQ2Gh9blDjlXAN9vVNj4jEepSMUwvwPzO9P?=
 =?us-ascii?Q?M3ch8PVRG6Z1qAdwCUarvTYGJlT3NNz9cBLJe6E1mGgsGZMTYxzCKu1qtTdO?=
 =?us-ascii?Q?sFhzHAY3XHgcGmGCnv9JCmMU9MuqxKXQy+4yi0wViYyG5wA8B48o2fVNueBD?=
 =?us-ascii?Q?01WWY2CSbgaOa58fdxZcPyhcRUJ6FUDMq4w3JVEseI0x/aLy++PsghiX3bvD?=
 =?us-ascii?Q?M37Ij6eWoqL4QlYMNffjJAh1j6oKYDvwjSeH3kwf9wJAbBk/fy6vjYYz9F3P?=
 =?us-ascii?Q?3PqyJVYWFiSjfPTOVjuHQRfkoxPZhqpqOPTZLAHdEOziZWqKr0Ui+f5WZW80?=
 =?us-ascii?Q?7+rSGGZxMHjzlquVScgHXJKmatmltakz+5VApRE5bu7ynpVXDenCJ4nhlvRJ?=
 =?us-ascii?Q?eJPKUC5MwT8LrHzHpmnb1F8b5QGr8NdOhad7xkAiHr22m/BOa9Ipxi8dHgJf?=
 =?us-ascii?Q?W0NN6CV3mZgb/b2r6uCseY92ZW0MeaUmorUNzpPeHHnY7KH75vuZnLQycSvX?=
 =?us-ascii?Q?WMb3L3nPCvA91fTKCzvt05Z/lYHmbd6q1mm+NdpbitDm4qs6E0AGSraV6cSP?=
 =?us-ascii?Q?vaMbioujMmw1uPQiwB2BzySYLkU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f7e1da-c0e2-4010-f09d-08d9fa4db6f0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 00:03:14.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeEBSHMmF8z5qSQ1EacQFdeHvNrN9ioWIji3/W3ErYxoCMh3MSEEIEMmUkToza/aWAoiK23+e6bNwlvRtlQtejVd+HlpDozynCuOr8pnm+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6184
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO hog nodes must have a "hog-" prefix or "-hog" suffix according to
the DT schema. Rename the node to pass dtbs_check.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index a823571f8f4b..60b0e650957a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -891,7 +891,7 @@ &gpio {
 	/*AC0-AC7*/	"SYS_PWR_GD","","","","","BMC_READY","SLAVE_PRESENT_L",
 			"BMC_OCP_PG";
 
-	i2c4_o_en {
+	i2c4-o-en-hog {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
 		output-high;
-- 
2.28.0

