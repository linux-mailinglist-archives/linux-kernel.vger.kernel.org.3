Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CE24D9322
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344730AbiCODt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiCODtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:49:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65E1C120;
        Mon, 14 Mar 2022 20:48:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F3VgZW003078;
        Tue, 15 Mar 2022 03:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FxxPwtg+NxiYmANlmtXseSns695DdV4mzCactala+pw=;
 b=jT8QN3ODZ1tXddhFS3aXXNI1crKpPiVyLcORp+oROFznOclZPLY885QzRE3JpSl1u2Yy
 QAAj4vqCjrhvhgc3E1YahMlWiCe9oqjnVfM5Wsa+q520TQnLClorTsJqSyvIfUzAWsJH
 YleA3lUZ3yfPHDslEuE4L0VVNmOz6xZ2kxaEbrUmzwVOUh+B4iskq4Fza1nXgWL+1U+Z
 99HzaJKOv4O2F1kYqMl5nCF0zBB0ZqJdX0LB5dbMyVVkiAo2KUN91qv/j5giFzXxwnk5
 RAa26v6SEUH+nYy717nPRqXS58D6SjOF82VK0KRDy8dWueCT09IH5SWLpEDSlx0wbays pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu21dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 03:48:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F3konY177964;
        Tue, 15 Mar 2022 03:48:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 3et65p8n21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 03:48:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9iLhRTFt81mwBjbQ1jpKPQZlv0z4ivPC1bqe9jT+et+rw9lcBCvOBQCwPnyw3QClS9AZ+sxQFKSqMnNLEVSEzIs4ggUF7WhpWBF2J/tAGbIP2spvzVbrOsh2jetBmwSGf1hnywzcYE4QY9hw8nAAnDabvbhzM2QiI4OlgbBK5H8O/eYLbciaI1i3xg6n42yX8WRdULl19kAkuTkIiZEjHJXLalBpTADXF6yil8Jx1mzF67f31n+a6MVcXFFhxozk1dW77fajTwPNuM6pR7QsnxDjYPAvlH30iXDCaT6TMt4EVafZNGx1pTissfVmBmqU8I+XmwX4fa/xA6GENrWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxxPwtg+NxiYmANlmtXseSns695DdV4mzCactala+pw=;
 b=Vz4IqRX9K3sISXWJhKRbImIzwtM0jN6JBW1H+ilRnN9GPpnIhK13k9ad9RyziUooo1j322Ay6vSivH1nfTA0UfX07Go1ZYfR8hXQCQjGKOUDAVIXvRNZGxt9+TNLhrGO2gRBsM24Fghp+E6eh75klu/7mK+HV7IlDQugJz/02LETgt+IuFyUh6JEx7JhlCOLaJTmG8804ylK1Dx7x/l3JYR5Yu5nIB/XvbW1xdG+GFGm/MN8+yJs4X/Fqb6kQZ1cEfVnhqtAydPrnEWMjwI5d+SHN+3jKZDSXmSWylcLueBsGxUTLKFDyHcHcw6dy8MemXXKk8WEPIIlN0NVLBOIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxxPwtg+NxiYmANlmtXseSns695DdV4mzCactala+pw=;
 b=TQOHUw8yjCavp1FvZzbASyRuTMQWpVA2UK4QZxnAT3C0jZERIEWciLueHvdBS9u4BvAHfr0ngTWVGgcuITa+x5TP8O+z7T9RcVqBH5INEEEYmpG+drB6X59RghQWzEgYh6/gl9Cf9hlb3XFkvkLwr4VvslWt2w0hkH6Y10MW8VI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR10MB1610.namprd10.prod.outlook.com (2603:10b6:4:7::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22; Tue, 15 Mar 2022 03:48:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 03:48:04 +0000
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     aacraid@microsemi.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] scsi: aacraid: Clean up some inconsistent indenting
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mthrdggn.fsf@ca-mkp.ca.oracle.com>
References: <20220309005031.126504-1-jiapeng.chong@linux.alibaba.com>
Date:   Mon, 14 Mar 2022 23:48:01 -0400
In-Reply-To: <20220309005031.126504-1-jiapeng.chong@linux.alibaba.com>
        (Jiapeng Chong's message of "Wed, 9 Mar 2022 08:50:31 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DM5PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:3:22::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a678e1-8215-46cb-0940-08da06369c3f
X-MS-TrafficTypeDiagnostic: DM5PR10MB1610:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB161054FC4809F0D3879DED448E109@DM5PR10MB1610.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gV5L2ErMaCg1ce9r2I+7tiRbB0JMmEmzfuWQ4aFNmsfGqCnZmWL5sW7/pQ6ijGRPDTyhJ2fj/45dcbVpeLJ7waIBvvLWxwJVmdY4UTnf7EMSU2u7itfjtnKPTkHRCIUkeUML/osmp88mEnEj8pKAxF3rsNPJAhAUpRk8WUwEcIfqWdZ0+r9z/9LNjtZFFdPsr4oHitl8CCHN/nwhW8slhOL5YnZ9lca732rfCKd38wSHfdMIPBDfL+Wekvqsq7PJ6SUPyvFPDJlKAMPRiEwM/sgPYShyg6lWwNNqg0SD9fvEUhQxpzZA9YXnQwOH9FNKuTG3gHvKdQQltCxgKcn2jIbNDYSeqGdjIF8qoUSYoUQ9Je5+cKgszoAZrokONgxAItZZEL3BfsuO91KJVW+U4XeqrvIb1HLYWaKQMSiM/vV3nqZta+QwnOctUhOQLqDJh0wqkARcooDdxMi6gpAG6ZUfkOwcYa3zQKbFsNfNuztYIF+u5nFEu8JiiXwjneZhPP5jjNcePThtXNRzjGz2gDjKBKLVu6KEN9y48VyQGZBuxPT2z5SgfxQ2izLQ2svd2ro9wmcPsFNIxoV76+WSpkiVfMr4nJOl8lWmzvU7TET7DNVRVNGBEh6zc3rta+eR0YNjMOZ8TC+G+XNBHsVlLjyWBvCEW5gd4zMVYEbwtEWujxSFjGUxUwUBCDORuZEQO+8pmqwpAXJ4JJT1gGQpJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(38350700002)(83380400001)(316002)(6916009)(5660300002)(6666004)(66946007)(66556008)(66476007)(6506007)(8936002)(558084003)(6512007)(52116002)(36916002)(508600001)(2906002)(186003)(6486002)(26005)(86362001)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ENPWn7nFiL5GMySjoYatGdf6KPb/8mGRf+KvHKcGSXIIwVGo1bUgCtggPMW5?=
 =?us-ascii?Q?pQ/s8refVSjjX+QE6vmpBYeTqnNcoiZSpRjdZnZ3vW8xoKQjizfwJMaJFaZj?=
 =?us-ascii?Q?D+eG9J/1Lz2TuFZ8Q6rIhKMOdmPDZw6NvDwblFPXatNbW3bHlQaRBi1stqFe?=
 =?us-ascii?Q?3CltojlHqDXlqM1UeAH9wx9QUjiXuNo4QTgopj+db0/3jSDsIdLXWyRwH27d?=
 =?us-ascii?Q?uHmBdUzJTdvzVYTCujPt/fFndrW77qfrIpTiGHJplIgj6KAR+lgOftMwDUlS?=
 =?us-ascii?Q?O+4LivyczCkk0PxsaLNoBIdVAaeel+bDyGGN4PFGOVEZl0DqfD/BslJRjNhc?=
 =?us-ascii?Q?2Ot7KIwqBtaPtXwBg+dtUXVjv4Tfa2Beq7Ac1+0acvANhg8JFyMy6ngeSppg?=
 =?us-ascii?Q?6J6scPnkc0MylZXUCZXMz7PPMMjeVCx0/HsXbBa8szo3LE2RubxIdTN7UiLr?=
 =?us-ascii?Q?jREhhRewAfd5nF3wcjLLoyoyGDTBCzjOlRC1Ln8QpP8EJZQgdk/r7jQtT82B?=
 =?us-ascii?Q?2W6u2BE9gP0HKOnSa5JqEGzcKzUlE0tPL7uUQqOFZXvv9eidvkN8udHx6CpB?=
 =?us-ascii?Q?zzF0xRiDhxALSEizxUerY4f3dQQAMLujTgKlgW8rLPNEHHs8xxRd16fzvkXs?=
 =?us-ascii?Q?1wJaSAiKABpWbB+UMvZMI3tCS7RIAXOCS0yT8sbUT99GJbqw6+cbDKrbv1/G?=
 =?us-ascii?Q?BIvKJH4ha82hm0tvPqo9hYqF3/dROYN4QAe+H4/MmNn709zU6JWB13p96sXJ?=
 =?us-ascii?Q?3e1lGLKhn5i5LX8Mx6ypzGiNS+kb9lvP5AJw/MTp3iZjNiywB9pU3+Imy0O7?=
 =?us-ascii?Q?wLgWUwwriC1gpYFGCc2TAnzzKH58WY41wPIheK9m/+fy43Ix4RNFb3SA/UMB?=
 =?us-ascii?Q?RqbpAMRRo6lfYvXRCXs9BJ8IvLNz1Yt7ZiQTMDYnWN3ccu40b7KAlgY1QGf4?=
 =?us-ascii?Q?PYiHJJckyTEB61jJj8nYRjMfuueqc7mdEihidOgiqtTQPmpSRgFKHT64u5p0?=
 =?us-ascii?Q?4pJLhK69Zp5sjmYAhgtPdkDh/OiVHbjMuOiVV8wxE4261NGuWyY8HoVGH2zn?=
 =?us-ascii?Q?7g7Jy43AAyBPrERKJVfqIZP3O5OqF7vVh3M90X2Y/oCK+mUWLEJpXRZgdfpn?=
 =?us-ascii?Q?9xPGWY1xl0HxCfNjBo4oBelB/cPLAZc5/hwJW+dz89s5AFpEGPN5SF424oCn?=
 =?us-ascii?Q?eTyU2sAd/yEyS63D13mEO1IYDzgKP161o5RyqgCdmA9Bem5W+gBlc4SYYmva?=
 =?us-ascii?Q?hViFwm1a/EKRmuMo9uJw7PDJlTqtvjIVa67Gz9SE+ScfFdAbAhURHu/4O4kK?=
 =?us-ascii?Q?QFpMud+VHtfCE9IowCYiJdjfK5LElXmmUmtIlDd2nLyfKpP34x0UOtclENUr?=
 =?us-ascii?Q?fp+HgKOHzK+SG4XKtWkVr6AAcghY62oUnNm4UvfojoHM1M77e84tS5d1OuZz?=
 =?us-ascii?Q?lQlp53ho5Vkhrf0hYS+oZ5ym7HOj5SYKyQp34/M+1S7hEpzkCljcrg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a678e1-8215-46cb-0940-08da06369c3f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 03:48:04.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4n1mCPHmjiQJmr/ikUhLATOJjbfaCGu4iwNp3EobkZ+ROF50APa1D/+UBFT0cEbTDDz3xwUmnNJ3MCUtgXh+T61hZsqefwpZm4AOCswKhxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1610
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=718 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150022
X-Proofpoint-GUID: H52x_YLgxcQdtLNZ5frrZP6M-TyXVXbm
X-Proofpoint-ORIG-GUID: H52x_YLgxcQdtLNZ5frrZP6M-TyXVXbm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jiapeng,

> Eliminate the follow smatch warning:
>
> drivers/scsi/aacraid/linit.c:867 aac_eh_tmf_hard_reset_fib() warn:
> inconsistent indenting.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
