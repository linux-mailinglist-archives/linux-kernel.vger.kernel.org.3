Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20347C074
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhLUNIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:08:43 -0500
Received: from mail-eopbgr130125.outbound.protection.outlook.com ([40.107.13.125]:33190
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229732AbhLUNIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:08:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbRIv4WS8Ts3a3fIYnAYppBiY1KlPRbLjOouKB0Lze41Ofa76DopPjk7pwxh07QhrUZA7lZA/N/+Y6f6uSDHNK16P/XGo7Zvj73uLUqqlqIwUcKVzeBwxiIcKqSMIwwYhQIKIv0ScX+vtA1K4v7wowkdtdRAHSNo/WzxmXeQ7QPpoh+dkKVHyIZO/OsO4DSYwRazmY2iBLcQXXfjhtOt40N4TFkFHeR8upfWgClkWGPpLr7PtCd0oF1ZV/rQP4O1ff34xguoLflOG08rEGvzzUfDc4IQU8KYx01xUdoh4nDJPF09iyief5y0e55MUxBQvMlycEmLzGF8zhYChI2zvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0a1NDQIhotDSjj3j+id8W8dM7+U5cI10f78J1EZ9xE=;
 b=j3roRw9RAMiOByc4K7OZPiq8bJt6/xcsgZ7IL+eVPrCPeN6V7VxA3Hp5Rwc6oYVt034HJh0nnOKEvj4wNY9TkoN3aegkQRv65uQVXPlGTukuoWGM4sMKdoQ5SEuQ8WoKZrhMN7hHC9k5tpzqdy7BTaDVBNT6XrVyX+Occ/daKbWpwoCBCl/YFlNIC9LilaWNMexmh3KueCDW0LwSK2tg08oU1uSPcvsLQvu3sIKe0nWXeoBtmS3tm6x7PCSjBgnMAg+QdmjnOKcEPNNVYdQrM2UEDh1k5eXbp8MO8PSCpRq04ytNgaiNsPl7E4Lq8ogva0MpGvB6sx/m1H9ADBS6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0a1NDQIhotDSjj3j+id8W8dM7+U5cI10f78J1EZ9xE=;
 b=eCwMcrI4tTtL/i3QO1Ycpj7uT9TJRDgGhm1fgc3aH8qF8pbv9e6QDPCAsvPNBZENuzdHCuaYG8xLd8iLsEibQctxT/SoeynF8eerCWU7OWiEKN3hYKRYm3WRHD1OUwcLPLCM/2RgzIJ4hTGzkkT8YOMBi6m3kdekUPDauVtq5Nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com (2603:10a6:10:257::21)
 by DB8PR08MB4188.eurprd08.prod.outlook.com (2603:10a6:10:b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 13:08:39 +0000
Received: from DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa]) by DB9PR08MB6619.eurprd08.prod.outlook.com
 ([fe80::347f:d385:ec53:75aa%7]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 13:08:39 +0000
Subject: Re: [PATCH] ksmbd: use F_SETLK to force vfs_file_lock() to return
 asynchronously
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, kernel@openvz.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e2aef4e7-a9b9-e44e-94a2-29ed6bc20091@virtuozzo.com>
 <CAKYAXd8pCfUBPRXT-44N_g2GD_BKtjboiepgTGz5DQ93YEiz-A@mail.gmail.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <bf92bd1f-d03b-1fb6-ff62-53cca4b441e8@virtuozzo.com>
Date:   Tue, 21 Dec 2021 16:08:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAKYAXd8pCfUBPRXT-44N_g2GD_BKtjboiepgTGz5DQ93YEiz-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::44) To DB9PR08MB6619.eurprd08.prod.outlook.com
 (2603:10a6:10:257::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 820b25d3-5a01-4627-5cd9-08d9c4830130
X-MS-TrafficTypeDiagnostic: DB8PR08MB4188:EE_
X-Microsoft-Antispam-PRVS: <DB8PR08MB4188EB15A7F3721BFD127A04AA7C9@DB8PR08MB4188.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4GumRicVk2KCJQ89AMlX3fIfxE/J0q1XbAi7Ie5Tp3w2La3Pqfw955oPi35Zok5YrnnVP5yQ8o+wfIZQc7fxCBzL8x0T2xgz+caEKTGTdI7SYwEJ/ERRDFMkZuZXIIzSlPwxQBt5Ju9iK7qdZ9XSjADr3PXHk+rCMrJeIjPsjPXYt8FAaBZ4D0NApNkaOMvjaN83bL8y5KoD4R7Xkdas82EYWotyMTJZimQOGtGPAgqAC0U6YeQaDzD/o1B3d+Km+MXznJ0tzqH8YGlx6egs0QoXE1GMLelyRQuUMbK3gVvcqiHPEJmpjJnYMeHOmyF9kcJMScRZ1E/+3viU9NKx2qyFDGDi2hAd2qV/w2gb08QkuR5UMLsBIfeH3lLeHlP8vXWNHbr6Lw/0Mk0LyHubWrMBzx/U88JnjIbcOrFjfkzazcoMl9wOZ+8ekQo8r5kYEpd0D9z/2U6veBLqyg/jANmQQo3liBG1tnN5/F5Ks4j1swiX1Akl14FIPEEvUF5XP9Smnd5ihDJz5TzVo737fFcA3F/2MDFLp2ZTDctwOEiQV3asDZN+UvjxNIHE/4ZCdUgzLHGt23mmEe2YUgttkMZZAi87hFxTUIIjHfunH8oh1VbH1SXK1mPn4SqqpPY7nDzQj2XnjA+ccKeLmJH6pjWHy1XtcCaCEa4jhuu/A9quFNomcllP3gf5nOlwc1RFyYSetaypeHhsp8Y+zUKUzVBCjvyp3T98l46wUcwQy8j5H75yvgglyzacNpzkR9xRMJx1H/tvb9jI2qTQrRIqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6619.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(26005)(316002)(54906003)(2906002)(53546011)(6916009)(5660300002)(186003)(4001150100001)(66476007)(2616005)(83380400001)(4326008)(66556008)(31686004)(6486002)(36756003)(38100700002)(6512007)(38350700002)(66946007)(8676002)(508600001)(8936002)(86362001)(31696002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FrRXdUK2xwZEpRTHBjL3FEK00yTkdpNi9raUZWa2daVGxlM2RMWUNCWHF5?=
 =?utf-8?B?UURpOC9ZUHlnTVdGN1paRlBBTFFQMHBsTWtKMnJYNWlGcWRTK0FCNTRldWow?=
 =?utf-8?B?dnc0ZDFWK3IrWEs4YlhrQkhvVUNBUFFzMS9UZUlLRENNUVgwVjFMQTRwMUVQ?=
 =?utf-8?B?QWVkbEJRaXVFSEkyaDdkN1NsSHR0V29tczRUZUZvV3NuaWVCRTJsb3B5c2Vj?=
 =?utf-8?B?ZkNtU2pSTy9OczFkUkxQaWlWZlUxOStodUE0MUt5MXkxc1dEQVJSTjRwUFp0?=
 =?utf-8?B?R0ttWDdELzlDaWpWYktmZXRobDI4aUpMeG9adzA5eVFOR1FjYXFBMnl5dCtu?=
 =?utf-8?B?ZEZoY3pCcVUzY2lQTDVpS0VCaHF5WkJCWXk4dVJSQW4wZGdHS3B1UjhDajhl?=
 =?utf-8?B?VDVTeUxFTUYxMXRVOHhLSjFkOWdGV21HbjA0UHRQekNoYUNLWFBxM2s1UndO?=
 =?utf-8?B?K05FbXcwOEJxWTVreG4xbU5HK1FmL0VXaE9tUU5QRlJycDRjbGdjL1RnNFlZ?=
 =?utf-8?B?bUxibzNRZ1pmaGlqWlRYTGxmaFVIdy9qWXhTWlg5TlpwaW9IeXNkeG5HK29P?=
 =?utf-8?B?RS9xZUVBT0lNc21Ba2lRTHJmUllOdk1YL3ZyWmFuWGJBWFlnRGxhQ0FvMmVW?=
 =?utf-8?B?TUg1cXd6elhwWEMwV0o2OWh2cFB5akFOQlpIVFJTRXFFc0Z3N0Y4eC9yT3Z4?=
 =?utf-8?B?SnhWNlExR2NUdzVrUlhkTW5qd3l4TUNFc3Rva2xSamwwRUlUVEdtWHFjdnd0?=
 =?utf-8?B?aVl2RkhsZXF4bFRHbi9sR3pCOFZoQjlGc2ZOUHlRaDdIY2N0cU1LWVNramd3?=
 =?utf-8?B?VEhmUlE2Y1BvemJqbUVVUHpXRVg1c1IzSFFIWVdaT0ZCSmREYWh0aGVwcEp2?=
 =?utf-8?B?d2dtMm5pZ2gxb2pzYVBiQzRkYUF2enplb3dhbDBRM0FVdGNKQjRMTmVsOG0z?=
 =?utf-8?B?UjZTWlJ6T0FIeERqMUpTL1FvRTdOTUhCK0Y2eHZaaUE4WVljcExRbCtnZmVZ?=
 =?utf-8?B?MVlTd2x2Rnp5bDR6dnZ6UG5pRnIxNHozbklkTjE2cGtoQW1CMHJSejJJb0Y3?=
 =?utf-8?B?UzZwQzFKbXllcGpKcFRPcUdhOEJUUjREU1ExdS9BaExLWmEzYUpDRmhPNVB5?=
 =?utf-8?B?SnNqK1pkUFBlR2U0UEhDQkxhMld2bHJha0dwUjJrazhmRS96Zlg1NUNFbFpM?=
 =?utf-8?B?M0llMDFwci80MkVYOTFHMXN6KzlsNzA2WWtqVnZ6c29PeGNqS0NITTlOa2hV?=
 =?utf-8?B?aXk1REVlcVhwOXZlMEExTWU0S01EVkYzV0FQSHczY0ZnMGxWNzh6eTFJaW1Q?=
 =?utf-8?B?T2ZWTUg2S3BZeElHZ0tRMjBBMlhDZitsRFIwdWhEZHlmTHAvektJYkthNFlR?=
 =?utf-8?B?Q3VRNm1FaHhHcDFlZXRoSVRmNGErRnJTTWhuUTkvY3NSSUVPei9RcWRKUG5N?=
 =?utf-8?B?K2JWdnVPbWZIUC9vMzJ0ZjdTeFU3ZXRaeVFaaUtRT3VwbFJaKzNxR1BVdzgr?=
 =?utf-8?B?Y1krNHo3dTYxNTN2OFpLcjNsS2hmTGFlcjRQNGtkVzQzcWx4UktMZHlNRTB4?=
 =?utf-8?B?MERIdEdKSzNueDlQTkxWUitZTE5EdWIwbWRmcHN5MDQ2RDd6bys0OWdZTHpU?=
 =?utf-8?B?TWdzd1EwWjhVc25KaENCSnJzUXljajQ3eWJtNU9IdVZ6Mk11NDJIMDk2OWVj?=
 =?utf-8?B?OGdzMzhrQldaTEtMRTdzSlRWdXc3N0pqVGExR1AxRFlJZDR5NUVtQXdoU0pD?=
 =?utf-8?B?bEM2Y0VxQjZnaUtDcGlQN2EyWTI5VHRuU0JFQ1R5ajNIcUQwanMzcDc4cmZy?=
 =?utf-8?B?Q3N0dFdJNHRXTE0xVURvcXR0eUV2WHNqWFRsNEhHaENaVlE5VDg4SGFlTjA1?=
 =?utf-8?B?ZzNTMlB4QmFBeExRcXoxdENxTXZ6U3R5U2lZVXNHUERlWFAzVDJrOHp3cTF4?=
 =?utf-8?B?aS9xWk9lUWxwVjFtSklpYW9td0czQ0IzMVFyUmJDbFVQNFdiVEU1OGE1VmhO?=
 =?utf-8?B?cEFQM1lLa3ZQMmJxOXkyYWFQZDNqTWNDK29kS1JIbXU0bklBVDBLc2NKb3M2?=
 =?utf-8?B?akc5bWtyZUlKczJ1eUhvY1QvY3greWVTaDI3bmgzMkVwVWFGbWJyVzlSdnh4?=
 =?utf-8?B?Q2hOc0dPT1FqRHdPZnUxa2g0cW1GVjJvcUVjc1VRN3RnN3hqc1hGekdVWXJY?=
 =?utf-8?Q?wj6sJj3+0ObR7lEuz9P/Wkg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820b25d3-5a01-4627-5cd9-08d9c4830130
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6619.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 13:08:39.1712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRy7iBVCZ1zphNt5JLDfdOBGKgCNjlMpLgTL/eFtnuffo/CfJoL0TzlDC+NHD+TZOg9uV6Bm0G/FTNQI35GbRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4188
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2021 15:02, Namjae Jeon wrote:
> 2021-12-19 18:34 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
>> To avoid possible deadlock ksmbd should process locks asynchronously.
>> Callers expecting vfs_file_locks() to return asynchronously should only
>> use F_SETLK, not F_SETLKW.
> Should I check this patch instead of
> [PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock ?

no, these patches are independent and both ones are required.
current patch fixes incorrect kernel thread behaviour:
kernel threads should not use F_SETLKW for locking requests.

"[PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock"
tries to workaround the incorrect behaviour of some exported filesystems.

Currently this way is used in nfsd and lockd, however it is not fully correct,
and I still search some better solution, so perhaps
'[PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock'
will be dropped later.

Thank you,
	Vasily Averin

>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  fs/ksmbd/smb2pdu.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>> index 0c020deb76bb..34f333549767 100644
>> --- a/fs/ksmbd/smb2pdu.c
>> +++ b/fs/ksmbd/smb2pdu.c
>> @@ -6646,13 +6646,13 @@ static int smb2_set_flock_flags(struct file_lock
>> *flock, int flags)
>>  	switch (flags) {
>>  	case SMB2_LOCKFLAG_SHARED:
>>  		ksmbd_debug(SMB, "received shared request\n");
>> -		cmd = F_SETLKW;
>> +		cmd = F_SETLK;
>>  		flock->fl_type = F_RDLCK;
>>  		flock->fl_flags |= FL_SLEEP;
>>  		break;
>>  	case SMB2_LOCKFLAG_EXCLUSIVE:
>>  		ksmbd_debug(SMB, "received exclusive request\n");
>> -		cmd = F_SETLKW;
>> +		cmd = F_SETLK;
>>  		flock->fl_type = F_WRLCK;
>>  		flock->fl_flags |= FL_SLEEP;
>>  		break;
>> --
>> 2.25.1
>>
>>

