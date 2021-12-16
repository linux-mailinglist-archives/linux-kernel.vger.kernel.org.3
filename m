Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A775477D51
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbhLPUUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:20:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12940 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241303AbhLPUUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:20:03 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGIn5m2025358;
        Thu, 16 Dec 2021 20:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=gApXByGo7Nnq5Bknpj7YS6Xp4dORLUVG4M1mJfLQd3k=;
 b=VM2gldADzwu7T4e9Ph+8BZ+9Nmt38GwTPBm71GDFWKgjp+HFJwkXRZHMP/V6HAeJQ5D2
 3pHcWuzsG/X40lftjvIDaJ+rnsNinavLi3BNTK00lZDblgWiYYkd/a6NJXvDf7KIqvd2
 b9ju+rZ8v1yRVQBN5yJL4M9Tv9GiLZ4w1ttOPNC8NYNO+IOFWPofFDFAc8wtIYcH5o3u
 AJ/ocfrvgMrAnod17mI2d6CeOv8TIZjzn1/uWGNING6XAuVllSHIP4eKzhKKuz1h38nB
 srJYP6d7HU5mrNFNX2aqSeK0/xLBnPNuWTIM/2v4RlqJqoZwS6pKf2UhKKSFn+1WAHXH BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknc3xn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKGCTa123775;
        Thu, 16 Dec 2021 20:19:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3030.oracle.com with ESMTP id 3cyjuae0cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxrWOyW5Rw0uP0HtL/2yxUUPcQrxehRRujQ9ZprW2M7M7oLU9YFR+ZGViCCCtnSzg3qc7CCBmL4ZvLl+gsGgOYhLqGhe32zK1PXZO0Azak2Z2qVG9w18JUMldQND941I5s4ydYA+QRwLggUgws6mcqmIAmUZQRdkx9nBVqnTGoBh4BevdXLceOpdWWADIPA4JpYYrd3AxedE8C8A39CgGuHccXEeNBQK8XiK4eP18wKbvXh027J8k+jyFYhUhNbt6ji67wfUQmtFdY1Rfn3TIg7ZQkUBFNOwivRinYKx63PUj0l3rpFg8h2EgIm9Bxiw/us/ETZg6mzG9R1VEfbC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gApXByGo7Nnq5Bknpj7YS6Xp4dORLUVG4M1mJfLQd3k=;
 b=jbU5LyF4FgwiCxQ422iuRTKLiOJYpu2EvCyVFpIOPKEIbUYMgu+RwPrm4GeRYHHWF12oewq7WLo+9nnyydQWssuYBTZuF5T+0TpfD8Q1kXfMruELoz/uZuEuVPqd7DNxF8ozwaZlYMxMBjSWsPsuASYVf7bLRwyjpEnOvR7/igNOgjBA+oPIFaWY2ujBiWmMmIglRF2w9ptkQd4jCeZ+aPP7WnZJxNikalkLH68AUYHUPNHNRRYpFHdaLcuhuVLVOQ2MBuR1Kw/Mhafngu4jj2jaVxMMHFAVMstJrhqXJssYDf2v+lBbOZe9GU0Bx3Ez9pSV7zqszeS/YwPvd5v7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gApXByGo7Nnq5Bknpj7YS6Xp4dORLUVG4M1mJfLQd3k=;
 b=iD8K/+2otGUD3+9m14enCzux5w4dmdIB6hrF8KsyQzh94p0yomlzKolQfoYnoek6JN+rZkTphEPsV/7cSzJYcRK9svcVkYmJX26MNlzRxVGymDl+0ZnF8flEBxcoJ5S/zb/Ewn95xyklJtBeOlOERH3NlFVvxY0x8uquu3HSAVo=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2541.namprd10.prod.outlook.com (2603:10b6:805:44::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 20:19:55 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e%7]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 20:19:55 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v7 5/7] kallsyms: optimize .kallsyms_modules*
Date:   Thu, 16 Dec 2021 20:19:17 +0000
Message-Id: <20211216201919.234994-6-nick.alcock@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: c88bfce1-e04a-49d4-337f-08d9c0d16c6f
X-MS-TrafficTypeDiagnostic: SN6PR10MB2541:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB25411E70D86A24238DF27DE38B779@SN6PR10MB2541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RclG2suHsharImX3CCL5ujXf+ANQfpLqyWn7IJSGHxi9UGhbywlKO2aIS9o2elpk7EODKzwZqt0wwhUSGPBnGgcWWZymbhqcTLsl7p73+XhATOnaU+IDdFFfmT7JV1avQBOiVCCQhF/VxwbcS0usqvQLhleiR9fK13/iTVU+YycyY/M85+jguR4OoIb+JmU+u7Ef7vr3DuiPeT4rXnt2jUVH5FaGih1j2eFxk3G4YPy9OGGYWRWEFFL7C+w8tm5QvkoRkzJGHgQZafQ/gvJi7kfwRpQKzrwZpPg511e74VGoEFht7l67xggOjAsYwW95cg3IOXUMNzln9BuwilH38b9bGnfBpszbGrU9EBWwZ7mcc0fzqQBnIaDN6jjq7kLEckxk39z9BYsAc4S1dQpVAAuhDfm+pPNj88ni/gPXvVAWq1UBLhMOZJHicxvneppo1KPTVHZpNPhTtaPrU/jgNOzvJDbYDkx9Z92AkJAENLhcf4XBQcrCG8B/YkuHArAEd0x1G6aePCX2WfrgCaIZ+q75/WCvVAaZzF0nhZJD0/Za2mQaqbAQ4VAaT2ngSRbUY89Ix1hqWfEDOtPLwz/yErPpo8ncJf7K5RVQSj3gJNfBzx12y+x1yt8X9hVf+GzpFewqQl0FEKv5d/WjjvE8ReW7TJvNRjLSpESLROrpPEiaG0noPeZI3BCvE9Pw0twcqGnqEp4+0cvw/sjGjsILjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(30864003)(83380400001)(52116002)(38100700002)(86362001)(44832011)(36756003)(5660300002)(1076003)(2616005)(6506007)(508600001)(6666004)(66946007)(66556008)(66476007)(186003)(8676002)(316002)(107886003)(6486002)(2906002)(8936002)(4326008)(6512007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gw/FMCJtgLCYlGMAUYx80AgatWDDKh/bBqxMmDqbbDn7Isp8C6qSNMY+a7xk?=
 =?us-ascii?Q?txToQSZwdZXlkJJU+P35j23IYj5ngJN+y+vKIu4rvvJOjIv0SMXsA9Fre728?=
 =?us-ascii?Q?JXXNHW4br0gkVhmglcFXeVA9nu2Dwhb191TBDzOM5PsZ3b3XdSZnfmW1Unne?=
 =?us-ascii?Q?nud5KgndxsrExH8AREZesCSUGBb0nDJMDnaaYbfx+7/ihu+WBf1IMyNJuFOo?=
 =?us-ascii?Q?LYxpjZ7f98BUe6MkRHdkZ3zQTO5gjK0Pvoq2N6/dbAiHk2pbR7ufWSHaqy3e?=
 =?us-ascii?Q?pXOLaoXTGe0gs4fUJZqJ8rJF4KfKmqfPshNy0rA7n+U9zSWsdNqkxjY0uB4z?=
 =?us-ascii?Q?WRrY4RXyL0vvS/b8+wiPd0zvhuqG2v58DHdXbBdliNljCaFsvA9Bh36RFezM?=
 =?us-ascii?Q?NcRNKVCpINPb4SaYcCm9fenhmWo5iTpaWJKGdc8YRnUxlZxgVZ3SX8LFCoHX?=
 =?us-ascii?Q?0dzQlQ5BsSuDcKEwddMdo0ZdxYPqmxfIZ2wqv5DQ3KcYxHT1fKAg6gTvp6MT?=
 =?us-ascii?Q?DRUmK980Yt1RM3wUb4LwijBKiYXCFYTWsTHr8MNLfZ5bgagAdA+a2bhwKHEG?=
 =?us-ascii?Q?JsNbiI4Ygs6M7xcLaJjmAzYtnH2LpX5rLLloNyHdZrv4zKKTAt5BysZvYs0I?=
 =?us-ascii?Q?hlNbeDB6lI0Fn9yIpeXQSObzgqLbq4TOI9m5czCBwKngxZPL5jUP21OvrDcr?=
 =?us-ascii?Q?/g+5cj1PWu6NkhxpuyQed4LUZDhNlQGy9R3U2kJGrGRKqRXJodp4TmdkODCE?=
 =?us-ascii?Q?AbzxHe3tTf2oRSw+rOqe4GhHunpCNngxpt7HOgIdC1gcb6jUftQBJWI4U01J?=
 =?us-ascii?Q?s5PtMNWnAhmwZbrBQZNbOfteo0WYMnPYh47B8sdDqgdLsWDfmLxenzegLsrt?=
 =?us-ascii?Q?Q3YRPNrdI4rLe+Y6Zz0SccQwx6CytvJ/r+++2iK/6kTV44+C87BAagueKDqx?=
 =?us-ascii?Q?DfNmy7etHa2BYWknMtLfWCyhkI3RF0ETBh7GyeVXuf+5rjrdYAwwu6N1Qj0B?=
 =?us-ascii?Q?Mf6RmUA/ExfRL0vRnpnL/OtwygoaZFBua5ze/FWCXlHn3sCHVxk3cEqA89SE?=
 =?us-ascii?Q?hlnoVaangzgddgY/XFmqzgRKvAoQT5rcez9nCStQCc01puL6G8Dr++ukEyhK?=
 =?us-ascii?Q?ptYbIF2R0CrP6JBcfrfhUgF970OKgxRBPGH2rBOtztJ9J3iU0u0benvJTVYh?=
 =?us-ascii?Q?6CjVnzCZifvfmbgs9iUA8Si3uO0XKRl8G1Uerb3HK0QFWPxUTk+m+9jdAuyJ?=
 =?us-ascii?Q?ThQgWZMMKqjyZvYq2NrCiQXUMx4Qh6RU4attyZP7ukik5W+M8gfui+WkSPL7?=
 =?us-ascii?Q?oXcuL2kFCIPYjixHMMJVxaH7+2X2FqP+L13rFPsdSj06aES3H1M7BlNdlNSk?=
 =?us-ascii?Q?PyFE4XfW4rEeiHU0lXkNiLB8fLpjvd0YCw52jaCPjgiSMg7HpVPZWmwBJZlO?=
 =?us-ascii?Q?mp7qGGRVxApyZeDy8/6ynNZi2BYVXsqhqruQ0FiDy4eqMKTB39hyggnBAcEB?=
 =?us-ascii?Q?hqDEVehCLc0GZ/ckjQRTWumNqTJLdY8zqOV3uOhY2hk+fEIvAavowqg6i/9i?=
 =?us-ascii?Q?MMiu3kxblhulZPW6PGWO0ZN4hVyDBV/AMkr6HOaVf0iGeiyYMEkWRTqNjbro?=
 =?us-ascii?Q?lJs9fV6ZN0Ha7G+3O5EwL9bfTXkbmNq0IkBSAZlMEUwB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88bfce1-e04a-49d4-337f-08d9c0d16c6f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 20:19:55.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fsiuxjOoHy4q3ePVxVai9giVSYWudQp1MvnjBGyhd/u04LK8aUpVaRu/S/FCD8BX/tv/CO/t+tgC+Gy5iagdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160110
X-Proofpoint-ORIG-GUID: BEWF7JwLln2qZz8_1WZPzaN2uR9Jj7dv
X-Proofpoint-GUID: BEWF7JwLln2qZz8_1WZPzaN2uR9Jj7dv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These symbols are terribly inefficiently stored at the moment.  Add a
simple optimizer which fuses obj2mod_elem entries and uses this to
implement three cheap optimizations:

 - duplicate names are eliminated from .kallsyms_module_names.

 - entries in .kallsyms_modules which point at single-file modules which
   also appear in a multi-module list are redirected to point inside
   that list, and the single-file entry is dropped from
   .kallsyms_module_names.  Thus, modules which contain some object
   files shared with other modules and some object files exclusive to
   them do not double up the module name.  (There might still be some
   duplication between multiple multi-module lists, but this is an
   extremely marginal size effect, and resolving it would require an
   extra layer of lookup tables which would be even more complex, and
   incompressible to boot).

 - Entries in .kallsyms_modules that would contain the same value after
   the above optimizations are fused together, along with their
   corresponding .kallsyms_module_addresses/offsets entries.  Due to
   this fusion process, and because object files can be split apart into
   multiple parts by the linker for hot/cold partitioning and the like,
   entries in .kallsyms_module_addresses/offsets no longer correspond
   1:1 to object files, but more to some contiguous range of addresses
   which are guaranteed to belong to a single built-in module, but which
   may well stretch over multiple object files.

The optimizer's time complexity is O(log n) in the number of objfiles at
most (and probably much lower), so, given the relatively low number of
objfiles, its runtime overhead is in the noise.

Optimization reduces the overhead of the kallmodsyms tables by about
7500 items, dropping the .tmp_kallsyms2.o object file size by about
33KiB, leaving it 8672 bytes larger than before: a gain of .4%.

The vmlinux size is not yet affected because the variables are not used
and are eliminated by the linker: but if they were used (after the next
commit), the size impact of all of this on the final kernel is minimal:
in my testing, the kallsyms2.S file went from 14107772 to 14137245
bytes, a gain of 29743 bytes, or 0.16%: vmlinux gained 10824 bytes, a
gain of .017%, and the compressed vmlinux only 7552 bytes, a gain of
.08%: though the latter two values are very configuration-dependent,
they seem likely to scale roughly with the kernel they are part of.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 scripts/kallsyms.c | 267 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 258 insertions(+), 9 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8f87b724d0fa..93fdf0dcf587 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -85,6 +85,17 @@ static unsigned int strhash(const char *s)
 	return hash;
 }
 
+static unsigned int memhash(char *s, size_t len)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		hash = (hash ^ *(s + i)) * 0x01000193;
+	return hash;
+}
+
 #define OBJ2MOD_BITS 10
 #define OBJ2MOD_N (1 << OBJ2MOD_BITS)
 #define OBJ2MOD_MASK (OBJ2MOD_N - 1)
@@ -94,14 +105,24 @@ struct obj2mod_elem {
 	size_t nmods;			/* number of modules in "mods" */
 	size_t mods_size;		/* size of all mods together */
 	int mod_offset;			/* offset in .kallsyms_module_names */
+	/*
+	 * If set at emission time, this points at another obj2mod entry that
+	 * contains the module name we need (possibly at a slightly later
+	 * offset, if the entry is for an objfile that appears in many modules).
+	 */
+	struct obj2mod_elem *xref;
 	struct obj2mod_elem *obj2mod_next;
+	struct obj2mod_elem *mod2obj_next;
 };
 
 /*
- * Map from object files to obj2mod entries (a unique mapping).
+ * Map from object files to obj2mod entries (a unique mapping), and vice versa
+ * (not unique, but entries for objfiles in more than one module in this hash
+ * are ignored).
  */
 
 static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
+static struct obj2mod_elem *mod2obj[OBJ2MOD_N];
 static size_t num_objfiles;
 
 /*
@@ -143,6 +164,8 @@ static void obj2mod_add(char *obj, char *mod)
 
 	elem = obj2mod_get(obj);
 	if (!elem) {
+		int j = strhash(mod) & OBJ2MOD_MASK;
+
 		elem = malloc(sizeof(struct obj2mod_elem));
 		if (!elem)
 			goto oom;
@@ -156,8 +179,15 @@ static void obj2mod_add(char *obj, char *mod)
 
 		elem->obj2mod_next = obj2mod[i];
 		obj2mod[i] = elem;
+		elem->mod2obj_next = mod2obj[j];
+		mod2obj[j] = elem;
 		num_objfiles++;
 	} else {
+		/*
+		 * TU appears in multiple modules.  mod2obj for this entry will
+		 * be ignored from now on, except insofar as it is needed to
+		 * maintain the hash chain.
+		 */
 		elem->mods = realloc(elem->mods, elem->mods_size +
 				     strlen(mod) + 1);
 		if (!elem->mods)
@@ -177,6 +207,164 @@ static void obj2mod_add(char *obj, char *mod)
 	fprintf(stderr, "kallsyms: out of memory\n");
 	exit(1);
 }
+
+/*
+ * Used inside optimize_obj2mod to identify duplicate module entries.
+ */
+struct obj2mod_modhash_elem {
+	struct obj2mod_elem *elem;
+	unsigned int modhash;		/* hash value of this entry */
+};
+
+static int qstrcmp(const void *a, const void *b)
+{
+	return strcmp((const char *) a, (const char *) b);
+}
+
+static int qmodhash(const void *a, const void *b)
+{
+	const struct obj2mod_modhash_elem *el_a = a;
+	const struct obj2mod_modhash_elem *el_b = b;
+	if (el_a->modhash < el_b->modhash)
+		return -1;
+	else if (el_a->modhash > el_b->modhash)
+		return 1;
+	return 0;
+}
+
+/*
+ * Associate all TUs in obj2mod which refer to the same module with a single
+ * obj2mod entry for emission, preferring to point into the module list in a
+ * multi-module objfile.
+ */
+static void optimize_obj2mod(void)
+{
+	size_t i;
+	size_t n = 0;
+	struct obj2mod_elem *elem;
+	struct obj2mod_elem *dedup;
+	/* An array of all obj2mod_elems, later sorted by hashval.  */
+	struct obj2mod_modhash_elem *uniq;
+	struct obj2mod_modhash_elem *last;
+
+	/*
+	 * Canonicalize all module lists by sorting them, then compute their
+	 * hash values.
+	 */
+	uniq = malloc(sizeof(struct obj2mod_modhash_elem) * num_objfiles);
+	if (uniq == NULL)
+		goto oom;
+
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (elem = obj2mod[i]; elem; elem = elem->obj2mod_next) {
+			if (elem->nmods >= 2) {
+				char **sorter;
+				char *walk;
+				char *tmp_mods;
+				size_t j;
+
+				tmp_mods = malloc(elem->mods_size);
+				sorter = malloc(sizeof(char *) * elem->nmods);
+				if (sorter == NULL || tmp_mods == NULL)
+					goto oom;
+				memcpy(tmp_mods, elem->mods, elem->mods_size);
+
+				for (j = 0, walk = tmp_mods; j < elem->nmods;
+				     j++) {
+					sorter[j] = walk;
+					walk += strlen(walk) + 1;
+				}
+				qsort(sorter, elem->nmods, sizeof (char *),
+				      qstrcmp);
+				for (j = 0, walk = elem->mods; j < elem->nmods;
+				     j++) {
+					strcpy(walk, sorter[j]);
+					walk += strlen(walk) + 1;
+				}
+				free(tmp_mods);
+				free(sorter);
+			}
+
+			uniq[n].elem = elem;
+			uniq[n].modhash = memhash(elem->mods, elem->mods_size);
+			n++;
+		}
+	}
+
+	qsort (uniq, num_objfiles, sizeof (struct obj2mod_modhash_elem),
+	       qmodhash);
+
+	/*
+	 * Work over multimodule entries.  These must be emitted into
+	 * .kallsyms_module_names as a unit, but we can still optimize by
+	 * reusing some other identical entry.  Single-file modules are amenable
+	 * to the same optimization, but we avoid doing it for now so that we
+	 * can prefer to point them directly inside a multimodule entry.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		const char *onemod;
+		size_t j;
+
+		if (uniq[i].elem->nmods < 2)
+			continue;
+
+		/* Duplicate multimodule.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i].modhash) {
+			uniq[i].elem->xref = last->elem;
+			continue;
+		}
+
+		/*
+		 * Single-module entries relating to modules also emitted as
+		 * part of this multimodule entry can refer to it: later, we
+		 * will hunt down the right specific module name within this
+		 * multimodule entry and point directly to it.
+		 */
+		onemod = uniq[i].elem->mods;
+		for (j = uniq[i].elem->nmods; j > 0; j--) {
+			int h = strhash(onemod) & OBJ2MOD_MASK;
+
+			for (dedup = mod2obj[h]; dedup;
+			     dedup = dedup->mod2obj_next) {
+				if (dedup->nmods > 1)
+					continue;
+
+				if (strcmp(dedup->mods, onemod) != 0)
+					continue;
+				dedup->xref = uniq[i].elem;
+				assert (uniq[i].elem->xref == NULL);
+			}
+			onemod += strlen(onemod) + 1;
+		}
+
+		last = &uniq[i];
+	}
+
+	/*
+	 * Now traverse all single-module entries, xreffing every one that
+	 * relates to a given module to the first one we saw that refers to that
+	 * module.
+	 */
+	for (i = 0, last = NULL; i < num_objfiles; i++) {
+		if (uniq[i].elem->nmods > 1)
+			continue;
+
+		if (uniq[i].elem->xref != NULL)
+			continue;
+
+		/* Duplicate module name.  Reuse the first we saw.  */
+		if (last != NULL && last->modhash == uniq[i].modhash) {
+			uniq[i].elem->xref = last->elem;
+			assert (last->elem->xref == NULL);
+			continue;
+		}
+		last = &uniq[i];
+	}
+	return;
+oom:
+	fprintf(stderr, "kallsyms: out of memory optimizing module list\n");
+	exit(EXIT_FAILURE);
+}
 #endif /* CONFIG_KALLMODSYMS */
 
 static void usage(void)
@@ -479,7 +667,7 @@ static void output_kallmodsyms_modules(void)
 	size_t i;
 
 	/*
-	 * Traverse and emit, updating mod_offset accordingly.
+	 * Traverse and emit, chasing xref and updating mod_offset accordingly.
 	 * Emit a single \0 at the start, to encode non-modular objfiles.
 	 */
 	output_label("kallsyms_module_names");
@@ -489,9 +677,15 @@ static void output_kallmodsyms_modules(void)
 		     elem = elem->obj2mod_next) {
 			const char *onemod;
 			size_t i;
+			struct obj2mod_elem *out_elem = elem;
 
-			elem->mod_offset = offset;
-			onemod = elem->mods;
+			if (elem->xref)
+				out_elem = elem->xref;
+			if (out_elem->mod_offset != 0)
+				continue;	/* Already emitted.  */
+
+			out_elem->mod_offset = offset;
+			onemod = out_elem->mods;
 
 			/*
 			 * Technically this is a waste of space: we could just
@@ -500,13 +694,13 @@ static void output_kallmodsyms_modules(void)
 			 * entry, but doing it this way makes it more obvious
 			 * when an entry is a multimodule entry.
 			 */
-			if (elem->nmods != 1) {
+			if (out_elem->nmods != 1) {
 				printf("\t.byte\t0\n");
-				printf("\t.byte\t%zi\n", elem->nmods);
+				printf("\t.byte\t%zi\n", out_elem->nmods);
 				offset += 2;
 			}
 
-			for (i = elem->nmods; i > 0; i--) {
+			for (i = out_elem->nmods; i > 0; i--) {
 				printf("\t.asciz\t\"%s\"\n", onemod);
 				offset += strlen(onemod) + 1;
 				onemod += strlen(onemod) + 1;
@@ -533,6 +727,13 @@ static void output_kallmodsyms_objfiles(void)
 		long long offset;
 		int overflow;
 
+                /*
+                 * Fuse consecutive address ranges citing the same object file
+                 * into one.
+                 */
+                if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+                        continue;
+
 		if (base_relative) {
 			if (!absolute_percpu) {
 				offset = addrmap[i].addr - relative_base;
@@ -558,6 +759,13 @@ static void output_kallmodsyms_objfiles(void)
 
 	for (i = 0; i < addrmap_num; i++) {
 		struct obj2mod_elem *elem = addrmap[i].objfile;
+		int orig_nmods;
+		const char *orig_modname;
+		int mod_offset;
+
+		if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+			continue;
+
 		/*
 		 * Address range cites no object file: point at 0, the built-in
 		 * module.
@@ -568,13 +776,53 @@ static void output_kallmodsyms_objfiles(void)
 			continue;
 		}
 
+		orig_nmods = elem->nmods;
+		orig_modname = elem->mods;
+
+		/*
+		 * Chase down xrefs, if need be.  There can only be one layer of
+		 * these: from single-module entry to other single-module entry,
+		 * or from single- or multi-module entry to another multi-module
+		 * entry.  Single -> single and multi -> multi always points at
+		 * the start of the xref target, so its offset can be used as is.
+		 */
+		if (elem->xref)
+			elem = elem->xref;
+
+		if (elem->nmods == 1 || orig_nmods > 1)
+			mod_offset = elem->mod_offset;
+		else {
+			/*
+			 * If this is a reference from a single-module entry to
+			 * a multi-module entry, hunt down the offset to this
+			 * specific module's name (which is guaranteed to be
+			 * present: see optimize_obj2mod).
+			 */
+
+			size_t j = elem->nmods;
+			const char *onemod = elem->mods;
+			mod_offset = elem->mod_offset;
+
+			for (; j > 0; j--) {
+				if (strcmp(orig_modname, onemod) == 0)
+					break;
+				onemod += strlen(onemod) + 1;
+			}
+			assert (j > 0);
+			/*
+			 * +2 to skip the null byte and count at the start of
+			 * the multimodule entry.
+			 */
+			mod_offset += onemod - elem->mods + 2;
+		}
+
 		/*
 		 * Zero offset is the initial \0, there to catch uninitialized
 		 * obj2mod entries, and is forbidden.
 		 */
-		assert (elem->mod_offset != 0);
+		assert (mod_offset != 0);
 
-		printf("\t.long\t0x%x\n", elem->mod_offset);
+		printf("\t.long\t0x%x\n", mod_offset);
 		emitted_objfiles++;
 	}
 
@@ -1093,6 +1341,7 @@ static void read_modules(const char *modules_builtin)
 
 	free(module_name);
 	modules_thick_iter_free(i);
+	optimize_obj2mod();
 
 	/*
 	 * Read linker map.
-- 
2.34.0.258.gc900572c39

