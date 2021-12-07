Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3E46C3FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbhLGT4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:56:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7420 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231747AbhLGT40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:56:26 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7I4WvE021491;
        Tue, 7 Dec 2021 19:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=rUdsA9g22QpLXJmRgI7qOzXk2J6vD1oZ1HyrwpPzMFI=;
 b=pjeA7s0+2Dhg182yBAXyyZDye+eVlrkQGu5d9BbfIYXfmTthg5zCx9l1HFRuEWzn+xeL
 KvuZBF+MXsr7jvWF1jKUW/4/W3P2Ec084cr53QLqpZ+LPJVQ7NJim8mB4VW/7AjoMGec
 7x5X4LYxmv/m7AvV9QMPl+hZl5k4d+AA/SHnRbRXibyZpOO/Oio2nH/hUsot+GAPmHhg
 uLAUiH4FR/EZhyVy3B+aMGdsMVWmSGU+mtNBaFeArg3PDbXnStR1uls14MwoXIm90cWS
 IXuYswuycPbs7L+6JjQJSKz5vbJiZlHBRiN5oxf3PiZTAL3NXqRo9xwLdmRT2urfIIAS LA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csd2ye5r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7Jkffa089622;
        Tue, 7 Dec 2021 19:52:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3cr1spgv3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZHHrt5m/Va8cbVIKZ+PlrcKW47bTv9X4EJWkOjhMsMYGY2qHTRbXhpUmdvIVIqWm1nY/pIcTMdMDU7FM3KX/X5VwxqdHK6EfzHf5Hm6BmFHbLcKTR3IWvxSx6CU1vRA+yh39r0NKOaQqxjUKp6+MlS6fnOWfWqeWKK6Q8cwnYzJhggBXKLtyviJHMXfZm6akq+98E9v+/1k9gN+OnTgTxXRCqZth+0zgVETZpRDCAaxvjEgknz3qFQRmkhyDAfuOEm3CBWAycgLaQ0tEPJQQcZkp6NLZqWhZ+AU4Np55f78E9X3WUz45Cvk7UQQgsBIdYZLPBWhayrZetyAINLoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUdsA9g22QpLXJmRgI7qOzXk2J6vD1oZ1HyrwpPzMFI=;
 b=kVJoAYsWRnYUesLJ+aCY55yaCjQq4TGZhMHvfy/n7FB0g97yv3QD62QF3zoRhYfUuefWGJVKNaKeMTj+qwjz10XG6aDaR7nCuVCpJMkMEdRs889KXiYF5TFhT8GFj8mBVcWoJNEwPQ/PQh+hU692dJTaGMZWFuqHYZ+JmEUshTlh6+1kcotsi6W1qjbjy7pI0ZNeW/XXIcXJcBhximcK1KOP424zLP39JBZsxdk6Aenuz1bZmtKM30qUQg1FpaU4Edw0cv1RRSFK9dSCtVY2A/K4WZyb24Vuk4WDf7S/GyErPQhmOWbNjFSAPoySxTIvKhpXVEGTybqa0slN5fBF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUdsA9g22QpLXJmRgI7qOzXk2J6vD1oZ1HyrwpPzMFI=;
 b=xVCGJ0UnF9anBkhnePqI4Qe0aSdGRLEjvvJLA1IEF7DViX/o8rqDtR8u6nYV3TcCL82UBWNlStsayfHUlmwnZuWUrlzIu6JShtURwvKK9hy1nJgVRUaB+IK0PbgULcSNxXHQDIuqepQmoWg2m23nll0pkkvKZclzY8Zpb2kXtnI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1695.namprd10.prod.outlook.com (2603:10b6:301:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 19:52:23 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:52:23 +0000
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
Subject: [RFC v2 2/6] crash hp: Introduce CRASH_HOTPLUG configuration options
Date:   Tue,  7 Dec 2021 14:52:00 -0500
Message-Id: <20211207195204.1582-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211207195204.1582-1-eric.devolder@oracle.com>
References: <20211207195204.1582-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0210.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 19:52:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6156558-17d4-4518-b097-08d9b9bb1630
X-MS-TrafficTypeDiagnostic: MWHPR10MB1695:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1695F7EBADEE0B190529AF38976E9@MWHPR10MB1695.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V32FaySBLBvS3gqqRhtxVHcOKLIgW6vFM6mRNmPCihRwSU+hB8jbnUXrwtV4txf0GlX68XoLe2gA6vuIKLPLJ6VAGSEBISbmaaR0/SXImQlxlU6YzAmbVScHRMdtrciuqYS7MqI8Dv6YEubeC73VHoqgCp0OATCqApsR1QLlkPean7iiBkyjz8TFcNOMiwsrV/H8pvm9pgFSo2lWVScRpbJb0p9WRDfNROU7Cp5DzoUIQt/I9voLoLG64a/GO4I+oCROJIeV0LaFSACnZ2dV3F/2zYdgqEMhQdTPz9m6kgAvnwJipZfRJvmTfRvyNcnMy98DmsdJ1ZFXpdC7253ETiLpmEk4Uq1OSK1Fqdr7uNa3BfkkeziyLFI5B3El69b46ZwYEXgWpr3WME4jhDPVtFkaeNmrlUyoh/RY6sUqJPYJLFo4lX5cDtqME2oaFZv7cJebLuzUVshqmDkhPPRc0SBB7Cm+nllCnt+PVZxKhiP2fG/whONotuL5E51PrzG5AezK5GAusd609Y0OrXc6rHo5w5NCNEnE7HyrZr4Bba0qSv4KTROKq/zqlMH+GTQWNe3mpqNFgAAeVHWJzdGXNGs5FM7dSVFtH7sxqCJEngTU4i/pcawgZfVVT+DkP20fhSj2iL7Ueqszeu8ZzIrvy7g7NCYRSQClkk4d9E4Sv0p2PCCXnP9yLOrwQjCOXMKLwbAspMPv2U8KRm4IA5uDpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(508600001)(7416002)(6486002)(36756003)(4326008)(6512007)(6506007)(8936002)(66556008)(38100700002)(2616005)(52116002)(38350700002)(26005)(186003)(6666004)(2906002)(86362001)(956004)(107886003)(66476007)(5660300002)(66946007)(1076003)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2PIqaAvZEDJgXHMw9HleJMT8jAKPilAHIgFvmqSFPMC6wNeLMobsB077OC/n?=
 =?us-ascii?Q?hKdsMJZXjloSzmlzpdaWkueo2OvFxJDZnznv7XrG8kemdhobSdw335hV0wLY?=
 =?us-ascii?Q?fz2RmKEDNqXycCCAEhFI8796wLpCB0kWphHoBdab6ULhiIUD/KPEAhKr4YjJ?=
 =?us-ascii?Q?znXuDQaBfOpm0jLjVGT8iTFLdWGFXWGCwsd+0ouVLx5OmMtiefUDoqrLp0OS?=
 =?us-ascii?Q?ZEbbDz/5S2II0FTRRKEu9afDDcrkmU3czl9hpyvi2hezWqgJujHg6ryq0bdL?=
 =?us-ascii?Q?/5FZP7XLHijs0PXcIqNalMyBSSSRWtH9HImSeN9QNVS45kE52T7d10YneC3/?=
 =?us-ascii?Q?h5tJHBfczrh6exB4UjWf9diAHkZWGjxbFuT83jsL6vmT6vJFgqnStb6355nN?=
 =?us-ascii?Q?MbgWSrhgNqCFllJbP3d3LZHLVfQaj3rx+xdU3b3KU6WPAJfmEW0tH56wn5Pb?=
 =?us-ascii?Q?JFQ1xPeGU/f8sAqVKsUgh6xFK2ISm7NzRRZFy1Ma1IDqPvsM8oRfHC2LTYAY?=
 =?us-ascii?Q?oOTsEh3sJVEavls4/Wlm23QLJQYo7IyMR1vlTnHw5laosQeHbgRzLt7cR+y3?=
 =?us-ascii?Q?ljEsIcgasBfYLhXfAmeA3CFCf/pPbV71PIVoy+7MO3bro/0Jzmtdw63iCzAZ?=
 =?us-ascii?Q?0nYZineuY5AToNZ3AhsRfMux9rwi7EEZhomgHSYMp/y8Pn25tEQQUj6KU+pw?=
 =?us-ascii?Q?AvjA1U5uvtxbItUdtMy7kwT7AXAo3I90SBg1CTIMzQWfQAb7t30ekd1PyLOt?=
 =?us-ascii?Q?x88i2oB9xYSiBY+6RSJYQ3wPsskXEmDb1Ty2NYDUnKQPngFNqcC9PEPbNA2w?=
 =?us-ascii?Q?WpqOV3XxzUZCufXwkKbZU7gnqRQnRDcN0aUBhMKKSZ0YXFz2zFhI2vDn2fep?=
 =?us-ascii?Q?1wFHercsp07K5IJg1A2VfHxLA64YWVQy2KVA/ru9FENEjMnzLuIM219R2Cx2?=
 =?us-ascii?Q?HVQf4/2gmBe/zfTzggcgr4HgOEgy3hcLixYZPnbh1DzaWOtJgrg/EtzfcdiT?=
 =?us-ascii?Q?laeUEnhpEWAW/Ta5j8CXiLdb4DLWIoSjg2I2JvEarkNRs1BJfjhWdJx278RN?=
 =?us-ascii?Q?Lde+Yp/d3rzxckVFNCV5o56ualaNCLwMpbexlXUqB2y0L+xG+KJrjm2si0E5?=
 =?us-ascii?Q?qWCkV+L27zbrbNBH3BavqOro4I12LrocoAnWmyRAEHof/kYLCaPfoHim2E2j?=
 =?us-ascii?Q?BxzhHsrXvyj5Jozo9XSd+F1qiRIsGsQHPrQPt09kCTtLT7nqdZc1yrL9G4In?=
 =?us-ascii?Q?W6Zy4dgrvuqkSEnLjB+BnkQ+34JjNn/+ZDxEmAaXMuN5U+md/Dn7Y+eKQtBB?=
 =?us-ascii?Q?70aiN/HoUDb61BU+ReEv06APMGpjenvrOkmEPqSx9ejP5VQxDcbixoKLBrHP?=
 =?us-ascii?Q?tpaNCPMb7gTLjS9rgJG1PRbylg1ir02L29osLoNyrKgPZerwDLqKdS0btoyw?=
 =?us-ascii?Q?H1cHdDmW2RJBc7NJRygHZQ9MYS4d//gUE334JnyEFjKQlpXKFxW7yuVLNmr/?=
 =?us-ascii?Q?NRUlSBsTLfTAA22OExccnOC87aHFqbTwMZSA/ao3Qa/gHh8B6sZHYlcVEFoE?=
 =?us-ascii?Q?PIfeslYs+8kFNBOooMFk9QvGkFRGRdSsnx0RxHVcCmEMa/+/IxKAn9Eo0p8V?=
 =?us-ascii?Q?dL7Qtnht6cNe+SlrfeNK6HBlxF91LSVqFby6lvoR+6Wvue6Z+Um7PS1OcB3M?=
 =?us-ascii?Q?82iQrg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6156558-17d4-4518-b097-08d9b9bb1630
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:52:23.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJoaKGSqORRQI0f5Yphn9Vv5iWXm01CMwCQyfLktLUMFxq4Rdt96+BqVauMGvP3+fCucppJ6k4unPXMT3jtkU+lRAIi4OHZxkmIA4l81Q74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1695
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070124
X-Proofpoint-GUID: t8chObVUc82D7jsBlLE0roOF_eqsy_k8
X-Proofpoint-ORIG-GUID: t8chObVUc82D7jsBlLE0roOF_eqsy_k8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for CPU and memory hotplug for crash is controlled by the
CRASH_HOTPLUG configuration option, introduced by this patch.

The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
also introduced with this patch.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7399327d1eff..901b4a6c50c1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2046,6 +2046,32 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "kernel updates of crash elfcorehdr"
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
+	help
+	  Enable the kernel to update the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions) directly when hot plug/unplug
+	  of CPUs or memory. Otherwise userspace must monitor these hot
+	  plug/unplug change notifications via udev in order to
+	  unload-then-reload the crash kernel so that the list of CPUs and
+	  memory regions is kept up-to-date. Note that the udev CPU and
+	  memory change notifications still occur (however, userspace is not
+	  required to monitor for crash dump purposes).
+
+config CRASH_HOTPLUG_ELFCOREHDR_SZ
+	depends on CRASH_HOTPLUG
+	int
+	default 131072
+	help
+	  Specify the maximum size of the elfcorehdr buffer/segment.
+	  The 128KiB default is sized so that it can accommodate 2048
+	  Elf64_Phdr, where each Phdr represents either a CPU or a
+	  region of memory.
+	  For example, this size can accommodate hotplugging a machine
+	  with up to 1024 CPUs and up to 1024 memory regions (e.g. 1TiB
+	  with 1024 1GiB memory DIMMs).
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
-- 
2.27.0

