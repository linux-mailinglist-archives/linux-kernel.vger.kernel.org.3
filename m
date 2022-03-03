Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E454CC2B5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiCCQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiCCQ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:28:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA376659
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:28:12 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223FFeHH011426;
        Thu, 3 Mar 2022 16:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=LbOYsPhRQ77HEGflxIK/gU0GHxpxWyXlTJarZFQk3LHIvrBACEde/wCulczWn5h3LPg/
 uNVZ0Aetc//y4qQS0PaZHoQLK+EXqJ3dNxYT/HULOw2x6Rx94JarUkU5AVEjpEkuhBXH
 l4bnjnzejdDiVSEEyqvVLvKMlOCsAVD+fWO/QrfS3Hlx3a9hXAoyw9yy7ATb9T/pTDPM
 wN8rRD/is27/JKHBB93ArFkOoks2WEqsCBKEasikX28jADkcs6+KGfz2CP2Rch+BwR/B
 VFhcnj0/ACJTmK6mg7cXfL8uQd4GZS1PI91W1Dys6/OBZzXGYqi+MSWP3k4Rg76H/N2J HQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehdayymyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223GGxW9100083;
        Thu, 3 Mar 2022 16:27:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 3efc18yyxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1EvM1U4pU+f6yyPoY1uLR4mghViJ5uPY3OLcFEgA2p4TnrNIaELBPSoVSwmdEp0f6JOjlBltWVnaWWZ3nSDuP7dQHzSaQU7oGaWjrIHW+CMQGBuMJ3fn3YrB5BmldCNQQSc2ttp+megyR895ZYetV/hhrOlHOCGPM1XYdtZRIIMuAUDg83HiDTkQL8tTJhFWVaXFM4ZIvGq+RvM7ph03shPIXpTP1hhsSgUH4hQF9zkJ3fPMHbQTCAhDOOuW2U9F6FLMAxDMk4K8eH9XsugPPEUtMlgzm0AYb/g7/T2DbKfzXSJQaPMhUeIJE/X6blOu3CVGTWpZfoo4ONa1KkAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=iE4Ybuqn+5Pf4pdA6VeDdRkk0lb9R9PDZs6nAkmS/IiLER5IpmtQQRffuccSBecWkYG74qMqKlPFRZ7OgFvi3Dtos3xM3XYbqZF3X05neTL6UmKLFiQT46c9dMJjwwVzBrEwpRgxspfhtyW0qQN1239s0ugAEjAXjdm+SAHtFffW7Xdhj2/pIvoYzRIbxdd4grUnXvKfh0p/KjAQIsWbxAMfmxwJHbzjYRvlZS2WEItPSFOnt5+tCJVwrTbgTXoloN1dmAs+bchWaeuUA/qHpqW1BDsM6crA//51cUaSbVlkX1hFeTQ+dSHb7kQru0323DLpIggbKhw3G9xefhMdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=qhBNuDIegcgBL6hOlx5OFu782WWYRe7QWv/RQNE6vXTmjqqvT+zP2oQSI8F1q6cf4TeNGuS3YmNaCgQJ/1uAr/KbHwDmZ9ouIGIPtTGxIGtlG4qUwIJO2eyyuFuqo2jbdQywOfV62ZkvWx8/0Z25br1d+nnuCw7SMdDbserfZZU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 16:27:43 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 16:27:43 +0000
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
Subject: [PATCH v5 1/8] x86/crash: fix minor typo/bug in debug message
Date:   Thu,  3 Mar 2022 11:27:18 -0500
Message-Id: <20220303162725.49640-2-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf2a8357-04c4-4560-9e78-08d9fd32be04
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4704:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4704B1CD970379A16CBA9C9A97049@SJ0PR10MB4704.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NlZs6cI0iAraYl7iFtV7uEDY1H3NAN+sx6Fq/6vemiLVHjCShn2L8GE655ZNvvMhoECAJ2QcKRr4OR3iwuFIqzpW5OFEdjH+7qOcgR4Btbwpj3w+aUgiAvFr1pE18DBzBW2psOIv3J3LsYxsQ6aptSJic30qDWfOetzjOYpv5BV0AJ5MVs4HXjGK6w0YDsjIp0U8qQNuMDr618FdmcmR1Rd/Kd+5qxHCGpIahstG5z4shY1qPinrsJ6DGMLHR1iweIfx0aUbUUqO13SuO4vu4xL2CsHOLuCOOJMZbBbNSL7rcNQZxNSZNUrMcXTgd7ij74LksII/GuewI9qjneJNDQdbJ37QIArEVo4ZbjxQDqnbwOyr9BddkhTlTKvgwvJEO72uw8c/8NcBtTfhDAkPI0f8VLajuKVbJlx+TxG+U3y4Kh0WPq4pm18i0XKSs5OVDRWYfANpT8Xmx1xSNI5xBdRNiRz7JYjNXb7OzdQQ/EE0Wze0GhstQenJV9WLg3KOZn7iD3dwInuGklTLk4f7v1lwrG8R1iHHmbv/V5Svm3n14e9rHYNIR3xTCQ+WUtcRe2zVLfI6ZzqeLvWbX2H7v6TUHqhRJjOSr8Yl2ve6FPIFYyRmw7rH2YSa2bGzAsOMdtlE9ZmxhFbOlC+nDnG2ECyuZajFCtV6bru+YkOZKmQhtaFp3CYX540gkA90CRGZprtzAnVuiWOM+9qlyLkYNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(38100700002)(38350700002)(8936002)(1076003)(26005)(186003)(107886003)(2616005)(6506007)(52116002)(6666004)(6486002)(6512007)(4326008)(66476007)(8676002)(66556008)(66946007)(316002)(83380400001)(2906002)(86362001)(36756003)(4744005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p9HB6xf2bIhUy2zdbS4sSY6bPB2OcO15LRa2FTcBBoWBDLu/04sxv5JbINKG?=
 =?us-ascii?Q?VO3a7fCmqL6RdCP7b1gU4wM8nNvCZO2eOoFVQ3B5/ex6KyjR2Iq4cGvEwWeo?=
 =?us-ascii?Q?Bk2YU9eXsCDa9d4U1899uZReqcHpDEtTJy9HYn0QaY+dlf565x0/q60W/MkH?=
 =?us-ascii?Q?hgSvmYHRM36vZ/K2/wmR/1SP6Nnjfd8f/oTrKPzopuLnjNESbvF78BAgNO2P?=
 =?us-ascii?Q?miME+T+ARLO+SwnmJYFRds/AvjOfI0bDDZNw2UUz04nNBweV9jefaCMOaruo?=
 =?us-ascii?Q?+eN2NQJfK+50M0w4HIbs/Sm+arsm0f4oKS+WJbQMcdVuk4Dx01FE793oOV2D?=
 =?us-ascii?Q?rnXcgDYvnzx1dSGEnl2QgaNHfJAcn/RCYTEaAK/UpXxRV+dN0HW06jWmTJqk?=
 =?us-ascii?Q?zBBgkWAQrK4IUhl9fQcWOYqYhnomNROuZR9aY+7VzDEFloG3S+BxtIZ70+L1?=
 =?us-ascii?Q?7rN+7MjfjNNmP5okEAPbeDVMOt3Skzuwzim2h3ng0aspuriyntGvor9AbHZG?=
 =?us-ascii?Q?OaXydNqDu7pSCRRANlijeJ0G14xFYGkV4SnFkXmUgQ9AfSI/dMX6o1zVXcRz?=
 =?us-ascii?Q?Fo/qji5EZNUB6CH5m2iD3ac24p4vDF8LokqW6vCbOiLoE4IQU2Q9SR7DqGzh?=
 =?us-ascii?Q?vmVF1XYjojmw+jmm6pBaGLvUlErvtpBdHZR5khSp5M6AzIPzPq4GFdLI2C/g?=
 =?us-ascii?Q?BhT0OQ5qRcHaPpVQjMPvqp0Bh3xiMiBm7RiT+fjvry+0GgDVul3d2DdA/JyD?=
 =?us-ascii?Q?qJq3Jcwa1i9cTeyxEMd9uyDjBS351hb5RsF5DWGaAg2WhhEbXV1kM+OVlhBL?=
 =?us-ascii?Q?GOj9HPR9gjRpKjV53dnQytbN7idxw5fugM2SC3KNWvGvgqnPJaUZd4990LJe?=
 =?us-ascii?Q?gnhgfTz73gdQboIn7omstlAth6hZm1BMGEfJr/8LVUwVR1GoC8acj5D3VvzB?=
 =?us-ascii?Q?vz8A+DVeLP6H/RbXry4pXPq5AWqKiJ6IKSv7rS6RxNHNGj0uYmjjmNaJP/Po?=
 =?us-ascii?Q?RB+9oykhJMn/IU4XUjyz/bk7z3HdqwS+FmfwpXIBuVN0WHUqokcng8oaD90y?=
 =?us-ascii?Q?vwlxfV6zr9yjE4AJDk5MbFK7fNCHNW3PPRS8YLyvLaAHb8t/gpqUb8VGyPAK?=
 =?us-ascii?Q?3h4AlnActSScO9owYZ/2V76dAdyAWo4/FaX92rSW3yOAoxxx8tWVk4b+G49R?=
 =?us-ascii?Q?AnT1QJon+E5/2yOP0vYRzJQ+mASlc8yKOqmdSfKd1BXsbk/buCeVGFSUZ4b9?=
 =?us-ascii?Q?RyvSmjOInE0owUc/ikO0E9yUC7f8eEvSki2Q4SoeTG/IpV3Zx6vRWroxiYoo?=
 =?us-ascii?Q?QYTrL/E8t2AcCi8+dQvAVTB5P8wOzvoz1Ar3abOCej9LvZ+j3+9uNRNtmYSp?=
 =?us-ascii?Q?2tD/7UWby1NO+tNgxbc5sCcQqokHkM7GjSMbb1AXGZafFBHhx+VI8pISCRcU?=
 =?us-ascii?Q?DGsMIZvdj+8P7WzjG6/qnUoMV/mFNnXTohwIR1I4F66zre3BuR2DEeFDHnUk?=
 =?us-ascii?Q?gBBY/UQ5oIXiYxvjnY2A9gMkKQX7TArpLCPgJh3QBSUCc3tkcjDp7bFMpAhf?=
 =?us-ascii?Q?I+PFcdCWLE0fT0D57+J94UCwSElocsW/vK9M3hUtnl8dKqLq33yHNHToAHNQ?=
 =?us-ascii?Q?Yi+ZEnFoSKn9tW5ZQEwMlcw0zsZIQEL1fjGCvapo/jyRvPVxpDEReqbvG29V?=
 =?us-ascii?Q?46QUwg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2a8357-04c4-4560-9e78-08d9fd32be04
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:27:42.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5vLFa2q68sRSwelYGQyZUM3I6owz3FCk3WMKNGM0dZdeGBla/PjzPGXaH192ZSLWZlsqNsmLQ4BoRO7tbHmzpk66TaNgPqD1DHPu58A6lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030079
X-Proofpoint-GUID: HqFM4eGigeboitHGTOTTvQfRpvFnQ0D1
X-Proofpoint-ORIG-GUID: HqFM4eGigeboitHGTOTTvQfRpvFnQ0D1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pr_debug() intends to display the memsz member, but the
parameter is actually the bufsz member (which is already
displayed). Correct this to display memsz value.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e8326a8d1c5d..9730c88530fc 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -407,7 +407,7 @@ int crash_load_segments(struct kimage *image)
 	}
 	image->elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
+		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	return ret;
 }
-- 
2.27.0

