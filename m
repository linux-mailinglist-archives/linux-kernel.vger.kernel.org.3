Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354C349E02C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbiA0LD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:03:58 -0500
Received: from mail-vi1eur05on2139.outbound.protection.outlook.com ([40.107.21.139]:53729
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239925AbiA0LD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:03:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJWQBxNN9R2vbK5xhFRBbpIvaqsoEun3wQwIWVjR8fVawWVsfoWWYiA1nM8XZ/hZ3T97zEk0UFSJI6olOysVuUZDV9ybnswCzB/nEkd7nlQHAyjbpeu/OnvBYjGHdi7HW3GMoszEosAsS8iKvtT85EvCFIjYO8/fxDHMj2IaNqhKScv1ObuxVYFCY1QWRPlg0cPRs0QjkZFHrVH+fAC3QMlzp21I4j0imMfoNEm+ZrwiMNXCEluoJbWq4u4Kb+8ojG4R20NZBxG4a7/9EjpR+Kgs+/A8umVKudowN/94xL4ofX8dP5x1V54NsA26JcfoYcHlJuk4GkbZSDr2a+hPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kniZiFU0jvklVFNiowRlco/Q/Q0/xf6THN+Zxdp5OI=;
 b=gkYQkITNBkDKsFrX1NLLQhl4fyziIcT7UAfgleznMHBKdCnbaZIY6i01Fj4yIM8bPiT/B+cQjurmHacpxJXWF6NWRRUyn0AzgzjROghKyqX7SkXE69NbBqjg+ufeEvabeGOkDjhPGiewDZckuDcZ2smbu+c8K9Wn/HH9itEiw+ZX/TXJ9gOcxp+RtqFhnM+74lXw6I+CXTgHZbXb9wKesJkLdAU96n0uJrPVtQFIUhptqAlK5pcuDXjXD07zZmfWjt9Sa3TlrzrwpoNiFzVS2VbwAVUWIFYV8pnObzGGprmHuBkzNVjQlgxuj0nzy5aXR6GHAkenCTCn6/eue/sMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kniZiFU0jvklVFNiowRlco/Q/Q0/xf6THN+Zxdp5OI=;
 b=hTeQ6PWmLrMUH6rxJNL+F4IW+R0tqUu+1YvwLMVYnD4bCFvut6CmRI/RCAiCFrEiYS9l8ikPCYp07DfjnVxWsKf5blOB/+VUbTCNN0HSDhI+3Sl4zA06ffyBDbIGXd0Iea2dKFoQD25pETEnXF/BJ5XE4K9aJgCq/QkPB+bWeus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by VI1PR02MB6366.eurprd02.prod.outlook.com (2603:10a6:800:17e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 11:03:54 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 11:03:53 +0000
Message-ID: <7bae39d5-7a38-ebdd-074a-6c140dc3a519@axentia.se>
Date:   Thu, 27 Jan 2022 12:03:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Content-Language: en-US
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
References: <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei> <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
 <Ye8Z6dS5cCji9LNQ@shaak> <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
 <b25932d7-91bc-27b4-ada9-8d5da1ef2ddf@axentia.se>
 <YfA+xFR0oh2ztDKv@smile.fi.intel.com>
 <34c121fa-2a3b-fb6b-f6d5-fc2be2a5c6b7@axentia.se>
 <YfE45cImAQpOeziT@smile.fi.intel.com>
 <7ed2cdb9-0719-3535-9e0a-fd9d393f1cd8@axentia.se>
 <YfFGLjeAEWfAAUWc@smile.fi.intel.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <YfFGLjeAEWfAAUWc@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0301CA0018.eurprd03.prod.outlook.com
 (2603:10a6:3:76::28) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee5d9c68-dda3-4e54-f4d1-08d9e184b4d0
X-MS-TrafficTypeDiagnostic: VI1PR02MB6366:EE_
X-Microsoft-Antispam-PRVS: <VI1PR02MB6366885DCAE7DD6E35E73BB2BC219@VI1PR02MB6366.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: il+RdZ3GNJe9tH5K0QEy3GCltnBGsaZbKdN3o4wP89/RH87KTlohtHlSkCIPF5PDnaR5uz6zIG4BwFg6ZDkftE4PSDkSWgRfp0SqieULxMg+Ut2YI72IkUun9Xw/KB0xc8GLrli+VDUYHDV+hh2igTppqykEAMAMFfg+6ob63iBxYzy6W2UVa47DElhbDSt/Te+SWE2kGtnD+ja6857RAOjpimT4xoE97UZ6q3l1aqZyrNcHvJrbpOUAkOyjnYwGQoSSzEOp0XurKpGf7EyN6Sw7faURbU555QLLGNsUzK1k01u+Y+RSZVPpl/0MnLf9xxdMpdhLHcHgQmHeIQRewpUQZRwO+lC0XkDfluE6ZyFvWJClA8EVIle/WXXbeY+DcQZtX7cANlKqBovWtpyKnoj7kkt+pEHsEUv1Ti3UkxAlU8rj0lx1SXL26OuhoeMINCbCkVVO6+uCs20D2eb64G57ZpFwV97XpP46BHbY8zD9lzwTvT3VWMQR3lLqcb4ab/pRnhfHaiS7golJ/jRqUVMqFnWQaLMuyN52fJimxO0QtwspbKS4x1u2jy6QTGZlXvG6cZUn2zvj14cIP/dIsJmnvZ0mpLwQP9KgQW6XTxu3rErQ21m9+8msueerQMvKO+ZIQGphEU63Y5p+kRMFz112pbXkltu6N3H39qj1i89bpmVddtX2eWkmlKZGOyVOkHC5UNTnzldRxrjs9StYFoXnTupFIw9iBoPcSNGvPaw7ikf9HTrcSt5mUXQtOev+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(366004)(396003)(39830400003)(136003)(376002)(38100700002)(186003)(26005)(316002)(6486002)(8676002)(6916009)(66946007)(508600001)(4326008)(66476007)(66556008)(6512007)(8936002)(54906003)(7416002)(2906002)(36916002)(36756003)(31696002)(5660300002)(2616005)(6666004)(31686004)(53546011)(86362001)(6506007)(41533002)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJCeE54ZGJLRW4rQkJxRmtJT244SkUxaENtNGxvTGFDUlgvZmt1WHdNdTF2?=
 =?utf-8?B?R3VDbUFRempMUS9rZURab3ZGTXFoY1VPeGJheXp6OGhUK2xRRzFoZlRITVNj?=
 =?utf-8?B?U0w3SnZIUDRQbTNSMHZzLytiM00rVWljcmJuRWJienB5bG56eXBuZVB5SlhB?=
 =?utf-8?B?cWp6Z1dJQllUZUpJTnpqQ2ZjSmZaNjN0K2ZFMldYL0E2QzB4dnhKQjhmZEEy?=
 =?utf-8?B?bEtwdW4xdHNad1cyM2EyTm9SRUliaVB4MXhWMHFtcXMwRmE1VTJEaGEwYmhV?=
 =?utf-8?B?dWpncDdmQTNhOEVmSk5zMUJIUWM3b3hjM3RmTitZaGg1WkFpRjc1YnQ3WlpW?=
 =?utf-8?B?NzlpUXk2WUQrVGdESkdXakp5akRmMXlMWnZ4aFRWZ25SQWRuVy9tSXg0KzUy?=
 =?utf-8?B?ejdmV3FpcUU4T2hVWGIzQXNGVXBWUEFPcFdpTUtZUVlqeXBFeHdZanU3aFBp?=
 =?utf-8?B?WE1nT1p4M3g0N0R3elEyVUVLdWxyRHM1TkVsOU9mVm5lRXFSVXZETm1VNHZW?=
 =?utf-8?B?amplK0VRSndSZnRWelNGU0F0ZG44bzdVNlRVeFU3VUptbHBmbW51VDFRZ3F3?=
 =?utf-8?B?YlY5WVBSSnlGaVlCTWFJV2Z3TGV4bGgzbjZ2MTU3RzJrWkxjL0Qramg5TEtz?=
 =?utf-8?B?NDJxeC8yT05OR2sycld0aS9BM2lJSzN2bm5zemF5c0RRQjNGWGNXT00vYUNK?=
 =?utf-8?B?Q3BWeERpdUQ4NDBqOGZvNGowczJRcTdPNUYyazluenJrcDFIMHlBOWdHYUUv?=
 =?utf-8?B?Y2JidStUODdsWlpCK3JmWmpvckduaWY5K1VRbmNUVksybFhHcWE5c2NTT3pz?=
 =?utf-8?B?RkEyOUhZUW56aHlKRGVJMkJCZU9WV2pPaS9HY3dpUDVVMU8vZE1ML0VGNTZG?=
 =?utf-8?B?TVpvUFd6RVdPaVBSVmplcTQ0VDJ3Um13SXJ3bXRzOVF4TU1NU0dxRFBwd3gy?=
 =?utf-8?B?VGNMaUdLS1BraTRNRlpaL093c1pLUWpISzIrZGQ4aGhrNDFYZCtCZit0aVV6?=
 =?utf-8?B?VEtvZkNDeVQzak40VmNqMzNDeWo3cy9PNWNjWUM2bjdXc1pwY2x5REVkRkQ2?=
 =?utf-8?B?dFJCd2cxTDE0OXl6VDhEazZ2RWVKZzRsQXYxd1B1VklRbVc3ZzRleDRXV25U?=
 =?utf-8?B?cjlpV3VncHMvaU1oRU5LOHA4VEhCZHJqTEZWd0F5Z1R2UkNkbk9GUndTNEQz?=
 =?utf-8?B?QXhuQW8wc2JZSThVUFBvTkVyamd4VGZvWUxWUlppZHBqSGFNNE9IcmVTODIz?=
 =?utf-8?B?elNubnRPTElZTFNHSG1iWGNaVG0rVkx0N21DSm9xZ3dTOVNoMUJTTHdGQ0Rq?=
 =?utf-8?B?VzVkQ3dncVlNSFVra1RtZ2ZBblFhcEIwQ09kNHUvTENLb0R0a0lWRndRRHZu?=
 =?utf-8?B?bEF3UmZma2pkQmF2dzNXR0FwYTM1dmlkaUc1T01mc1hKVXY4RVU3WnhhOWtm?=
 =?utf-8?B?NDZiZDVuTFRqd0hIa1dVdHRseEkza3NtQzk4WWtzMG1ZQTQwdDcwRGhtVEtt?=
 =?utf-8?B?aUhpYm00UlUva01od1FnTGYyOG5RM1RRbndWanRueXphNVE0YmFycFFGYzJX?=
 =?utf-8?B?cjVFTUd3bnl3Q0k3M2R2dzZkQTg1Tm9oM0F3clpKTmVVUytZbmNKM2FvVk5x?=
 =?utf-8?B?VnNLWHdmWlFCamFaVmg4OU43UGRjdEhBS1hGZllzb3JnUi81MndCT2kwdjc5?=
 =?utf-8?B?Rm5RcFVua3U0QmYwS0hxQ2JMem1jdWd2R1VNdTNxdFBFMEJSclJ0MFZsdS9i?=
 =?utf-8?B?eCtzUGZrRzZ4Q0MyZkVJUStIREtpbUlVSUFnWENaV3R4NlkvNHRmamw5SE95?=
 =?utf-8?B?MmFRdUJoWEE2QkN0YjNiak9DQ28vcW1oNU14NlZ1a3hUWkkrVmcxQzAwZU1X?=
 =?utf-8?B?VVAzTytjT0ViSGEyaEpVblR6Y0RleXRuS3ZJS3lUcWhzODRzZG1uZExoUm82?=
 =?utf-8?B?SDMzUW9ucDZYWmxyUk9OWjRNME12WkZzMHg0U0czQmp3ZHBlZmFaMEVvUS9s?=
 =?utf-8?B?ajlxS3kvOC9xTDJFN21aUW85dzhKVk9Dc0F6bkQ0bDE0Ni9IQXZJd0tnNEJT?=
 =?utf-8?B?b0NFdUJTajNrTzFmQUlJeHFwa2F2cXV5cUJGQkxqZGpESkNmbnJlblMrWFBI?=
 =?utf-8?Q?zuDk=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5d9c68-dda3-4e54-f4d1-08d9e184b4d0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 11:03:53.8286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzxyrYZj1BOGrB8BZkdoWGuEMoSA3vuMLFK/y8LdEJ2pc4a0IWyP2yOM5xd/pbZu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6366
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-26 14:01, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 01:35:09PM +0100, Peter Rosin wrote:
>> On 2022-01-26 13:04, Andy Shevchenko wrote:
>>> On Wed, Jan 26, 2022 at 11:26:50AM +0100, Peter Rosin wrote:
>>>> It's easy to both remove and to add back "the bigger object". I just
>>>> don't see the point of the churn. Technically you can probably rearrange
>>>> stuff in probe and remove the 2nd argument to ->props() altogether and
>>>> chase pointers from the dev object instead. I don't see the point of
>>>> that either. It doesn't really make things simpler, it doesn't really
>>>> make things easier to read. To me, it's just pointless churn.
>>>
>>> Since you still haven't got a point the conclusions are wrong.
>>> The point is (I dunno how more clear to make it) is to have proper
>>> layering from the (current) design perspective.
>>
>> I think got the gist of it. I simply do not agree with your conclusion
>> about what the "proper layering" should be.
> 
> And I see no real argument against it. With the patch applied I see
> a better structure of the code and exactly necessary data to be passed
> to the method. Which makes me think that current implementation is
> either a leftover or was something like "let's take a bigger object
> _just in case_", which I can't take as a proper layering.

The bigger object, or the one and only object as the current code is
written, is given to ->props() by design.

BTW, you don't seem to understand the ->props() functions. There is no
data "passed to" the ->props() functions. These functions instead fill
in properties. Currently this boils down to the scaling fraction, but I
can imagine other properties.

On 2022-01-25 19:17, Andy Shevchenko wrote:
>                              The bigger object would be needed
> in case of using data that is not fraction. Either way it would
> be easy to add a container_of() than supply unneeded data to
> the method.

You argued that it is easy to "break out" to the bigger object in case
it's needed. Which in my book is a sign of poor layering.
It's way easier to *not* change things, it's perfectly fine as-is.

The argument against making the change you propose is that it does not
make this small driver any easier to understand. It would still just
change things for the sake of changing them, and I do not see the point
of erasing the existing future-proofing when it has no cost.

To sum up, I'm ok with introducing fract_s32 in this driver, but I
don't agree with the signature change of ->props().

Cheers,
Peter
