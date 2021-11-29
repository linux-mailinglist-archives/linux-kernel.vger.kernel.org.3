Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C42460FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbhK2H7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:59:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29650 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240514AbhK2H47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:56:59 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT6O6Mi025582;
        Mon, 29 Nov 2021 07:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=sMkKfNGuulMLodYqcjPbDPCZBkuZjGSFfCLGykvn2HM=;
 b=FUIKEM7Qk4bHJrvTm4t4Mu0wJ8W/TqGGyihG8xe/dNPZEbfDtZQ8vCRnkkMdq014Zv2l
 IZRInPn85FiNGxqKi8h6tJ9kgrwnTQHna6UJ9Rdi87cedo14g25i5DWsFkD7VMTuxosH
 cKWHYRbIYEjs/lpH37jSbsq5fd8qfb/Q3NFEbwQm4DvCt3ZNqo0roR2hmcvAjIwd7Fgd
 WhLJysKO04lj4bZFV5UVHpc5qA0CIbKm4XsCUEOHkImi5R6ux5AgF4887rSAoBypLoaF
 7kd0UMq6IN/YLNT6A/5AHBOs7ajcF57m/87F7tD+syf+GxjEDJDfV0yNey3uv1o4hSo5 QA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ckd7u4s6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 07:53:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AT7pdbo026368;
        Mon, 29 Nov 2021 07:53:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 3cmmumn1f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 07:53:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXU4AvZ5C+oNE/oiRGwumlqZd82oW3zPEJfbL1eefyySyx5eGdv4JAgElrYO9EXsvoSzAgvXMe3GJLawSSg1gM8BR75T0LPFZpMH9IV5WZUkDRDQXsD/DljGp8Uw8MWycSz3HIbe5VC4x7wH/oDcWqdGfXK/uTgyO8T+ujnK34S8OT1Zwb7E33sV9imeg2kYca81LmRuMMvOXTuftszctR8U4pitZAxZQg9UfdF1kwfLLUScVo5FfoIt/iHutMZCRROVL0EognhVlmBRHw24gujRlxW07l0zOcRs1vy91z1D5biFQcFDRY7CBuBeMBuAWM0HuJwoN+xYSrhfqrzzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMkKfNGuulMLodYqcjPbDPCZBkuZjGSFfCLGykvn2HM=;
 b=YlB6GOPM0elk3BQ1z7u2mXErb/Je1m7NxOD2bKYamqcWNpFquxUXqAqMr2j4vJFLgSk8NMcUNVsUbk203HeEoCDVB1gD++y4vC5r+fUa18hqfwjdIJ/O3DQ4PdGS9Lh26w6blrDOrqGyNJOXBPaz1Gf2IrnUmPjbFg3b6cTftcPiVZPzBZ9uv7rCHeK7sDdhruwCJ2NV4K7QbmhiAwivSrclXuz/Rj9YBHopK0/oweyED/kqUjjXQbJwQitEM9YCK1bbuNd5tr7PLdozPnFLQ7QjHiEb0YPfNJ4snoz3QX4B47WVMwEjDOzr1CNsuX1wCtqHk8f1vYueN9plEiU7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMkKfNGuulMLodYqcjPbDPCZBkuZjGSFfCLGykvn2HM=;
 b=zAgsnqNft4phCDb/u+Xv8vAZD4FTT8tsq12cnTrC4rsoz/LFiQQu/b9VuZFoMGyLB7Di57GcjlAPrhbpGKtZxtZMGWdzGjl3G2s0PNIFbUxVK9bzzfthTRD9ik7pp7M1n0Es02/58lMyL605dbPs/UX6gQwqU77QvWbftojSvok=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4513.namprd10.prod.outlook.com
 (2603:10b6:303:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 07:53:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 07:53:33 +0000
Date:   Mon, 29 Nov 2021 10:53:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: net/mctp/test/utils.c:15 mctp_test_dev_tx() error: use
 kfree_skb() here instead of kfree(skb)
Message-ID: <20211129075314.GP18178@kadam>
References: <202111250652.KJ5iJFpx-lkp@intel.com>
 <0b6aec80835439afe62010a4228fc1af49f68e2b.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b6aec80835439afe62010a4228fc1af49f68e2b.camel@codeconstruct.com.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 07:53:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02224d99-d1c3-475a-2dae-08d9b30d57a1
X-MS-TrafficTypeDiagnostic: CO1PR10MB4513:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4513FC9AB4E9F6813158719A8E669@CO1PR10MB4513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQpqYRBIl9SnaUCRJ0Jt4zg7zbENOOucy0DvygMiBAMiyYuEGZTTOJS8MM8AXziL2UVpEjmXvq1wxvSUxPYpgF/a5ZD0vxAAaOh6FUWlXdOfk3lvcjUT392RsXEMgG4HhyzktZaZH93ql5KxfI7Ourn5u7f/JXpDGYfhSlMG9ZFcFahWIN27ukbkIjLasI+5uILEhSNCD/j18Uvd/3bzfIZcEHdUE0uB92vPdJhiVk+bgag31zu4y8rJ0whZRNql9mPAuG6VbOdRbB62YsBCPnlDCNa1shLeCba3rd6OX0oaNsnFux2UwP6lejuT0YKx1QQcAmdrXB/a4iH+h72xdRIP7/l7JjzWGoZON6A6SzH9W4DtPvoj7JoOcSXz3G95kB4yIU+jVsR8aM5SSVNeUMwGjS63MYVtH0kx/RjIFs35vbVvuqnnFTMdQXiSqBVDtY6sP910Io3vfIvanzbGFiEU1RTsaG7ZhuIcsmM9PrusUtojlPRpeCLnlZ03l++d0EdMVyFAhsnaeWiQBUEkXC1OzGDu0+WRDdOY76x5GbH03ByRs5nx042emkDZCm4VGRnD98JTi+Ul9/yw3jPoMu9IxpBHyaAs3WPGbmqEGwfBsnlEVdN8d7wJd8DURYzDmlhtWzfhhdfxUeQctZ18Dx4v/GafdNr+8uHQr7BogAarA6/nXoqIhfIE7Y/V1kUd6V/c+V2O730F1j7bDSRznw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(6496006)(52116002)(8936002)(66946007)(44832011)(6916009)(508600001)(86362001)(66556008)(38100700002)(33656002)(316002)(83380400001)(38350700002)(4326008)(956004)(55016003)(4744005)(33716001)(6666004)(2906002)(1076003)(9686003)(66476007)(8676002)(186003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1xr/TYSVe2Nu8KZK0YNTNd7v9YsSSVQ9i7wYOPUMQuds7hswsdGwt8fndVfA?=
 =?us-ascii?Q?NBdDWrQVKCtOMLG3FohqT3v00MasUYY2rLuc7ygTU77t1vHGTKhCYcqrnOsa?=
 =?us-ascii?Q?8mwf09xmITWpzgXazQjCjpHrvyxtucO5yUHY5CjYr1O2cM0P27bvyGlfK53M?=
 =?us-ascii?Q?NQvtY1xa1HLQNHoyPUkmjAlJSTHl05Y/+8yUR+OORur4FVwNecaDo3UoAUTk?=
 =?us-ascii?Q?xx2+Opic+KARiAxyFcJnf9Olasyjyucu7suwiwHPB7aGiZ/QiTY0I5P5AFKQ?=
 =?us-ascii?Q?AipgCElNFzA6bhpCoptS9j7J2bXnWXKhJbeiN0vpifomEOMIZavGiTsUjTA8?=
 =?us-ascii?Q?Ztx/Ql65ylVBc5A0r3i3eNmO6EoCb0LBF1HYAmt5SruweFeCKaYo7Ptx2133?=
 =?us-ascii?Q?LG3OFE14jjm31bZ5RTA7fZ+UP6ifvukq5BUaotvN4gQp7yd+Zmcmjv69WN8O?=
 =?us-ascii?Q?Z7FK0TyUtsX7ob1hAmU8lsdYQQA6FO4hNNcLHXiZ0y+lxgLu54gCMk9o832W?=
 =?us-ascii?Q?pqlslALZdfkhmiSdAy/O8VnHQhIZh+Rb7D4uDjgbcg1l7U4wrSGJMgHjot/P?=
 =?us-ascii?Q?fLfBcqlf3xax89pz7RyFJvlFndoFSHrBBKi/cqCoWi8Rh7SFmbHw7t1WkvQ3?=
 =?us-ascii?Q?L4DWLkw8oxR0gX6AF4bVFuc6oS5qAVrogEcNmhBoZe2Pxq82w6KYv79cAtpN?=
 =?us-ascii?Q?A0a5pqzKyE1V7vzTHJAFddvdoLxJnXvhOYP1xTcc5WXKhwy7n3pjTXJQBEe2?=
 =?us-ascii?Q?oPxcV3TQTS1raEdOgTKAlsb8nlSC+VCF0VA28MXZUJtj/5gvz8UGwynlvLNC?=
 =?us-ascii?Q?lfzEu6DkG6iUD8cmnFLZPRn5WGdlHR2SN30npF1RLQ3ts+oxcFpREJ2bSjwG?=
 =?us-ascii?Q?OU7Y3vBmFDU4hgEH9Xk9ARsVC/78ZHX5s6TXt01hxhjwhTwlaLU0gw4wAM2J?=
 =?us-ascii?Q?MmInfkNPhhrNIIRuK+G3B2AEVknVsiA1eWfDHzp5mcthJnD0IAX4W3AVdBwC?=
 =?us-ascii?Q?MswfMmDYb6APo9wq3uhpmHAqljCCY/YSb/iptcuC0huQSLFSHVZmy/T4kHLw?=
 =?us-ascii?Q?HS1xIpgiJFvefyUH9YeE1pDypnhobL/NNF6xZlmtsguVdj4fcAcRh9n4Dig6?=
 =?us-ascii?Q?XBGEax03sbopXgNZmkzl3jFQbv2xjt4W9CBlH+Qw1/ldr4pIBine2d653O2+?=
 =?us-ascii?Q?RmeLpZMs2g4WlviDd/K69y8I1UrsYEJ4EJgNWnBhqzRbdOr0O1m7HdwpAB8y?=
 =?us-ascii?Q?zB30OZ44WG3zbR/QhkIBbhdJ07SlMMiIgepO2kgO6LaOavqBBCkecT3uQQex?=
 =?us-ascii?Q?hB83CSHq3pU4zDs3jGlNKm7e1UTzaiVQG5Yi4llNtoBuzaRlQfaEInSxqdQj?=
 =?us-ascii?Q?9IKHu9f1p1B6+z42FGnhuhBhYXprc2jGdsa2zxR37QYs1Bdxiusyvi2GK4NW?=
 =?us-ascii?Q?yFvQagyEJ/zsG/gJvE5DLz3Y1xa21/j0pErUGU2jAprBa9JOzl47BxO7aCI/?=
 =?us-ascii?Q?9eioJgeGCfycfPFls924hkUHGVokDPYPEib/m2xsBgbc4tXh4sIaolh1LIh7?=
 =?us-ascii?Q?LPfu4Q5BUP+UyxuzQax1nUYfUxcVKMZTZLlqGSMily6SHBEZHyB7CYtAR4kN?=
 =?us-ascii?Q?LVUDTy0LFKzuyP80qRxd+e37YSaa3LU50IbkXIC/WBAf49eekDO55OxByyJU?=
 =?us-ascii?Q?CFcGMe4JTtEXz1spWfL3Gi6T0BE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02224d99-d1c3-475a-2dae-08d9b30d57a1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 07:53:33.7652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04mKKH3z0svbcOXgBWug0CjvqPetDFcI3zub8jQuOcO2LuHKvSVi+/PvUSR/xTh29HaeUG4f69y4HuWtynq7UeCw+jtAuzQ7NLn4HLuvHfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10182 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290038
X-Proofpoint-ORIG-GUID: be_jh9Uyhy4KsUB-Oa_sBL6yTSFmXFC5
X-Proofpoint-GUID: be_jh9Uyhy4KsUB-Oa_sBL6yTSFmXFC5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 10:24:15AM +0800, Jeremy Kerr wrote:
> Hi Dan,
> 
> > smatch warnings:
> > net/mctp/test/utils.c:15 mctp_test_dev_tx() error: use kfree_skb() here instead of kfree(skb)
> 
> Thanks for the report! I've sent a fix, you're CCed.
> 
> However, I can 't seem to recreate the smatch warning; could you include
> the build command you're using for these? I've tried with
> 
>     make [...] C=1 CHECK=/path/to/smatch

The CHECK= string needs a -p=kernel added to it or it won't do kernel
specific checking.

	make [...] C=1 CHECK="/path/to/smatch -p=kernel"

regards,
dan carpenter

