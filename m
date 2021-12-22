Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E719C47CD9F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbhLVHka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:40:30 -0500
Received: from mail-eopbgr70094.outbound.protection.outlook.com ([40.107.7.94]:58945
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231422AbhLVHk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:40:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkIZbzNSgbIfhgSFe/hXtHzCNnQcOfY5U62MiqBbdlbA0e38v2PCx5k7U42D4hbJNLSoYJklhPxE8UATw3SRjsTDdaL4Gvo+vpwZ836bOjJ17WEzl47LUPeXhmmsvFdCEvo3fV9iU7nWvTwQjjCBIOZFSJJ9gVRzX+pOYH95HT3MSdQsmA0R3JS4ZxTJYjL8VQqYjfwQbS/ceIUU0uAA1ypV69KDApeGxtapMvggNP7quN3hHd13lC5SrG4rG1nmUFlsGSDAcvdP2gEvsHfBYu90XX0iEGYGi0+X0+pB1vJ8ZospjRJe03AAyQQ99gRMArQ8BvHUYL0pip5IJmeiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td78KFs3F/3kgv1u93vA/OH5vjLZD9IHfeSE8HkJZO8=;
 b=n12h6EGFZPGSXb6cbSfa+pFIjn6tQ8HCE+5s2dGXoef5lMK21EP/1Pg27lPypRwGsfMmZDVi4A5TkSPUIppi02jGB/wELDZlq4i20/p/fmQYWqr1+wDRYRfI2/8oHQm0f7Bn5oXXpz9dXmopHXnWvHRcy6/fxsCh3D6MMksD/qlOehwvpXVsiYHF/ORzNxcGmZ4T4nfp08oNJzrsBTxt7u22vMbb2uQ+ota0Jl6vBB2fiC6pY+Sbd/oDCF7bQ2JBQxSQ1DBTXImy//E7XBtJdlswvctTmXYmOMiOWt7NjzpCa4UebNXevojB7w5GMdSOCHqFiRbPDVsrcJHu4B/hzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td78KFs3F/3kgv1u93vA/OH5vjLZD9IHfeSE8HkJZO8=;
 b=YJtsfJ92Jde/BVGCjG2dZF0YeRt7BRpIGQkIvrknyllx15zBlu4MgkMc2Yo9rtYsFLZwo5HmIiV9sL23VTeQZA02nO1HIVQ3bdPSGxI1l4tTswXonzV2Qb8qxPpfmckE/R/mh1aP7CDBh/rISTNNfmQsXLp7hMJVer/SS9Zi2SI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB6PR0801MB1750.eurprd08.prod.outlook.com (2603:10a6:4:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 07:40:25 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 07:40:25 +0000
Subject: Re: [PATCH] ksmbd: use F_SETLK to force vfs_file_lock() to return
 asynchronously
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, kernel@openvz.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e2aef4e7-a9b9-e44e-94a2-29ed6bc20091@virtuozzo.com>
 <CAKYAXd8pCfUBPRXT-44N_g2GD_BKtjboiepgTGz5DQ93YEiz-A@mail.gmail.com>
 <bf92bd1f-d03b-1fb6-ff62-53cca4b441e8@virtuozzo.com>
 <CAKYAXd_z9i6VtMsHmR_FQDwBzGHcjHLv=zicAsddjur=_A071g@mail.gmail.com>
 <f210483a-69f7-1983-65cf-f3f5bd4112ac@virtuozzo.com>
 <CAKYAXd97orfDc7VA+fae7tLjTufMksQTepYKazY=gX7UkG0+rw@mail.gmail.com>
 <c6fcbdb7-f232-f888-674b-7a45d98ad92a@virtuozzo.com>
Message-ID: <b9e08f35-66b5-b627-fe7e-f1907745be8a@virtuozzo.com>
Date:   Wed, 22 Dec 2021 10:40:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <c6fcbdb7-f232-f888-674b-7a45d98ad92a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::46) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d31232a0-40aa-4d69-07f4-08d9c51e514f
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1750:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1750EA12A2133A866319FE2CAA7D9@DB6PR0801MB1750.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Z/97ETkvaaPjkZLJ2avgTDcFlF4KoVumKM9/bH7DpPJzqEQrbAZMi560TvA/Oca0KU0u771UtcBXCCErnQe9t5yCT6DDhAshOitJfoV8zDO9v3TyrC+RvolOMNCfPUoBVwxUgv9waRa7BPuR+a/iD9BoWp1c8goZTwQxFdwg1ZLGs504zb/45xJjAvXc313md45vnvA36fAI+WQ//V5eHPmNvc2NmXw+lzOJxwHpMsaFjzsFTCVpKUlosM3uJ0rJdlGWnypatrag3rx4aWfNT5YiH9hk5C9srGGJDcWNH9rj1JR/dKEyAQUZvxxFn8x7sUT95QXfNHYjBavddDj84PJLbR5onduzLkbQmZOJzdAR3VUiR5/GpWA0wQrhsMWflV5q2Izj1yBLZXnyRTSBCLt8IUiFdv/gC5hrXIIEfWA+NLZR8Co/VAt6QSucurtzbQLbhW4iYcsTNDStluyBxvZxKYXi/rBqFmyrf26pZ64+FsFxFVfWSn8MfKfheIUDLU1grj2vVib1UBw45JWJ3laGMbTs2eTaQzj0cO+xWvGwz+EQBeCTnRaXT1+WpUXkWt87P58t7lI2lRvEDR3r3OgadKliOaEBVdPzExvKPr91jMVM+fqOFKlblj0/o1Q/SoCFLOVD73vXVay/ofXjEMyDJhv3yWxrS/VnxbO2DKNB5rj/alRuF6un/lDZU8a0mgPZ4NIJ8nWAijt4vfz8l96caxrllKomZxtdWEG6uOVYNvZXfOdpB5uzxOHBQxTaQ2Jmte0ElubrvFUf2bVmFh520+ors3XLlUtGIDFlCy7yd2PQKCJ8Dyq/N9SOIVtIeMXftel0+CGmEzRDH1kL1aEybGKTAMr+rb6ql8nAm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6506007)(66476007)(66556008)(4001150100001)(5660300002)(6486002)(2616005)(38100700002)(38350700002)(2906002)(83380400001)(66946007)(8676002)(186003)(31686004)(53546011)(8936002)(36756003)(966005)(52116002)(54906003)(31696002)(86362001)(6916009)(316002)(6512007)(508600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZjTzVuWGhhM3Z4VGVNK1ZyaFlvSmhabFFRZkhpakYyRkh4NWhkY2V6amc1?=
 =?utf-8?B?QmsyUXVscVRwbFdLVkNIb3dOVHJidDNJU2pYTVdKcXhDUDlrTjVjVFQrOFdW?=
 =?utf-8?B?KzljaG5RcWZyT0F6cmRaVzJNbkMzOE9HOHYwajd5OE10ZEZ5S1dTV1l0SzdL?=
 =?utf-8?B?eXhodXhlSHpJRk9RWTQxVXIzbVBLNWtHSUI5TElBZFJ4RlpHejZQQlFnUHZQ?=
 =?utf-8?B?Z3Z2NnVXMHBjYnNQczVveGQrNVNCdVlCa1cvVmNYL3c3ajE4S3NoS0UyNXl2?=
 =?utf-8?B?Y3JtMUNjdlkzeVF2MzNhLzYzTC9NNFBRM29JWGdVNVRTTlArYlp6MFAzdXlY?=
 =?utf-8?B?ZklHcDJqbHdMdGNoZUI3cXFOVEQ5ekhCTVBUNFJaRkF1TytrYkhWeG5NYUcv?=
 =?utf-8?B?eU84MlVEOUNyQ0grWlBvWWlJWTVzV01iVHplaE1laGVtQ3VLcThDdy9CVmRC?=
 =?utf-8?B?b2VzZmNXbTkybE9PbGU2VGVKWjRvNkZvc3VXcCtMTWZIOTlaMHVKTDZ4UTRs?=
 =?utf-8?B?QUhva2RsbnErMk9zaDV1WWFWRTdBRVZWcmZOczNLcnF3OWQreks1cEE1RFFt?=
 =?utf-8?B?N29sM25JR1QxSitGYWR0Ry9BaU1IL2RUOTdYcUE0SjdNWDNyZEsrZWZkaHp2?=
 =?utf-8?B?S2NsMUNoaVlISTlYR2ovZFRyK01oOWxDQjdONUpEa1pDN2RieXdrT0laYmxN?=
 =?utf-8?B?ejlEejNUM0xHQVJIU0VpK3Btdkd5d2V1dHJFdUM3VGp2cWhzL2xSbkI3QWtB?=
 =?utf-8?B?Q29YMjUzK2ZFdmVVdjU1ZGdJNzN4dngzQmRHTTdacm1oUEduWTNxbW9hblRI?=
 =?utf-8?B?TzVwYjd2d0J2cEFGY0s5ZWQ2VDMvdEFGMDMrQSt1bjFncjBnU25BOExxYTBQ?=
 =?utf-8?B?ZzR6SkFVajlERkRjekwxNThOM1pvMkNiU1A0R1kzWUdQSWdiL0J2a1pwSzdN?=
 =?utf-8?B?UzR1UksyYkRjTFBSWnJTYmllRWVmRnV0bDhvQ3V4UWhqcjRnVnlSeUM1Q3Vu?=
 =?utf-8?B?R1NUaVA3VTRSU2RhWUpmUURXeEUvMjhkOHkrbCtQVUN1S1JJN3BHc1pmUVlu?=
 =?utf-8?B?c2ZyR01Hd1BhdEdWc3ptUUxweVYzMlVKalhDZVg2bE0wZUhzcWN1Vnh3ZWIx?=
 =?utf-8?B?Z1lwb2tKeXhUS1NQbHl1U245dnR0R09pZW8wRnhSUndSeEhpWUFsdndpV21L?=
 =?utf-8?B?V0tGbDVEeGZIUDgyQXFHZzBrbEw3ME9YTVUvOFo2bXpwTGppZVdaOFI4RjI1?=
 =?utf-8?B?VFIvWTY4YVNzWEgydDRzeFZPeDFHc0FleXJoTmdsTTZ3aVBKR0hzdVJ0Mktr?=
 =?utf-8?B?UTJobjVJcEtsYUNRY3U2N3Y5WW1ZckhqT3lUNzBURlkxMDd5UlloZmxtSSt5?=
 =?utf-8?B?NVIxZTY4c01LeXhHNWNuQ2FsMW1PeDZTMW5vRWlIMkYrei9UaXhTdkZmR1RC?=
 =?utf-8?B?ZndmdTB4YklJQlVCMmcwS0xBZkN3dWNuaTlyUDgxaXRHOGZTZ3BPUW5ZNWps?=
 =?utf-8?B?NElBa08rQzN0NFc2RzduQktYVHVTNVh6cmFUOVcyR0dBbENSZE45dXRwbG1B?=
 =?utf-8?B?V3QwNmN1UE5aS0UyMlhWUC9pTkFEQURaSlhHQS92bzBkNmZvZllUaTNzVzJU?=
 =?utf-8?B?QnJ3WE9Qd0k5d1Nwdjg0WWh1VFU2b2l5MUFiNEE3ZmdEMjE3VFpCQ1VsNVpB?=
 =?utf-8?B?cnJ1d2ZDQmxHQVRCUks5WTEvZk9zb1c2emJ6R0o5TFpBajJhbFNWTUFwOWRM?=
 =?utf-8?B?anhZOFcybjJERkkreWFDOERhK1pueEhoN0Q3OSt3WTlMdzhxcGxvaUJXQm5K?=
 =?utf-8?B?MWlUd1ROd1hkSGhvTVp5THJDQU5XUzRldTYzM0VnaGphcFppV0xzYzRKNEJ5?=
 =?utf-8?B?MEtRL2RJZ1d2aFN3QnBhOS9LZk5wYTVJdTZ0UEJLOXNFK2lIekxCRGlyc2ps?=
 =?utf-8?B?ajJDUjQrc0krU2RaN2J6N1d1VXB6cnF5TXo5cm1OUy9xUjQ4UEhjQVFHVUw3?=
 =?utf-8?B?ZlNNS2hoRWFZb205ZVlXQU9jYXVrajhRVjY5eUpBdXA3N2hlend6UUFVbWtG?=
 =?utf-8?B?U1JQU3ZCUDlPMmdCQ3dPQVpTV1NnN3J5c2RYVFg0WFRReWdsbDljMXFBQ2ZC?=
 =?utf-8?B?RjFsNUx3VE1BcVNCckF6TXdkMkw4T1I4N2dtWEVaWnpwRGkxbFZ2WFArdFpP?=
 =?utf-8?Q?u9zlVcOUY0Cv0T99I/hpmjg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31232a0-40aa-4d69-07f4-08d9c51e514f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 07:40:25.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkndSQepYtGDB5U4JfKuvSid4CD072ciTaInX/MBthMuLcrqke7up2zG/tm5hA/aC+022xQMnC7efKZMPm+4QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1750
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 09:51, Vasily Averin wrote:
> On 22.12.2021 08:25, Namjae Jeon wrote:
>> 2021-12-22 13:32 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>> On 22.12.2021 05:50, Namjae Jeon wrote:
>>>> 2021-12-21 22:08 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>> On 21.12.2021 15:02, Namjae Jeon wrote:
>>>>>> 2021-12-19 18:34 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>>>>>>> To avoid possible deadlock ksmbd should process locks asynchronously.
>>>>>>> Callers expecting vfs_file_locks() to return asynchronously should
>>>>>>> only
>>>>>>> use F_SETLK, not F_SETLKW.
>>>>>> Should I check this patch instead of
>>>>>> [PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock
>>>>>> ?
>>>>>
>>>>> no, these patches are independent and both ones are required.
>>>>> current patch fixes incorrect kernel thread behaviour:
>>>>> kernel threads should not use F_SETLKW for locking requests.
>>>> How does this patch work? posix_lock_file in vfs_lock_file() does not use
>>>> cmd.
>>>> And your patch still leaves FL_SLEEP.
>>>
>>> "use F_SETLK, not F_SETLKW" was copy-pasted from requirement described in
>>> comment above vfs_lock_file().
>>>
>>> posix_lock_file() is not used in all ->lock() functions, and use F_SETLKW
>>> forces some of affected filesystem use blocking locks:
>> What I'm saying is that when we apply "ksmbd: force "fail immediately"
>> flag on fs with its own ->lock ", this patch is meaningless. How is
>> ->lock() with F_SETLKW called?
> 
> I got your point finally,
> yes, you are right, now this cannot happen.
> However I'm going to fix all affected filesystems and then revert
> "ksmbd: force "fail immediately" flag on fs with its own ->lock"
> When this happen and ksmbd will still use IS_SETLKW it will trigger the problems described below.

I've created
https://bugzilla.kernel.org/show_bug.cgi?id=215383
