Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B3A4A79F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347415AbiBBVCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:02:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32422 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347361AbiBBVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:02:40 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwhBL023474;
        Wed, 2 Feb 2022 21:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=mLAnDDUXlDLWaVWT/k1YEoTu1CAdHb7fa7/mXYpLt3k=;
 b=rCakxjycR7llNodPwSiQgK+dXsUZyiXC6mevP7Dx6Y1XggsdOdJga1fRXfnfrv8SpQFU
 8J1NFfqqRTPfDc+1ahdlb2Xvknok71r73h5i4et8rMzJOhBhFLDvud9KJLyHpooU8tP3
 LE84g4eDob0/9CSwEq3F71iVtecuttG8+coHQtd/bvhs0FClGeAM3GS6tB85Wt9ZlTWO
 AbldOylUD62f7A2M5U53XgbfEoboW9mtM5gIBH0mj+vNLQCaN/ur2W104yGT6VnomOdT
 m4QG8H7p1kQVTLUlfNKpw9M6hha1KNE1ewGPM0Lb4mi1BaAzMgWVEjq1sbQWISbGqR6P Mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2pxcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212L1Ejn021471;
        Wed, 2 Feb 2022 21:02:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3dvwd8xt3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl6PrtNxjVWgbVO8Qnsae4rxO4SVbvLpy9+e4RH36EnIk0Nu4RwUHHJOsccqamI1msMT2s19/DnCcR+HF7NcnPJEjYINoekuM5dnOdNCYpM8DY7ZUYpV34IsEAfReQvJ0uMrgKAfTeg3MErHo/ghQ4q24y0/mjvs9PDe3YOm8eBLGan0L7/+dXmEGczXf4Qx2pXy9euMvSAM8p0WJ8HdiKIvfOF+tEqUTzBgoTt0Utyo4ASuyvS6M6W441aRCBRJa/enPJ594Rch4vhMR31eVjkJqihfvNcZ9FqIpWlzfVhqjsWjUjytMK/ccw+uWAVwVsj3r27q3eHFQsOwggphFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLAnDDUXlDLWaVWT/k1YEoTu1CAdHb7fa7/mXYpLt3k=;
 b=NlAcZO/GZ9ED2bEla/bxyYtrOMv6Y+zulydi2iJKTCu8cTPDWUX+IJEt8mm1IZXZCCfnaJaHC6iSgvV8JthlYfUBWJevNXLtlm8jh2c9tm8Eorjt2RLekOUR57YF+XzN8yA4ah5RoC9LOrZ1X1brLfQ3mb6T7ydqC56y9g4TJhAQtXhWFs9Rwyq2iTqMGkcOcEZP7aTlayLHD5txSW3LeSuOWDKjG4ch2f5SIj2WEGyfkY+AbLQfSOyrzEs3MYwnYh5xYfggaVZ9DKvzvnW0ZX8HGYF2c5IzcZ1fpikbML+sZ7f0ksWp4W0PiOob4PMbhcwWvFX0cL4aGk3ZYpJZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLAnDDUXlDLWaVWT/k1YEoTu1CAdHb7fa7/mXYpLt3k=;
 b=ExvFJKgpJhBBsDPwlqDKU+hmk31L0gOajc6KN/KPEW0JBzW3oaw/+YJTX2mOsEQkg8z424eHd0nfX1hCwjCCfoVn+72R/YOZgnDczwzdVKuladxAdiuIIXtEJfNnl3rcTw6c9iYaBk2ZPDW3ktDQQcmLluyB2AlenwoPWNs245w=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4014.namprd10.prod.outlook.com (2603:10b6:208:182::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 21:02:11 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:02:11 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 2/8] fork/vm: Move common PF_IO_WORKER behavior to new flag
Date:   Wed,  2 Feb 2022 15:01:54 -0600
Message-Id: <20220202210200.5235-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202210200.5235-1-michael.christie@oracle.com>
References: <20220202210200.5235-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:8:57::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aad4c17-4915-4e4d-02d0-08d9e68f4756
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4014002004B1D356BC3DB4F5F1279@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjdhFkuErrVuDRbhxc405gY+iH1ICZPMgqekRxArsSkyltyItNCGXSh+uF2EQwe+2qAPaHqWNaT5WW+i8z2XUCC4dCpBFcTTL0G2kmoXqZg8onM2MJ7dsHB2GzgbV/rXB9rU7YZzvz74rhDHGwPhvLO3BldN/RxZlB2fdQueCq3TmWunLXusAYY+6kslqqCNexJ0lRiZ2/gvmmdqZYsVUBOSS+2Z1aoXbEfJrLiaZfu0LQFPOJyXmldc3TwFV8byS8azss0KmYNF+n9CO7YkG4zoyoEL7qplJTNH8rw68tdy6/VCC934Mow/of/bgz1lx5AZcACRjh6qLhRd80b+SsEbGm7HdDWzBPvP/90UqB2hjElgw7WdLkH+ebtwTDM2vzhfn5OO1Ufa/nMMFFqZxWPIBWea60VcC+mtTppqAaC8wizh+uU22seGAGGqYqWI3pTOhngfYIBNz+GgOpG4E82Kjt3PaOXbqLxVcbMmCtagsp9hULTSD/Fmwrvf564cpAtwD+IqHDbZ8cCHyXm6jeHvfA5QAfqD3U8p73yvHxxBBNWAYhrAy9CxIdFYnqqE9T+ZDxx1d0FsCGspxNRHaMPXXMHQf1FWTJdG2Jk+RisZuuh56zF0Tdc7gBzT69xihqatVVoGugDAtun0zP/A3mIcQiPi1QPZOSlBrlyD/J3lzR41s7wXCi0V2+5ptiBcTZp+zpW3dtyCK4OFGD2Lcn3u03jyoTl9A51QO8aum/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(2906002)(107886003)(316002)(38100700002)(1076003)(38350700002)(5660300002)(186003)(26005)(30864003)(2616005)(66556008)(4326008)(66476007)(7416002)(6506007)(66946007)(8676002)(52116002)(921005)(6486002)(8936002)(508600001)(6512007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vX0Qj+OwVMZkt1oPCa0jhU6OknbZDHGSwzNHbPu9bpiRZf8/nSccH7F0SP26?=
 =?us-ascii?Q?KB/XeFkU0Z/iziRwThhNgwQONQaFH3cCNbokpw+k2kPIHNS9l42Bfv41XZka?=
 =?us-ascii?Q?SrdV3I4Uxl5bF/ebSil6P7s+Iq9SxWAswCmxNsw3cf7t15X6MIJrcRpQVO75?=
 =?us-ascii?Q?n2FE0ejiyUp+bHbge/BKSQy8iAnnJrAXCA1pun+WUJpiEffHvdBcQnVoYx8+?=
 =?us-ascii?Q?dCwGMFuWRkqFSNSFzr8DwBcmad42/RuAKQLMb+W4aQ59n+zaNYiQjNennQ/1?=
 =?us-ascii?Q?jMi8wA/VgPz4jWvrfPXFzsCG/c9ndQmJwRFzAbNiSFkYvWqL9MbhjEHkBRDD?=
 =?us-ascii?Q?l/THZs+6lTRJJfu+AdVd+xVqK0FJWnaI5Oh2XoWeowsnpyEYdUJpXWGENWk2?=
 =?us-ascii?Q?BhZaxSlRqIL59M7jb3AozBkoi5MNsLdJ/a2U4N8EGbmYXRisSgh+eHrmODkv?=
 =?us-ascii?Q?OBCAnelqC9FcPlIaY3ekhfSmy+dKjHj9Mt+ZAbf7DUKWuvH6yqXhbNfZJ6ZU?=
 =?us-ascii?Q?FLjOjID/GslfRjy0cq2/aH2nZXwsgc94z2Dk8l86uLOBQx70p29ybvkPN6HJ?=
 =?us-ascii?Q?yvKPaCP22r36Zj2gdpQ0puwb8IazjQ3DNRIB5hvIud8VkoXtwhdOAjzDuVrF?=
 =?us-ascii?Q?nGeaVKAOXNVB465bZ+bLobHP9l/ZA+MiJj80Mqr7JdAYunqzccbE9/ZEReee?=
 =?us-ascii?Q?wU7mWQn6PnjX+ZfQrpMJKOuycbacHRhMrQeakPm35mGE5NEygGkJDBwFwOtj?=
 =?us-ascii?Q?sNwgbm+XnRUcTken+uyV0wXVDSJHcAA1CBO8gb/Y1qwbNitAYzwLI81fNhek?=
 =?us-ascii?Q?jW/6pnAUe3QObmgc0zmFHPuH7erzfZ4CnJjy9Gl5o/yg6apN6V5VrLq+XFOT?=
 =?us-ascii?Q?ANj8BR5WUbOXTrhCqn678ijmWYoFENocPAnuUp4IN9VPzoZJgh1a8ZmEndsI?=
 =?us-ascii?Q?STZ+GjTRpfKIXqxRkXLPADmM3OAQWD02K3+rC/2Uj4uoq3MI2NyLQriTexK/?=
 =?us-ascii?Q?VUDDfTzHaEjqJUhI8pyKiU5ayezVVO+GLKcHsUkOrIL1pTnWBhqae1y9P2q1?=
 =?us-ascii?Q?/XlTmInQ2HefVdac/vLnWIXMih1vmWRqrppy4huMFQiPOpO9XPJ0p4oloval?=
 =?us-ascii?Q?+NyWEyzYUO0JHV8KmxyGY7ti9NOUrbRMfog1qsMKuLSWCVdYtXMZgthnHAfI?=
 =?us-ascii?Q?Yk6P5kaqjjFCMZOxB7fpXcO8HRtTSDq6xAIB7NIHAjEnKSyElVqNo/7UNTKy?=
 =?us-ascii?Q?aXRMgwA8+Y48m0gV0169Bz45dMA3QXhJXzLtrqbjfXQTm9DR0oXey+DJxvVp?=
 =?us-ascii?Q?7coI50IWZv3/PgvMnCVt3EcqpYS7cuk82YzpmKGISh7MfIuTh3WMezUAzL/W?=
 =?us-ascii?Q?jMWNqIskzVGG1wPQl+/JnbqFpRc84/HyUPiw0p/GsRS7/qlOEKGHLCWWNPye?=
 =?us-ascii?Q?hvb7oGqPZz7YeJozmCzqt2lhHDWdvClD5gfkCmgrZsznEEkABb5YisMOQ9pr?=
 =?us-ascii?Q?8DaVMP9uPfRLf0O1r0nYpe47x49mFN33ApFmHtRuOcKzWDI3p54XvEuEun38?=
 =?us-ascii?Q?ZgGdkMKsIqoVrqtfW8HQl773pgVysW0zI1oOE/7FmnasVEI45qi3Y3SlaEru?=
 =?us-ascii?Q?uIuvuq7fWvG2bf5mtc0tbP3riaPKHcyFjm66Y0AXLGCJU02+tsazhhnHT7as?=
 =?us-ascii?Q?uhwofA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aad4c17-4915-4e4d-02d0-08d9e68f4756
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:02:10.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PYuttFNMC0XnRSPIoHPnaF4MmFBwMZSyTpi1wbEuu4ZQbiECyjbi8o+phs3aQthKdkRP4vx53UwdQCsw4d7RUd6hUo7PqiC/v9nt4qgXXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020115
X-Proofpoint-GUID: Jj1_8KcT7FzABhrbFpWBiTypMEi0Odue
X-Proofpoint-ORIG-GUID: Jj1_8KcT7FzABhrbFpWBiTypMEi0Odue
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new flag, PF_USER_WORKER, that's used for behavior common to
to both PF_IO_WORKER and users like vhost which will use a new helper
instead of create_io_thread because they require different behavior.

The common behavior PF_USER_WORKER covers is the initial frame and fpu
setup and the vm reclaim handling.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
[For m68k changes]
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/alpha/kernel/process.c      | 2 +-
 arch/arc/kernel/process.c        | 2 +-
 arch/arm/kernel/process.c        | 2 +-
 arch/arm64/kernel/process.c      | 2 +-
 arch/csky/kernel/process.c       | 2 +-
 arch/h8300/kernel/process.c      | 2 +-
 arch/hexagon/kernel/process.c    | 2 +-
 arch/ia64/kernel/process.c       | 2 +-
 arch/m68k/kernel/process.c       | 2 +-
 arch/microblaze/kernel/process.c | 2 +-
 arch/mips/kernel/process.c       | 2 +-
 arch/nds32/kernel/process.c      | 2 +-
 arch/nios2/kernel/process.c      | 2 +-
 arch/openrisc/kernel/process.c   | 2 +-
 arch/parisc/kernel/process.c     | 2 +-
 arch/powerpc/kernel/process.c    | 2 +-
 arch/riscv/kernel/process.c      | 2 +-
 arch/s390/kernel/process.c       | 2 +-
 arch/sh/kernel/process_32.c      | 2 +-
 arch/sparc/kernel/process_32.c   | 2 +-
 arch/sparc/kernel/process_64.c   | 2 +-
 arch/um/kernel/process.c         | 2 +-
 arch/x86/kernel/fpu/core.c       | 4 ++--
 arch/x86/kernel/process.c        | 2 +-
 arch/xtensa/kernel/process.c     | 2 +-
 include/linux/sched.h            | 1 +
 include/linux/sched/task.h       | 3 ++-
 kernel/fork.c                    | 6 +++++-
 mm/vmscan.c                      | 4 ++--
 29 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 5f8527081da9..f4759e4ee4a9 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -249,7 +249,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childti->pcb.ksp = (unsigned long) childstack;
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 8e90052f6f05..b409ecb1407f 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -191,7 +191,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childksp[0] = 0;			/* fp */
 	childksp[1] = (unsigned long)ret_from_fork; /* blink */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(c_regs, 0, sizeof(struct pt_regs));
 
 		c_callee->r13 = kthread_arg;
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d47159f3791c..44603062d661 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -251,7 +251,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	thread->cpu_domain = get_domain();
 #endif
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
 		if (stack_start)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 5369e649fa79..2528fb9650ef 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -334,7 +334,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	ptrauth_thread_init_kernel(p);
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
 
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 3d0ca22cd0e2..509f2bfe4ace 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -49,7 +49,7 @@ int copy_thread(unsigned long clone_flags,
 	/* setup thread.sp for switch_to !!! */
 	p->thread.sp = (unsigned long)childstack;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childstack->r15 = (unsigned long) ret_from_kernel_thread;
 		childstack->r10 = kthread_arg;
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 8833fa4f5d51..050aca44ba6d 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -112,7 +112,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->retpc = (unsigned long) ret_from_kernel_thread;
 		childregs->er4 = topstk; /* arg */
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 232dfd8956aa..40f8294c6c7c 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -73,7 +73,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 						    sizeof(*ss));
 	ss->lr = (unsigned long)ret_from_fork;
 	p->thread.switch_sp = ss;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
 		ss->r24 = usp;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 834df24a88f1..29015ebdcf1d 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -338,7 +338,7 @@ copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
 
 	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		if (unlikely(!user_stack_base)) {
 			/* fork_idle() called us */
 			return 0;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index a6030dbaa089..cbb693012b5e 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	 */
 	p->thread.fc = USER_DATA;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(frame, 0, sizeof(struct fork_frame));
 		frame->regs.sr = PS_S;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 5e2b91c1e8ce..de1da9900f7e 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -59,7 +59,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* if we're creating a new kernel thread then just zeroing all
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index cbff1b974f88..6f1ed337cd41 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -120,7 +120,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = (read_c0_status() & ~(ST0_CU2|ST0_CU1)) | ST0_KERNEL_CUMASK;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 49fab9e39cbf..dba91dd1e289 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -156,7 +156,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* kernel thread fn */
 		p->thread.cpu_context.r6 = stack_start;
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index f8ea522a1588..eabf3452e5e2 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -109,7 +109,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct switch_stack *childstack =
 		((struct switch_stack *)childregs) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c0c91bcdcba..aa110383cfa1 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -172,7 +172,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *)sp;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(kregs, 0, sizeof(struct pt_regs));
 		kregs->gpr[20] = usp; /* fn, kernel thread */
 		kregs->gpr[22] = arg;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index ea3d83b6fb62..a76120e30eb4 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -197,7 +197,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	extern void * const ret_from_kernel_thread;
 	extern void * const child_return;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(cregs, 0, sizeof(struct pt_regs));
 		if (!usp) /* idle thread */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 984813a4d5dc..02f91fcc1417 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1736,7 +1736,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..8deeb94eb51e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -125,7 +125,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	/* p->thread holds context to be restored by __switch_to() */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gp = gp_in_global;
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 71d86f73b02c..51169bb351d4 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -130,7 +130,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	frame->sf.gprs[9] = (unsigned long)frame;
 
 	/* Store access registers to kernel stack of new process. */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 1c28e3cddb60..0506a739b0a8 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -114,7 +114,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 
 	childregs = task_pt_regs(p);
 	p->thread.sp = (unsigned long) childregs;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
 		childregs->regs[4] = arg;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 2dc0bf9fe62e..5386e56b5e6c 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -296,7 +296,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	ti->ksp = (unsigned long) new_stack;
 	p->thread.kregs = childregs;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index f5b2cac8669f..6058b3966f71 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -594,7 +594,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 				       sizeof(struct sparc_stackf));
 	t->fpsaved[0] = 0;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 4a420778ed87..25dd496fd820 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -158,7 +158,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct * p, unsigned long tls)
 {
 	void (*handler)(void);
-	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
+	int kthread = current->flags & (PF_KTHREAD | PF_USER_WORKER);
 	int ret = 0;
 
 	p->thread = (struct thread_struct) INIT_THREAD;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8dea01ffc5c1..c5b34fa8bb0c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -579,10 +579,10 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
 
 	/*
-	 * No FPU state inheritance for kernel threads and IO
+	 * No FPU state inheritance for kernel threads and user
 	 * worker threads.
 	 */
-	if (dst->flags & (PF_KTHREAD | PF_IO_WORKER)) {
+	if (dst->flags & (PF_KTHREAD | PF_USER_WORKER)) {
 		/* Clear out the minimal state */
 		memcpy(&dst_fpu->fpstate->regs, &init_fpstate.regs,
 		       init_fpstate_copy_size());
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 81d8ef036637..b0e58fe55b31 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -195,7 +195,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
-	if (unlikely(p->flags & PF_IO_WORKER)) {
+	if (unlikely(p->flags & PF_USER_WORKER)) {
 		/*
 		 * An IO thread is a user space thread, but it doesn't
 		 * return to ret_after_fork().
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index bd80df890b1e..00d81668ead4 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -224,7 +224,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 #error Unsupported Xtensa ABI
 #endif
 
-	if (!(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (!(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long usp = usp_thread_fn ?
 			usp_thread_fn : regs->areg[1];
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f5b2be39a78c..1a749940cfde 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1691,6 +1691,7 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_USER_WORKER		0x01000000	/* Kernel thread cloned from userspace thread */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0bf95966ae7d..0467b3ce1c94 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -18,7 +18,8 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
-#define USER_WORKER_IO		BIT(0)
+#define USER_WORKER		BIT(0)
+#define USER_WORKER_IO		BIT(1)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 9273fd81a329..1f6e7184b31f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1998,6 +1998,10 @@ static __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
+
+	if (args->worker_flags & USER_WORKER)
+		p->flags |= PF_USER_WORKER;
+
 	if (args->worker_flags & USER_WORKER_IO) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
@@ -2497,7 +2501,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
-		.worker_flags	= USER_WORKER_IO,
+		.worker_flags	= USER_WORKER | USER_WORKER_IO,
 	};
 
 	return copy_process(NULL, 0, node, &args);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 090bfb605ecf..bb85b454ff07 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1061,12 +1061,12 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	DEFINE_WAIT(wait);
 
 	/*
-	 * Do not throttle IO workers, kthreads other than kswapd or
+	 * Do not throttle user workers, kthreads other than kswapd or
 	 * workqueues. They may be required for reclaim to make
 	 * forward progress (e.g. journalling workqueues or kthreads).
 	 */
 	if (!current_is_kswapd() &&
-	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
+	    current->flags & (PF_USER_WORKER|PF_KTHREAD))
 		return;
 
 	/*
-- 
2.25.1

