Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E5D492FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349448AbiARU70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:59:26 -0500
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:13869
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245609AbiARU7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:59:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOZXLbDMVyrsxPk+ldew4MRwHIPcjQGat9PsjkIjRPNpbcySolNfHld5Qvv3sy27rJxQUu6ZNbS43qiG+WFBIfNPR/T7sqe/rt6TZzJn++rSztq+QtI3uO5HtMV9jjWT7vhOS4l9N1/ANlzPvB+CZsy1N4negcKFoEI6fm1Y7MB5Mbw7kPTfyrGTSIS8Oi2lQWkEKgUY2r+IgoCiLJR1yo0b5vG0qis00DfU9qhkTWfDrJDwPuAJtNTId4q/rS42HtVRyvajwq1jGWODdPLDyQ8Cgd1tBHGSWsEZiwRQraA7IrTcA+AWo20RrXhDiYPhq5ASz7qh9uwX2S/ph21qWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79TGy9gydQNsHShFPNzG1ZRI4flEDZA2/JTil5PfN4M=;
 b=GQDzG8x1/E78gkMO2V095IfkG4RDtwwOESiUlh2QhRiZsaHsw/lq20JqDIz2q+P/asuPF3HuD8+G5V+kd8yGm06H5GJNhfdn9P/nsR5ocGhFtCJRZZwkZCyYU/VSIlMQHJ7r83JwkJwuCVwxFHAgxipfRxddx1SuxaCse+6NZHCSDSG0A7xdSAcdXAkfr4TZT0ESk02mlWm/82XrGRrOKpKwP5kQjXtabdmgI3/r/yFjTWTIfjvgjlC87JZcP7ry2ewKm5GaPOd12QW/+t1ByMOeeL7a2lct05J5oj24FZR53BjEciEQRUYL5IHKJvIQvDpWhv3jib26uyzCGmthMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79TGy9gydQNsHShFPNzG1ZRI4flEDZA2/JTil5PfN4M=;
 b=coTlpMeausd21Y2NXHnu+1M1bSJEsJkUXb9S4bpDsNMg1crH6iAB3XWFZ04Cdmrv0xEmbpN2JxsxWZuAuBdPS9flJDhyoFglqwO9RtvVr8d/K0kFKu415P2wEQrPQ0Bhqmt3SNtLSuOOsPH2kr1xqTR9uiqq/MLaP6XwUevq1cGW9XnmSh0yU/FqVtqqjPwvi/uLdrDv3E6s/wKA9FdZubEdqMp1xpTd4T7X5xSk7R2q+TXJ9gd56uWIvf6UtHYDnYp2K7oyXwOwjfxFSVTR/NxIp8GyToAAtyoiSv1gbFI1WojCkG1qnv5fFHSZcuAs6qYHnzBEdTp62wFdEAv8Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM9PR03MB6818.eurprd03.prod.outlook.com (2603:10a6:20b:2db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 20:59:21 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 20:59:21 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from reference
 clock
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Baruch Siach <baruch@tkos.co.il>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20220114233904.907918-1-sean.anderson@seco.com>
 <87iluifxy1.fsf@tarshish> <7831a4f7-7c3f-4a2a-be73-38f2c40a123c@synopsys.com>
 <f28052d9-5dea-a05b-8745-09e4d237b539@seco.com>
 <f53ba815-f2ee-a558-73f3-06c5a43f5c5e@synopsys.com>
Message-ID: <0aaeb0e3-1e10-df41-0b61-c10249ea5faa@seco.com>
Date:   Tue, 18 Jan 2022 15:59:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <f53ba815-f2ee-a558-73f3-06c5a43f5c5e@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0034.prod.exchangelabs.com (2603:10b6:208:10c::47)
 To DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40e72eb7-6555-4937-1511-08d9dac566b0
X-MS-TrafficTypeDiagnostic: AM9PR03MB6818:EE_
X-Microsoft-Antispam-PRVS: <AM9PR03MB681874BFF6B0360C3BDD729796589@AM9PR03MB6818.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAu4h4rYs0JoWVKTYy9sFoO7zCYe9F+cwEyygNLsjha9zvqGiChxFwO8v6qkpiahctBjlHlR593vZow2PiFVBN0a7xjSLNHHLb8OnVmWTogWN8MIk0HCbQzHYLoFiJqpk4bBRTYbju1pVjvbfPWKLJjLkNzo7ECNib+65yOMaP1mZtMgnT0AZQkZZPQd58Ew/f3JECWT0In+JPmYzW6TO8DhwYxPE46NmxOnnIm5ye8wBAQMCAELknhDJg8usLtIhXJBfkdeGKaV9NKLj3a/mlrYu74GW0EZRdfSkJCEfDFnJXCiPorEWVmfukz5BbUAKy9gVnTVJQCfKl75bovjpIY1AusunnB6m49UJoKQYBYldjSOG/gA7U9RlLlBjv8fxYtogwtae5UxodUghFGWr3313uGPiULn2sqpwOfOi2LOdNjLF5FjAbctVFHnSYSq2Oj34JXrDu8Kx6dis0vzTJKkWitBYDJXszfQBOgHz+qA/CG52Bj2mR4OfR22DQ6ZPhPTAjEX4Y1duJq5wKldH3K/y8kQQxRYiWCuCq4f94MTAL2Veyv3Gwlur1+QyfroRFoD5wWBsG00f/0wgkMLwPBkZKzrEZKzCnC9UjNcYnAghKBUtqdW4HunWjRtEbtXz7SX1jXLv8C1yryZ0KcudQ7ZxkWYL9jSwNEY3N+YRDNfblvE9EEBjyOOxAI2xFkO1rloDLuouPGeydNE+nL386vr/SC+aa0Y6LkVI58l0NBRwgCgmvZ/hCYGUzdEZOFWIwRivPej3JmgLAZnifrGw0nfsbr1fwcMeFQ1K5JQLXJXANVADDE5LwAWGZM9KVOIzOJIbBECScDH5+jCXmnf4LT6M+6mH6aWRfLsVcZ1Rtc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(86362001)(83380400001)(66556008)(2906002)(966005)(4326008)(7416002)(38100700002)(38350700002)(44832011)(5660300002)(54906003)(6486002)(31686004)(110136005)(508600001)(316002)(8676002)(6666004)(66946007)(26005)(186003)(66476007)(53546011)(6506007)(6512007)(52116002)(36756003)(8936002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDl3REJWSU9LNlpjSHBOMFBxYzBmOFMzaGtEUHRwZmVrMUlldkRBamJqalJj?=
 =?utf-8?B?d3lwTHYrd2FFL1pVWVZTWjZHTlBpYlZLbXIwU1ovT0twN1dsalhFaU9rU251?=
 =?utf-8?B?bVQ2NURBeWNnUVRhUlA4aENvckg4andyYVViTjlLK1hWcXZUMnVqeUUvVjJF?=
 =?utf-8?B?cXhZYWVUUFRIRllVVGhQb0tvVDZXQ0dtcnQwcUtXQi9yK29BbmI5alpLWW1S?=
 =?utf-8?B?dUVHQU10NGQ3ZVpIOS9BUGc3V2h0cEdERkZRbExSRnBEYjdoa0lQQndZQWNZ?=
 =?utf-8?B?a0tKQUw5cjg3OFVwdm9vekpOYjh6SmhZaGVsbjVKZ0xQcjlUUCtOVTNOa1l6?=
 =?utf-8?B?cEZja2hDUHk1dEtLaTJ1Y05PODY5QVh6bTUvYUpvd0RTaWpFcnNLM212R2do?=
 =?utf-8?B?NUNiR3ErRCtqdmQ2K0VFSXRPc3dwT1htc3B6Q1FaR1cyZ2RSZUk3STNlS04z?=
 =?utf-8?B?RUN0L3owQUMxUW01YXhIdUN6cXNxQ0phVHk4bHd2NTMyNFZvejBzNndqZWlR?=
 =?utf-8?B?ZmhQSnVtUU1oQXh3SThYNjZpR1dDUkErczhWdFRERXN5ZGw3Z0JudXcwaUVI?=
 =?utf-8?B?aTJvcGtscFhsVlRKdVpCUEhwZEIwZjdlQS92T2RSQURTbjVXazlwKzg2Zmx2?=
 =?utf-8?B?cFlHb3VCZTB4QVJNY3Q3NFBZTTlPY3V6UDJBOW1weTdNZmEvNTZnQmZNZlRL?=
 =?utf-8?B?SWEybTNNZEROdXZMSVYrTUNNUFNzMllpRDA2UlBkYXFYRFR1MEVjaVdIUXZU?=
 =?utf-8?B?blQ1Wng0L0p0eWs5YWlseVJVSnh1RHgzWnY3eVR0VHRFZmZ2RjlKcVdXMzJT?=
 =?utf-8?B?d01XeCtnL0EvK3RxWVNCMGdaTTFUNVNQb0phS0dlSTZmODNkdHI5YmJ1OU1Z?=
 =?utf-8?B?UUozL2d5d1dTYUN1bzI0YWorL2p1dFdDTG95S3lCQ1BPZlY3UHh4SkZzYm81?=
 =?utf-8?B?d1pRWnlkSkNUaGd1YVJEMU5QUGJOcFR0OVZHcDl1TmdlVE5xeVEvaTRBUVFQ?=
 =?utf-8?B?UU1sVFppWkIxZmQvM3YwNnFwVk5RL1BGbEJ3dmdFM1QrMC9kYlkxeGttNFlt?=
 =?utf-8?B?cEYvUE5TU2k4aHY5U1hCME16MVJ0Qys0RXg0MWErcldRSVVIVnZiTllLZFU1?=
 =?utf-8?B?QmxEWEJ0ekMzS0crZzc2SmJIcGJMMGNpQU9teGVwVXJyUzRybVpzZnlxUXlG?=
 =?utf-8?B?VzhQcWNjUFpXVHVKRUoyUE14SXkxT1lRbkNLMFFhd3U2WDlTaWk2RE1MVXpw?=
 =?utf-8?B?Rkc5aXN0cFBWZkFiblo3MVBLZnR2M0FEOUp5aHVuQ3dWWWVVQkF2V2NvSTNr?=
 =?utf-8?B?b3MxYndDc2krMDdsa3k1SmpZVVZtbmFJS2sxRmJJLzZwdmhkN24wbG04MDAz?=
 =?utf-8?B?aTFkdW1HajlNUlRFWnV0Y2dJZ3F1Tzdxd0ZFVFd3aGpQbTRYNVZ5a1FYSzVi?=
 =?utf-8?B?cUVUcmdCb2p1R3k2NGJYUWRlRFprektzVnJucWJCYVZZWUF1VkNZYzBCL213?=
 =?utf-8?B?TkFEQkFMM3FUK3NWTFBpOWgxN0JLL0hLQ3VwNEh1NElFNzlxSDZScEtXOE5p?=
 =?utf-8?B?eVZ0Z1NRQjdadHlUQWwzeXNIK0Z4MGgvU1lDR0owbzJ3NVJZdCtzdnAyK1RV?=
 =?utf-8?B?OGFqYnE5eDFSK3RvVHo0UXVxWmNMV1ZiZGthNjNLZUp2S25CWkdsVTVvYzNj?=
 =?utf-8?B?RVVRMW9ZcjYyR2lPZTNrZk9aYWo1SysxaFlhOEZkU2N1dWtrTmJ6WVBJK0ZU?=
 =?utf-8?B?c2xJNHZXUjdkaTFlcDFlZWwzdUNOYmc2anRYc3FzNTZFRjZRZzVVeU1YUmdh?=
 =?utf-8?B?ZWNqUi9aNDBMSmMxRkdqKzJSTkZRaWRuZEo5OGRielNIam0zNDh5UWlPWnZo?=
 =?utf-8?B?cE1udU5oSlZlclZ1aGR4QUtkR0tXcDRxOFlDSkxBU2drNXI2L0FSRFl4UVZJ?=
 =?utf-8?B?RnhDVThUS1hwV2VwSlVSTzRpZkVqSE1MZHBidC8xeS9Rcjg4czVnK2hYbXFR?=
 =?utf-8?B?TlYzRDlxcjV0WFlETnN1T3BsNzM0Q01UcVBseXVLQ1M0a3VJMzZla3BsRmQr?=
 =?utf-8?B?elhJTFF6anFzVDQ3c2p5ak5ibkdzUkxCcHZzWkZjdEJZbUVFNU9lcyt5MWVB?=
 =?utf-8?B?UE5TT3o1VCtRTVNDc1ZSUHdOd3Z1eks1Q1ljSEg2Yk1FK1JGczVnaTFkWGho?=
 =?utf-8?Q?lgbw1Mcfyq6UBfi5Xz/55aU=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e72eb7-6555-4937-1511-08d9dac566b0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 20:59:21.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XE4B8l8l2C4NOkMnppJ8gOlbjBrwkEjWfYSbVzjvSBQqyVSNPKmIqTqMgdsepimJUBQ+jrG5Z5grdJ1oyGdBGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6818
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 1/18/22 3:00 PM, Thinh Nguyen wrote:
> Sean Anderson wrote:
>> Hi Thinh,
>>
>> On 1/18/22 2:46 PM, Thinh Nguyen wrote:
>>> Hi Sean,
>>>
>>> Baruch Siach wrote:
>>>> Hi Sean, Thinh,
>>>>
>>>> On Fri, Jan 14 2022, Sean Anderson wrote:
>>>>> This is a rework of patches 3-5 of [1]. It attempts to correctly
>>>>> program
>>>>> REFCLKPER and REFCLK_FLADJ based on the reference clock frequency.
>>>>> Since
>>>>> we no longer need a special property duplicating this configuration,
>>>>> snps,ref-clock-period-ns is deprecated.
>>>>>
>>>>> Please test this! Patches 3/4 in this series have the effect of
>>>>> programming REFCLKPER and REFCLK_FLADJ on boards which already
>>>>> configure
>>>>> the "ref" clock. I have build tested, but not much else.
>>>>>
>>>>> [1]
>>>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20220114044230.2677283-1-robert.hancock@calian.com/__;!!A4F2R9G_pg!M3zKxDZC9a_etqzXo7GSEMTHRWfc1wR_84wwM4-fShiA35CsGcxcTEffHPbprbdC4d2R$
>>>>>
>>>>
>>>> Thinh, you suggested the dedicated DT property for the reference clock:
>>>>
>>>>
>>>> https://urldefense.com/v3/__https://lore.kernel.org/all/d5acb192-80b9-36f7-43f5-81f21c4e6ba0@synopsys.com/__;!!A4F2R9G_pg!M3zKxDZC9a_etqzXo7GSEMTHRWfc1wR_84wwM4-fShiA35CsGcxcTEffHPbprbpOFmvX$
>>>>
>>>>
>>>> Can you comment on this series?
>>>>
>>>
>>> Unless there's a good way to pass this information for PCI devices, my
>>> opinion hasn't changed. (Btw, I don't think creating a dummy clock
>>> provider and its dummy ops is a good solution as seems to complicate and
>>> bloat the PCI glue drivers).
>>
>> Can you explain your situation a bit more? I'm not sure how you can
>> access a device tree property but not add a fixed-rate clock.
>>
>> --Sean
>
> Currently for dwc3 pci devices, we have glue drivers that create a
> platform_device with specific properties to pass to the dwc3 core
> driver. Without a ref clock property, we would need another way to pass
> this information to the core driver or another way for the dwc3 core
> driver to check for specific pci device's properties and quirks.

The primary problem with the existing binding is that it does not
contain enough information to calculate the fractional period. With the
frequency, we can calculate the correct values for the registers without
needing an additional binding. So we need to transition to some kind of
frequency-based system. So perhaps we should add a "ref-clock-frequency"
property and use that as a default for when the clock is missing.

--Sean
