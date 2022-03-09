Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00E34D3CA9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiCIWLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbiCIWLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:11:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16836120E9E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:10:43 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229Kd9OT022976;
        Wed, 9 Mar 2022 22:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=5UTdP0HIaDKrwOQIyNmOaNJemcSZtyoVpIkXrdol39s=;
 b=BH02WDiG/16/0SdsxpityJfGXgneYJkanS64xYXyH6J9FMixKNjILwP/2QjKWEwBk9AY
 jKewEpE6wvboUW/spTDJrqDW13Lfomq8TmWedr9V/EddhK9iSxqaU2VeFQh7T8J0CVgY
 MUJDV6LP2BMTsLjCuvBnWtTxbRvW07MM2dnYqrrzozvhoxdhvXzPHQETJ5hmVECa8GKk
 +jOn1pGoKDlg8tejMh8chPZf/TXl6xRV0A0Xcp5qJSuuTA/cBheIM0+zzXcOCWMJpoRl
 NdVPL8RWr9gfwEFyZEhpRhwvTsPl88Qb8DvwTHM7LII167A7A88xf0IislP0BeadC03b Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrau1w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:10:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229M5EaQ067926;
        Wed, 9 Mar 2022 22:10:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by aserp3020.oracle.com with ESMTP id 3ekyp36srk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 22:10:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odtP8gqsbA4PhkQj9avC9Y8vpzJA82WR9diEHw4MN0/1XAl9IO4/A2eMjlMvaSx6NXxwfTO3EZSeC6meks8oAkvM70fodzap74A3n+qXJlb82ExBQRaGJ1ldHvQxScV37KVXjCslooOQrBekVVucSdc6N5pgKRm1/jhSUJr/fF/IJMPzj5awqyhfrW7YhWb4l3ymVVgjccKjv51Q0CI898a0oa1WGsOp/mif6afs3w7yUvx/fbaETwhq/mB7ThN1AjYjCTepiTdhxpenhAYQrAEByUGkDVu8F/QgM3I4HGiqSIqI95KCxu/v1YIe8SZZj/mwq7T/0SWpPHHWcic6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UTdP0HIaDKrwOQIyNmOaNJemcSZtyoVpIkXrdol39s=;
 b=hV4xhNz5uMLRWQj1TUQcX6RgJJNwnDdagggZIrMj/AVl2c12VgsgyuScBZycP4I+rDmaCIWTMkWX1k7w0OPfkC0S6AR2JcJHHIVNSLDFdqLNJ5Uz/iLDaQRrN8lnaLnq/jMjd3M5znV2TEmt1x8iW2gZfYMygyHwp51Lph9FDMLEKOUe3fQ1JK+YnOk3ciQtcJf0joZpiy1rkkDhfv2OPq2vRCXIBPEXNxrwE+iacJicfWJsHPWzEvnhNdSKWTzmSDZEzg/9rqF0DSg79m5fXtYJyfC211GvuzL/yJ3/qD3zsEznxsz6Ej6Gp6FeYb/sXdD/AMfmMlSTiQbudi3FvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UTdP0HIaDKrwOQIyNmOaNJemcSZtyoVpIkXrdol39s=;
 b=w515qnmlEqudzdOEBUdqnpImAkLFfwVOLXfCGNGCqntvLT6f+idUpHUv2JitDgvCRgjBCvx7JALVIuS/QBG+fMJ94hmfWe7GX8fu39N3QY56fZsM5Thha/SZ8JDtKb4JwlvnEUtSxDyebUz99EsYsvzlYdGuuSFm+94v1AkEzxQ=
Received: from SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19)
 by CY4PR10MB1639.namprd10.prod.outlook.com (2603:10b6:910:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 22:10:07 +0000
Received: from SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::e82a:9be1:793c:1702]) by SA1PR10MB5866.namprd10.prod.outlook.com
 ([fe80::e82a:9be1:793c:1702%4]) with mapi id 15.20.5061.021; Wed, 9 Mar 2022
 22:10:07 +0000
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
Subject: [RFC 3/3] x86: Expose SEV-ES capabilities in sysfs
Date:   Wed,  9 Mar 2022 17:06:08 -0500
Message-Id: <20220309220608.16844-4-alejandro.j.jimenez@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 49d5d547-09b9-48fb-6164-08da021991bd
X-MS-TrafficTypeDiagnostic: CY4PR10MB1639:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1639D298CF44E8D270F9D044C70A9@CY4PR10MB1639.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwHP974gR1Bpwpvz9VhGXF6yjP0MXShEbyYOUtlGYo6ekt0YDEFz+2wKJ+bw3rFxJvypPL4yL38yXUWm8K2+H9uH2Sm8UZlX0ls21AYJ3kqlg66fucNwm1TC7blbmd/yFI1Tf6oY6g3iGgeBIRftEMlzKhZC6ksJdntBWMhtG8Fkm0Dn5knt2m2ilaJWxdOfmGraoWziJRkzDByscR6mklMEaJIRDY/CUwFVD2ti2GvWTxNI2KWClEGdFM7lcpGw9tRr/rmVFb7Y+ASIXdF81KD381VNMdrwQXrhgk4rRdvii4aulIK8JpzoWcHi1IwBTii3OlR7xvoxUEtL54pjbuzenNKECXz9hpplSPQkAq7lrHqsfjWGoXiHsExXAaZ6T5dATY9OwEUlqnflxhb2DzWoTHiIfrHAVAwoE2fKOpSRKmyITpZkNFZUjgu1i/OVpxRjYyPJNquAKjZjjG+kdKRbjUaSxSwcgHptkV/UaQv8VmnQ7BLqLneT31GwSUC4abt0IDbeY3P+C4bqvbm/KbI6hFJ0ECw6Ktsm5stX1ncD/OM/gXjd5vTMHhhrr2UNkFeyDcmCQuoUsbwE9nHy/Vb0tI402RWCLEstbHxwJxPDeH5xOuAOfWvYvnaGm6Glc/9OLvtMxW6PtX78VHuP1CBh076OuzQHu8M/A2L1uxuFhNeEiqKBqAiO/WBtA7jwt+100FBIUVNFi5N+AzqSug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5866.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(4326008)(2906002)(103116003)(66476007)(66556008)(8676002)(5660300002)(1076003)(508600001)(316002)(8936002)(7416002)(38350700002)(38100700002)(52116002)(6486002)(36756003)(86362001)(186003)(107886003)(6512007)(6506007)(2616005)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sFobs9c05FXAtL4j7LcGxurHSnlie3n71K19KcRIJ29V+O1r1ES+Ds3lqg89?=
 =?us-ascii?Q?U131YgI/Zk5lR3IRfzrt2UC2MQH/gRobkIdesh+mDnURrQV48kkDmg8ar9yK?=
 =?us-ascii?Q?tELZvHqTxfebUo0L1WdMmh5Ln7dzXK5UZNy7VxVQWUbVgwwRFVJ/Pvei9ISL?=
 =?us-ascii?Q?2Fnb/haUHLYS1Hvp9eERfc+bx9xZ7kjzBa9BugzFw5XWEwZ5T9F/qNY2z7SK?=
 =?us-ascii?Q?3rN86iMWdwZ4/x8WOva8piCFi+KkCDiDvluJj/0gIDam44pGNwmdNymfF7jX?=
 =?us-ascii?Q?mNRELYzddbwIFMGdPtmwL/GmutpI2ipDdae78NSslBk6/iUuNq2iLSGldkhz?=
 =?us-ascii?Q?qg9gcWL1vzTtvdBc7bRAiIirkxEIpmWde+4YObNUp/8vcY4+w6XWv1yPPi4t?=
 =?us-ascii?Q?AkxiK0pIbPHpOGaBksfOAMybCFq3d2i+rc5hmfCCRSvJMV4RBoHunWm/D9xk?=
 =?us-ascii?Q?0N2xQ87sG2q1tRg4OnzsOo051hWZNCmGrqJubD1DKszoSudkwOVGqUIih0pP?=
 =?us-ascii?Q?+uTBaHQV8oXDFwCK0/3JZ5CBczuL/q3AbqMWnz/8hcoWZCMmQUqCLedsPr0s?=
 =?us-ascii?Q?+BR++fXJVK5mftfDkkckuI7sTwCZzB7X4kW3vn7O+ZRPQy9M8ILmJlywMG0S?=
 =?us-ascii?Q?lz6TWMem5LP/8TLHUwaACtIQAHcGkynyNw0N+I3bc0eSONv0zS8nH4L+YH+z?=
 =?us-ascii?Q?EFmlYwqahaxi8pSm/jKoxFCwYSuLr89IX2K0+19u4QvcU5KNfEg/3JNzvkKs?=
 =?us-ascii?Q?mgVR/Hq+5yD1JxZ76b5PwFM3h5ptPwkPYgvkmg5KCxDyqIqxHoIqM1lUqlX9?=
 =?us-ascii?Q?WGSGRAkgoFxzdMBeFmmBXj018SF5Igr4/Fc7Q4M/1GwR3UB9sDWtMc/Tuymx?=
 =?us-ascii?Q?lNfmyP/pR45K81UvQsIp6U/ErubXMNCKk2d9bMzOiZO2gZ+j2jWCwV65THPN?=
 =?us-ascii?Q?bi6fDOLiDWFB+zmbeCMIXMuzEDATAbvbGmuOv4FIzzXJGUWjT5htf6DWr8EU?=
 =?us-ascii?Q?z+QGywJA4yqiPDffjPUcmNCnYEtKS1ofynfEqB3VZDf3aAJwAvNC6OwhMBuy?=
 =?us-ascii?Q?s+3WwO4p3g/dvrioA7hxSd1a8RdbgC6RrwFmoqnd3eMACjCA4+sV1ZZNgqGN?=
 =?us-ascii?Q?hzgMhzbsra6S/O+xeAlONoy6RzqZiwpwfj81m0UVX9Xsco9Mwzfk/c62dOUv?=
 =?us-ascii?Q?3C1BoYbMFfJ/12bi1gF7QpATFsrRaWGE8xLfi8PEItVXuNfzqHloNIDPR8L1?=
 =?us-ascii?Q?RXgYN9dbaEaQLvs4WR/3SGBSYEDUmjRNAlWBGFodh7vmUmwQEW1J0A7cp6DL?=
 =?us-ascii?Q?n9Hahkz7R4XgdEAmOb/aGm+VrGwBKiKSeo0R0bETc31EFh+WXaZnYNy/bYHg?=
 =?us-ascii?Q?0nkXddqgO1GWbmW8HUP8PPvfOQyRYk629zdRUrchho+bY5qjSYNMLga4BSAJ?=
 =?us-ascii?Q?lOgvdW6rWBqJlsSijYqMWj03qTgtxluW2uK2yBbNvLV9CwbCLy4k79TswLj9?=
 =?us-ascii?Q?9LNe4ko/KxaiEz5dfGc/VGCunlUaaTqqX9ZWr4iIibFFme2kxKDpeudj7N6G?=
 =?us-ascii?Q?4YLuXyn5Iq9hPv/EetMe1YWzDwxzi4YqnHdkN33P9hUOAmeDEOXqtv8idc/3?=
 =?us-ascii?Q?uq770c7ol3+5/snWW10QY/MklPkkVXp/8yeuOQ0hH1x01fef4RVq6fLlZ0nw?=
 =?us-ascii?Q?qbTP0Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d5d547-09b9-48fb-6164-08da021991bd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5866.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:10:07.0297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dJ2XDyupz7HMBO4vKgr91tMo9soxZQKxH5UUbEu5OeX9nIB3+dW0SMxz328fY4hqHI6M4AncP74daRpB4loRIPl8H9fpG71TK4FFL9ZNcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1639
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090111
X-Proofpoint-GUID: 5zitXrpuhG_CzNuIAl72TDrey_IrVgM-
X-Proofpoint-ORIG-GUID: 5zitXrpuhG_CzNuIAl72TDrey_IrVgM-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the state of the SEV-ES feature via the new sysfs interface.
Document the new ABI.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 .../ABI/testing/sysfs-kernel-mm-mem-encrypt   | 28 ++++++++++++-
 arch/x86/mm/mem_encrypt_amd.c                 | 40 ++++++++++++++++++-
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt b/Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt
index 68a932d4540b..ecd491c0a7bd 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mem-encrypt
@@ -49,7 +49,7 @@ Description:	Expose status of sev feature. Valid values are:
 
 		inactive (Guest only): Running in unencrypted virtual machine.
 
-What:		/sys/kernel/mm/mem_encrypt/sev/nr_asid_available
+What:		/sys/kernel/mm/mem_encrypt/{sev,sev_es}/nr_asid_available
 Date:		March 2022
 KernelVersion:	5.17
 Description:	(Host only) Total number of ASIDs available for encrypted
@@ -60,3 +60,29 @@ Date:		March 2022
 KernelVersion:	5.17
 Description:	(Host only) Number of ASIDs available for SEV guests with
 		SEV-ES disabled.
+
+What:		/sys/kernel/mm/mem_encrypt/sev_es/status
+Date:		March 2022
+KernelVersion:	5.17
+Description:	Expose status of sev_es feature. Valid values are:
+
+		unsupported: Secure Encrypted Virtualization with Encrypted
+		State is not supported by the processor.
+
+		enabled (Host only): Hypervisor host capable of running SEV
+		guests.
+
+		disabled (Host only): Memory encryption has been disabled by
+		System-Configuration Register (SYSCFG) MemEncryptionModeEn bit.
+
+		active (Guest only): Running in virtual machine with encrypted
+		code, data, and guest register state.
+
+		inactive (Guest only): Running in virtual machine with
+		unencrypted register state.
+
+What:		/sys/kernel/mm/mem_encrypt/sev_es/nr_sev_es_asid
+Date:		March 2022
+KernelVersion:	5.17
+Description:	(Host only) Number of ASIDs available for SEV guests with SEV-
+		ES enabled.
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 86979e0e26c7..bafc34bf6121 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -39,6 +39,7 @@
 
 #define AMD_SME_BIT			BIT(0)
 #define AMD_SEV_BIT			BIT(1)
+#define AMD_SEV_ES_BIT			BIT(3)
 
 #define CC_ATTR_RO(_name) \
 	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
@@ -98,7 +99,8 @@ static void encrypted_mem_caps_init(void)
 	cpuid(AMD_CPUID_ENCRYPTED_MEM, &eax, &ebx, &ecx, &edx);
 
 	cbit_pos = ebx & 0x3f;
-	sec_encrypt_support_mask = eax & (AMD_SME_BIT | AMD_SEV_BIT);
+	sec_encrypt_support_mask = eax &
+		(AMD_SME_BIT | AMD_SEV_BIT | AMD_SEV_ES_BIT);
 
 	max_sev_asid = ecx;
 	min_sev_asid = edx;
@@ -174,6 +176,10 @@ static ssize_t status_show(struct kobject *kobj,
 	} else if (!strcmp(kobj->name, "sev")) {
 		return sev_status_show(AMD_SEV_BIT, X86_FEATURE_SEV,
 					CC_ATTR_GUEST_MEM_ENCRYPT, buf);
+
+	} else if (!strcmp(kobj->name, "sev_es")) {
+		return sev_status_show(AMD_SEV_ES_BIT, X86_FEATURE_SEV_ES,
+					CC_ATTR_GUEST_STATE_ENCRYPT, buf);
 	}
 
 	/*
@@ -210,6 +216,18 @@ static ssize_t nr_sev_asid_show(struct kobject *kobj,
 }
 CC_ATTR_RO(nr_sev_asid);
 
+static ssize_t nr_sev_es_asid_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	unsigned int nr_sev_es_asid = 0;
+
+	if (min_sev_asid)
+		nr_sev_es_asid = min_sev_asid - 1;
+
+	return sysfs_emit(buf, "%u\n", nr_sev_es_asid);
+}
+CC_ATTR_RO(nr_sev_es_asid);
+
 static struct attribute *sme_attrs[] = {
 	&status_attr.attr,
 	NULL,
@@ -236,16 +254,36 @@ static const struct attribute_group sev_guest_attr_group = {
 	.attrs = sev_guest_attrs,
 };
 
+static struct attribute *sev_es_host_attrs[] = {
+	&status_attr.attr,
+	&nr_asid_available_attr.attr,
+	&nr_sev_es_asid_attr.attr,
+	NULL,
+};
+static const struct attribute_group sev_es_host_attr_group = {
+	.attrs = sev_es_host_attrs,
+};
+
+static struct attribute *sev_es_guest_attrs[] = {
+	&status_attr.attr,
+	NULL,
+};
+static const struct attribute_group sev_es_guest_attr_group = {
+	.attrs = sev_es_guest_attrs,
+};
+
 /* List of features to be exposed when running as hypervisor host */
 static struct amd_cc_feature host_cc_feat_list[] = {
 	AMD_CC_FEATURE("sme", sme_attr_group, NULL),
 	AMD_CC_FEATURE("sev", sev_host_attr_group, NULL),
+	AMD_CC_FEATURE("sev_es", sev_es_host_attr_group, NULL),
 	{},
 };
 
 /* List of features to be exposed when running as guest */
 static struct amd_cc_feature guest_cc_feat_list[] = {
 	AMD_CC_FEATURE("sev", sev_guest_attr_group, NULL),
+	AMD_CC_FEATURE("sev_es", sev_es_guest_attr_group, NULL),
 	{},
 };
 
-- 
2.34.1

