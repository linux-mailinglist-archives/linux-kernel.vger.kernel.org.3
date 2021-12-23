Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9C47E993
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhLWWxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:53:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47822 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232659AbhLWWxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:53:05 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNMO1bc022467;
        Thu, 23 Dec 2021 22:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4JNV/EBYBMUGdP+he4IPX/ml5QgXkgcIhhzT4lcrquc=;
 b=xfNplbmWzhRtjfZx9niDF9RkVBPNUU2vYe+uEQE7O71GFaSOTqWf6gtG09Fmmf2Op1sg
 FbyQggpvywfHy6XFTz5cwlp9wSz9T8wQorStwNnyRdFOYniV8RRO8D3CNFc2mDs3iM6u
 AlVlM9QStbrahbA7dxqaxAzIf8SPVbDAIxuKH3avGa33bmuN7YFsbkaVa0Dw2mqAVYk3
 9ZQMzBUyRNIW9Zmb3At4ouXHGhQs2dNygmetRld24It0jSGlvsuG4ilS26n+AQRh3fid
 9G9wHvu0jVvdVoNXJB8EGWCEk94n45WlBFmqXUG/PuZaAjYQ8opsdTiu5A9IUQ73+oiL wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d47a0kc6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 22:53:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BNMp5ZB177201;
        Thu, 23 Dec 2021 22:52:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3d15pgk34a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 22:52:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ6ybjG38EUtaAFNmREWwpPv2G7m1CNgSsmPar1Jdx57UpyhvUfQblxhBc2Sb2otN9AVPv9qZgLNuHLTYRlaY+mxX7B73peKq10Ny9zH2QzOIIpaycF86l7BCubI6KtNt7zJK0doDLE0nO/4BG8ct55IDIEO+RsfjzqTEMASysb44jAwfaYIHPwF0fW5XzvYsbd89c33lI9IP4HFKbiBWtUOQk5vqhC2kXGYXTEUMNlIi7cohJl6DEZnu5W6zeeLYNSInUm9J3FzEejgRNqgYJCVvxlg61P+cMcNVMMv1YYeX1sjQ0PATmnZ2vgZjbSGfdnbGTD8qcLetf+oFVejNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JNV/EBYBMUGdP+he4IPX/ml5QgXkgcIhhzT4lcrquc=;
 b=SEG3fnbzSynNRBR1kEDgeB9Qttj3AjJGJk/IT+MXuzcPwDIJvrLMNgWGqO8mF/4yjTXftZOjqK7HGwYhtBrofGkd5UMh5QH3f0Cq5s8QPn6UJFDAAuymMB8R4cSd56qBoIKS0MbZPzI6tI+qyie6SY2cjnLr5BgYzTVYKnYKZJBRfAS3h4lRGvX/Fvy5jVQkRzwo1FLyidxkqub2+GhMItQ4eH8L6mnJNqpCi45yy94AKY3eF7Qa0+T+dUCsWJcX9Zeg1A5nNJRjXzbJ8G9h9lmFjLmjFqSLT1ufXrop9/e5dlpW2R6fTp1qxno4pqYjmKj+FbWVgA+MAbAG1f2DEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JNV/EBYBMUGdP+he4IPX/ml5QgXkgcIhhzT4lcrquc=;
 b=vWVTOLjbUn3z/z62itZfIXz5xVVXvip2wUd5OxS8zw6vv96zgD0Bc1AwoM3JJxBquEL0r1QpUl30TlEOaopyRjVhhkGF7sL2DYD8Pg7jYFfaOhfHP+FXfiOKGvlDAhKk2RpGolkyvBns6ULAkmMAbivKaShOAxBzfmeVpAMW/Ng=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO6PR10MB5792.namprd10.prod.outlook.com (2603:10b6:303:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 22:52:57 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a%6]) with mapi id 15.20.4801.020; Thu, 23 Dec 2021
 22:52:57 +0000
Message-ID: <1cbeb70b-6ae5-85fa-8f67-5da17974ed0b@oracle.com>
Date:   Fri, 24 Dec 2021 09:52:51 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH] kernfs: use kernfs_node specific mutex and spinlock.
Content-Language: en-US
From:   Imran Khan <imran.f.khan@oracle.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
References: <20211215150638.390466-1-imran.f.khan@oracle.com>
In-Reply-To: <20211215150638.390466-1-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:a03:167::16) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44bad31d-4818-4af3-99c8-08d9c666f653
X-MS-TrafficTypeDiagnostic: CO6PR10MB5792:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB579287EA5A642471242E044CB07E9@CO6PR10MB5792.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8qBh0wzCnJ3WXQeCQpj1AzI+kGq4DuBo+cA7z7birvZOfVQibHzCa+7qWS+HVzx7wa+TdeWAl6aCcAYiNCK/NjM3/fykhGw91OtwHPXHrWdeNYLrNYJXz8upv+7vgiZH8tVkxEp65NpGoT5P+xo2xnKv2HOOVhZHrQvS0ZYoaRViJeIvANXq6jeP7CO/WWCc/6R2vjJwLuonpkWeIjqtcL8SKDnmInPCAgkPRZyfvbNkV5iwu6jjnR3Ojuq22N1x2hOXrVzr9qBalq4SRKk9apAWaO2U6LI6Y9ROTUYd9JvPjKWrMHyeDw08gIRup2/cB98vxDmn9vnMxKvLXhCRvpquxS/xGXntwpwtIs8Dms8UhjUgbezfOMMSos4fShjYmM7dsmD2UI0koAbnHATUqxCnzSaEeSUxc4E7LphP+sARekMJFVX8lPJV5HAQI//pR3en+2ctP+Zjq9+5F/Y/rvbz9vAsuww1y7m3mt6w7qI/x1/mVRC/ZcTb0F29zVSzhwJXRkWP94MYHi/Sz6GhJqJFVrW4zLPgzWK9mN2SyO/G2y5v0wDwNLyQEwXCT6xT4516+wOrRdkVk9SU8SC0Q8uic4uEyswqCzBaXvHRO3NYx2ercP/jwlpY0LpnzeGye4xb+hdgwpaw1JuE62PgXc47Y8P1saS98yDKtv/zPvjoduPbQFMtHeVfBATR5S/pKXUB4nkb4elew6w68kBKukd4p1wqVp+A0tzWSWUF3fyePDEa42uFGwAoctWihgtY7z1fdAOqLPaf5cAK/rTcXJKLSkc+zpnAiP7/RCCuH8654YNabZdq1PlQXZSNdXZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(8676002)(5660300002)(6512007)(38100700002)(36756003)(66556008)(316002)(6486002)(86362001)(2616005)(66476007)(4326008)(8936002)(6666004)(53546011)(31696002)(2906002)(83380400001)(966005)(6506007)(26005)(186003)(31686004)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNlZXdua2krQTBLblcvOWZ2OHNJQTN0UTNBOFJJTU52ODRtanRROGZsb0Nl?=
 =?utf-8?B?ZXFMcEduK0s4dzQ3OWR6NjN1SzRWZVBIMTByeE14am9BcEdPOTBuTlZmV1Q1?=
 =?utf-8?B?eUZNTnp0SDN0M01SMTRRR3ExSkVJVXkvTnphZ1B1MEdncTdkZXdxK0kvRldr?=
 =?utf-8?B?dnExeDNDSjE4dGNsZTB2SURZU2NjWEFsMEZ0Z2JWT1ZPbEZ3MTBCUG5DNXM4?=
 =?utf-8?B?dVd1VUtsakY2b1FEN3BoSWxzcis3amdYV1lUVU5aUHZMdEdvMHVYRnJNVWVC?=
 =?utf-8?B?dEdNT2pyRG1JL2VRSm9SdjA3b3gzbkRzdTRySW1RbU5rcXdvSEZmUWZOck9L?=
 =?utf-8?B?ejhwc0J1YzlMQ0NVaXJCZFRpZCtlSVh3V0JMWGJFbXNBc1lhbm5VeTkrNkh6?=
 =?utf-8?B?WWcvZ0xQemJPajAyelJaVGRqQmdRdHM0eFFtN2JIQ05XUG52Qmt5Y2tISE1C?=
 =?utf-8?B?SFl1a211alkyR3A5MmFGTjk0MXBrVytHYU1zSjJtMzcyc0lBZERia0NuZWdN?=
 =?utf-8?B?NHh6Z29NZU5FK3VqTlF2RWNNcTVNVGJtSHhMWWFnV1hvZ2hZSGRvU2ZqVGhk?=
 =?utf-8?B?ZG92enpVYUpISmdua2RGTTJvTEtrY3pmOENNT3NWRGkxd1QzME9XazRWNktn?=
 =?utf-8?B?c1c4bm5CWlNkd1Y1by9GaGc4SEU3NTZLUjl5NjRrUHNzUzhoK1ZhZlZpU25t?=
 =?utf-8?B?T25IK0pKb2VmTnZUOWl0bXlyZCtCQzlkUkdnTm00Q0k5QjhvYzM3WjBFY0xw?=
 =?utf-8?B?cmh6Z2s4aytqMzRqMTBHTTVDY3BjdnFEYUJ2RkNIb1I5RlZzcTZQRFQwaGtk?=
 =?utf-8?B?MXRSMGpuMFByV3krNmo1RDlMVlpPRzkvWjlxejhWeFdiSXd5ZFdPTHlQaEg0?=
 =?utf-8?B?VE13SFpTc0F6UlhKM2ZwUXUrMDhSbnd3MjdULy9yWkVOcmpkaVgyM3laV1Fn?=
 =?utf-8?B?TVFrVzNKOUUrajdORHlnQzMxbVlDSmx4OVgySU11RDRkQkNQUWRvQVp1VGlD?=
 =?utf-8?B?L2MzNEJIY2p2d0NEUTdETDRpYjJMNHdXdVFTUnhLcS8vcVFkWmJtMmVUdUcx?=
 =?utf-8?B?Vm4vRThObVRtQWU4NllucVRzMU9jK2Vncm50WFZvQlZNWStyd1poT2ZpQVJM?=
 =?utf-8?B?RkhrRjZUcW44VHRJUTQ2ZU9KN3FOQm1KUlQxa2VvQjZnS2ZBSEwyaVFUZmdj?=
 =?utf-8?B?aVc2Q2E3blJvMm5ONmdWc1NyVXFwSWRnZ2d2cWtyVWJYSE5aSk4yZStiMmJI?=
 =?utf-8?B?Q3lFUVRJYW15UzVhcGVjQTJEODZRTCtQQWd1VUJUL0Yzemd3SFpPSmZHRmpt?=
 =?utf-8?B?UHNVcFNreDJyY29iMEJRRXU2L1prQkJJeFpCZkJVQjVGQkNFT1lqTXpjOVlj?=
 =?utf-8?B?TVR5Tit3cjJTcVFDcHpLL01nSWRSalVhNURlNGttVnN3L21BakNTc2pyQ3Z2?=
 =?utf-8?B?Wm9ZVHpSQmo1akc3YitQaklwcE96bUN1cEczQllFeFBqdDFuYjJKelAzcGxk?=
 =?utf-8?B?NW1yWkRha0ZkTjdETXo1Tzl2YmhKUUptSXBrZkJJTTlhSzVRamhVS2xZOFh0?=
 =?utf-8?B?eGdXRmlrWXh4ZGJvUHM4MHE5bCtZbGZOTVhwckpOTzJiVTZCZDRHSkFKVXpE?=
 =?utf-8?B?K0tJTWFBdVQ3UWpyMThBdEU3dHA3K2UrM1VkdWQzM2pZMHE3bXBoWm1xaHNR?=
 =?utf-8?B?ZGZnRHJhYzdSMWZOUCtQV3ROZXF6bm01NWJiQnE4U3ZsYTZTS1YrVWZsVWkr?=
 =?utf-8?B?Mk9PSDBNcUw4b2dGRkxYbU1ZYUtpM0p3REFkdm9ab2duUC8zdlVJZ3BZUUxW?=
 =?utf-8?B?MFFLTU1RUE1XV3U0YnY4Zkp1WTdjUlJ1c2ovakNPOTBSakFTdGlrZ0RsUDg1?=
 =?utf-8?B?QktJTWViN2Q1dFFobEVZeFY2MmYwNk5VNUI0UGpuN3JWTXRqVDZiei9TTXc5?=
 =?utf-8?B?Z0xNQ0RFUjd0cWlITDg1N1dSUWZuNk55MUFlYXVsdDZlNUhQaEw5bzNNSnVF?=
 =?utf-8?B?azB5WGVtM2hwOWxzZGRZOHZwZWhCV0hHMkxMNHhmcWZwajFSTmN5eVpRUjdm?=
 =?utf-8?B?QXdQSTE5dFlSYUlGOGc5MGtOR3NYc0E5QzlwRk1QbnZYRm5meWZ5Wlp5YW9J?=
 =?utf-8?B?RUx5TTNYM3A0VHZ6aml5bHVOeGdRbE5jc1c5WWFVQnhMRWhEQ0krQmsrWTJI?=
 =?utf-8?Q?QJ9Nbic558eNpJXgfUMbtUE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bad31d-4818-4af3-99c8-08d9c666f653
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 22:52:57.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1D0AfGP6lmrec5DbiSAI2PMUN56EDwzyLdz3FA4BA1b3/FsQm7LLkPJTwK2q63FAY9aagocbUPvPYkU6xsBDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5792
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10207 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230116
X-Proofpoint-ORIG-GUID: U1W9Ho6DwWavxJ6jPJU9AN-fwcDZt_RN
X-Proofpoint-GUID: U1W9Ho6DwWavxJ6jPJU9AN-fwcDZt_RN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

On 16/12/21 2:06 am, Imran Khan wrote:
> Right now a global mutex (kernfs_open_file_mutex) protects list of
> kernfs_open_file instances corresponding to a sysfs attribute, so even
> if different tasks are opening or closing different sysfs files they
> can contend on osq_lock of this mutex. The contention is more apparent
> in large scale systems with few hundred CPUs where most of the CPUs have
> running tasks that are opening, accessing or closing sysfs files at any
> point of time. Since each list of kernfs_open_file belongs to a
> kernfs_open_node instance which in turn corresponds to one kernfs_node,
> move global kernfs_open_file_mutex within kernfs_node so that it does
> not block access to kernfs_open_file lists corresponding to other
> kernfs_node.
> 
> Also since kernfs_node->attr.open points to kernfs_open_node instance
> corresponding to the kernfs_node, we can use a kernfs_node specific
> spinlock in place of current global spinlock i.e kernfs_open_node_lock.
> So make this spinlock local to kernfs_node instance as well.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> ---
> I have kept this patch as RFC, as I am not sure if I have overlooked any
> scenario(s) where these global locks are needed.
>

Could someone please provide some feedback about this change? Also if
there is any issues in this change, can I make these locks per-fs as has
been done in [1].

[1] https://lore.kernel.org/lkml/YZvV0ESA+zHHqHBU@google.com/

Thanks,
Imran

>  fs/kernfs/dir.c        |  2 ++
>  fs/kernfs/file.c       | 48 +++++++++++++++---------------------------
>  include/linux/kernfs.h |  2 ++
>  3 files changed, 21 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index e6d9772ddb4c..cd68ac30f71b 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -603,6 +603,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  	atomic_set(&kn->count, 1);
>  	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
>  	RB_CLEAR_NODE(&kn->rb);
> +	spin_lock_init(&kn->kernfs_open_node_lock);
> +	mutex_init(&kn->kernfs_open_file_mutex);
>  
>  	kn->name = name;
>  	kn->mode = mode;
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 9414a7a60a9f..4114745d80d5 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -18,20 +18,6 @@
>  
>  #include "kernfs-internal.h"
>  
> -/*
> - * There's one kernfs_open_file for each open file and one kernfs_open_node
> - * for each kernfs_node with one or more open files.
> - *
> - * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
> - * protected by kernfs_open_node_lock.
> - *
> - * filp->private_data points to seq_file whose ->private points to
> - * kernfs_open_file.  kernfs_open_files are chained at
> - * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
> - */
> -static DEFINE_SPINLOCK(kernfs_open_node_lock);
> -static DEFINE_MUTEX(kernfs_open_file_mutex);
> -
>  struct kernfs_open_node {
>  	atomic_t		refcnt;
>  	atomic_t		event;
> @@ -526,8 +512,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
>  	struct kernfs_open_node *on, *new_on = NULL;
>  
>   retry:
> -	mutex_lock(&kernfs_open_file_mutex);
> -	spin_lock_irq(&kernfs_open_node_lock);
> +	mutex_lock(&kn->kernfs_open_file_mutex);
> +	spin_lock_irq(&kn->kernfs_open_node_lock);
>  
>  	if (!kn->attr.open && new_on) {
>  		kn->attr.open = new_on;
> @@ -540,8 +526,8 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
>  		list_add_tail(&of->list, &on->files);
>  	}
>  
> -	spin_unlock_irq(&kernfs_open_node_lock);
> -	mutex_unlock(&kernfs_open_file_mutex);
> +	spin_unlock_irq(&kn->kernfs_open_node_lock);
> +	mutex_unlock(&kn->kernfs_open_file_mutex);
>  
>  	if (on) {
>  		kfree(new_on);
> @@ -577,8 +563,8 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
>  	struct kernfs_open_node *on = kn->attr.open;
>  	unsigned long flags;
>  
> -	mutex_lock(&kernfs_open_file_mutex);
> -	spin_lock_irqsave(&kernfs_open_node_lock, flags);
> +	mutex_lock(&kn->kernfs_open_file_mutex);
> +	spin_lock_irqsave(&kn->kernfs_open_node_lock, flags);
>  
>  	if (of)
>  		list_del(&of->list);
> @@ -588,8 +574,8 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
>  	else
>  		on = NULL;
>  
> -	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
> -	mutex_unlock(&kernfs_open_file_mutex);
> +	spin_unlock_irqrestore(&kn->kernfs_open_node_lock, flags);
> +	mutex_unlock(&kn->kernfs_open_file_mutex);
>  
>  	kfree(on);
>  }
> @@ -733,7 +719,7 @@ static void kernfs_release_file(struct kernfs_node *kn,
>  	 * here because drain path may be called from places which can
>  	 * cause circular dependency.
>  	 */
> -	lockdep_assert_held(&kernfs_open_file_mutex);
> +	lockdep_assert_held(&kn->kernfs_open_file_mutex);
>  
>  	if (!of->released) {
>  		/*
> @@ -752,9 +738,9 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
>  	struct kernfs_open_file *of = kernfs_of(filp);
>  
>  	if (kn->flags & KERNFS_HAS_RELEASE) {
> -		mutex_lock(&kernfs_open_file_mutex);
> +		mutex_lock(&kn->kernfs_open_file_mutex);
>  		kernfs_release_file(kn, of);
> -		mutex_unlock(&kernfs_open_file_mutex);
> +		mutex_unlock(&kn->kernfs_open_file_mutex);
>  	}
>  
>  	kernfs_put_open_node(kn, of);
> @@ -773,15 +759,15 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
>  		return;
>  
> -	spin_lock_irq(&kernfs_open_node_lock);
> +	spin_lock_irq(&kn->kernfs_open_node_lock);
>  	on = kn->attr.open;
>  	if (on)
>  		atomic_inc(&on->refcnt);
> -	spin_unlock_irq(&kernfs_open_node_lock);
> +	spin_unlock_irq(&kn->kernfs_open_node_lock);
>  	if (!on)
>  		return;
>  
> -	mutex_lock(&kernfs_open_file_mutex);
> +	mutex_lock(&kn->kernfs_open_file_mutex);
>  
>  	list_for_each_entry(of, &on->files, list) {
>  		struct inode *inode = file_inode(of->file);
> @@ -793,7 +779,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  			kernfs_release_file(kn, of);
>  	}
>  
> -	mutex_unlock(&kernfs_open_file_mutex);
> +	mutex_unlock(&kn->kernfs_open_file_mutex);
>  
>  	kernfs_put_open_node(kn, NULL);
>  }
> @@ -922,13 +908,13 @@ void kernfs_notify(struct kernfs_node *kn)
>  		return;
>  
>  	/* kick poll immediately */
> -	spin_lock_irqsave(&kernfs_open_node_lock, flags);
> +	spin_lock_irqsave(&kn->kernfs_open_node_lock, flags);
>  	on = kn->attr.open;
>  	if (on) {
>  		atomic_inc(&on->event);
>  		wake_up_interruptible(&on->poll);
>  	}
> -	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
> +	spin_unlock_irqrestore(&kn->kernfs_open_node_lock, flags);
>  
>  	/* schedule work to kick fsnotify */
>  	spin_lock_irqsave(&kernfs_notify_lock, flags);
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 9f650986a81b..22cd01477129 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -162,6 +162,8 @@ struct kernfs_node {
>  	unsigned short		flags;
>  	umode_t			mode;
>  	struct kernfs_iattrs	*iattr;
> +	spinlock_t kernfs_open_node_lock;
> +	struct mutex kernfs_open_file_mutex;
>  };
>  
>  /*
> 
> base-commit: 0bafb8f3ebc84525d0ae0fcea22d12151b99312f
