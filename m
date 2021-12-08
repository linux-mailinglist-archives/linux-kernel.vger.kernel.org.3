Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A38046D079
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhLHKG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:06:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33056 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhLHKG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:06:26 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B88x3xC008483;
        Wed, 8 Dec 2021 10:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=XqWTgFnK2j9x2bv2in6RiR3CbBD44X8Cma3VYepKtG0=;
 b=meBoSMu498UB71Xvq08Kjr7okq0pIJIZDTA2DISDMcPRsw2IyaPxMtJNSNtS4RAi3XRB
 b2jDeZRj50LGTHwd4gPf24CaHvYJBmsbby3rlKby7/noc9FvbRjnHThkt9JzMJ2NLNkh
 FZttkZYirXikRqUkb8C0bbSkw0Xlef4q8syFS3nol0sv9YqXTYAn7jFcU0wG9NzzKvp/
 9PDeiTsqB7vNgkfceb08AhdYn8HTff3YDSprCfNpck9VqczgwhXF9f4VAqk/xeS/8qM3
 nQGK3zWNCAJU8G1PktlsRlcl559F4UuPgGfnSW0qfqM9748m6IvSrx0dml5l6T46uQxT mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcg29m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 10:02:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8A08kX136596;
        Wed, 8 Dec 2021 10:02:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by aserp3020.oracle.com with ESMTP id 3cr0565h8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 10:02:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWKDwu397GzvW6IshITLIC93RqJ7jrbWOBoFnoXeOUiAHIt394Fm3zqRu9QbceXH5sJxI1Qkn2YIl0aITrsPUtBCc3xADSaiAbSMbefdXouBHvePHqQmxZTStUaibgB40S456JNhdCiXBsExNO0WfdZ4u3oeTF/4vlETt4wwQUL7uo2VsTaHPd80ezMbrU9KBWmJKQ3yIBemVkXzUULaOFPw2trjPeiEtqpq2YpSHHJBchMHxUqaxrDiujSgpDCSHdZPrmYMEPYOhPF8HygY3fCI2q/aMZ9uq6dhE0o/XPc8irVia1PIWOrHHCF2uqq4EVmD2j+VJgbbUKHyUGLkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqWTgFnK2j9x2bv2in6RiR3CbBD44X8Cma3VYepKtG0=;
 b=SiQ+8sbpjQstGGzO52CUCLjkspE1Cl/Dfburrh6tHYQZoQzzEmMpF87b8sRgp3NkIT86GYRyZ2+ZMCSdH298CgNulQJal8hvIYWTphwIv0ktl6fFVrVi62pxyDin3buq0+9Xhl2cdzl+U8BUPmqDktVkfa6w0zA9pHv45r2in7SBh+icz/KjTSTtiSulXdZSQyjHXxPGrdg2VcW/QE4+3x3awZXqv0SoagIpQL+lrlJ4jvPQ2TtLJ57pcxZiVMR3778uTx8s1szbkqfjMQlE/z1IPrAQlXGRN28Lm1RLDRaKCec/c5OmnQ8zeZtwWB3n1li2Eblu5vRmY2rONJu0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqWTgFnK2j9x2bv2in6RiR3CbBD44X8Cma3VYepKtG0=;
 b=im4Mb69X/ORkKpgwyah97XRN7gbmJf7jLRkRcEppH0Uew3MeUrQtJTC4V7HYjSdS8CwKSA8goo6XpO3AdTRWSJRXvzz+DGa5d+6HDi8JufuC/SZfNDPPEdXAwSdqUF7eupYq6qtzKgAlB1qsukUi07eCywrGAWBYlhLlFqqtq58=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1549.namprd10.prod.outlook.com
 (2603:10b6:300:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 10:02:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.024; Wed, 8 Dec 2021
 10:02:49 +0000
Date:   Wed, 8 Dec 2021 13:02:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] intel_th: remove redundant re-assignment of pointer
 hubdrv
Message-ID: <20211208100229.GI1956@kadam>
References: <20211207230709.121444-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207230709.121444-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 8 Dec 2021 10:02:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36ce46d6-3abc-42db-22a2-08d9ba31e3ca
X-MS-TrafficTypeDiagnostic: MWHPR10MB1549:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1549D959697F4453CA3E0FDD8E6F9@MWHPR10MB1549.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFFuUbagbj8qXPt6GCSnX7rBs1uH+m1kLtEV5z8qYhZYfrIliNM8tQd+SOF8c2pelQ6ixl48OMhykoXB8z+heb4OKDpaL6gI//YyToRRv2KwgnopbPuDgY7uw2Et1PoCkQjcsZ/jYPNV6vYbYDyqCEp3QBrpCVjcoRHf+UBwVHrnqk4Z2vkqTE/YeEcRMZNv18pu2vYtCd+n6OH4szlEra3yqupTESRiefHTMJCRPDHcXRBTkYxnzJjC+1W89XiezrdzA2teKCjkCh8AbtFLSZNoYl485ukpTlb3U/1vZh5lihfYbHcWWsoDJlKwuOqWFtcVwdN/61aKL7uzb7FYd1wgqNxPaj/8sH+52bjZhhlLv2fjGdXyzDqxKn3R6cEs/f2Ds1yU5PaISyOpdijl8N2zJ2wf0biJi1tRViW3mDidy6UqZPHlNKW3xqLguhGhhz0B9HgCah1L5kTfqYe3AEExONaEAmhwS5uj8pcMzDHlTuDYwqG2LJthbzXPmgr3eFlFO0ObStWJSnfpbiYzy9i+wDOKX3TGWWDcsjWPSoPB8RhRhJsi/A02uUiCcS5kqfCEp5VUIu1iPVa79V2b8JU1GZ3wLGQZhpsWK5TxsU4xI4nn92gHH72GtAPhD6qT1cxXMryZJPsGFXwyNej0jH+F85TrRJMro09Xp6vVbF1G2gUd4z5WHTJTQXBb2WI5Smr6xZW6Y7lNjzE+2OzUrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(86362001)(6916009)(2906002)(33716001)(38100700002)(9686003)(44832011)(38350700002)(4744005)(1076003)(956004)(55016003)(66556008)(66476007)(26005)(6666004)(4326008)(6496006)(66946007)(8936002)(9576002)(316002)(508600001)(186003)(5660300002)(8676002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bFbH5zFvbg7M1hFAiNzgFCaKjxiZ1Ln81UfxxCgVO+SIejS+rNCWGmbgnMWw?=
 =?us-ascii?Q?IzMpriXAdddDCm4CFfQiemd9e4i3tpa/GjqWjplMYN1ZJn1I5TMKmAEz4aeL?=
 =?us-ascii?Q?9GCzSSyOF3SZ8aFv1iiI+jQGLUbYcW0YYK78EbKr3Gm0XRq6p11gUYFreExI?=
 =?us-ascii?Q?XoWSD7v52MhHIYwHM8OF+uTrnBHFVa9av7s04k5iFLoCAfTLUNLQwSpydGCw?=
 =?us-ascii?Q?jPjuRiyp2ipGzOBN+9Dab07XxGB0aX4HgfvrFwuh2SrNCFTkUy/vxuiGitnT?=
 =?us-ascii?Q?e6aUiBxGBVQhkWAX1a5r8wkpYEOIui/Sn8usoPBNqomk3PwU3sE7E8ZIWIsY?=
 =?us-ascii?Q?aqzyI/WKU4coOkB8gupmmNIB+JkssF7EwAMoq9fZVM/kVdcvvg/uDLc8U2oL?=
 =?us-ascii?Q?wGTot4vl/MKH++AzaH1B8B6B3nO3Bovj/3GeBui98W6z0w6JZAnWhFtR/6fu?=
 =?us-ascii?Q?yDC3h3PdIdA68SrPHfzr+cGBI9ACmLDFFGGS4iSsw/0THO5tiPVMs2Q7D4bk?=
 =?us-ascii?Q?6+tSiLpwXEMTPlpWfiS8fX4ojy9Yk2X+nIKv6PvNz2e3h04+qE4kZx+CrOF/?=
 =?us-ascii?Q?UgXnYgV3hwcEnHfOzPvrGdiSCJxUZ4JwVBPlRjBnHh2vxJlRLlqiH9zm3+0t?=
 =?us-ascii?Q?GNHdUNf89wDDvF7T9uY6VBrEFVrsadEKfuOc6zfDa0PrDvywXQ1XPaX4YjFZ?=
 =?us-ascii?Q?tV74WDWR/ZRSWLltWsFemKDPV9inJWZQUqNBYBkzH5JojVa3NqakGFQa9Lhu?=
 =?us-ascii?Q?ob5G2S3MRmnHFjAG/vRGbvdg8j7353LitqGql5Be2K8t/1TytRUBGT/T/xok?=
 =?us-ascii?Q?kBIcJlEgsZAABBaNAvjxi5aK1g/sHuw/nDg+YXegV0+BoxVA0pv4fE/D66q7?=
 =?us-ascii?Q?ZMcfMMnTVSKqfuBw2Jk6HDlRO+a6pQ3f3Us7rpT2PdZsIlhYXOOYODCSljfS?=
 =?us-ascii?Q?DFpKsNiIrU0GWrcXeZ5RwFp4z6sMFo7K8VNCOtTl75uPPVCxbu7R7yPY/sbM?=
 =?us-ascii?Q?APEZmYZUXUoE00SyhiYf5eU0IwGqcNDRwac1pDa6yazjhNcUBf1OeKKO0xau?=
 =?us-ascii?Q?Hg3IymFxC2EtFeOxx24hCfPksLXw6pN6prCs0v3hKxQSZIdMEkY9VuuyjJdh?=
 =?us-ascii?Q?Xz8T2j9N8C3RZDfvRJlQZFioDpDTiBWmTTBm8fWG8ZQBSd4xq2BhBl2GOi4B?=
 =?us-ascii?Q?jkgBvOsOP5n0BHAfLYWQM0qKGqJHTKfCufwSKw9lyO9036MhNqbbQ0v2c6Pw?=
 =?us-ascii?Q?s+xNvW9aQSs5Jo7jvDWsSlq5LX2t8SH4lSUvkaXfV2rSKLAper90Ol3MvKlI?=
 =?us-ascii?Q?d9H8eudMChS1iqQx3kGdIyW4Ad6+RJUjnn5xinXHDYarEW2LC8J8/CyOoxIt?=
 =?us-ascii?Q?zwhx53UkD/ounNK34nGue+ro/7QFGirFYsfJgai7gB5XzHEazdMd5gx0sRz5?=
 =?us-ascii?Q?cf8GnTss2w1q1Ao6yscS6DT3ZLKEiilqNhIEVNfLpuVhVp/nPXNN1kIi2jLN?=
 =?us-ascii?Q?j5TnF0P9F+6vaZqEE24WvBbKuCy2gQTbnuP0J9pcZxSMTD/IbXvZ41LCFY27?=
 =?us-ascii?Q?uuwtLrDSRTXK4KSWJ/LxPZHvGm9P6EA99mJc0f0LpzxRTbEiJiOSlt++gj1Q?=
 =?us-ascii?Q?RVFpekwNcyC8E4u921nUEvkvwNILv55UfpN2rxw2pRlr+7H5+7P11Rv3maEB?=
 =?us-ascii?Q?Vww3d3tCyt+UzJqNDBWrKfmneXY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ce46d6-3abc-42db-22a2-08d9ba31e3ca
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 10:02:48.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nu7TfsCC5hLpzqR14tzbzfndMw2nvVZ1KifgsqK5quAKvTt6UdvhoEn4u+7R2UO4fUqw6GxwNzsuk/2IeElYyn+PuSdJiwzsPQg3hFdnyA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1549
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080065
X-Proofpoint-ORIG-GUID: B-EbHBw5V_FmXdqfw5xc_Yn8VGCl-mBH
X-Proofpoint-GUID: B-EbHBw5V_FmXdqfw5xc_Yn8VGCl-mBH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:07:09PM +0000, Colin Ian King wrote:
> The pointer hubdrv is being re-assigned the same value as it was
> initialized with only a few lines earlier. The re-assignment is
> redundant and can be removed.
> 
> As Dan Carpenter pointed out, the pointer hubdrv is hub - some_offset
> and in this case some_offset is zero. Since hub has already been
> dereferenced hubdrv can't be NULL so the NULL check is redundant
> and can also be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

