Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178D249C779
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbiAZK1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:27:06 -0500
Received: from mail-db8eur05on2134.outbound.protection.outlook.com ([40.107.20.134]:11873
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239896AbiAZK07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:26:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdFx7yY6oI8zQ7ksmcsxeWMqZ62v2L+CETrB56g4672dc0eGGtwF+l6eJ39Ne+hPk18qi3bff16ZOpRK4TYS2fPfFpgal24MLHOh3R6tv2KS9isLP6rPX3oOh8RSiKBlqyfU2j1bWqAKXeiqskT8S3A4M3DZ/7PGO0FDrzoKedYwUSy5RDmt1zsW79Qw1bBv0k8pucU0xGTtE2nLFaOmwoKlbUPMd0Q84oIm2/168kna0StHgFqZldCuiqhjyxGgwouJ51iL9iGcoE85iW6aFt7tApGl+Y5MHvd8hM3zKk6MWjBpxIWuR+2Gg0pwjrblwYyJjBmfj9vvFfAVdiVafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3hR5Vd35isX9atuoR2KoklCdc3LjNhEmxO0egPmPX4=;
 b=eqMJyE/me0L0WEjf5xffP1ql5cfmxX70Bm8ppJAv7qq5YFteffxZqJh7nd4QbSf2k9TtVDS6ORrYVAQ9DRX1d/sDaOyEyomRYDs1vk/pUV0fxX/NaV5rD/R0StbcfrfzdEHvYOBfMCKwah5iRYK7EUzaUMEqmisRSQPKAmK2TY+IC8FaEMnGXP4YZNnzYjkZFYqM6PLltsVFYO2/ayWsDFgjUJms13wPnetOG/lUJJmoBX1wBtcONJitIydG8/ujv92Zs4KxGdSQQPH6KRG23wRgFhas1Pc4se3aeZMcOLbhLc7H8/6E+AS0tH0eGJvxZx5iEHEjaPLfvu86UJilnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3hR5Vd35isX9atuoR2KoklCdc3LjNhEmxO0egPmPX4=;
 b=Yc4sd/kJlSymHIcWC1qMvs9dMYshZHOYEoDE2U3Z5yESA10ji09FvpHYiBl2EQJFUWF8Xw1I/yWEwVQP7HG9g97QKWYC4NM2njhKC06UkSMtEdFf5CPaghbGEIU5bZCCrtENWP9TMK8ffL6nhMpsk3kVjxONh3cC94Qnwiesvl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by AM7PR02MB5942.eurprd02.prod.outlook.com (2603:10a6:20b:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 10:26:55 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 10:26:54 +0000
Message-ID: <34c121fa-2a3b-fb6b-f6d5-fc2be2a5c6b7@axentia.se>
Date:   Wed, 26 Jan 2022 11:26:50 +0100
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
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <YfA+xFR0oh2ztDKv@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR06CA0150.eurprd06.prod.outlook.com
 (2603:10a6:7:16::37) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 268b02ad-6eaf-40bf-5e74-08d9e0b65fbc
X-MS-TrafficTypeDiagnostic: AM7PR02MB5942:EE_
X-Microsoft-Antispam-PRVS: <AM7PR02MB5942BA0DCCC922810CCF2A6DBC209@AM7PR02MB5942.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dma28q4NIV2d/0bF/UngLP1Xn3REb/Wira/QkKOctJwi43r2REj0gS2iO6V9QS104OWXkdTUUnbb5+Zex5/qvlRr6ZDM7JJhcUT4LtYlSsMC9S4KZksEQIyGy4MRwliEizc0W2yuXcqCEfU0lTbddxQ7Qa+jSBQ17dNT4crQcnyCq6ZGv++cGcATcrlTTEy6kWyUnmie/uqTTq8Gid3xWysti3nzwj20J1dVT3D25nC5FGblVKyPl9krlKGeke+8ddXVWIB+bJJS1oIqnNE8cXuxcgwy2MineN1Am9fKk3I9ssCaQV5/ke6Qo0r0hAWd7yUMmglzoEHYszy0aRplk8IKbklfjQNhQm/TZAomUIygbWlgmyX+9UIK0AGPuhZjCdOzHLJ360UfOc7p8o3s+UpYTsqjrjLbIQDWIj1BTuFEKuDteUae6TOwMQ8N6ELqq2BJMkPixBV6///J5FqEyhVy1NY4ZdXXQkxVwE/VtsFzyNzm4rtpCcnMVzHglHUpg7TfADsvBC5DtilqFKM3CgNOepuqAxd8962emmC0pbV/XTaykZTuRwh6wGkRzw0tFB8gxr86XROb+HNNEtitsQGw6f8KOXKIhqvTMkA2lr2+VCHPLVuFrwjMJyt8ltnBaYH/opFRmU1dSFmOQsKLzoi82i6fqm8eH3ZAR0lKYFlJbZYwNsYlVqxz7A5KcglDmx8f5KjzUtb9cZ/2GiVpdwf68In0HDQsmRKmojyZ9qUNCbVZypF9EZE6xmXdsiZx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(39830400003)(136003)(396003)(376002)(366004)(6506007)(6512007)(6666004)(86362001)(54906003)(316002)(31696002)(6486002)(53546011)(6916009)(36916002)(508600001)(83380400001)(8676002)(66476007)(66946007)(2616005)(186003)(26005)(38100700002)(66556008)(31686004)(36756003)(8936002)(5660300002)(2906002)(7416002)(4326008)(41533002)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGMzWG1mUUNISFlyY2xNRXR1RjQ5eTgzNEJOSmZ3YjJKcjNtSjM2T2lWUitn?=
 =?utf-8?B?SGZ2ZzRDTEVQOEE0OGdLcWx0V3NBWG5IWis2RXJ1WkhmTGszZWhVMDg5Q0ZD?=
 =?utf-8?B?dzgxK2JzeWsxMEdMeEtiYjluVTZBeFZPZkV6a1VpU1gxNWtsaytaM2hZdkJI?=
 =?utf-8?B?YWtVYmVRSndJRW1IK0NYZlpYUjV5R1hYSXlCZEZGc0ptYU4wUFp1MXNOSzVw?=
 =?utf-8?B?SHc5a0Vma2FUemFiWDhObXV0bTM0MWJFdmhPVDNpK2FxeFUrTkl6TUpYeWxH?=
 =?utf-8?B?bFdOSHdIc29oMklReE1MdDNVT2p1VW8vUG5lN2E3aTdmb1kxNFFNcGRWdHo4?=
 =?utf-8?B?V09xRXExd083WmVrVDdSTTdQZ1BlMFAzcXRQc1grbThkSGhwTjlCK2ZZV1hy?=
 =?utf-8?B?WXVpaFJ2dXhMNGdtTjhFd2JHUHBXM1hoa1FZUlI1Mnczd3J2ZlNFcTZrcEcv?=
 =?utf-8?B?ZW1tKzNmTHZIMHdyRHU4ZUk1MmVjdFBRakZIQ2hKL2srdFNWWk1XSzBJTENP?=
 =?utf-8?B?SkwyZytHdDF3TzZiaDBmYVRlOTNuTTdSaFdIbzRaczZoVkx5SlhyN1F3TE9V?=
 =?utf-8?B?TERGNjVWeDFVTTZERThIdlRhODI1ZlFtajZTNkpzWW9DSGZWaEVOLzJsZ1JU?=
 =?utf-8?B?TkV6UmswQmJSa2tvaDFHY3BuVDVkR0ZTcU12U2NyNFF2Q3VLT3I5d3pOdFJP?=
 =?utf-8?B?SmJqOWdPQm9PRzBtRVA3TEpzRktpTjBMNGswNW1FZ1FhWjlMcHhKdEc5VHlP?=
 =?utf-8?B?MFBRc0U4TmxMMjZURkpyVjhyY3F4aUd5RCs2MXlOMTErdEp0ckpra2RFVVBO?=
 =?utf-8?B?bmNaR0oyUmhWeEZDS2REdS9PbTFBSkUwTGd2ZjNOb2J2YU93VC9rdVYzL25T?=
 =?utf-8?B?a1VLeE5ydVdNSG82aGVCTVMwa0JWYldFb3dmdHN2QW9PWXZQUmZOVytzNm1z?=
 =?utf-8?B?THRVODM2a1pqMXlaeDhsODdrelJIOTlZYzdNQVQ3TG1TNDlRVmZUUTVTV1ZB?=
 =?utf-8?B?dkpxSXdOSG5JdW5BV3BmSkRqc1JtV1RFWVNDZWNQa1VPUUpLYmxnUW52L2I4?=
 =?utf-8?B?cFU4cGQ5ZGRjMTVZNFpIZE1RT3lvUENjUXRLeEphZ21BQWszS0pLTll6MTVV?=
 =?utf-8?B?ZnVIS090Zkkya1puemlNTVZWKy8rWmtSN2w5QU9tbkRyb1RBdmQ3WmkyZUlm?=
 =?utf-8?B?N01ZVjlUSGk3M0hPL1VwcEdVR21kNlNSV2NTVDdJTFphS2NRVGxuU0hhNVhR?=
 =?utf-8?B?REVJRENDY1FMZjJ4d0R4cFdLQWV1ei9kaVE2VGxNV2RYZGZ1TGZnTG5qbzBL?=
 =?utf-8?B?NlJBQU1WVlovWkhNbG9wWVZRQy9wUzdwQ05mZG9NdTIyMGcvY2tINm5CR3FY?=
 =?utf-8?B?bC8zRmR6bnFndWxPdDhVZUwybkNuS1JEK1N6TnJuMFdTM3NxN01reFRkZ00z?=
 =?utf-8?B?UFFNZlBSbTlCNHdsRXZUVjdZWXB2bDRGV2E5dGNGU2RxMkN1TmZlQTh1U2JW?=
 =?utf-8?B?MUlMaThkOUR1ME1HQUliQjBVVWh4aGlzTURRbElXdHJMa3hOaGwzZUFWd2RT?=
 =?utf-8?B?ZzRwcDhSSHFnazg3TXJhR1lCR3lOaUdOQ21tOXFSTnZGcHB6bGF4a2dHeGFu?=
 =?utf-8?B?a1dNbGVQb01QRUkrMXg3WkVxaXlwUjhtQWRxanVrWDl2Wm11NmU5UUNQSkdX?=
 =?utf-8?B?a3B0cVpOeTdxby9pT3g4dGZCQ1VxVlM0K3Z5Y3pXeXFDL1RyRnBiU2cwZnNw?=
 =?utf-8?B?WFowK0wvM2NrMkRRUmNJTzI0QzU5S1VUOUx5ZkRmaWpJekNzSmtjQklOUnZn?=
 =?utf-8?B?dmdhYlY0ZE83Mk1UbWZvdEQrUnM0MmtwSThqcCtGaEh4VU5id2M2ZVM5YkF2?=
 =?utf-8?B?cTc3eUdoK0FMS0ZxMHRPbVcyQ3d3czVCc1hWQzdIbVZ3MmhLaVV4TjZtMVNs?=
 =?utf-8?B?VWt1U3BxSVRNZWgyTkYxNnJCQ3Y5T0w2aUJPVWhINUJjb3c5MDhGdkRyREM5?=
 =?utf-8?B?WHVBTVhxRENQbFZNb3RJendlOUFRbVlVaFlxUkxYeEttOFJZcUtVTXFzVTV6?=
 =?utf-8?B?OVRQeU85TzVQaGU3V3BmekdGSHhNa3dzcXg2Vk9FbHV4QzRHVW5ZNmJVNWZG?=
 =?utf-8?Q?8Jiw=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 268b02ad-6eaf-40bf-5e74-08d9e0b65fbc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 10:26:54.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cE0xc48ZCw7xk2kMrcaCF7SX2KyIwa6oOe8Pj5g1uKKgJAMEjwk/dhaq8wEMSl4x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5942
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-25 19:17, Andy Shevchenko wrote:
> On Tue, Jan 25, 2022 at 03:54:07PM +0100, Peter Rosin wrote:
>> On 2022-01-25 14:17, Andy Shevchenko wrote:
>>> On Mon, Jan 24, 2022 at 04:28:09PM -0500, Liam Beguin wrote:
>>>> On Mon, Jan 24, 2022 at 05:18:32PM +0200, Andy Shevchenko wrote:
>>>>> On Sat, Jan 15, 2022 at 06:52:03PM +0000, Jonathan Cameron wrote:
>>>>>> On Mon, 10 Jan 2022 21:31:04 +0200
>>>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> ...
> 
>>>>>> I'm not totally sold on this series showing there is a strong case for
>>>>>> these macros so interested to hear what others think.
>>>>>
>>>>> So far no news :-)
>>>>
>>>> Like I mentioned briefly in the other thread[1], I don't really see the
>>>> advantage for the AFE driver given that it's almost just like renaming
>>>> the parameters.
>>>
>>> I tend to disagree, perhaps I wasn't so clear in my points.
>>>
>>> The change reveals that the layering can be improved. In OOP
>>> the object A which is inherited (or encapsulated as we see here)
>>> allows to clearly get what kind of data the methods are operating
>>> with / on. As you may see the two functions and the method
>>> declaration appears to have interest only in the fraction data
>>> for rescaling. The cleanup I consider helpful in the terms
>>> of layering and OOP.
> 
>> [Sorry for the delay, I have been far too busy for far too long]
> 
> Anyway, thanks for review! My answers below.
> 
>> While this is all true for the current set of front-ends, it is not
>> all that far-fetched to imagine some kind of future front-end that
>> requires some other parameter, such that the rescaling fraction is no
>> longer the only thing of interest. So, I have the feeling that changing
>> the type of the 2nd argument of the ->props functions to just the
>> fraction instead of the bigger object is conceptually wrong and
>> something that will later turn out to have been a bad idea.
> 
> How? Technically as I mentioned currently it's the case to use
> only the date from fraction. The bigger object would be needed
> in case of using data that is not fraction. Either way it would
> be easy to add a container_of() than supply unneeded data to
> the method.

It's easy to both remove and to add back "the bigger object". I just
don't see the point of the churn. Technically you can probably rearrange
stuff in probe and remove the 2nd argument to ->props() altogether and
chase pointers from the dev object instead. I don't see the point of
that either. It doesn't really make things simpler, it doesn't really
make things easier to read. To me, it's just pointless churn.

> 
> TL;DR: It makes possible not to mix bananas with wooden boxes.

Which is all good until you need to ship an apple in the box with the
bananas. (e.g. if you for some reason need the bananas to get ripe real
quick, apples produce ethylene)

> 
>> Regarding the new xyz_fract types, I have no strong opinion. But as
>> long as there are no helper functions for the new types, I see little
>> value in them. To me, they look mostly like something that newcomers
>> (and others) will not know about or expect, and it will just be
>> another thing that you have to look out for during review, to keep new
>> numerators/denominators from appearing and causing extra rounds of
>> review for something that is mostly a bikeshed issue.
>>
>> My guess is that many times where fractions are used, they are used
>> since fp math is not available. And that means that there will be a
>> lot of special handling and shortcuts done since various things about
>> accuracy and precision can be assumed. I think it will be hard to do
>> all that centrally and in a comprehensible way. But if it is done it
>> will of course also be possible to eliminate bugs since people may
>> have taken too many shortcuts. But simply changing to xyz_fract and
>> then not take it further than that will not change much.
> 
> I understand your point. I will provide a mult_fract() macro and
> apply it to AFE to show the usability of this. Would it work better?

In my experience, burying stuff in macros will make it harder to follow
what is really happening. Something that has proven hard as-is in this
driver. While reviewing the changes from Liam, I have repeatedly looked
up the various division variants to find out what they are actually
doing. Here, it's not the individual steps that are difficult. I feel
that if we start adding macros for fractions they will soon multiply and
I'm not really looking forward to also have a set of similar fraction
macros to juggle.

But sure, feel free to suggest something. But please hold until the
current work from Liam is merged. That series is clearly more
important, and I'm not really interested in neither adding more work for
him nor a cleanup of the current code without those pending changes.

Cheers,
Peter
