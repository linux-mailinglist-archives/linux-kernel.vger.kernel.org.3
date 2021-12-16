Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427DC477D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241339AbhLPUVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:21:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41420 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241292AbhLPUVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:21:06 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGIn5Ha025867;
        Thu, 16 Dec 2021 20:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=lPARvt/9VwVgaz1rJeHwdtNSm/OQoGk8u3eBi4Tr6jQ=;
 b=Zf8spPy1GwYrkXl6Mf4BP4gSv/q/KOh28feFfQDWUQlH6ZEsbo1BAR3W2xNMqXH5YqiC
 0Va7nZf1eUVczK7GF+dzvpKNU4b03kvryQmI4YVnSMHNmFqgmkrlE25RNUfxg2gPc4Lw
 k7aHNHisVX977Jlx2WluCRGxOMrO+O8j3m3CH61KV8DYZgE2TidIwYWNAAng4LKfSjrR
 klkOvuJIs44Rr0ueN6G4Dxpp1g/INx/9lZRPDPaKRtg6gJPwaZ6vjzA6vq/5rNmwWSi9
 4pA+QPHBeuTqcTwCyM7FnoCgeP2580lbjncY9WSd39mz81LJfSS0RXWuAt42ShpVo1ok qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp3y7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:20:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKGcsi047804;
        Thu, 16 Dec 2021 20:20:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 3cxmrdxba4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:20:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW80iVaYjZZ15h+eybg11PDAfCXQ4GNuYXf544kazoWNOPjp5d630g8zH7X7AmDPF+f8JqquPGLG7SJEBWNrjpOAJw+Zkhw8moScBgEvlplwZItB9yoAqjk6R3J6V7OAAgOfC6eVb2+wx2yqv3oaKYYUuKRE9tk/E+Q6/rxcOJzlus/Hc6gW6Duee4y0wdlkGy7FdJNbXHrKvmBWhwZQljY9/rUmfBIqoXn0Fc36kZyhS+P03Hq4ev09jx+1YOJpyfLJLohBP7gCVD9gE5k0xPzD3yV6oJSFUq3keobnTtD+8o9DZW9yaNHAQD0XoyUrSoyVr0McFae3SUd/BEqpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPARvt/9VwVgaz1rJeHwdtNSm/OQoGk8u3eBi4Tr6jQ=;
 b=Y4YKtXp0e+lUzuKBYZbCWkEwS+dN8XMnhmW09iEj9GNovbva3BvUPXzkwQIP/TGDKpYgWPCmSGjzb0fcIrelTPcjtnx6lApdyWU56OJiGw0B6evRz25nyHqWrvkZr1wGRrHZ4cdy4GN1zSPwvsBhXJK7LXEfJ9TgS1ZYF86MUGSgoiaLupSwaPgKzfblRlC6fcvM1Z+eNKwZ2fCywLNqNS/YA+fDwLY/PSfnUv1kcbn9Vdre4Imv6E3d4PZ6xvwiZVXVBV1RlCJ05uOkzjH+aeKLWWdRWyP09idFJ96r2k41isz1DpjO7tt+HGwfvrQ/i8R5eKTa9gv7t0Chfk9o0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPARvt/9VwVgaz1rJeHwdtNSm/OQoGk8u3eBi4Tr6jQ=;
 b=s22L3wYDNbnBPUdVPndgI+2HEFiUbb7vKe8/s1+VlR6qYjAAGjmebQB2BfZmG5kLCIniMWRRyjucTgXi+iqRu8dE8BwTVTwHKBLXnqxVBJIbHtquDc7jAXV5K4KSu4WzjuqL68iYFIU9hdYmbZvI3d9JUPs0uX036oYSgcIqtcM=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:22b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 16 Dec
 2021 20:19:58 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e%7]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 20:19:58 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v7 7/7] kallsyms: add reliable symbol size info
Date:   Thu, 16 Dec 2021 20:19:19 +0000
Message-Id: <20211216201919.234994-8-nick.alcock@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 17d3d733-7d47-4541-6e36-08d9c0d16e53
X-MS-TrafficTypeDiagnostic: SA1PR10MB5867:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB5867EBF25F75B732F36D989D8B779@SA1PR10MB5867.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgOVhNwrNEr3MUD7P4PZE2Yl3EROWA4x7SFe9D9PKaDewZFjXGUVbJg/QWpQaPraYIzbNUWM9kAJ5GcpFNephT65OktICXcH5PedlX2r6629HZHZplsNJq7w/ry2hVBIa7IunTm8WPVkXynXFDUpSEXlpO2cr6bMIGLshgpRrCYrm0o4CtR7UHhvFrBngslCcY9wNvenblIritRbK/q41A3C/hBeJeqqGD8g9zTOiGKtiliesLiwt8KKmYWqRKLLYvnJKWQbOGJu+YbGWWI9TkHV0w8NvuMzXOaS9da3V8p9DsBO/Dru5//fSwdYBq6BoXvCKGdqBYKNpBK4haTTUO78ePxsPhMrjWoxdwpz9Oe4F8Aktn7IYKtdZ/B8Q/EnNRKGPrbZN/z/94OEdQ+RT2SJOlISz9Ejortn4o+b9NTxbjuC8UDpgcxrEJOL5YTOZQBR7t+rUe5XI0BJywqzCOEQINuC73K7p0Pv50snuzDNYBN7gNtxqiiSBzlAoGvJC9saGAygbBWnCTD2W8GItFZAnIQBi8dqXKidpFM46StwbKRmWh4elG+KOu1z9OlMNjMjTRLFHyG7opOJ0r8bqYw12UvusHJbvikqZ8EZPGjg1rZjWxMacBRCMHqd1JLZ8RvQA7ITMscgdloBuBw9GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(30864003)(5660300002)(2906002)(38100700002)(6512007)(36756003)(4326008)(6486002)(6666004)(107886003)(66946007)(2616005)(186003)(44832011)(8936002)(6506007)(66556008)(83380400001)(1076003)(8676002)(66476007)(316002)(52116002)(508600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+q5UvA8UGH1XaKYgmnaddhHbzNnkdEI0w0kcpHiF56wKk1A39VWnMo6JqXPU?=
 =?us-ascii?Q?pxFCdPIt8RNYNH4cfe7WsbXRy0N6RlA00Oxf/4dhy9DDkMvIF3QyNSd5uiXU?=
 =?us-ascii?Q?4yV76C76Hc9fzyFb6oYMnpxVpS0vEdX54MUraaenRZuuOtBKuwmn1ZQJhWUw?=
 =?us-ascii?Q?/438lre7dC64GtcjfJwO9XnqpGyJKDXc8J5ZnxOAoDhDv71+iphXqpQnrYqR?=
 =?us-ascii?Q?skYLzXa6GrDUmwdNi00gYw3H8aU5pN7Jzkoy6IjXkufNm3QBeWTmh46TpEkF?=
 =?us-ascii?Q?82k0Y6G3oOX5mvjQBCVdcsWNqg02nEXg+5AKMS/zq0zgDC/RqDpm0sXT3mMa?=
 =?us-ascii?Q?/oJLBR3OtIN+4cZ4HpcS7MIwWWisIe0n3zNVzi3zYhKOUZ1IOyJ8kSOBdhNe?=
 =?us-ascii?Q?WKR0rSYZhykIhCRZlZpXjJoXoLOWAaBnEES/j0gvajQvkpzTH6ion4rOGzne?=
 =?us-ascii?Q?Uy54cwU0v4ZToT+NDZlTKnjctN6IaFk367yHFhZsDjsBZOuuL31ZbdqsCTge?=
 =?us-ascii?Q?noBHDfF+kG4lDrcd+kxqZZd4I10noPxZZwc0NtojIqjgPFnb8+ar+ku2fmER?=
 =?us-ascii?Q?GIpBQbAPdZmDwKGu6ZEQQ3s+XC3ITa9UDo470zz26mhqfRrfMajkCJj3zxMr?=
 =?us-ascii?Q?Mc9cMERB+nqDmQrD8wfXIWEsSDJSy/8zAxM6lz9FCoYLMK11FMYzlnUCo1MB?=
 =?us-ascii?Q?tBulU0GcR40KP9wpKWJ8wnyHTN4x+7BycUuL6Ce40xNA75bZ8f8xl/pZVVXt?=
 =?us-ascii?Q?7B3Uua9vprqmysFkBAJ/WdNFCF9tXkIGLKyUVgL8WmmZQHmP62goGLAXtnh1?=
 =?us-ascii?Q?lmm1buQankMQBtNBKe+DKPS+SLzl9sl3jfAbY6ydkM39nfi2Vqc2b9WCYvLa?=
 =?us-ascii?Q?sEZDG2F5z3ew5chewvbVjF/ut+vASOlsrhWyIi9n6ALic3yBGByTjN+OkIeE?=
 =?us-ascii?Q?48yfupREXhYTxGpbDhAY2KcpnH15tylrB8OxZnVapFzS/RFDzZWFCFcedsTx?=
 =?us-ascii?Q?2A7KJtz/RIi4tUgqg52OsjqaHAsvQER+xrVfo0bULFYpFecT+ys/qQaSeKF8?=
 =?us-ascii?Q?Qv3H3s5fOcH/uQUGXprqO1qPBlG3l/StKqtycFoz3ySjHv8yf1fI8L+5Pykk?=
 =?us-ascii?Q?6IhnS11T+Xjl7neJl5CAfo5yC1XHeYOsYMnxGOSWnhqayJiP6dShOwGaZBYx?=
 =?us-ascii?Q?mg4w3UGW5qsYyPOQzXkJzuWzz2wo4RC/xHctKCLl9jLL+447mRK0C3hK1v9Z?=
 =?us-ascii?Q?bERChqQzANFwXn951OrKFqmbRE1ENlEyJgJHvUj4zcGFRp/UCYXh72xll8bW?=
 =?us-ascii?Q?Tv13gd+vMDbuSG1LLp0R2O0Ru7qgUZPGwVSdh/Oj9TIiylLgyfeCyEeldGOs?=
 =?us-ascii?Q?fBl/aVDm+Din8or+r6N5ij09IFg3l7o57PsfpA3+Bq1ld5Nxv24y9Q4e1tBF?=
 =?us-ascii?Q?JidWqZnyvcBkWMGfID6YykfgDVSvdq/Yuz380b6B/0qAxJoQbBe/PDU++Et2?=
 =?us-ascii?Q?iuTqy9ZjEx5EFoOA9bXMY2MF+1O/qvmo2ISJghRuhIdu6WfGYP9fH+fcQSBi?=
 =?us-ascii?Q?eTpamQqD0nWM1gzuaVt5wkdCpe4iouiY1QZVBHp7Y+YsoWRSUNaXIkSg6+Bv?=
 =?us-ascii?Q?cmcLT8ZhQUzo56zCsINcj4eOkfX2C3Ui/rAzKvbUNqQ9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d3d733-7d47-4541-6e36-08d9c0d16e53
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 20:19:58.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sz2z6X/Kxj1Y6q+4dxJ6octggtBWLCM7hUpIg8LaG1LQ3pb/L/gBPFcIUM7H7rY8wRxyZaJGSMufA+zqInXbWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5867
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112160110
X-Proofpoint-ORIG-GUID: f3slKgY2I2Vy8ozzozhc4lj8JMGu3ZCz
X-Proofpoint-GUID: f3slKgY2I2Vy8ozzozhc4lj8JMGu3ZCz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing mechanisms in get_symbol_pos to determine the end of a
symbol is an inaccurate heuristic.  By passing nm -S output into
scripts/kallsyms.c and writing the symbol sizes to a new .kallsyms_sizes
section, we can get accurate sizes and sort the symbols accordingly,
reliably sorting zero-size symbols first (on the grounds that they are
usually e.g. section markers, and other symbols at the same address are
conceptually contained within them and should be sorted after them),
then larger symbols before smaller ones (so that overlapping symbols
print the containing symbol first, before its containees).  We can
also use this to improve aliased symbol detection.

Emit the size info as an extra column in /proc/kallmodsyms (since its
format is not yet set in stone), and export it to iterator consumers.

The notable downside of this is that the new .kallsyms_sizes is pretty
big: a PTR per symbol, so vmlinux.o grows by almost a megabyte, though
it compresses pretty well, so bzImage grows by only a megabyte.

I'm not sure how to reduce this (perhaps using an array with elements
sized to be no larger than needed for the contents, so that almost
always two-byte entries would do? except that in my test kernel two
symbols are bigger than this: sme_workarea, at 400K, and __log_buf, at
100K: the latter seems often likely to be larger than 64K).  A simple
scheme to reduce this would be to split the sizes array into several
arrays with differently-sized elements, and run-length-compress away the
zero bytes -- but that's not implemented yet, and might never be if
people think the whole idea of this is pointless.

In the absence of a way to shrink things, this should probably be hidden
behind a new config symbol if exposed at all, and kallmodsyms just shows
zero sizes if it's configured out (but this is enough of an RFC that
that's not yet done: possibly the benefits of this are too marginal to
be worth it, even if they do let kall(mod)syms consumers distinguish
symbols from padding, which was previously impossible).

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
---
 include/linux/module.h  |  7 ++--
 kernel/kallsyms.c       | 74 ++++++++++++++++++++++-------------------
 kernel/module.c         |  4 ++-
 scripts/kallsyms.c      | 29 +++++++++++++---
 scripts/link-vmlinux.sh |  7 +++-
 5 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index c9f1200b2312..b58f2de48957 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -590,7 +590,8 @@ struct module *find_module(const char *name);
 /* Returns 0 and fills in value, defined and namebuf, or -ERANGE if
    symnum out of range. */
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported);
+		       char *name, char *module_name, unsigned long *size,
+		       int *exported);
 
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
@@ -768,8 +769,8 @@ static inline int lookup_module_symbol_attrs(unsigned long addr, unsigned long *
 }
 
 static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
-					char *type, char *name,
-					char *module_name, int *exported)
+				     char *type, char *name, char *module_name,
+				     unsigned long *size, int *exported)
 {
 	return -ERANGE;
 }
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index c81610ffc4ba..e234c659dfe9 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -36,6 +36,7 @@
  */
 extern const unsigned long kallsyms_addresses[] __weak;
 extern const int kallsyms_offsets[] __weak;
+extern const unsigned long kallsyms_sizes[] __weak;
 extern const u8 kallsyms_names[] __weak;
 
 /*
@@ -277,12 +278,24 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 }
 #endif /* CONFIG_LIVEPATCH */
 
+/*
+ * The caller passes in an address, and we return an index to the symbol --
+ * potentially also size and offset information.
+ * But an address might map to multiple symbols because:
+ *   - some symbols might have zero size
+ *   - some symbols might be aliases of one another
+ *   - some symbols might span (encompass) others
+ * The symbols should already be ordered so that, for a particular address,
+ * we first have the zero-size ones, then the biggest, then the smallest.
+ * So we find the index by:
+ *   - finding the last symbol with the target address
+ *   - backing the index up so long as both the address and size are unchanged
+ */
 static unsigned long get_symbol_pos(unsigned long addr,
 				    unsigned long *symbolsize,
 				    unsigned long *offset)
 {
-	unsigned long symbol_start = 0, symbol_end = 0;
-	unsigned long i, low, high, mid;
+	unsigned long low, high, mid;
 
 	/* This kernel should never had been booted. */
 	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
@@ -303,36 +316,17 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	}
 
 	/*
-	 * Search for the first aliased symbol. Aliased
-	 * symbols are symbols with the same address.
+	 * Search for the first aliased symbol.
 	 */
-	while (low && kallsyms_sym_address(low-1) == kallsyms_sym_address(low))
+	while (low
+	    && kallsyms_sym_address(low-1) == kallsyms_sym_address(low)
+	    && kallsyms_sizes[low-1] == kallsyms_sizes[low])
 		--low;
 
-	symbol_start = kallsyms_sym_address(low);
-
-	/* Search for next non-aliased symbol. */
-	for (i = low + 1; i < kallsyms_num_syms; i++) {
-		if (kallsyms_sym_address(i) > symbol_start) {
-			symbol_end = kallsyms_sym_address(i);
-			break;
-		}
-	}
-
-	/* If we found no next symbol, we use the end of the section. */
-	if (!symbol_end) {
-		if (is_kernel_inittext(addr))
-			symbol_end = (unsigned long)_einittext;
-		else if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
-			symbol_end = (unsigned long)_end;
-		else
-			symbol_end = (unsigned long)_etext;
-	}
-
 	if (symbolsize)
-		*symbolsize = symbol_end - symbol_start;
+		*symbolsize = kallsyms_sizes[low];
 	if (offset)
-		*offset = addr - symbol_start;
+		*offset = addr - kallsyms_sym_address(low);
 
 	return low;
 }
@@ -653,6 +647,7 @@ struct kallsym_iter {
 	loff_t pos_bpf_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
+	unsigned long size;
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
@@ -687,7 +682,7 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 	int ret = module_get_kallsym(iter->pos - iter->pos_arch_end,
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
-				     &iter->exported);
+				     &iter->size, &iter->exported);
 	iter->builtin_module_names = NULL;
 
 	if (ret < 0) {
@@ -760,6 +755,7 @@ static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms
 	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
+	iter->size = kallsyms_sizes[iter->pos];
 	iter->type = kallsyms_get_symbol_type(off);
 
 	iter->module_name[0] = '\0';
@@ -878,12 +874,14 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
+	unsigned long size;
 
 	/* Some debugging symbols have no name.  Ignore them. */
 	if (!iter->name[0])
 		return 0;
 
 	value = iter->show_value ? (void *)iter->value : NULL;
+	size = iter->show_value ? iter->size : 0;
 
 	/*
 	 * Real module, or built-in module and /proc/kallsyms being shown.
@@ -903,15 +901,15 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 			 * /proc/kallmodsyms, built as a module.
 			 */
 			if (iter->builtin_module_names == NULL)
-				seq_printf(m, "%px %c %s\t[%s]\n", value,
-					   type, iter->name,
+				seq_printf(m, "%px %lx %c %s\t[%s]\n", value,
+					   size, type, iter->name,
 					   iter->module_name);
 			/*
 			 * /proc/kallmodsyms, single-module symbol.
 			 */
 			else if (*iter->builtin_module_names != '\0')
-				seq_printf(m, "%px %c %s\t[%s]\n", value,
-					   type, iter->name,
+				seq_printf(m, "%px %lx %c %s\t[%s]\n", value,
+					   size, type, iter->name,
 					   iter->builtin_module_names);
 			/*
 			 * /proc/kallmodsyms, multimodule symbol.  Formatted
@@ -922,8 +920,8 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 				size_t i = *(char *)(iter->builtin_module_names + 1);
 				const char *walk = iter->builtin_module_names + 2;
 
-				seq_printf(m, "%px %c %s\t[%s]", value,
-					   type, iter->name, walk);
+				seq_printf(m, "%px %lx %c %s\t[%s]", value,
+					   size, type, iter->name, walk);
 
                                 while (--i > 0) {
 					walk += strlen(walk) + 1;
@@ -935,7 +933,13 @@ static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 #endif /* CONFIG_KALLMODSYMS */
 			seq_printf(m, "%px %c %s\t[%s]\n", value,
 				   type, iter->name, iter->module_name);
-	} else
+	/*
+	 * Non-modular, /proc/kallmodsyms -> print size.
+	 */
+	} else if (kallmodsyms)
+		seq_printf(m, "%px %lx %c %s\n", value, size,
+			   iter->type, iter->name);
+	else
 		seq_printf(m, "%px %c %s\n", value,
 			   iter->type, iter->name);
 	return 0;
diff --git a/kernel/module.c b/kernel/module.c
index 84a9141a5e15..311eaa8fd21c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4405,7 +4405,8 @@ int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size,
 }
 
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported)
+		       char *name, char *module_name, unsigned long *size,
+		       int *exported)
 {
 	struct module *mod;
 
@@ -4424,6 +4425,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
+			*size = kallsyms->symtab[symnum].st_size;
 			preempt_enable();
 			return 0;
 		}
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 93fdf0dcf587..fcb1d706809c 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,7 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux
+ * Usage: nm -n -S vmlinux
  *        | scripts/kallsyms [--all-symbols] [--absolute-percpu]
  *             [--base-relative] [--builtin=modules_thick.builtin]
  *        > symbols.S
@@ -38,6 +38,7 @@
 
 struct sym_entry {
 	unsigned long long addr;
+	unsigned long long size;
 	unsigned int len;
 	unsigned int start_pos;
 	unsigned int percpu_absolute;
@@ -394,6 +395,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_addresses",
 		"kallsyms_offsets",
 		"kallsyms_relative_base",
+		"kallsyms_sizes",
 		"kallsyms_num_syms",
 		"kallsyms_num_modules",
 		"kallsyms_names",
@@ -507,10 +509,11 @@ static struct sym_entry *read_symbol(FILE *in)
 	unsigned long long addr;
 	unsigned int len;
 	struct sym_entry *sym;
-	int rc;
+	int rc = 0;
+	unsigned long long size;
 
-	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
-	if (rc != 3) {
+	rc = fscanf(in, "%llx %llx %c %499s\n", &addr, &size, &type, name);
+	if (rc != 4) {
 		if (rc != EOF && fgets(name, 500, in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
@@ -548,6 +551,7 @@ static struct sym_entry *read_symbol(FILE *in)
 	sym->sym[0] = type;
 	strcpy(sym_name(sym), name);
 	sym->percpu_absolute = 0;
+	sym->size = size;
 
 	return sym;
 }
@@ -932,6 +936,11 @@ static void write_src(void)
 		printf("\n");
 	}
 
+	output_label("kallsyms_sizes");
+	for (i = 0; i < table_cnt; i++)
+		printf("\tPTR\t%#llx\n", table[i]->size);
+	printf("\n");
+
 #ifdef CONFIG_KALLMODSYMS
 	output_kallmodsyms_modules();
 	output_kallmodsyms_objfiles();
@@ -1189,6 +1198,18 @@ static int compare_symbols(const void *a, const void *b)
 	if (sa->addr < sb->addr)
 		return -1;
 
+	/* zero-size markers before nonzero-size symbols */
+	if (sa->size > 0 && sb->size == 0)
+		return 1;
+	if (sa->size == 0 && sb->size > 0)
+		return -1;
+
+	/* sort by size (large size preceding symbols it encompasses) */
+	if (sa->size < sb->size)
+		return 1;
+	if (sa->size > sb->size)
+		return -1;
+
 	/* sort by "weakness" type */
 	wa = (sa->sym[0] == 'w') || (sa->sym[0] == 'W');
 	wb = (sb->sym[0] == 'w') || (sb->sym[0] == 'W');
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 5301f3e77116..55815937399b 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -265,7 +265,12 @@ kallsyms()
 	fi
 
 	info KSYMS ${2}
-	${NM} -n ${1} | scripts/kallsyms ${kallsymopt} > ${2}
+	# "nm -S" does not print symbol size when size is 0
+	# Therefore use awk to regularize the data:
+	#   - when there are only three fields, add an explicit "0"
+	#   - when there are already four fields, pass through as is
+	${NM} -n -S ${1} | ${AWK} 'NF==3 {print $1, 0, $2, $3}; NF==4' | \
+	    scripts/kallsyms ${kallsymopt} > ${2}
 }
 
 # Perform one step in kallsyms generation, including temporary linking of
-- 
2.34.0.258.gc900572c39

