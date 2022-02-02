Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888854A79AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347271AbiBBUoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:44:10 -0500
Received: from mail-eopbgr60133.outbound.protection.outlook.com ([40.107.6.133]:23141
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347194AbiBBUoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:44:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmf2Gz5CodRwSaXxjdpBfKJWIbJwrKhTTHDhOQCQFQGhmLexBZKYIIAX6w3oi26JnwEXtbwXSTuuYbHcDh1Ey2pcUeREdTb24Bnx52dG6jsL2taqEDBpMVZbA2Thb6sjksNgDegI7MfVd4PjQN4Vpan20TMoiU6wFEeFxWElOKXUmEKrDeJB4MqAIpm1byaNSlXlu5jce3/pyoKPtoh+GqrLU6AcHBsQnXGSItx47EthMUkSXTXnmQs+zdZSHKsB6cIh1kE8CkQIAR4k/03GjbCiRzAY28TPQwJVv1WMVbSAMhEKgwnlYfbslKfgIRuzaNSbh+TFMdIxkG4BksfQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rtOkz01CZBUob+KU6YDYt6E9JFGMhCxcfV5P5rc1ls=;
 b=dTkReNO4/QqXqnQeH0Q9ht4x7FAUce5CfYIM0CXyPSMp84p7yRmy5/xDXsWMrm3JA/hGEZjgapA12XdUg7zWVof6eNUNKindnRVWZf5vcACxk7wfLPJVMHg+hQjxAfH8Bq1MxFDvLZg6iD/i0TvuekqRge0ajyvn6+TOFrtizuMZU/fvINoWQFK6g0jSEiDedAu3xBDKf+TW+4ON1Q27Mk2EdlsRmV6nxjIFLVFqnzTMT7m3ry5tcmoyS7DVoKyaxV4kWkVbQjI4UTJd5e4JErH0669PLOz7BTWND4ifxV7euWeH+q8yirXOux3pfcNR18OVheNrcTp11R2ljvc+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rtOkz01CZBUob+KU6YDYt6E9JFGMhCxcfV5P5rc1ls=;
 b=GITrloKxmRN49LhIvttSl4sG1qbqkiGYeD1CIrX0KMfU2xvoXh5wQbtadVJr5X2rGnx+b3HjwtXTKEfn0Ea0MF3iEQ0MOqGbshvKXxsQscp7Al8HO9ypcrPq7WWj/KW0a98LMM2IZhazHCBADq/SVbBuHHjoULhRi83JXdWYyfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by DB6PR1001MB1381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 20:44:04 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::608f:51b:ced9:9c8f]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::608f:51b:ced9:9c8f%7]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 20:44:04 +0000
Subject: Re: [PATCH] linux/const.h: Explain how __is_constexpr() works
To:     David Laight <David.Laight@ACULAB.COM>,
        'Kees Cook' <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <20220131204357.1133674-1-keescook@chromium.org>
 <6641e01b86374ce197020d57c65ae3b3@AcuMS.aculab.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <311c9ca5-e2d4-22fb-0299-d47f84470677@prevas.dk>
Date:   Wed, 2 Feb 2022 21:44:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <6641e01b86374ce197020d57c65ae3b3@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0094.eurprd05.prod.outlook.com
 (2603:10a6:208:136::34) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eaaed45-8f37-4027-e41c-08d9e68cbfde
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1381:EE_
X-Microsoft-Antispam-PRVS: <DB6PR1001MB13815600AB8BB80E73B1ADE393279@DB6PR1001MB1381.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbJA+skFHR3wpx/knAzXfzTk98J5yzQH5ai0oYTrGVDCuxMyWmXmLwXv/l28Q8KfkZL99jzJqghV6v7rZ45OnfgDsoiJmQgvAa6yFtLhswROS+Xyfnpf9UlWtt13RyQXtV7nXTftmtZ64XTpbUAWMEoi24obVTDbfZndNLBnb3BVM2Cy9OWq+6a/ew1zro0sHIhKUTMw91f2HbJ1QFnBLm+QbrMnI710oxR5+5hV1tm4Z1S54U1pVtCtyQuLSJ/jC+1dKgVyXhH2/e4QI7Hcf4Nulqs+A67B2F6fnTQZDmMTLu/Kbaqv+RLW686cwsn6sb37kYuI0cgS1ZFhCfJMTa3xamaVVOlMbq83ILD7zbnA8uvnFeSGqyK/6ISbEZQF31GntH5MgoHrBohxHEgljSxQdoshd0/RUtr562nKJhYz22SbXH7FdDZX2kc+FZSXRihEoZI6eaIaTzPIumFfszVu8Jpxyaroi5P1kSdUD77aN6LL3uXUVKOY5j8g/xyiw/1nrFKxhCq5M96s+vdqx3mRkY0NNXPXjzTJrVSHEevoZ5sVg66Bd6wCTRpJFNS1dSylZiiitmZSKT+XQDNAP5MYktCZYV9eb3AkFCYJp1+8iYGksGYRpCVkBhX7j6fYzL5Tdjr1JdD6wahCurmzHSwJ2vt08UeAoP7VciF0t9tqVeHlNXZwm6syavElXJXwu7XJF2GG48RHtd9toR9q9t4MtuFPIwhW+jOPaJPvVAFOuMy1XuSPypJ2w0BLcHUoIg3W/AylC01zKgsTdVQpdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(6512007)(52116002)(508600001)(6506007)(6666004)(2616005)(44832011)(6486002)(31696002)(8676002)(186003)(26005)(83380400001)(66946007)(54906003)(66476007)(66556008)(7416002)(36756003)(316002)(31686004)(38100700002)(4326008)(110136005)(5660300002)(38350700002)(8936002)(8976002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FqSXRYSmx0K0doaWxESXcrSHIrTzB6OWxML2Q4ckd6Rk9SVTNPak5IY285?=
 =?utf-8?B?Ym5TaEFSREdvTGVjQ2VNRGdpdlVXVEI1VnlWbmgwMFRqUWhZSFlxaFRjMDZI?=
 =?utf-8?B?OGZHbGZCRVVrcDEwSkJKZG51Ly85a0FFSERqV3pzRXExS0FITXJFM09xY1V0?=
 =?utf-8?B?MGNIenNGWFpqZXdwVHdTZzl0RFBWVmtlOUZvdDhjMVlhUml2NXpSN2dxbEdW?=
 =?utf-8?B?S3B5Q3RMbG91Mm5uaHRzbWdHYWhFeVVzdHNqUllZYy9laTF6d3h5WGN6YzJs?=
 =?utf-8?B?T1AvcSsvMTg3WWFHbUxxczFZTmlETmFSZWRwV1NiYk9nL2x6VFN0Vys0QTZE?=
 =?utf-8?B?Ri9yK2RhUTNLbGl0VElHbG13cjJnU2laczlrTjhMajhjem9pS3dzWlFoYjli?=
 =?utf-8?B?eXgvSEZ2eFdZMTJSa1U4M0pIS1NuM1p4ZXlUdFE5U3hmUmQ2eEJxSkNMdC9R?=
 =?utf-8?B?THZCS1h6Z1VpRGNTZmtvM2JRTHp1ZTVNV0gxdE9kTStXMlJqYVNoL2tJcDY4?=
 =?utf-8?B?Qko0LzY0bUdzWlNKcG11c240alY0VE9Gc2lBTVV3MFYvUjhQMGJDVk5CRDJs?=
 =?utf-8?B?alB0b1BLOXNNVXpBSE9BaFNEVlUrTWpycHB0UTVIZEwvdFY1SkdOUG9lbWpL?=
 =?utf-8?B?blNPTUVoUlRtRStZVWJqcGdiS3dBekxRS2xxa1BzOGZnL3ljdFNHVHZDSEhv?=
 =?utf-8?B?RFFaSGYwQ2c2WEFJV1gybFlzb0d5RnVydkJORjhJeG5ZTFZFQ0xIVUJ4Yjd0?=
 =?utf-8?B?dEVIKzBYNittYkdRWGlJSk1weFJIZnlSSjdIaGNEWG1xT0xYWTI4Uy9ydlRt?=
 =?utf-8?B?S1M1S2RJbWttd2dwNDZEU2xVcG90QmpUNDhSNkQrdlEwcndRbENGOU9peVlR?=
 =?utf-8?B?RUtKU2tESmdtd1JVZ1ZhVllvUDI0cGp6ZHNybTlha0ZiTzN5OWdCVmVhWkE2?=
 =?utf-8?B?UE1NSmJDdDZ5cWdBMGluU0tNbHlmRnJVaWZFOXRabEpiT1JSdzZ1eThlRTZ4?=
 =?utf-8?B?R05kUGpNVDVlbWg1dUJPb2ZkaUVNL0Fkemk2T1FqRUEzSUluTjNSSHQrUkhU?=
 =?utf-8?B?bkwzM3kzcW9oejhPWjEwbUh4c2tLdlVnNlBCLzcyUisybXkzMjFKbHgwOVky?=
 =?utf-8?B?aUpXQXlRdDRzVFkvK3FRbWJ3VHA0SEt6Z1pScG5YRHczYy9DNFBLcGFiZjRM?=
 =?utf-8?B?UjFSQlBWL2hORlJZc2czbkJCNzRQeEExS1BJMEdhS00rSXhxUlB1bEUySW50?=
 =?utf-8?B?V3JBOU43REVzemNtOHBiSlcxcDh6L1RBNUppeUdMOUI3MGpmTGdQT0dVNUVG?=
 =?utf-8?B?UHVTbFFTaWR1YWdYbXpsem1jb3M3YUhVN2h2ZUFtWkNIazFKZ3N4SDNiUmZM?=
 =?utf-8?B?UTBqUlBaZk8rQTFpYVZmb0oycVdYUlhNeUNYY1ZjcXREcmdISlQ3OU9SRmsw?=
 =?utf-8?B?N1RHbmpkTkNyNE43dmY5bzJBZXpyd1NZdXE0NDlZc1ppT3JEWlNuQUJzeldu?=
 =?utf-8?B?VnRxYTNzbElrbVYvNlM0eVVaSWNwMHd0VFEzb3E0L0w5NHZzaHRqUU15Z0Jk?=
 =?utf-8?B?UVgzZkRvdDQxeWEwQnJ4WnpsVFlGVjFlYW9SbEwvSUlwcGZwTEdtclFDNFB0?=
 =?utf-8?B?ZTdMdHAwYy96WXhWbUZWWFgyS2wvYno3bGJrekdkN2VGRTkvVnpCQ3k3dTcr?=
 =?utf-8?B?enVlV0FkblRjWERkaUpSMkVVZzBrTlcwc3FRNHhNaDNYeit1Z3hLdWlYSDg0?=
 =?utf-8?B?aVhsVXBrV0ZuQ0FKRUM4SDhaK0YzbjJrNENEQTgvOFFwWlZtVzhFOVI1MXpQ?=
 =?utf-8?B?MDBPQkMwVlZvL0hPUzFGSExnakxGUHBsT3Y0aVJVSGNLZTVpS3BjMlJmYlNl?=
 =?utf-8?B?NFg3R1BXM1AzSG03UDNXVzFmVWtKem5ITlRSWmNiNXlKU0h3OUI0aTNDaDFB?=
 =?utf-8?B?a2ljZXZ2U1Qyd2JTaGdzUXMxWEpzL3lkQzV0TVphdjN2cVJuZGZRTko4TGcy?=
 =?utf-8?B?TGRzbW1acnpHQWs4VUk1bkd0YUVPTlJRT1lFSTUvZm8veVk5N3Y1YXJQc3Vp?=
 =?utf-8?B?bFdEc2cycWx5TGFQZkJtY0FoOUJNWExOOHVWYjBKU2RaVGJvS0JjVXUrODI3?=
 =?utf-8?B?VGNQeXp3Q3RmS0hpYS91RHFBMURLd0RhcWVzbkR3SVNLRmlhTVVDNWdPdmp2?=
 =?utf-8?B?TVRmQkpNakd5endiUk9Qbk15QVc3aE95NS9UVGdpTEtZNmZpbSt2Ym1WQlR1?=
 =?utf-8?B?MlowcWhwZFovbVRaNis3Mm1rNmxBPT0=?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaaed45-8f37-4027-e41c-08d9e68cbfde
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 20:44:04.0411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4ya9OBprILb6XJcpO1CTL5zuz7i3FlpiF/x14j5B4HyAWYX9NC9Yzm2aL1eCVXrm3f4U4G8p+ZY+oVt7Ag525nxDRhtJozYjlzBdWNfgA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1381
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2022 17.19, David Laight wrote:
> From: Kees Cook
>> Sent: 31 January 2022 20:44
>>
>> The __is_constexpr() macro is dark magic. Shed some light on it with
>> a comment to explain how and why it works.
>>
> ...
>> diff --git a/include/linux/const.h b/include/linux/const.h
>> index 435ddd72d2c4..7122d6a1f8ce 100644
>> --- a/include/linux/const.h
>> +++ b/include/linux/const.h
>> @@ -7,6 +7,30 @@
>>   * This returns a constant expression while determining if an argument is
>>   * a constant expression, most importantly without evaluating the argument.
>>   * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
>> + *
>> + * Details:
>> + * - sizeof() is an integer constant expression, and does not evaluate the
>> + *   value of its operand; it only examines the type of its operand.
>> + * - The results of comparing two integer constant expressions is also
>> + *   an integer constant expression.
>> + * - The use of literal "8" is to avoid warnings about unaligned pointers;
>> + *   these could otherwise just be "1"s.
>> + * - (long)(x) is used to avoid warnings about 64-bit types on 32-bit
>> + *   architectures.
>> + * - The C standard defines an "integer constant expression" as different
>> + *   from a "null pointer constant" (an integer constant 0 pointer).
>> + * - The conditional operator ("... ? ... : ...") returns the type of the
>> + *   operand that isn't a null pointer constant. This behavior is the
>> + *   central mechanism of the macro.
>> + * - If (x) is an integer constant expression, then the "* 0l" resolves it
>> + *   into a null pointer constant, which forces the conditional operator
>> + *   to return the type of the last operand: "(int *)".
>> + * - If (x) is not an integer constant expression, then the type of the
>> + *   conditional operator is from the first operand: "(void *)".
>> + * - sizeof(int) == 4 and sizeof(void) == 1.
>> + * - The ultimate comparison to "sizeof(int)" chooses between either:
>> + *     sizeof(*((int *) (8)) == sizeof(int)   (x was a constant expression)
>> + *     sizeof(*((void *)(8)) == sizeof(void)  (x was not a constant expression)
>>   */
>>  #define __is_constexpr(x) \
>>  	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> 
> This has been making my head hurt all day.
> The above isn't really a true description - ?: doesn't work that way.
> Try the following for size:
> 
> - The conditional operator (?:) requires that both expressions have the
>   the same type (after numeric promotions).

No. Please read 6.5.15.3 for the preconditions, and 6.5.15.5 and
6.5.15.6 for the rules governing the type of the whole expression.

>   The type of the result is a compile time constant and doesn't depend on any
>   variables.

Yes, the type of any expression in C is known at compile time, and is
determined via the rules in the C standard. I wouldn't call it a
"compile time constant" though.

> - If the expressions have distinct non-NULL pointer types then they are both
>   cast to (void *) and the result has type 'void *'.

Wrong.

> - A NULL pointer can be made from any integer constant expression that
>   evaluates to 0, not just a literal 0.
> - So the type of (0 ? (void *)(x) : (int *)8) is 'int *' if (x) is zero
>   (because of the NULL) and (void *) otherwise because the pointer types
>   don't match.

That's basically how this macro works, but "So" is not warranted as it
does not follow from any of the previous, wrong, statements.

> You can test this by evaluating:
> 	sizeof *(0 ? (float *)4 : (int *)4)

That's an ill-formed conditional operator, and gcc says as much even
without any -Wall in effect.

warning: pointer type mismatch in conditional expression
    8 |  return sizeof(*(0 ? (float *)4 : (int *)4));


> This is 1 because of the implicit (void *) cast.

There is no such thing.

> I'd also delete the l from the 0l - it isn't needed.
> (Or at least use L)

That's probably true, I think it's a leftover from before the explicit
(long) cast was added, which was done to ensure the expression being
cast to (void*) wasn't a 64-bit type when void* is 32 bit. The 'l' was a
simple way to widen the expression to long in the case where x has a
type narrower than void*.

Rasmus
