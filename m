Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331744C3827
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiBXVwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiBXVwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:52:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34393FBCA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:51:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OKTJw1007900;
        Thu, 24 Feb 2022 21:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=gZipOVj0ANJPBHydjW1hu0Ub3HQQYNC8CTUA2epZ4yg=;
 b=LKsFrBywcYkIupuzDdezEZEYmJxF89dxe03CiVpuTvSA2XSYqRuugG8+g6Q523wVN6oD
 dFBIXKwmpvFIcZ4B29ysQBy1UTxRlqM3lyT5RFK8sTmcnQMXFBr7pRz7r5cQCG1dxgk+
 n8f1/3tk2JhZd+NUdIP73+8jbE9lWKXVLd/KJ6u3RilTRC7Rf1cGR/NmzcpvqRyQZQ9N
 eospycghK4Frs7FdVvhnQF7AFYo4hpLoTLHLVu14yl0TeoAUhV3dMVhKghu1X1VDgtNI
 CSCbyMCBOmBIiwsiKm/pPHGh4EW69pDhjBuQwsqGJPh3t4gaSY5r+7u6gAHWb3d1jCgJ kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecv6f0jka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 21:51:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OLexQh004512;
        Thu, 24 Feb 2022 21:51:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3030.oracle.com with ESMTP id 3eapkkvqpr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 21:51:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkgE1SjfwRbvJL3MQxLCHAqcCRB4o78p8vJ6s4+/HkU6u7/1bJYF8yFFtjYLkPjtJpTP120sCp81UzRfdX507m4PEODNl/0hZaOj7yGO+9mkbiK2Bbt4AmPQ30WIIdlkum9pNIOwoa6+eYZxdmCUvPswSrtWtsrdMwiBLembYZdlmerc8ivt4xGulMwW3FAH1v+duEM0qipYSMsoGw7RArcdEmuw/Xxbkv9CjHcUeXGrdQyTR68A8SjdKSdotMsp9akNkvAhB558xeLcxz3eGfErcUpDJoWKgQCOiT5f2/loaHbxr19xZSOdPSp/FVPJfwnce7IuNFozuNOGqQ0Jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZipOVj0ANJPBHydjW1hu0Ub3HQQYNC8CTUA2epZ4yg=;
 b=I66/Lw5Npf4r55R4d/s+m0V+iX/0MNLsioOrKDSwzzg51r+sO8ijhX5YK2DpIM6qm3geUq5i/eAXyROKRElhglA7ROamebZO1LkpLl4uQrim5v68ajD5pT3rrM31rGrt5QvyBnrTuHjr7b/n9RR5qlLjBvMm2hzNl+GFqfHRuVBEX1yEi5gm1HkqoV+hZNLFXxWCP6C7FzBABclZfYyG0NIMUa9HAz+Sxm123eFTv4X2DdNWewb4job+SbPF6uW2tbLOxdChlHX+v6Ll+2n9mZtEt4WuuEr3N/gDDde+b7bXRSQOiarnQPD94kUH4Usz2CJZiRoGAtTRLvkIy+cnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZipOVj0ANJPBHydjW1hu0Ub3HQQYNC8CTUA2epZ4yg=;
 b=rq/waDtXqD83I1LO13s/dAe4rfd2+WEYrqAIA+MfrfPXjYA0GVcXf9tmalQjqZtT8FZ9hNqyMAZ7qEXUNE2pPDs37wD22SyTeyAA9DgvUZSI4C4kckszH6AkXEKKNYIjGaO1Z1oWQLKso0s2hsW91CpHENHa9r04OEhq1UR5XRM=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BN6PR10MB2020.namprd10.prod.outlook.com (2603:10b6:404:100::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 21:51:07 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 21:51:07 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, joe.jin@oracle.com
Subject: [PATCH v3 1/1] xen: delay xen_hvm_init_time_ops() to xen_hvm_smp_prepare_boot_cpu()
Date:   Thu, 24 Feb 2022 13:50:49 -0800
Message-Id: <20220224215049.2845-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224215049.2845-1-dongli.zhang@oracle.com>
References: <20220224215049.2845-1-dongli.zhang@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:806:24::14) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8445e2c-1374-4bf2-db86-08d9f7dfc2df
X-MS-TrafficTypeDiagnostic: BN6PR10MB2020:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB20206C612A8AB50F350C1864F03D9@BN6PR10MB2020.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRXsgfu+6kOdFwQr4GnMkUFNLEfkfLkpwTDvc15SHB/c1DwRU5yxgQBtyjOnk06BiADoJwHQGqzDDPPk+wOAn4w9oRQTR2nDY5Zi7BSjlEYkOORUi1GEx6UkuIQ6RMmB21TduZwqFqsO2ulORB99Bu7AmhjvwJYieU9HQzwsX2GU8VUlNy7XanXPwuevvtocgZgMM5jcoX6IaceTWj5TFAbMv+OCNUQZU2JtsQE1cN7A2whUGqw8QFWmilfdDm5yU0KOg7CzaFdDoVgEyjyIjHvujqhuj3eDLqT/ffce1gEQ34ygEDM58kIPBpBj57ikdkqwVB/pJrAumu6IsPbY19hRkJViJV0BprwVJUaogaYSjkY8E04APQ+jNbMHAuDOGQNB+ntK5mEAgTPj2a83PsIFzloI8sFvtFWz3DeYPB0urr4/H1CizMgpCJX4z1RTj9G0zHiXIVuPGgXlR06wLEh8e1xoQWhQMjX4RosswJJrFPZ2u2/vRBcUOLYTEalxX+af4pRzyPya2KBxxpnsDxwBFGcxBrg2n7J0XR6kpOorNFoCLTTDP4BpNE9rSmiIB3tFL9XTWXGrH1O4pRzaBNZWg4MKMl64B851hKJ9bj4NWw3dviSJ0xghR53ddJlVq/6HKqD6JwHVBjE9FftwsOe4eJQ9Gd5BHN6cbzEw9XZtxrRcMDXZP9AgLnO4Fn9jMQYXVMDHn28STeX90YD9Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(44832011)(36756003)(86362001)(2906002)(6512007)(107886003)(186003)(8936002)(2616005)(6506007)(26005)(7416002)(6486002)(5660300002)(8676002)(66556008)(508600001)(52116002)(83380400001)(66946007)(4326008)(66476007)(6666004)(38100700002)(38350700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fmhClmG7FvRl2yXHDfiCpmHBSHxiELkPoJe9eVuk2XeOHyf/13rtSzuLVy9+?=
 =?us-ascii?Q?K7Sxc2i16zN6bCOwHXdzhCUcTrnMdnRp+sH4XnIfR0XzKfVRpzhpx+S/MY3K?=
 =?us-ascii?Q?20ALkBD/F7jjGLmI6E+kC7z/FTECleJYcFgm6KEfM4skk7jOuH4uqEzxeY81?=
 =?us-ascii?Q?7A9y43ViR0RSfq7q7KBZ8paEnYzciBL0Q+RUH5GWggUulOjEilFN7iWSpqu9?=
 =?us-ascii?Q?cNHYD/S7MNYwYrLRWxg5AzN473EsVgKyAPCc2lfHdmSdEawKDtIXXEH3SW6+?=
 =?us-ascii?Q?9cLKIvHfQw/1LmWnb1kTbrLYkaqn2KAlIK+vLV4fv+RaCC1zg1Pn3Pd+droW?=
 =?us-ascii?Q?uOrGv8Wt6GRDhy4v2HiprQultXWovpwLKnozCvQ/Zr0E19l5O70XhuRR27MD?=
 =?us-ascii?Q?lVsALbquPgcLnfc60CnCDU3MLXi7k05r63mnBUL+RiAC8T3pcGFxoNiHO0CK?=
 =?us-ascii?Q?RTtfAqdLfc3M6qgzif3OfAR20a0JK4rgU3Dk80bZOxUNoXO+c8h4cYJpkgqy?=
 =?us-ascii?Q?Bt/C8jL483cRnwIJsUlb8jzFoxIieWXTrBqKsZ1nAtSYfG+Z5NDj0P0IFJUq?=
 =?us-ascii?Q?IyanYqWGw9Lk3+XIV3+I0K+DY69RUH8Vf5C9koX5gJq1oQCMfMLKQ5YPFvbU?=
 =?us-ascii?Q?0TlByS5mL8VY4FILhpcc5YSEOlGKyJSv7BNpXIabZOKxoQ9+NZYJeOcUKwR9?=
 =?us-ascii?Q?iDJjrcMT5jGdF9kTWfgvIk6wMpqyKdFlfP3s3bwB8WCzhRZdPCz+cbPA7BFb?=
 =?us-ascii?Q?t2PbaJqjWD/U2DiMB4wfNxf24jOa2CiUH18F2sUp4oWolE8zRdqdmpibtcMA?=
 =?us-ascii?Q?qfamQeGnLLs6MIr9aZejjDlwnyu0qZS4L4JvICscWkwEmc+CZEKpC9/kCbQm?=
 =?us-ascii?Q?5C/2N8EEfyjaTHfWudN2jxTA/4GVi8xrFHq+9hfKX7fog62MbnF4Gga99jnc?=
 =?us-ascii?Q?oaqokLjBkDBsUsIHbDiIFUU6JzjCuSkZqHl+dZ62FAhJc60VLl9Ul5SvzmXV?=
 =?us-ascii?Q?RotEg3shfvun1G3M2nPbkT3H5nOEvMGeB0R98jhTAqCIEdnvt33GYGwMaKsU?=
 =?us-ascii?Q?J1lTtlcGpuGigWelNI7KioOn0A0o7Ap1IwCRxB0wa1QeGu0f1UG42L4i1+zV?=
 =?us-ascii?Q?U4YTLFAtUrBIMOQANblWCfcICwgWN8dzfB+2bjmuEij06DVECsLV/E0zwIv3?=
 =?us-ascii?Q?pHWVQc7W1FbMBuGMF1veFv48CH1DKCSREKfySeh9uSjtc91zoVgk2yUJ4zzb?=
 =?us-ascii?Q?FMlWI7aafMB5+nDOX+sH0bHXLuvNJUC19lkTW6jlb4f8/uYxFw8WDf8REGnz?=
 =?us-ascii?Q?ib9ulbFQq48ViLAcY55cZ7P926SZDWn8sCVXBCx5K5LiIHwptiMEpDm8ZfdM?=
 =?us-ascii?Q?aECSXyeRbsfiZe5MXeMmao2LAufPr6AlDm4tNzlYrEVetTWEggWL7l/gpuCD?=
 =?us-ascii?Q?Z6wHKgvnzY1BzhJoKEHzmmcbyEV3y+UQgYtUiyUK0n2FTwTmslc14mMjSd6Z?=
 =?us-ascii?Q?17gtUdBkSCZbzfMuFi5AUGuodpwnKSqObGoFT7hyuiN35q0CAOlFiFlbsX72?=
 =?us-ascii?Q?5f5gbtVF/ggm12kj1tMYR14XyyGntSaYYiBIpFQPuy8pqhYZ49Ohq98AM5+j?=
 =?us-ascii?Q?L/uUyEoPzAdn/7CmHotxUpA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8445e2c-1374-4bf2-db86-08d9f7dfc2df
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 21:51:07.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCNov6F9Ke5ya3RnB+oXMMm2Vqc2KZpsstQ7/hTcKQE7sMVs/u6tV4zyaUVNcHPSKZq7LGYV4EgZg59AzGqjxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB2020
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240120
X-Proofpoint-GUID: 4eWe7zao_OZm0IANtyUSQ9-DZBBJPrEh
X-Proofpoint-ORIG-GUID: 4eWe7zao_OZm0IANtyUSQ9-DZBBJPrEh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sched_clock() can be used very early since commit 857baa87b642
("sched/clock: Enable sched clock early"). In addition, with commit
38669ba205d1 ("x86/xen/time: Output xen sched_clock time from 0"), kdump
kernel in Xen HVM guest may panic at very early stage when accessing
&__this_cpu_read(xen_vcpu)->time as in below:

setup_arch()
 -> init_hypervisor_platform()
     -> x86_init.hyper.init_platform = xen_hvm_guest_init()
         -> xen_hvm_init_time_ops()
             -> xen_clocksource_read()
                 -> src = &__this_cpu_read(xen_vcpu)->time;

This is because Xen HVM supports at most MAX_VIRT_CPUS=32 'vcpu_info'
embedded inside 'shared_info' during early stage until xen_vcpu_setup() is
used to allocate/relocate 'vcpu_info' for boot cpu at arbitrary address.

However, when Xen HVM guest panic on vcpu >= 32, since
xen_vcpu_info_reset(0) would set per_cpu(xen_vcpu, cpu) = NULL when
vcpu >= 32, xen_clocksource_read() on vcpu >= 32 would panic.

This patch always delays xen_hvm_init_time_ops() to later in
xen_hvm_smp_prepare_boot_cpu() after the 'vcpu_info' for boot vcpu is
registered.

This issue can be reproduced on purpose via below command at the guest
side when kdump/kexec is enabled:

"taskset -c 33 echo c > /proc/sysrq-trigger"

Unfortunately, the 'soft_reset' (kexec) does not work with mainline xen
version so that I can test this patch only with HVM guest on old xen
hypervisor where 'soft_reset' is working. The bugfix for PVM is not
implemented due to the lack of testing environment.

Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1:
  - Add commit message to explain why xen_hvm_init_time_ops() is delayed
    for any vcpus. (Suggested by Boris Ostrovsky)
  - Add a comment in xen_hvm_smp_prepare_boot_cpu() referencing the related
    code in xen_hvm_guest_init(). (suggested by Juergen Gross)
Changed since v2:
  - Delay for all VCPUs. (Suggested by Boris Ostrovsky)
  - Add commit message that why PVM is not supported by this patch
  - Test if kexec/kdump works with mainline xen (HVM and PVM)

 arch/x86/xen/enlighten_hvm.c |  1 -
 arch/x86/xen/smp_hvm.c       | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 517a9d8d8f94..53f306ec1d3b 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -216,7 +216,6 @@ static void __init xen_hvm_guest_init(void)
 	WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_hvm, xen_cpu_dead_hvm));
 	xen_unplug_emulated_devices();
 	x86_init.irqs.intr_init = xen_init_IRQ;
-	xen_hvm_init_time_ops();
 	xen_hvm_init_mmu_ops();
 
 #ifdef CONFIG_KEXEC_CORE
diff --git a/arch/x86/xen/smp_hvm.c b/arch/x86/xen/smp_hvm.c
index 6ff3c887e0b9..9a5efc1a1633 100644
--- a/arch/x86/xen/smp_hvm.c
+++ b/arch/x86/xen/smp_hvm.c
@@ -19,6 +19,23 @@ static void __init xen_hvm_smp_prepare_boot_cpu(void)
 	 */
 	xen_vcpu_setup(0);
 
+	/*
+	 * xen_hvm_init_time_ops() used to be called at very early stage
+	 * by xen_hvm_guest_init(). While only MAX_VIRT_CPUS 'vcpu_info'
+	 * are embedded inside 'shared_info', the VM would use them until
+	 * xen_vcpu_setup() is used to allocate/relocate them at arbitrary
+	 * address.
+	 *
+	 * However, when Xen HVM guest boots on vcpu >= MAX_VIRT_CPUS
+	 * (e.g., kexec kernel), per_cpu(xen_vcpu, cpu) is NULL at early
+	 * stage. To access per_cpu(xen_vcpu, cpu) via
+	 * xen_clocksource_read() would panic the kernel.
+	 *
+	 * Therefore we always delay xen_hvm_init_time_ops() to
+	 * xen_hvm_smp_prepare_boot_cpu() to avoid the panic.
+	 */
+	xen_hvm_init_time_ops();
+
 	/*
 	 * The alternative logic (which patches the unlock/lock) runs before
 	 * the smp bootup up code is activated. Hence we need to set this up
-- 
2.17.1

