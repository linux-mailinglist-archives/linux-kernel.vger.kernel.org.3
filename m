Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289764B0358
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiBJC2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:28:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiBJC2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:28:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E904322BEA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:28:48 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219Ne6Vd027620;
        Thu, 10 Feb 2022 00:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jBkZKnw5lXyieR15PXG9AXwk/350etzcOaCwbaYovKY=;
 b=JcfCostJ3PJYLP1f6ZyRrCDfCHLHEIX7vJ+iLbL1xWThx8J2FEMhJtK6XGiqF1f5CvUx
 HjDicgR7gponNTTNMftPmjMceYBNz93IUZAjVnN2KY/H89onAXFkUU+sJQu4t6l7NgQf
 qjVD9wDeRC1DiXOaShvQVG8HD1rwKLWYJZKXyeONhuHMXkJLKhGCxobJ8QN+GOplaQdo
 hrzKnE6w9iHV+aQZ2LpHjXDN5hNVVkK1YpfO5kRV2Wqm0MkcSiJwEqIy1WYkdUkweYNZ
 VTufa6WBmwLGqmOz96BWXa89T6F11NWKxyYeNIk23B/7oZ1l4aa21DYp3whT4OFGtW/v gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdsx7q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 00:44:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21A0ZrpL168837;
        Thu, 10 Feb 2022 00:44:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 3e1ec3pp4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 00:44:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxTYuO2NypDPym3F/YDunfuQ38EjKEhpe9AUv2Sil56WProEi0NJvQQUSERddWVgs66kQmZ67I6ucyWVgVrrTmQWLRC6vgxG7aosQg9y5R6j2yYVb6aB01ajdgTytCQUsJwR95rUoAQT3YYMo7sWqipXZ3fT9D65QJVog+qWnaGBAMKv2LST5cAuZNke67bwoSFGjgx52ExYRiiSaHZ6nhmVRcO2LUPYSr1tI5Y7FQvriZU2wLIv+nby5Dr6YvJNQFADe2c+mVJ5UeMJfz75I2PRsGqVIVf/03sKwo9qHslfa1weJjyFk67L4h2jI7hXXNqr+2IM+Ck+qfAbVKRysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBkZKnw5lXyieR15PXG9AXwk/350etzcOaCwbaYovKY=;
 b=l6Iuyy8c/2cxUZyoftWOgigjHHCg19vHlx5zdqCDYS3gq9SApQbxM9AM9Q0WcoDLsv/zaGBMB2ebBddMh5jBes7x++ocizWknfrPV+7MM+qUFumYaaathB0XO5Rjg53ht5n+woYYt6LwydjMNjUfMU5IEn8ARRt6Trr31+d7IVref8zdmfYFLubcgR2zywgpdQOHQZbGj10ZQontalwFKa0C6GrkS0IUs8IS59Vp53TqyCa5xtrP9EHsdckePZc9fsOgo/3a65tS2xTo0dw3+PElniju4LF5gbu0l68Zpv8wU576Qx0PhrMkR0kKQ7hrRn/8LGaoVNaOlGl2TMumvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBkZKnw5lXyieR15PXG9AXwk/350etzcOaCwbaYovKY=;
 b=cqRBWYaI6UvzGQcyui2u2LycZrT2/Isi0LZtywpNE4uWlmZgSVU6E7Ub++PFPu19avRx29ATLFRlL3pXndyZGPIoapzEtwW0r6/knsNl9GKZHY5sbY/v8N02vkPL74sBo59hD/XBxtZRRLaTSD80Ffs437DFOz5e7r4Khye75Ws=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR10MB1618.namprd10.prod.outlook.com (2603:10b6:405:3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 00:43:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 00:43:32 +0000
Message-ID: <95d1dc4e-fc3b-fe3c-5d85-218a7410e966@oracle.com>
Date:   Wed, 9 Feb 2022 16:43:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] hugetlbfs: fix a truncation issue in hugepages parameter
Content-Language: en-US
To:     liuyuntao <liuyuntao10@huawei.com>, akpm@linux-foundation.org,
        yaozhenguo1@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wuxu.wu@huawei.com, fangchuangchuang@huawei.com,
        windspectator@gmail.com
References: <20220209134018.8242-1-liuyuntao10@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220209134018.8242-1-liuyuntao10@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR12CA0058.namprd12.prod.outlook.com
 (2603:10b6:300:103::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476a8ab9-c58a-4fbc-f4df-08d9ec2e5ce6
X-MS-TrafficTypeDiagnostic: BN6PR10MB1618:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1618928045675D2FEBD71C60E22F9@BN6PR10MB1618.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Zh8AZvThX5RTZNLDQItx4Z1xqjKxd6Ha/BofMitHaEOVNO8Txo6TqgWYyZAekhYkozNsu4yxvdiFf/Sq3rlnUqX0uDDSNTniz8BimmMhqlk6Pg0/0G2bRywgIcTEsfdNBnY8FOz+sAEVIVPmP0r2O2OAYh9flTmxpE54eyN/dHtvXKA3PFoJmIQIoxUzSAESgzi1qhBaF6mfgqWKFn2iG5VmOVyOOeqZmh3C73fBnqgCDU7CQRivpkkXtLlNoivpNY+cwkljr5C38NmlRkn4BUJ1Q7PLHqCW2cXi2uk/fQYzSeSrqbIO9SmSx3FtZiXc7NejXAvbnxtr9fnTDl41JwDSfavavGKTX308giQYZg3XFSg319m45QXNkioTkkIOXVjGYyDxKCytsXoP9dA/Bn8F+wwFV24CpdpXThkNaZc8NCq7pceX+mGmnh5twkpt+V/BvwgvKM598stLSC+xjI3aoAR9GJYYRuZD/dLlxXbUNYUU4ilgpYxR6lYTit3J/Vh7MGllGv/C+TtAU1fChvm4qfoHcfJGAIxSm8zWf/STEti46VtISx6jjFVAhprt4ki7i3bgwqsMAOb/XVMuZa47AzNXGJXmPzxObyhJebT7F2JbIwF0S4iyUfnEuF2/klLHMDrT0/tHF48Rckz9nbl29TRElsMk9UJo9vJ2c18YUmxX3Mcqa6KbwDwfvXVkI3aI+wpg31QRgvPJ4ZKxjIwAB1FzGXjTAI+pG8H8JbhTPf313+zLQHQRUBvxBJqO1T9mJN+DKHiLTO3EPb6RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(44832011)(26005)(186003)(86362001)(52116002)(38100700002)(53546011)(2906002)(6506007)(38350700002)(316002)(6666004)(66556008)(66476007)(8676002)(4326008)(5660300002)(66946007)(31686004)(8936002)(6486002)(6512007)(83380400001)(36756003)(31696002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNqZCsvV29yMnlmNjd1Y3dOQW1oOW5OOFdidHVXRnRkUng4cXpoRXJhWkI5?=
 =?utf-8?B?SEdCRkZWLzdQd2NvNlZvVjVRdkNTSWcxUWtDNDdjL3pMTXVnM0xyZXFOZjZE?=
 =?utf-8?B?OFN2MXdmWFVOUFFMNGoyS0ZzNitUOFJjaFRKZWZDL2xHOFR0SlZJN004UURs?=
 =?utf-8?B?cDc1VWx3b0I3NndiWEZ3VnNpeFRVMm9heFNPTzJaRkM2NHVtdDAvYk9NUzVt?=
 =?utf-8?B?MHBsVENaUkFVTkNRaDlSRktRMXhnczB2bWlHUVJTQnppbURNOER3RHgyL2VV?=
 =?utf-8?B?a1pnbGNmL2Z6VTRKdjJNVkxhQlBMUUJpNkpuNm9mV0tLSThncWxTM2kycTdv?=
 =?utf-8?B?MlVuM2FxS0VFWEhjQUk2eVp6MUI5WUx0RHJxeldYblVDb2pNUkg2OWMzTkJB?=
 =?utf-8?B?QkdabDdTZHV5TVNhWkphYlJtUThOMllBYTd1SGJvODBNM2dCTmE5a2pISDFR?=
 =?utf-8?B?SDVpZ0Q1UnNWUm9oOHlFUFZ5eDdtZmlWQ3FOby96OXREeExyU0tVZTE4Z2ph?=
 =?utf-8?B?T1RreE45OHJVczNHS0NSQTF2YUxWQitWTlRwS3NNdlNlYzlibDAveXEvZHgw?=
 =?utf-8?B?VnhFVzROellCd215em1zeWlyMEVzanVlRmp3bFBOSDlmRXRSVStVVVZkVUZB?=
 =?utf-8?B?bEpwT3ZKNlZhQU1ueEFDS0NhajBpaG9zN3g0ZTBNSjJldVpYV0R6K2VyZHh3?=
 =?utf-8?B?MW1yZWRGTVFNUWZhcmFXNVF5NktxOElRTTF5Qkk3WUlpaDEzaTMyMHFiSk1D?=
 =?utf-8?B?YTd1QzB4Z21tTTh3bVA1M2IrWU9RTEdESGtjTU14RHVjMG9BOS9BUVB2M1VU?=
 =?utf-8?B?NklvNlBocW1FNkwzdWxwY1V1NmRWbVJ4QzNpSTYrU1lCVlNDOVc5clRIYzg2?=
 =?utf-8?B?bUZ2Y0lPR05OUVFxMldiVU05ZldjL0xubE4xN1NlZ3JOYzlobXpxQ1hFYnB5?=
 =?utf-8?B?OERKK1JnTUZGR2Q2VVhDZUhKZFFoKzJONzFxK3BwSyt3TStDWnR3RFdHMmhi?=
 =?utf-8?B?djRBeGUxaFlUV29KbTUzWGsva0RTSnY4YnFlZGE4K1NJazZiYndrdzg0N0Zi?=
 =?utf-8?B?aURKS3RtZXg5Zmh5T01FSW9mZGZTMmluWElSNnhWdFc2eWljZ0IxcTBEMWMz?=
 =?utf-8?B?MUtwWVFOeStzTHYrcEhvQmZVZmZobWhFbmFSSStscVJtejg4MUR3ZXJlckNL?=
 =?utf-8?B?NFFnUFJDTkVZQll5alVaN2QwRjF4RDVDZm9iMVYxVmcyMllNSnRlK2VaVUZ6?=
 =?utf-8?B?eWZIUUVubFBsQXZZN2RSTlNKRTNqQ2M4Ri9WbTdmbUE0NW9Zbm5ZVTlqVkhK?=
 =?utf-8?B?Rm9EaHRKZkhDWUEvbkZMUy96OW9IVkE1ZUlpV1RFcjEyWWNYSHJTeCtoSlgw?=
 =?utf-8?B?cTZJSGVoejYrZmxTNHR4VEVNMzFDRXA2Q2ViYTlhaU5DTlRmZWZhZWhxdkMx?=
 =?utf-8?B?UGg3R20rSkNxM1oxYlRCVmw4ZHNyRTVPYTI2UGtJNk9GUU9kRzBwZmQvY3pr?=
 =?utf-8?B?d1RueDdTYkR3TnJLV0VsSjVZNTVEY1FOMDhGYlhwZ3lJYVhVdHJlMUtHd1Vq?=
 =?utf-8?B?Vk55Tm8zVVZFclk0S3dJVmpUaExUb2ZnbGhyR2U2cFB6SU9WVWg3VG1vSkk3?=
 =?utf-8?B?dTZpM3VIbXVyQzFQZzRCa0t6ZmM4ZnJudUkvaHg3YTZ6LzFwajZQenBLVzg0?=
 =?utf-8?B?UHNKUmlHQmFuN29CNEk1ZGl2QnNwRTJ0MFgwekU2cmcvbi9XL0RGYzNUYyt1?=
 =?utf-8?B?RVJRWXhKenNJempNTmRtWTJmMzQ5Q3cvWUlCc1dhTFpMMHd6a2R0azFleUdp?=
 =?utf-8?B?cENhOVJ2TVFRRHpwdUJOa01KTDh0dFFPTk9Ub3JrWVNwNURTT3U0cUx1MTlZ?=
 =?utf-8?B?QkZvWVFnSWJva1U1UXRpbTB4VnpUR0NSV2lheiszY1lGZU5Mb1FjdEdRWHNo?=
 =?utf-8?B?U3cvalNPbHY1OWtYZFVnSzQ3Wjd2MGJ0OXJlOW43cmZGbk5zNzNXUVpsUy9H?=
 =?utf-8?B?WGEyK2plaGdVb2ZNaTk1M05RNTYxMGtVM1grK2kvTDUzU0NYQXR6bUovc1hH?=
 =?utf-8?B?UHhvdE1XTzExSUlBUGRYUGxkVUFTNEtRMG9RUDRaNVA3YSt3Y0VPVkRybUhs?=
 =?utf-8?B?N2FtN01Lclp0dmUrNGtiSXdCVUtvRmZ0Z3JsblR6VDZuQTJ1UTNtQzMzakFS?=
 =?utf-8?Q?PKPjllZjfPEleGhGkO6Ho94=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476a8ab9-c58a-4fbc-f4df-08d9ec2e5ce6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 00:43:32.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnFozdSfpJo4MqYDXeW4r6X0OuR3h5cXCMM9UiTKygs6sjoi867vNFCOxdsgh8Akkvqm3/pvHsXK0fKqNhfaRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1618
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100001
X-Proofpoint-GUID: YFcMPDIVD3oyZ7p04cKSuYdfSg_71PzJ
X-Proofpoint-ORIG-GUID: YFcMPDIVD3oyZ7p04cKSuYdfSg_71PzJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 05:40, liuyuntao wrote:
> From: Liu Yuntao <liuyuntao10@huawei.com>
> 
> When we specify a large number for node in hugepages parameter,
> it may be parsed to another number due to truncation in this statement:
> 	node = tmp;
> 
> For example, add following parameter in command line:
> 	hugepagesz=1G hugepages=4294967297:5
> and kernel will allocate 5 hugepages for node 1 instead of ignoring it.
> 
> I move the validation check earlier to fix this issue, and slightly
> simplifies the condition here.
> 
> Fixes: b5389086ad7be0 ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
> Signed-off-by: Liu Yuntao <liuyuntao10@huawei.com>
> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 61895cc01d09..0929547f6ad6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4159,10 +4159,10 @@ static int __init hugepages_setup(char *s)
>  				pr_warn("HugeTLB: architecture can't support node specific alloc, ignoring!\n");
>  				return 0;
>  			}
> +			if (tmp >= nr_online_nodes)
> +				goto invalid;
>  			node = tmp;

I am surprised none of the automated checking complained about that
assignment.

>  			p += count + 1;
> -			if (node < 0 || node >= nr_online_nodes)

I can't remember, but I think that check for node < 0 was added to handle
overflow during the above assignment.  Do you remember Zhenguo Yao?
   
> -				goto invalid;
>  			/* Parse hugepages */
>  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
>  				goto invalid;

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
