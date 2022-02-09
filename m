Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499E64AFDF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiBIUD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:03:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiBIUDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:03:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF428E05025F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:03:15 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HFfHp017435;
        Wed, 9 Feb 2022 19:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=QtGKe5zkdDHbOqZfoVX62iXOsdRoZLp5RadEORn0Egc=;
 b=x/aYUdlfrU9EH7nE8lueOdKZ2uubDaSk5d8NeigbT9nKxQ3QntyseGxlSNJLR6MUbdHG
 gXxRo+P0AfI6GjjNi7j+E2+ofIixVDdE0DEgfT3kEXzA9d9V5Lua7aY6dD22qut99Bek
 86RD5mNP+vBcN5z1wio1kS2uIAUvaleh+/A15wtaNVwne6kYwe9BOSi/CIegtK0NnVuI
 utvMnZQqOUEMa1B6RE2HzCshIs+Kq2S2pdnvXhVX2NPj0UhDJ7//Oi8UZNY8FqeMGTyA
 o4y1FAnq+BCYwZx8hepVYrSysn6s+EzV8IGvhtCe1yEiHbIiDyNMnsRlGXH4jbvh4OlD AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3h28nkw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219JtqrY046251;
        Wed, 9 Feb 2022 19:57:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3e1ec3b0ku-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crWzKCDYjWl9oId5A2TS4gNTm998JkfXWWO/AteLSMloC7l3XvhD9qcaxKNZQhE2JLXJ+VhIB1WiCP6kY2y2HFJP0uAD2hEFcaJDXzHtlcLyPIdB+9+RMv0DEOGEj8h4HMavLThk4P1dBZeWKWLcUGHV5oYcaildWRIXvtrmpdxIYU1cJWNm6L+330A0/8M4S67AOitJZ+JcneyQzdnn/F1mhe1yKSsNEk4Xj+4ntU7/XF/9e+er03bV42Hs9NpvvxA8XNwRYS3m1ZD+pFaMkwHVct6NqCTM9QHc3+fxTm9GJkXtZcubzgQr0XOi0LNuVY/GcaKHp8s3NmADm1QvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtGKe5zkdDHbOqZfoVX62iXOsdRoZLp5RadEORn0Egc=;
 b=ddrsjlLKkI7oumLcx6liclBJ9kk3AIo6F9ozsvvg+Clesk2iKgDmhroSAVVjeF5Hn3uyRBA9JqgvWoWA6hyeYo+qx7JKeY9kZ9+1Iupfn/DU4pDPhUtHwlwr4Nd5KOXnihdRGgF90oAaLSGiZ6MbD73J5yR7lUjjfYpX1jtxYVvZ4+9gq7c+pAU+c8YPUELQZ9wmnw//2uBZrLCA/xLbTX/ZtTcpIUcMpBRzx5tdVoaZ1yJ66l4hvowNgcGzYmP6aPBOxoRAtnnhyzcpX5jMedXYXGTsoJy/th3fPvJnddowSjBNGjXWakJ46akXbAv/dFoGQjoy4UX7hnRDl9pSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtGKe5zkdDHbOqZfoVX62iXOsdRoZLp5RadEORn0Egc=;
 b=CvJVWYxZNO6KlrrJRA6x66LfpgIwYo9k7P5mUFn9CFi11mD4AKk3fa7oP+BlD9n82t/HA1Ekc5fIzq/Thb/4tD7Ir3ZWjocMAJznCxqQ1nIesQm1qzeFYxc6xmWQAu/mt5sgGhFt+KFiq3dx3PHlLUsMFiLagyL/c46dUvR1Vqo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:57:40 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:57:40 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v4 09/10] crash hp: Add x86 crash hotplug support for kexec_file_load
Date:   Wed,  9 Feb 2022 14:57:05 -0500
Message-Id: <20220209195706.51522-10-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209195706.51522-1-eric.devolder@oracle.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:5:335::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44c4cf31-49d9-40a4-320d-08d9ec066dbc
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5701049B0CCC031718B871BE972E9@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+8bHvAGWON8eV05iGttvwYoT5jthylPXWFpnWINWVKenTSRs2s9PP1J1CBW/1fquyGxuz+ClCW++EkoTjQhMouUdPWBAFK/rvv9/y8ahz6LhTMOLDnVxEHdBKrMZm/Jqi6rYtP+eVFiH2jvSeq5NGvhi5nTI6HSrlc6DvpyoAPlmthOiRl0KsXp/qhImv4nRRNtC5AWAe4sRpYJj+kkebdUGG6JX3hIBz4I6aCm51CQiPd9wmpj2C3v+92W/3Cj6ZysvnBJ8YI7rjlvRhOe7eHIj+cvlGGVYE/UgmWtc0m0yNeu6x6d6ugjDPJMmoBoR0Q9nQChV3HXCur7ZFAgBMjCV0FYCn5pI7zltVL/I3KnLYfnlzuazTHUHdD40K/c/LAcbQDfiRyeQansdsrwgysENPVpBovDbG7Vdl+FxaG9AvhQQ3GvzQrV0454bim/OsVGcux1JlDq/KkhDckhuLq4Rq5c0E0zub1tW1Qe4zfVZtOZevcHE4zzJNo0Gygl8mzo6wv9s8PfG6T1CK285Hw8rvIIzxBl0svKUPZWvK28umDwDAURIaFSwEUAgYEUIm/WPnNXc1k3CaqmEdNKLk4o4XdrKlqZHXY0yCaxMvrUmHiqey48kYifffhBfa6ygFuDtIlesf7MnQ1kwFNj/02QBlK4hlo9grYQHM1XehgPaQdX7SXpWv+wUhQqbppAeb7v+Ww63cLa9DieROEXVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(7416002)(5660300002)(1076003)(26005)(107886003)(2616005)(186003)(38100700002)(2906002)(38350700002)(8676002)(86362001)(316002)(6486002)(508600001)(6666004)(6512007)(52116002)(6506007)(8936002)(4326008)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BOFet9NCVIQVPuEfLT8IWFLAkBamodr7jKy7HVonIo4j42jXfPKCB0mTacX4?=
 =?us-ascii?Q?DVT74Lu1bXc9YUmFrV9r/LH1gj2xtBeLwPQf3jrRXoMJn6KmjtMV+AiGonYn?=
 =?us-ascii?Q?ZpNlujNx44i6aSR/GsW4SOtmw27+SwQpQb2IKIe3v87MQBJ7QfOKO4IuDhAE?=
 =?us-ascii?Q?QJqPAqO1O0m0axDLpG7Gz36iFsucvdU7AJXBR0j2g2muQOGVhPHC17SmXZzh?=
 =?us-ascii?Q?so3f/I6gV/t2KJDkUrQGP/FgZ6g0gF/KzHHcrNH8cLgfqegATJTKCFxDJ94o?=
 =?us-ascii?Q?TJjUuPgLyIh2xi/WT+4Lm75mU+C2QRIesPgCe21I1C/dwpGB7RutsdsNIWuk?=
 =?us-ascii?Q?xHPKh8/CBqaeQtM8SBVrwz3OufooecRUWl30xpI5Qq7SjjqnkUwAljjtUsBF?=
 =?us-ascii?Q?q+UsygUftWBJDi5gW2P3+dxX10529ebDn/UVjzUOS5I0h1kWBSdo/mAr5XJn?=
 =?us-ascii?Q?nU2aawB5o1SOoQD6Ym9QoWHqUsrkQyjaAO4zpfrd4bdSNfL5efVJE0SYd8gp?=
 =?us-ascii?Q?4HyR/8s13eY/rRfKIus1SDWWmE6tR6+99mAUo4nOhwYbtv3ZU9HDtLUXNCQH?=
 =?us-ascii?Q?yx4s2Ay3nlF2Uie8t6SqdFoO1EO1yX/Sboo5lLimLP9fzWS52cfa3njjlCoJ?=
 =?us-ascii?Q?WU8k3Z0okM+4CevZVrU8t0fLaqVt9n8aKexfInR9GeeQV5mdRmme7KuTN2gD?=
 =?us-ascii?Q?Hyif8+dT8mcPQv9098SUbd7uYcGKQ22JYAA/bAqeMbR6bpaR3gkJMar58Ljd?=
 =?us-ascii?Q?g0LLoqsPFWNuNjoTtGGPPerGc14lgu0FVFlH7f8C1Q7sdua6Nl/wzGyGJbgU?=
 =?us-ascii?Q?KnZbhn60NPz2RrWaUGSwPzD1aIGT8vyS+zKIlXY9e+Qa0KmK//TTCFlAFPSl?=
 =?us-ascii?Q?R4Fw4s5awjYYq4+ik0auhP/utubqcmGWTnd3v3DsrEo34dETrRPLuBYiXMYu?=
 =?us-ascii?Q?ffZ7tQ5+Y0o7c3qUY0Zosx2y8tJMtZYOSxeA9nH4PgETUH+mP0tmVJ4No3U1?=
 =?us-ascii?Q?YJ3bk7gWKtvc7WgGVb94a82FxSR5OQfiPjIza++/p4QiyAoR5eP3Hjx1RCiL?=
 =?us-ascii?Q?aupik4Nez2DTcJiXO2uVhgM9AHqImm9UfP3R4u8K5a98AlZo6BhNl5E2Gk2A?=
 =?us-ascii?Q?N6tbFbMn8zhtzps9pGex5KyQf/1g9d/F/rOOfviBJuUQB2QbZIMLZHsUUeqB?=
 =?us-ascii?Q?Eyis4XQgYi8AKfOcq2rDL2DFyqyt88k7Z/bgq5pigrV0SzCqZ7NkTQITynGt?=
 =?us-ascii?Q?pbXYepwAIzfRHye47I3N3QlSNam5yuBlDfstrGrHmg5hH2kFg6CkP+7VWLyB?=
 =?us-ascii?Q?L17EHpSTdDGalr+eAUjnW9DK+xuSOWCyfOGpLFb1F6FtSlz/+VCHCIPuyLog?=
 =?us-ascii?Q?o4xNSLZnXSImOcwiegnCFgvGBbi4GwpwwQp7pz7VO/VYMTJFIqN+L35lYziX?=
 =?us-ascii?Q?g5da/6BTFQm1oIE/11NlbprVzlgjPFXA7dKHdkwd58cCgET7gDHOAc7LYveh?=
 =?us-ascii?Q?z7PBsO3zoHV5NMzzNJUFcN6e5ziKN31eH6wSJA/i36WO+OaR2JIqAx4KUMkV?=
 =?us-ascii?Q?rO/tGnvVuG4foDU+g2TQ2DXMZry2E6H/w0chFjwpzhAuL9e3uluXRAnMd3/q?=
 =?us-ascii?Q?Y06UgL+Z/mmGSgtR7pke4Z8nRxn7ju76mgDaNP0USppSbxkdZtOfRGcoANBv?=
 =?us-ascii?Q?/AVGSQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c4cf31-49d9-40a4-320d-08d9ec066dbc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:57:40.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJI0t086g86mRyOqKiGkQS8MIgBAPNgC6rZwJZqyj/0pnOCt5KhdWwdMSt+UIpZbNHgJc2opM7kow1gCK81d/dqTOL8loY/MVmGvzeidTbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-ORIG-GUID: dbAX5WsMD-dfQtqAhjkRB693bolBEkpz
X-Proofpoint-GUID: dbAX5WsMD-dfQtqAhjkRB693bolBEkpz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86_64, when CPU or memory is hot un/plugged, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

To update the elfcorehdr for x86_64, a new elfcorehdr must be
generated from the available CPUs and memory. The new elfcorehdr
is prepared into a buffer, and if no errors occur, it is
installed over the top of the existing elfcorehdr.

In the patch 'crash hp: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.

With this change, the kexec_file_load syscall (not kexec_load)
is supported. When loading the crash kernel via kexec_file_load,
the elfcorehdr is identified at load time in crash_load_segments().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 92 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9db41cce8d97..6215c51919db 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/highmem.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers = kbuf.buffer;
 	image->elf_headers_sz = kbuf.bufsz;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Ensure elfcorehdr segment large enough for hotplug changes */
+	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
+	/* For marking as usable to crash kernel */
+	image->elf_headers_sz = kbuf.memsz;
+	/* Record the index of the elfcorehdr segment */
+	image->elf_index = image->nr_segments;
+	image->elf_index_valid = true;
+#else
 	kbuf.memsz = kbuf.bufsz;
+#endif
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -413,3 +424,84 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+/**
+ * arch_crash_hotplug_handler() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ * @hp_action: the hot un/plug action being handled
+ * @a: first parameter dependent upon hp_action
+ * @b: first parameter dependent upon hp_action
+ *
+ * To accurately reflect hot un/plug changes, the elfcorehdr (which
+ * is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories. The new
+ * elfcorehdr is prepared in a kernel buffer, and if no errors,
+ * then it is written on top of the existing/old elfcorehdr.
+ *
+ * For hotplug changes to elfcorehdr to work, two conditions are
+ * needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources. See
+ * CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ *
+ */
+void arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b)
+{
+	struct kexec_segment *ksegment;
+	unsigned char *ptr = NULL;
+	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	unsigned long mem, memsz;
+
+	/* Must have valid elfcorehdr index */
+	if (!image->elf_index_valid) {
+		pr_err("crash hp: unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	ksegment = &image->segment[image->elf_index];
+	mem = ksegment->mem;
+	memsz = ksegment->memsz;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources. The elfcorehdr segment memsz must be
+	 * sufficiently large to accommodate increases due to hotplug
+	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("crash hp: unable to prepare elfcore headers");
+		goto out;
+	}
+	if (elfsz > memsz) {
+		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * At this point, we are all but assured of success.
+	 * Copy new elfcorehdr into destination.
+	 */
+	ptr = map_crash_pages(mem, memsz);
+	if (ptr) {
+		/* Temporarily invalidate the crash image while it is replaced */
+		xchg(&kexec_crash_image, NULL);
+		/* Write the new elfcorehdr into memory */
+		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
+		/* The crash image is now valid once again */
+		xchg(&kexec_crash_image, image);
+	}
+	unmap_crash_pages((void **)&ptr);
+	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
+
+out:
+	if (elfbuf)
+		vfree(elfbuf);
+}
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0

