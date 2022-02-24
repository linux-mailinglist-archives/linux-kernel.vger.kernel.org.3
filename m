Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5CC4C4722
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbiBYOMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiBYOMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:12:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F78165C08
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:12:15 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PDbiUB019060;
        Fri, 25 Feb 2022 14:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=1qEgM5jHGxsSaCZ5x6T9NvLqUPGs6EZxuIPN4dZB730=;
 b=aTHKS4iXNbd1hY4Z+GSKZtZ6u+19xjyK4NvRsq+T92giHjw3JDzZcryV+YhFIF6XGI1F
 Pix3Zs1fSKyTym1y933nOBoW691L5kzxtyJE2kpNRApcNBPgS+FXOQC/RrELFaDVw+jD
 p21HTK74EjoSGaYDlU963GaelRmkffeGOqDSq5fm74/NAEpsKR/z2EF5JwD0JZFwKsgI
 im8pHnwQED5dNxK+Zte+thrxXebHRiShvmgRfsgUaM4tg36H99fdlmJPRc06yi2TwquU
 yXPcQSPQTJzynoCfiV+BHtu26XqRvO+mejjVJwxajPo0EuO0pkohjuVhdi0NP1Ypy0yr wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eexj890n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:11:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PEBkAd061343;
        Fri, 25 Feb 2022 14:11:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3030.oracle.com with ESMTP id 3eanp08u4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:11:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyZ+gLNKWGaaJhhiaYPWxqqUzErKaqg/6qpElj4Tjj+Qi0fUuk+u9WHIg2WAfSxPJhJaeSGbH1UWz5zvaV732CiIlB0IVG0TLNBtgkp+83TJyahNlxDGDC5w0n8Wqt2dwE1HIKP/94g+4Z7X7ztbt93Mklh/jBwZH2s/2Sk57WPa9eZ+Zv0RdddVN52L3rjTTresBkgZnds/+02Mv16ytdm9JwN9fD6dwLQkEF0aPs3Axr4O7lOI2/QBskclmWlxJzMyRD5q06n4+2kwxZ3XcDKMb0OQNjo1rOukCw1gGPMVqspbtHFQmGzd3ByNDZCqGKglMvRUC89FqbCI02PZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qEgM5jHGxsSaCZ5x6T9NvLqUPGs6EZxuIPN4dZB730=;
 b=P6+YHaooetueg7Q4uJd41S7dTL23EOpEkPVFKlB6ynhmQl+7Siltw73za3MynpkoOusxJnFpGvKrd1qBxL3qlLbHrieaFVT4sTf0dLgIa5Gd5LZRQNQG2PxfP460/r4/a+uVEWxF0oAbRd4OHkEM81qQ2sMC7XID+g/vcE7DURbISblMRCpiXNccBW/r9LaTSK+zo0Q8YfwNFE9PksnbgLM7gyzTaWHFzSD6wNuih2rI0JCfYh0A0jApAc9ss6GdEa9xsNKcLGn4i1xBFiw+UvgVdRwBxlfln7rDptc+/hPEGC8UCdkFbpF80D4GFIuC9GphMV2c1JlEsbRowuJ7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qEgM5jHGxsSaCZ5x6T9NvLqUPGs6EZxuIPN4dZB730=;
 b=rF5rHx7QZl3Su2iz5dY9GgdEVH+oSn+CrV49lrikWAqbm7WlIHdKAUBPMAu9Y7+G9/nw2vqVizjcgmeT65QlMtIDbmKQNL7EXbdHNfo+ZQ4eK+dqYFj7lEkK4avn11rYQTDNc9QM4SxDNxTuWv2rt7Jve8N0bSv7njm85ckN2Eo=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by MN2PR10MB3328.namprd10.prod.outlook.com (2603:10b6:208:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 14:11:55 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a825:7455:e3c8:3b65]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a825:7455:e3c8:3b65%7]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 14:11:55 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, daniel.kiper@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        dave.hansen@linux.intel.com, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v2 0/2] x86/boot: Fix setup_indirect support
Date:   Wed, 23 Feb 2022 21:07:34 -0500
Message-Id: <1645668456-22036-1-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::32) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8fe4f2c-0ef9-4dfc-c158-08d9f868c715
X-MS-TrafficTypeDiagnostic: MN2PR10MB3328:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB332892518D10BD5672FF4E55E63E9@MN2PR10MB3328.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkPEFBTdhRyYK/IGJbSjI2mx9tPTEApTYJ3Z1IISpDDQdXou7RHY2F4hu94PoSzfHtQzsWKJVHf5wFoxtLMO+N2eMjiqDkYYNKbupkBZJSf6KDuo+BzYZooNhPeaoKFgwYLtXUZXf/Lb/dnAnaxVYY8sl7AU91chd0xQ2GuFtTRXkJqx/6r+Jq/FwEZe+6OTBym+ij0/GA9m+E657tpTSyJw65qSojcdOcNh6NV87ORUEoKRAn6GmPqb1F7CbNyg5UiNfJIyjaHttkice9hDKnopFOrwDrW6zZz96EeNALnvFBc1c4FwKnGCpgcw6z4DnA5vrbCgShLF1U0O7O7zXcgg+qiOe5nUVx221DiL1MfZSOW0TAozD6GU9o6+cZ8vHodFpysBlHGnmmpNaBjt8qLwRCKfUb7ughka+TvgtH/GsYN9n7c9RtDtYnfbSVRn/1zy7Vanr5UpS+kK5YWxgKwjXp86yzE5KZYMShM+YNuhb9YdDjvWFCLHr3sKN05AwRJiyqxfkeJkgIc7HSpUOi2ZuFfhmux/syTtlVE4IbHQlH4lzVu/U33kZvb9948enuHcMX5muAZFm0tP737mHV0FJVlDSWUKGU8qpAGuHXexKUTNDBm4wa3EnIUchr1r35oTLD47q/7C4+JDBEOHzfBYTlnd9agzPwZgjYLDH3jihTxTNEJE5TJV+nPY4qjux8pBTCGU573INZkuVjV7wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(4326008)(66476007)(38100700002)(66556008)(2616005)(66946007)(83380400001)(186003)(8676002)(26005)(6506007)(6666004)(6512007)(52116002)(2906002)(44832011)(8936002)(38350700002)(36756003)(86362001)(508600001)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iWX2GmVV4mo+v77kr3uqXkD/3olaHEDNpuI536+FMdM1+FUkBzfzKQzq5HSI?=
 =?us-ascii?Q?DMlLM8OyKH8asdGbvDw58jqW9Cuwih+XDfoIXvARbHA/y8tzPC7u6ci9mXBP?=
 =?us-ascii?Q?Qxs+gStX+b0tGP6TwMkBzVTw/30pU6UYHpKgLdJ2lBH3tcyraVJV3QDbFR0H?=
 =?us-ascii?Q?OYefoRigUR3zhdgIrz7OLNoemoTcOF0ol/VYTfoh4fKKX/B+uMi9EeYUO5FH?=
 =?us-ascii?Q?spVi+dIvAYqHFyL5imru46VktIX3jyqyTJfZ31mNSB83uFi2nmSv/+DicyF/?=
 =?us-ascii?Q?iZOgYexLIWKqiKTO/oRKeNgFdz5UAOhi9uavPbx5Z0CaF7RE0ICsXyxyEZX/?=
 =?us-ascii?Q?sYwQH497yox8AiMjAigishDn4r7ZDK6J5l8rTGSyY9YkyVyjZuTrIcv8ga/R?=
 =?us-ascii?Q?UYFB5K05lEzx72kt1dIr9/gMaQXIUWUuDyan1BgQ7jd94FQOnCWY/+4spbIT?=
 =?us-ascii?Q?d3ZtF42nLc1g9B5Nm0zWJk+4HVKeF7CT1x/qL6KkTKzvk5MXn23k6ocUX4R3?=
 =?us-ascii?Q?LNVBDuOJ2G0BRr3+2VZUTAC5ZUOrKKXrCo6+WlonCP1++nx6u0Ojj5nirjyt?=
 =?us-ascii?Q?6hK3j5deDbA87iZULaAYXlmTlgJe04J5n6qFzn7UFHeGLxHuO6f3uKCv0R/8?=
 =?us-ascii?Q?8MBgv3jnlHrMWydq+mCBRsxKZKDh2amBCk1kNOeveATtFh6x0BjumJUZkl5u?=
 =?us-ascii?Q?UkWBUUwxani85AZpYzjgvUeOwwuwTz2IK+c0Z9ncpIIHgoWSYSY7qVqNG1nB?=
 =?us-ascii?Q?5V1c2x6uix+cUb/oMxlITG/HPytnvdFBXAr+zqkwLHQIG87d10CCpaa7qkuI?=
 =?us-ascii?Q?S9bU6FyJQ3EMl2NIxV2FRk4Ab4TWZ3HSPIsrfkPcUJcEPli/PkF8SdTpTFhm?=
 =?us-ascii?Q?6ZG6XdmvdZXQoEtb7MqN2dKMx22SQPpcN6k0osSaQ+leFkxtq4Qld/jetYYf?=
 =?us-ascii?Q?JrB4+lrVvpqtk2hRsYl9xWFO+AJZoy1K56WzlOq7YPoVmw+9MqT48kt24kUV?=
 =?us-ascii?Q?YamTueIEDbs8x38DQ0pAD/tJLpvKEKQnXpekPXXAOFsv1ch00x1ovUCR3YeD?=
 =?us-ascii?Q?NGyBXVBeBo93GvKxI9Gbq4c+vM5koeFr4xB6g4JPbH/pPIEhNn18Ryqwhl11?=
 =?us-ascii?Q?VJ26IE3YqR2aM5UvUrHIcw7tF/8rKCwKe98+4aqCCvOIEExs2PnCAQAg0sqS?=
 =?us-ascii?Q?OO+jHnF5BlHbh+tcN2W5bDq38Lqi6cP/gHTAeacVrnM+5mYEumJSVtkJRzx0?=
 =?us-ascii?Q?R+dh+QqRtkMXpnAcVEoNXqNV1ygF1Dixmy+C8dXhJB646lyXF9WiFFEiztb6?=
 =?us-ascii?Q?hY8s9qhhjmS2f+3JdX9qSUAGJNIPVbgeb5Jnp0bFVAAzMkNUj5Rk1UxLbrVB?=
 =?us-ascii?Q?gNe+WtivaAGMy9m5Yr4KoYVnEzwToIe53VpVuB19kD/ZDjXuhcuiK5JxAWmh?=
 =?us-ascii?Q?vYk4GSjUyNqem+n2WqgXf+WLd5tPxeoJuzj912judAztqyNHQ4lCDaLEGtnr?=
 =?us-ascii?Q?YF88LJIjRZW+XnRV7uGTF6HHHqvuPxj+m/Nwi1V5P+z7Tsnnqft2PCyb7oy0?=
 =?us-ascii?Q?+2rox2JCkR0/fpfbnrhDRiF9tV0+M6tYIyKeAuJYjahoBmJtu9rOL1xGgBDY?=
 =?us-ascii?Q?JR3oQg3yr5D4No+74IDwKTJrztlvWtqSSDEgv9iyhvRgV0suP4zDThY6RhuC?=
 =?us-ascii?Q?r/4mNw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fe4f2c-0ef9-4dfc-c158-08d9f868c715
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 14:11:55.2983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zygf90QIGXFGMmUxLO4FICuzfvU9XEbQujrfqEmUXculKlPeHUT79YqIhUCFSSYP7xNXEaTdg5uxnFHgWf247DaaANvjkQUSU/8s/ee86Kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3328
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=690 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250083
X-Proofpoint-GUID: OsETmLM8W6PqNmWOxmCAeS6ihRmtF_dj
X-Proofpoint-ORIG-GUID: OsETmLM8W6PqNmWOxmCAeS6ihRmtF_dj
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_indirect support for x86 setup_data was added in November
of 2019. Several issues were found in the implementation and these
two patches were created to address those issues.

These patches were originally posted as part of the larger TrenchBoot
patch set but are now being posted separately since they can be merged
independently of the TrenchBoot work.

Changes in v2:
 - Add checks and failure modes for when early_memremap and memremap
   fail.
 - Fix variable declarations to use reverse fir tree format.
 - Use local indirect variable and remove all the inline casts.
 - Misc. fixes to the commit messages.

Ross Philipson (2):
  x86/boot: Fix memremap of setup_indirect structures
  x86/boot: Add setup_indirect support in early_memremap_is_setup_data

 arch/x86/kernel/e820.c     | 41 +++++++++++++++++-------
 arch/x86/kernel/kdebugfs.c | 37 ++++++++++++++++------
 arch/x86/kernel/ksysfs.c   | 77 ++++++++++++++++++++++++++++++++++++----------
 arch/x86/kernel/setup.c    | 34 +++++++++++++++-----
 arch/x86/mm/ioremap.c      | 57 ++++++++++++++++++++++++++++++----
 5 files changed, 197 insertions(+), 49 deletions(-)

-- 
1.8.3.1

