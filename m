Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEC64CC2B8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiCCQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiCCQ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:29:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D8B10AB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:28:20 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223EnAwq003629;
        Thu, 3 Mar 2022 16:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=+i+KtCnoP+kA99/b5WAl4TvRcWfqE/kEHwStHfqV+Bk=;
 b=fDWynTASvgv/L96FE2lCwJeeBlfIJmuJt4BhKAeuPX5MQx4RwYmRE2Fl0PVmSlGIvbnJ
 Cu8alklb/nrI9C99kdHVQ6PFAIClQkNf4DVWyuFJ42uCugTEBk6lnbm9DN1L2O6DPYBR
 y1uhyBrqib38q3vLZU8RvcDKEXnJVkxTNJur9U7L02g1ACXdmwAJ4otNP6G18MWVYXw9
 sSTHGCCbR/fQJ7QvYiuyUtybjtxzBm5ofz9luMNsRuhMmpjdVDVip/7BZVcBPNHe260J
 lAmSv6nXCP/l9mnFZOMw+lvWJxNxhYDspXYd3nEqM1FzqfXw+N7581U0WX8i2gqvAEBa OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2eq8ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223GFRs4175955;
        Thu, 3 Mar 2022 16:27:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3efdnt01ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGCcogBBfN0aoqKl8Pwk/JIbfzlJU5hTD2vXa1ESV9OEOh/mOJEM8zhF10kgx7motP1PHe5xiW+N11D0j0DHn40NI8KITTk/Mzv1uQ6DWUfnZeRbKKjFIzdVS2bjvARCPP2BUFY/zxEeZTE9VY2hId1It5z4ArRqx/OGDCnZXdpRYpQ3iiIcLTlr9SdPdnCqacQhUhN4pWvAoLFysRli2Y1n2RgvVzL3GGM5ePl+7r4EQXm7V8PbjF1NwD/eLRwFrfeRnBsqjNPGjqMM3KSqvHobgOKp6Lh3Rapar20lIdquKzkr49SdBhc2JYEUuNzVSwWClX98bDBEpm+MWtdYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i+KtCnoP+kA99/b5WAl4TvRcWfqE/kEHwStHfqV+Bk=;
 b=S0kDIAdXj0VOKcVsqH4oTlxbj6q91+kTEJABSIlDhnpN2bUf9m2UqpTsjjpEgP8Mu66mt6F+EaRtBdLqTx+z6vFH6FaXXSLI3OjQ6hJtyVbl93UUErWcZwef7EyuGFfUfnkGmnldPifSEzpgyoa3SX5+cU5VzaHuHaINSik8uMJYzNHGQDVn9M0Pxx4rhVhrBYg03LNbFby3gAHLawuESRANl6KDozEhkV2MCKREQJm6v53jNnf1TzuRheQBdMVdMInh2bcQF/RuqKJQsL2BUMi2hUpIGsc4eW6yHDfUAXrOmAXwDkuMrAvUucNyWliO3QeohTH/b7vcmztBdHsQYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i+KtCnoP+kA99/b5WAl4TvRcWfqE/kEHwStHfqV+Bk=;
 b=GjLCibaLCI2gDQ7jpcPdCNrVVhPy/+Y1NFmvdFHqkoyGc+eyDdx0RKdhxWxGog6J9vh5sIVw/ioU9cE9+p257l0JBmySXd84sPu0vMvPIvQjK89XF7CnuYTlzrpI+rwRPsIx3a8zCRS+HrUaISztbMsPREL4cUK8jtuuJ+5U/uE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 16:27:54 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 16:27:54 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v5 5/8] kexec: exclude elfcorehdr from the segment digest
Date:   Thu,  3 Mar 2022 11:27:22 -0500
Message-Id: <20220303162725.49640-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220303162725.49640-1-eric.devolder@oracle.com>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:806:127::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 595816b9-0def-4f3c-b468-08d9fd32c493
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4704:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB470431630D36A0840BCC8EDB97049@SJ0PR10MB4704.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbSyyOoMjhyf71cR3geFIT8xztBtsQgL2/3hYddrRxp3nW29jALBerUOzhOVFj9Y5sRFlN0DGyaP5pR46/ZEVTgRNfIzixR9IGI7D+AfLWztNOF3gVS/80r2BimVzVwX7lBitEF9jds+J2vDxRJhxBQaxL/OOu61UTpdZyZRkknriGUjrghtx6Z8td2MQ2y1WlR1ODl+vfE13Y+kf/NtJZrmzZwHOX8oUfSjN/3zNwkPOmpF8ZeQRjT5/vKfSMA0i99W7oW5CX3eOb7toAlnkAZP3i6VVCvLsv8LB7wAZj6Q367xyVYRCYrSuriN2dpBrUsj5HijKpVChrPNsi5C/ltLK118EMtf4nIzLFKo9YYFjQfsO0KkTE+JXfSRg4wcvGq68UDMV8yN3y22SOR6Xr5AabnUnviKDWuxfMOehL2lYpaAHmLnE7zd1p0dMJY78f6hjdASbWeW7vp7ZT0A8xpLEDlqpP250ax71oaBPUJC2AP+Cgms1p7QkMqIYK4EsM4QfV3zT0cE0Ox8xzBYwfuL5ClqcOReE7nQm6Za5jh0ciuqU+ezVsB7R2mDS22f9rQuf00/4rafAYc8bvjT7kct0c8wzCCdRM6gUVJ/yH+A8hFiXqZF1WcQXA5A79C20HlORAgokFikgUb4WJerqDmZwXpUVpn/RfYVBW7hJXvOoXBAkvnugIyaXl0GDVFutcq+NQt2NsUndRQjr3cltw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(38100700002)(38350700002)(8936002)(1076003)(26005)(186003)(107886003)(2616005)(6506007)(52116002)(6666004)(6486002)(6512007)(4326008)(66476007)(8676002)(66556008)(66946007)(316002)(2906002)(86362001)(36756003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WwA92kOWQpYCGoAOXuQsXmI4F5tlhviChd/ZWnJQg0PlwecnLHuCbzcixzLx?=
 =?us-ascii?Q?gHfps5NzybK4RvZtGFmVRu9uTyCvKBICxZVor1M79x+AJq9MSO9GEAH5R5tD?=
 =?us-ascii?Q?HWVgxKhnIQhQPfL6CO5jVPS+EZyRFvUYZKh37DkoGPl70o7LdsnJDFNJQ5Wt?=
 =?us-ascii?Q?lbFSnh7KF5DBnnsDxVtnTSFX78WCdph9IF1Dd08S6Nkj9IHQMOHNi8CRNmgd?=
 =?us-ascii?Q?E7nmXQdki1qnqT1VgAHX64Joj1Uu0DsiKxLbcWSePecu3Y02nff41IoJ7drp?=
 =?us-ascii?Q?VSmutWGrXLZDPKzf6jD3NjIO3pvHI14SFLAxqfEUAziEWlgFW22jaNgGy2CY?=
 =?us-ascii?Q?aXndK5JmB7V/fSNfAASIW28jhYxvtWZSrU8i+kD+qibnfhyF8LMtGKxfyi/L?=
 =?us-ascii?Q?TRP00VL+Z4mV3EL99gigax5iV0j5s+6/ARKD88GBDqpCpMaQHle1AvCL1VsK?=
 =?us-ascii?Q?SU/E0+lMR8a9dO8Rb1yMVCIyJEOi/Fi+wOHi2eqCUQAs/KCAfzxygOLWANE0?=
 =?us-ascii?Q?tN9llP05Nx/L3EGCHRTxDpAQQU1bljEo/ykxA9Uxj/DOkAAP9rZr1lk+4BcE?=
 =?us-ascii?Q?xzoAnK4wg0tKZbI8OTGwG+bxy+bElq9clkiFTIYhUFG2AdkDtfuP1dW+dqfW?=
 =?us-ascii?Q?M+cURQWsGzUoFmrebpxULR0Sai5Xz5YEbmcB+9HuO0N02K9wX52X6J83rPqo?=
 =?us-ascii?Q?0sENZVTWZQVEUCJiT82Bq1u3L+rRRw+zlOMbT+/ERV1Gq+YR2JRJqU+OrMjr?=
 =?us-ascii?Q?gIcXuj6QkuRy+haCYUzNLmSPhwnyAfKYejZMaPhqtqrOSiiObgqdM0LqceC1?=
 =?us-ascii?Q?+SGvUCtO0lDpkSk2wSCVWnevpTRzeudxOrPVcauOTJ17hWBBx57lJEtsEXWz?=
 =?us-ascii?Q?8tVkhxYqHt/X7hIv+4fuwsxi/XODx/H3bpyMXUSqmtfYFu8FdHfJxcsyXSnm?=
 =?us-ascii?Q?q2dIw0iSC64MTB4mZUC1q54J29cjb5aF++77mAfODCj3WzzB09hLe/kbV2AK?=
 =?us-ascii?Q?5/Oy6yr16ES8Wjq80WuIlfTpjZV34x8cZ0LWCyhx9oMswnRtTDQvlufIQcet?=
 =?us-ascii?Q?MyjAtUsgI9HNzReo+gFEOd6iqUp7jgkM9MunPR5507cHwhL38Y04P9gMG371?=
 =?us-ascii?Q?MGRoS783Upo1g1UOgCh9JRL7FPrAo2wNBle4k68hN0FKMP9LtctW1pFNN2Jw?=
 =?us-ascii?Q?4AUTd6a6VjvgyAZjhiyCxSHLpveHXfW0cDIshJ15DNWeHvuN6VrqHgmE1P2M?=
 =?us-ascii?Q?v407bAk6vWx7ShOcXZHVsphW6k0v/i1YnCGG0mFgsqVVGwWrD58o618B6s/A?=
 =?us-ascii?Q?7711Q/OT2NqJM08EoyOh14MBfrrCqAE8JLtLLT047/jD/QQ/Yg8NJCWkldUK?=
 =?us-ascii?Q?2/zm5eD2wTB1iHPGfSyf2ePBKWVRWpkOTqIE6raTef9uJtbbwT0bUyRIjwg4?=
 =?us-ascii?Q?QqSvEm5vWyYsu0zNEc36U5MPkM/YqthNfUAk5ujWpqk1iTjuy3aIUPyYNhJh?=
 =?us-ascii?Q?3sIPHs5JEGc0L6PcejdTB45AnLzI/Fv8XoBwGVryzUFw7X6OgCS4xjuqqMgx?=
 =?us-ascii?Q?uqRdFMSqfNffuX79gBdRTNBMiLHzi26R0wk8ylEm+dr8gPfLB/4RLCTki0u0?=
 =?us-ascii?Q?NxACOHrVTzdIZSXCTOQcPhDBfBETSfRQztWSK02TUywsfv6kjOdbaF/IkHr1?=
 =?us-ascii?Q?Tb/5Nw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595816b9-0def-4f3c-b468-08d9fd32c493
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:27:53.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7qDLBPLGt58kDpY0G8eC/K1RgKbkDWiVlPGJQmxflmvTdt43gbEy9G19f7dv4gQbDuMhzLpOqE8eOl8URyzRboyXfGNsnFnrCh6aQ3Ay7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030079
X-Proofpoint-ORIG-GUID: OWyvS2LKNnV_MJooU6i7xviu1ubTmM3g
X-Proofpoint-GUID: OWyvS2LKNnV_MJooU6i7xviu1ubTmM3g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

Since hotplug events cause changes to the elfcorehdr, purgatory
integrity checking fails (at crash time, and no kdump created).
As a result, this change explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits changes to the elfcorehdr in response to hotplug events,
without having to also reload purgatory due to the change to the
digest.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 801d0d0a5012..93bb0c0ce66c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* This segment excluded to allow future changes via hotplug */
+		if (image->elf_index_valid && (j == image->elf_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.27.0

