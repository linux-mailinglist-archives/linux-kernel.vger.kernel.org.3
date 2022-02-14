Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC71B4B4FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352954AbiBNMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:20:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbiBNMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:20:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561AE488B4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:19:55 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EAvAs0018836;
        Mon, 14 Feb 2022 12:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BmdVgDbdYIGv06KXEw68G9Me5RN1bpa2LWjxewYNKB4=;
 b=tM7X54k1d549zaaUVT7PgOmQiU48gf2mbxBw2fiOop4KQGS7tOZJmSfUYKnrVyd1b82R
 1Z2fjg00mqW/QUBepDRqY0NP1rxfmD+21i2D3toJNVGkD6nOzuNhnkLGZWa8fXQ/dhN1
 GEMI7fkPUcr0NrLUrXGAoC/qYxwpZeHJK3/Z1UA9SKq/GdfGY4COVWXqxLLob+FbHuMy
 q7ERqIqUtEP6FrmTJ0gsjM/brnkXYS5hdz/HktNkmZisUJeHrUCrt2N3zqA1uAeEsDBX
 yuetPF3htlb8kOM7CN7RmdvtL6sN+oeeefr6RT3reF7fSQk5qUOzcPM6mIuc+DTzRNgf Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e65euc767-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:19:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ECGhcQ155095;
        Mon, 14 Feb 2022 12:19:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3020.oracle.com with ESMTP id 3e66bkxcr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsGW2uApBTIF+bO90Glsxv+gMZJY1l+bbSnA7tDKs4ZsUV6Ujr5pRQndDVOoh81aRH3hJFNsUyKdZTvxZ3vRm+RVBoAKq02EyMNSKJXf7ESIm2VWBTeIn+xDs0pfIXPy7s7XfPSqz6Ipb8yr40Rto9d/8xJpWV+74RyNBY13JnI6dVcapMVJAy8CdtL0PY2OyxjrUJyAGQlFbgfeYFVugsd2c7D2qCmquVjgdAh6zO4HSVQnobILC7IQJ0fXmmoPRf5XKsC/f87YT2blvLVHRm0WRKdM6C/V4U0sYKS7CJUYarD/fcEZTRYP6ltjYcztLjiTmJpRzFYeC4Qe/WwO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmdVgDbdYIGv06KXEw68G9Me5RN1bpa2LWjxewYNKB4=;
 b=b6fuAtKAbi6ZhdJzslqYch4P+btTnsLj2mhXv7i/kWIDPzsfFRcNWwFcRrH0u8JpkUCWnRktKs4XdMHdUBIggk6Tv3kGY3JTjPee12Yc2xF22WkEw5oAEil6xyeeHNBvuL4/vDqB4HGNMyO0KlS1/IwmniVjf0A4OKxPT7Wsr+pYVI5W7Qod3O5HDkP2gX5b58UHZo1hc27/TpaSwB8bX5sHEPCkU9euMHVNXI/ixojffnpx9Ko9lFKSIZ53hPT+bLO8Yn2vvtSagGrccxTY5qEEiPKcnVAqcN286A+eqNwkP0Yg4td38el7m4DZKA3hViHOe0McFxnKmnqlaIv5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmdVgDbdYIGv06KXEw68G9Me5RN1bpa2LWjxewYNKB4=;
 b=GYzfFm8byX4/2G/GCLovyMz7PzrFYkvPvuwvqBW4+x3Skg5j7/qaYbQh8zIGgNfrRExrrdHhXsqbUwpevK6AwjCtHR/NZA5J45xlgP8DxotgG+ykiM8SJ8CLCIcZvA1Y74pMW8Yj6/0T41mvBlnQi1K+f9qouYKLyiGDMBiuIcI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN6PR10MB1827.namprd10.prod.outlook.com (2603:10b6:404:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 12:19:48 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:19:47 +0000
Message-ID: <d07546ea-0dd3-f795-ee04-e4b40db5354d@oracle.com>
Date:   Mon, 14 Feb 2022 23:19:38 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v5 1/2] kernfs: use hashed mutex and spinlock in place of
 global ones.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20220206010925.1033990-1-imran.f.khan@oracle.com>
 <20220206010925.1033990-2-imran.f.khan@oracle.com>
 <YgKm5aSCcCYWkck2@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YgKm5aSCcCYWkck2@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYXPR01CA0101.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::34) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d23be297-4f85-4e6b-553c-08d9efb44aa8
X-MS-TrafficTypeDiagnostic: BN6PR10MB1827:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1827712A38AB45C144C7BFC7B0339@BN6PR10MB1827.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCFZnjlREW1Xr0FPwwg9HiilHPZ9nlMtBi7c8J0uv/IAgQKtx2YfiMlELvUNctX7dMKPSXEpJO1fKVKtzosodyJZsL+qetbMPG5pjTYx+WJxi+x9kEPwpdvjJSqYlasFASxPE6n3YqaPGQXB0u+8zXNi+27G5pB8zScONdR/tK4c1x5cWWRMzr7fSp8UwcT7IOUZTOYt25ucerY2qKg9BCc9WU2SPxmYyCgmbFXHoFbSyZ3dbXCbyKNVO6sqbyDtKDc150XU0BN/4APF+1MqsL9SOEWhw/f675hrVjHh0kZpTyqjhguBuET6O3e+7k3VGIESsdCWbf+GN3Y4YW76vIpuso7g969MO1vv/ZPaYRbX0azhF6DN1vBlYXjy7SWEvUXR37xG34Y3QcEQ0GV1ZI7ePTtZ4a4MfMZ99YkBOfhKOCKbg4skxIjj2pKZHGHP5W32E2ME4ypBziZZymNr7SgmJP0pJ7aBF6v3dxRFEgny+BPWNzQ4qMyA/qI/Wbd9sjEV1xAKivpEOs5ySz3lSBc9y9a0fJU4JbAshMK2A8m+VVSER5c3e0Hq8BZQGbReGT/Ub+rAChnuqjdJ05yd2L3vU4isIabp/T6JcGRUmb2uCr+r7vJJlIDVDYvuVKzzRrigUIYuY8sNUv3jt5KHKopO5f/tC7y+7ohYX3m+Z9uuW50ydDxz/e7bxnBpo4f8H2et5y9z4pZr1wQpJrsBjvlJbiAa8cXeKi35CDdN/PaNjr78TBHsAW7H+8heT1+RPCR8DSAY+0jTeFaPOXxz6CMbdTX9bGOTfEN74xXIeWGh5O3MvVgFe4rItHoRfUMX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(4326008)(83380400001)(186003)(2906002)(31686004)(8936002)(5660300002)(36756003)(66476007)(508600001)(6916009)(966005)(6486002)(66946007)(2616005)(53546011)(6506007)(66556008)(26005)(8676002)(6512007)(316002)(86362001)(31696002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFROMUtaS08yZFNScnN0Y0VQdEFxZkxuOVpidnpwQkZGcXdaOHVrVUFGa1BH?=
 =?utf-8?B?NVpEN0dnQmthaXAwNFJ4MU1YZ2FBTXk5bUNiUldRbWwySlZUSUYxS1BJTzhH?=
 =?utf-8?B?MVFOVWxZcks4b3hqRlRjM3V0d0x4aXd5WXZ1bURFRG1oQUdvd1diVFFUV0hL?=
 =?utf-8?B?NjFPeVVSdm1IcCtydnlGQ2Z4OGZIa21pWS9VWTRPTDZiWklZOFBOSjR3Znp1?=
 =?utf-8?B?SlFsbTVpbUdDdDBIUWFveHFubk5pNjU5T2hMUURRTU9iUFZ2R1ZuVjVsaVc5?=
 =?utf-8?B?dE5TSEoranBHVVdOQnNIMHYvSG1EM3krRWVsVHVGUkdVOUkrbkE0KytsTE1E?=
 =?utf-8?B?dG1WZUZMRG5DSW1ZV1Y0N05mSklBUTg0MXVodTdZak0zUzdVeW00Y1JxRVZ1?=
 =?utf-8?B?bFpmYWI4U1JFa1pXQ0dyNWxBZVBNaVhTNm4xVjlHNHhERndUNEl2RHYrb29k?=
 =?utf-8?B?T08xOFZ4NWdVOTAvbERrNlRzWEd3dm5BUFY1NGFKc0plUFVmbnQraXRKK1NN?=
 =?utf-8?B?Vmp2bGRpSGxkamRKVXJEREErQWNkQXozT0lnR2dhMnVML2pYTHpBT3JnMXZ2?=
 =?utf-8?B?RnhmM3VSclc0YXFMQmlSRnRGaE9PSEhlRk11cmhxdkc5dmc5TDF5YkRGUXB1?=
 =?utf-8?B?MXJtUzUxK2pGaXltRHk0dmVnTGhQUkxjMFJJdDg4bFpBSHR5SGZjalJSV24x?=
 =?utf-8?B?eVZYaHpSUXhpRTFHYS9UdmRkcWpTcHBLU0Y2UXoyYi9oNWR6bXBiSGRaN25V?=
 =?utf-8?B?eEV5VnhFWDF1OFFSMUJCNHo0cGltZFpMZHhuc0ZRTnZLTWE4NEpkaUNVTGt2?=
 =?utf-8?B?RE9qYUMwRUZGZzFDZjdWWHcralEzQ3F6SjllWGZIWm5YWTc2dUtNVGtNeThh?=
 =?utf-8?B?T2x0V0VhbWdLcjlpMCsyYzZiSTBrN0FJY1BvaFc4NTR3WklHKytQOGRlVU5M?=
 =?utf-8?B?UTduekpjeEtKaFJMRk9qRXE3dzFzK0FEV1h0ZmFPdHd3eVN6bHVTdHhqbkdK?=
 =?utf-8?B?UmRmdVRoY2ZyS0puT3J3Y3F6eVVHSkF3RkRqM2JWdGdSdFZmZ2Zqc3pVYkV2?=
 =?utf-8?B?WnE1QkVERGpjTlJGelJPREVVOEt3c2FUbXFJejN4WWVYNzJWYzdoelhqOE5w?=
 =?utf-8?B?REJzckp2ZEdvOXNGUStmZUo5SDdXcHc3T3lQN2pWNG9TMWdZZUp3NStWaFY1?=
 =?utf-8?B?Y1VNeWE1eG1EZk5SNjhreEZWVDNkbjU3cWtwT0d3dVZqbWY1Y3Y1dWVQeGda?=
 =?utf-8?B?TFE0L2dWNER1bGlncjlSREpIYjlTS2xpWEtxY2k5cGwzWWlzMGF5RzZ4MTdi?=
 =?utf-8?B?MVRxYUxlbEswYjlYdmU0SzJxY0pKRTRTQkpiOW1URFJaTnRzdnBULzdEb2tr?=
 =?utf-8?B?a21udUk3TG1hTmRobUJCTktFZ0ZoMW9MdGcvSFk5am5UdGVZYmVtNE5TZ05Z?=
 =?utf-8?B?VVoyejdtam10cHB3ems4SUlBMWNTSW0vZ1Z1dWIzbnJoaCtFSWhjOEQvRGtY?=
 =?utf-8?B?YU1pOGxtelRUaEhoQnpCNmluaVVIeDJQeGJHWStsSUpnNStHTUt4dUVIU2wx?=
 =?utf-8?B?b2NaYndXTUlxMEk1cndjeENSNndHMkdRc09CbGZPMzZpUk14QmIzMmxXY09R?=
 =?utf-8?B?Y3c0YVdnS1dwZUozVFllZmJad3k4NVUyWitsdDRXaGZ1ZDJPTnRtaHVncXlp?=
 =?utf-8?B?YnhRTTZ1bUI5OGtKeDkvcG9RTDVZbm9weXhQMWs4KzMwamh2cDNzK3gwUnBJ?=
 =?utf-8?B?RjZmNjJBZ1JaTThVZGN5cndUTU5kc2daRm1ISGNROUhDQXFVaXZFNHJsUDVm?=
 =?utf-8?B?RUgxZlFjWjJXQnRDT29YMWEyclFwMUdrTUgwVlprbG5zNGlqbHVvd1pGQ0gx?=
 =?utf-8?B?SHNtV3prVnJYdEthdDBJWExuV2hsN1VtT0RVMnQrWENMY3F4V0xKVlZlRDNn?=
 =?utf-8?B?WTJZWHJ4RExSNll3QUJUeXhQeFN0c2VyS0VvRU5OUDk0dGpxOXoreDFDVmFN?=
 =?utf-8?B?ZzZ6OWZPeXI1b3AySEF1c3AxSTZ4NkI3WVFLNUw3b21JVVp0M28vS1BFbGpB?=
 =?utf-8?B?R241M0Uva3FjaHNDMCtiOWppTFVLYnIwN1J2MXUvNllYWGtHc1ZjdmwwWjBT?=
 =?utf-8?B?YVhZRGFZeTFUTVpqeEhrcTF6cE9jNlk3cGk0TXdadDlCejRaSFI3bWpzd2tX?=
 =?utf-8?Q?I6eA/o6SFwjSZkDCdQ17n4c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23be297-4f85-4e6b-553c-08d9efb44aa8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:19:47.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlrJTQucO3tMvmR2FQDFSy1aNpTbCCgzLxznqjI5CB7gfscGwWJUX4umOriAfUo7xDvPRIxq02OzsjL4jl21Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1827
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140075
X-Proofpoint-ORIG-GUID: PfkPfzvQBinZbGKktLSFpOlwuN1orqRV
X-Proofpoint-GUID: PfkPfzvQBinZbGKktLSFpOlwuN1orqRV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

Thanks for your feedback.

On 9/2/22 4:22 am, Tejun Heo wrote:
> On Sun, Feb 06, 2022 at 12:09:24PM +1100, Imran Khan wrote:
>> +/*
>> + * NR_KERNFS_LOCK_BITS determines size (NR_KERNFS_LOCKS) of hash
>> + * table of locks.
>> + * Having a small hash table would impact scalability, since
>> + * more and more kernfs_node objects will end up using same lock
>> + * and having a very large hash table would waste memory.
>> + *
>> + * At the moment size of hash table of locks is being set based on
>> + * the number of CPUs as follows:
>> + *
>> + * NR_CPU      NR_KERNFS_LOCK_BITS      NR_KERNFS_LOCKS
>> + *   1                  1                       2
>> + *  2-3                 2                       4
>> + *  4-7                 4                       16
>> + *  8-15                6                       64
>> + *  16-31               8                       256
>> + *  32 and more         10                      1024
>> + */
>> +#ifdef CONFIG_SMP
>> +#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))
>> +#else
>> +#define NR_KERNFS_LOCK_BITS     1
>> +#endif
>> +
>> +#define NR_KERNFS_LOCKS     (1 << NR_KERNFS_LOCK_BITS)
> 
> I have a couple questions:
> 
> * How did you come up with the above numbers? Are they based on some
>   experimentation? It'd be nice if the comment explains why the numbers are
>   like that.
> 

I did some testing using different number of CPUs with qemu and the
above numbers were collected from there. It may not be optimum but this
is what I could think of while doing those internal tests.

Do you think it may be better to make this configurable via Kconfig.

> * IIRC, we split these locks to per kernfs instance recently as a way to
>   mitigate lock contention occurring across kernfs instances. I don't think
>   it's beneficial to keep these hashed locks separate. It'd be both simpler
>   and less contended to double one shared hashtable than splitting the table
>   into two separate half sized ones. So, maybe switch to global hashtables
>   and increase the size?

I have removed the hash table from kernfs_root. Doubling the size was
not giving any improvements so I have kept the hash table size same as
before. This change is present in v6 of patch at [1]

Thanks
 -- Imran

[1]:
https://lore.kernel.org/lkml/20220214120322.2402628-1-imran.f.khan@oracle.com/


> 
> Thanks.
> 
