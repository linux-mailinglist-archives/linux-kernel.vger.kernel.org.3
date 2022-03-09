Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293A34D3CB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbiCIWMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbiCIWMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:12:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1873120F4E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:11:48 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229Kclxm022212;
        Wed, 9 Mar 2022 22:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=oRAKl0H0TZNhMdCI+8vB61CbQYLRZvaq+CovkWIIVCA=;
 b=LyX21OyfS9I/wE7d6uwQKPQFBUikE/Ve3NyM4EfJ0ylvLfuGJnlqHed5xxfbmL26VELW
 sJuj2KAkRJbDVOygtkisl25wALhwEIP1iv5VxgBwgAOer6SlaK9BQQezPhRWr1oTMklZ
 y8j7qR3ZnXdg3nZfU5eWPjw6HciMO+yW9hrxC5ESNWl8A+E2Es9nr77iy8js+sslrFjb
 nDcb4dlqXu7S2k4Unn8m4Ml2ysBdmzW7S7aJyWZIU64qIvCS+96M8WvardVsd5Z441qy
 6s8FUj0c1zKyBEId9r6bhrLBvihTKM2U9IzyeXp8Lcz3zJqNeBL+icdAgAuuY5arK+B6 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0ugkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:10:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229M5geo132868;
        Wed, 9 Mar 2022 22:10:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3030.oracle.com with ESMTP id 3ekwwd28by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLjFsX/ZNrvg8+lynU18llOCurU+fVfBbNMqiP39W+vGeVZhTJBNWe67u7Hd8enUCjHfk2Lt8w94p3dgpxWlPmMFmwAXJ2Qf+r0T0rGJuOl6okQP2H9dzBt2957AOufM8lkfzTxTxnEOR0/9cII9+aMwVZ3d45TcGAhvmDxllk3fMUR4BaD6klf9IzyAGtPvTptNCPS3/JVerWiIv0PtfZu3hWNxMrTYeXUNcj4fQ2asHvoYR1pVRxNNZ4krwS5dnA95/kqvz6hKvgmRE/fyKKEl9lnv29gFSk7l14UjkmBSckurUSrkVsGsNMIsX6vo+TTEOx1bIuo/6i6KEOrTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRAKl0H0TZNhMdCI+8vB61CbQYLRZvaq+CovkWIIVCA=;
 b=nL/ox7baI50FwInNh093Xb0M6dHptCWF26OCn/2o6SqVBhqKdXEFNB2wOTStKkiixyOAg1FG+2xI0e7oMjwEDK4cHu7sk4cIdlxqVanYdazXtA+wKhQxsuCD4wWD6LOmAy9P28HJMYWAtjY0iYQJytUMHL2Isrw+jipdx2jTJr4BmJv1kKWa6yqrA+yzcvx+eWCrxzZWr1lICLHxBLKAQsL2GSbFHmT9+RJ2uKC+sk6De6x3JHqbCm8jqsApJsnM1NMGyG7JqTa1L2yCTPEGGoHK5zyc3giaEt5YB9/Y3h0IkoV9U4h7LXI/2TxIr6ol6WtnpwW0OIkDFxdBdIOw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRAKl0H0TZNhMdCI+8vB61CbQYLRZvaq+CovkWIIVCA=;
 b=JP6CObGUb3r2f2Ofa+J2EIK586NlxgLZtQ0WlOjfFksWn5hfY1UgkAfTf6gUkP43Jh6bVfGj0wr+M7qK/V9EPj9nYpSscPjTbJviH6QBEmeTVdLHbHHzbPSejeXxjl2DNFBWv1CigYlTVHYv6q6yXjt97xezm1HX3aHOxYePrdY=
Received: from SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19)
 by SN4PR10MB5560.namprd10.prod.outlook.com (2603:10b6:806:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 22:10:04 +0000
Received: from SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::e82a:9be1:793c:1702]) by SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::e82a:9be1:793c:1702%4]) with mapi id 15.20.5061.021; Wed, 9 Mar 2022
 22:10:04 +0000
From:   Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     thomas.lendacky@amd.com, brijesh.singh@amd.com,
        kirill.shutemov@linux.intel.com, hpa@zytor.com,
        pbonzini@redhat.com, seanjc@google.com, srutherford@google.com,
        ashish.kalra@amd.com, darren.kenny@oracle.com,
        venu.busireddy@oracle.com, boris.ostrovsky@oracle.com,
        alejandro.j.jimenez@oracle.com
Subject: [RFC 2/3] x86: Expose SEV capabilities in sysfs
Date:   Wed,  9 Mar 2022 17:06:07 -0500
Message-Id: <20220309220608.16844-3-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309220608.16844-1-alejandro.j.jimenez@oracle.com>
References: <20220309220608.16844-1-alejandro.j.jimenez@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To SA1PR10MB5866.namprd10.prod.outlook.com
 (2603:10b6:806:22b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c620303-b0d7-4c56-fbe2-08da02199001
X-MS-TrafficTypeDiagnostic: SN4PR10MB5560:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5560035A7DD9E9B093CA08F7C70A9@SN4PR10MB5560.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZGVvk1AiTEUlkO5ztgW0mFAeAlqWPeAnt3ixR9qyebj91PyNl0GSVzq0/L0PnFSwb/Ex5EOOCSxPmI+anQMaUQYDYuy5q0XMgnIqVBkEVIyHwbikL5l7OapG1XwOi7husU+BueQcoSSmEHPPB/KQ+z4XmNDVidTOXvyZ5nalA9vX+DtmF2/uhQHJrKRouYGbWhHKZdKuVxl5NlqCT+5Yx0C/SWoZF0mekxtK4U/nGkkpfnsyZiedMeMpYbhXXFh2Dm6i6fPExLjb5TOn2Rk8+59gEEuDhzBTc+vC3cGEfEZrSxdHNattkA4MiKTAdqlj/SPFjiO6G7TDyELUnSy5Mt4U0npvj1kknzkto/iDiA9KjlE2gmRRNtyb7nzWmAJOGgZBURHDZ7L6DQ3dc41nx50/n6u9X8/QzxGeJm/EztKunAcc1yHZMCkoXmL9SKID8lCSK+AgRq8NPD0GXCTqVIxg1vgg3Q41NGqV+iiDtEWZfNo//eec0y5hlsshgdKW9WXvVY6pQeMAqkmfKmcp7gaxUjgzn2udHlotdUcD/aXPFzf0qAizt1Y2WwVVIhzqN5GFK8dzyzkYXNT2pCnCeaCOSVtSWJw7bjkAl43Y1toj1c5ZGtvDRrUexFW4dnhImcmx8I3VHyJU29ktlI/Jaqsm7xPxX8VxoWQznPEvEfhasgqqtv7DUGAZZzlGLkmpqQ37W4Y4I+9AgUHHT5op2m9BiJhxuwsWcKPfML+tH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5866.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(8676002)(4326008)(36756003)(86362001)(103116003)(107886003)(186003)(2616005)(1076003)(5660300002)(52116002)(6506007)(38350700002)(7416002)(66946007)(83380400001)(6486002)(26005)(38100700002)(6512007)(508600001)(8936002)(66476007)(66556008)(2906002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JdkDTm3ylhlxZNqrmre5mNmq6i4MPLwUlN71rGWj5ux5KoAO3AtxQwza6ctq?=
 =?us-ascii?Q?jZmpU7ammb91CtiKiFR0xNdkmnNubySgrYmYo5d+QVMmANsShDxUOwYEYGpO?=
 =?us-ascii?Q?/gZ3jUlH681J0BUo5bwfkzD3TO47hBNLmFT9AU8CEXOBZTbGoJwo6WRK+aVW?=
 =?us-ascii?Q?I2DA0a+pXVcuf3vqatf1qvyhSLhwxgF/G5zUIzuoQFisnMKYc4K//gA6QGVR?=
 =?us-ascii?Q?6C4XAorEohhfacbXOA3eRiOEJo/XFzRzbhY/TUGr/C0WLNPSS/RrXMwG+u82?=
 =?us-ascii?Q?jrkZNafcppV3Y2H5iq0dWLhIGnHuU8+gu6kHKDjAK3lrMD0ER/FcqW7rmUrF?=
 =?us-ascii?Q?pvEnQJGOqdS8VzrIb9V3ZMg8OVAYfPRcIq7FGGwRlQa/GIvhc0e8DidjcxpE?=
 =?us-ascii?Q?KDu3XA2KaOvquduBLsYXyqOwTvpxRs8s/AvxAZIzOrUwsDWveCEgIQN0taIi?=
 =?us-ascii?Q?UBg3ajfN4LyT1lgU/C1elS171ScA+2RKz1KCxTUt2Ad+1Y7/hX0P+upEhXk6?=
 =?us-ascii?Q?SxyeJAVoq2Re/DGysUDnMtwpuaw7mmCxvXbHj6e8CrYg93l76azdNKgu8xj8?=
 =?us-ascii?Q?9o9vCSZDYsmdoZNyfUzMgUXZrfvOZAUeds9gTFYK8raAIAIqLzO2sfeb9T7d?=
 =?us-ascii?Q?G0mdUNV53U2jsC8OF/6uUP6F4haGKdnrGuAJp/q+IAdXvXtaN/qwveqei5vj?=
 =?us-ascii?Q?P0czxRLsc5lTFpVOXMC50X9M8v1hi7YIAZZPSItPtKXGsvpi+RJzfwdLUgpi?=
 =?us-ascii?Q?Xp/zb4L+dSUSjK7+z3o1ykXCWStBMYNTQL+ePUuBVZv5Ax9Cp75opOHrGkGx?=
 =?us-ascii?Q?dGgs0WT0Od28GjIGlUBRRI38h/X2qslhMdFUAcWyq60+G8eEtCp898uTe2Ca?=
 =?us-ascii?Q?Uo/HAK4vJoF87RAk3i99PDyfJftJ+El89wBFbcWezB3aVZP9PSMj2+wYR8qm?=
 =?us-ascii?Q?l6Dhd/B1ew2Wn8YnBga1sv79Ey9GHKrQBohymEIJM5PDXbxgV5mg9OM5Bjrz?=
 =?us-ascii?Q?Hy+11f9ecScrFJHx54lZG+GLy54wRx2qqf5jj5vr5sCuv694lnukOHS4xsZJ?=
 =?us-ascii?Q?bn8ZnYysM02IvJ4ziRXjN/ZoGZ7jkAct1L6W46oOC4jgMlb5Oy86AKQBE1gz?=
 =?us-ascii?Q?SREKj+s1igc54TYqknHoMmTJTP3jVycA9iRHZWJs3AXgo25EIE2SbwGbRzjA?=
 =?us-ascii?Q?FkVsM6/T+JyjISqa6CwOmvM527VC1U3egjH2fioBU5bWO7oO/OVxltwPAkYR?=
 =?us-ascii?Q?Bbi3xQ33Cd5/QITkGiDzqYazZsXVzaCF+vfGAU0E2lgZWOA4BvenNKmdxjG7?=
 =?us-ascii?Q?lVOQt7lYK+fpkbEoCGKx9PNKcQ+WYY5WJ8rod7z/t870gMlg4pvZww0+oSLi?=
 =?us-ascii?Q?xqSlIjsYKFj0jLOunf48o8IlnMevozCaUp4htH38dD+wt+gHiC6c8G63f8cE?=
 =?us-ascii?Q?uUohqU36gF6UsKKPdLLaXiB1Q+ba5A4RMUiAtHy3cDqYx8ubg762fC+3iILZ?=
 =?us-ascii?Q?d7zesZSRTx9VedfBvRVCRjoeV4IGxLM06nRd9Z5FzQw1wioRl+Hy5N7pcpwn?=
 =?us-ascii?Q?4bqbuY80i/53DwrmEXrWV8EuQuw3z3uL5XANwk4bthk3uagOWCuCiYRLmcKb?=
 =?us-ascii?Q?XT7MbRhcyYeuBraEjUGHefplFl/76C+2TicDhu0+IHhO2NrC2qDw/Vf6wTJL?=
 =?us-ascii?Q?ChalkA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c620303-b0d7-4c56-fbe2-08da02199001
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5866.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:10:04.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35Fg6NEo/NVbSTTFDosXbBd8lOPow+9YgkwxYIT51zTc0vZBkwUu++Bie+csss0IPLQJnfP9RFD12+rFeAjrNv8DUku8nAcC02LaDX3iHmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5560
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090111
X-Proofpoint-ORIG-GUID: iZuVj_WW4QMJZMTycOHM7-sfLEIMx1gk
X-Proofpoint-GUID: iZuVj_WW4QMJZMTycOHM7-sfLEIMx1gk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the state of the SEV feature via the new sysfs interface. Document
the new ABI.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 .../ABI/testing/sysfs-kernel-mm-mem-encrypt   |  31 +++++
 arch/x86/mm/mem_encrypt_amd.c                 | 106 ++++++++++++++++--
 2 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt b/Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt
index a53f87f28704..68a932d4540b 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt
@@ -29,3 +29,34 @@ Description:	(Host only) Expose status of SME feature. Valid values are:
 		inactive: Secure Memory Encryption is supported, enabled, but
 		the kernel is not applying encryption bit to page table entries
 		(SME mask in kernel is zero).
+
+What:		/sys/kernel/mm/mem_encrypt/sev/status
+Date:		March 2022
+KernelVersion:	5.17
+Description:	Expose status of sev feature. Valid values are:
+
+		unsupported: Secure Encrypted Virtualization capability is not
+		supported by the processor.
+
+		enabled (Host only): Hypervisor host capable of running SEV
+		guests.
+
+		disabled (Host only): Memory encryption has been disabled by
+		System-Configuration Register (SYSCFG) MemEncryptionModeEn bit.
+
+		active (Guest only): Running in virtual machine with encrypted
+		code and data.
+
+		inactive (Guest only): Running in unencrypted virtual machine.
+
+What:		/sys/kernel/mm/mem_encrypt/sev/nr_asid_available
+Date:		March 2022
+KernelVersion:	5.17
+Description:	(Host only) Total number of ASIDs available for encrypted
+		guests. Number of encrypted guests supported simultaneously.
+
+What:		/sys/kernel/mm/mem_encrypt/sev/nr_sev_asid
+Date:		March 2022
+KernelVersion:	5.17
+Description:	(Host only) Number of ASIDs available for SEV guests with
+		SEV-ES disabled.
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index ccd6448042fe..86979e0e26c7 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -38,6 +38,7 @@
 #define AMD_CPUID_ENCRYPTED_MEM		0x8000001f
 
 #define AMD_SME_BIT			BIT(0)
+#define AMD_SEV_BIT			BIT(1)
 
 #define CC_ATTR_RO(_name) \
 	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
@@ -78,6 +79,8 @@ static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
 
 static u8 cbit_pos;
 static u32 sec_encrypt_support_mask;
+static u32 max_sev_asid;
+static u32 min_sev_asid;
 
 static inline bool is_vm(void)
 {
@@ -95,7 +98,10 @@ static void encrypted_mem_caps_init(void)
 	cpuid(AMD_CPUID_ENCRYPTED_MEM, &eax, &ebx, &ecx, &edx);
 
 	cbit_pos = ebx & 0x3f;
-	sec_encrypt_support_mask = eax & AMD_SME_BIT;
+	sec_encrypt_support_mask = eax & (AMD_SME_BIT | AMD_SEV_BIT);
+
+	max_sev_asid = ecx;
+	min_sev_asid = edx;
 }
 
 /* Verify that memory encryption capabilities are supported */
@@ -104,13 +110,7 @@ static inline bool mem_encrypt_feat_supported(u32 feat_bit)
 	return !!(sec_encrypt_support_mask & feat_bit);
 }
 
-/*
- * sysfs interface for SME/SEV.
- * Expose whether the various memory encryption capabilities are
- * supported/enabled/active.
- */
-static ssize_t status_show(struct kobject *kobj,
-				struct kobj_attribute *attr, char *buf)
+static inline ssize_t sme_status_show(char *buf)
 {
 	if (!mem_encrypt_feat_supported(AMD_SME_BIT))
 		return sysfs_emit(buf, "%s\n", "unsupported");
@@ -129,7 +129,58 @@ static ssize_t status_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%s\n",
 			!!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) ?
 			"active" : "inactive");
+}
+
+static inline ssize_t sev_status_show(u32 feat_bit, u32 feat_cap,
+					enum cc_attr encrypt_attr, char *buf)
+{
+	if (!mem_encrypt_feat_supported(feat_bit))
+		return sysfs_emit(buf, "%s\n", "unsupported");
+
+	if (!is_vm()) {
+		/*
+		 * When in a host, we can avoid reading MSR_AMD64_SYSCFG MSR to
+		 * check for MemEncryptionModeEn (bit 23) since an earlier call
+		 * to early_detect_mem_encrypt() clears the feature from the
+		 * CPU caps if the bit is not set. So it is sufficient to check
+		 * the CPU caps here.
+		 */
+		return sysfs_emit(buf, "%s\n", !!boot_cpu_has(feat_cap) ?
+				"enabled" : "disabled");
+	} else {
+		/*
+		 * When in a guest, we cannot check MemEncryptionModeEn(bit 23)
+		 * since KVM currently masks off MSR_AMD64_SYSCFG. Use the
+		 * cc_platform_has() API which uses the SEV_STATUS MSR to
+		 * determine if the feature is active.
+		 */
+		return sysfs_emit(buf, "%s\n",
+				!!cc_platform_has(encrypt_attr) ?
+				"active" : "inactive");
+	}
+}
+
+/*
+ * sysfs interface for SME/SEV.
+ * Expose whether the various memory encryption capabilities are
+ * supported/enabled/active.
+ */
+static ssize_t status_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	if (!strcmp(kobj->name, "sme")) {
+		return sme_status_show(buf);
+
+	} else if (!strcmp(kobj->name, "sev")) {
+		return sev_status_show(AMD_SEV_BIT, X86_FEATURE_SEV,
+					CC_ATTR_GUEST_MEM_ENCRYPT, buf);
+	}
 
+	/*
+	 * The checks above must cover all of the possible CoCo features that
+	 * have the status attribute.
+	 */
+	return -1;
 }
 CC_ATTR_RO(status);
 
@@ -140,6 +191,25 @@ static ssize_t c_bit_position_show(struct kobject *kobj,
 }
 CC_ATTR_RO(c_bit_position);
 
+static ssize_t nr_asid_available_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", max_sev_asid);
+}
+CC_ATTR_RO(nr_asid_available);
+
+static ssize_t nr_sev_asid_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	u32 nr_sev_asid = 0;
+
+	if (max_sev_asid)
+		nr_sev_asid = max_sev_asid - min_sev_asid + 1;
+
+	return sysfs_emit(buf, "%u\n", nr_sev_asid);
+}
+CC_ATTR_RO(nr_sev_asid);
+
 static struct attribute *sme_attrs[] = {
 	&status_attr.attr,
 	NULL,
@@ -148,14 +218,34 @@ static const struct attribute_group sme_attr_group = {
 	.attrs = sme_attrs,
 };
 
+static struct attribute *sev_host_attrs[] = {
+	&status_attr.attr,
+	&nr_asid_available_attr.attr,
+	&nr_sev_asid_attr.attr,
+	NULL,
+};
+static const struct attribute_group sev_host_attr_group = {
+	.attrs = sev_host_attrs,
+};
+
+static struct attribute *sev_guest_attrs[] = {
+	&status_attr.attr,
+	NULL,
+};
+static const struct attribute_group sev_guest_attr_group = {
+	.attrs = sev_guest_attrs,
+};
+
 /* List of features to be exposed when running as hypervisor host */
 static struct amd_cc_feature host_cc_feat_list[] = {
 	AMD_CC_FEATURE("sme", sme_attr_group, NULL),
+	AMD_CC_FEATURE("sev", sev_host_attr_group, NULL),
 	{},
 };
 
 /* List of features to be exposed when running as guest */
 static struct amd_cc_feature guest_cc_feat_list[] = {
+	AMD_CC_FEATURE("sev", sev_guest_attr_group, NULL),
 	{},
 };
 
-- 
2.34.1

