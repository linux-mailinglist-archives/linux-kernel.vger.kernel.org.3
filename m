Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5E94AFDE0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiBIT6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:58:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiBIT6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:58:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6133E067871
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:58:07 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HGoli013543;
        Wed, 9 Feb 2022 19:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=4lq10SfzIqDtmItrYsFNHjd/1F+h378qjqN5ixNQsYs=;
 b=P2/wLfmbixNt0R5VveZ+5Lu0nVXRyKv0xRZtfyyeJxn2Jk3etY8NPFpNOltydXVbMKqG
 t40QINlbXkea3/mopXVlMJjTkJ6N5SPdwGGYlmBpKdwyPqgDWwzgfcFl8zCHWm1UbDyI
 CZ7IvWMJ8cV5xypvo8admSG7eEWBcRPIguA9KZbBjUUc2OPuDAmoE2SjKO4fhuQ8VltB
 T59/dyupHB2If469LJRjAgxAYrCvfBAv9yNjGJhQ5jGEOTTAk6Baa58ElN6OAYNR27GD
 NWrw9XPhYt1VOZ/p5+8M4vB1/4USuqRikXlJ5iAfTa+0VngXBI5EbQUdpsANkHRIIlIS wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345sqkg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219JtbFB130738;
        Wed, 9 Feb 2022 19:57:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3020.oracle.com with ESMTP id 3e1h28vx63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl9OA9+uPV5j1Dfw2CcXSFs6q39LaEXBTrWkNrwQiUVuu0HkuUNl9f2UZrs8LtBsjpCvRpkbB/zLaoEzsub/u1er3t/X3MY6+NG8NuNfJ6w2tYEczaSihFICoP16RiKewzqA6V0hHWIuXOQYTZufdVKguwsgYZ0MqBGZ12q/+UoxwsGAh3jsGJIhdBCN+IWcKXjzde4ghQLw2FvJS3gM9xKDJB1di66c04XHX8GFwnY9clS8m2+BvbDhRGBVu+vr+nEgqNN7i2Y1N2i4UjALWRuwpmLkyXyI8JfLTw8p07sw1Rcoo6LhO861u83XhSUnBOkXoUNkcdRENnUe/I4dvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lq10SfzIqDtmItrYsFNHjd/1F+h378qjqN5ixNQsYs=;
 b=NmCZtUVmvDCm7xg6843DGRfj6x2H77OcRZ+LOEHNpih31sAyYPWbWLJ+XjMBahYEaJgdFQkWL7nmDApR9GYDmNOe9yTLnRwXp4Off7ojc4xpn1NyStT8YjZkmlc8P81E7X8fNZPA8qX/xSb4CdmsvSbO+FYctS6Il/h+glchuwer04nsSmFVSKv5uHvkZcCYk93I82Qf6ZbtRs7FQSQIQnjzQZGRgoqsRo4rJ6exZFxSRP8edqgf0RRaHf8s/Zm4Qz/krCToXzf61FDOh2KTMjUoICwaLksjqaZncZ+1roWjn4V6IF+4reiiWNkHrR6AZJG14caE2DMRJy3DIKmsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lq10SfzIqDtmItrYsFNHjd/1F+h378qjqN5ixNQsYs=;
 b=BpBxvyeNAg0Ue6tulE9Vq5FSSkEJjdu8BAEoMFMsx03tQXbusy0sBRhBKD4NYz/4X09++WCxup3opzBIKiB5qMvhEvtvzrXpSBrXSTar1/ehCO4bh0+Rb9bVp3LQpUZlx0KX+jERe4F6p83OcizhnUrVM8W4+P299PR+B2+X6aY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:57:33 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:57:33 +0000
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
Subject: [PATCH v4 06/10] crash hp: generic crash hotplug support infrastructure
Date:   Wed,  9 Feb 2022 14:57:02 -0500
Message-Id: <20220209195706.51522-7-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51a313be-3b9c-4dde-da4a-08d9ec066996
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5701EF5BA2466DECD5FE1A29972E9@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FmxqSx7QBc0tS70AAXTBU65VmlEPvHiyeghUb0mXrAHWbdSpqMdlxPo796t49G3oUGOOIrm7srywe7m1ThS1S9zBhEufrc+pgRFKkRQALWWdgFaN+PNCSoTr3MslD6KTN6P+mMkTwZKUvtiZSRRwTeTNwjQFnrm0W4GBUxyVa1iR0chw3RzIfQG1lA4r/tx4OAye68NJe8eehGVDD6Ta1RG9TlndH7Iev6syMy35PyJhREsfOVeSOg7gzcX5fyyyzlwcF41A+qcAPQn+INy686v5KblEF+KT2pU3Nsm2m0iHMO2/RIjsJTC9Vh6TWzxPtA4MuVJQ/m0r8eey8xRk0JypyjDAeQQnyreN5UYBfoXCwZEVpTfT6P07VEzNd3btTnlLrnEvagq0/9Rq5no8Htv6gTsU/OlyS1ifGzbZPV926jzNmDglA+g0Jo02CJe1SCcSl61rxlIqJinaKVIxS1jLyCBXEsIVapG1d1j4vjFTi4SY+XA8eCK40S+2zyM0r2ln65SNkTaPlh+YsVdpL+Mq88EVVx2WrrJaYeAWQRBj4ewoDoI1CxOOENPmBsr7mieuOdqvwcAA4BsB7EaJ8zV87MWZfNoeI2p/miXbyc+p+7oIgh7O6Yn8MNVyY/S255m39bYdsw3x45EucT8/CyJt9GzI/qOE7eC/I99tcLzDZIjKURE00b5aOlQ5+tTefqeUdMbX2vRU2/LlpsQtfZtfUUHUlSsw64NqGPytBXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(7416002)(5660300002)(1076003)(26005)(107886003)(2616005)(186003)(38100700002)(2906002)(38350700002)(8676002)(86362001)(316002)(6486002)(508600001)(6666004)(6512007)(52116002)(6506007)(8936002)(4326008)(66946007)(66556008)(66476007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4jeiffAFVrH4x/tHm7Oe8vFDHNnYBVWXRXkNMoikBLnn4aaqZnc6VLsT11No?=
 =?us-ascii?Q?9/b96RHjvMsKDLZaJr7sZRtxHd49oiO7UpcrYWBqiwG9Nmf6Fp5vLwnWVfCD?=
 =?us-ascii?Q?cy1JKkbXDzCTi9fKrrppst+XMyjPQyq8t8md6ex1lYqsjEOfphRiMdj9iG9A?=
 =?us-ascii?Q?g4fOk66eoBtU0qKnjhQ4ag7tIX3hAi4sQ2KzLVdSElmI27VEazBbzbuzZVC6?=
 =?us-ascii?Q?Sl5h7GrmoNaAf/X9HgLUfAumYGg6ZxGvwM1rHFFt4C3gtM/2cdGVwv7l9nfq?=
 =?us-ascii?Q?LT2CbbIeGm3/wWlck5yo8YiVTKsapvN5fYiV4SFhHE1dLMabZGs0Gakk8EGi?=
 =?us-ascii?Q?jZVC2ap5tUXMvxUsWoRItdzG85fC2MdBCP8IIYSMoYLz3oK7JKvMtwOsdZfd?=
 =?us-ascii?Q?YZksLOeFEL5+/+rG3lmhbtnyxAwHFWOWCD6UN+ox3z5E34wOQAnqEvms/9Oo?=
 =?us-ascii?Q?qQekjkG5lzZAYnlmoLpIFaWXtGU/pcxZN4q1gJMHJVbRky4ACVg4tSeO3Jpz?=
 =?us-ascii?Q?CDEVPys3aNOxfePtoI2PX0szNAvB3UkRRtRVXUfHEZm5DF4Q13bqTRxNdiFq?=
 =?us-ascii?Q?HCjtmB+XxSGvTlcheRqEBuVm8RhLZ2XlidzzJVWJcAtVgvtSBOzDs+eaw6mJ?=
 =?us-ascii?Q?WCMSaH9YX/BJwdQj2x3+g46SsJn/ZeQMCbGKxhOxpjgShrjl/zqHlQQN/zOH?=
 =?us-ascii?Q?3b7vS4a9R02UQcSced3xlmaz+o+mJwDHFEtQRf+rbbI6hMD75mCa264OPsyZ?=
 =?us-ascii?Q?3TtgS4eRNKA/3sbHfPAHasJJC6tnIJnVkCl6s/xsVJtcYrmAE/4ZaKd8A32J?=
 =?us-ascii?Q?LN0hjEYGmfPjcQ8Bxegw4IbcRrY/bWVtRKCRhBZ0r1P35ESsu8Yv+TAbkg04?=
 =?us-ascii?Q?W5kEswq4WQO6rtdbuk0Aj7oEnOJHBfjxtuc8ZbI/wNM8a+1prd+WKhyFTAa2?=
 =?us-ascii?Q?nLCEWgBggi878+y1GBAthrX+ULQ8N+s016uiXBKorvdxbILofSYOeOp5Mgnl?=
 =?us-ascii?Q?OJt+UobvOUN9Z7rtB2ictT6lRrpUWiRrl/BPW6YlrfXRKWeElbHwAL16fGkK?=
 =?us-ascii?Q?63SEjIeVsj0B83lN3UfMsMGlq9x1CDSaYFaEAhaucjv3+Czv19CbTycn0S2F?=
 =?us-ascii?Q?vDevNerr4w4sIOpnA4/M+y3/K8OJdUl72qmSgT3oJdSyqKwLM05zdjpheZOb?=
 =?us-ascii?Q?U2rRLP80FFUb7wo80OY4VKUhpVWvh0bTmr9lnoEeUuZuH5pJF+Py/Qr4k0oA?=
 =?us-ascii?Q?FCwcTRD+jqvxMyZj7rNnosnNtPA+ENPyfFwqDpjzjojP1PAUZQLvMU2HCnwt?=
 =?us-ascii?Q?/0CisALm/L4H35dtUStGnm9SEtkPTsaXlVCJpx0VzPjSty/ghEbmamMre+YJ?=
 =?us-ascii?Q?1zQSnkeARgwGHf9M0xaII3YVEIg4nANEpvukxtJkFpnSyF9NtnAQ0N3LoKoc?=
 =?us-ascii?Q?SF/hXZSaA/Zy63pF06aslwnKqLcGwo84v4EEqm4e1vk/qqwrR3yUyEN5ish5?=
 =?us-ascii?Q?aDQcBPatBlGKwG0zfbXRx6lHEL0jOe5p+RUVMuVgHfw9JTZhZs0ViMIU8NEj?=
 =?us-ascii?Q?sIUhPoIP3yhNS7xO4DWaMucLMiQZHgW0eVVGzY9yQwFcdgpadt8spgSicaSP?=
 =?us-ascii?Q?Xyif4JeKbr09TqtaLikBUZiLE43arRk30Dx2JomOPUI3PZtj+hyur/I8nmeB?=
 =?us-ascii?Q?2hF04Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a313be-3b9c-4dde-da4a-08d9ec066996
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:57:33.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdmNFWItvrSbcdI4xcQdTJ41u6QHdSqyaT9VoGURwWnldoEp4Kmc07Ua2C+lKdPyocj2+1IqTTI8sddFc3ODpLc9UUSU2lR0yujpKuo3fog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-GUID: _N15Xgnwhp-MIRT8EA7WkEKZELTpnXhz
X-Proofpoint-ORIG-GUID: _N15Xgnwhp-MIRT8EA7WkEKZELTpnXhz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a generic crash hot plug/unplug infrastructure
for CPU and memory changes. Upon CPU and memory changes, a generic
crash_hotplug_handler() obtains the appropriate lock, does some
important house keeping and then dispatches the hot plug/unplug event
to the architecture specific arch_crash_hotplug_handler(), and when
that handler returns, the lock is released.

This patch modifies crash_core.c to implement a subsys_initcall()
function that installs handlers for hot plug/unplug events. If CPU
hotplug is enabled, then cpuhp_setup_state() is invoked to register a
handler for CPU changes. Similarly, if memory hotplug is enabled, then
register_memory_notifier() is invoked to install a handler for memory
changes. These handlers in turn invoke the common generic handler
crash_hotplug_handler().

On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
the CPU still shows up in foreach_present_cpu() during the regeneration
of the new CPU list, thus the need to explicitly check and exclude the
soon-to-be offlined CPU in crash_prepare_elf64_headers().

On the memory side, each un/plugged memory block passes through the
handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
memory events, one for each 128MiB memblock.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/crash_core.c | 104 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 0ff06d0698ad..524470e18883 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,12 +10,16 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
 
 #include <crypto/sha1.h>
 
+#include "kexec_internal.h"
+
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -521,5 +525,105 @@ void unmap_crash_pages(void **ptr)
 		*ptr = NULL;
 	}
 }
+
+void __weak arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b)
+{
+	pr_warn("crash hp: %s not implemented", __func__);
+}
+
+static void crash_hotplug_handler(unsigned int hp_action,
+	unsigned long a, unsigned long b)
+{
+	/* Obtain lock while changing crash information */
+	if (!mutex_trylock(&kexec_mutex))
+		return;
+
+	/* Check kdump is loaded */
+	if (kexec_crash_image) {
+		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
+			a, b);
+
+		/* Needed in order for the segments to be updated */
+		arch_kexec_unprotect_crashkres();
+
+		/* Flag to differentiate between normal load and hotplug */
+		kexec_crash_image->hotplug_event = true;
+
+		/* Now invoke arch-specific update handler */
+		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
+
+		/* No longer handling a hotplug event */
+		kexec_crash_image->hotplug_event = false;
+
+		/* Change back to read-only */
+		arch_kexec_protect_crashkres();
+	}
+
+	/* Release lock now that update complete */
+	mutex_unlock(&kexec_mutex);
+}
+
+#if defined(CONFIG_MEMORY_HOTPLUG)
+static int crash_memhp_notifier(struct notifier_block *nb,
+	unsigned long val, void *v)
+{
+	struct memory_notify *mhp = v;
+	unsigned long start, end;
+
+	start = mhp->start_pfn << PAGE_SHIFT;
+	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
+
+	switch (val) {
+	case MEM_ONLINE:
+		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
+			start, end-start);
+		break;
+
+	case MEM_OFFLINE:
+		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			start, end-start);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
 #endif
 
+#if defined(CONFIG_HOTPLUG_CPU)
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
+	return 0;
+}
+#endif
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	register_memory_notifier(&crash_memhp_nb);
+#endif
+
+#if defined(CONFIG_HOTPLUG_CPU)
+	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+				"crash/cpuhp",
+				crash_cpuhp_online, crash_cpuhp_offline);
+#endif
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0

