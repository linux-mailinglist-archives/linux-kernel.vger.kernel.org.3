Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72961488C32
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbiAIUHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:07:36 -0500
Received: from mail-db8eur05on2129.outbound.protection.outlook.com ([40.107.20.129]:5126
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230395AbiAIUHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:07:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT1PrAl1iMFqmcevdYt8wAczml6QKMIoN/F4HR94huuZEMiPb4BuwQNjy/xKEvDtmhB5B8sXQp1vAT7fpiLIwGC6fN8eXB7PgJQUzJDOdfk6l9v7NkwTWyIVe/HQrhVRtchcSz6Q72HRaKNDSa16tIEUusvSYw5FKPAcX+Ir4/B+Iq+Nkek18ZTi9mhRBpnb5ONEYvSb6dUOWNkENuhtGOXWGqdrdZnHnxaCwWFXZnv2+g4ePWK3gMmf7Vti85YE9++qOFTi9InBqXD3uwERWSdap7AldY8z3pPuyFXWIgiBJTlXrz4Zwcxmhwdp8tTWHHfTiCtDjCBP8eLTLsGl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spgNWeSs7vLXaK9SyNoDgH8FKsyBKup+1JURjZ8g12s=;
 b=Frz3Fd1ieFYrex2hC86SCJ2ydK7GylveCwbS7yxC+RltLQrsIthJ9CD5HguTSo97mT+aKcnROMKDKDqTokFZjyLUNDn7UOYyfj5MjSSQOye8Sbk4pjcEEQIr+ZrQcnDarJbB0Rd3X2PQKn9f7V8VJ4rS0dfBLl7lSJekNVDTaVSjR+Xn1NNVmnDle2ILncpKPr2hjeQLy9aEgNiUt6MFQdkjqL47Q9rPophf029EY4RxLl5lBe+OAltmnm/4LMmtLrwQFq10iytp308fL+1DlMyU/VJqOLcBG5vV8RDi6oKat4rWI2XMu9vYKsyEF8lW93oe3SXo+pLiNLdVjp98Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spgNWeSs7vLXaK9SyNoDgH8FKsyBKup+1JURjZ8g12s=;
 b=JlJDzVy/aGd3ZdgeBwog8wUlMzMlAckFkuhmg14Cvn/x/Apejwd8uDCNVG5eKmepzOz8S8/j6xBiCHgTu9MdIYr1b5iwEpp/JkkM6G81m152jY/rKKqKEmizQ7KR7nKTcNVmTk0EXeNKuzTMIiqVu4pIhc5xc3Np9jvgMaXd6Vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR02MB3176.eurprd02.prod.outlook.com (2603:10a6:6:1b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Sun, 9 Jan
 2022 20:07:34 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4867.011; Sun, 9 Jan 2022
 20:07:33 +0000
Message-ID: <6901bb1b-b701-9760-1d36-89e8127c1953@axentia.se>
Date:   Sun, 9 Jan 2022 21:07:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v12 09/16] iio: afe: rescale: fix accuracy for small
 fractional scales
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
 <20220108205319.2046348-10-liambeguin@gmail.com>
 <CAHp75Vd-FOV7BL0VjhGLyC5fhYXbW3x-hC5J1VvMT9W3Kfc_0Q@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <CAHp75Vd-FOV7BL0VjhGLyC5fhYXbW3x-hC5J1VvMT9W3Kfc_0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0202CA0032.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::18) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3234918d-9d11-4223-57a1-08d9d3abac6b
X-MS-TrafficTypeDiagnostic: DB6PR02MB3176:EE_
X-Microsoft-Antispam-PRVS: <DB6PR02MB3176564F401B1385B6475875BC4F9@DB6PR02MB3176.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siZ/iw12+Q/RcHxpRsl1+Yeteco8wbwD6y7lzIb5q75EuqNTZ+IudOhW1ikK2YDX2PE63mgkb7/45lIBNrlUO10Fn3Am3Qf69DqAqTo13JtyTQ232C9/6FfXKrJTtA5TLY4yRia0Ek1TbT8/49BKPdNcZQNqFTGov6k7fke9fxAphsW/edTUX1CLklZ1psF/tnJkWHF+Cm1ILK49m/w0qE8rZBZ5Qpg2pQyl5JOmZ1q2tCtFJLskoPqDl+HRHwvcoxJF6Mkn1QxpPb0GBHJc2V8KmxHEz8t8+mluoVXUn62mJ2vMGgy3dZOx0pbyDc9glDH42GReXpAxPJJHXHRLbOXNKVIRzcRPpkP7YgyqOcezR91KnGz/lgAfBb1n+Q4BgjyzibmS2VvqIHnLswmU9LvYWEV/svvKcjeIHF2hoDNW8xaDYbiPRUWzeX4Lx6sndKNWG5bcbNdMefbtHiF9hixBlzbpZBbgZVZayBUzBEXWXiLC6EWpvYyRWGMdY/RhgK9HtH18m+yziXzdaZoKiOMPTPpMiJMzThGSkcPmgFwfrAGz1gPIk9mLTp5Wk/UcPcCQeSxb2BEhOirZjKndFiKi14mHhbw9pM4BBmazmPU+oQ6marEUjVR3qGiv8LsqAZiotJwh7zSC7Jr5gp5vd96RVQ7DBIVL2a19GoTd27HWvYnS1xqb5r9uF56YmYPTUvYl4e5scMnx9q5BHLoUpXXACK2FG6moqVkYb9QjoXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(39830400003)(136003)(31686004)(6486002)(36756003)(66556008)(26005)(66946007)(66476007)(6512007)(8936002)(6506007)(316002)(38100700002)(186003)(86362001)(8676002)(5660300002)(4326008)(36916002)(2906002)(508600001)(31696002)(53546011)(83380400001)(2616005)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFIrNkJiUWh0aUx4VDBxVUc5OS9iNjFDSnJPa1owbG9hY3AwMjVhSHBMeUdu?=
 =?utf-8?B?VHArb1ZCZVR2aVlVZ3ZsK1d1T1p1T011ajE0Z3JRVG9NdmVGOGI1VmI3ZGY4?=
 =?utf-8?B?Mlo0UDZZaWRZQW9HbCs5ZEdMbUZod0FnOFpKeWxkNlFtNnZRVkx6WG05WDRm?=
 =?utf-8?B?V3FzM0gzV3ZQS3hjTWdOcWZUVzNrSCtBNWhsdUZOQjdVUENaN1c1MlBoSCto?=
 =?utf-8?B?eFdDVDY5MWxBS3FVRVIrakV2WkdWVDlET2F1V1U1Ukg0djlLQjFzMUx5SUZh?=
 =?utf-8?B?UUxzVlMzSG5OV3U5eG1LLzZqZ1ZYQ1NtZ09ZcHZhV2NjZHpycXdvTE1VTXVz?=
 =?utf-8?B?WFdLNFQ3dndhZ2UwbVNReU1FNnpJUmkxVit6THRPMjdoQWdjaEowUjdxTStz?=
 =?utf-8?B?SWgxeWdaNWJIaWp6RTlxZnRsNm1JMGJvOFV5YnMwL2lRTWx1cnBWZGowTnFW?=
 =?utf-8?B?ZHliTTZNV25jbUk4cDN6akdCdEtZa2ZVR2h0Rk93ckg5YTIwT2J4MXkwT1FM?=
 =?utf-8?B?SU9Vc1l6Q1Y3Nm1JWHNYNkt3MkJWN1UrVkNOT2pxZ0hYZVhvdzlPUUFtNnoy?=
 =?utf-8?B?cmREL1JydEFLWlpxYTZEaVQvbXpESER6Vlp2SXFhZ1VhYmp1d2V0QklmS0tm?=
 =?utf-8?B?Z0Q2czJhcjloTXdQTUpwcFlWSlhBRWgvWEMrZERrUGRiK2RiZGdOcHRYeTVP?=
 =?utf-8?B?NEVnaGlZMjFOUFZFK2JFM3ZKVUhJWkZuNWpLYzAyZmNCTEtackFzYWdWMVJC?=
 =?utf-8?B?cEcrL2sxZUFUVFFCOGRHZjVlWDVaQlN0QXFqN2VCS0FzL1JjbmRxMW9OYnZz?=
 =?utf-8?B?OXlxNDlCbUxYQjVrVzAxT3pxblkzRllBTU1Nc2pLbGg3M0d5VkhobldzMHJv?=
 =?utf-8?B?eFdFYkhRNkVWQ21nVVVjTHJWaG1GYlhBRTJTQTI1ZkJjTGV4S2x1L0VWM284?=
 =?utf-8?B?dzBDNHMyR01yWlBaVUhhSWpncnNLYmFtWmc0c1NOTVpwejJjand0RUJlTUJ3?=
 =?utf-8?B?cTZaRmN3RXRTblJNYXcwdjB6Yk9sUDN4VGdiNDU2cU9iU1ZMUTNudHFoTWhS?=
 =?utf-8?B?YjNBSWZYdjFsaEpHOFREYWxoYWxPOFVvQWpXcXZsYUFnT2RVY2tnNy9mM3RS?=
 =?utf-8?B?cjVTMGRDWW5SUW94MklsMlRJWFRMN3NWS1M3SFVIdlNob0k1S05lcnI0cUMz?=
 =?utf-8?B?R1VURTJtSW4rV09DV1FpdWY3Q2hWeFRUUWhqbllBY2NCRTFRM0t6bkVTeUxs?=
 =?utf-8?B?M3pITHJGcTMzZWlCN1FxWWZua3lZVFVaaDg1UzNkeXMyeU5GY0wvYzhQSSts?=
 =?utf-8?B?eDNLcERhbm9jT3kxOWlHUkpkQkhtbHB2czJycG4yZVZQUDBYMFlYL1QvaFFI?=
 =?utf-8?B?M1BEOXhFWWpyTUZlNnRwOXdadDdpbDQzWTVFQklPcElQNCt0UjJ0WTlhSmk4?=
 =?utf-8?B?b3lZc3didzNmSE1TdFpRK1N1SVZJdEllOFdWRlRzZ0FEWnRuVWk0SUxDTnZ4?=
 =?utf-8?B?UWQ5RGFwbytaRnlaSE5FdGhzTlhEdU9ZZUVpcEp6OHRTV05vSU9aenVzaGNo?=
 =?utf-8?B?MFRHTzdUYUlIdlV2SGxrMURyS1RRTzBGNXUrRjFFZjZybGdJY1JKLzUyQnRK?=
 =?utf-8?B?MXJkRVdWNzNsQXkzV3RBQ0JNbTFhYmNvSDVpOG0zeCtJNWdKVmNZVTVtVTFp?=
 =?utf-8?B?RVYxcVdzUGpPZ1ZYeGIvNURQZkxIQ1ZFT0FacDMvUlZFR1Zwem1aSEd6aGJw?=
 =?utf-8?B?TU9LemNrbkhuOXIxdS9IZW0rcVVtSGtMU2R5QVBFRzc1WWRKRnFaT0dEbVlK?=
 =?utf-8?B?bnloM1RFemo5WFBjOEJuZnY1THBoTFlQYXpWNnJQYXM0WWh1NklZc01uSHg4?=
 =?utf-8?B?dTlKcjJoS2tBUmhZdlI5TzR6bjExaDlrREQ0RHJ2cVhwZVpvaWRNMXNBbFdl?=
 =?utf-8?B?bUNMTDFudzI3Z3I4RGw2cXdLd1ZDRDcyQnA2MVZTRGJlUS8wQUVpWFR2VjVL?=
 =?utf-8?B?TWxSek9EQU0yUndSOTN5emdJcmVrbGZHUEoveWx2NUxyQzdTaFduTzB4cXZq?=
 =?utf-8?B?TUptTU8xRDE5alRvcEMyZFJQUDFmWFh3bC9EeHhBeFZSV3lQbzVnTUtSWXZR?=
 =?utf-8?Q?uy1w=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 3234918d-9d11-4223-57a1-08d9d3abac6b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2022 20:07:33.6782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCvCsnNBmKkchKJLDtxEokZxxtuxn8z63eC2lP7txeiRmIe+mg8LMYfBqPmARox/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2022-01-09 14:02, Andy Shevchenko wrote:
> On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
>>
>> The approximation caused by integer divisions can be costly on smaller
>> scale values since the decimal part is significant compared to the
>> integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
>> cases to maintain accuracy.
> 

...

> ...
> 
>> +               rem2 = *val % (int)tmp;
>> +               *val = *val / (int)tmp;
>> +
>> +               *val2 = rem / (int)tmp;
> 
> Hmm... You divide s64 by 10^9, which means that the maximum value can
> be ~10^10 / 2 (because 2^64-1 ~= 10^19), but this _might_ be bigger
> than 'int' can hold. Can you confirm that tmp can't be so big?
> 

If tmp is so big that it does not fit in 32-bits, that is indeed a
problem, and it means that the scale has overflowed. However, the
problem with the scale overflowing very much existed prior to this
series. Doing something about that overflow is not strictly related
to improving the accuracy for small scale factors.

Cheers,
Peter
