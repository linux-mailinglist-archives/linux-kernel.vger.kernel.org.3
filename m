Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3361493107
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350094AbiARWwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:52:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37270 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240919AbiARWwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:52:37 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IKEkuO007941;
        Tue, 18 Jan 2022 22:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=K7tPZwjTf7dA1Hp8GJYrrVI5AfcCPpl1oqy1ETjUzFM=;
 b=jZgvgVM9ALLfX+nrd2ClAVgGigzMPXP5XsUWSx3E3/bqCEf+TJcYXZCIjGSiUXRpGSvd
 zSYR2YaE8PW7zDASui6HBb59VSyGqI3qSMeNvx0j7Mla5slGnBVy0q8n9/zYKVn/Gmsy
 7zpaa2zhJUnA1b1jnmxkNt3mVlUd4nCPa5XjeZKQkDTVdtKjfa4v5Ko/Tzrsjb0RZ3Fa
 /U8da+EiIgQ3SgQRPXif5Oli5lc7SIIKoSy5uMOttoGIytXi9qnVE48FlEGxxFH8L+vn
 XDhbt5HxENiW9M+U3KLQ8/p7ajC18BSyArCmGifcP91qD6te9JEN1eRv/Tl8u44e6ik0 8g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4vkexg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 22:52:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IMoPr1131171;
        Tue, 18 Jan 2022 22:52:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3dkp34yd44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 22:52:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX0U1HB/SSR3jK4afaaoynIaNpke6MEA5fA/KcgO50EV/cL/QyzLUIq7ChiQ7YeehbVyzLOFwA8b10NIgiaRxNXS4zp4sIOeKxRYchc6UZSvU9oW7ocoONHEnrFwI9MECTXb2593lmSc3giXwfv4l0+5nmsBEvKhhg78wgVRbxbIQwehDXLT7MsSClm/d6F7+MjwTBtMhJq4ida49G8GK61ydvM4PW4PyeMMdj0WO+ceO6kLfh1a8N9kzFm9SXtXTZFosU8lqwU/0Hw6ajGMJutjjx5RlSA148Ldk9JreE1MtTHzGEuyIUzxgA3pJy+BLXL8MwfPWo5dRZb1IMvjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7tPZwjTf7dA1Hp8GJYrrVI5AfcCPpl1oqy1ETjUzFM=;
 b=csaX0PrPZUF0TAGULG3FVIpZi8i/SPsXTdXYVo5jRr6XQuiVHFpNQCQpv12ZTKWxL3AZInBtAMP56Had6QDW2dwSnAbtxSh3aFkPCxD6A6EwYG6Bo4AR6/oCkl7kQF4LyxGr7aPmTq8EG1UP2liop0lKbNKCNvmNF2xdFEEWhbqBqMp0JZCtwz9/bE5nilhaDhx9gNZYnvvOXdOY6kUR2ZRKKhYo1YHwkgq44U9YylPzyAegkST2uTd73bACmU9cNL+YVcwVPowwT3o4XWL8rTV3KPrePn0Vs/wKOld03sU4la2kzAlzFnc4QSOC77v5BH+R2OHVb4u+OOe6Z5IgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7tPZwjTf7dA1Hp8GJYrrVI5AfcCPpl1oqy1ETjUzFM=;
 b=frLNBbytyHbJ+CWkDiBDS6qkK04t5Xl+7a8wbqRKBZiGxkh6X2JAHmwBx0FzoSIYE4q3jzP+m1I9+Jssk6yKRlk1GuQVr7UYMQx+Ul8VGQahobxLvljlI6iMPBaV6SmobI5jd8lVH8Lze2EGd5TTxDFzMcFWY19DMO8nye2yJuM=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by MWHPR1001MB2398.namprd10.prod.outlook.com (2603:10b6:301:2f::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Tue, 18 Jan
 2022 22:52:16 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 22:52:16 +0000
Message-ID: <20b93ac5-dd98-172e-505f-094aa6b0df92@oracle.com>
Date:   Tue, 18 Jan 2022 15:52:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org,
        willy@infradead.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com, rppt@kernel.org,
        surenb@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <e0196efb-9c55-c0f8-c663-b4af44b8ffa4@intel.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <e0196efb-9c55-c0f8-c663-b4af44b8ffa4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0063.prod.exchangelabs.com (2603:10b6:800::31) To
 BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77b0336b-8bb9-45e2-e0e5-08d9dad52ce0
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2398504E91AE36A04207730B86589@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8SWQDH4pZ25rbiMDKJQCi0YXlsnwSX3ffdOm+iDjlKhX6C748Ms0VNpJD8zNh4ZuAnBj4OhUu1Va2okn8cjPTVb4CQrAZ3WePs2XAJ54aSXaYSWhSZT3rIBnXn2myGulEvBFBPfDntivgWtkHHt9yyfTGE7H8egcrRLxs8+o5qCTmQo1eus/6jIKa7O6NQnKPjBFxtNCDrYiptpM4ah7OZfXF1vPOFZcDbBjPdFonzHoF5mRy2tXpEvWI/NE6t5JJ0rGu+181st1eheWxiFuyggpWrvms31x2D0gRGra68HFoeme1gL79Bh/QsqTGh5Qcharo256W073v+W3HXUYFlzCNLprjMLC0TPHAZOJt/ucp+xrrJnaTiPpsLctex/riS93scWlhjnbnsEnURvSceoc+Mj5gCkavlEq0uOGlX4qhcIR//sv6U6KZHBplKZFvu8VJDl/mPtEsSo2Hs85vLBEtdz9ondbHFVoUy60vQMTHXmT9bhYK9dO/5hPfsTkCiecgzZ+7XiIVmjUc4AJ9awNRMkO9jhn7L6N1UYa+8Hk0cqJk3Ubp6Mrs9oh5W1a55e6J+P144xGA0zEw2mjlUOTDDU0YnmwvxAhwZonZ2AUD4rTN8ugCaxy4Dhm5GHa13bEdBvqurxRFVlsz4jdLSQn/gsX5UI14LP3jIO3ixeqlsTIfAeWCI4oxfwT1DLHamjZfXD6o9ZF38Tm+VrGV8tL/TuJ66u40doKMNwRwMdYFfU7az/7gRcw09NFS79
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(8676002)(38100700002)(8936002)(186003)(53546011)(6506007)(36756003)(508600001)(86362001)(6666004)(2616005)(66556008)(7416002)(66946007)(66476007)(6486002)(5660300002)(316002)(44832011)(921005)(6512007)(31686004)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3JZUGV4YjhraDRiYUlqdWQzODNwSmV0cVV0d0NBQW02MGZhWjRTTHg5Wmpq?=
 =?utf-8?B?TVZjRWUwSDFITzRsMVc4RGNsQzViTENUU2h3LzczTVRqQ3NKamFRNVdZbUhh?=
 =?utf-8?B?cVgxYnZMSE4zRUpMVjhUUjgrTVZrbElsT3BaK1FaMnptOHJ4bkN3eWU0SklG?=
 =?utf-8?B?bWxNWnZWY0VTTW1EOWphRXpPdnMxSC9KZlM4VHo5MENRQWhaZDd0M3E0bkVl?=
 =?utf-8?B?UDQrS3hNbGcrbU9xbklNOVRJTVRHZ200NXdQUlluVnVra01LSmtTYVNBc1o0?=
 =?utf-8?B?WTNjWlBvbVRkV01nMTJiU3laVlhYU2M1LzRSajY2Vm56TE9SM0FXZEk3R04x?=
 =?utf-8?B?NHlrOEwraDhhajFnWEx1bHBVdVk0aEFUWitCQVdOd2piLytDRjNhSkpTVG9k?=
 =?utf-8?B?VHdlZEZzTTJUM1dxa1FWNHF1cjhDZGdOOVhCbUZ1UDRjd2gwbkQ5ejdBbm0z?=
 =?utf-8?B?YW1EbTQvMk9hMU42emc2ZDRpM240SmszNU8vZU1uWGpsRFpXSmVwSmxtbXMz?=
 =?utf-8?B?UTJyQnVXSWtXR3BmeEpIVGY2bytFVFlZTFlSYmlpWlVSRDhwQ0xXaHRTMWpH?=
 =?utf-8?B?WXZRYUl1SVpVbzVJV1BTSjdpOFhsU0hMRm8wNUJtdVFYdWd0Y21iY0VTRyt0?=
 =?utf-8?B?ZmhpSTJtQWIvUGw5b0JKN0FxeDl1VExRbDhMWmNoVmZ5OEkzRXhIVjVxaWo0?=
 =?utf-8?B?UG4yOXhwY2VYMm9UVEs0WU1jY0JDNTBuejZvWFVPc2lKNFg0Y3lOSGIrYXRW?=
 =?utf-8?B?c2pNeXpoSVJUOG92RUEvVFE2ejlWTmh5d2Vhc3ZsOHVLQXZVQk44TzFHNTdM?=
 =?utf-8?B?eTBKT21oc2FsSzEvV1FFQTBNdmYra095OWt4UWt2SUkwZ25JbVhXS3lUZmxn?=
 =?utf-8?B?R0tSVlFXSis4Vm1ibVJ1dHIzZGd4dXc3d1Z3NUNBUkFzSzMzcTNwb095aHdq?=
 =?utf-8?B?Q1EzTDNncVpHMTFmc1BPZjVxdnpKMWdTWnp1a01oem5JWUNEZHdaRDF4L21n?=
 =?utf-8?B?dFIxcnVaTGRDVUprd3VqQVVLY0ZwTndFL0xrT3hwbEJIamZmdU1zY2tEemVI?=
 =?utf-8?B?Z0g5bW8xM2lLSlV4SWttNnU2SC9oT2w1M2lnVzFxUklJZjk0S0R3UVBsZzND?=
 =?utf-8?B?Q20vNS9Sb3hMRkdneUpWVGtFWURvdytkZUpYWmdoUUY2TC9sYW90SzVpWERq?=
 =?utf-8?B?OXZxd0VHS2N1S3lYdU8yNEY1cFZZdER1MS9nb2MzUHpJdlR3ekNQbU8zNndS?=
 =?utf-8?B?WFpXTEdzLzk0aHZaekxobi9ycE9OZitwWnJVdEdQSUZ1TXNnNFB0Ny9rdzQ4?=
 =?utf-8?B?NVRVQ2lWNkR6WStCZmtwb0lITzFJeW5yaExRZFB1aktxUzdvbmp6YmVodUxJ?=
 =?utf-8?B?V09NK0pCOFcwVzJtcS9HVVZnWXNOTU8rSTIrRUhZeWZWVlRnZVh5QjBZNGh5?=
 =?utf-8?B?aTBDZW1lSkovQnZoSnU1Tnk1WkJ5QXYwYlZDTkhic1RQaWY1R1BRZWN5b3dp?=
 =?utf-8?B?OW1GTjIwQVJRNmVyLzlhWUFwcHpmQldTNzkzSEx4NUxGaysyaGZ6aVRZWEVQ?=
 =?utf-8?B?RWpLN0NwUlhDUG9hZ1BMM2ZjQlQvcFR3N2lINFhOYzJFRjcxcTAvL2Q3ak05?=
 =?utf-8?B?Y1M0YTFnekM0KzVGZ1pUbE50YWFDM0NURzYxcnhzamJyYmM5cmNBT1RwV3V4?=
 =?utf-8?B?dlpHS2NkMmZTNnlQK2FkWDZWdUtvT3NaWHlNQ1Q5WFpUVS91U2dmWlZ2MXc3?=
 =?utf-8?B?ZDMyK1ZTQndWQW9McERlaDBuTy83dlF6dEl5cXZMN3ZFRmhFZ1NCemp3RHFn?=
 =?utf-8?B?TkFnc0E4QXBDZVJCZTZtQ3MvaFJqSHloRVNLWGlJU2JFMGpTRmJKZkl6c05l?=
 =?utf-8?B?NFBiZ2JMMkFISC90RCtIK3dJa3I0R0RvT0N6YmNqamZEV1hnREc2cmRuSzQy?=
 =?utf-8?B?eUZNVjFNdHVxQ2FXeEk3Y0hnZkN4bUh1TGRHc0draWVPTU0wbGdCSzBwbUtH?=
 =?utf-8?B?VTN6WWQzK2JERGFVcU5FbUwxdDl5S0pvUkpnblVnVzAxSTJ5c2MvRWMwWHRj?=
 =?utf-8?B?NWR4RXcvZWdNOWhuZ3Q2TnMxTFRkdzFTdHdrY1FjR1pVd0JIYUk1azlTbGdC?=
 =?utf-8?B?YVl5VGF3d0JTWERaN09QSnpVRVNCeDRGakJmbUxQTkdoMWNUN0hpZzhvNHdn?=
 =?utf-8?B?TVZ2WUhPZ0RJOG56Q1k2TDB3eUJMdldKeHRoN2xhQTBmV1JyTHNQUmdFTWEy?=
 =?utf-8?B?cWMwSXVnTnNYY052V1FaaGhoZ2pRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b0336b-8bb9-45e2-e0e5-08d9dad52ce0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 22:52:16.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifVH2PbYnEvjLwC+vzvzoiTUAKlpNc0DA1Ttx1GrNBt++qMvKK23QgadLZ20BKMxnByCIcy+CaDgRvGnmscd4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180128
X-Proofpoint-GUID: XcLtW0aQpFp6ZsUhzdyqh_VnXi7iDFky
X-Proofpoint-ORIG-GUID: XcLtW0aQpFp6ZsUhzdyqh_VnXi7iDFky
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 15:06, Dave Hansen wrote:
> On 1/18/22 1:19 PM, Khalid Aziz wrote:
>> This is a proposal to implement a mechanism in kernel to allow
>> userspace processes to opt into sharing PTEs. The proposal is to add
>> a new system call - mshare(), which can be used by a process to
>> create a region (we will call it mshare'd region) which can be used
>> by other processes to map same pages using shared PTEs. Other
>> process(es), assuming they have the right permissions, can then make
>> the mashare() system call to map the shared pages into their address
>> space using the shared PTEs.
> 
> One thing that went over my head here was that this allowing sharing of
> relatively arbitrary *EXISTING* regions.  The mshared'd region might be
> anonymous or an plain mmap()'d file.  It can even be a filesystem or
> device DAX mmap().
> 
> In other words, donors can (ideally) share anything.  Consumers have
> must use msharefs to access the donated areas.
> 
> Right?
> 
> ( btw... thanks to willy for the correction on IRC.)
> 

Hi Dave,

Consumers use msharefs only to get information on address and size of shared region. Access to the donated are does not 
go through msharefs. So the consumer opens the file in msharefs to read starting address and size:

         fd = open("testregion", O_RDONLY);

         if ((count = read(fd, &mshare_info, sizeof(mshare_info)) > 0))
                 printf("INFO: %ld bytes shared at addr %lx \n",
                                 mshare_info[1], mshare_info[0]);
         else
                 perror("read failed");

         close(fd);

It then uses that information to map in the donated region:

         addr = (char *)mshare_info[0];
         err = syscall(MSHARE_SYSCALL, "testregion", (void *)mshare_info[0],
                         mshare_info[1], O_RDWR, 600);

Makes sense?

Thanks,
Khalid
