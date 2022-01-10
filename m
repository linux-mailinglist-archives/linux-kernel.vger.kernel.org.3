Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B461548A095
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245445AbiAJT6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:58:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14240 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245231AbiAJT6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:58:24 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJleBi021735;
        Mon, 10 Jan 2022 19:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=4nZLkbLPQjF2e+CGpZP5Brt0FC6DaCqZwdobXBL//Ig=;
 b=hYCkGqGCs04NSvj2A/iD5WEmD8+JOH1+8+ynHZwf/BdY31Q74/9EDHMZjRiktIzv+4qJ
 YN3JZDaSRWqL+kP6CNYaHvvHzBpDXZMnhXShfhxzMhrzcnj/DOHycov7DHLUJGz4CB+H
 5s7o3cPKrER3oygY0LWQME78Ip1AsY6GIU9M8VrMCUxAB1O84qirS05cDr1JL1aN47v9
 u8EUwA6sreBD3P68KFHVmk289MXLggTM9vp59hbyWr8/4O2bLjlpJfui1Dw3PSMbn0At
 rfh8a6dlPtkrrhHSAaeS5mdKy5umdg4vM2LaRJSl2BnWPEXZr4xhJiW2dDBgzcgZ42uc qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9988k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:57:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AJtZRf014310;
        Mon, 10 Jan 2022 19:57:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 3df42kfw3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzyOD5V0WZBJwqf9pEFGGhl5uIAS0fI2hLhZXp0GHdIVeiROelXF8oOQWcgzjrX3b4w9yjK8I99CN/O1j0q6W+vWfJOVkYMo1MSBOJ/jlsnnozZtCENdm9rJo3+zehgRHTh8LSLoonfrzksFpnAa48vdZQ490w89JXHrB1zMqDGf5U/hgWtNoDk31VP0ZUihgNX7hBP8V52Z7c8Saf/CRZ2fqFmo3WHml1i/iWdqylfQWUMHAjI+pHLTxP8obuD6OjRNsHyErAIDUrzVfO+zdAn3E25JcVJgRDfjK3o3/MDzGZRFClV2wUVKftWwCV5NtNWkNfoQBwVbFwgiRP5mmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nZLkbLPQjF2e+CGpZP5Brt0FC6DaCqZwdobXBL//Ig=;
 b=Rs0yqm5c/6m7WTm+ur1NYPh3Oqgh5tU2O7NGcyf0zp+4cVQMG5l5i/M2FHhRmUEQ+oXrzYEOEodevBED7uKNMlfNUOcuzajDX0iclVVTk5P+7bFBe4EluVC5B8mC0NSEgb6ir5WpIGQuIbT3BNgKwVwSFdX6Q9l+zKE/sqBv5fG7b017s9X0lfaU+AqXmy1Mlh68txC7vDeSOXCKSqFwef0PdwS4PkYiGXtSZrn30UIQGN0hRURpmsKEhxFMZXEwuBwPECGnN6Za3SqdyqCk/jdklgLG27RjzNVr6gfSe+Vb01FGfBoCOGahmEujy9RKbVOApW3hi3WmmlEBbMLhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nZLkbLPQjF2e+CGpZP5Brt0FC6DaCqZwdobXBL//Ig=;
 b=X4gu0JHGqipHIKgJFXo+o/8wqsPWbr6CruRvU5Yqf5LG+PTSvd7FIkUSlzwr/Zd0ru+Zi2ot3fuhw+wcIbjE/6S7LE5S/yur9+8+mWyoxEQQ7lPzdR44v3tmKGvi3eVe8eeipvVWWfP4z/DHu1HAWBm0jHQ7Zc0FFpuWkqrDo7s=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Mon, 10 Jan
 2022 19:57:52 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 19:57:52 +0000
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
Subject: [PATCH v3 3/6] crash hp: definitions and prototype changes
Date:   Mon, 10 Jan 2022 14:57:24 -0500
Message-Id: <20220110195727.1682-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220110195727.1682-1-eric.devolder@oracle.com>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40f193c9-4f5b-4b60-b501-08d9d4737c11
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB57019F04280D5F443420068097509@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRh5nSqqcvG39+tJ5TfeOSQZk9ad+iKOjlIbfq/Lwgwn5nRCJclZaHckAPx5Ly1SZyovHEQmA9QNgnS97ViaQZqT3d+OjXNz3ozavLfyharLt32pNdLeKro8BR0JnHpD6f2ObfTCw0POMJm7mgEVloNdxnI8tvfClhX+fmPTLegke4YDEF6gEBMSIAPPnJJe0ZkFPZz0gWa/LOqVAlMeNRQ05o2B2qHdRkdvIpDMehDqb4atvonQUI6NxuS+XQ7RYYyl3Oiu2Cj0ivnCFWCs4yE434u1UW2s9iScbwX6rIzQz5H7XcbwSkevQl/0Sh4KHRTymnj/aG6RnW6dh0X2I3tbj/3LTJ0iPIdt4V9n+65so8DyJEJETrYVGcI7RNtJhqFvFLlrtXMwbhAvv2QNUgwt2wN+pEgaRKDgP8jDFAvSr8yuMcjsYyzVrQMVUirxS1OxqIsYzMv+wEsdlbndB8PV/LblLWydwBiZOIOElObQ5wiNZDCFFpNLxhqTsFV1E20bCTO+fUgpqHjd3qmuLqfmLscTeCOirTXeZQkwugLlDuxO3vzPo3mn0baMMqVvO/EPlxHtHNSUoWRuUSD1flAprpNzmXDUMb1+1+HAZVX/vFFtLto8PBWzqRBPlQyfgWtPtY5LkOSDzlN4+KoYE/OCYqBs3n/uRV6VYmltHX4Zoucq2cxcqWvO+R72lZuGYZzPDkKlz2SU2sFMhdA07Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(66476007)(5660300002)(36756003)(2906002)(8676002)(6512007)(52116002)(8936002)(6506007)(4326008)(26005)(508600001)(1076003)(66556008)(6486002)(38100700002)(107886003)(38350700002)(186003)(316002)(7416002)(6666004)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7H4tBLgYvTRLnCUnqVGp2CtRYnHPbxsGcsgah0mdchn9MAptqSTLvYQTrie?=
 =?us-ascii?Q?XrYmITpIp/+sITNvvQYQjXVAER4NxRbdPB1VYsboSHjMO0zerLXQemYCbFlo?=
 =?us-ascii?Q?kwMLiDq/K8DsSu2uPangRHYGLTlyu1jc30NVvzD/9dDBFO0Mx5vXml0FIy0n?=
 =?us-ascii?Q?DqKKVcrbWbbW8YPZESS2vkclPmCtQkWt0/udl/64nRdtHHr+NhIQKovgl5dz?=
 =?us-ascii?Q?f/aR9b46eu/O80fJCOqA6NwDrkFlFvhfLHrt94mbJDBZ2MyjT+C8P9i5xIyZ?=
 =?us-ascii?Q?GrK5VAvjbnq565878FxL9JSbyi+lLOuNjJ8RH+ps+HHb9sJ7WyFUBmj5xN3b?=
 =?us-ascii?Q?UIh/nv7McUsCTck7/2E5Wc6gd8bT4uuw3KyPELqtUvdY1xpwi6ktWFakhKab?=
 =?us-ascii?Q?GCOGZgfbD+eTYS+noFbBK6khLNu5LNdAb4by9m7uXlcp7YQDVSYjoPjlBmDv?=
 =?us-ascii?Q?zrLKjqB1NCKM70tTehJh5k/F0AcfO5HdZVIOKkoWQfsvIhhpWvHV5THDffNh?=
 =?us-ascii?Q?NclJR/gx17tT24IW9e3XbtgVaukF7cR+H/uVxHynigrJxwCZKjMdXb0IEByd?=
 =?us-ascii?Q?QDvf11FluS7LcPy6HGINFdpSWTkO/y7edeAZXBf4XU+3XmRAT9VRbL7UBFPM?=
 =?us-ascii?Q?0ueZCjbLGOiX+IMSKBigKwtwyxt+NNobI3qwGB/t+NB0CwujY+c0H526c10M?=
 =?us-ascii?Q?gFIo1m2K/EsPG7Vowscf2UNTA1tU7Eqdh2UNG/bl0JBv5gMmL+0SGTfno5YL?=
 =?us-ascii?Q?Gn0w7RHxHI7H+yNPqd4G59e2kscQAC1khBgZtBxN/CHx6MV/BQ3rGgkzFBLM?=
 =?us-ascii?Q?T2cWb7KbrzrNb1WAOAHTrDMykH3IL7Sn0qgaE02qIfHkHMJaDuSCxcgE0HD9?=
 =?us-ascii?Q?Ir5/urIyiWBivalhs6zaBxYLJHCahuAdmSWDCbPuSLODfLx2QKLZAeQt4FkJ?=
 =?us-ascii?Q?1HSSYZqa8MvHP/Z8apaL4q3ToCFeT3VhB5hKTPKJTjtMAUkppgL2m+g9SzYN?=
 =?us-ascii?Q?nFK+6etCYVmg/dwIdmU6zRnvMT2xOTyORhz1myZIvQqZJ6x0cYVHSJpG2Sal?=
 =?us-ascii?Q?RryUodSI/L1rg2n3nsYXdb0hkEn60EFIqef/C/Og2ukuVkrwmsGhPFo1RajW?=
 =?us-ascii?Q?O3XnzDRPRuk+6LJlHCb1jlGHNvkv28SuwakwfSm6wnL0WdRUtFPBtxYSJh67?=
 =?us-ascii?Q?R5UeSsH3XNxOxj4jdahmXgDXYWE8zSGgyhIDPuC7B6dg4EJtmCZ0rQLt3Oeh?=
 =?us-ascii?Q?UIHAJl75XSAFBPlg0jLlsWULyTRalICWJ9EimkZkd+CmdrsJ5dgEIVcGLVgm?=
 =?us-ascii?Q?fXpXhqp+OpiAdyMa9bcaKdT7TF+WcAF58Vvg8u1wb9VT02C3fIqhiTxxziYM?=
 =?us-ascii?Q?dpSXJ8HtX617YmlEodH10E2h7Vp1DeWSM804OKeunM+Kw9ptdkNzWS8VZHlf?=
 =?us-ascii?Q?vnB3iRI/HPpWCSyPMR4PdOiE/FZatUbLOKIimaYLVlBYJC1d3XkkCoqdPDyp?=
 =?us-ascii?Q?D/zi8OYqbJMHUl4J4SguW5hbjT4L0RWLcMbSLdkgkmrHZvJg4pIwULSWaRH6?=
 =?us-ascii?Q?bWqNJ4Ych9h7hqhP8WrJJYrOPelYwq1vxD7efGiQX8raSaywV7WKYTRfkMOP?=
 =?us-ascii?Q?zDjyzddfOL4XdqoYBUCO3j8tG4VR40BtafxoZhTUxCc7cHwIevi1f5L5afOw?=
 =?us-ascii?Q?SZGJZA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f193c9-4f5b-4b60-b501-08d9d4737c11
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 19:57:51.9217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1isKoYuxjimCPikpQ8Upea9rKy6KYdnw5uWTUsV1j9zTvpzqnY9GGFqDeEPciwG/7vbQ6m3ka8srA+l4zULkZO60UI2ftkzNtVeKxGdI8B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100136
X-Proofpoint-GUID: QI2hNbv13clCNLP_eFPdb655W5nxCBaO
X-Proofpoint-ORIG-GUID: QI2hNbv13clCNLP_eFPdb655W5nxCBaO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds members to struct kimage to facilitate crash
hotplug support.

This change also defines crash hotplug events and associated
prototypes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/kexec.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..068f853f1c65 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -221,8 +221,9 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+					struct crash_mem *mem, int kernel_map,
+					void **addr, unsigned long *sz);
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
@@ -299,6 +300,13 @@ struct kimage {
 
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	bool hotplug_event;
+	int offlinecpu;
+	bool elf_index_valid;
+	int elf_index;
+#endif
 #endif
 
 #ifdef CONFIG_IMA_KEXEC
@@ -315,6 +323,15 @@ struct kimage {
 	unsigned long elf_load_addr;
 };
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b);
+#define KEXEC_CRASH_HP_REMOVE_CPU   0
+#define KEXEC_CRASH_HP_ADD_CPU      1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
+#define KEXEC_CRASH_HP_ADD_MEMORY   3
+#endif /* CONFIG_CRASH_HOTPLUG */
+
 /* kexec interface functions */
 extern void machine_kexec(struct kimage *image);
 extern int machine_kexec_prepare(struct kimage *image);
-- 
2.27.0

