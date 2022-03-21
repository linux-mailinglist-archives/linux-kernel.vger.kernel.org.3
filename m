Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03934E2A82
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbiCUOQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351814AbiCUOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:11:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3C9DFDC1;
        Mon, 21 Mar 2022 07:10:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LCwA0S009877;
        Mon, 21 Mar 2022 14:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jJvjaD9nDPINy+yDER4EzUWY4D2RflHCie4NZqkBL5M=;
 b=yzinJ2+Z10kVBOUVRRRflvhCizRqfLTxhzITyZk68qsGj8SJ6WCJm1ORyZSMTLLZU857
 FxXycx6ws5J1DfPnShaBppZI9REk/AIzJPbqfSjKwemo/+2jInNtNrftOdhr/u7cUrFt
 glL5A5rl8LJ6Y80zXyOWqkbZjgHeQzUo5UxYs85Y71ewT2tWQuoJGb1qhSoXrvLql9lQ
 wQW17ppoTMDC6zL1vhB+Kbbne9WKYzHaDRxxsS8xerZc/wzNq1l3uBoLBTVrscpJMq42
 /9ug7bMr/4K872OGlnHmBAo6Uew8Rtf3lA+7Shlve8ZbJdnP2bvxbVUIT9LpAx3fNf2b LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72abb8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 14:09:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22LE85vv038153;
        Mon, 21 Mar 2022 14:09:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3030.oracle.com with ESMTP id 3ew49r3k8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 14:09:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fi3vHHOQmg/8+J8BUfKOs5SO+Obgu09/6kMplfMFQic6+XgyFsaVGW78q4ewpvx/0W0DBnz0AGSW+OFq7RxRXhsPkUy7zcf2HIXvDNLi4GWf5oDnjLrB/R3O+7h0nir3tXy2JyUouoOxBN2ZnvUmqoyVq1csuvTHUPXcybvXb0gNlM2w8Dxvtrnlw0Z+0S+QMSnXG9zGNAh6oj0xnqTAycluLL3SJHMWnAZqULDANwMfkRLn3mb9dJ5gW5Eg/0h/OCVwwyQUIhmWMldOyd72SQsV2k1Yk5LPrxDTjWoSB4DLFqLAffAiEg5G8ASgn/xqm5WA14od13Wh4hceQ+o/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJvjaD9nDPINy+yDER4EzUWY4D2RflHCie4NZqkBL5M=;
 b=kRDGgPJ7u2eUqLjUlKziDP/QrFhs2FHmJMO3ZABM4eOMcOc26alBWIkYcidx0dvtS1LMiPvikLqHtPV/U+EgLMF1YQvuAPR1yJGoYgXgueVA46hXE4wNf2FYfOkv01eqvyWmpmaUskjB7r2FzNIbRS2AMR+XXC7TV+RA4uCF9/nnEQ87n5wF+sa30qr4QDrcVtp7qXgTRvj07VMGQpbImTRa6zBdeaWkPuY/ChyOkksTvNZh0YMW/RzIJ2NzL5IuC19huqy1x/n6Uk1/7AgG0TcelyG5p8Tp3pPv1GsP/4B5kDhEcGfiQzVbetWG3KcebtIf30nI6KjG/kBZPVQpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJvjaD9nDPINy+yDER4EzUWY4D2RflHCie4NZqkBL5M=;
 b=QKVz2fJRGHsmQhQCAJm+/ClYQRFhl7TLanghabE8JGvznKUIPqLYmv1u7V++pUXNsR6/j5n3SDddF1Ne0r3s3VqoMN9WZBQASW1NyFQSJu37cwnI6uXajsm99bUMM4N+Z3yjxiAYmg2+lHmOnBt6kk0vBDQ+LfYZYHn4Q049Yy4=
Received: from SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 14:09:24 +0000
Received: from SJ0PR10MB5742.namprd10.prod.outlook.com
 ([fe80::2400:c9fb:a176:3502]) by SJ0PR10MB5742.namprd10.prod.outlook.com
 ([fe80::2400:c9fb:a176:3502%2]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 14:09:23 +0000
Message-ID: <d938a7e8-6b4f-f24d-41d3-8058ca2b2ac8@oracle.com>
Date:   Mon, 21 Mar 2022 09:09:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v21 3/5] arm64: kdump: reimplement crashkernel=X
Content-Language: en-US
To:     John Donnelly <John.p.donnelly@oracle.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
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
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-4-thunder.leizhen@huawei.com>
 <cc0186d9-29a3-8eff-e38a-95fd4dd9c46f@oracle.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <cc0186d9-29a3-8eff-e38a-95fd4dd9c46f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:806:125::31) To SJ0PR10MB5742.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acde4f42-0a05-482f-c5ce-08da0b4466ae
X-MS-TrafficTypeDiagnostic: SA2PR10MB4714:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4714316445B7D14C213E503087169@SA2PR10MB4714.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUg/c+pnbFntsIAIdpaRfkDVRaSEmJno+d1iGmyXkROQUhOs8O5or1T7f2vHF+MOv9iZfCjc3FUvBelR0BEW4Sz2t0a3Y3tt2wUs8hXo2K14wysKC8FmlRjffrwLefvJWoRgn8FLJ/Wt6IJ7OGcpV5JOQLK/xTtPR5PSbs0dPrJervG9zi93EnoRlr3qJE+qgR3nffIAeLo3zmtFej4B2Bes162ddEk+nMbW1fe4O5TrryTn0imSR0now4+RUB2HGWoQgwOV5jNPUcJSS+lpiVzcMF4Puh9Sgd/L3654E9NNsiMjcWBTyQeuZLRbjwpZRpOrNRi6tlZy5Do44M3/5+TSvmclKrPeOERJWPXuxw3aDHVUmgoiVhf0boNe6t4wxvvzFLMOHkmngqCyIDZoXIk89ArliIMpfI9M//UgvI83Cc1Sr5ICLfgG64bqUPJfUNlez23lXpVxj7gjS9hb1kiPYxTJgbR3KQob8gNJ4q6P2jxuYm9+3SqzUFqvxSGqo0pL56jiMEPzI3bxnOUfqPk52gt3fAqmCMSmTmQCTAFV+uCBXUvSOfSwlRh5TejJhrzHIjQ/QRBx5Y0mhm+TAMBWWukiRq92TgrXd6WveGT6F2leU6VFaGyVu8L/FB1W105ytHeD6oFJ0a3uWsfcfdt4Rqf4DqCGAk/RoO8p91uOWglQnBBRPeKfqaQSov28BBjKu/uytJyg5yduZgtQrg8mG0JuhoHWkHocpsVY842W0gyz/YpF9sMmbxSjixl33TSgiG/qIzIy9prTsEPi4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5742.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(31686004)(316002)(38100700002)(6512007)(44832011)(110136005)(6666004)(8936002)(4326008)(8676002)(6506007)(83380400001)(86362001)(31696002)(36756003)(26005)(921005)(66556008)(66946007)(186003)(53546011)(5660300002)(7416002)(508600001)(2906002)(6486002)(2616005)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRydVFLNndoaUlaS2pnS1hjSG5PV3d5aUliYU9HZzZhc216NlFUcndXcFNa?=
 =?utf-8?B?YjBVNm1vYkpwQzhCRjJqTTY1WWtHSUFsMmZoemdQNkhPcHh1cnJYRVpJTEs3?=
 =?utf-8?B?dnZYMWpoWlVSVDlnWkVZYzM3bnpLT0loc3k2MVowWi9JQ2ZZNWVlOXRWUW1K?=
 =?utf-8?B?Y0hhVlZwODFDS0NldlVDNVh6V3JtRmhLS1NGVXVmNzUyeXF1UlBuQzV2NSti?=
 =?utf-8?B?bWozNGlnMTU2OVFyWTBUWlFZZ0txRGxmU3RRNWtyVlBjUDNhZEJWUTVaYjlF?=
 =?utf-8?B?ZHk3NXpReDJRdXlPN2tDdG9rYlFTNDEzaFBSUTFVOUpRNGthSzdRemEyTFVq?=
 =?utf-8?B?aVBLcEp6Smt5aWRQNVJmNkpIVkhLOE5XRFdhZXBlT2gxanhiQU5pRDFOYjcz?=
 =?utf-8?B?aGRFMCtMTkNJemNvTXoxdGY4Zi9jZWtmazUvSjJkK3VxL2xVVW8xL3VBbGhR?=
 =?utf-8?B?MmJFc0pBU1IrSTd3WGIwR2pSbHNWa3BDaU5TUm9TQ0IxMy9JZ1puY21PZi9N?=
 =?utf-8?B?R3g4UUlVZ0IvUEFYbHY1R1pWaHUwYVZZTE9ncE1PZ2dvNThaQnNzL3JHRlh6?=
 =?utf-8?B?akVqMEdTVlMwL2xpOFhPcHo3V1BBby9RN0NUaXMxVmxvYTdCUUIxaWlyUHUw?=
 =?utf-8?B?bmJmKzR2N3BTaW9kalVSMWRuK1pMU2x3N2U4enVmeXFLL05FVDcxc2NpRFJu?=
 =?utf-8?B?aDdlTVU1KzVDdkovYjNTRXp3bGZacXZvQjF6SFhmUkRCd0dDdTU3dUFRMFlx?=
 =?utf-8?B?TGhXcTBpem90dzRBeDA2dUZYakgzVWZ3YURKbThreDE5WEZEaWY2VER0dGVx?=
 =?utf-8?B?VHdwalJTYldYOU5pazAyK0dFaHZ4RVZmd3REQlZzeXc2YUxPajhJalBLYnFZ?=
 =?utf-8?B?Vmx4REhQRzFnZWplU3hZZ0xWMTJ6MkorOStIVmExcnBOVzBuckNlajYvRUdw?=
 =?utf-8?B?Q1NnYUExc2s3bCs2L0NUMVpRL1UzdDJYQUtrS0V2akFlb0pBK29zTUhCemtI?=
 =?utf-8?B?WGVJNXdKQlNLYTZEUWorQ3ZmVzhtYjFIMWVnc3RTZkR3aUtPYStIb3g5TDlG?=
 =?utf-8?B?dE9haGZaSTZnaEpQNkJpR3l0QzNTcHhCb2IwQUdDV015WisyWWhtcWVmY2F4?=
 =?utf-8?B?YW9abHYrdFlmckEwd2tHc0V3TlVNOFJ0M2NBamxzVUhhOWQ4Z3NOdUZwbEVT?=
 =?utf-8?B?c0RXVVA3YXU3emV5Y0VMVi9hQUcxYkhuMUdkSEoxcm5qZXBIS21ZN0VLWk50?=
 =?utf-8?B?eVowNXVON2E3UmhCdk01bGY0ZncvZFR1cElINFRKLzc0RURaWHB6WUZNZWxV?=
 =?utf-8?B?b3NvRU5wcVQzRkZ4VzFQL0tXMzhhRFhNc013TXJGUllBeTJ6aU1wSGRHaVoy?=
 =?utf-8?B?bkZORi9rTXRIak44NVdTZGh0aUdtNHhyT2RtS2ZBWlB1aUhTVzF6Z25SZ3NF?=
 =?utf-8?B?VHJ2eERZeTdXR044NFhhR0VzNDJiOVlZczhlZ1loSFAzOXlITGVIWVJaRFda?=
 =?utf-8?B?RkhHUndsMlJuRWNVTTJYeC9kT0VJRDU0dldodDRBUzcwMVJ6c3JEdHNLYURJ?=
 =?utf-8?B?N0Q4QmhlcnprTUNSbUZBZUFjWDhnQVVnTGNQY1p1NUc0aGhvZlFBMkptcVIr?=
 =?utf-8?B?UUg1N2lYNVNMaTllTzkvbmFJb1RUM2VRWURXYUdVcG1UNGlGUGtOMFBsWm9a?=
 =?utf-8?B?ZDJ3TzgzcUptbEhlTXJxZWlGMFU1KzRGV1FJZkFtMG1GTi9tbEVrUzBIczdJ?=
 =?utf-8?B?TkduaHl1Vmh6Sk9tVVJOUXZkam1KVXhMbmxwdnB2Y1FkV2ZuUmpvejZ1SG1h?=
 =?utf-8?B?ZDNPc2NHQ0lZYXE4SnNFSnBJbTdoVVNSNDUyUmY2MEpiVkZxWjNRaWNjckQ5?=
 =?utf-8?B?K3ptWXQrODI4eTlnalNXdmVyemVyMU1xQXdpdFBCSWs1Y3VQTjJKOFoyZFBZ?=
 =?utf-8?B?QkNmbUp1K2NzN0tCYjd1Ri93MVpNZWNteEVLSDhJL3hUa1NGMGNNR2hhekk2?=
 =?utf-8?B?UnkralFKWTRBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acde4f42-0a05-482f-c5ce-08da0b4466ae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5742.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 14:09:23.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzWL1sSv5bw9oP+u6Tn5kKBT03trK8lspgBr3sLXLXLTfVujtgcwmaUyOkhbGK7MPBcP/oti6AhYO23yVLww9D2xiLR86rlvVEWDl/UB2dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210091
X-Proofpoint-GUID: IRD0u_w1U8uV-9o6ukynIRVo8EFQqtM2
X-Proofpoint-ORIG-GUID: IRD0u_w1U8uV-9o6ukynIRVo8EFQqtM2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 8:29AM, John Donnelly wrote:
> On 2/26/22 9:07 PM, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>> will fail when there is no enough low memory.
> 
>                          " Not enough "
>> 2. If reserving crashkernel above 4G, in this case, crash dump
>> kernel will boot failure because there is no low memory available
>> for allocation.
> 
>   We can't have a "boot failure". If the requested reservation
>   can not be met,  the kdump  configuration is not setup.

I think you misread this. Without these patches, if only high memory is 
reserved for the crash kernel, then the crash kernel will fail to boot.

>>
>> To solve these issues, change the behavior of crashkernel=X and
>> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
>> in DMA zone, and fall back to high allocation if it fails.
>> We can also use "crashkernel=X,high" to select a region above DMA zone,
>> which also tries to allocate at least 256M in DMA zone automatically.
>> "crashkernel=Y,low" can be used to allocate specified size low memory.
> 
> Is there going to be documentation on what values certain Arm platforms 
> are going to use this on ?
> 
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
