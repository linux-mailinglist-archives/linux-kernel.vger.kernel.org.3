Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802D248ED05
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiANPTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:19:23 -0500
Received: from mail-gv0che01on2108.outbound.protection.outlook.com ([40.107.23.108]:64257
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235681AbiANPTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:19:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTEAjQw9iNnEd0ZxAmIHOjMF34ojAXxyZ7jAaIrYiN7ts9nLbUlCoHWqBqZvyqnPZ/p1VEVT6fzDMs3fmUcR+jNHervzJ7ar6xvrfn11Yjkf9uC4GIjSRnnv0OBIkVdScVFCxKy4Dimc/rkrO2fGkVuCaxAdjI3Y38c0ICpZinQpRL4YgdYFwYOwyUuy3FslAF9PfOpfT0mXJZmFapmzbBO1w2IRSppnvrOkDsXWafXHI8th3oOgVa0bXu+GzYK02n76BvWu7n94n3yD0bkBm6B2MPtmiLFP6xlsif2XJXrrY4Zc5J5niKolrIJm3qFwr/MZHZ9WXFAWPJPQG6RS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqzNVp++vLnkPZ3x2sQjCax3A8kzgFudflQGOPaUzcc=;
 b=K4W79c1iSHwiKLn24A78P2jj7lXqXxtGhzfFkwYhNXmBupLmdbIoGkmdt8WAigvLI3NNvAu0m4xgtKklIK5Y8wjLV4BuK94bfya0ET7fAa2XsZYaw7XF23S5MIvHW9wPoMSKA8RJHmD6w1yxE5432zdiFLE022XSD4HFqST7nwaEYe0iQUpEBGfHtGAvVnLTp6HMEH4ptE2hdrnyeDQ6RcenzNRhOJvAWcL4kLeBxVeeepcHQgr19TFYqZZtsv+DbnlAOy2AWcVTGVdl2u5Ql41+6nfo2/enr73Bo9MTLheeSKlLhjYI1PtBElX4GErYsy6vwQVUtB77OBYKPq+zjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqzNVp++vLnkPZ3x2sQjCax3A8kzgFudflQGOPaUzcc=;
 b=IAKqD8KxvWT9LoNo80B2ZH1GxFdFqviropB3spjUDMI7lD7XK33vndt7hKbEsTmYTFnCpyQu0N086x7jY3hHyo4tVBhqQr5Inc2i/dEeqJEU0UfRlvxZfEVzlGcpNI46W/6V2wK7HsiGx+rNSSHw8KeYdRxE7fSrH7A/147Av0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by ZRAP278MB0080.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 15:19:05 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0%2]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 15:19:05 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Stefan Agner <stefan.agner@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/2] cpufreq: Add i.MX7S to cpufreq-dt-platdev blocklist
Date:   Fri, 14 Jan 2022 16:18:47 +0100
Message-Id: <20220114151847.290518-3-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114151847.290518-1-francesco.dolcini@toradex.com>
References: <20220114151847.290518-1-francesco.dolcini@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0085.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::18) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e94f3f5-cb45-4df7-620d-08d9d77133b1
X-MS-TrafficTypeDiagnostic: ZRAP278MB0080:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB00801563131A6BB31078656CE2549@ZRAP278MB0080.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUbw5BRIwxSp6tz/XCDQ+2FMn/WJ2Dnfhgl/lP65n4OcTQupjMvC/WTi20o5KQkOf34+erm9qrwT6aTxI8BzT6/36zlpkpgwdpPQz8cQLpls+AElT2TcDFN91mNKoQiN1RJY8TMQ8nyx6+QHjo/XJNxCYPOiiLyz87a3Brc9I4B7Sfb9AJEfE6rvMyavXIZcxeCsY7+OsEklnB7TSEzkLljMbCSp6qZUas8Z2S1G+lc78w6bAUgfJRTRNLnLoOXCk8N2JFC1SJE1XI8EnRED0sEP8m7kK37K2VvlGlUAI4dmdJqEZfKhUNa+PwZhceWWNTbbo7u+V9VdODa3hXCCtZ3l77tJkWfqyMwNohc2TgguapjUYiY5KaX8VPJcxN0oLTtJllhoefCXWXCCoVFulLTOzutqjQywSLrFhj+UksLkedwzboA37wCyV/7EUniQ5XuVesid7TwVSL4kw6BjMSFv/kAvuSXAGAcqTQp7q/Xpqqf1D7SRn94+0DB7Kv5O+SzqMtLNwrKIYZXZRimNO5W5fPCtIyFBNEn8j8DEEXEArqxy5Jpxc4AvLBzilQRezr+AJBNhHjz8afa0fEs4vMjH1dH3LEVAqhKL0J8vUns6AIp4b2rxt88LaVcHlVjd7lCC+dooxlOJYk0XgPuJ/DZVtHQGHZCO3E2B8ReCIsO74c9HkssIIPOg0i8lrXx5+Q1nRY/wONK+vtVuub0iQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(36756003)(110136005)(86362001)(5660300002)(2616005)(316002)(54906003)(38350700002)(6506007)(26005)(52116002)(8676002)(66946007)(66476007)(66556008)(186003)(44832011)(83380400001)(1076003)(107886003)(6512007)(7416002)(6666004)(6486002)(38100700002)(508600001)(4326008)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YKJDa4BzM7kTre8yOeymrpTPsl8uoy2HxNIAfaoRx9B/rTthQPm0qFIVYP0s?=
 =?us-ascii?Q?VyZYqDacBWbunxjp1IZjsERGGk0cQJsF/gXEdX1FjJeOwLNSla7+oCTIsugv?=
 =?us-ascii?Q?aVibtcFjpgvlMCtIMMUx5QqrAnRNn49F3nV5Yj2dmMttbgLdMNJlRjV7ZzXb?=
 =?us-ascii?Q?8vjTtP0KJiW4gZDq0qJPIw6Vlwyf7QUUOvqoXqVJSbzFF/IhquJsjzBJ46Xq?=
 =?us-ascii?Q?SMcks4HfPU+qvpOLcD9kDCelRpuABTScWmi/6S3VbzY4+w4A+9zinkOa1I5f?=
 =?us-ascii?Q?e8yDOWpaOMYHFJw6qi0oUt7u+0HFkjOoseKs7mNd/fEK/sZ8tTrTdDvA/+Xr?=
 =?us-ascii?Q?a7ZohKW0veLWpWawoNiZS7ZmIG8NXSBteqFNRmoXOdIqlfKL8dmG1VZwl3+V?=
 =?us-ascii?Q?IK6XLgumZTQ0EQaiP/ujaYvh/HVdr25Oeu1VkGCTYZ9xv7HjgBkA3XA2YOCE?=
 =?us-ascii?Q?eJQHt+/v3/F0vDMhqG/G+v4h10flN7H0zdKrQISmYZVij/2+HuN4nMw5rOv1?=
 =?us-ascii?Q?ncK3HyBUOslvGa+BRuLvuOCU7rxQh1Mjk+rE4NSOJWh6rtkQ+wu0cCsnSmH3?=
 =?us-ascii?Q?kzAQdYNPIvqKJkttj1/2Jw40YjJQJ/xIJFa4gVuCKAwfOTatk+u0Octyx9xh?=
 =?us-ascii?Q?Ge6h9WICHIgq/yN2EVHPlJsLrjPj4+qIvnnOCTudL4uEs4quWuOsnilEMe76?=
 =?us-ascii?Q?yO3Rq0oG2j423OaDPZIIDXv+18MMYLgVELJZM1zc5V2SMSWjeNTMIlyLGobV?=
 =?us-ascii?Q?sW9F3/30/eDDufeX80WPdIUQReGDkjvLJewcEl0OmsX61r30NnDuthwhiWwY?=
 =?us-ascii?Q?2somJCDogg6UhZcLMuZZ2lkupZISJiFqfKj/uqHE7aUOOOJdD5SGH/dvgq29?=
 =?us-ascii?Q?bFvjQaaNVHRGZyqoCaZ4NUT1Na4Ij2tk1Wxn/S9EHw+gizBm+Z/V5ERMvoPV?=
 =?us-ascii?Q?5oOJJIoOp+gMG4JUWBd1S9rEBjEIuSgdhwPzzAjvrIRmuOybL855/G9CmqjI?=
 =?us-ascii?Q?AwrcvXSgKTizcrvZNfYckBDf7oyxR1zZZtVNAsshu9HH/r/Tk5DXZGqxejCZ?=
 =?us-ascii?Q?mvKH+czdTo4BoAgdtXUJSc2YsfSFW1fq6r5S67u6c3zReQa4Cyc0fZnvIHcj?=
 =?us-ascii?Q?O3+6z5wnrmd+wgXr2VfvpHIrLP2Bm+bGqn7qNIrUZ1/q8w1eNkjYswMobTLQ?=
 =?us-ascii?Q?4ggNILdMqMU3JCTFCi8btmammdB0TZ1wb9h6/yidSIAYZt0cfmqJCcoii410?=
 =?us-ascii?Q?LIxTVjbJSQAF10HqW/H5mCazsdfPDq7gAQLhDnSf7seYQSzXEUX5ATm/k5IS?=
 =?us-ascii?Q?4AN1gps9rXogLOqtbzuh5tmuq9kqKY4ZVWtLlSE8SKRI80BAjRnAqKv2Z09j?=
 =?us-ascii?Q?cQdNa8TCUC6SaK5/4f4sDNEd+b5CcJbdV+vblqKk3RIAGO+RpCJfNoE2mMlH?=
 =?us-ascii?Q?ceScijBg74v3ZfzApap1zNFCdSYiEbVNgzIrNaqHXhzwsqVOvqilqX1qzv7O?=
 =?us-ascii?Q?b9fv9bMgVYf1jshgSDIruWCuKwzbp7ft5X+Fmq8RHvJZvOULFEbNgboBev6T?=
 =?us-ascii?Q?jzULjEVg0zNvawBoTDsmuCUQz6YT4Zdz690IZ2j+kVzljqGYaHf/ysC+yOBg?=
 =?us-ascii?Q?zalhFUz/hpPSKcyyAVLWUvSt4IlUKj46xc/g3o/wnp/fwg79+e5jJHkqvlCq?=
 =?us-ascii?Q?4ZImjA=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e94f3f5-cb45-4df7-620d-08d9d77133b1
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 15:19:04.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtANcMkTvQ28a3GWShcAcw+3gq00eOmkWjG6yYQOhZUTTS9Rf1FLKVNEBacpbUWbvbeknCHzkuufpYpzronyp7tH8aU1H4SZ9JnnQpqrNMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

The i.MX 7Solo currently does not have multiple operating points,
however, in order for the i.MX Thermal driver to successfully probe
a cpufreq device is required. Add it to the cpufreq-dt-platdev
driver's blocklist to allow using imx-cpufreq-dt.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Cc: Stefan Agner <stefan@agner.ch>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ca1d103ec449..2e08f8564a12 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -110,6 +110,8 @@ static const struct of_device_id blocklist[] __initconst = {
 
 	{ .compatible = "fsl,imx7ulp", },
 	{ .compatible = "fsl,imx7d", },
+	{ .compatible = "fsl,imx7s", },
+
 	{ .compatible = "fsl,imx8mq", },
 	{ .compatible = "fsl,imx8mm", },
 	{ .compatible = "fsl,imx8mn", },
-- 
2.25.1

