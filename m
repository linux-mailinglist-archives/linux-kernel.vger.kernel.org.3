Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DF84AFDE8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiBIT7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:59:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiBIT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:59:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3FCE04AAFD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:59:27 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HL8uh013515;
        Wed, 9 Feb 2022 19:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=2Udk0cxklejMoIZNmK3NUQ3ADxvjgbDaJaMdjq9Qq/o=;
 b=RPMPldQWGZ3ePjahH1KuV4Fv2WyyJl7Iz2HGvZYYdk4berA78slIOnAz1061X+Q1lUlc
 3cTe1loTtZtGdkAfct5jLCX3JtYuhKFKTKb2MEK+W+t9kqA7JgqGG55+Hey0Zd4vRG2b
 SRXIlukCxc5d/QUJ5ia/s9hdyZ6O2spjM5TeDfh2sT7SqeKKNvqV3JGKtvRaldcndPQ8
 8jW00nhfVSpuOvH60i97A1Fu8qFkB2HGfgKFTbtT44mPEsUmqtEUw5rXakqIh9Jer2jM
 si8av4TBOKKqHHJPvQbhON8hGvip49NAuuBoRlEbP+wGZuW41jN/9iYoCG5mD4S6dUKY pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345sqkgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219JtqrX046251;
        Wed, 9 Feb 2022 19:57:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3e1ec3b0ku-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVGtgVOAfgoJvFRgDwiQo2FvX9W424BJjZeeNSTDzbS8QNzX0MuTlxmcpQQWNU8LEg3dMCskhvXcEHT6vv384/WLWuBNakhTJBCc/yeBdK+KgH6HfiqCp9VMz5D1jPJNY81bhnOuz0pBUnY4nq9j9K1XyctccavvWIECtwAZqtQsIeey4PlzySoNByPF31y1W1xZNbdXR+KDJONyP/+Qm0Ogph9HhFusUrGs41KynNkYvlk0PlowRQwBX8eMfWt87NdlyBQXnWojsF8zqj39E7jbYN6DKEyXxv2FuQDFn1RdyZxBguQPAgUgX2AvLkNhYPCG5zuTpUKI92xHsSBH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Udk0cxklejMoIZNmK3NUQ3ADxvjgbDaJaMdjq9Qq/o=;
 b=mqExqE6Fet9QN/9J4KI47TiR+eQ+a3kReki/6pS3rQIeTrAFVz1IflDf2mUTb6sXNtdghJ287sWtMJWjPJPS5HFUMa2Oamyw+fyU9oILBb5BH3t4NW/r6uI5ggD/xY/QfSAdmAiVRZhyf8CmsFl7Tm2Meu8B//PzcYZ9PP+BFtk1EENRI95B4Q5lV9ulAScrBH0xdh4YeAakf0V3MXW6Cu38xm1MJaQpOxf+NKnwVWQOPcPKyDOgFRvq2hf2DzYC8k6cqET1YDTG71O+VvwHoEDDLM9K7vXNVQ4kGaqGKnaJIHnKq6Q4YybM/+wnIK7ATY7jnjlkQeheLw7xtUPYYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Udk0cxklejMoIZNmK3NUQ3ADxvjgbDaJaMdjq9Qq/o=;
 b=MI1F7ZTmUS4p9iPwt1z59lGM4MIW3S2zog0bkSy1rwcStbDlop/OTpUDTGj3f0snqr+bVLNq1BjYlBqlIrqh8fD5rBjl1FkJXqlmstN9q9XA4pltozMNibUqfU4Xlla6HJ5emsYHk6A+Imf+OAPACQZb6OQLd5xDSJJXYRXX6nM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:57:39 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:57:39 +0000
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
Subject: [PATCH v4 08/10] crash hp: exclude hot remove cpu from elfcorehdr notes
Date:   Wed,  9 Feb 2022 14:57:04 -0500
Message-Id: <20220209195706.51522-9-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: b8b46b2a-fd5b-4d97-6361-08d9ec066c5b
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB57014300A71B732CD27B86EF972E9@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldo5O4zRQiB39RqCGIwxHk4rwaX4P2GGeHrUtIKg1mkiwdTAPK1tXf319WjoXgZk3Q8B5s3cwwPb/nmC6H2UZrW58KKwVtUNmvuhsxae0F2AFMH3CkxWR4Jd+or2+VgJyfcI716irnwVpaStc1+iu36MRqIzNjF++eICBJiwL1i88reL8sSWx/7JakTn8YqIjJe/S9lfUyVdPj4WEvVFp97RfX0FId0VDnbc3yXNj+5U8oZJ+3To1ynelr00+3tfM59Cn+cO46HfFC/t9dP/nLlcr5lGPIms6vtKuFg7rzX61ecQhLZIzgw4hOlB3WTg/jJrM0qN2MdFmiLDiOdivsmkBJiwltHpKOowadLJjYEAZfrz17k8l8tMVyODY9K0EFxPULLwBdq1cyxZ7FxSdFa/RX2uZcMWOYqFgoGTxwkvMSo3H2ler9gVqTEzk1pE8VGerzx9azBA13LdQtGN9U4x9+YxAJWuDPGGc59O/+rfos7khim8cEHKNiTwZ+lufdr+i1WxUkBeRMuNcrIwvB2LO2PbyvWKZ3YJWVy3CRaQXzlO7XXsTtx4BwfOWDRwLGOww/ELW9VHLM5LyhH7Ektq8xwJaHx/JBa2yRCTl+rQochFMwWN6fcrFKw15822pXDW7FtlUSOYSJoDoL7YmBYeJlwXRB8GwU32DOlW0d3QL9sGhaAgRnXvVDARysYT8puOdD6eA4CIfzmfqgy5/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(7416002)(5660300002)(1076003)(26005)(107886003)(2616005)(186003)(38100700002)(2906002)(38350700002)(8676002)(86362001)(316002)(6486002)(508600001)(6666004)(6512007)(52116002)(6506007)(8936002)(4326008)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6KYyXj230yqRCMnssrKn3Twdy0JqNceuNPuHcZJRcg/+zj/m7dUt8yrhxhqq?=
 =?us-ascii?Q?kOqEFwPYWw+rJEXCa4Ni6YgasSbj8dvdQMKhcUYvTeXs9UJ4FT6/lG3hzfbR?=
 =?us-ascii?Q?IKKTcudMTd3orQqR8nkhr0j6ESNBa7SiYKNMVtwHSw3tiNDByCe7535cDNDW?=
 =?us-ascii?Q?TSDPoTsTqxJ8GoE562QQabaCuAgopVUmIN7Y0EIkYCTXCrOANap/3ujqLg/m?=
 =?us-ascii?Q?OnjgaAuhS1TUGpkfvQFtVKEGseEmJZ9VFqjvYyfmaWBIdTB1bUpXraGvqRRe?=
 =?us-ascii?Q?XnCdNgToa8k7rTR+shPhw4oHq3OvpGdznYPTJ/7cybJsUqLjCQfWztWbMjiZ?=
 =?us-ascii?Q?oBCQ2LG3UmggutKSFLAWKQ52anVH3pfSugIG2NYQEdR1QsjbDrhmwPrK8YTu?=
 =?us-ascii?Q?poOgwFO2c6qTQ3OF5vkHFIIrfryITulkHxwnc0pJ4KZlB5CzBTvSAdgvnHqC?=
 =?us-ascii?Q?vYBcvYhN+ih+QROFKzPMvlZOUUhwBbItoWBxJv+6caFC9zqWeSwXCN1dVrSc?=
 =?us-ascii?Q?D7SFO2rVWw/8xviHJym2zZujOabBZvbyor0VRhzYTvrk+HazVR0kP11mmSzV?=
 =?us-ascii?Q?iSMnAApId8EM3JbQwxNsX5nthdPREG8Zd324s5nZbvbBMsrXSlK3bKqr/Zkj?=
 =?us-ascii?Q?RizYq+EG2XHCYGuc67/6FfqNWYJuSqzR54/H+t0IGDML8YtsbG3dGdlnDRG9?=
 =?us-ascii?Q?JWs5BGEay40ONy/pJzKveOJcBqiyL/gjyFCQYrD+4SXnL5QHsekgiGzJ7+1D?=
 =?us-ascii?Q?5Pi2C1JWZC/iFISOPWfLAUc2W/FkLqUFB/MvhkhrhlQjLJznLZx2RBjiGjF6?=
 =?us-ascii?Q?1WbsuRhxHv5r9zbqinyBfPvBOOhxm0bjV+oz7gdSWjJukblgO2fAphRt27Ex?=
 =?us-ascii?Q?Y/o4hq9l89LUc9EXwGd5L8PARm/H/VUJnXogmau47dDnvX5cbmRPPLSc++44?=
 =?us-ascii?Q?Kz/ttYPZB1Xativ43sygnMH0OScxkJ3llTwMwjDX/QJpkqOrYWos+snjvkCK?=
 =?us-ascii?Q?aZ+a5cIERgQZS9I843T6N8s6gBtyLbxTKmqWtZBqAZcRd6v8VVZ9eBmLkJmE?=
 =?us-ascii?Q?7m1tdCSXN7D3Ixu8IXPNrNAIVs3HUdT5tkhRI25UvWxz3DJcpZrNXp5JuaAB?=
 =?us-ascii?Q?kf+amAZYBWtpb+gRs1xhRYPPk736dIhGYQQJnJolCXGS9+/6Y+r9yJkSOGLP?=
 =?us-ascii?Q?Qb7UIpLvPDOcAsWy6gY1rB4SVq7xImNvEiLAVdl344ZMZYhGejTsYZlKrtAe?=
 =?us-ascii?Q?LCnKtbQ28SSEqJAzYVOE7ZzUidz20K6E97relBqE71hEjTniVmy1epNs401K?=
 =?us-ascii?Q?GOt7doeaNfDjsQy3Wk3ZY+PdF/rDP/+2xWK+b+9CjfuGTpidvfy4gzvKEIMz?=
 =?us-ascii?Q?Qriha7bbqKhfdXW7tEmZMBiUcLe3/HnjpRAb9z4GaY1AJfhLr/dsAIxWFtoh?=
 =?us-ascii?Q?O0Mh5PvWHKsBucW+vLt60uetu9oXIZmV1/VbalC3WJbQjKqaqBgwtFAh29tV?=
 =?us-ascii?Q?1m+SZklFG3UKrPPQMBXRqt18nGb1TjKFuFvCDpy9S16UwOWDDcU6V3oHw4Ln?=
 =?us-ascii?Q?Q1DXMd9jn7DvbjfhUN/ucP95Hr1JLsx7sn/eb4RmWxgl971jnJxGsfE3U8uu?=
 =?us-ascii?Q?C46zpjedrhPF0cZMo+JZyUJ8fsFYOH+dM4gt65J80JgSPJ/ZRxOhH+dIgXdl?=
 =?us-ascii?Q?UyOGCw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b46b2a-fd5b-4d97-6361-08d9ec066c5b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:57:38.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvGw0BX9N0t2HSImwDuFlYfKyDAAzEaJMPu3ql++LHkLa+8Af8Ub/aIB7kCa15SSWy0H+eaERA395btHb7HF33IjYtBVfsWQQUT1JLNjtqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-GUID: PdR-rPKa7d-YNBkx2VOW40srg98kJ-Iq
X-Proofpoint-ORIG-GUID: PdR-rPKa7d-YNBkx2VOW40srg98kJ-Iq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
crash_hotplug_handler(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in crash_hotplug_handler() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/crash_core.c | 10 ++++++++++
 kernel/kexec_file.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 524470e18883..b6942e04a188 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -550,6 +550,16 @@ static void crash_hotplug_handler(unsigned int hp_action,
 		/* Flag to differentiate between normal load and hotplug */
 		kexec_crash_image->hotplug_event = true;
 
+		/*
+		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+		 * this callback, the CPU is still in the for_each_present_cpu()
+		 * list. Must explicitly look to exclude this CPU when building
+		 * new list.
+		 */
+		kexec_crash_image->offlinecpu =
+			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+				(unsigned int)a : ~0U;
+
 		/* Now invoke arch-specific update handler */
 		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 93bb0c0ce66c..339995d42169 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1314,6 +1314,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.27.0

