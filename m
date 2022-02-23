Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B504C05EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiBWA1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiBWA1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:27:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415E653E2D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:27:24 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MMo6XF018680;
        Wed, 23 Feb 2022 00:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FOLYmfgDEXGa7tBlRB3sd81BH4RNjJH+7+EMlU5flS4=;
 b=zyCChgLdEJxjIFdfNXcOrRVWZ5FXI7j1vm7xp81E/D8fH46w3mm3JQdP5WYNcVL57t3z
 rmA+WvTeqJgK9C7DJsxvKq3CmFmAtKuVPpZxU5EE9d84TRfBgzEmWQHZEkU4U0v/aNXp
 eWAnmvRhDc/jA2Yu95caGxD45MTAB8xJCVJ+L9UCja5pHi6wgbJ+JLB0ePynBP39H3kx
 JJ/a1Joy78A+mfKqs1Z483oLzzOIEp0+tfBLb++RBpTHGFP5Kgpzv8Lxtb3HNsYfcs9I
 EyGmmkKTdsSbLF2w1imy4wi3jvyKbiw2HQtB1/hCf9gj0y8pOZiFSBx69q4X9NFZ2d0w 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx2qh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 00:27:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21N0LZkW025727;
        Wed, 23 Feb 2022 00:27:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3030.oracle.com with ESMTP id 3eannv3c0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 00:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiEfO84xNQGKiWKCg7M1/GY0F8KZg7+DJzS6uynfZFa6zqY7lmdB0/4BJ8FAt7Aa6fdr5a+Tc/tbY+k6NXHQ5i+FqIHRaHcHUgZ8nEC48JLTm6ChATNGh9hmKp0pnc6SR4vzTCi5R2AmlywF3Et1sKiaMvetE/VfUWaYuOXXvcX95XXPpDV9fcxRdesolT7VLGU2E3/BkAc+DE/zwrvvv9lAqP7tHDtnMuSe9lQkCiPDQ3RNoLoaPBm1vLi6np6d3+UCK170azmIBgbfUHzzh0Q6QRucLjq+gXPOfNYUg924csfaQhUoScqFA10lnnkMhBQ6Z069iumLL9PTyux4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOLYmfgDEXGa7tBlRB3sd81BH4RNjJH+7+EMlU5flS4=;
 b=DWHdI0pj13MBxvSIGVOBaP0+yeQKV+C0oQZ04pl6XyBQVJJfkQg0bFucBMHe/PpwXajADZClKcDSwyOCp70wZjDKvBKRkhq3Z6h6RJc9jX62IxKbjqx7KblVVgUPtBJ9aTO36TdX4HrBD49uQCgAptY/Y7P5CC3S7NGAwOJV9qJFTOdhc12AUVIbvzOwurF6AreOvuXVlfy3qxxBW7Pqub0hUn3h1WoFLz7Rsm0DCy4mBVx0utB5k+ZGnnlkbf0OhjlUwi9SLMc2YbVm0L2Lld5rtwBheNLVS9ynF4hqcCk/6TLFxNJuRba7tOsxjVHzsI512z9XnPEwF4B1I6HEQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOLYmfgDEXGa7tBlRB3sd81BH4RNjJH+7+EMlU5flS4=;
 b=YcEJqZmRMMs4vVDe47wvDblyJLSydnriio/GY45S4hL7MRmp2rpj1EprIQdcevDd2p8z0fZRqgW3RrRl9vUs8YinN+YNslP8D1tnI+aN3zZk7IiAlfI5Gv8CI1INDGXQq0sGPwIty26xequG8CZgpwWEMu1k6Rc9pZt05mh+WFw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR1001MB2372.namprd10.prod.outlook.com (2603:10b6:405:2b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 00:27:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%6]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 00:27:14 +0000
Message-ID: <6383a6b9-5e03-25e3-922e-97240d7b59ca@oracle.com>
Date:   Tue, 22 Feb 2022 16:27:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/hugetlb: use helper macro __ATTR_RW
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220222112731.33479-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220222112731.33479-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:302:1::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3cc9e3e-9877-45c1-ef45-08d9f6633d4d
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2372:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2372B3E5AF810DD80DE8441FE23C9@BN6PR1001MB2372.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYk6ZZtzrqKyGgQavMKtYZ6LgTkv8ftQIjMEsES5eHstck3dPE277YpAObUc81PuLdhlyy4EZCS6JPKOG0y7no4G3speDbZXZgVwzBNWFhciIkqyt8vPGkfT8kAYMUOUy6QahMpipi30641YRgyLl4XmWJW135MiHlQKdY1N3tTm2xwR2G0lfmvX18HRiLGeMLBb0w3LYMi3QtN9apfr9lhri5uSdTXMI0s1bp/9CStdjOOGkpn5oNSxZZeVszZKGeHOQlQcFiaNNzMoLgQ+c1xz8MQXBRZWkVH2EJ3XfSAP/RGKzsXwo1O7UfUBQmnBbJlKYKRmAPVMNtItIyh7TJOEclcdIpRj2N7lIRXoLjy1dV/bgOWz7OQWp5ZyGGl06I0Jx1ZD54QzPSpMI6TxpcE3p5iwlhApZLfQflhRQCyOKufXaCutEnHFVAzDoU3sxQt3iBxlUpyE3pfHI00P5aJNTnr/tog0kdyxIPU96NsZsxvYYqhhBSQJelV/cn8CZ08EsO8tlB/fX+x83a4qk3OWVZO/XYIJiu6z8du6vfO1Z7OudfvKNWeh1HrfvxwiMddfGf+1HGlrwB/p3SYuLzxc8aMJ8m6JK5z9CBqmtFGAzoLgWQtAZ1pkrtQjrQPisnOcIBEvCotYVqDNbgO+IUqnH5wyyqBL5e58WTmOD5fzotGQ3flVNnWjCw/r9DYKJnhkaJQ4//79FUysLvcknRF6P4FfzkwdwHW3gi1vpEJgNL84fQ1+5PIug8McV9Qm5YPs4YH5E4ENUi5L/umSdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(8936002)(508600001)(31696002)(86362001)(83380400001)(31686004)(4326008)(5660300002)(6486002)(36756003)(44832011)(186003)(26005)(38350700002)(2616005)(6512007)(6506007)(2906002)(66946007)(66556008)(66476007)(8676002)(53546011)(38100700002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFHQXZNcUYrNnVzc1Y4RTNuUUhheWs1RTE2eHVjeVN5VU9Oek81VEdzLytj?=
 =?utf-8?B?UkQ0c3I1d3kyYUpvMU5XWGhqKzhtMkg3SnhtdWJxQUc5Y1IrNENjaGwxbWx4?=
 =?utf-8?B?dVFSVlJtcVNqMXRpRkQ1Umd1S3RLZHFjV0FMUmlCQ08vRC8yaWZ1V3FneFor?=
 =?utf-8?B?Z01TZEhsTGpsSHY3UGtlUE1rbE14YkR0dDBObGxucW1Tanp3USszc3NxRm5K?=
 =?utf-8?B?OW1JNjFvME1JU0RaR3JFTmdpNUVWRFBqQkJJb3Z6ZnJ4Y3NhdjJ3SVJ6ZjBu?=
 =?utf-8?B?Y0ZlOWMrUjBIb1BoR2Uvc1ZyRHEvSUhERElwNGdPWHdKd1RIZTc1VFR2VERT?=
 =?utf-8?B?K051Kzl4Q0FBYlZHMGYwMEU0OVprajRiK3k1dW5ZNS9QNHFPY2tENXlCUmYz?=
 =?utf-8?B?amFDeG9jZ2ZuaU5nRjQ5TGRBcVhjYWRnTzhUdS91TTJ3TzRGYmJXVUFqTmtK?=
 =?utf-8?B?NEUzZTU5a2tucEc5dFNZM3JUcldUOVl1NDh6Ky95aS8zZktyTFhVT2c3S25w?=
 =?utf-8?B?T0dRRGRtQWtLTlI4d2N1c0FFcVZid2tlMzZFN0lST3ZyZkRYYStwczlvV1o4?=
 =?utf-8?B?L2tuZU1CVk53aG9GRTJSVGc4NE9LRmNDSmJURFhjN3pyME9QOVBKYlVaYXBv?=
 =?utf-8?B?VS9XWVd0clI3RE9KRTJmK25MM09PZVE5T1JtTythcU1oMVRQOEpTQ1BsL2F1?=
 =?utf-8?B?bmczR29wYmRKZVEwaG51UzlwZzd5SGZiWUswTkhDR1ppOVpXL2dIM1EzWWdt?=
 =?utf-8?B?WmtRUGMxTzJIdnZmMXh0VEtnbFkxM1YvYnhhSkVPL1NTbXRVUS9HODFvK05W?=
 =?utf-8?B?Y3JDSDBHQ3lwOGRvWVhKbGRTYXZMMGh2MmRhaFBnLzk4clZXMXZ3K25WUEdP?=
 =?utf-8?B?TUc1R085NmNHaWh4TEVDMHZMWHpVSUpTdnRLUmVaYWw1anRObkVnd3czR1A3?=
 =?utf-8?B?WkxOZURhdEhhV2RFbTJjK0s1SG5UUi9RaWFXV0sweTZGck1FZUI1MTZGUSt0?=
 =?utf-8?B?dllocmdOWDdYT3UxeVlmZ0NMeTRZWmVYNTJBQ3VIUjdxMmo2bTdzSFNUSmx5?=
 =?utf-8?B?cXVGODBCb1crZWdvakFHUnNCWEc4S1Vuby90WTA5QjhRUDRoNEdaRjBRbjZj?=
 =?utf-8?B?WVVWQnZpaE4vRXZjaTB3VFZSamtDU3hCYXl1NjFkMnF0cENjdkxiTnNiN0Iw?=
 =?utf-8?B?TERqNzd2K05JbGN2bGdyV2tKUWpPN2VwMWpNcGo2Q0UwQkZ6cTBBK2Z1dFhK?=
 =?utf-8?B?RERYZ3FJVmZHaTdqUDFleERSVkVGRlY3ei93YUsrYnRqWHZTalJlRTRIemhQ?=
 =?utf-8?B?WmRrdjh6YTUzNjBCcnc0eWRxNURnUnB1ZXRtREtaZm9kZ0dYSStGenJWWlVX?=
 =?utf-8?B?MlR3ZGVhWnc0Rm9yQ082OXR0SkZjN1l6Sk85V2lLVDR4aHh5Rk5xQUhTNXNv?=
 =?utf-8?B?OGZpRWtMYVNjMjBmaVdobDJvR1I1enR6OThGdDBReXdzQ3lnaDhROC81Qnp0?=
 =?utf-8?B?Sy8rRWdKWFQ3QjBGTEg5Um5VVlRUNDdyQldqcEF3aHNNMEZqQ1RveTMyRVFC?=
 =?utf-8?B?U05ZQitMQkQ2cVI3cDlSZUlqOUlPU3FIcElqVmdQb0JLRDN1QVZwKzJOSjlw?=
 =?utf-8?B?cXdsQVZxZzBUaHZldzdqWUVYcXdSdXZBdTlOdXVvTUR0WGlCSGZ6QjBPeVVl?=
 =?utf-8?B?TkorUEZvM01vUDZJWEtkRElCcVJ1VkhVTTBlcHZiQkdCVndHby9xbkFBd3o0?=
 =?utf-8?B?ejdkQUJOQ3RyTlhVUU1qMVRLYWxzSW9odDBtWXJUdWl4WGhxcHRrQXYrNXFo?=
 =?utf-8?B?WmdsazQ5WEdOa05VZ255M09FSHFhN2kwK3Bjc1U1RjZ6ZWh2Q085LzRGVnZv?=
 =?utf-8?B?MFM4eCtRT0k1Tjk1Q09TZGVRQUlwNnFZbWYySU81UDNtLzJTdlJFR2IzVm50?=
 =?utf-8?B?RUNCWlFPbWhnSUNpamZTdmFzTko5azYyUWZnV1QrdXN2Mm9qWmhjR0c0RDFF?=
 =?utf-8?B?NTBqTG1YYVl3MDd1ZWZQVjJXaGJtNm1ucjk4aXUzTU9henBoRW05dzgvYTU1?=
 =?utf-8?B?U3gwQlRiTnpDZThXcWQzVlIyWkp5VHlhczBJL3pqQ3B2QmdSdFdza1lqUUZo?=
 =?utf-8?B?L3pRZ3FJaVZ4U2JqT0tLcUNkdlBCemVwMW14a0NLNDAxYkh6WnF0Mmg2R2R5?=
 =?utf-8?Q?aeGdaaE5WTm6qa+S7SSap8I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cc9e3e-9877-45c1-ef45-08d9f6633d4d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 00:27:14.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7nUeNBqb9HDMAFJgzz/8lH2qWNpvzEM87+AUx0wHeUABihYPM4QzmjMYDSyx1B5BAuzB/0XJDT6Rpi+EUxbcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2372
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10266 signatures=677939
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202230000
X-Proofpoint-ORIG-GUID: dqjgoNaIoV_C7ncI2ClS7pUOpY2R1uAa
X-Proofpoint-GUID: dqjgoNaIoV_C7ncI2ClS7pUOpY2R1uAa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/22 03:27, Miaohe Lin wrote:
> Use helper macro __ATTR_RW to define HSTATE_ATTR to make code more
> clear. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks!

I should have noticed and changed that when adding HSTATE_ATTR_WO.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1f0cca036f7f..c0405f3c8413 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3498,8 +3498,7 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>  	static struct kobj_attribute _name##_attr = __ATTR_WO(_name)
>  
>  #define HSTATE_ATTR(_name) \
> -	static struct kobj_attribute _name##_attr = \
> -		__ATTR(_name, 0644, _name##_show, _name##_store)
> +	static struct kobj_attribute _name##_attr = __ATTR_RW(_name)
>  
>  static struct kobject *hugepages_kobj;
>  static struct kobject *hstate_kobjs[HUGE_MAX_HSTATE];

