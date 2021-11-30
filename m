Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F89462E46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbhK3IPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:15:24 -0500
Received: from mail-am6eur05on2113.outbound.protection.outlook.com ([40.107.22.113]:37601
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234484AbhK3IPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:15:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWCx1Eq8i+Z8SoGQCECQjbGfyHv5+Vc4KaUkU33WQzFNA6qhY2H8kk8Bza1uRHeII4AjevcfMVdgVGc/uRJQ3fod/agI/A8J/ZjVyl+WZKWD6dyKZkG7uyfWnqjc0zPcY3EYDZjPasKJ7A1uD7TigIjcnDOFeNEUkeZBpN3ocAosYXBkFww+73bSQJSg/nPrE0z1np/cHv0yEz8dw9FOt5IwpPJU0wINHBihG5g4PZ8VdJWZrblxtbmxSNkkiYG1wUP4sH0a67CN+osUsPx2juhDpxI+WDsQ/IN9DTyzJWnvoI6AxZ3eUb13OeiTNTC3fMvrgZXrmbOHkEjtlBJBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FNGQRLlvr/jhtkU7svsSTyLwkWFc26tAWHOKEKPpUw=;
 b=Uhv97Kz3CIv2cjgdQCHLhHPZKQ/v47fKyAWPuqEgVFkujo/VMCvJKa+yX6uXJC4PXDjDifmqDduexznBvODfb9hk3u9WE15ZeX2vXL0UtzH9Kii3ryXZKxS65uxPHq75SKm4X4E0ARmEM7VGNXBGoDAXVBsrf+rk91AYjIVkFAXtL9TL9v4qtZfuSp0P9A+GLWstTh0+HSMxE+2BFKQFDpui6u6NxMtATaAyuRVL3AchghgHwQEcIH5nu7tYcaGXYiSZtQhwCbU+bTSDY/EtXQ9pXfyjcZkOUz+izfVcb3LVtJIj0I1T45o6PnmnulLKdEwNo7VTy17qsjyYq3CR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FNGQRLlvr/jhtkU7svsSTyLwkWFc26tAWHOKEKPpUw=;
 b=IM8xMKvLxjToAZ5RGmhI42KY45UzXahB4YqxF0t0eX/fWDKoFlznVT0eK9/eVW1mof30l+mmKCot6qHd4D4UyODt26p7D6kkB2UsmlOOQADVo2Xq578x2zCzMY3KeHQXxbTJ8z0UuVcipGy1LrbSS7svQFn9CdF1sODyhGDykuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5964.eurprd02.prod.outlook.com (2603:10a6:10:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 08:12:01 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 08:12:01 +0000
Message-ID: <3c62744a-3d12-81d3-3270-f9496addfa61@axentia.se>
Date:   Tue, 30 Nov 2021 09:11:57 +0100
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
 <06126316-53ef-6c32-2fbe-cff68e1ea064@ti.com>
 <81e5d8e2-d91a-1832-1854-2eacb60df7d6@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <81e5d8e2-d91a-1832-1854-2eacb60df7d6@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0089.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::13) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0089.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 08:12:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 604b687f-b1b6-46dd-92e6-08d9b3d91662
X-MS-TrafficTypeDiagnostic: DB8PR02MB5964:
X-Microsoft-Antispam-PRVS: <DB8PR02MB59642BE52E83386042B58201BC679@DB8PR02MB5964.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWCmuEuY1opjWlXuI5gmApn1l4VSBT+YK3aw5mtKy1/6ztkl/kaJ5Y6ylhetsLf9DbwGwF1vuk2T4Cth5FecUBcbcK9twpxMUzFHtdQn9vskvOTO04mU/K8cCIOgvzd+7b4kk8HXpHg2hAcGERs6XdLfDWVfQyIvLFX7n9bBlHIoF57n7Q1vYeU2qsgmeT6Mlx7wRMJusIvbOG3q1K1Bsw5YLQ6+ksm6GwuUGDHajzL5l7davPX0Svq2kmEnG4g36v9svvjo64EhBMA9Lx2HKBoEAder0RrzJZj4IdvWZMR3kh/HAyv+zDFFYfjSxQFojuZUXYP8tvt31khT68RwjWjBqkGwuK+Ws+DnIXpyTd/VDF50svSnuwU/hzGhxwpH5cRs1o2q3ZSKWUmaY6gur/Kz83oSlYoM6Ib0pAUZBVNK/RyGS/NJ5Se+WQVWEwQ00eMvC9EqFSVkZnd6WS0ndDm6hrjQ8kdCjYl6Rh5Qkt7Rjjlu5j7LpnZGxFj6hxmF9b4GacgrunXoB6N+XIKyDvOMqk4Cs5pBnMzErtc3NEGupcFynthtticZcvMxyyQj2kN9DZCcMI+SyuJnSHzxFMgQBJn+S7GizV9YDY75gYh7OJTcqxakac4eCMJW+4E0ZYXlWkFgn98//+cDatMaxnhh7UdoQ4Co7CGrCxRjjstFw2FArC4NhJP1VFJ2aVz9hB7I3MFH8d55XEdm5siMR0gKrokARM7sdagd8CK/eEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39830400003)(366004)(396003)(376002)(86362001)(508600001)(16576012)(6486002)(316002)(66556008)(26005)(2616005)(8676002)(6916009)(5660300002)(36916002)(31686004)(186003)(66476007)(66946007)(956004)(4326008)(83380400001)(8936002)(53546011)(4001150100001)(38100700002)(31696002)(6666004)(7416002)(54906003)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3lmaUdjeVFMbVBhL3lPZW9iajNRZFkrNlFtYWJOVDQxWWFwMUNsMUFzMXh3?=
 =?utf-8?B?MnBUc3E0ZUdxbS9ncjRwRWdUeWltcVFIWVlYTllkT2NQWDJVOFNiUEhmOG5X?=
 =?utf-8?B?SlJVZys2b0UvTjNUanNDQlVjbEtsWDJiMTdKNVpMeVBmMzRaWnp1MXovUTM3?=
 =?utf-8?B?RVhCaE1PcWZWUzVyMTZhaXdkUGNkd2Q4NzBHYXFrVmNNSVlvdm5IVkxhZW5G?=
 =?utf-8?B?WVE3WDdXZ2ZjdWVVNEhVaVRORW0xNU1ycDhQSXg1VGdaUndyS3UvWXAyNFIy?=
 =?utf-8?B?YWtYMDZDWFhnZkxUTFNjRjg1N0Q2STk3eGJGRUdHL2ZnKzYvai9QcWxVdi81?=
 =?utf-8?B?TmJOek92Q0dKWWNEYi94Q0pWR05nQVRvVkZycklYV2pzdHB6Ylc2RTNPVkpv?=
 =?utf-8?B?UlZlMjc0ZEYrdm81S3owUjdYR2JsOStIOGtVUFVaZlEza1BvOEZCSVc5Tnk0?=
 =?utf-8?B?b2ZhWURzWnJSQjV6MGdQWXp3b0tVT3UwNWsyNi9zQTQ3eDdlVE1yRFJwOFZC?=
 =?utf-8?B?SmxXaUluZmx4QVZmUkF0YXBIeDY5YkU5UWxkeE12TUxlMzhPbmNDd1J2elo5?=
 =?utf-8?B?RWg5eC9lYUIxR0dYNnhlSC9LZXB5ek45V1lKdTdCeDhVVENIRysrMlBSc3Jh?=
 =?utf-8?B?Zkg4cW12THdwTDBRRlMvYUxTUUV6VTl1WTRHSzNMQmZaczdtWEZ5dFB1NHdu?=
 =?utf-8?B?SkpwcTY3UzdRbTNLRHpONVdzTUJJMkxLRTNqZG5WbHVBTUkxdVo3MHBHbHJo?=
 =?utf-8?B?U3BsTkJtYWJmS3hIUWY5K2ZIUDRwclFyNkh1QW5qSytKYVBWajdYSml2bnd2?=
 =?utf-8?B?a3pKNElJK0J2ZDU1UDJsam9qcDRYQmduVjJWRHpFSm1yWUVDenlDQnQ1a2ZJ?=
 =?utf-8?B?UVN6aXhZQkk5d0hyR1l0SC9RUG9YNTFYbFFaSHRoOTBFcUZRcFFuUHBXQzVv?=
 =?utf-8?B?QTJXZ2ZaWGEzMEdNWHUzazRGQVlEQTVOR1hDQSt6NSsvN3pWMjRuQ3ZyaXJE?=
 =?utf-8?B?WjRDdUxNRjQvbnZsalczN1dzYXhPeTJwVWNSRjNaYjdmeHJoTS90aENIV0xi?=
 =?utf-8?B?NlpoYURReFQwVFpIVEJkL3FUVmlFWTI3M1ErZW1JVmY1dHFGaWk1MmdqdkxY?=
 =?utf-8?B?M3B4bHhTSitGODlzdlZ4aDdlbkRzeE1hUHIxL1dmN2JMb1NVa0dtSkU2aFla?=
 =?utf-8?B?V0NxcEYraGZRVzgxUzBuTXBoL3JSdFo2NUl5aTNjWXBrSERnVGI0NTExaVpt?=
 =?utf-8?B?eGJwZjQ2MHllUUZlZVArQlpJcW1IN3Vhd0FKVERVWjBaN2w0MlFCeHJoRzZr?=
 =?utf-8?B?Mk41U3lpNW92T3FIS3hWM2xPNGFZbGVzMU1PSWdwSUpraE0xaUZ1Y0pudldT?=
 =?utf-8?B?ZEN1cWpMNy9ENnlvY0FSZlEyT1JibTZ3QTBKUVc2M042RVlkTmZRTlFvOTVs?=
 =?utf-8?B?M0l5SGFGV0hYS1d3bFNTeGkwRlcvQW0ycy9yTUVtZzFtQTZpOW5JNCsvOTVs?=
 =?utf-8?B?enAyMjVaSGkrK29xZmZTUTJ0T05PRGNuNnBHd29VZkxKQ1UyN2h5eFJIcVpD?=
 =?utf-8?B?NkJMMDFlVzlDRVhaa245VEs3N3U0cEhpOE90cFFEQWZvekM5M09tY2lQWTdx?=
 =?utf-8?B?cFdwcWQwbWRzL0xpaHMvYkZ6cG9mYlIyL3ZMemhnR0d4NHdhdUs3cnRSdDQv?=
 =?utf-8?B?U3V2V29tdE9CVnp1ZFMweVlGWVRKbmErRC9HeDV0RStLVnFPYUNrSGF0a1A4?=
 =?utf-8?B?aFBaNm9saytRdThDbi82cC8vNTJrSkxTSG5kVjNGRmc1bUU0R0xOYVdWZFFD?=
 =?utf-8?B?M3pOT3FRc2RjUlRrSVlkNmtMSkoyNkRCL1RMejM0Ny9kZ1hodW1BYjhKc2pO?=
 =?utf-8?B?RWxiZExQb1dRWFp2aEVRczEvMVllZE9LRDA0VHIxNjREUzFzbU11eVVNakJ2?=
 =?utf-8?B?T2RwaTJvWTF4YnJoLzJQQlVWbW5mZE5tVHhjTEdLTlNlTC9HdFpHbk1jdWFq?=
 =?utf-8?B?TXNxNFp2YjN3bnhGNkdyOExXU0xlOTVVcjd3UjlnK2o3cmVHeUNhcFBqcEtt?=
 =?utf-8?B?WmprS1ZacHArVUdhTUVWZkFrZ1FxaFhUclZHRnBDZ0FzM3RhZU5CaDZIcUJl?=
 =?utf-8?Q?eapk=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 604b687f-b1b6-46dd-92e6-08d9b3d91662
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:12:01.6458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSYwjF4xtMkge9fmfARZj3g7peQpnG5vv2Deiu6OoHBG9XB3g3JL8XWD4Cn069zu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5964
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-30 06:58, Aswath Govindraju wrote:
> On 30/11/21 11:14 am, Aswath Govindraju wrote:
>> On 25/11/21 7:22 pm, Peter Rosin wrote:
>>> With the suggested binding in my comment for patch 1/4, you'd need to do
>>> either
>>>
>>> 	ret = of_parse_phandle_with_args(np,
>>> 					 "mux-controls", "#mux-control-cells",
>>> 					 index, &args);
>>>
>>> or
>>>
>>> 	ret = of_parse_phandle_with_args(np,
>>> 					 "mux-states", "#mux-state-cells",
>>> 					 index, &args);
>>>
>>> depending on if the mux_get helper gets a NULL (enable_)state pointer or a "real"
>>> address, and then...
>>>
>>
>>
>> Sorry, while trying to implement the above method, I came across one
>> more question. So, in a given consumer DT node we will be either having
>> only mux-states or mux-controls right? How would we take care of the
>> condition when we would want to set the state of a given line in the
>> controller. Especially when a single mux chip is used by multiple
>> consumers each using a different line. Wouldn't we require both
>> mux-controls and mux-states in that case? So, shouldn't the
>> implementation be such that we need to first read mux-controls and then
>> based whether the enable_state is NULL, we read mux-states?
>>
>> Just to add more clarity, if we go about this method then we would have
>> both mux-controls and mux-states in the consumer DT node when we want to
>> specify the state.
>>
> 
> I now understood the implementation that you described. mux-states will
> be similar to the mux-controls after this patch is applied. mux-states
> can have 2 arguments(mux line and state) whereas mux-controls can have
> only one argument(mux line).
> 
> Sorry, for the inconvenience.

No trouble at all. And thanks for tackling this! I think it can open up
the mux subsystem to more uses.

I'm not sure if the devicetree folks like the concept though, there has
been no comment from that direction yet. Because it does feel a bit
unusual to potentially have both #mux-control-cells and #mux-state-cells
in a single mux provider node, especially when they are as related as
they are. But sharing a mux control between several consumer is perhaps
not the most common usage, so it will probably be the exception to
require both in actual usage. But I think all that will be clearer
when/if we see the actual binding patches.

Cheers,
Peter
