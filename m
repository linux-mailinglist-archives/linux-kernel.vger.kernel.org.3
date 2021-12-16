Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC79477D49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbhLPUUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:20:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4256 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhLPUT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:19:59 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGIn6ie016283;
        Thu, 16 Dec 2021 20:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=b14iBLRWU0nVcSXUIqFX1pJwnsPw3Y8nCAGtD4diYDA=;
 b=R1JgLXaAMtiPLAsENRvOXieP3GMhD2jBlbznxIdVnHqx8tDs7Qvc53v7H4Isk/CH66fs
 H9hHgxdwsOlD3qSCsRSC5YsO0/wdO7JiW61AO2aig6VD1zj6lutqEq6HDuwyET5j+clw
 vS9mSub7OkblnYt/YDQqZY4T7HLh493OZyCphs5MSOPKoZbERZcdN6tjVPLdqmKVLeLR
 hphhC0ZekumBTBPW6B6OolzpZ/kZqvft0qDaequqELNzWSKIWKvfmktpEIc4WrnY6FE2
 lIVI9xJ3tccEGvjlCcdYOeZ70zMqnlVXg3/iYQb2N7XcoLYOmIGnsy18Stj00D33W9or IA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmbky5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKGbqn047602;
        Thu, 16 Dec 2021 20:19:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3cxmrdxb5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFiLX40OocrEOmzPrqJhGJgdrU7CkNojY3It8qO/f7I0pDMSy10d8vUVSHj4Zyr0xDCWOw6JgpiNWxQMUeR9rq7JBbjP0yB9ZoIiNGsf93B/nIen9JGJlPg2+1f5EbPskc4UUwpZe4wSHuyyIwExJTnj6daz3k584bNWf/x5dXVemxS81LjCcTXxsbWIIOGvzVhSsV8Z3kaPVLOsmw7yQ9giFteacqX5ufD5NRPDwybuQ836E+nz/dcaD/Z1Udr6+6ryTGdNYLS2FLJZAIJJJ8O+q3wk/LmBQ00kBxbKZAUnCD76ssBhRaXTLAO/JUIOFt/ZNoIqgUztbOj4kjKN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b14iBLRWU0nVcSXUIqFX1pJwnsPw3Y8nCAGtD4diYDA=;
 b=iVtQ9l5v7rIDC3N2rAoKQ5wJcvD+1EvSfigJWdqPX/MhlH8UBECn3lKcYj/s9NXgrPNcadW//yO1jx/r+eLM4RN7xaFcOi+OqVH1RT+DrfVKI1/GNvMC+HYFx/MazJYiXJIQHhPDV7WeY/ni9btxPHW5K/pqNifiPDXEhWSfUuI0VAiHVrRP01T8EzlRXskkQA1K0MUdIhXp5skz1olGqcEnz3FjunQFQLomR9li8eyXQsXRD8XJA3tVwsrTZeWkz7t4VkmY7Alu+OIW8/yxjoF1CTCy+ETTG1gyDmeqxPak9FjYeqKXm6quNhjNQgL58a/xqj2/8ejfPE2eF85O3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b14iBLRWU0nVcSXUIqFX1pJwnsPw3Y8nCAGtD4diYDA=;
 b=oLaC5Rx2jpocxfyoz7PgAELBvHJqG4igH0DGKCJQsJOqtQQ9sNZx/n9pb0qY6pMnsqMKzI76KVM6P1oQP43lT0BtgoS3CQy9c11VkW0M9sWmx77Vhh2VqEQhHB2aU76z198tId5p3cCcJsmcRHQWGFQ9MBG1foEjyOfoEdyrJWM=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2541.namprd10.prod.outlook.com (2603:10b6:805:44::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 20:19:50 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e%7]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 20:19:50 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v7 2/7] kbuild: add modules_thick.builtin
Date:   Thu, 16 Dec 2021 20:19:14 +0000
Message-Id: <20211216201919.234994-3-nick.alcock@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3ac7cb4-bdb0-455a-5595-08d9c0d169a1
X-MS-TrafficTypeDiagnostic: SN6PR10MB2541:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2541A5D94AAC33C102CA82358B779@SN6PR10MB2541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0v6+HychBpRunCBxU4xBijDgQLK7bzJ44oJ8572wlsKBT+tpbZioWc/sdmUq20B7SqxQkWtBTZGXou5TouMi2yBK+u2YgdgBj1d0SlgMYxbnpOPykd35zij/CZqCIZ1szU2x6YA2cHwrRVW5Sb1tojuFBjT1APpYK4ZuD3KV8z80/gyQrdQfDY5aZU0EX6IgSUdyowWJp2lby8dZ0fCC99kmUJOr78d7BD1VplwHY/lfpL/eUr3rz7Or5RYxU29M5e9RduHV6WqxMY2LJqur1LQNzSiU6YJFJ5wKsUw5Rhk9aUn1S6fZZ8ql/WYfXlPkI65aYDrFu25vJPE5+SICgsGVa1vervMmmA6pJi49i/+ZemM3RKmRcHUzmXzRYmsE7eyJ3M5cbbW9WadjmTdoQH6fufkV0T2mMPItCaDoH4Sf/w7LfU2zmsPAlkfLCyiYYTCjeo6kkT3wmXH/8ePllp3gqpgX6huhYu2LlbZuxdM6z+Xm4wODtBKT0bKgQtt94AiC2/dIMcGl9pcF9/SJ2bUUopqurr0qavvNO2O6vAynVXARAanjxW5sRYvkOpuj7Tpn8SjCmM8iyUshX3jbV8s6xdwDQbProW/yXbjdyLFadId8vqe6ZO/wpXfpwotzGgaXqrAYMdFIsp4KjDJslO/hQuvZtAwNBjicw/XFOcQoLlNw3uCCxfwvMpn/uxXxALyUqymtviIhBSr3wTVgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(30864003)(83380400001)(52116002)(38100700002)(86362001)(44832011)(36756003)(5660300002)(1076003)(2616005)(6506007)(508600001)(6666004)(66946007)(66556008)(66476007)(186003)(8676002)(316002)(107886003)(6486002)(2906002)(8936002)(4326008)(6512007)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XL43zFdmKUCo+2WlYCVIdNmnhPQIipWAAKxl1QCeG1pCsr43dhuj2hsPPgPX?=
 =?us-ascii?Q?sGegqUYOL4PNUACt2MvJSFsuyiZSY/H6xs2Pnat/81ZrYPkioOYCMEwKVlV5?=
 =?us-ascii?Q?38elUSLPfvnZRRU+hctwPHC2lUFRz/ZaCkyAwMwEbinYSDchlVtag8056h/s?=
 =?us-ascii?Q?lMkSkvop6C+3aDft/oiPXGb0nxozqyQnDZH5uBqv9jGZeUzJBP359I6/Xend?=
 =?us-ascii?Q?bCA+tCec8NbG1GuYX+nm0NbIAF7+hpM5Qa9KrWulyE/NK2C6Wvqsjg//gr7r?=
 =?us-ascii?Q?SPGcvsTr+dgTD0rLccCW3KGW/GG55qy5NQoHfutUSWDmtVdzxz1Z6BvNfMRp?=
 =?us-ascii?Q?P4u4Ex8s5GQMzCO10dYP7oj5TUv361uFjhhWdldFSeQhSWv4P6ktM+By/AR2?=
 =?us-ascii?Q?4s/xovoYNm2mrm4ZAHp/0W31S4QtySlATZJsY/rOo71e8+frdYxFq1ztkWjf?=
 =?us-ascii?Q?W2OGl9LxJzN0YGxY74HBv6p0cEj9S2taDFu0NfAj2dStJoYgxvT3lJnpUiC2?=
 =?us-ascii?Q?AYj4mS60OyYR6iexAact1l6SacRBK4ytGDiFcRvkS2L+RzzA8a1VcjoYougy?=
 =?us-ascii?Q?xgGl5nXVbgp8HVHuk9Tx9OL1zqbbv0RGKsl0EskyAyVzFL96gFdE5MSOiyXm?=
 =?us-ascii?Q?LGBruUiwcWZG7AlHB7nAkshJQwPnia0O4Wc/V/C8k5ucURKb2pQIIFsW7d/G?=
 =?us-ascii?Q?n+69ZMWwo7bHKAQahJ9P5sBf1yPTsbLTNOCV3OgSLOL2rWA8H1n7MeQI+sRw?=
 =?us-ascii?Q?uURXhzUJQCg4Z4yqPrD67PMLhTghXeSdKbJQGe5RGT3Lai1llvVfkGbc1vpN?=
 =?us-ascii?Q?Q6zI0hhnHLbCAfub4W/+msXpMkdQCevOsv9J9wqI9cjXK4rw/wOk4OjwPOxc?=
 =?us-ascii?Q?w2VksTSZpmSB0Gybl+vYIwQKjNn+7g6/359VQKlFdj7iuiDBOuL/LjQ8edWx?=
 =?us-ascii?Q?l4yvM3TKLMblD/F2qow7E0SUkYIxUrHWBVEwg4Z+MIWyKZMQkb1YYkfce1QI?=
 =?us-ascii?Q?yHgMno7wrni16Xa2I5tYkkl5LuWRN2xRk+wp/B4i+UYWG8vtRUktBdUkC8jP?=
 =?us-ascii?Q?2fbCBh6zLWS8bSS4pDutM4jr/wBVcLlwpLr2imT3G2JVh+FNK5SS7f0xb/6G?=
 =?us-ascii?Q?aIrUWaJ1y5uXwfoiPfXkNoGqK/8BPLXP8ziZPj/oHIabz2xrvctWkLfaekcX?=
 =?us-ascii?Q?G9DgNagODIPLsEK5KcAuMFopwK794dv1MH3gDfvb5Ugum6NC92U5XI2dCHYR?=
 =?us-ascii?Q?24orj1/6c0bwrTirOasqj994UQ36PYZw6+9QcKGoXVPrNLnNOz/UcknaZ5q1?=
 =?us-ascii?Q?S/BZblvvd9BYpJkR3Nv2VlTXgawY34/rEV4UMTatuEP+Vzj8nbPAoGYm80J9?=
 =?us-ascii?Q?kiSLlVKYri4Al2ukTzIYP1zUbIwaE0+BuK8m5HJ6ZVVrx7IR+X0KqgiOtqgb?=
 =?us-ascii?Q?cfC1wxGPdb0AM9+WQVWkFmrzhSFQMCbU5jaxhVIo/VZ+rDPlQ6MDomFudFwj?=
 =?us-ascii?Q?FL0H4E+tdWWyLN86U060VVLfd7+H0nAX+KnjM2TGMcHtk8yl34ZW9XpOVKdr?=
 =?us-ascii?Q?lDBz7bHLfd3WxydjfkhDInvwJYDVcXvjScZ51Oq80r4OI3GE5iLSb687FK1t?=
 =?us-ascii?Q?EF1RpVXBOt+mlCuTCEMioiUSIqMh8BOqWEdwLohszuoC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ac7cb4-bdb0-455a-5595-08d9c0d169a1
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 20:19:50.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+Ur41n092RHBWS0+Cf9wRjDOfTqRtTvts4Ol5EngPCgOE8jXHqNof1GYClUmrN7lzlv560yYGTzn6lnjjh59A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112160110
X-Proofpoint-ORIG-GUID: YS6tnhHrqPi_Qy53VYpt8bxI8qUj51mu
X-Proofpoint-GUID: YS6tnhHrqPi_Qy53VYpt8bxI8qUj51mu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is similar to modules.builtin, and constructed in a similar way to
the way that used to be built before commit
8b41fc4454e36fbfdbb23f940d023d4dece2de29, via tristate.conf inclusion
and recursive concatenation up the tree. Unlike modules.builtin,
modules_thick.builtin givs the names of the object files that make up
modules that are comprised of more than one object file, using a syntax
similar to that of makefiles, e.g.:

crypto/crypto.o: crypto/api.o crypto/cipher.o crypto/compress.o crypto/memneq.o
crypto/crypto_algapi.o: crypto/algapi.o crypto/proc.o crypto/scatterwalk.o
crypto/aead.o:
crypto/geniv.o:

(where the latter two are single-file modules).

An upcoming commit will use this mapping to populate /proc/kallmodsyms.

A parser is included that yields a stram of (module, objfile name[])
mappings: it's a bit baroque, but then parsing text files in C is quite
painful, and I'd rather put the complexity in here than in its callers.
The parser is not built in this commit, nor does it have any callers
yet; nor is any rule added that causes modules_thick.builtin to actually
be constructed.  (Again, see a later commit for that.)

I am not wedded to the approach used to construct this file, but I don't
see any other way to do it despite spending a week or so trying to tie
it into Kbuild without using a separate Makefile.modbuiltin: unlike the
names of builtin modules (which are also recorded in the source files
themseves via MODULE_*() macros) the mapping from object file name to
built-in module name is not recorded anywhere but in the makefiles
themselves, so we have to at least reparse them with something to
indicate the builtin-ness of each module (i.e., tristate.conf) if we are
to figure out which modules are built-in and which are not.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 .gitignore                  |   1 +
 Documentation/dontdiff      |   1 +
 Makefile                    |  19 +++-
 scripts/Kbuild.include      |   6 ++
 scripts/Makefile.modbuiltin |  56 ++++++++++
 scripts/modules_thick.c     | 200 ++++++++++++++++++++++++++++++++++++
 scripts/modules_thick.h     |  48 +++++++++
 7 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 scripts/Makefile.modbuiltin
 create mode 100644 scripts/modules_thick.c
 create mode 100644 scripts/modules_thick.h

diff --git a/.gitignore b/.gitignore
index 7afd412dadd2..b49cd96f587a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,6 +49,7 @@
 *.zst
 Module.symvers
 modules.order
+modules_thick.builtin
 
 #
 # Top-level generic files
diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 910b30a2a7d9..6a78988547d0 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -183,6 +183,7 @@ modules.builtin
 modules.builtin.modinfo
 modules.nsdeps
 modules.order
+modules_thick.builtin
 modversions.h*
 nconf
 nconf-cfg
diff --git a/Makefile b/Makefile
index 879066d1af4b..f94b5f05e9f5 100644
--- a/Makefile
+++ b/Makefile
@@ -1485,6 +1485,23 @@ __modinst_pre:
 
 endif # CONFIG_MODULES
 
+# modules_thick.builtin maps from kernel modules (or rather the object file
+# names they would have had had they not been built in) to their constituent
+# object files: we can use this to determine which modules any given object
+# file is part of.  (We cannot eliminate the slight redundancy here without
+# double-expansion.)
+
+modthickbuiltin-files := $(addsuffix /modules_thick.builtin, $(build-dirs))
+
+modules_thick.builtin: $(modthickbuiltin-files)
+	$(Q)$(AWK) '!x[$$0]++' $(addsuffix /$@, $(build-dirs)) > $@
+
+# tristate.conf is not included from this Makefile. Add it as a prerequisite
+# here to make it self-healing in case somebody accidentally removes it.
+$(modthickbuiltin-files): include/config/tristate.conf
+	$(Q)$(MAKE) $(modbuiltin)=$(patsubst %/modules_thick.builtin,%,$@) builtin-file=modules_thick.builtin
+
+
 ###
 # Cleaning is done on three levels.
 # make clean     Delete most generated files
@@ -1864,7 +1881,7 @@ clean: $(clean-dirs)
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name '.tmp_*.o.*' \
+		-o -name '.tmp_*.o.*' -o -name modules_thick.builtin \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index cdec22088423..ef68635831b0 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -74,6 +74,12 @@ endef
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(srctree)/scripts/Makefile.build obj
 
+###
+# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.modbuiltin obj=
+# Usage:
+# $(Q)$(MAKE) $(modbuiltin)=dir
+modbuiltin := -f $(srctree)/scripts/Makefile.modbuiltin obj
+
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
 # Usage:
diff --git a/scripts/Makefile.modbuiltin b/scripts/Makefile.modbuiltin
new file mode 100644
index 000000000000..a27b692ea795
--- /dev/null
+++ b/scripts/Makefile.modbuiltin
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+# Generating modules_thick.builtin
+# ==========================================================================
+
+src := $(obj)
+
+PHONY := __modbuiltin
+__modbuiltin:
+
+include include/config/auto.conf
+# tristate.conf sets tristate variables to uppercase 'Y' or 'M'
+# That way, we get the list of built-in modules in obj-Y
+include include/config/tristate.conf
+
+include scripts/Kbuild.include
+
+ifdef building_out_of_srctree
+# Create output directory if not already present
+_dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
+endif
+
+# The filename Kbuild has precedence over Makefile
+kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
+kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
+include $(kbuild-file)
+
+include scripts/Makefile.lib
+
+modthickbuiltin-subdirs := $(patsubst %,%/modules_thick.builtin, $(subdir-ym))
+modthickbuiltin-target  := $(obj)/modules_thick.builtin
+
+__modbuiltin: $(obj)/$(builtin-file) $(subdir-ym)
+	@:
+
+$(modthickbuiltin-target): $(subdir-ym) FORCE
+	$(Q) rm -f $@
+	$(Q) $(foreach mod-o, $(filter %.o,$(obj-Y)),\
+		printf "%s:" $(addprefix $(obj)/,$(mod-o)) >> $@; \
+		printf " %s" $(sort $(strip $(addprefix $(obj)/,$($(mod-o:.o=-objs)) \
+			$($(mod-o:.o=-y)) $($(mod-o:.o=-Y))))) >> $@; \
+		printf "\n" >> $@; ) \
+	cat /dev/null $(modthickbuiltin-subdirs) >> $@;
+
+PHONY += FORCE
+
+FORCE:
+
+# Descending
+# ---------------------------------------------------------------------------
+
+PHONY += $(subdir-ym)
+$(subdir-ym):
+	$(Q)$(MAKE) $(modbuiltin)=$@ builtin-file=$(builtin-file)
+
+.PHONY: $(PHONY)
diff --git a/scripts/modules_thick.c b/scripts/modules_thick.c
new file mode 100644
index 000000000000..9a15e99c1330
--- /dev/null
+++ b/scripts/modules_thick.c
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "modules_thick.h"
+
+/*
+ * Read a modules_thick.builtin file and translate it into a stream of
+ * name / module-name pairs.
+ */
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file)
+{
+	struct modules_thick_iter *i;
+
+	i = calloc(1, sizeof(struct modules_thick_iter));
+	if (i == NULL)
+		return NULL;
+
+	i->f = fopen(modules_thick_file, "r");
+
+	if (i->f == NULL) {
+		fprintf(stderr, "Cannot open builtin module file %s: %s\n",
+			modules_thick_file, strerror(errno));
+		return NULL;
+	}
+
+	return i;
+}
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name)
+{
+	size_t npaths = 1;
+	char **module_paths;
+	char *last_slash;
+	char *last_dot;
+	char *trailing_linefeed;
+	char *object_name = i->line;
+	char *dash;
+	int composite = 0;
+
+	/*
+	 * Read in all module entries, computing the suffixless, pathless name
+	 * of the module and building the next arrayful of object file names for
+	 * return.
+	 *
+	 * Modules can consist of multiple files: in this case, the portion
+	 * before the colon is the path to the module (as before): the portion
+	 * after the colon is a space-separated list of files that should be
+	 * considered part of this module.  In this case, the portion before the
+	 * name is an "object file" that does not actually exist: it is merged
+	 * into built-in.a without ever being written out.
+	 *
+	 * All module names have - translated to _, to match what is done to the
+	 * names of the same things when built as modules.
+	 */
+
+	/*
+	 * Reinvocation of exhausted iterator. Return NULL, once.
+	 */
+retry:
+	if (getline(&i->line, &i->line_size, i->f) < 0) {
+		if (ferror(i->f)) {
+			fprintf(stderr, "Error reading from modules_thick file:"
+				" %s\n", strerror(errno));
+			exit(1);
+		}
+		rewind(i->f);
+		return NULL;
+	}
+
+	if (i->line[0] == '\0')
+		goto retry;
+
+	/*
+	 * Slice the line in two at the colon, if any.  If there is anything
+	 * past the ': ', this is a composite module.  (We allow for no colon
+	 * for robustness, even though one should always be present.)
+	 */
+	if (strchr(i->line, ':') != NULL) {
+		char *name_start;
+
+		object_name = strchr(i->line, ':');
+		*object_name = '\0';
+		object_name++;
+		name_start = object_name + strspn(object_name, " \n");
+		if (*name_start != '\0') {
+			composite = 1;
+			object_name = name_start;
+		}
+	}
+
+	/*
+	 * Figure out the module name.
+	 */
+	last_slash = strrchr(i->line, '/');
+	last_slash = (!last_slash) ? i->line :
+		last_slash + 1;
+	free(*module_name);
+	*module_name = strdup(last_slash);
+	dash = *module_name;
+
+	while (dash != NULL) {
+		dash = strchr(dash, '-');
+		if (dash != NULL)
+			*dash = '_';
+	}
+
+	last_dot = strrchr(*module_name, '.');
+	if (last_dot != NULL)
+		*last_dot = '\0';
+
+	trailing_linefeed = strchr(object_name, '\n');
+	if (trailing_linefeed != NULL)
+		*trailing_linefeed = '\0';
+
+	/*
+	 * Multifile separator? Object file names explicitly stated:
+	 * slice them up and shuffle them in.
+	 *
+	 * The array size may be an overestimate if any object file
+	 * names start or end with spaces (very unlikely) but cannot be
+	 * an underestimate.  (Check for it anyway.)
+	 */
+	if (composite) {
+		char *one_object;
+
+		for (npaths = 0, one_object = object_name;
+		     one_object != NULL;
+		     npaths++, one_object = strchr(one_object + 1, ' '));
+	}
+
+	module_paths = malloc((npaths + 1) * sizeof(char *));
+	if (!module_paths) {
+		fprintf(stderr, "%s: out of memory on module %s\n", __func__,
+			*module_name);
+		exit(1);
+	}
+
+	if (composite) {
+		char *one_object;
+		size_t i = 0;
+
+		while ((one_object = strsep(&object_name, " ")) != NULL) {
+			if (i >= npaths) {
+				fprintf(stderr, "%s: num_objs overflow on module "
+					"%s: this is a bug.\n", __func__,
+					*module_name);
+				exit(1);
+			}
+
+			module_paths[i++] = one_object;
+		}
+	} else
+		module_paths[0] = i->line;	/* untransformed module name */
+
+	module_paths[npaths] = NULL;
+
+	return module_paths;
+}
+
+/*
+ * Free an iterator. Can be called while iteration is underway, so even
+ * state that is freed at the end of iteration must be freed here too.
+ */
+void
+modules_thick_iter_free(struct modules_thick_iter *i)
+{
+	if (i == NULL)
+		return;
+	fclose(i->f);
+	free(i->line);
+	free(i);
+}
diff --git a/scripts/modules_thick.h b/scripts/modules_thick.h
new file mode 100644
index 000000000000..f5edcaf9550c
--- /dev/null
+++ b/scripts/modules_thick.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple modules_thick reader.
+ *
+ * (C) 2014, 2021 Oracle, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _LINUX_MODULES_THICK_H
+#define _LINUX_MODULES_THICK_H
+
+#include <stdio.h>
+#include <stddef.h>
+
+/*
+ * modules_thick.builtin iteration state.
+ */
+struct modules_thick_iter {
+	FILE *f;
+	char *line;
+	size_t line_size;
+};
+
+/*
+ * Construct a modules_thick.builtin iterator.
+ */
+struct modules_thick_iter *
+modules_thick_iter_new(const char *modules_thick_file);
+
+/*
+ * Iterate, returning a new null-terminated array of object file names, and a
+ * new dynamically-allocated module name.  (The module name passed in is freed.)
+ *
+ * The array of object file names should be freed by the caller: the strings it
+ * points to are owned by the iterator, and should not be freed.
+ */
+
+char ** __attribute__((__nonnull__))
+modules_thick_iter_next(struct modules_thick_iter *i, char **module_name);
+
+void
+modules_thick_iter_free(struct modules_thick_iter *i);
+
+#endif
-- 
2.34.0.258.gc900572c39

