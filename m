Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3449447E600
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbhLWPtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:49:11 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37416 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234588AbhLWPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:49:10 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNEiJ78008894;
        Thu, 23 Dec 2021 15:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yFyV+kFpLJGL2iLmWF72uPtbX5ljL13ZG4vp/nbptqk=;
 b=ulWK2TZ3Qxf0a4Z9PgTC0yUlE4T0q1FrkTxxaiXYMt65ToSF4eItF4/CfNcSdg/4ZWi0
 4sLhi4v9lsMvg/NmrEgNVVRp5fz6jKQPPTct0y4Q3+TmKRlxYANsdJOSmDFOML0HO02N
 4ZLDEFp2VTPiRq8HQdzgFAaNMFwuMLmZQG7Acr2Jrc4WY/F4m421TjCNbLyB7/LglMUF
 Hg3qs4h/rgxXF+bPiOYal5nbHZ6tLx7s/cv5AIaV+Omtshxs2WKoHzHS5BqcgE3innqe
 Be9ozEdvCoE7RQux+aS44FJ/ZxMGet2W6WaZVw2o8uI3uJ0NMLzRnsFYbO73JSV68+j6 Kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d4maw8yk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 15:48:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BNFUaJh003098;
        Thu, 23 Dec 2021 15:48:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3d193rt3g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 15:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNbVq6rokma03XdonmedZ7sG/OBlIakyM24MZrQHbkxJ41Z5HJOhZnelcuoCng/c59q9LngBt6XgRhFkyOpCnOCXoEyzUkQPYGAaYsLLDfsJWLDP/+8xW1wAFlJaauqWgbOPFihotBqg9S5OqTi4mGPWh6yIramqga7wKfXAjAoEwDYH1XoTyPH0JVmbgg3mY+6t3K1MEaRXghz0oPgC5qCT0tOkiGhyJPi01HezIz8fhLL2QNh0NpRPp9XPpP2vl+/dk1RESUV1CDMmsISqy6jePIi9N2oBCH9x+fEp5g1bNUmrbTB4K6ccFgw5lbW2Rcfxpw4880gCdXmdQIX9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFyV+kFpLJGL2iLmWF72uPtbX5ljL13ZG4vp/nbptqk=;
 b=NX3P98xrNKapjdM/piNVjvo73fc0HjqopquaP5fWboE7Rl/xaPTPZ3XBopXQoF2Cm/+cF8hciKNV6wyLVIwvBSe3CEWv5W2VXgh4mS+xTWuSC4WAn1zt0L13vueyd7Yf7/Tt/t29hobz942I67fv52q5ECgwcJyNgfHebU8ClopSXaWqZsWb7o3zFX+RKpOcMPAvD+5HsbtsGkBQz7wP8Vf5lx0N5ImP6LaBS4y8LSm6mKqyCqASTRxhvdtSXDz8ieMSfCut9rV+izplhzejv5uenyyEc3mUhgIQIi6YEdm/xGzE1GeP0HtuGgH7uUKIYXNf0rZ3aorAbiAPPglZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFyV+kFpLJGL2iLmWF72uPtbX5ljL13ZG4vp/nbptqk=;
 b=ALBkV/y2CELl/TBTJv61RzqdwBwU8qNn7zAUkLY7dEe31GvYY6B8o5Ub8h07MUW1pfzF3F0ZTnDrEOlYM5yoCd+OqZVUdhY3oAFh/eieZ0I87IYyUF3yjleWgSdraK56qGqQznBMip7Hjmkaek9hQWBlaCIxrl+igpgyy3ROkvg=
Received: from SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17)
 by SA2PR10MB4779.namprd10.prod.outlook.com (2603:10b6:806:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Thu, 23 Dec
 2021 15:48:21 +0000
Received: from SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::9531:f662:355:ace5]) by SA2PR10MB4665.namprd10.prod.outlook.com
 ([fe80::9531:f662:355:ace5%8]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 15:48:21 +0000
Message-ID: <e9f66aca-f399-bf79-3e01-91d419442788@oracle.com>
Date:   Thu, 23 Dec 2021 09:48:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v18 15/17] of: fdt: Aggregate the processing of
 "linux,usable-memory-range"
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Pingfan Liu <kernelfans@gmail.com>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
 <20211222130820.1754-16-thunder.leizhen@huawei.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20211222130820.1754-16-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:806:6f::14) To SA2PR10MB4665.namprd10.prod.outlook.com
 (2603:10b6:806:fb::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 110b06cb-b113-4d7e-99d9-08d9c62ba593
X-MS-TrafficTypeDiagnostic: SA2PR10MB4779:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4779C909E6CE06C25F0B24A7877E9@SA2PR10MB4779.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pErUPVs2j66GdoxI+XO+p2ySQeDFJzGbn1YKjOLxBzTsUcRn1CbexYWunzpQkF0U01S4P41y/HgHjX+/t3zB7SJa+embP9eEJdtN8z7zAacIGmC8FFUaxcyBHEE/a+dKcA3g6gvIfMRpNXPiZlNkxjv4LYSoB1vCl3Vs7JYWsxR40xVrpmB8/Z4/eVjdU3DB/NfLYe9nIhaCmMMt33BLQOJHsyoUtPPWOHRDyvVinax65Q+bPO8KlZhDOujSzwg1kC3lg/2FDUMPZ+qmwdf75TiBmv0MTbjKCWuBHx52GV9ys+FIk/xxC6uxiO6uWHp1KX6qUVRiEAc2uQ9rf+TMKeCHj1CctPbDYaJr+uN6PN+C2rwUItd9V8+ANROZHLE8zIzCTsqi0qZdqLk7faxZqF6cZOzG0kGv43KgasqmXjRVB3WZsfwbWTcHQNUgi1cO8LBovuPfc7Pku05siFO0HPQWtM86ncIQ+iBDd3lqP8GJQzBvNeYLIg/4RWG0kK0jRZZm5JaEEgan6d+W8DvUoiv1Xc/9jCfuXs6ID/M+hEngo1rXqYgXc4C1l0WlIa5/hRQHtMaaR5OUrz4KViiLnyo620Nvjpv0FVGN1LjoY+pfZqgx/HiHSE8xor8mmdSvDj0NF2f4YKsebywLBzR0NkgVPmIA2OhZPwrCEJL13n5L4UFiRKEunN0lMlLocNVS4glylb8357uAFA3+R3pYJOYw0gvoY/7bDlS5hZs+eP9eupgYCjNsUq0DWPfwZQrxDPvU1X2xeX3aoPlEWn0T47OMcsPSSJBs17ACrmJoGsI8JKQti18UYWPCxBQkBFsdHID/lDQ9U9QBYGYf2QdEOFELYu3JouWf0YSa1b3GlnnT0aHiMVzyrBAkLlWNnuMj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4665.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(110136005)(6512007)(44832011)(921005)(31696002)(2616005)(36756003)(6486002)(8676002)(86362001)(6666004)(4326008)(66476007)(508600001)(31686004)(83380400001)(7416002)(6506007)(66946007)(66556008)(8936002)(5660300002)(26005)(54906003)(2906002)(966005)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZWSHNMbm1Yc0ErQTVtMjk1UVgwdVZwYS9XWStIUktBSDJySkhUNmYxM0hT?=
 =?utf-8?B?WDgxc0xtQ1F0Rk5SQlUvMUZ5bzJOUU5WRU94K1Jic2dmU2FFMlYvdlVLWkVz?=
 =?utf-8?B?NUwxNTRPQ3Z0RGVpdklMeFZEaTZrLzdMK0FlY2pyd0VVQ0dLTUR3dThXS3g4?=
 =?utf-8?B?THYrWHpRbCtlaEtOdkpMM1JFRm5IYTRXaGROTTRXMDJ0dS9kWmJJSXlqYlNt?=
 =?utf-8?B?YTVldWZiNnZzTlVKeXovdlhoQW1sR1AxRHVEdmpqRlNEY0QrU0ZSV1NubVVC?=
 =?utf-8?B?di9DNHFrVm5RUWI1MHVONGNnNThpeFoxNzdibmxPYUUyZ1g5R05mdmk5SFB4?=
 =?utf-8?B?Z3V0NUxCRlZrREx4WlRCWnNXVUlXT3V1N2pXYVN4ck1zTHlPZDhWaVdzN2lw?=
 =?utf-8?B?c2puQ09kWjJEb1p3WHRxZzlOM3RUUE1hWWtQbnhRYnhEcnlQTXZtY1IzUGhE?=
 =?utf-8?B?YmVlazhoRWtpa1MyNm12dTNRNEFVOUhtM05oM090Lzhtd24zQnJtZFd1N2V6?=
 =?utf-8?B?THV5NDNvNE5JaStqNStlOEFOYk9LS01LbVExZXByUEhONnVNdmFuRU1pd3ZP?=
 =?utf-8?B?RUxlYWVHL2xVV3BpTitRR0pSd0c1Y3VBZXdlUFNUaThmall4RE9XSm1JNlRJ?=
 =?utf-8?B?ZkVkQUY4T2hhajg1QnA5WVh6dmQwR3ZLbnNnYXY1OGp2M1NUc0xXWXh2eTVa?=
 =?utf-8?B?cmFYRkVyaTFDSGdrWTE3UjN3ekt2aCtIdE9BTGxEOWlvWGExc0xBeEltYUNX?=
 =?utf-8?B?aFRnaWdQdEtCWlBNZndWdTlQNG1yMENOWlhoRVpJeEtYUVJuYWxRcnpRTUxQ?=
 =?utf-8?B?b2IzYkRtckl6SVNwTE50emJlZHY5ejFBN2cyWFFhQXRBdHpDWmcza2JHeSt1?=
 =?utf-8?B?U0dSd2owY2tRbTNTa0dvczVoaU0yeWlybkVmTDBoMnZhd2ZOTUlCdk9oTUlC?=
 =?utf-8?B?TnR4Y0RRYlZqdFBSMG02QnJjQXlUSXozbTZ2b0ZndlhuWExuWHVHUjlqMmRW?=
 =?utf-8?B?SG1INDduZTdKRGZnMGdoTndDdEV1ZkhGU2dQcEVGMk1IYmRMYkp2eFBkekFo?=
 =?utf-8?B?U01IYVpWSVoxVXdBeVJMYjlRcElrZEdtd1JBazh1aXNFM21GWXdNVUY4RHEx?=
 =?utf-8?B?ckEwNHBxWm5lUk5lTTVHY3NKekJIbWdqcVVLalpWTjZTM2tnWDlGaHdLbE9I?=
 =?utf-8?B?SGsvbm9xNmtzRkg1cjl0RzZPeGg0K21pY1dOVFlsZmsvdEt2b0ZrcG45ZGk2?=
 =?utf-8?B?eXplcGRVQ2RGMzNIdHZ1Q2RrclA5eHhJWHlPRzRrcVZ4UFMvTGhiaks5djRR?=
 =?utf-8?B?QzFsc3NzZVVEQlJWdGtsNUJWbFFMVk5YNnNMUUtyVUVvR25zRTZOZVEwRUtN?=
 =?utf-8?B?Ky8rdFVqakVuOHpNZlM4V1Z6QjBXN0tZVk1wSzVhRmFwMUFWODQ4RkxNWE9L?=
 =?utf-8?B?a2wxNTZNUGIrRFZXcXlCNzRlUzJjYktyUjR0SnJ3TWJIUk5ja3JMb2ZBM05y?=
 =?utf-8?B?ZVlLMjJPL2ZwQ1NyVVdxZ0hTd0hHYnFZYVhtaGliSExXRE04NUJpeXNLY2N0?=
 =?utf-8?B?ajZwZ0VUclFBdE9aMlpjMytXSjVrOGVGblFiNnBCb2Z5M1NyQU0reXY2cjR4?=
 =?utf-8?B?bzFTMXhOSjh0ZTg3OGgzYjhPcHB1S3dxRmZSV2pibnRKQW5hVHFteVU5eWIz?=
 =?utf-8?B?WFl5blBvZEZ4MExwdThQWHV4Y3dGNGxjeW4rL1hBeDY5ZktPTHFLcDAyTmpW?=
 =?utf-8?B?c2dpV1FyQzZVYmlEYmlVSUt3ZWxCS0JOYXA5NmZTaDRRcDh5NjRuVGVKWDQ0?=
 =?utf-8?B?aE40ZnIrNnNoUFI5WXlGUm4zSVRPeWlPT3M0d055UG44WVJrQ1BjclpIMEd5?=
 =?utf-8?B?THVRSjBrWWFISUVMVHo2bkNOakU1MzQreXROSnd6OGE1R0doUURMQ1JVdjNL?=
 =?utf-8?B?K1llZ1g5b2x2SUNZSktZWmdQdWNYK1NCVHc3cUx2SGhLNmc1QThXQzVLL3BS?=
 =?utf-8?B?bmlYbE8wKzVENGsreUpjWU9ZWkZLQkhZTnl6Z2g2QkE5ZkZWcERnRmFXYUxJ?=
 =?utf-8?B?NzgyMmhtc05ydWZHenoxQUpFV2xmT0hxanNjTG8wY1RWK2FqUWlDc2wwYnlh?=
 =?utf-8?B?TTNqSGFqNXVqd0pnWklMYVdOVFhvTXloZVlaeVY1RmMyVE1lQ2JHTHhoeWRr?=
 =?utf-8?B?N1U3Vk9zemE5dUc2MHhKYmxjaEZJVHFma3g1U2VzMmtrak9wM1V4dkd6eG4r?=
 =?utf-8?B?M1pYVTFyWHlQclVQa3FZL1kxM1V3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110b06cb-b113-4d7e-99d9-08d9c62ba593
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4665.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 15:48:21.6579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sH/TjSf8/VHlcqkvaDeRCDwYfUWUBgvyZzVj4YAoEfs8MaiHbBH2n17DG4pO45G+5Pzw+3Tacz4gqwum2J0Khy/rUnOBj+lm5/BfVRdd1pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4779
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10206 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230084
X-Proofpoint-GUID: OQekjZ31ZJPwby7pwyG6FstLACqp346P
X-Proofpoint-ORIG-GUID: OQekjZ31ZJPwby7pwyG6FstLACqp346P
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/21 7:08AM, Zhen Lei wrote:
> Currently, we parse the "linux,usable-memory-range" property in
> early_init_dt_scan_chosen(), to obtain the specified memory range of the
> crash kernel. We then reserve the required memory after
> early_init_dt_scan_memory() has identified all available physical memory.
> Because the two pieces of code are separated far, the readability and
> maintainability are reduced. So bring them together.

Rob Herring is pushing a modified version of this patch (changes made by
Pingfan Liu) to fix a regression. This will cause a conflict when it hits
mainline.

https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=dt/linus

https://lore.kernel.org/linux-arm-kernel/20211214040157.27443-1-kernelfans@gmail.com/

> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>   drivers/of/fdt.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bdca35284cebd56..37b477a51175359 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -965,8 +965,7 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>   		 elfcorehdr_addr, elfcorehdr_size);
>   }
>   
> -static phys_addr_t cap_mem_addr;
> -static phys_addr_t cap_mem_size;
> +static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>   
>   /**
>    * early_init_dt_check_for_usable_mem_range - Decode usable memory range
> @@ -977,6 +976,11 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>   {
>   	const __be32 *prop;
>   	int len;
> +	phys_addr_t cap_mem_addr;
> +	phys_addr_t cap_mem_size;
> +
> +	if ((long)node < 0)
> +		return;
>   
>   	pr_debug("Looking for usable-memory-range property... ");
>   
> @@ -989,6 +993,8 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>   
>   	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
>   		 &cap_mem_size);
> +
> +	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
>   }
>   
>   #ifdef CONFIG_SERIAL_EARLYCON
> @@ -1137,9 +1143,10 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>   	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
>   		return 0;
>   
> +	chosen_node_offset = node;
> +
>   	early_init_dt_check_for_initrd(node);
>   	early_init_dt_check_for_elfcorehdr(node);
> -	early_init_dt_check_for_usable_mem_range(node);
>   
>   	/* Retrieve command line */
>   	p = of_get_flat_dt_prop(node, "bootargs", &l);
> @@ -1275,7 +1282,7 @@ void __init early_init_dt_scan_nodes(void)
>   	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>   
>   	/* Handle linux,usable-memory-range property */
> -	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> +	early_init_dt_check_for_usable_mem_range(chosen_node_offset);
>   }
>   
>   bool __init early_init_dt_scan(void *params)

