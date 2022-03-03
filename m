Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349AD4CC2BB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiCCQ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiCCQ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:29:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FF1B12FE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:28:20 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223FCr8E007695;
        Thu, 3 Mar 2022 16:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=yL4gUxuX1xhIJKyqEsW75T/qKrplKqiWLQnBIOkTW8I=;
 b=GBvAUj7o4B3J5iH+D1BYVx3woW5fqYWJYJ5jByhaRoIgeF7RH1xD9RmKY6t77GHDfbLc
 SxarwXCtgS0pvE35GxZzovBjYQ35mDcEqRT+eD84wyCiuhEKhVp/Z2fc/cilG5fwnuIT
 qm9W6sZyN6C+yVQ3Du7331wwIZ70GozSZ3HHdw43vgYv/bHAmzNEnqBmDMuEfs+lGhcQ
 885+ePEi/24lWygnzFqn1Uj96O1EZIYa+gTIfPbuJ5jxULzYjK9/m4KUM95d1jWT+3H1
 bEZgAWoz/HgQl4FIv6Om2xJC64RzCyiXLI4VJAgIedVjHW30R6xcvN3NlW5V8F5XFbjT JA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15as2yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:28:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223GG6la119092;
        Thu, 3 Mar 2022 16:27:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 3ef9b3sj06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3Uel6WP6Y2XdEQii7JXZ/sP5Yti3am19qu1Br0j3vHDbW1PQCtdkeILSKsz4U7qGgdd4FvKHbh5zQvdJG8ew/OPjPCTVL82eTkaSK/x/9BeTdWXsXQwNyBhZ6wwIPIzse++W4b0D6+UNMA7YRUK6XU4klNXzncYGVtW/Y5GO31N8/lo76srCXNMpbakTJvs2Q1uo4zgCy8qjIwUp4d0XNDm7XA2DEQRhXxMGaqNXdaYux/MFKsBjoRjxlJqqRGPHP1bX0o8RlBc0OXIMwVWFlnpDLO2Rm8Feu6zUOetni6PSrDSbyBnGBPJtfUtyNfL1vSOHKLFpZ2Zl9SmCWetfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL4gUxuX1xhIJKyqEsW75T/qKrplKqiWLQnBIOkTW8I=;
 b=bHDTlRbcv4qx3uXaiDBDyxH2SnDJa79ISSKHH0jixI712ntjfXQptaqprWhuV3e7J5E/TMy8FJk8z8Y5IA2JdgyNauy/kuUNlzpELP+yDSjaSo28s7JmBAv+FALz+LFo07mQaS6kfUoxreZlLr5am4myTDxjYXkldRGQUFXg1Fe8Bt9IQdWPbXavdawPn323oJW8xRr6lN5duuI+xRAsaq98TkZOQ0IWwB8ATETVacjRmdgdhjc/o9CskDJa3pooVAPCXA9Gt/RzwENSaToRVKUVAgsCNdDha7jSiSwzdvHpM0p3pQkxdrwdVZ30RFhQMnSrkEngas/s9tY2LFc0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL4gUxuX1xhIJKyqEsW75T/qKrplKqiWLQnBIOkTW8I=;
 b=ChhUnynk+4SpsOMLKT0E4a+75rZVEQ186ZiTUDBK94Mivy7hgKGYIGbZtpaqZpXiFlIY1LOdAWkujnnqvKNrsZLsz4yjLso7WmrAYAs6/02B/tVeVvsGCTpI7D+dxEeuPyfWBOg1/Vc3naPHkmpPIrQs/k2TDbzzw2mKmzM/AM8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 16:27:56 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 16:27:56 +0000
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
Subject: [PATCH v5 6/8] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Thu,  3 Mar 2022 11:27:23 -0500
Message-Id: <20220303162725.49640-7-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: fc3af331-4864-4e60-8196-08d9fd32c62b
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4704:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47042854CDA5851FF1C4045297049@SJ0PR10MB4704.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhiGwCWIE6U6qvmlLbTFbM73B8PLTM5Zld9zPe4V5NMXhhn8uF1965fTH30pKqWVjAGrArVq+wGvARDBa06HJ3REC+3uMLZ0QE2tzZ5VURIAGodK9QGIKrjSM2rZ4aG7dU3ncncx29R0guzBMEGQXNPugxIma+88rL5ZI6aWsHhFONwxtHcf2uTMyp5FoU0JYHv4cTT4+ztXaitkadb6FkC2g4VK88NiR1EXPkosp0Z91lWj5clay6Y9quKV9pM6O0Ndkr5y8QBMN9SEZBxIJrLTCPKC5dGKRStC3ur4ap2CXtIRRq8r75jnOwQKiPNqe8zsdLUpRUZqs5WJ/XTrcWZHPkVB5NHxCKzn6EF1pWpRuPbtlqErdPCcIhKYNvOgJkMZLMvS0VfelucG/asSanEB/yQ9w1Zaiq9qAW3z/kZu52Cbqqdi7nJ41uiHBjjsSgi2kHJxZ1HuhXE96iuMOKP/aF4tRixuwCPAjw/HBXCh34Rcpa1VWPBVibPMaFUW5ukjmIRQtFfenDAkz7V9ARzvG2lgJvD79/aB1AeB1VuObf4IEBO+zLqfBgJ6th6muo0zPGsFhLCeeGRb/ukud9J7BQVS/br5i63HtW/rhhY7Ul4ehFj1oLrnjp20/0oGcjFwme6CvaO6E0Vr/Uoxf90dVJbWqXOKjfpSKkRiBUb1YofFehE8dKu6rW7gOwxD4NIHmYiJ+mVIZjsohjRdsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(38100700002)(38350700002)(8936002)(1076003)(26005)(186003)(107886003)(2616005)(6506007)(52116002)(6666004)(6486002)(6512007)(4326008)(66476007)(8676002)(66556008)(66946007)(316002)(83380400001)(2906002)(86362001)(36756003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3+PoP65wIn12q8/BP8oSafOXCI+qrfF4njNZTb8o6+inryEjCsHy4+MTuZwa?=
 =?us-ascii?Q?cU9QKKIbLlfuMm7kugVUF6G/KYHxVHQtNsdHs9trXA1ZYOhwXcpeO7AZ5Viq?=
 =?us-ascii?Q?TlnUtjbp3eSeMURK/mQJmDIb7SRdSOeUiQgH/9d+YqzeyatzVoeQ89mfYBps?=
 =?us-ascii?Q?NlyjUu/WX5NnThAfSQaWedxYyZCQHx5EUEIxEcxUXc/d4KBa9YKM2RagZA3k?=
 =?us-ascii?Q?RoBUpoA36WWDrVAMIERIdiZrYDKoWa85ZWpLXodcNwtvzJi80V9npoUiLzKE?=
 =?us-ascii?Q?YbTd/hDVyzNGOv3n7tt5KqHn9ylpKLwY5ICBuLyDp19axHLffJq6fYJt8X2k?=
 =?us-ascii?Q?MHyh1a5t1NH7ofq3ZaB8FqEgdg8XC1BhfT3Z5DSOUjIEYm0O/1O5Vx1W8Vva?=
 =?us-ascii?Q?p4a7axHHv0imlTYtBv129PCJi8VyY91b7eTLnsAut8RZR3sp9xGe9nM0fBnH?=
 =?us-ascii?Q?c7jdCQjQGyknTD9gkpwZoSMVEH4TrZrJJ7L9gnd0k98PYRSXesO+/mVRBtGJ?=
 =?us-ascii?Q?SJVlzvvYddUvOvNCnDbhJ0O0QJXO0uPr4h5Wy+qh9o+vJ6UbDZ3zJLi+1llD?=
 =?us-ascii?Q?BtV3eXCqUp0I3uobZb8ZQmSWmceIRZy1ufVgw7pCy2cPBn7WHh7WIHKLw20G?=
 =?us-ascii?Q?SlM12Tn1KMu3kYnmlznzTzYaCcZPKkaoYos0jEGszdzuCqd7ZO6gcjk3zKnL?=
 =?us-ascii?Q?FJ/U/E2/ABoNePg2QaPVBiaD/w9hJY5OaBmTkzhLqaz646GhJXMzwOpXTF7m?=
 =?us-ascii?Q?HaRpKMAboPplS8VEztgA8i6tI306E3lD7B7O563vWoXa3ttheFcbvTgTjcg2?=
 =?us-ascii?Q?vhkoV/Ojm7ZLstAXgyGG8gG00herbuF1gKxJ/h0LyHi/StWLvshIWC5XBXld?=
 =?us-ascii?Q?EA21ZpR+cSYkH5YBCvJiGtIfFkYQTRyZJp0H4fE0ST1MbP2ibS2NYZO6Z2BX?=
 =?us-ascii?Q?rDPdWWQJ1GNlhl+Yqh9DcSFQJzA18kc37lklP7eLIK2oLhu0rpdyd9b/9U7V?=
 =?us-ascii?Q?zsl4W5lYtFxmrIONjPB4zWqqKwrZJbHYGVL9hjMekb8DnS/T4/t+G2FDPPc7?=
 =?us-ascii?Q?9861M05fko+sZc0FU/Z+UXHG74W1tubTpwu4/tb7eP07HCu4TJPJDNyOc8K4?=
 =?us-ascii?Q?fTVRwILIi7t3IAd3by7RLngaRhOXAVO695xBobUMWZKk3v7E88P7lzjjwOtI?=
 =?us-ascii?Q?mQM7E0Shq8edKG/D7MqFCJ0iI4BI8DTyDrc/gNURpORjYaMWIuGUzJe2Lerf?=
 =?us-ascii?Q?7q+smUMcDYy8J41fEPCgxN7OaOFc9QVLdmZ73XdII4RsrE9/wrYG3moR+SFa?=
 =?us-ascii?Q?sS+bPthLuCbc0vaCODBFvzOKplxARoKy1vntiYv59/d2AMoru1tnpYaL+01g?=
 =?us-ascii?Q?A/jjVVpTnzCTfyXEyo+WV6YszKrmPkAcDaM+eZWUx9jdvMra7Axal+g+28Cn?=
 =?us-ascii?Q?m5CIT6Y850XHOKjuzAzD0PT0vYKXcgHkDFXJAeVZsv5IyfCddDlZewjCyjWH?=
 =?us-ascii?Q?tllaq6BSZVc8+dzgOHysJRY7+ekdy4gmR0r3oNvl/aq+X848MjTj55AoAKEj?=
 =?us-ascii?Q?geQlC57swrf1gewHvTclESREbY+O53+iE86aYKPO5ieb7HA8XTLuESjXVId/?=
 =?us-ascii?Q?9T1PcH7++WSzB9OJSCDH6SWxoxPbjCBtG7Zg6eC2R6y9vBIFkrknIz4OV9CE?=
 =?us-ascii?Q?3AO7og=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3af331-4864-4e60-8196-08d9fd32c62b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:27:56.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5o8p8DkCBVjpReAYtMG9HU/S8Dszs5Nu/Yuj7r38yvj20jnBvSZ6irl2f4hW6Naa/doB8mCuOf9JzhHY32AOAM/0ewYVrZdJ0PqCpd7gYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030079
X-Proofpoint-ORIG-GUID: gC-NOuP6BiQ7FVaq0D2a1rsvl4cCymsi
X-Proofpoint-GUID: gC-NOuP6BiQ7FVaq0D2a1rsvl4cCymsi
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
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 10 ++++++++++
 kernel/kexec_file.c |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 76959d440f71..d3fd51f2195c 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -522,6 +522,16 @@ static void crash_hotplug_handler(unsigned int hp_action,
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

