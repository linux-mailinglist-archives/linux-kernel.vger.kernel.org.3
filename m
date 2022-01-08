Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B6A4880B6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiAHBuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:50:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50178 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229935AbiAHBuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:50:04 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2081T21a027793;
        Sat, 8 Jan 2022 01:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=T7rtdv+A5KujriLkYIwQCOKn2I0bV/xFgPKPaHDmOWc=;
 b=vmEpltP+hZfkdMm21pSYks3rov0kedIvrZpeq7vKbxNlfy8vs4iOrG7eRB6WVFr3FNh/
 cCuSDDq/ofLZ9ERA6hH7VUlZAGR7CJBflfEWI4YXYlwHTrQWU+985U7V2qroNSe2E2ld
 +vcnUkMfb2H0Xxzel/B3REHR48W5/dnza/X+O4+SdULzsRu2Hvq0VUrzhCTGPZI9W0II
 5XmNXL7vcEXv3RiV44w9PqaCUMT6j+LiSR+o2q7ax0ZrJ5cWTxKyOw3C2kW+MF3+KHN7
 CHpTWnJDxICpYClttD6vvB8XShDo15/LkskQOT4wdcC+k0LQsg6PLuBHim3Lmp4f24iw pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v8bbjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jan 2022 01:49:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2081jmq3112155;
        Sat, 8 Jan 2022 01:49:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3dej4tjcbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jan 2022 01:49:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhH8Bjcrtii0aBCfJApzC7287CLEg+C74HD8OZ3PkOUtjYFgSl/9tiQLvjjNZ/ncgiTkx++XXxfde7pO6pIxSm2xBQtJydRBlvOIEwQsRvTnCIAot/fogGlgcvfIVevqeROsbGOXI9r1QE2BrqdH3PFZE9dKOwLZRODtJhf73BNbIVsV9fWg1mizyR+zSIXN97biFfcRKjICHcoX7tGZ5ozf2vl2a/VrfVtEj+pQ9Gzmm1c675rqMDubcAVX+UIzRknLQA1Rbwcw/ew8aSmQWQRha55RQg2+PmJMZAr2AE+t8hnNLOz6QqN7fjBEjgsdaWvX2aEnzVGGHMa2YJB6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7rtdv+A5KujriLkYIwQCOKn2I0bV/xFgPKPaHDmOWc=;
 b=Jo/TFygTQeBvHaL9icCcgzNTcJtk/YK4pudWb/xBmhyCOn2oyIOe7NMoe7kfnWfNkDMA1E0gEdzLKtQAdwcJLgo42RhMi+fSaZvK2kBGg+icQK2a53vZwtPCWakrGRtEL1tMrShhxub9dnHFupbnU3WwaOzSKGssXcBSf5uss8DPJ5d9nPNOQNxVccNoQ3h6mas7C2q62f4qZAxAYA1kupjgyIuWJujBsT/v7767xKqrv+uvn+p3iqQYdUD/zJLqraai8GGx0tK9HfzswQEB9H1gNyd2iIaLXgPvXfKzDYoexMlTOBtgZIh6DDj0J0EXrTGg3a4quP5JhFApnvMbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7rtdv+A5KujriLkYIwQCOKn2I0bV/xFgPKPaHDmOWc=;
 b=d55lMVzYmYaLLybe/eK2HB4HTfkn6OT5m+aDhL3y26I9BEWycm5AahT2s8v1l7jmp7T8/RfqNAJnJ6+lsKjAli15vlv5hSgDeW+Z1i/K5O1rW3RAMWSmBUTumi7lR6raN8rHe8yyJU4X33DIFHf+KZ13KPUBugx6dIN9uwbzjAc=
Received: from BN8PR10MB3283.namprd10.prod.outlook.com (2603:10b6:408:d1::28)
 by BN0PR10MB5094.namprd10.prod.outlook.com (2603:10b6:408:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Sat, 8 Jan
 2022 01:49:48 +0000
Received: from BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::317a:27e2:c007:7eb]) by BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::317a:27e2:c007:7eb%6]) with mapi id 15.20.4867.011; Sat, 8 Jan 2022
 01:49:48 +0000
Message-ID: <3740be2d-192f-aeaf-02fe-e309cdb278dc@oracle.com>
Date:   Fri, 7 Jan 2022 17:49:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] vdpa/mlx5: fix error handling in mlx5_vdpa_dev_add()
Content-Language: en-US
To:     trix@redhat.com, mst@redhat.com, jasowang@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com, elic@nvidia.com,
        parav@nvidia.com, xieyongji@bytedance.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220107211352.3940570-1-trix@redhat.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220107211352.3940570-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To BN8PR10MB3283.namprd10.prod.outlook.com
 (2603:10b6:408:d1::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 260235fc-61b2-423b-2f27-08d9d2492726
X-MS-TrafficTypeDiagnostic: BN0PR10MB5094:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5094E4AF40CF4A864C778F3FB14E9@BN0PR10MB5094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJpgEFRO0GT+HaU3+lM5RnVTYIj/65Bpvb2F95tDeJcH7sqgfX7kYnO10Jz59NYTLQSksnzFw8rIIRgiNoDUax14x8vv929YITZrdOgT4Dbu+ybGTQ1NT1c2ifTWvpXZrc2y30EVzPbLt/EnW58jtYVDa2258o5iLgxVzoiu3c2GRVY3yTmNqQv/8MHHDonUa04+RxaUXNqhAd++Zy439Xr//PG2nGy1R0K7ckoyTyNzqZr+E0EYhbsgsVXW5UQj/A88TMx1A+5knaz9CZDpdrO7mUYf9Jwa0uKKszFojhHLU/vDgobcA0aqY9TVsAnhl1ouVbQ0PHpR5OuhdoySdSEfHgFMiK0VLXMmuGEI0Bd3wQVwgYYEtKc7fAPU4nbqa7a2p2ccVbYpLezkZMvHC8Mv0hIC//JkCrjblMW5y+WrUDpkKors3nKgVW7Xox+RmYpAvm9NiAA8mbbkNpSyMcTJJm0h2Br3oqhlkqn3ybVkSIn9YTOUy7B/WEsNmsgksvJgHmRMkmIs4WE5tVYi/81/Ib3MYmKKdj/oxc5ctF7kY2cgl0lGmypESCih6DIUlMJWNFV3nihL1XsIjopZKQ/6WinuhKYyFeIPHgD+0xK84XNwVPwLq18YfIMlC/I/5PY+kThxNmSLIANJ1LbRA2bIGpwzQQULPvTxK/sg/I7xQcO7wwpJukU3QKI74PM6/0QHGbnW0Il31SPy4NzEX6YcxEnKblCCs1x356aQ6CA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3283.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(36756003)(83380400001)(31696002)(186003)(86362001)(6512007)(316002)(4326008)(38100700002)(6486002)(6506007)(36916002)(31686004)(2616005)(5660300002)(66556008)(53546011)(66476007)(26005)(7416002)(66946007)(2906002)(508600001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmhmVTkxbzRUN0liMVRlRCs4NU5ueURYV3NMQ21QbzFZMXlaR2pZdCt6VVd5?=
 =?utf-8?B?TThaVFFWd21IKzN5U0JPQU5mNGJFc0t0dWpYQ1VWZmVRdE1kNWRLcFhDV3Nu?=
 =?utf-8?B?cXZMbTRZUkt3ZXoyZ0k0bnFZeGsySmJhM3g0cDNhazlLYXRaOWdSZUp5NnJo?=
 =?utf-8?B?d0xoamsyTy9uZHk0aDBJTjgyMHlxTGtBUkNRaXd0M2FuSTBHQXgvR2o3TXRM?=
 =?utf-8?B?QUhFWnRmaUFsWXZiK2Z3N3RGUzBTbFNMNTNSM3ZjdFhsaGZoNVFJSU1MR1Ev?=
 =?utf-8?B?aEZQVVJTTFVVdTg1Y1poenJTT0pUcDV2NnFrQnVPRHNiU1l2QzF4MzN3UEFE?=
 =?utf-8?B?Mnplb3hmdDBuT3FCeU5WWVh3a2VocVd5K3dpM3VEcXhTNUJaQjhrSmk4RVov?=
 =?utf-8?B?LzEvMHlEYTdXL0ZPa0pWeE4xRHI0cHd6VkgyWXI0S0x3ckNJMmwweEJrb1Bu?=
 =?utf-8?B?T09nbDl1eHIvRXQwWkkyRk1CV1FrZEprNW9Pcm9xZEc4MTl2NUk2OEw3R253?=
 =?utf-8?B?OUxjTXpKU3hPM21Qb3F3NkMxcWY0dVJQYlVwTnE2dGhURnhNUzJDbHNwTEFH?=
 =?utf-8?B?YzkxSUdNN1BlaVYxMlFneUp5N0xOMlBwQjNPcFBEaTRZRUJxVURNTGVqenBM?=
 =?utf-8?B?cEJBRGxuMFJvc3lqeFRLNjZGeGVmMUw3c3RCYnZqNy9OWnU5TStleDR3TzVw?=
 =?utf-8?B?eTNqQTN2NmVUejRaYStsZDI5WlJJYjBwQk9FUnV3dDk1eG9Bd2JCbnFUQ2ds?=
 =?utf-8?B?TnFZOXJHd0x4QzkzTjdLN3lLOHJibTJnVDNwaXhsSzFEMW5nUFBmbjJMNTZ0?=
 =?utf-8?B?NXJsRWhTaGV4bmVsUXlPbDF6a0daMFhaMnBnbG1HRFpMdkxJelVaejQ1dlZx?=
 =?utf-8?B?Z2ZyL3FvK01BUFRBZlFzdU9CV1JIK2xDTHBLeGtEcUdFT3lONlVaMy9OaSt6?=
 =?utf-8?B?VjRmdDZwVm5sWUFFVDdxbjVKZFlPeWhvNlcvY2NzTVZNOFBEcVdYV0ZFRnRj?=
 =?utf-8?B?dGF5MEx1Z09EeExFNXR5QXZnamVudmdLU0tZS3hZdVNlN1RvV2U3cXJCNVJT?=
 =?utf-8?B?OG9GdmM2Ungxd0N0WkM3Tk5Lc1RPdDR6eUhDdnpiNG5CM0szaWZZdTcrWlRn?=
 =?utf-8?B?UkZmUnhxTi9icjFzOUphQTVGUW5JVENvU2ozVzZZb0dCMlVNYWlBamFNTVV3?=
 =?utf-8?B?ejNiL3ppa0QzaDBSYStOYVQzTjE3dzJwcXVzM3AwalcyVldXaDl2d25oRXM1?=
 =?utf-8?B?NVc4TU1tYStRMlpsSXdCNS95NTRGZDd4NnRTVG9UNlhQd1F3N08wQ0xyU2Jp?=
 =?utf-8?B?emxwV0VIcmJ2ZjRsNUk5Nk5iNzBqU1lHd05OZ2lOS2dVYURHRW4rSFNERUhr?=
 =?utf-8?B?Y3RGSk1US01TZHdVNGxVWlZLZjlYOTk3ZldvUHlId3Y5QU1nTGRnTXVvMlpR?=
 =?utf-8?B?REorMlB3Y1VjMENvaU8vcThvaEErN3Q4eVF3ZUlqZFBXUlUzYXE4MUNVR2Zm?=
 =?utf-8?B?eU5ObDVmRHpwWGtmV2N1ZUpmUkdKUEltdFFXd3RmU0JsZlFVamdZbFQ2dHhN?=
 =?utf-8?B?SDdhVStzL0c3VlBwc3dhd2UzNG1YSWJWQkRWMVJjcURlUDV4YTVnVm54U1N6?=
 =?utf-8?B?a3pPLzRTNFhPa3I5UDN2UENwZldFUE5ENC83VWlBdzRRVVRZQjY1OUJQem5p?=
 =?utf-8?B?RkZkU2pDb2xxT01nam5OWDVEZ2ZBS1huWjJmVFE5T0d2aVpJRHc3TDhZakVP?=
 =?utf-8?B?Qk05OXUxSHdrc0VnUlA1eXowL2Vxc0tld3dwSExPdy9xdTJNeUo5UHRlZEVo?=
 =?utf-8?B?ZFdSaVdJdUxxQnlWOXVLcW9mNUhNVFo4NDZva3AxcnUrcWhsK1dGNFloR1l3?=
 =?utf-8?B?MmhuOUx6eC9JbENiYjVmZkRZRlErRFBhWENDM0tIUzlxeFFLUFQ0WXRFQlI2?=
 =?utf-8?B?Zjc5WmxHNFB4em5sdlZERjFuem5lcjlIVWVRak5IQmNwWHVTaFFKT1J3NmVt?=
 =?utf-8?B?dGxKaU4vZi92clpPS2VweXdHVlZzdUhuMmtOS0pMc3JSRlVMUlkrMkFhZjla?=
 =?utf-8?B?QVBXK1ZhV2pPZ1lpNjZyeVJVZ3R2M29vQlNVSFZTdUFCdysrQ3dpWkdzdHNs?=
 =?utf-8?B?TmJlMm1UWVJPTk1qc2w1Z1JXMG8zOWI0Q2lrVDJsR3ZValh1MGVVTXNxbWNT?=
 =?utf-8?Q?LxHzpI1WdwpglKEdHh4bR5g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260235fc-61b2-423b-2f27-08d9d2492726
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3283.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2022 01:49:48.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrlrILorL6VauSHh4TTY/mwwG1Wpdqd21dxD65tnriOO4QizX0/nUpvvaMl/PYMPrz/paQhp/eiTDHZq2nX4XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10220 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201080008
X-Proofpoint-ORIG-GUID: DHJdobcfejsf_EeP_Fx710edgW_y0TdM
X-Proofpoint-GUID: DHJdobcfejsf_EeP_Fx710edgW_y0TdM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The proposed fix looks fine, but I still hope this to revert this series 
if at all possible. The review hadn't been done yet.

On 1/7/2022 1:13 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>
> Clang build fails with
> mlx5_vnet.c:2574:6: error: variable 'mvdev' is used uninitialized whenever
>    'if' condition is true
>          if (!ndev->vqs || !ndev->event_cbs) {
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mlx5_vnet.c:2660:14: note: uninitialized use occurs here
>          put_device(&mvdev->vdev.dev);
>                      ^~~~~
> This because mvdev is set after trying to allocate ndev->vqs,event_cbs.
> So move the allocation to after mvdev is set but before the arrays
> are used in init_mvqs()
>
> Fixes: 7620d51af29a ("vdpa/mlx5: Support configuring max data virtqueue")
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index b564c70475815..37220f6db7ad7 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2569,16 +2569,18 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	if (IS_ERR(ndev))
>   		return PTR_ERR(ndev);
>   
> +	ndev->mvdev.mlx_features = mgtdev->mgtdev.supported_features;
> +	ndev->mvdev.max_vqs = max_vqs;
> +	mvdev = &ndev->mvdev;
> +	mvdev->mdev = mdev;
> +
>   	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
>   	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
>   	if (!ndev->vqs || !ndev->event_cbs) {
>   		err = -ENOMEM;
>   		goto err_alloc;
>   	}
> -	ndev->mvdev.mlx_features = mgtdev->mgtdev.supported_features;
> -	ndev->mvdev.max_vqs = max_vqs;
> -	mvdev = &ndev->mvdev;
> -	mvdev->mdev = mdev;
> +
>   	init_mvqs(ndev);
>   	mutex_init(&ndev->reslock);
>   	config = &ndev->config;

