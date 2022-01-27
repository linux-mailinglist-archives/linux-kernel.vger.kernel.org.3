Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D0649E824
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbiA0Qyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:54:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20552 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244142AbiA0Qyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:54:44 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RFtubp012353;
        Thu, 27 Jan 2022 16:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=IdL9rY2Mi33HO7jw+Ww1bRx5DNJKuq/voejo6HBd7Po=;
 b=XfpTheAVh4fQ2VZU5070pC5uoNqklYJUsSRqWEtMyGGnDyWogDa8CKnhRzrroYIYqahA
 oTSbOwKcE+dQq7FINrJltmPM7NcoFlsrQtxPl/R4IBPA0C14aO7hPBV1+UwcIMIaAFUW
 i9Gad+v8jGp4b9OZvQ18CZLcLwdIUXAywOskAoZCBQcBYkkRlHXYCKNR5VN3DvM553QW
 I5sDWvV+ZCCFVnZMDtBYWm7ypiQe9wkLLmnsV4lsVjM+Hi1BqCkm5LsJf5mGx0CYWfTt
 c0jNM0sizC1Id2p5dQ+G+6JM5EJ/VVyZ7YsxnJ7i+PYOxtqH6S6hZHcPG5ZR112PhgtJ Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvnk8nps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:54:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RGUXVk037157;
        Thu, 27 Jan 2022 16:54:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3020.oracle.com with ESMTP id 3drbctv1kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:54:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEosKj3bZjUKzi6IFACjt2pgA61geuYpM75F6lYZqWEzW0xOTWDmypYG/ekitifqn/PnXx7V83sEsv44pZafw4Ku0TyfspMBlYvU1MixNyEp1HX4n/h1a/HeKcZo5UBLrCVO58vKsPG1Cg2eotNSyaHPhaL/UiEMDOd7mDRwzooTqg5/6D6Jj5E4AMTjdKUphDq1OkBlFJbs/iV1fO1wvdFjYD+VmiKQXlQljBUX0GT1Gx71dKzpieg5HQEpw31XOq39zoLdcYMGa1pkZSS+yjhCSSOz03tJt+1DGrg4eu7X4O1+uP5xjD5JWy1f6g/2lz/M8PewVn1umtmrEznhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdL9rY2Mi33HO7jw+Ww1bRx5DNJKuq/voejo6HBd7Po=;
 b=NY/S2YLhgSm9KYRKcK2amkvPlJ6NrYTfMuD6dBdVW84ky8SEimyc/sHcSbUWjJ3FWmmAhPbB+Zq6p5tHDty4FJxHYjM75OG8kjmo7hdxVpp77fcwA3zse7ad1RoqMMZTePEIZh2BedpS1i0EX35/9LbFSTGvao1TnMK+7z0OCbciXTf8kbvuWJhOvs4fJIY4yYB0xJh/9wDNpv7KXjK+UAAFwO9MXB7pVbgPagU95xULnPv5/xlXOfOhjL7+CQtFGMVVVhRq6cagkpjaXvZUlqjpHtB3s732u8rD3Z/jnrU2nsheSXaIJDm4EbuwWo0dwCMpCftUZKK+isXZGaGB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdL9rY2Mi33HO7jw+Ww1bRx5DNJKuq/voejo6HBd7Po=;
 b=lkvP3P1kE5q2Dy9ukrBg7Mflj+iP8zlvERP+3KqcYdWX9g1w7mcevSbB347U4oWiREWggakV1Yas+5EwM/lLApH/qzyspY3hn0ML450d3FyO3p/nH/xXLZ2n29/xIafh1VACEUEG8erPgP5972ataRTfNhq+LJb1itGzt0/yIAI=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 16:54:15 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 16:54:15 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, daniel.kiper@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: [PATCH 0/2] x86/boot: Fix setup_indirect support
Date:   Thu, 27 Jan 2022 12:04:14 -0500
Message-Id: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::30) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7fa909e-197a-4fe8-eda0-08d9e1b5a672
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB43709406EFF17EF20F0246C5E6219@BY5PR10MB4370.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+YLlf7kQGTJWDt9NOW3QYmOsYU0TIZcxN+ms3Rl7tHlubmmDT3+QEnId9SEF6EmYKr+GSB9WMbq1ciyproRIVzz+iwtvMYpXR6uN7gTHcbspEsBQxGpEeOCyMlNqVglPINGHzv4Wn96iEk+U2K5M4o2wAAJVL9xmJ2eYAlg4L9MzBvBhaxz842feNL3MNVaopJaf0SIuNfUPZTSZbzMxsgLp8OV3eg3N4pzYWEXpgCQM5Hs0g8EIxjEqJ6l7MoUr5Q4bxVUPEfAKK9y8CgGX4BDEzefIsB8wwfg3RzGCn8yIlcwio7IaM4hEIacgAhEVJlIuLzwgp0V68ObCm+ahSSLfOPhhSsqHypATuj1KaU4jSNDYO61ePyJpp2TdIqCc2D3UDLxsRFEGb1wkkxEsd2Hkw1cyAtxgup3Dg0+MDn8p8GDn2PRfL81bh6RBqd/djLoT5E4M9K8EfHoakd/bIsyudJcNK1tiIqjWxLbaROinQRfXTsXvyXY+oqCMrcPiJJJZbZm1XjHLBXoGxjYz05RW4gnU/a3CWwVszgup5/Vpxzf7AnfQS7URYIOY8ILLsDW0/6mGACkP+fQM6r1XgFaSZkpgOIDHbolFj0t9bH+oydq96BYguGu7UJ78UNHfNe89BQsFVR5TPeoIjQNDvNGa9Ww5RNWJDWTpb8sGNJqj2U8yy9rimC2UMWoj8sPUr1fxfTdA+m49fVnim+eag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(5660300002)(38350700002)(86362001)(8676002)(4744005)(44832011)(4326008)(8936002)(66946007)(66556008)(66476007)(52116002)(36756003)(186003)(2616005)(26005)(83380400001)(6486002)(508600001)(2906002)(6506007)(6512007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h9A4D/zbzVX6PO7DoMsmYlG27lvhlK9R/kSFTT0jlowV+tqQUuRyYNNAi43E?=
 =?us-ascii?Q?Xwo37ZFb91YYtOjYe2lr00CyR9v/WJRWJHWQ+45/16KhFeTjYhhkgnNCQaA/?=
 =?us-ascii?Q?IohLJZ7GN51aF2Henm+SJ2/1+QDDC3dOicAF5dws404P+rpayRpiYFvwv/8j?=
 =?us-ascii?Q?CG8n/2JFeXe4d+ffb8bYdCVvid+GvzVx6Sko/4yCyQGxadVG45k1FoNph7g7?=
 =?us-ascii?Q?yvjRywrikVdvvKDy0Tp04W6hSrSEOTmx66hdOIJlwmwKKHTtn9PpZ+ucfIfk?=
 =?us-ascii?Q?0nEjv6bJGPGHuzBI4JILBedYrK4HumDdGjI31JfDHwPDRe9900bZjv3aKf2p?=
 =?us-ascii?Q?Y1yd4bnMoobAJrZAbS3+sXZZLjiPH1fFH+uBvt8l7uLOTq842F63Kjj1B5hC?=
 =?us-ascii?Q?2UjgwdOUf3UT/f79U/SGOnBruc/tn7/O0y6RikZyyqKVlVrIV/S8MqxiyUu4?=
 =?us-ascii?Q?+oAnQb4wFG0Yzo3oEv1eygVHM/86k6sIfgCIFB38p1gWF32u0mE66P6kPvQx?=
 =?us-ascii?Q?ZHt1TShthZZK0vFmC/W3UyAwQ8yy6u6kIfgaNs6NFBwqqCQIVgmMn8TQAE4r?=
 =?us-ascii?Q?ao7dtpXo9AOK4NFsGDbrFPxO3NKvXZFXX1bH1Oa+hHalj0BgE57j++2EwLzh?=
 =?us-ascii?Q?cz5V+l39E9Wkjzcp20bm0SWNLAVTpu0NK3lLzpP+miYWpfDR4l2oCs8jFu7W?=
 =?us-ascii?Q?eKcbpyuIuY8PSHr9vTlNLnLvDhdN5SYe/w3ISsaniK1RShEo4ZbfgdJUaOhJ?=
 =?us-ascii?Q?2O/cqT7iFvmjqCndZD5FvDT0zpOziHlVr4m155gi6IVsIkQggh1lBhH7RLAE?=
 =?us-ascii?Q?wT+DyZsA2BEzxTpZP73GB6VSnebeXAfsw73tNuOJFtNpQiaJWwLqyhReQ+Gh?=
 =?us-ascii?Q?QfEijqd7oo11yJkddFjA/aKWrD/qoAePlJp6u4x95xk74c9yaS8k1CgMLDfk?=
 =?us-ascii?Q?y3Rw6NVNKF65KIGvxC9NKBX4TnxnxB9y4GwF8ZH0bWadX6ekAMfBJ7dGsSuW?=
 =?us-ascii?Q?5JduZzJaXjhUQ4y/8eu7qazC+k3ZbG/ZKQWVpWla4oZXSfs8hWlnjVMLlXtY?=
 =?us-ascii?Q?DAjoFTGmqvbI1Ak8/AbtM6T/tB64LX2k3WHSh9e95+w7mezScgdSLm3h9bdg?=
 =?us-ascii?Q?wLn87nzQer4n+XTfi5SUTRCRO3xXvrmmKkNU7PvCkXzeSUXOCS0I0fOGbo9L?=
 =?us-ascii?Q?B3TpZwVHjVbRNn7kbRST4+Wu5+X9ZZeWBCbvs69Mhe7KYiClr7GLHcyXL4fW?=
 =?us-ascii?Q?/MEs9/tZ/sAb8vlXusmEWuhA2IPtE/izfIsF7mQvMYiOBesIBMk5p7jvgUmr?=
 =?us-ascii?Q?rVxvxWf4kE1vbjsDhuH4F0/CaV01wFRObcg82iAn4g+yEsojx1NgPrlAD2zJ?=
 =?us-ascii?Q?hMZBk1SgoCj8jKXiQNw/0JYaM+PLbnCnjDu4c/waY5EHAWIht/DzzPOBPiAd?=
 =?us-ascii?Q?qgyf0ArS1zooTlwRk09kL1okMldGnEVLEkHP11sZAQi0K/qTTk62SzbwhmmG?=
 =?us-ascii?Q?2QNwCLjvtfaQwBIAGHReS+a6D1gaZ1NgkJdsFGOn3maIVnFUAe+84/zfZwV/?=
 =?us-ascii?Q?P8WncX1HAGFVCuJPONO2kezhh3qn0H9R/dXvgj/6TPgXxgl+i+2kBRy6Y2gU?=
 =?us-ascii?Q?vOelGKYdgbFOZySxH46xEKUGn9IXtVHbJqiaoWwaMh3CihUUfoR1B9I7LoTR?=
 =?us-ascii?Q?Rzey1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fa909e-197a-4fe8-eda0-08d9e1b5a672
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 16:54:15.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbtQ6VwTgQzVS5d2hgPnlNWO/yCnEtEkn2EsTknriXZGZK7Q9jDonUvhBisP4kq3e9GTqkHb+5Ixm0beUZWbxMb5ymcTiFvEBnZ13OqahjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4370
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=809
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270100
X-Proofpoint-GUID: ZN6fVNpZdCzbd7Qviey_GUyU9E5F6eok
X-Proofpoint-ORIG-GUID: ZN6fVNpZdCzbd7Qviey_GUyU9E5F6eok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_indirect support for x86 setup_data was added in November
of 2019. Several issues were found in the implementation and these
two patches were created to address those issues.

These patches were originally posted as part of the larger Trenchboot
patch set but are now being posted separately since they have been
reviewed and can be merged independently of the Trenchboot work.

Ross Philipson (2):
  x86/boot: Fix memremap of setup_indirect structures
  x86/boot: Add setup_indirect support in early_memremap_is_setup_data

 arch/x86/kernel/e820.c     | 31 ++++++++++++++++---------
 arch/x86/kernel/kdebugfs.c | 32 +++++++++++++++++++-------
 arch/x86/kernel/ksysfs.c   | 56 ++++++++++++++++++++++++++++++++++++----------
 arch/x86/kernel/setup.c    | 23 +++++++++++++------
 arch/x86/mm/ioremap.c      | 34 +++++++++++++++++++++++-----
 5 files changed, 132 insertions(+), 44 deletions(-)

-- 
1.8.3.1

