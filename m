Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B13486151
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiAFIPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:15:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34176 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236013AbiAFIPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:15:09 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2067Xo2o012787;
        Thu, 6 Jan 2022 08:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=dEgod9P118+sZBItOAP1adXVuQnrIHkqp8/lyG7is3k=;
 b=bxR2QKNx0jxgCVBkRS3lfP5xtkHD5yeJVtHQ1HXXHFT6aYmr3MmhRg3iJ9afPcCBB1EW
 Stp3TdX5aZOCEmOOFJOCo4LYpYNrdZfvfXVz3EFKWEcu13g74BkPhyAMARXi13NFHaNS
 cHYMOEZzydTRL96feQ7WaKJRFB3aa+RgdYzxctrbpsFaUPfIpahahScCYcDXqyC9V7P1
 hD0pmv+UEPiYYCBic9Q65Cu9ONgMC/sa+0QJRg1TME+I1ZFjI8079bXle0Z/xmsCvdOi
 Gu9dOLqTscvIuuKyxK/p7b8s5NpnA/FroQzNHFvGWtzC+JhrALuUy4CcZtf3TWyMrJl1 ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpjryf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 08:14:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20685K9o176477;
        Thu, 6 Jan 2022 08:14:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3020.oracle.com with ESMTP id 3ddmq6bfp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 08:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzVAdv6XpYsGFRrVPrwhpAtKuBY3vHBNPgBMgpJn6gwKkP6XTS+ybI/nGMCmHSPZXjYvAf/tiQfHP6Wn9Bl07UQnJS9ClYOwGeDlRxbSmN2FJOshScirPxyv3HBD+UrMBvK8Y6TCYw8Cmj9Ho9ySWDUF+BaeNNMZ+91e/4Ms+HfjeFHie2o7msmKwNIeJhGrnzLIZyWAKy89uCybljT7GSwqYGNhgMayTr2QWE+GAWlOd0ofotHLzfWHa1wbsI34DsIngdxg5rqw5+5KCNzsgi0MdcQyEZvxYoyBJFQptWvxrbs7Zh5LqxrtPYDs/uU8Mrx8fwRzrm5LelbFo9caGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEgod9P118+sZBItOAP1adXVuQnrIHkqp8/lyG7is3k=;
 b=GzQqkNZfVXkuoU/jj7MNGiYLUik9+lmF17SR/zZmyKYOupKzeDImURDBCcWPjWhmJKz2GXaw9Afpj23UkYrkrHWJBBRCPJyGJxPC1/XZr/WVlzYZoDcz2qc2uXIvcFdEmhCQYiJGDjei/uD3gaMcISQsoTawNFdfu8A0nnUhPelhKUZIDCgvWs5L7Q3nKtrx9yZ3KxNGBlQOdccy8AyAU2Bqbl/CO42wwdGZlz3t+flNA5Oa9cX/qbzsNuKWgDdYQV11ag0J5EjCYX8+wOFkfqQ5noSYOBS9icgbQhfz4r0zC/N0v/5sMfxAVMXH+y3j5TinsOmvUDBWK0jiQ5CMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEgod9P118+sZBItOAP1adXVuQnrIHkqp8/lyG7is3k=;
 b=ILwAbvbK/EhqDYzHKNpxAa1AAKD7wE/GPNjKLjnHGLNMAu/+6Lk6gxw48XBxMZeEKyBB2RlQ5eUzSXEYCyRJhg6Bfoe/IEjNwfYx51FnG0ZNxVbP4B9s+k0TQbN+g4REu1RCQWWGc8cUBXfA+5ivyhlC41qHhhK3hhi4NrDdst4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4513.namprd10.prod.outlook.com
 (2603:10b6:303:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Thu, 6 Jan
 2022 08:14:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 08:14:40 +0000
Date:   Thu, 6 Jan 2022 11:14:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, eajames@linux.ibm.com,
        andrew@aj.id.au, linux-fsi@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fsi: Aspeed: Fix a potential double free
Message-ID: <20220106081418.GH7674@kadam>
References: <2cafa0607ca171ebd00ac6c7e073b46808e24f00.1640537669.git.christophe.jaillet@wanadoo.fr>
 <YcldM9sgYdjMYMtH@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcldM9sgYdjMYMtH@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35de76de-fbe5-4890-cf80-08d9d0ec9687
X-MS-TrafficTypeDiagnostic: CO1PR10MB4513:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4513AB4FB27C95B5DA45DF968E4C9@CO1PR10MB4513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMoHIRpWH5PDOZVpuFOvifDa5vi+SHppAdvcfIFFVer9Rcs/JQLHFPtGCNdz/hN/nPx8pNpdUHd0ANG61X9U42ozoWwQVQ9sGU1lg7c/ZshKlfDUr7DowyBkE2AGEpqNzILQ8OM49bUDtsbT99cSqZpCm4teofRrrJY8tY40OCxZPiayK6bGaSwKctSGfkJ3/8TLaScvwT5CIsaNIk2WyJY+zkIueurS39/dWc7PaXcGjIurolvqjC1WpjLCIvjlKjbwxeE9Qpf8Q2GWBV+3MXG7fx3vVNDDpGxyMt0DmcCxQGLGFdTDgZ91zhlui/M1ZPWd1QH9KIHsN/ZgXZrfzRpn6nexwksEwSwuH/8alZhfyCIjtsg3pMjBY3b0Afc0bYI8GI4iDs1BYP20Vz9r9hqCO1IqF1dKirnazhNEYG6eWluW3DVsUgKLEHBMSseoXvS/gOOyNc3ErLsm2202xZr4lHlqVH1kgEuu7F6Yd07XnZRsQGRBTxlVWAJsUQu57LfeezzvITKAVmQJuNXq9w/bU2DcbAtc0kD9LG49OuIJx73fQ8tg8tqBWcCLUwGNyccI2YfvLASCkMeSVMr8mApFZlxTAoAmbkVH954A1yBzFpLsltna0IxyLJM/oQFfsY5FI85y7ltWnfDu5TfxeKImwK9UOLe5aPICrj3uUqE57ZxbQe/+6dLPsPcG4FyBK3joTyXkrU5y9a8keya1Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38350700002)(316002)(86362001)(8936002)(6916009)(26005)(66946007)(6666004)(6506007)(7416002)(1076003)(186003)(66556008)(6486002)(33716001)(9686003)(83380400001)(5660300002)(66476007)(8676002)(2906002)(4326008)(33656002)(6512007)(508600001)(44832011)(52116002)(4744005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0hCIJk28JXEHINSASrHfAg3uR4D4G9ixHpU5taepAe0RO2/R29XXsS4klaL?=
 =?us-ascii?Q?UuYhaZY3eZRw07critnR4ivpNkhd/Jgz5qzU2eT1YfHQNiBHx8zGvrM4KIlz?=
 =?us-ascii?Q?T+wxnAW3hteo2tnKXMHAVUw+gU1QG26NGB6H2bSeX+mQonFruElojsivq8mB?=
 =?us-ascii?Q?FCiKv62d1inW9Y+0ocQOUSqP3kKRGwPF01yFsFlQMYXWPMMe6owkrT15oFpQ?=
 =?us-ascii?Q?KlkDxD4mn3YJi/Rwq+cLDC/YEfknfynr92snwWXDCgvR1wdO9l3NpXDxlgA4?=
 =?us-ascii?Q?1cFkOaLwQ8X5c6+o75ZVbT60r/8bsCj9XMJvJKOX+tSSY1GW7yNf1dMs50b3?=
 =?us-ascii?Q?PukcWlw1lQYrZxCn+yG7pia2vk8qYoVc6Y46efVkee7aD9xKFTBLkUvQxM90?=
 =?us-ascii?Q?UGWMfXAMdGKwKsnjJhPrs4BnU8qTOqXVdNiJq6G2XikcuWlJJbGPZ9AT4iDg?=
 =?us-ascii?Q?AAk8XBCrS4oH2vQFQbijWGGe3Vovrl4F0V2LbQxtcVBjXqdFWMjxSPvGIB0e?=
 =?us-ascii?Q?31VNSudBNVkcQ5P25b+T3pb7kA4/qylMbGIFDEOlF9vIn+QlBDHZds+ju1Yq?=
 =?us-ascii?Q?NlCMJX8ymUHhYQJpGfjAJk4VSe2TKCJ7hmIaxO3jYKmUvCE/0tqORlNDoBMl?=
 =?us-ascii?Q?L9IcYcF9L/kuaspzmyz7CxAF8+arItTKKnNjg3hSZe43zIOS5PXc1jM5/tCV?=
 =?us-ascii?Q?d1bbHGKVhVW4+BXG1daAnvnntdYjVVZKtamDV2Tehnnl+AKyuAfd40ySzYwD?=
 =?us-ascii?Q?SyBO3ltClxkAV2JUVD3hoBC26UT1t6CRqhksiBwshQE28vJa7Kf4qYaNmKdW?=
 =?us-ascii?Q?cjBBexjrh63pnqMcNa6OMvJhKJ/1QU9Llzx4mq1/vVLoIWH0CPbefI66WFPk?=
 =?us-ascii?Q?dLlaaKc32W+2u0HMK3xESotH9vVJgCytBIj0SkZitLIgvxXzrNTbE6EvLKy0?=
 =?us-ascii?Q?pcnQ/l4/5Qu42nt8ecJ4cOFIalypeCJN2JIq8RMN0V42x4Y1ZnoNEMDOD6hI?=
 =?us-ascii?Q?XxndfDwo32SXY0SCnL5lmpg8TMS9t1YEADedImXe7vaxVHIwJaNmCk2Bvxm6?=
 =?us-ascii?Q?Itsq37uNLEMwb4lapTx65gymdGRHzO5tjC/R+4Z+3S0oW2WkO/FC3cwTV0qp?=
 =?us-ascii?Q?DyRh3hnJMtDyp6uZAM3Akq+vngeFelbqX2HIX6Cs97RhvJtYSHa+WenJ8dFh?=
 =?us-ascii?Q?o8K2kYdrwcBbtZ2xM9EaCyJ1peEvnfpvEW7vejP4X31naymhryCug9vjrI0f?=
 =?us-ascii?Q?5RWM3AiztKWKtvc34WxZMEwF/FaC0D2y49/+XH7bRnEMdbKK6OOvdZ0qy1XY?=
 =?us-ascii?Q?7V2FqijcOioWf+bi8UGF0RMOw/fbYYsNNjoOB+x6MGw16uKcqUeNZhMLLBuV?=
 =?us-ascii?Q?VMNSruFSnCfRDiYP6+oaBo3y0zzpUcNO27pyGGZFHCxSw2A6h3PRyNaYLSDP?=
 =?us-ascii?Q?zkPXZdaOtM498aLFT0QjNwmhGAFxlmKasPwcXiZfI1G+B4mqY411AgX+5n3g?=
 =?us-ascii?Q?ovACLrzKj/RA2qODI0ukqDmhHUNrSyjiCrUktIMwVglHsOp+fkfMALqZiifw?=
 =?us-ascii?Q?h3O9a8BHLic2uO4f2KccMpoYcS0Pqxu/p6+4YcEKGW5CZigg+tXYR3/GARr7?=
 =?us-ascii?Q?gYulADjrvy185iqtZtyuhZqvNTrqTjfOGaFf4FdbLKe2OmUmRAyqlPI4t3vx?=
 =?us-ascii?Q?RvjHORx3LMI6oj+GORqw9H0pn0Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35de76de-fbe5-4890-cf80-08d9d0ec9687
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 08:14:40.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxAbp64vz1xqaD3tiYXRJJ6xeUvzsfwOiuNhtPDAub2iAMUkfErIm/N+qcAnVkgFqpZqYwEvAG77bDl3K7PPDMpxf8yQz2QSwCQu/Hu54yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=855 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060056
X-Proofpoint-ORIG-GUID: Hhf9NE4mws_pnWKgGhB6jpJ8PAv9bSc1
X-Proofpoint-GUID: Hhf9NE4mws_pnWKgGhB6jpJ8PAv9bSc1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 07:29:07AM +0100, Greg KH wrote:
> On Sun, Dec 26, 2021 at 05:56:02PM +0100, Christophe JAILLET wrote:
> > 'aspeed' is a devm_alloc'ed, so there is no need to free it explicitly or
> > there will be a double free().
> 
> A struct device can never be devm_alloced for obvious reasons.  Perhaps
> that is the real problem here?
> 

I don't understand how "aspeed" is a struct device.

I've been working on understanding device managed memory recently for
Smatch.  It's really complicated.  There are a bunch of rules/heuristics
that I'm slowly creating to generate new warnings but I'm a long way
from understanding it well myself.

regards,
dan carpenter

