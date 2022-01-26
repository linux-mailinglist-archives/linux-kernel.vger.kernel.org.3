Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E748149C9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbiAZMfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:35:17 -0500
Received: from mail-eopbgr50119.outbound.protection.outlook.com ([40.107.5.119]:14006
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241367AbiAZMfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:35:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzuI5hh04UKz2eTgbhCRdzx3swrylSBI32aw/XQOIwE6lg03zhaHryx9E/tFMOPqfdCPRNnUseytcI+9fk5zV8b4k+m7Sz9/evLUw3l/9HIizobYO64CN9e3gaUajljd+2KRnC8lY0pAim8xfge+PK8iSTi4WRqnjVlaujEGsK6xYMtUMl2hWEij1+gIvklwo+znRNIOdlin/wklCIR+zaOgXrZ/q0sIjev6Usg1/uywTuq47rLyQzYyc5vRpuInzHI2mbBn5RQI+UqzSlmeniqgFzH61MtfeONLlbVjXjzOG4Z9wtAspPGDFQYllW28w4ExqA7BSOQslgYyszipoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyP6y87hsWzBEoJYzrvyLvZzX8V8+oPmVjtb+DCtAb8=;
 b=FhfDJkPnEWcRuFbUv0DdI7WbhHA6P6QEmZcINfavdFX9RRbeSiMCUhjCkzk24VzTl1LBcvaGBu+kfOKpAmVRcAGAsFMnTRM1Up301pZpLHZqoCu2umfrxfj2zTIuwedQLa+U3VrWTFI31QQWcOjUBk8SQeVhkMpmxvEsyFUIjviGJlXuAV7tO+BMwLK+jFZm6s5/yfWhCP8LDOpKgyW/VqECcI0Q3x8rG3Rz6tSFa2ThYPp/1PmFXxkAEzjjNFZTZlWIjeMRV5SDjshGy0a+O5NLWQyIvIQhcAB5pjLPTlS0bu+p+qAG2vv+h6YIrL51p7qdHfJF0YU03GVOGVpOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyP6y87hsWzBEoJYzrvyLvZzX8V8+oPmVjtb+DCtAb8=;
 b=B/QKKE9YitMRqP9sAKldsVLL0ZBpnvLuf0B/Y2z7YHlfiiz9D7JJBx8lBwZotJKgUPLQQIZbijboykC2awkVEF7sqgUTda4Eg/fTIfbZZlbcMBTtMpliLcQKP7ZxDKY9EOsiKtwGyCQGrO3VR0RRBvLsdwAaMRjECGjg4TOHhhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by AS8PR02MB7351.eurprd02.prod.outlook.com (2603:10a6:20b:3f0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 26 Jan
 2022 12:35:13 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 12:35:12 +0000
Message-ID: <7ed2cdb9-0719-3535-9e0a-fd9d393f1cd8@axentia.se>
Date:   Wed, 26 Jan 2022 13:35:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Content-Language: sv-SE
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
 <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei> <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
 <Ye8Z6dS5cCji9LNQ@shaak> <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
 <b25932d7-91bc-27b4-ada9-8d5da1ef2ddf@axentia.se>
 <YfA+xFR0oh2ztDKv@smile.fi.intel.com>
 <34c121fa-2a3b-fb6b-f6d5-fc2be2a5c6b7@axentia.se>
 <YfE45cImAQpOeziT@smile.fi.intel.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <YfE45cImAQpOeziT@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0902CA0020.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::30) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff429d32-9516-4066-da12-08d9e0c84c36
X-MS-TrafficTypeDiagnostic: AS8PR02MB7351:EE_
X-Microsoft-Antispam-PRVS: <AS8PR02MB73513C3D6188E5EB91F8F4A9BC209@AS8PR02MB7351.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKp7eTxcj59Dg2vC0rYuVou6CSb5oihsQMK9/6Q3evFk5TEttHr37IDGKL7urd5XGfthNMcsuUhRW1TGddVbcH9vQChy7lkjIK5rLCfIw/7gv15xynJHTLfjPa13VoP86Yeys0ZIfSIcBKbeKyxme0sSlRBoW9lSUEY6y24hw5DYlbYLgraQloOLxZelOksI+5vZb9LgHH9YYG1rTqn5PD284UOg84fSFmXLRoqursfQebAxzZBLw623eJdK7pDKiWXKtH8RIR/7k7fnwOHum8syuEbWUeA2fY7xwRxgGZnjYfrL4Iu61F7pg/j3ONJFfDrBMM7FB5CnWVOXSdeHdvSu0QS9nDBM2kIsb+SVmNPHg10yqNLjc3OsitxDeK9V9lHC+IL1BihiMuvoIm805F8ka565ASJpQS61/a2M06MlCD57eQqbHfUtkQ/LeweXf4lcqst4ox9GgOsFpRQL8BWcNe4WiJESuGvheAdAJwAhciFhio9qgix5cY18RDbS/wjKgXDdS/N0TPtfHDRax6Q/c1BecwvOg/W46iZYFeT2zqGz8vEHT51KCCYohMO5C8JYXhwt3XdoFFkXKsh268UZjYT70WzfaPPVAtkxZKpQMxNQl71u24i+dWV0w6J2/dBWEQHfsEY0TGIjy7Mfs903k3YIzLi9+LRKk5n2L4qOXdX3etlgdjipaqk2dlqNtBEFk3VzoRVmU3sD5AZ3jFk6CjEaRvU90ns2FGw8BB5FPdtJN1K5rAD91iIpq2ym
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(39840400004)(396003)(2906002)(6486002)(2616005)(186003)(4326008)(31686004)(6916009)(5660300002)(66946007)(66556008)(508600001)(38100700002)(4744005)(36756003)(7416002)(36916002)(86362001)(8936002)(6512007)(31696002)(6666004)(54906003)(8676002)(53546011)(316002)(26005)(66476007)(6506007)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzVPS3FmeHBXcVQxZm1qZi93VVhDeGl4SzJsUHREZkdWTnM5aThZcEhLWWYx?=
 =?utf-8?B?YlFXMmxwOTBjWWQwOElnNnNiRFlaTUFWMmt1em1laU9CV3NraElJQTVLY2tz?=
 =?utf-8?B?eHA1Q0ZUT1RsakZOajhZTlZSdk1YVVpkbUdhRWN2QWVVT0VycXJabzBXejBm?=
 =?utf-8?B?MEZMcGo3Zmt0Z3BHQ084d1YzT2IyZmdkNGpTYVAvNHVwSlZPZnZRK2x5T2JV?=
 =?utf-8?B?VlBIWmQ4V0lFVkZ1blhuNnpPbm1rSm5xK1kvaG9SYmJrUGozeEpNSUM0a1g0?=
 =?utf-8?B?alVtRHYrUUIwSHpmQ3pGZTNqQjhZaFlUVGp1ZFpmOEtoSllidnFFaTdSUkVj?=
 =?utf-8?B?aUo1Zm5IT2ZPTU1EVEYwQnM2cWo3RUdaQ2ppRGpla0FFWTdJSGc3RTliZVNh?=
 =?utf-8?B?TlJXODB6aDNiTnNkMmI5M2VWRXNuejFNVDYrcmRScVoyR1VUbExMZGFwTzZO?=
 =?utf-8?B?Y1F0ak14QlE4NjlMcGpTUkJLL0hEUktMQS9FeGVTUmw0a09hTmVUS015OTc1?=
 =?utf-8?B?b2M3TTZuRDFCekxRa09IdjFtbTIyNy9MSFVKenpEdk5NS0srV2J5SmI1a3Vu?=
 =?utf-8?B?eEgxaVhNSFpWSkdRbzhhVjhodW5VVzdJeUNVYVpUd2JwV3lKOU53dlZoTUtN?=
 =?utf-8?B?bkRCZ1IwZXdNbTZrVUpXa0t6eUFqUXlVUCtyeE5aT1QvcXg4WWdkT3dPck1J?=
 =?utf-8?B?VXFoUjNtVSt1K0R4eDlINStCckxibFBvOFY0OG8vbEMrN05FaGpYcm13QjJz?=
 =?utf-8?B?ZXJ3Z0MzTnlMQkVQblZFL2JMOWRUZzlsQzRFdnNma3RKSU1jZzlKNnZMeExZ?=
 =?utf-8?B?SXBYWFFTOVZpYmowa2dlZUYyS05tQTVQOWJwYWo1N0VaMFRPZ1duRC8wMFB5?=
 =?utf-8?B?VHRIRkcvdGRBNHdvMWMxVXV2UVBQejR2OEcyKy94NE9LcnhnUGhRSE93Y3hm?=
 =?utf-8?B?WGhVU3B2eHhEcnFGNkR4d2h0czFMRU9HNUdpT2drYTkxM016ME1jSnVKQ0pE?=
 =?utf-8?B?aGhRVExFNnl2Myt5WlF2RE1KT0dUbUREVjZWS2hINFo5REZZdjFmVVF3OUE2?=
 =?utf-8?B?WHpWNllrZFlEYkhoSzFCZXFzZS8wT3IzWXNTSitzejNtVnZSSUVKOTdWNGQ1?=
 =?utf-8?B?T2twUUREQkhleTIwT0gzTncvcUVIM3Zncm1sTTBmY2xGRTlNQWo3OE53eDlk?=
 =?utf-8?B?QS9RYXdYSFFZRkpPNDNtTVIxRml6WnhYZGlva0pIUWRkSzBRTkxOTC94Q1FN?=
 =?utf-8?B?SElpRHRvWUZZbHpQSEhYUmcyRXlZQzJnT3A0YUZjT0ZJeFp3TlNlWnM5RW9t?=
 =?utf-8?B?QVFYSzVHc05uVVd6ck5KTUNON2FYcTRuWllldFJCNjIwZm9ZZnAyQWNCTXZq?=
 =?utf-8?B?NWdJd3NlMGpKSHcvdTNpWE1PNHBCbU0rSDMzN3lJSHM2dzJTYnl2eHBiL0pw?=
 =?utf-8?B?Q042MGRRMFJjbzFIelRPS1lSSE14em1nei9OdTlQUkIvMElWN2oxaTJnSXBp?=
 =?utf-8?B?K2V0UWFpSGxabXVNYUVIbVEzLyt6Z3FuaVplKyt4Z04wZUNVQndjbVNERDNp?=
 =?utf-8?B?N3hORnJyaWxEMFV5dW8zV0VyQ0toQ2RWZVZreVVxNmMxVHlkWkNidldYbTkr?=
 =?utf-8?B?R2dXM2pMekJPaDNweHNiTXhSOXAyT200TGhzQnkrU0Z3bDgzQjJ4YzdnN1Nh?=
 =?utf-8?B?NDJxd0drVFFMckZDMm1mQUJXL1hJT1p4bGUyb0h0cmFGNUFtRkZrOU92eXZQ?=
 =?utf-8?B?Yk0wMkg3MkdYMzZ1aFBlYk9IM01qNkx6OHB0RFI4Ky8wbFhzcVNiQTlqK2I3?=
 =?utf-8?B?QU5qdXlaWUdWZ0ZxUzRjQ2c0NXV2enZIQjJxRXdzL2ltS2VXek14dzRnSjRC?=
 =?utf-8?B?ZnpZQXhkMER0QStKQ0RPV1J5dU5rTnBXS2VWcW05TjNNMjZWQmR5OUpGdDFC?=
 =?utf-8?B?SFFldTdiVWp1eTFqV1FpVTFDeFJqN0t2N29DeWpwK3gvMXRPTDdhL2pNYkVP?=
 =?utf-8?B?bHJ1Zkc5VGJMVExLU0lSai8yVkdLWm5kcVZDQ083Zm9pWEhnSW0za2kzWmNH?=
 =?utf-8?B?NllDRXVxbnBCYjF3aDBoZENVWmpXQy9sWGZBMG9BSktLWTZRc0pROFJOUnI0?=
 =?utf-8?Q?jaVY=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ff429d32-9516-4066-da12-08d9e0c84c36
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 12:35:12.8411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RhWWz7mcRHQEhrs4AHFnEnqOPBKsBgmOUEyG0revPpZZifxWQ/TeEnzmQh8Vh+v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7351
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-26 13:04, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 11:26:50AM +0100, Peter Rosin wrote:
>> It's easy to both remove and to add back "the bigger object". I just
>> don't see the point of the churn. Technically you can probably rearrange
>> stuff in probe and remove the 2nd argument to ->props() altogether and
>> chase pointers from the dev object instead. I don't see the point of
>> that either. It doesn't really make things simpler, it doesn't really
>> make things easier to read. To me, it's just pointless churn.
> 
> Since you still haven't got a point the conclusions are wrong.
> The point is (I dunno how more clear to make it) is to have proper
> layering from the (current) design perspective.

I think got the gist of it. I simply do not agree with your conclusion
about what the "proper layering" should be.

Cheers,
Peter
