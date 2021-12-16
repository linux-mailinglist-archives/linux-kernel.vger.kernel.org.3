Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067AF477D52
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbhLPUUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:20:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33392 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhLPUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:20:04 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGInWvN005091;
        Thu, 16 Dec 2021 20:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=fdoVdxf6gDSe9Z0aQq/l4ni0Hbq7nNmEB5szE8POLEI=;
 b=tGSIWMPxA8f1Vjx3c7FdfO6uLc+gB7q4ak3lUrKdpz/zbanLIP9mpLjAEGLrVe8r6Kph
 a7EHVVP0LRm1rXh2UEnvhaUxi2VKVqjlNiZrT6ryidZJqwEfSw7y6iPcSr7kIeZh9w9a
 4QUzb+OUNpq2ZcnbFyGfIxIPjNbwv0e4B/6hsbNXTFzXxrHXHet7a8A+FchzyWgKpuTE
 cch1ghzlR2F9tu5iU0Fb99jsOi/ZR6rVVQYC9D0oP1at3BIWnALUITpyysODaC40Pm3k
 nIiyzqheAgfmDqMbzL8zLwgBUQRGz96eDEdqBgB7etr2LWYW9VfMVsU/U241ro3W9qpo fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknrkvau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKGD96123962;
        Thu, 16 Dec 2021 20:19:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3030.oracle.com with ESMTP id 3cyjuae09p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPwZFC5V4tCnZEHI4IcLX4fosKYOyUHr/tODay9pc1BpRIGATBkWbzof8Y9kPjAP2WA8OWb0rRJcI6+m7fHEXJJE1X29ZdqqoRqfAtd9cKH+iLN1p9/hIudMZj4B1ekYM38Uw85ty6RULCYHezZxzieZYlpudokCKvww8mm8YenFOhkLMl/uD1Z4+2ghkv38W5l95XH9c+A325KUOWI88L2Weybfmme68Aj/y7JJKSfqQEvhP86bUmQ2jQXSeUYE6Gsv0Vu5sxb6qnOjJzuXiyZdmHYzVtPSgJkDcKS3vR6iin9w1pRZm70o/83ZqeRruiopQO31ppZS5pK4h5vzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdoVdxf6gDSe9Z0aQq/l4ni0Hbq7nNmEB5szE8POLEI=;
 b=hlMgCBqP/oJI85P1CxuhzTMQIdMjWIHAcYzzsoKRBKxwiQWQzG3bB1dGu3mUt7llhzxK1/31EnlEWGFDl4ER2EzY+V3Fp65dhsjDLKBqvbs1uoEFrQb1zGBH2ZKwLKvm5RM49EWZtfA2vxI+GIwabG6IP3AM+GF9uLdJki2A3A+zTsplQ+kMKheUf6mJxrUEjHA9XRohZOeCgCkb/p8c57mgKnnhqhkPQHgauE3CWczo6BnoaTnj/gSx/Vp4O1I9jjh0nwL6N5MIcVTSgBthf/KDaALhaH04rGE1nAi7huc5ZXJIY3EctzGX55tabL+5pkqHb3xGKA4nPdXaGLiH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdoVdxf6gDSe9Z0aQq/l4ni0Hbq7nNmEB5szE8POLEI=;
 b=nzza5DNwuztVuGfMAvp9anzwWkZ8Z6w5NKkQo1T2d5oqSPItKz2Gh3lVsCt1bufqOimrvWwc1kFEqbEUMda4hzBsICWmEiJ/RrAFz8IE/4J2MFA0Iq/jiCgcsIYxb+NEFqynnm58TycL466j0cea3XYCcH0WQuf7l4FeWGbE8uo=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2541.namprd10.prod.outlook.com (2603:10b6:805:44::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 20:19:48 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e%7]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 20:19:48 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v7 1/7] kbuild: bring back tristate.conf
Date:   Thu, 16 Dec 2021 20:19:13 +0000
Message-Id: <20211216201919.234994-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.34.0.258.gc900572c39
In-Reply-To: <20211216201919.234994-1-nick.alcock@oracle.com>
References: <20211216201919.234994-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::10) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9ec893e-00f2-46de-590a-08d9c0d168b7
X-MS-TrafficTypeDiagnostic: SN6PR10MB2541:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2541EA3A49A222614EF64AF28B779@SN6PR10MB2541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jkf4OqrbhvRv4cAR65cY8gjko2kA9ujF+jmrFW2o0BVmwsqOlBgN83J6AWeRFgl1RKWrX3T8iw4CauimELGvYlNyEtddPGkltqMv6KvlxLdA3Cnw8VSXIhQXLAe0Yhl5D/Yn88GTT0J8e0JrH/nkeQGU9yNbVYRSCOTHpRlg90vGdY7lnnvyiPP5b+ct5FTX2yDzThlfWH53VR8UUVL8Vt2tuc4cSGL/PXj+IEqCnujdC5Uq4PXvlYb6k6LrVExRptFlt1PtYuGmKGmbqsyBeesoMDnfkdMcFJ2JBe5hTYv3Y9Edv5bwyZsMSRc5gHV1v5uZe3lfgoCYGjXwmQ/LVbhZZe8h3P0vm2E8Vd4lQGOGdyXLgVJBhqgblKmgK7/d5bE4PEddnlRrp7ftt7dMVyNAIizd5Z76JfvGtwM5jNiVtxD0Chde+elTuZ3580iSRyWqcGSUO7NFVN/7KcbAG520/XewxW2Ab5zSouUI5KYc0N/9jME7g0izB0+GRC8NXY9gYmniPfR+5Dibg4DdDAvypLIerPF+RIKIN8+fhHJ1rzAPuOcWyZ5P2wOFofxh128HgNFha1MxW3JEk0N+U7RizrcvNAA6m5fqE7eeZKHzRK4aAkJsC0kc3UNnwBk+rU8iknxhUAun16SHgGT3ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(52116002)(38100700002)(86362001)(44832011)(36756003)(5660300002)(1076003)(2616005)(6506007)(508600001)(6666004)(66946007)(66556008)(66476007)(186003)(8676002)(316002)(107886003)(6486002)(2906002)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tGkqpck4vik8X7QNbOvS7JUZw9impNjqBqQQ0JMFTZ0zTNPROBVsLgrLuady?=
 =?us-ascii?Q?ZXooHZcnPuYt5sqTr2zpBr27FGamR/w/OBm2zJS9tYaje6O0ny5NkqsNVVKd?=
 =?us-ascii?Q?Sf8AT4AD42YckPs+e8qL3qOLAUyHKg90eOvjUKJHV2ArOgKwTlL6P1WWtObj?=
 =?us-ascii?Q?++6WkDUzeNih3oKel24paQWCemr8C2wrxiuhJXxghVMpYAdTo861rIG6+eDm?=
 =?us-ascii?Q?Jjh6xtEfQwDGfj5agv+N5Vj72S8NecqQRl4PFlU4fZNd/EdzD2x6n96O4dMt?=
 =?us-ascii?Q?hIc+z8tl/9xyla0g92nm2R4HAmHk455IYSeb9UNByLLGFKqde/XueUogqBT6?=
 =?us-ascii?Q?BNvRn4I4O1y7IcNp8pBk5MZP+0ReYVzr5HRDKPUYAJT5jTdexN+Vk8fgCBNB?=
 =?us-ascii?Q?n3vK/4PFkuv99cQLUEA1QMnl9I6hfrz7BfClMr3dfrKaL98iyzY0qYTF6ncs?=
 =?us-ascii?Q?0tNt4/Z9yQBsK5p/LpAuxgKOy7chc+pbjaRHm5injxr8fe7u0m+zopWjbzHb?=
 =?us-ascii?Q?Wgu3c+hH9nnn5N96B7WNvIXMfhD4gbzgbKXUUjp3sGVbmF4CJxUr2fGde4Ld?=
 =?us-ascii?Q?g0sCvePKmTmlw4PSVzb4Xelm7eHF/XQ+pS0vOdwA7wEhL7X0Di2TEDqZ/gs5?=
 =?us-ascii?Q?06A+XKlYx9PPugTKn0QkPCaXlaExizRkiT54m7Ems0FrLNXnCJNs7wEJRtDI?=
 =?us-ascii?Q?iN0JrqTw82T44/U7o/WYNrGtbTBQiySQY4w18QTCcAYoFw81QQN88uxT3MO9?=
 =?us-ascii?Q?TR9oRULNKeu/COlQj6ksOYB9Fs2ohXyERNwVileunWd1N51VUh8llqdyEWS0?=
 =?us-ascii?Q?bM//NaMU28VDNDGN7UmtoHeRXVfgoXvU/OjxipAYD1IVzorEgtJSV5lMQa2K?=
 =?us-ascii?Q?oJ+ZQMOR5ZCwqPrDpDaZm0jqYt44E14Q7q5weiEBhImHWC5U322BzXei46ju?=
 =?us-ascii?Q?54UkgNUG0je5CpXEOQ8AVAXeygiTfkGYb2TWta0NnVFCqtJ9+Qhj0DkPXQgz?=
 =?us-ascii?Q?3vhtxDiOy7UbsRDL46IjggIUy/Dmj0wfA1GQsYdP1MmHsyEEKuffwQo9F74m?=
 =?us-ascii?Q?vHCh3WparrHmXsONPgQcGBa0fje0gjADlT9p5Z+5C0NdLIUQPajqb25G+po9?=
 =?us-ascii?Q?6SHSz2umByzUhY0kD4iRWeZBUDxakcihSnOT3/WTvvm9OGYpDj9Hojd78at7?=
 =?us-ascii?Q?pxu+8ms7kAcjRracq23PQKWLXi0ny5P7JRyuqOqrjZY8+Q91SVdkC+V4jKA3?=
 =?us-ascii?Q?+rR+QArKRuVfXOmUXkSqtMNWpnofJuhGwz5KUkAu0734TrdCDAHovwcm4cS+?=
 =?us-ascii?Q?iHemdXppCcOsiNO32WxHRo36ou9aVBCYtnUz3vJem6Lye9XpgsKyHAJBLQeR?=
 =?us-ascii?Q?akaqAxWUmtP9V23p6E50QO4jXpGYfp00CRZyM34hvyKquZVVsWWNXEfN33Xl?=
 =?us-ascii?Q?lxlSdKg3hMTtls+GYBb44ddmcY7tnhp7JjdDVX4fasPGr1KQoDUbihvLqYax?=
 =?us-ascii?Q?4Dc3s/kHw/YPr7vpSAjSbmHDLvLWbgAcM4K9872ZhqVqQWp/xQJb95pdYuly?=
 =?us-ascii?Q?rbPRhEjbrBCzLQD8pc6DIhRsT6Vz3Hj+R6NVlhEEr6HkXO9ApSCZzAomVsb9?=
 =?us-ascii?Q?L0f2LylPnHxqMrHXa0EdDrx9z98chg4QXmOm5MWj2f+d?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ec893e-00f2-46de-590a-08d9c0d168b7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 20:19:48.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EEF/Eru4kQ5FwCu0ExttJC2jYwSHmG2KpyIi5b4CKp07gqxmK763zd30eZ5+MKSX7CuntPBrDso9dgYH63+xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160110
X-Proofpoint-ORIG-GUID: MpVCiALNpVDKyUzrV0fT_EymCDgnYy9H
X-Proofpoint-GUID: MpVCiALNpVDKyUzrV0fT_EymCDgnYy9H
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tristate.conf was dropped because it is not needed to build a
modules.builtin (although dropping it introduces a few false positives
into modules.builtin support), and doing so avoids one round of
recursion through the build tree to build it.  But kallmodsyms support
requires building a mapping from object file name to built-in module
name for all builtin modules: this seems to me impossible to accomplish
without parsing all makefiles under the influence of tristate.conf,
since the makefiles are the only place this mapping is recorded.

So bring it back for this purpose.  (Thanks to the refactoring in
the 5.16 timeframe, this is basically a reimplementation of commit
8b41fc4454e36fbfdbb23f940d023d4dece2de29 rather than a simple
reversion.)

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---

Notes:
    v7: rewrite in terms of the new confdata refactoring

 Documentation/kbuild/kconfig.rst |  5 +++++
 Makefile                         |  2 +-
 scripts/kconfig/confdata.c       | 36 +++++++++++++++++++++++++++-----
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/kbuild/kconfig.rst b/Documentation/kbuild/kconfig.rst
index 5967c79c3baa..e2c78760d442 100644
--- a/Documentation/kbuild/kconfig.rst
+++ b/Documentation/kbuild/kconfig.rst
@@ -162,6 +162,11 @@ KCONFIG_AUTOCONFIG
 This environment variable can be set to specify the path & name of the
 "auto.conf" file.  Its default value is "include/config/auto.conf".
 
+KCONFIG_TRISTATE
+----------------
+This environment variable can be set to specify the path & name of the
+"tristate.conf" file.  Its default value is "include/config/tristate.conf".
+
 KCONFIG_AUTOHEADER
 ------------------
 This environment variable can be set to specify the path & name of the
diff --git a/Makefile b/Makefile
index 765115c99655..879066d1af4b 100644
--- a/Makefile
+++ b/Makefile
@@ -727,7 +727,7 @@ $(KCONFIG_CONFIG):
 #
 # Do not use $(call cmd,...) here. That would suppress prompts from syncconfig,
 # so you cannot notice that Kconfig is waiting for the user input.
-%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h: $(KCONFIG_CONFIG)
+%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h %/tristate.conf: $(KCONFIG_CONFIG)
 	$(Q)$(kecho) "  SYNC    $@"
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else # !may-sync-config
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 42bc56ee238c..1d30faff6984 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -216,6 +216,13 @@ static const char *conf_get_autoheader_name(void)
 	return name ? name : "include/generated/autoconf.h";
 }
 
+static const char *conf_get_tristate_name(void)
+{
+	char *name = getenv("KCONFIG_TRISTATE");
+
+	return name ? name : "include/config/tristate.conf";
+}
+
 static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 {
 	char *p2;
@@ -666,7 +673,8 @@ static char *escape_string_value(const char *in)
 enum output_n { OUTPUT_N, OUTPUT_N_AS_UNSET, OUTPUT_N_NONE };
 
 static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
-			   bool escape_string)
+			   bool escape_string, bool upcase_string,
+			   bool tristate_only)
 {
 	const char *val;
 	char *escaped = NULL;
@@ -674,6 +682,9 @@ static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
 	if (sym->type == S_UNKNOWN)
 		return;
 
+	if (sym->type != S_TRISTATE && tristate_only)
+		return;
+
 	val = sym_get_string_value(sym);
 
 	if ((sym->type == S_BOOLEAN || sym->type == S_TRISTATE) &&
@@ -688,24 +699,32 @@ static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
 		val = escaped;
 	}
 
-	fprintf(fp, "%s%s=%s\n", CONFIG_, sym->name, val);
+	if (upcase_string)
+		fprintf(fp, "%s%s=%c\n", CONFIG_, sym->name, (char)toupper(*val));
+	else
+		fprintf(fp, "%s%s=%s\n", CONFIG_, sym->name, val);
 
 	free(escaped);
 }
 
 static void print_symbol_for_dotconfig(FILE *fp, struct symbol *sym)
 {
-	__print_symbol(fp, sym, OUTPUT_N_AS_UNSET, true);
+	__print_symbol(fp, sym, OUTPUT_N_AS_UNSET, true, false, false);
 }
 
 static void print_symbol_for_autoconf(FILE *fp, struct symbol *sym)
 {
-	__print_symbol(fp, sym, OUTPUT_N_NONE, true);
+	__print_symbol(fp, sym, OUTPUT_N_NONE, true, false, false);
+}
+
+static void print_symbol_for_tristate(FILE *fp, struct symbol *sym)
+{
+	__print_symbol(fp, sym, OUTPUT_N_NONE, true, true, true);
 }
 
 void print_symbol_for_listconfig(struct symbol *sym)
 {
-	__print_symbol(stdout, sym, OUTPUT_N, true);
+	__print_symbol(stdout, sym, OUTPUT_N, true, false, false);
 }
 
 static void print_symbol_for_c(FILE *fp, struct symbol *sym)
@@ -1129,6 +1148,13 @@ int conf_write_autoconf(int overwrite)
 	if (ret)
 		return ret;
 
+
+	ret = __conf_write_autoconf(conf_get_tristate_name(),
+				    print_symbol_for_tristate,
+				    &comment_style_pound);
+	if (ret)
+		return ret;
+
 	/*
 	 * Create include/config/auto.conf. This must be the last step because
 	 * Kbuild has a dependency on auto.conf and this marks the successful
-- 
2.34.0.258.gc900572c39

