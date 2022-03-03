Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CA94CC2BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiCCQ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiCCQ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:29:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4584CB914
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:28:30 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223EnAwv003629;
        Thu, 3 Mar 2022 16:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=BSnrw4sTf+o2O2WZcIZhPT+WRFNBZY3+wGl1bUetvTc=;
 b=yU++miwO5g6qC+t0Ei1iYlUga2IEwlphuLXJbN/xHv+dsY3kepbQ9Mc6IWEeFbgecB49
 EROfl8bVymLv5yxcNUhxGv/+ECmKBI+/Myyeeai5+D6CQF2RKJJCMjP5OBYfcCRJQXEH
 h7NpWbN0zJlc+3JWv7eJK0sLW5ZfzLX7JlJjOpzFLledA/httu8hWymKwf1SWgcB+wS+
 yyrfyBv5Wdwd/aixXmJq5xFLJ4KVwuygBKgAQkGnqO5vTGKFvF5u31rJYYFwP5EuH23Q
 8ur1T4cY9h1xe+UFwrYa/Ce+zjHYukgxfBy0jpu0vJMJvIC7unYxFyq1GZzf6t6j4Uxy NA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2eq8vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:28:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223GHN9f084026;
        Thu, 3 Mar 2022 16:28:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 3efa8jf1m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:28:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmJjm63c8CzecqM67ViY/Ty/bZ+zkkUzrlyoT9olnmiVmBpa3gQu+bUSggF1aBPD5y+OgjBCy+FPHffewtTibA7I8E7LOTnK1anzgRTHISuRE2mkCPlchKXaCaanIn0svn/xKUVKz+eA10B4eUlrX5V91gZIpY8b0Smfg05bHENJmnrx6PXq7Bb+AEUKtnWMtrbpaaxZwN/T8SqlhMy7NCbcmq9SR9Nw2TqPj9Tn37SaEAR0y8nVbxzlBFKHmqoA/ow0BurG1mgxvj6NRyzRRlW16tleYsoAeaUeYgz9TdunFPT8dEuFLwa8BosIo0qKXGiOvczNdtz1MKDqYaDnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSnrw4sTf+o2O2WZcIZhPT+WRFNBZY3+wGl1bUetvTc=;
 b=WGr1c3IIXqTNY7WA4bfkRoOalKh7Xh8K3pPqtN+oGUBB0KsKGXn0G/KWxCdLKaqplXVW2qdr3ffTGt8HbbZD6J/KBy2kEaMki5tWz3k/M16gQDbEdFezhYGdjtzhrf8nODNvuqTppRdxtSM3W909vayo8lFlsFopFgTFeNwejQCR6hPYa9fDfZGZ0d1H+/FubTItURNcjrZ8PbYL1lYbXJv6TnxxtDz3om1C5Vtx5SbpOiELYvVwD8egiPz12QFW6UMmP3Y+q3Ok1KuVtILsEnbT7VTZQwXDO13TiPFkAAHh11nBLzP+rORYzUloFhiC1usRqln8izakyBOpdPtpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSnrw4sTf+o2O2WZcIZhPT+WRFNBZY3+wGl1bUetvTc=;
 b=hhT8SpNd1BWf/g1H8h9m917OE3a8P0XRGyWqLotMIanqLy1Pne16x9Wnlts9hh5UYOqtvHk4eyXo8gTnXqrD2zrhCVW3GXPSEeRRRvghXL/W30LowXzPV8qfdJfU9CTt3U3LejDjoZUg+D4gKzQ9BydN8h8VNENnNKTFt2Nm19k=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 16:28:02 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 16:28:02 +0000
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
Subject: [PATCH v5 8/8] x86/crash: Add x86 crash hotplug support for kexec_load
Date:   Thu,  3 Mar 2022 11:27:25 -0500
Message-Id: <20220303162725.49640-9-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8811de37-2786-4f56-4adf-08d9fd32c962
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4704:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4704633860A3851E863D0A2A97049@SJ0PR10MB4704.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwNU3JWSI/vkt7gtg2lgTbEsTWHhDDolkFWE1+edmbiPdt6mKeOLK55kyy0hrYA/IPjsoq+rLKUqs59KZ4yM45f8GUi889Si8Pr7b4LFm9UhosUiWt1osrqljyxwu3CgYVXe5aKZeAf0b5Ghs+jmdCgb4toWcs/+lOcYRv4OxYSDWxe8JJL/cQc7G0OyjaqSdaDRgI240zjYC+o/X8qb7Mjyv4wVsZyqnIlA8wfVeI6FtwEhopjKdxFrYWoUnJrBGXV+e0pCMKjxBqGea+Qo76S8t90rQp4B6jGmUIPBRuBr2DYrQ9HWzC8nrntTicf2gU/DztENibAlW4NJ0apwrsi7f/sKdmis20BRKHvollK7JYinwJAXUCLZV5lW8mVVRUvnylGwBA1AsOXRdT6ZSmEwrDCBV5aAmhAW6JqtIJgvGHBBDDY7gteZUjCGGWI0//u0rHfzCIb9qFBIzZWrTXq9SoBLsxJ4domwPbwD4Thjr9jMWz6FECAqVnTWouL1SzSy1qeRdrLvicenaqHjpfBFftmSMRydRNjDjaGe9A4OBMDgIlLrT9OWdAy2n1cJ7A/V0EFoiLdtllI0O7/f2EC35O2ypZWXH/8ITnaT67M8Gk815qZALdSeDHj0+bvejwlMkQ1//BnJLvTwn+t5dmM5SoHxEpIIcNHmuOrEsthX5mFFjmnVbEnbiyZEB+8OVItpzlGabwC0Y5v6ZxXCrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(38100700002)(38350700002)(8936002)(1076003)(26005)(186003)(107886003)(2616005)(6506007)(52116002)(6666004)(6486002)(6512007)(4326008)(66476007)(8676002)(66556008)(66946007)(316002)(2906002)(86362001)(36756003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yK/lK0cnlYfrSu8dT4CYi1FLDQk7xqfV3Yctns1hD4qr74qFFvdFue2iltFT?=
 =?us-ascii?Q?7Ayin0EQah/6uYYjW8YrR5U4jjMggq2h/3AfVFFA7rX5BGMYHPa/osKluBzt?=
 =?us-ascii?Q?52cNZxXG3+FGLa37vkeeHkaLv3r85fmn/ZYxtYr8H5GtUQeMrwSPvFd1JVXI?=
 =?us-ascii?Q?B0DRqwgcKwBtHQVogO6aFQnvTaFCzWsFcdbgdgWoNZJk+iePCgN7vFzgCDzB?=
 =?us-ascii?Q?J68FlfHZYaAJ/MYfLc18Y6bJAYRvSsKoyK+OhKEae0Nt5L9d3TPU6npiycM/?=
 =?us-ascii?Q?/XYMK3gU7Oi01ZvWMP4ntSDkbVjgnTzXgdb5/XeqU+wIanu4rHVZvIH2rbZj?=
 =?us-ascii?Q?mYvKyia1OEb4JcZ4EJiqCyGDN1HGm+51BAkrq1k5DM2UAghEVYymO59Fv0/i?=
 =?us-ascii?Q?RqFhrpo+1dpU2ZqEL2ZrzZvj7sfA+fCLwZmiw+ilgg8OlJFiN5SxY6OR/Gon?=
 =?us-ascii?Q?a1CgIvupWIUq/GMLWbUbo5CRFhaLgrN6XywAXVj5jjqlvUMHGX3t+WhopgJC?=
 =?us-ascii?Q?z6hjKo53uXJVfpF6EL8NC2ofm1mKw/7iidb27tOnWmx53xhIynBIf9u/GHyF?=
 =?us-ascii?Q?PjV9PsrojOmQJUU9tm0vS+2YQp1E74i8BjHgAw94WZiWCgM43bxu2kIAAmXd?=
 =?us-ascii?Q?Zb+N9KImfYaaLRHrTyd6nt4eDbKjNMZyVoVEG5YndjrNtT2bZ6G6TTQt5v/d?=
 =?us-ascii?Q?xRNz/7aF0Sg7vaJCi4yYvZMSTnc2PLRjy52Z/aefW72Nl7ASPLRCtKHaUX1f?=
 =?us-ascii?Q?t6Rk1Xk+zv2Hgf1og/NbL8znn+M+8JxZglJOWLEDdW5c6n+cn2uHBuHuNPPB?=
 =?us-ascii?Q?+1OE49987OxAjWiCKYLgLKMeKeEbieKhp/W4JBIuUcFE3URuYkzestBuwiLp?=
 =?us-ascii?Q?jBDNsHRYZHX6hkT7cMS00GpMagtdReZsVE0ZviphKFBG+yn/aT+XAbyrE2nQ?=
 =?us-ascii?Q?KIfXFqEf7L54i9d4Ww2LCQY/2jHhtsNwyJevzPpnk89zVK/zZBF1lLvpNA29?=
 =?us-ascii?Q?ApYCU0VoWJhRY+8y7uZXe5xdBpKjTWga1XuVqQ68bFJYiXiLNu3HDElMyRBl?=
 =?us-ascii?Q?KXu0xr3b5dKxgsHR6FfKKQZKsQdbU3mDTIpbXnEZ9GFi1MvFmPt3K7b7/bko?=
 =?us-ascii?Q?2wMNh802f2cTRLcDjMo1JLmr/2B+jFX84AizTeikTYYSaqEwTykwnzaA9lFh?=
 =?us-ascii?Q?oh+h8W00zO/vdWAKQjdi3N8WpjJo8SyCjrnT6jliDirZdTC1M1WmdxX/s9k3?=
 =?us-ascii?Q?zeUn4Udo74lgDlN43dDOIRPBv48w5hkX4pVslqv6b6Jh6f2x21d7EcCgPK3B?=
 =?us-ascii?Q?Efr+S6pM6HSJ6lqo0M1gSegOkAv7UdxoTbPxXyw5UWMNLCSrrP10so3arRJe?=
 =?us-ascii?Q?rrKLOQn1mgDSvB/PFXdfRDS17C1s5uxmiL6a2Xj7Jjjc5b5fHXH7udE+WrSa?=
 =?us-ascii?Q?PPBQ7H8aULhguFxh0LtVeoCmiN34p9Uh/eibFTR1F3H92H+GqmGorpUuIyGD?=
 =?us-ascii?Q?tIPDz0ikAfvaA9EDQpByy9QMmPnnivTzHE7pZQjnhUfHnzh8+ee7/3mZhM6Z?=
 =?us-ascii?Q?e2W59zVCW/s2Pz+XrxQrFhdGK9NJulvqjxOh6jgBVMWutYd1rPhHPfxgdJ7k?=
 =?us-ascii?Q?2yjdayz2XCrf+7K0k12IzMekHEol497ViGBb59myG0p0u5xaaA6wzE2qfZW2?=
 =?us-ascii?Q?lc6fKgfVUhi+feMVfsKPPx0KThM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8811de37-2786-4f56-4adf-08d9fd32c962
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:28:02.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZc+KydFpBqhnku4YpAZzMhITwT+9BeHykzrlYeKdjUUthMH4p0oRksu/l/qMcmbH2V5YBZN+tesQvsnTE2Ua0UfGUhuh/KjZJacmJnnImQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030079
X-Proofpoint-ORIG-GUID: FCaT6qRjAZqhONaAn6WnjKYi3S5Bk581
X-Proofpoint-GUID: FCaT6qRjAZqhONaAn6WnjKYi3S5Bk581
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kexec_file_load support, the loading of the crash kernel occurs
entirely within the kernel, and as such the elfcorehdr is readily
identified (so that it can be modified upon hotplug events).

This change enables support for kexec_load by identifying the
elfcorehdr segment in the arch_crash_hotplug_handler(), if it has
not already been identified.

In general, support for kexec_load requires corresponding changes
to the userspace kexec-tools utility. It is the responsibility of
the userspace kexec utility to ensure that:
 - the elfcorehdr segment is sufficiently large enough to accommodate
   hotplug changes, ala CRASH_HOTPLUG_ELFCOREHDR_SZ.
 - provides a purgatory that excludes the elfcorehdr from its list of
   run-time segments to check.
These changes to the userspace kexec utility are available, but not
yet accepted upstream.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 5da30e2bc780..45cc6e3af63e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -486,6 +486,32 @@ void arch_crash_hotplug_handler(struct kimage *image,
 	void *elfbuf = NULL;
 	unsigned long mem, memsz;
 
+	/*
+	 * When the struct kimage is alloced, it is wiped to zero, so
+	 * the elf_index_valid defaults to false. It is set on the
+	 * kexec_file_load path, or here for kexec_load.
+	 */
+	if (!image->elf_index_valid) {
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			memsz = image->segment[n].memsz;
+			ptr = map_crash_pages(mem, memsz);
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if ((ptr[0] == 0x7F) &&
+					(ptr[1] == 'E') &&
+					(ptr[2] == 'L') &&
+					(ptr[3] == 'F')) {
+					image->elf_index = (int)n;
+					image->elf_index_valid = true;
+				}
+			}
+			unmap_crash_pages((void **)&ptr);
+		}
+	}
+
 	/* Must have valid elfcorehdr index */
 	if (!image->elf_index_valid) {
 		pr_err("crash hp: unable to locate elfcorehdr segment");
-- 
2.27.0

