Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8056E46104F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349459AbhK2ImJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:42:09 -0500
Received: from mail-eopbgr150115.outbound.protection.outlook.com ([40.107.15.115]:19276
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231421AbhK2Ijy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:39:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPqySYUXnG82qiuHR6U/QSAydmjkuO+lnelfdSUamJ+aCs2Bmk3xCb109Yh3uL181gO+RCvOGxMRtqhP4cyDkVEIabKMJAnuw+lzoOQuANQUj3QF316R5x9/AFFnjEVN+pH+WsyLcgPDhNKugYFPh87Wixbl4OIEwmWJsPje9YTIWQn9rcU3C+q8s/c2TvpLAXZ/PsuHhCH+zWTLsm8sjsVuqwSWJaFS5FS1jg8rjt1+SRZ0gS6E07jJ5neUduk2Hrsqf37YGNbXXhSejdQ0qjZ4L08603WOk3wdUzTex+8S0AWo49+P+sm1FMVcTjs+xBLV8/s/5QNh1EkWQ8+g/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLts/NJ8yBDifhSgSFS5wokn70hFwca3mro39GlLFA8=;
 b=FGrVt9Qp+LdCwtLu3Ee56AhzOiv0l+WvWhNJaHWeD4Eolq53QT2V1cS+Ui8vFPFCHwbrTzm4BcOkIMsUI98e5muG0wQyxZAn4Dbrujdf44qyfV7L/2j/g3RsY5L/D2/h86APZmAnwt0PN6Ro1S/hGyOjnEp1F3SMy2YEhN+19n93VcQ1j917WIkdr1UYLngfmr1OeNBbW5qedtSg62BgQZWfKniJsqsCqBCEcL8VmCKkNMAUotSkNu6Zt77nMTsMsmP18/PJx5U0dGxN6dNxoYx7D69yOLA6X4TCS9PUGxt8s3fyJBqD8Wn3LbPBe0c/2Y2RDdHCt13i4MHsXDjp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLts/NJ8yBDifhSgSFS5wokn70hFwca3mro39GlLFA8=;
 b=PNt1xz1IXBlip/zq6zxh6xbcPP7CRY1vwOj043mC4WOwJTAJq+NeQ+vxO1l5IIA72Oza/5k2e7gpKKvRdI8AAbBGUSOcwYHSfDO4HM2F2BmCW2qbiNrqFDDAUfW2Ty8ZrBZ3FXuq45P5812T0R8w3Jd7E1OWOIzT10OiCrriYbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB5097.eurprd02.prod.outlook.com (2603:10a6:10:7f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 08:36:34 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 08:36:34 +0000
Message-ID: <cadace04-0f7d-c1c0-0cc9-88ac16184a49@axentia.se>
Date:   Mon, 29 Nov 2021 09:36:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v3 3/4] mux: Add support for reading mux enable state
 from DT
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20211123081222.27979-1-a-govindraju@ti.com>
 <20211123081222.27979-4-a-govindraju@ti.com>
 <5a530528-27a9-f5c8-abd4-025897a1c197@axentia.se>
 <48156e28-4ef9-ce3a-bff6-c104a94bb869@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <48156e28-4ef9-ce3a-bff6-c104a94bb869@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0063.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:15::14) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by OL1P279CA0063.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 08:36:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa9eef91-8d56-490b-48c7-08d9b31359da
X-MS-TrafficTypeDiagnostic: DB7PR02MB5097:
X-Microsoft-Antispam-PRVS: <DB7PR02MB509701F77A530A9B7BCD1F64BC669@DB7PR02MB5097.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CszZAfct8XxHMIWvc5s1+D0eyNWnnJO3h8ME2xyCfyKSkSzt4E3buaTQN1hcPFz5/GS9V+MblpIoJOn8SWE6yc4840Q30afZg/+gZiPjvRwcgvZ50XrbRPBsdV6bzRe3QASE212txsQQF6iTINt6BhUe9hhdZ7y0G/35KMdm4io1i4oPfS3z2A0VNpdb/JySqiSJYX7ETqAu68Tw3sqCbAqwbJne7ER4BsXX8sUJZotKpcmeGyPOlCJpk4S2j3CRm6nHXzbj6kJOQhkW/VoP7ItMHHbFgCbFC2eNhwfiLTzS8tL45qDPxlNV9ddhj8Nuvna55/P5k43CXFxcvxQ3cFeDEXlTjovZ5JZNqxCdM+p2NucHd/3RsdFuw70EAxhn3H067iL9I+AUPGX0A6pyh/KmFzOxyaldtDuFkxA7yncSopf0tMsMZPUYkSiuNsMjIfpt1+8gzANx3zECxo8HBAKJvSEFF6k33THJy9513kj/EX8NT8oJEFoT8GquNmSxFQyg5kYL/ycBjKNLGAirYqj2rcYnwoBKZI2agKnC2jNi9z6MTBIDTKCI9WQ6xhsGTNkLOwLYa7SdPVvBpllOaLUJeKJZl4kKfwuXLMPeq7HORo0SvQbqm65vNDuunjof/vcgg0TwVWZvkhlBYp/H2RUqHU2S0hfuU+A/EDdTlolT9phDTtgCVdNgHhK+2FjVftmqxQKWruMzE1dOO4NLve4GG/0xAtlopqmWLg5riGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39830400003)(136003)(366004)(376002)(6916009)(5660300002)(54906003)(16576012)(86362001)(6486002)(316002)(7416002)(38100700002)(31696002)(26005)(66946007)(508600001)(66556008)(66476007)(83380400001)(956004)(2906002)(36756003)(53546011)(8676002)(186003)(8936002)(2616005)(36916002)(4326008)(4001150100001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekdPaGl1YXFYUDQ0SXJCOHpCR2dDaHh5aWRZZ2g4ck96QXdTTnFlQnpwMUxw?=
 =?utf-8?B?enNkZTVRTmlUcXRQYk15UzZhM2s2ZWY4WXRlc1prRTZCUGJhVGZTUnRMT1BC?=
 =?utf-8?B?TEcwNm9wZ2dydzdENjhYY0pMOTFKYTljcXdla1pvRW55cjRiV0xwbVpoYjZm?=
 =?utf-8?B?c1cyOWpSRWJjUzdtbkVGSEkyMzVlM3hDQ2FqRURnNUgzelpaNjVHaS9mVFVv?=
 =?utf-8?B?UkNxeExOOEZSdFZJL29TR2hhSGgrUVB6TTNoRkplWXU4R0tnelQ3ZWxCb0Qv?=
 =?utf-8?B?bWdJc2FWTkNCbUUwdmlqMmJvQ2J1bE8xaFlyK2R0YUpMam5CRTdxVTVLT2FJ?=
 =?utf-8?B?TERaVExHZ0Y0Rjdoa0JDZlhSRXgxMlZGTXhvZm5Id2tEeHpKVVI5ek4wcDJq?=
 =?utf-8?B?RW5xc3FVYVdxcFJVM1E3bG4vNndiUTZIZ0lKRUFaWi9sN3lSUVJNVWxVMVN6?=
 =?utf-8?B?T1VmazZycyt1S2lKcTdqeXFVclgwbDhnQkp1V01jZkIvKzYxNW9BbEVFM3NW?=
 =?utf-8?B?WmRPVk5UVk54VjQwWU9ha3dmUGUvNHNwU1lnQU9LZFlQMUpsakJHdUhxVWZi?=
 =?utf-8?B?ZWFUL1g0eXhzcGJQNlhTdVlEcDJubDMyMnJJa0F3YkI1c09BV1pzMTJvajgr?=
 =?utf-8?B?cjdzTW5ZaUFzVnNsYW9kTjgvR1NsVVN6UmZhQUEwZ1lTS0ZzM1dtRkMzYXNh?=
 =?utf-8?B?OHBQNTBXcVVkMzhUcGR3cjMySVZXcHh0L2g0NTV0QmxDVkRzSGtrN0p6M1Zl?=
 =?utf-8?B?WW1qMTh6ajFBODUzQ2xRaHNvb1lDdnMySTRxRkRXbG5Hd0FZRjgrVnNWVjlU?=
 =?utf-8?B?Sk9SdisyS05ZYXZ0a3JVbmhPSjZQcjR5UUxTak1pdDVVdm1TWEsvZDUxS0d5?=
 =?utf-8?B?TWFqcG43c3RxVldqcWtIZmk0eU1uWE1xQTFxeTF6VGhnTWgwazZkdXFleDZM?=
 =?utf-8?B?L1p4ZWxXT0V0VGJ2WGhzRlRIalNEWG5PL0pCSm5kNCt4SmdZQUl4MWJodUln?=
 =?utf-8?B?eVNZK1YwTE5mQk9McUEyQ3BRWHV0bUVwUHVmUjRMRnpJWkdEUEs4b3lkb1F0?=
 =?utf-8?B?ekc5ZmFIRHRJMFBCOEVKbWk0VWVSaHNEMnhhWVR0ZEtlbGVEYVpkcU9YaFM2?=
 =?utf-8?B?WVFyZTZaTnRxRGJnMFdDa0NlSkFNU2s1dEovbUUvMHRRVVl1YmEzUk1MbDNp?=
 =?utf-8?B?YkhnWkJGMzBtb3hldHVKZ1NUTmFvSUV0L1ora2VTTFpmUzVoeDhOT2tkQnJi?=
 =?utf-8?B?dWJKNUtTU2NscFloa1VFL0t6Wjh3MXpoamRqSjh2ZjhERVdvc2FEQ2dBaWZl?=
 =?utf-8?B?WXo4RVlibzhpb2JjZE5iZ1gwLzhjVUNJaUt5THRIR0RrNlAvdHQ5NXVQcUwv?=
 =?utf-8?B?akdiZ2RBWGFRdHRYcGl1U2pwc0hwRFV2endEV0pWdWtrY1RlQWtJZVkwdjNJ?=
 =?utf-8?B?V0Y0OE9nUnhCNDFWTGl6NTRoM2pWaVZQMVdCQ2Z3UFlvZENDd1U3UDVpRURR?=
 =?utf-8?B?L0hPLzNPblFrTW5WeU1wQy9iZUc1S1VFUmo4MWJRZUZsdkdwdjFoWnI1Y0Jj?=
 =?utf-8?B?cGVUWW1BMVlzNjJoY3FsaTJxekI0SmY2aVArc0pJc1FuSHdEZnpRNDZETEZ3?=
 =?utf-8?B?Z1plbnNSdDUzRFhRQ1NiV0l2d0RiZ2NRQW5TcC9GMTl4c1VjRDV2SGJDRXlv?=
 =?utf-8?B?MWFzbnpZWkhPVVZkQWx0L0VxZzRQNnVmd2NHZlphWDhvY1NCMHlCMVVjYkV0?=
 =?utf-8?B?bm02akU3Mzhsck1DQWlxNE9kNGE2V3E3NU05SXhDZnlNS0dFMVMyTHM3b0Vv?=
 =?utf-8?B?ajBsTHBwKzF6OGFLVHZtSlFMWkF5a3Azem1KTTMzY3VBMlNLcWw1THZsMHBt?=
 =?utf-8?B?WjRLVExWTWFFMW04R1Jqd3N6bEltMEhHSTVnZll3Z3hDZUZlU2I0MnBoQ1Bk?=
 =?utf-8?B?OW5PYmVDOFdGTnhSTEhLc210cEFBc2hMMzd0STFqZmNUQ283ZUlHdDVCZVIv?=
 =?utf-8?B?YmlaRzRURTNiVGZmSGtmVktTOGlzUkJkUHhabmdkdVNBV1VwcHFHSmxuUTZS?=
 =?utf-8?B?TE9yRDB2Y01NbmlURDlqWjFCYlU3Y0RwV0NXeE5JVWJVL2w2aks0NnFRV0dm?=
 =?utf-8?Q?Zgyc=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9eef91-8d56-490b-48c7-08d9b31359da
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 08:36:34.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMA25Q7hda0cjqieuOkRdVB5enfXcWtCy5KGrC2ZHQP6SlTQp1Xt9j1OTwLsNqQ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-11-29 05:44, Aswath Govindraju wrote:
> Hi Peter,
> 
> On 25/11/21 7:22 pm, Peter Rosin wrote:
>> Hi!
>>
>> On 2021-11-23 09:12, Aswath Govindraju wrote:
>>> In some cases, we might need to provide the state of the mux to be set for
>>> the operation of a given peripheral. Therefore, pass this information using
>>> the second argument of the mux-controls property.
>>>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>>  drivers/mux/core.c           | 146 ++++++++++++++++++++++++++++++++++-
>>>  include/linux/mux/consumer.h |  19 ++++-
>>>  include/linux/mux/driver.h   |  13 ++++
>>>  3 files changed, 173 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>>> index 22f4709768d1..9622b98f9818 100644
>>> --- a/drivers/mux/core.c
>>> +++ b/drivers/mux/core.c
>>> @@ -370,6 +370,29 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
>>>  }
>>>  EXPORT_SYMBOL_GPL(mux_control_select_delay);
>>>  
>>> +/**
>>> + * mux_state_select_delay() - Select the enable state in mux-state
>>
>> The terminology is that you have a "mux" with different "states" that you
>> "select". What you are referring to as enabling a mux state, is elsewhere
>> referred to as selecting the mux state.
>>
> 
> Sorry, for mentioning what I mean by enable state. So, the idea is the
> the state that would be mentioned in the DT property would be the state
> to which the mux to be set for enabling the given device and hence I am
> referring to it as enable state. I feel that referring to it as state
> would not convey the above.

Ah, but that this state it is use to "enable" your device is a mux
consumer detail in the context of the phy-can driver. Some other
driver might need a specific mux state for something completely
unrelated. So, the "enable" naming should not spread into the mux
code.

The situation is similar to when a driver needs an enable-gpio, the
gpio consumer knows that it's a gpio used to enable the device (or
whatever), but the gpio subsystem does not bother at all with what
the gpio is used for.

Cheers,
Peter
