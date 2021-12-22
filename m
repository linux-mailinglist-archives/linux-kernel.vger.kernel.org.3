Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A047D43F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbhLVPbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:31:06 -0500
Received: from mail-am6eur05on2138.outbound.protection.outlook.com ([40.107.22.138]:7648
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233787AbhLVPbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:31:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHpRT0uN3uJBw/hnC5tPw8WF4H0n29OAafr/8C1KH8jG5zYcCDQtDo6s5JuS67xBiBEAW8VE0Fll+U1VKHfUR7XjS4Rc1ChNuFavr1ImnrQfGndyp4r3nmi74Thsr5er+ct1IBj+tT1mxr7r9n/sIm/AH1q2wLPHE4aSAipNzB/EgAc9FnCJ7Iha0s1etSH/5IEs7UaOwLin3gsrInO1p8t4dR+qwJgjz4VjxpPtjvdu9z/46V/nSGu8cq7M/b82Mypo8E5SdZHAP8xKtUir24lh5jc+uFBZ32y272iQkOskuWyoBkleO5/tkHEFoAiJHJJrS9kex9HzE6cSi+QE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ecq3/CPQudGWGL+OyfmSw8UkxfdUOsnHMmgq2qGXKw=;
 b=CLZopwZPgMvZJWJr0Wxuzf8QDo7ZLWJ2SZUXF7tYDFLdGR67uHQagpfZTWu1kd9rJG2n3B071lQ1qYjqDiCzLWtE8Zd2sujGe/c03p1JDUDjJZndw240c21KGyBvW5VLjL/JI4Fk4e2WIO96oVMtx3zdscT58U7PJ81IyW4MkamW1/cMGSChiVnuGajLXz4r0Euq91SxksrAVQQkgLwBnAM2Fsls47U49GwH9UFQL4an/xU74PJjliqxg+RmvJdKNfx/MmrvYHV93DwaBscvhEhjDH0XNcIvTNDz9NMKQTB9JojCabTifnHRpLBimBA4baAcfS0YKvlRd8OZXrZ7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ecq3/CPQudGWGL+OyfmSw8UkxfdUOsnHMmgq2qGXKw=;
 b=sQQzNANCD949DUPcTFKIeS9dILTcr2Mtc1wnwGJst5aoXrTwOBfy3UVGFiLVFJVskUrxAIt1dmUUsnL++0JAiUwA9bEJHBFc6xF9uKPdwypdApfMdtLEDnpmXOKW5WgeexoJPl/aNQjZK4zeLs3kRAdNhFdEzUbJMjNHNPpsgbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB6PR08MB2680.eurprd08.prod.outlook.com (2603:10a6:6:19::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Wed, 22 Dec
 2021 15:31:01 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 15:31:01 +0000
Subject: Re: [PATCH] ipc/sem: do not sleep with a spin lock held
To:     Manfred Spraul <manfred@colorfullife.com>, cgel.zte@gmail.com,
        akpm@linux-foundation.org
Cc:     shakeelb@google.com, rdunlap@infradead.org, dbueso@suse.de,
        unixbhaskar@gmail.com, chi.minghao@zte.com.cn, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
References: <20211222081026.484058-1-chi.minghao@zte.com.cn>
 <63840bf3-2199-3240-bdfa-abb55518b5f9@colorfullife.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <1181e64b-94c0-908a-b9e9-1a38f4610430@virtuozzo.com>
Date:   Wed, 22 Dec 2021 18:31:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <63840bf3-2199-3240-bdfa-abb55518b5f9@colorfullife.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::31) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00997b19-3d91-4e83-018e-08d9c5600f84
X-MS-TrafficTypeDiagnostic: DB6PR08MB2680:EE_
X-Microsoft-Antispam-PRVS: <DB6PR08MB26809A08A963094E481437B0AA7D9@DB6PR08MB2680.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mG/5BbzHg3d3N7M4ZAXmlCNRF4VlW7DsOy3zPXGJNVinfkyMk5ichAYxBB1Bf4pS9lXBLADAL0hApjDz/w/dNr+aEccBeHKxstVHHy5zwtoN6+IB8nzrNxQkWweB1MNP8VIDV/AWFpB1I62Qmg5z7qFhu6W8dZ9SB/3sAPKBLFtZzXtRKs/WgcuxsfXtKTeoLrcSksCBrMMjYAQfaMeSN1wZ67emrNOD+/oDlNhNyPHNIc9GzEnHxKnGl9cxX7M4xZql2N5E6ZQYHfkpRsdkSiF4DwhG8yeef84OvRTWBNjRYeeRPuWrHbP0ROJcNywdkZw1fAViQooBaobuiEX5lyupcmojcdRCjzNEpS7iMNcrlXLiqhf4Q+iGIa5D8LEuuh/e+/u8JVVULzArOkKKZbH1EpUC2hhqTp0WHVVY8otHBfYFtWCe74i/XfTIsJRofjGTdGzwgjCKgtRE4HkwzIdTbE5GLvZqty2HcN7l5YVXKqQsFFGmpxecSEKJSVVoXQiuZ1ySPT0ASbkxlsuVYQ5kWIbTx3f6FBFPLyrZ1kyOQP/Z2eC5Z/5ov16Yjvyu7OtiL0UK7K5nvYUtzDfnbzUr0sfBb4dwH9YtjbqHIquFpnMINhx03FVMFRAMc3vZ29cCyH473OBunG1J/GyJKuQ7wqvdAsi/ZkiSYB2CU/s4G5Kt4aUIbevLV1uddKsToFTyPwBBLa8oGYym8/wAzIKnOn4jLizIqzJHx2iZPuk3UjLxhxu+yO8mUevIP/xI8yFyJz9iy4NHVSh2Si6VHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(31686004)(38100700002)(508600001)(66946007)(2616005)(52116002)(4326008)(5660300002)(38350700002)(83380400001)(86362001)(8676002)(66476007)(6506007)(8936002)(36756003)(186003)(26005)(316002)(53546011)(31696002)(7416002)(6512007)(2906002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzlNWlBRK3RHTDVZU3REdTdURFZ0dEdseDNPNENLMkhhYXpLd2ExdFlHNVJD?=
 =?utf-8?B?bUU5VG5ycGdlci9xOXdraER4L3YwY0JGVU9wY295a3kwMjlQYzhlWEtDN0Nn?=
 =?utf-8?B?RXNiN2JpU0pyNXNTNm5ha0EyN2lJbWVBL0VXZHYzbGFCUU9zVXNJU3NxNlYz?=
 =?utf-8?B?dEFKS3A4SWpQcmVxaWJtM0lsejlxSW0wby9xNjBIUVowc2NZMnJmMjlUbTd2?=
 =?utf-8?B?blQ1VytzNkJ1NGlFaldQTFNtSk1QRnJpb0NXN0FNdGppd2YvcS9XVGk0YWRL?=
 =?utf-8?B?V0U4cnVOa3ZCNExiOThxanhWOUEyaktPMWp3TGQvTlRpOVM2SENSdTlhUUc0?=
 =?utf-8?B?MjhJOThyNWY2SFRKT1RwSEE0aHhka1dvZXk0cWxrTkN4Uis3NzNTakxheHV3?=
 =?utf-8?B?enpWZ0JmWUR0UDJpOUdPakFpdDdsY3gzb1UyV0Q0Nk1IUzJGRWw3UWhJajZa?=
 =?utf-8?B?bC95b0t6NDZEbWN2ZzNOZWNHTGtuL0kwZmFIVzNwQ1I1NzYzd2NoMFMrci9n?=
 =?utf-8?B?Q1dTb1ZSRnBOVndOQ3Myei9uRXJYSUxhS0NqekUzRXg3R3djOHdNeEJONG0w?=
 =?utf-8?B?S3Nsc2hmdDcxeHVDdGZMR0xHR3IwRVpmUlpUenlsWWpyMGZYdHdwNHpuZWEr?=
 =?utf-8?B?OXFtK0tWclp3UkZTNUMyQ3dKVFlqdlg2NXdkRnJ4RkNiZ01XNWpLZ3N4TFkx?=
 =?utf-8?B?RjFjTHJGWDlqNjFYVVpwZXJJOGVWQStWcTQvTmpSeWVUMVVMRmU0SitXVlh2?=
 =?utf-8?B?d2U5Uk9ickR5UFhvT3lhYVJtS3ZJVUQwVkJZOFJaM2tsV3E0NU9sZE9rbzVp?=
 =?utf-8?B?YjV4TVVWMVk0MGduWktnbHgwcUZOMFNlMC94bWVmSXM5cFFQaGIxY1RQNmhj?=
 =?utf-8?B?V0czTDVsMjEzQldwWE1QcGNPOW83RS9UYzY3NTVHM21uajVxUXpTTEFIZHlz?=
 =?utf-8?B?SFBFRDZLR3RoNVZkMzVIMWFKM3ZnU0tITzBQWmVidVR1Rlh3MWtURkV0cFZl?=
 =?utf-8?B?ayt3L2dwZzd2V21uWTQvL0lUY3IzditmSDNoYVpYMmVLSytXemlVTlNKdlAy?=
 =?utf-8?B?VXkyaWpFM29rV1U5QVpFZnhyaVJ1dzY1MFRYWndkL0NZazdzZjQ5V25TU3ZW?=
 =?utf-8?B?ZlN0KzY3aVRpWHIyeTZVK3NMZ29iZzVoVFpBby9pQ05qTjNOeUF4OTlBZEQy?=
 =?utf-8?B?VERRTE4xelgxRjVxZnQ5emlaWXhYU2dZeVJCampFYWxBV3BWYkkzWTN3bisy?=
 =?utf-8?B?SkhXYng1K2xQSHVmbWUycTJoNnh3RnAyaDB6bG81eDF3b3pJaUtUOWN6TkxY?=
 =?utf-8?B?Y2tKenl2RlF6clBiV1N3bjRsTUR1c1ZBYlVCRXFSdW1YeFFlVmNxend2Q01h?=
 =?utf-8?B?V1paRUZRbVgxRkkvTlUzaVpJWW8yTThRaUdzdGJwUFR1RzJENkRKTHpJWVBw?=
 =?utf-8?B?RzFKWDlZVTBTbTZ3SkM1b0RDb3dhUXM0Z3JoRi8vZTgxWmErNi9UYnVpV2h4?=
 =?utf-8?B?N0UzMGF4T1h4NkRiaXI0TmdWM1lBelJkQ1drMlJaTlNTWFQyUTJMKzI1THZa?=
 =?utf-8?B?UVdZWTZvdnFnVVR6RGROODRENjhyNFhjVVJnYmJDdHYyZmhiVlhtRDBqbkk5?=
 =?utf-8?B?cU50MTBiSUlrUWY3bFNtRXlkcGRqcmxqSGJsNXpxMkNiVk43eEhHTGtFRVpy?=
 =?utf-8?B?SXU2dkt0K0tXZVVYNGY4a1NxZGV4ams0NUYrUUNCRUFmcWY4cU1nRDNaNkpt?=
 =?utf-8?B?WGcyVWJVT2NiTHJ0eTF4a1BMNzZYa2xoYjVsamVETWo2TXJoQ3lCRFJaZDhZ?=
 =?utf-8?B?V1A3cjRqaGFqaE5vYWpZSnppWEk4dDRkUHYvVkViMnQ4LzZNMmNZZWQzQjBj?=
 =?utf-8?B?TUZaTUkyT2xLbFlobFc2eVladWRBZWFVUWNnWVFzZDMwMjVFNWRlUFNQQVBk?=
 =?utf-8?B?WlBTQzFwUWNBODdCemhjRW5rbzNqbXJFeTVSRVdOSDdRVXdxdWFhN1hJbG4w?=
 =?utf-8?B?Snh1TUJ0Uk1OYjlQZzkzeENhbzJLWkZNa2VZTmlVc2xTSCtmR2JNdEpNekFO?=
 =?utf-8?B?RVBOTEpab1gyVTIwdlZKcFNtakU0TExkM3piazFvS0lpdGxsMjgvZUcyczVX?=
 =?utf-8?B?emhmOTJ4cWZFeDdMaDkyNXRJQ1JxS0VCRXU1TCtqaTlRbDRVY2dvNy9SUFp1?=
 =?utf-8?Q?Od7Knv3SAOLd1X09cl12QFI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00997b19-3d91-4e83-018e-08d9c5600f84
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 15:31:01.8732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBEGR1Sy/j1UCo5cZVAGwQkjJEMLjZD1i8xI9MVy2wNmj+KUVfW4CsDQnuQWMS8J6JYuwxzP/xZSFOngQmQ3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2680
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 14:45, Manfred Spraul wrote:
> Hi Minghao,
> 
> On 12/22/21 09:10, cgel.zte@gmail.com wrote:
>> From: Minghao Chi <chi.minghao@zte.com.cn>
>>
>> We can't call kvfree() with a spin lock held, so defer it.

I'm sorry, but I do not understand why exactly we cannot use kvfree?
Could you explain it in more details?

>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Could you add
> 
> Fixes: fc37a3b8b438 ("[PATCH] ipc sem: use kvmalloc for sem_undo allocation")
> 
> Cc: stable@vger.kernel.org
> 
> I will review/test the change in the next few days.
> 
> Especially, I would like to check if there are further instances where the same mistake was made.
> 
>> /**
>> * kvfree() - Free memory.
>> * @addr: Pointer to allocated memory.
>> *
>> * kvfree frees memory allocated by any of vmalloc(), kmalloc() or kvmalloc().
>> * It is slightly more efficient to use kfree() or vfree() if you are certain
>> * that you know which one to use.
>> *
>> * Context: Either preemptible task context or not-NMI interrupt.
>> */
>>
> As an independent change: Should we add a
> 
> 
>       might_sleep_if(!in_interrupt());
> 
> into kvfree(), to trigger bugs more easily?

I think it is good idea in general, 
however please do not use "in_interrupt()", it is obsoleted 
and in fact means "We're in NMI,IRQ,SoftIRQ context or have BH disabled"

Please use something like in_task()

Thank you,	Vasily Averin
