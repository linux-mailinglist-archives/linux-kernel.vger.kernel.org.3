Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ADD4AFDE7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiBIUAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:00:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiBIT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:59:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5F1E04ACB0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:59:27 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219H6fo1027623;
        Wed, 9 Feb 2022 19:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=4CHoi8tqlVL0/7RbUyPcGVvdE6vnARDE3PCOqd5z3ts=;
 b=Tj6tggintmXlG89beKDEXgWARvZbUSqOXu0nbf2Ha0YHV9+hoxrUxPaMetwD4ii8ssuX
 7K0nzvjPbuF78L1l4dS0hhIYBFjYOc31ToLt1usMXPkhEpCvJ2uPFV7+aCSvcS2/ihZ+
 /X0F7Ej9MF0xajrLgfiotJRRxbLhB0D6duqX1EODBmrksyjzUfnrFWQlBiIztBPdezTY
 54rJwDKUroAs4fSupAntjVBVhmH8Bhbde1bWhQ6mo/hnJHaCy2FJSGgDNeGwhLupXoUD
 XWL0lvLIKliPgk0frI3QblS/qWraQ1WTwZoK/f4sKs/32jrUClLpE6ptzRnTmsn1TjoP LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdswn2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219Jtqh3046293;
        Wed, 9 Feb 2022 19:57:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3e1ec3b09u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9nbYJyy09yjCEkFHrzsIe1EsXLUvZIHwHzNrMuMyG1Z6+oCanemoE9PyrM159/4g7dWkdiHYiShZrC7CEVt5W2McE2Az1W7j052Wr8detR3K4OKPtgDz51G1T3bTlG9xWtPKR/gLoq2zblIRkU6gEytWXt4OWAbTQqOaUNxLj/N8rSac+645Tc0fEkeyQ+0d0EifE8KQHCoCaTjhcRB29OoS/fJ3p/42dd5DSkSvFERo/9M1VGtxIvjzc5zqD7Wh9xEO9ZpMggLUThNb85ztSxhU7fwh06U3lObq64i8JRfXfltioh7289ie4NW9v6AMWMXs7iTVktv12+goqd3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CHoi8tqlVL0/7RbUyPcGVvdE6vnARDE3PCOqd5z3ts=;
 b=D73j7sFMRA7iGbveKbpyO6LdoCKZG6Lo6R5b+XBURNrPOUMeihaddmfPgDq8J3gjjH6X1bY2ZlH/ZP33W7LhLXUDt5Yu5Pyh2iw7vDcrLk+WS4d4MM5XVA68TWGJT0vm3onTOnY7GVxo4Kdl9Dzj6Ju3cwgQZ8MeaI3TZdbDGQwIOixYGDbYwGDSOsFkSY2VeDIenbtSo6MU1VuGsr4S5fR7hCI/M3b0VhmZXfzHSPN/kHVP0Oqz1MMWzCqE9R256DRii1BIAn7TOceDjszEAkxhGPHk3gaiSg12ojQ0xgXl4mFCfcs7TWEVMA7mN/gVhKGtNiRXk6qethAqSti29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CHoi8tqlVL0/7RbUyPcGVvdE6vnARDE3PCOqd5z3ts=;
 b=faomw66Z9KxkyOnckZdnr9K5R7seZN9Cr5yiSk+ObDqJH66ma951TqMk9y9na3a3DYm4sTp5E69m4fuhw5AL9f5PeZwlXTZFp83sjTM19Ii8NtvCgVBz8Fd1qy52lEeHlHOsnrOZ5v9DbpunY2TePKJuTuBI3MPRl+//Frxb4OY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:57:29 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:57:29 +0000
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
Subject: [PATCH v4 04/10] crash hp: prototype change for crash_prepare_elf64_headers
Date:   Wed,  9 Feb 2022 14:57:00 -0500
Message-Id: <20220209195706.51522-5-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f27f7fe-7330-40a2-9f0e-08d9ec0666ba
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB57013DE77446036A57247512972E9@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ce69bnK1YgeKbWhnWfJ14ciHfTMtud0GAOI3Sips0JEawagtfliM9/2tJdPv6riKNaUMW/40AnlfB7RzFMHJHraagQewx322oZOAV4Eq7OaV3FyM0v0g1iuYgKw61NS2eEvjM525OAyXuUz6cqnG+l38DdR6OpYDE/UnlYy1Fj3dW3sUQpyRyCcBUj7LW5LJxRnprBR5CQjEp5Fexb1rYqI9eUh6sUyCcjitnlQOwTp4NdZ6jhxY8a7R4aEXa+YYcrVtIwtPCL7i8BH1evjp+2xKlbgu7343yFzhUa0FQ7kPUYS9xbg5XAshfzbxzfg1+sHEl+sB29GxfahNB8Wy6+bVqoGNbR9jzgxeQdfibOBF8ZRjgzKL3F7BJB034VYwkPYq3jwAsm5JqL4CSJXisW6QYoU7KMF8tiFST0yioBUtls84HXWQ1QNtEpdwmDDWd/fPdAw+S+XAwgYz2aPr5AOSz5e0Y4I/ejvWsQb3b3JxPNCf8l8wEHeBWsH/3NUlaNBIZs5IzTRaKMr9KHFbYLi5/Utu9QzQLWTLqXYxuZvKFr79ubJF27BmkjIgMuuQBJJ0OTKPUuB4UH8zeU1aVyL8ROPfQUClb4TknpfFTR5QmWHYng/6kHSC4qzktAn09C6d6GY9oNn5I4WIAWgI3C1S+J6wqEojOVEAHpSV7UtlazIYRc7Y3fGSuIxAyZuZMTOEeF8z6b7Vst9fvIq+kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(7416002)(5660300002)(1076003)(26005)(107886003)(2616005)(186003)(38100700002)(2906002)(38350700002)(8676002)(86362001)(316002)(6486002)(508600001)(6666004)(6512007)(52116002)(6506007)(8936002)(4326008)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rj7xD5mfFcCKlQ245DC9VOiyvhzbiiAy9PMBmIx2JRKMAScw2kmXQXTsFqUf?=
 =?us-ascii?Q?mGbkbOma4VQhxJnPf66aeSRetpzpvsBKbOTsJ68SWE8AAlVEKXtSOioMjwxh?=
 =?us-ascii?Q?Jx/awA2WMdFLFDGk2TqBpFTDnj94vbHRsZ0VQTAKD2IUgqC+iTyq3pYpVnaJ?=
 =?us-ascii?Q?dq2QftGjF58gkfGAadH0s6HuqKSvp+Uhli2zh9cFaObP96LtZhJV5KE2Lr2u?=
 =?us-ascii?Q?xcznnpMtgYkzFk5B5IKMnohwY/4H3OjZz7ZW/DT4LC1Jg3d/2YNSKY3XqcqR?=
 =?us-ascii?Q?5BhzHBq6R1sPObSb0AcmxBm8GVXGvI2d8uvnXTupNTq6gGNeXIvd+WRWXjkR?=
 =?us-ascii?Q?LfbtBklWJ4nPHlVp66eNb5GKxmZDwrNlo6TWQ/NqJRWaYuK00Z0mjWevYB4M?=
 =?us-ascii?Q?S8HTdB+2mQLJrLcMHG6lGhaKKgw7ZKLKSZhYUmYV9pJ84pPanxhm/1kZVxtD?=
 =?us-ascii?Q?vlOgI7JG/dnLCOTv4tXtKMe8U6rBZJrtjya85laR5qwIrOjMti7cyFST3lYn?=
 =?us-ascii?Q?PQrIj8mMSm3lc3ndA9alCzPeglB6KnSR0+7HH53x6BcalMH83YVMu0C1ajA/?=
 =?us-ascii?Q?gjLvbHC267MBzdjpq7ljBfVCmjdx4ooOMT3C0GTKuAl7UJMuaMMhICLSPWmg?=
 =?us-ascii?Q?DiLzO3Gc5wJ+Szeflo3P2KmKO77C+dXuJbjCGJjZTILRmE+czWPHQk17xOFB?=
 =?us-ascii?Q?QKu3CfIzs7r6+OXHmtGNHz7OUrZ9NoZEq+iIlnWsSWY2pTWZT4B1FH+ncid8?=
 =?us-ascii?Q?5e/TjEKQPtyDZbaDVKtBUeHtrzV+ZShaSRUzj1kqOHEhEg23Gfzd7OsgV+AT?=
 =?us-ascii?Q?cE52+4+5MIdOxSXpwRFc1O+lIGiko+70bhDb1zV5wvWvGasOigTEAd7gfhCu?=
 =?us-ascii?Q?fMXhPUvzNHUmum1ol/za48e8iYcPM8dfj8Rai59InTco3wdVt4F5BsVJsbVs?=
 =?us-ascii?Q?RZKSx81MO412bU8fE/jUZBX5RZZb2bZ92NdJONt71+BO5vV8vwC8vBZSOvIz?=
 =?us-ascii?Q?C5baRZjJrRbjfxGxXq0e2zG/2DwCJaIOrQ8Cm/nCkQiH4KoIuteI0XJ+FByS?=
 =?us-ascii?Q?s4ymedIJ0w+hFEag119Wp0l5FThhceJi0RnjXEWLpa764do/8JJkIkewjZx4?=
 =?us-ascii?Q?FFeo1p5/ZqJFPtF0KRnbVHVbav154rGDurb6Vaa8hsJRWSkV32b5CcAVoMcy?=
 =?us-ascii?Q?cjMK4KT3nFdsz8zmAv+IDr3BWjsWJO1C2rR1ZR4tm0AI1QF3Osl4gU9kiFK+?=
 =?us-ascii?Q?CB8HYzmVgOxdEZHVhfEKI483Aq4cCh7CiT5KVLEksHUltU9Ko2v+C6z15wcS?=
 =?us-ascii?Q?Kl/dir1Mn5YDL+LlQ5V75/5YglHYPQ9sCsEE4PhIGtbMct10xpr/019X+1FF?=
 =?us-ascii?Q?CaLQjtl37FiOp1ANah267CJALbX755K/HA4SoRXnGrSF8WpkX1GUMxO2FWxH?=
 =?us-ascii?Q?4MQyf2mfSfAcbMZ9lh4g0dRvwdAcLNMS5Zshy5ZtPw5STU86VeC+YR2QMDx+?=
 =?us-ascii?Q?uSvtVEMml0G43+RakJ3RyRNxPAelkG9uXk00VI97zjSWw/NjvivmLgxBXaRV?=
 =?us-ascii?Q?qejHSKbjWfjL4oeBKNj+fms1hipEO56oFE3ci2dqhsRfhGYxIxgkh34Cfg0f?=
 =?us-ascii?Q?tJg223C/x3jtQ5FsIhDPz+UTgUita00ukXn3cdyk65BVphIlmewvjH1hj7L9?=
 =?us-ascii?Q?6m0XJg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f27f7fe-7330-40a2-9f0e-08d9ec0666ba
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:57:29.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mEyHUM0T095I5bl9S8HpF9qJbrRgAkIZ66LovnwqSXA/xG8G1+tLn9jn4Z9VCzAC2AW4OUBk6KjZzu/m8uL6SrIMa9EQl8sIazRaeaeEC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-GUID: vUXE5iohOFkzPRCGi7WbH4qmkQEywj8o
X-Proofpoint-ORIG-GUID: vUXE5iohOFkzPRCGi7WbH4qmkQEywj8o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From within crash_prepare_elf64_headers() there is a need to
reference the struct kimage hotplug members. As such, this
change passes the struct kimage as a parameter to the
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/powerpc/kexec/file_load_64.c      | 2 +-
 arch/x86/kernel/crash.c                | 3 ++-
 include/linux/kexec.h                  | 5 +++--
 kernel/kexec_file.c                    | 4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 59c648d51848..7dbafb42ecf2 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -67,7 +67,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 
 	if (!ret)
-		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+		ret =  crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 	kfree(cmem);
 	return ret;
@@ -96,7 +96,7 @@ int load_other_segments(struct kimage *image,
 
 	/* load elf core header */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out_err;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index b4981b651d9a..07da6bf1cf24 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -797,7 +797,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..9db41cce8d97 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem,
+				IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 13c238c2da48..b11d75a6b2bc 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -221,8 +221,9 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+	struct crash_mem *mem, int kernel_map,
+	void **addr, unsigned long *sz);
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..801d0d0a5012 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1260,8 +1260,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+	int kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.27.0

