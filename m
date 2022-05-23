Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19C55318DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbiEWR6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 13:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbiEWRcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:32:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700D6712C0;
        Mon, 23 May 2022 10:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e083WD7b+MQqFjKZMsvQGfd30ixT7EYk17zL/5g95gdN57tclaS9LIfQWPKqhvTNtqM6bInF5PUzA7B1Z2daN0ACCTmTK+uwk2MozJsC6tR3niZ+OXxrXnKO6bqgNWVpxxXmyIxGj0ZF5LsF0tw7MPPyFHkK6aUh0+nmoP9TATjhS/GTF3nYpwu5B6WtuSYcG4zbGGFv62mIMUJ1Ni7RQAELwwNRsvxBWUIYKaOXjZPihFdvOb62P2bqJtBv3ejP6w93QJIVg2+p6K81YsMTMrb4vKw2+v+16WuFTt8Eq3KYqYey34c45Pi5DYbOhLHicCytZ4LgSRVoVuqNyTxehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJaKg//1QtxF0UYFOOaeb8EaUIxH+Bxi8y3Ht8BoCWA=;
 b=AGSs709+8XiSVKeKECWA5nKOqgVn6mzsHS1IIkaZu4ZOiDs6YVtF5Ahn4+hbsSxx3Ft/WNW7YDWs1UGh5PulaXjWwoqOwMLWT4fQUYvPVLaH3toa8rz/xSIR1iMPcre7ntrVs5sL48T4GEuXOktWsC7n3j7rHtUkfnTxY5znHzLggR/9tGo91yN5uXUwEDQCOhfuo1jPqrSeftnbI08LKb8vo4cdvwgPnn5v9yWpf3mvuFwaPFTfqyXZ3GLo961wRhAsN4XVUPyW6bKnzCIsRGKbJ2wOyxp15c0gVdqH1R2HOHoqF50s/sYoVLxy/5WjrGYdIl6fOnFtv/mGG3RHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJaKg//1QtxF0UYFOOaeb8EaUIxH+Bxi8y3Ht8BoCWA=;
 b=Cd0MnlrsDeU8mPVVybOYLp5sRY9Aq7HJYMVau2cZRDjYktr6XjI/gtVGmj96Asr/5Ry1VatNuHz3uthDJDEOG+N9NfDp3sxNeTMI2slkYYQyrTnpJmGIh1ySda/afkKRp1ZsrTbVwTaPN3LqooxF5G2tEFisULpIh4xmCWdmhMAR37BVPImPvO/P1l4RQoA7M1dfBf5Llqh//MptsuW5vEE/CfvgSQZzxGkmcvRHzD8Qqy8VRDEb8RWgU5Zr/cD8Z0XK+DB92DJDkfoltttGNRWJ5uJ8OUm1iB1CtiGZbisG6KEw/aLsEImfnhEjimE1Bi3bdt22We6b2GquscIqIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Mon, 23 May
 2022 17:26:44 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::6c51:327:2e1f:a04c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::6c51:327:2e1f:a04c%7]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 17:26:44 +0000
Message-ID: <c7abec4b-69c1-d075-bb22-931a162694cc@nvidia.com>
Date:   Mon, 23 May 2022 10:26:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: Renamed hte directory to timestamp
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra <linux-tegra@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20220512175011.28753-1-dipenp@nvidia.com>
 <20220518003508.GA1948162-robh@kernel.org>
 <CAL_JsqK8hKVWChDNdmH7pB4kj2RafmEN0jFZSfi+i37uAPXhZw@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAL_JsqK8hKVWChDNdmH7pB4kj2RafmEN0jFZSfi+i37uAPXhZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d3d1176-94ec-4211-7ab0-08da3ce16824
X-MS-TrafficTypeDiagnostic: MW3PR12MB4556:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB455630DAC128AB7437552255AED49@MW3PR12MB4556.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUR7VuEzYB80aRvajIqNco5vgkRXFHXpUFz4oB9h7rPKF0xa7tOYwpaAxU2Zb+X0l6mooZDIuqBeomR2BHErfRRcSr4DCREYMh3eb6dWkxBhFjqMjrBF5vu4rDLlkRYcIot2iOnlHA7Wo0LPxHxf3iOLVzJI6bOk2XJ32vRjXRkhYSLFg/MCeaGG+fYHEynP3gW9l/fOuZCP/msonICUXEFmfVEIjg3Y1cJqb3BRY6YZaUlwGMhhPxZ+8KVjeYYOhPa2RxdYUoGw9nTmMz8VZjv8XEpDHr/gHJ4yJMHKVpmqEqOGSRDx37XvmIzAEYfdyrT9TTitnM2Md1uKGosPSZrNZwEiONVGu/HnBu8m4wvfb/9w3byLwPS3L2JoOfW3EeWJY5H/ZntV5brgwxnYAR2PEpVy/U2M00n9B/DSvvQa+61QNwJTLftLM2G4LV+swRLoCERwyDYEMCNNGD0Ayh7AUBA4hMKsZo/ma0PlKm2dPvsQjngQENPMIzr/Pm08f55s0ssrGzdG5OmlylgpfCNdVI+09hGyhgJqtQE1lhWmkZtnRiLGPvrXC+stDrEnAv1XkhdAt03EFpKpkTEyd6gW2bj/N/EPv3Vx1ocEFa8V3mnQgGZ2vDtNcU7WQX0HM7ePgw66cndisJ8V6F2Ei2j7MglN9/tTvCgclgWiwyF7c842xeUpGRf+4EdDi4oX7x9h4Oi0tTgKXyxIqF7rIlrJpRqadXOALuZpBrPKz7P/gnQjmiVOzwmtj7QZATIQvQ+4vD+gBJFT+z95PRPT6Yg76QT7OWKvIHYf8jt1seiCx1pxP0XMfX8qx9kkMnpSDDsG0jju2uH1L4CsNFMNCJgYAUrRakHrXxTfK+7nFjq0KagxNW9iwCIVzvR48GLW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(508600001)(966005)(6486002)(83380400001)(54906003)(186003)(6506007)(53546011)(31696002)(26005)(86362001)(38100700002)(6512007)(2616005)(6666004)(2906002)(36756003)(5660300002)(8936002)(31686004)(66556008)(66476007)(66946007)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVdxem9rY3pWMzBERklXeDRDZnc3bGNQaUtsSGM5bEhiSlphck1jZ3gvT1du?=
 =?utf-8?B?SzRJRWlCTzNnZ2dYSWNsVUlQZldRMjZ4clA1d24vV1Y1NldwanM3WUR5Witv?=
 =?utf-8?B?MGs3NytoZmgvalNCS1FPNFdJLys0LzJ5d0Q3Tk9SbWVCRVM4T0VIY1FwelRI?=
 =?utf-8?B?VjNDa0tVaWJqZXZ2MCtjNW9ESlhZWmFHYmkrRmpKMXNVRG9SSEV0Um5vQkpx?=
 =?utf-8?B?eUxSTnVqQ3dJR0E5OTRSVlpaZTE5UXZJTTNJTkhuakFvc0JaS2U5cCtIb3J6?=
 =?utf-8?B?b0krSlR3ODJXRTVyaDdJWTZSdTVUc2djZURSbXU3VzlUTFpWS056Q2FGQnU1?=
 =?utf-8?B?bmNlaFpuRWVxRm95Wk5xK2ZkcG9rdXVtSGMxcjB1Y2F5UVQ1NmNDRGE0UVAx?=
 =?utf-8?B?MlR6UmRjZ1hZUzRmbi9YMlllUlpvdWVWZ2dLY08vcUJ3MlQ4SVM5WmtkR3N0?=
 =?utf-8?B?MGhVWE9TMC9FSDhMeEFHem1uUllpZWhyc2U4UnNHMXB6QmE0ejRsQ3RyaXNC?=
 =?utf-8?B?THoxem1ybDNmb0hkWDE0b3NObUxDUEtHQmc0eTc3UlNJNk1WN0hjbzZKMFlm?=
 =?utf-8?B?ZmtSN2JzdzcvcGJHSW1PSjlibGxTVjZxNTFMcGE0SENWUzV3N25KRWdIcXRa?=
 =?utf-8?B?aUFLV0NWZ0pLWWdNYWQydzJYdHdtWEdTNUZyVTdUdkFIOHh4anZPOENVNC83?=
 =?utf-8?B?ZFJXLzdxQkd2OFBMSEpKWVgrZGtlUWlhaFdqdCtoY1FQZDExRkpWbmJncnNG?=
 =?utf-8?B?b3psL1dsb2ltemtQOG1oR1VYMHV5TDFWd3p6QWlSdHhYWTlVcVpQdVZhNDlN?=
 =?utf-8?B?TUpiNG9ZcXVMWGl4VGM0ZGo3cGZaSXlwakxMb0I0MmhQY0kzN01ib3Q1ZHRm?=
 =?utf-8?B?V3c3Z0N3bkhvdWYxRzBwQllaSFBoeGhMQ3VIVWJBZmN2WU40SFRLVVdHa0lY?=
 =?utf-8?B?cGtUQVRJa0RlTVlqVE01SDR1VVlaeGlzY0swR0NCUENlcFc0MGljeWxFajRF?=
 =?utf-8?B?TVM4N1U0dHFla3lxemJkclNuOUhraVptREx0d1E3OHgwSnRNV01uNFF3L1hm?=
 =?utf-8?B?L0dQUkx0aUNLdVM4UG5xU1NqbnNLbVRtck05b3N0TTl0TzViRjROMFhGZUNH?=
 =?utf-8?B?RWxIbjVrb3FTbkJ1eTlFK0VxQ3Z4Q2ZzNnJyTnlEZmtUVEs3ZlBzbjFEWG5Y?=
 =?utf-8?B?eXA2QjhxZU5Od3k5V2d0MVBCOXRzbXJmMmNScysyMSt6RWVjZHZnc1JrSGw3?=
 =?utf-8?B?ZUpiSitwOVNvMjJ2MUppU3FwOTI0dENOODdMdmJJSk5JREthSTFhQjd2NThR?=
 =?utf-8?B?dTRuZVIrVDd1WVR0WHY4ZkJOVzhjNCs3SW9IYnE2M2ZndDZ6N1J6SEt4YVlk?=
 =?utf-8?B?S2JlZUtIVXYyazErY0dRS0R1WUtwM0pQOW1lSjBPOTRMNStaZEZuNE5QYWoy?=
 =?utf-8?B?MFhLODZwMDlVVW54Y2RTZmpGWktYSm9rN1hLSkI2Vm0rcnRId2RKWUFzWnNq?=
 =?utf-8?B?ZVB1VjZTOEVuTllWWWJQS0V3bXhSSml0aTNZTEdLS0RDdndDOU8wUGRsVG4w?=
 =?utf-8?B?amhadDlLeUN4R3NWMVJaVlFML2RsWE96OVZiU1BUOHJsRFFVbE1EQzA1N0FL?=
 =?utf-8?B?Q3MxWVNBV3hUQkZmUVpOYjFuZGJSR2FhdDhMcDdTdTZIMXoweWtSVm5Wa1RE?=
 =?utf-8?B?dThBWVNYZDRKRWlxMS9FczdWZG9ZMkFBZ0lnK296NmFpcXVKSEx3NCtVdVRC?=
 =?utf-8?B?THRWOW44UVdJN1FFMWN0UkIwU2lNNDNlcmI2eXdKamZaT1BnbElzY1plNWhI?=
 =?utf-8?B?aXdITmYwVXU3bEtRN2JKbjZUTUFMbzFYUHpSM2xZckJaNlhVd1B4UWhtK2VU?=
 =?utf-8?B?YUVHZ3FodmU3Rk51NkVGZUk4VmJSZVpxb1J2cktQZHJGSno3emMzQXpvU0Fo?=
 =?utf-8?B?cUttZ0F1aUU3Z1l6bVdEV1BMWFBySGFxc2tqNzZ3QVk2WGJrVFNzTVZPVUsy?=
 =?utf-8?B?MWxLbEJjeEs0Skx0blBDN2c4Y0ZrRzROMkxpczlvbUJHcDU3T2kvdnNEZ3or?=
 =?utf-8?B?RmE3Mm5xcU1yM1B6RHlmZ1IzSkFFMUpKR1AwaTNXMlI3K2ZleTFrL09McXh4?=
 =?utf-8?B?RVV2elhuNlNjd0sxWGxuYUV2ZlV6aDB4WGphTHdzNm5JamNtUTBaSnZPZ3NQ?=
 =?utf-8?B?R3NWYlF6ZmY3TlhoMlJDRkpCWWZzNWpHQzNYeTlGNkNjNmM2STllTDNmVFl1?=
 =?utf-8?B?K0R5OVpXYmQ1alBNRCtpYXh2emdsbXhIUExVbkVjWHg4UjJhQnV5TXg2WHRr?=
 =?utf-8?B?TjRVWUxDZGNiS0pBS0dnaXNDVitubDN3MU80dy9XQUVhRkQyM2l3QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3d1176-94ec-4211-7ab0-08da3ce16824
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 17:26:44.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/R6C1Yokd+023hzIAvkULa72WnThhEgOFbDDXYcymHPtIOPhs2pNM45JIiK5EajDhx1YXJk+POyuzail0dWgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I have just sent out the patch to fix this.

Best Regards,

Dipen Patel

On 5/23/22 9:05 AM, Rob Herring wrote:
> On Tue, May 17, 2022 at 7:35 PM Rob Herring <robh@kernel.org> wrote:
>> On Thu, 12 May 2022 10:50:11 -0700, Dipen Patel wrote:
>>> Renamed hte dt binding directory to timestamp according review comment.
>>> Addressed minor comment about having HTE acronym first in the common dt
>>> binding document.
>>>
>>> The change reflects above renaming in MAINTAINERS files too.
>>>
>>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>>> ---
>>> This patch is on top of old series (Intro to Hardware timestamping
>>> engine V6) present in linux-next tentatively in preparation for
>>> merge.
>>>
>>>  .../{hte => timestamp}/hardware-timestamps-common.yaml      | 6 +++---
>>>  .../bindings/{hte => timestamp}/hte-consumer.yaml           | 0
>>>  .../bindings/{hte => timestamp}/nvidia,tegra194-hte.yaml    | 0
>>>  MAINTAINERS                                                 | 2 +-
>>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>>  rename Documentation/devicetree/bindings/{hte => timestamp}/hardware-timestamps-common.yaml (71%)
>>>  rename Documentation/devicetree/bindings/{hte => timestamp}/hte-consumer.yaml (100%)
>>>  rename Documentation/devicetree/bindings/{hte => timestamp}/nvidia,tegra194-hte.yaml (100%)
>>>
>> Acked-by: Rob Herring <robh@kernel.org>
> I take that back:
>
> ./Documentation/devicetree/bindings/timestamp/hte-consumer.yaml: $id:
> relative path/filename doesn't match actual path or filename
> expected: http://devicetree.org/schemas/timestamp/hte-consumer.yaml#
> ./Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml:
> $id: relative path/filename doesn't match actual path or filename
> expected: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
> ./Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml:
> $id: relative path/filename doesn't match actual path or filename
> expected: http://devicetree.org/schemas/timestamp/hardware-timestamps-common.yaml#
>
>
> I was wondering why a new common binding was already in next without a
> Reviewed-by, but I let that slide. Now I regret doing that.
>
> Rob
