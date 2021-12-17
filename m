Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5513B4784DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhLQG05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:26:57 -0500
Received: from mail-eopbgr00094.outbound.protection.outlook.com ([40.107.0.94]:43784
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233217AbhLQG05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:26:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVdlBpTZqe+D+2lFjEq6zgf3B2ECqwmQ0VThdogdcyH+EjJhJ3zoqVAnrGgppaJP2QbO1as1kvEOCSoLNoVS+NrYS5m+ukNTBDYueIn4BRNxY5aPjGuGhgbrjUITyya3+Ojpkg6pvXhvGL+6bJXksPRrvP2Q97KlBFLPr7maTZo0TddlEm04YwLPL1W160B9UuC2kRNv8qtj6+Ukb8De2yt2BrTGExeM/R2tr07cgS96ANbBDyjrD37rVRxUP5YWBMGiqXwl+f8xf7SS7a4jMLxNC93/oHjuJWs65+Tn6wsDEQLgT4PEpKQNkqkc1jygSPtzSida0vCyB5AcB0Yrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf0X12auJcvnihm/lvl+TqmlixaBMYD6/veSyleXT+M=;
 b=RGEnck6vuuR9QdxLxEwOmGmR1j3IWI4JQUmj9olgmfNr9eTCAfk/oKb2MYuHB8Ts+f1pB2dk6okrP1ELpNyct2pGfzUkdeCWQ3kGghWEQcj/PsIyLjq1edwvp0Xnr0+wasKnO3/rJEKPgsRLiueJtVRjQjt3hbE4jiZNWGtfu/zXUxneQxy7XQKFXCsjJMAJSVK3/37Nqt11Du7LXTyWkyKX5PJFR5f8pReBXoNqLaORMvphGrTfkB9zmTR65UcL2wFaNxzWBio2kLCMbELtivOmjWCWrJdqBZYrrMl2ocr+0Zv755dlFWuGTpHZIbqdtxJtjsg8/majpkj/W/Zl2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf0X12auJcvnihm/lvl+TqmlixaBMYD6/veSyleXT+M=;
 b=ZTdECdyuZS9z9WpasoDlynyfJV2TcehYk9lVSrq9pKs5tO5UEk0YKz8X0e7ZvfzTYCPQyXYdhnUV49MiLU7OJAubgdQC3GFaLvTqRRo9mCKt9scYtCQm3/26TAEHA8wjPr0Ecqt9RLGe2EkPa/IUkKDolHFGcILlJP3xU1R65OE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4106.eurprd02.prod.outlook.com (2603:10a6:10:4c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 17 Dec
 2021 06:26:53 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 06:26:53 +0000
Message-ID: <af642da8-a9e1-6d3a-a928-8a514f1c5eb0@axentia.se>
Date:   Fri, 17 Dec 2021 07:26:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 0/2] MUX: Add support for mux-states
Content-Language: sv-SE
From:   Peter Rosin <peda@axentia.se>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20211202124053.2835-1-a-govindraju@ti.com>
 <59c57ab7-a272-b925-befc-79f88c925e3c@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <59c57ab7-a272-b925-befc-79f88c925e3c@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::20) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a530da56-f6bc-4df2-fd95-08d9c1263792
X-MS-TrafficTypeDiagnostic: DB7PR02MB4106:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB41067CEEA01D1B86128988F4BC789@DB7PR02MB4106.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHiJq6yZJ9vcL9GH5lnjEM9uVUEnP2ek7pMpFS8yfjfMgCLJxy+zKgxFXjS1+BIfas155LamE728PxjnwodZZUQ6J9jD+J7cMJav+gm/JdeRPK2rJgPErJgFt0LEzqByE/h/N9GEs+cnUP/z+zeAi+5ABWxdqso6+izr/ENKZRqXyt5q2yhXpEu6qsyRernBU8WYndUiyyrOcBnVoMaD/1KE0ZAC9tvNZdmHNhZjbn3IT3rqorO7S0Fec62Usk10jl/FKCVAodkE7Rx6oN6Pupy3G75xQpIO1n4nNrLOY286Omqat8AGYmfUfkezsFSulSG118B/kofF+1ZKc3heZ/NTagswWOf1uplBrLeRTsjNgV+vCiRB3wxmrBOKpE4ETUjJHgl2Ii/1+gBVIcuBMuCe//flBChMjfLyX1SrUSBrW2gxxd0/Yqs3yNgfHQvX/srMIqYeJKO6ClxBHGGvEZE//gn6OqXuTRfBbUpMniIcUOBkz+n2dPA+hGJBGQK+jDngQLNA+17JIXPKyA9MFM8GaO3EBTf6nGZGiLjE8M4yQAbr5hr3n2MS9fY8ilZlb5Gs32lvDJPslL126rhCY2hwgxNsrSNiv3XcYTbSu0nq5+4aKm7fSWKXqDXtOLDkVcerPZHA5Ijf2HQBPDiwxp0+ySqnQnVFz+AEfBffVJFdUwEYVKrT9mkd2Lj/S/JI4ZrXfm/RoKVaZ2pO43t5sSDJelpwmXzNLPFXS2sJAaASSRv4fj2854ehRRu+Bq9W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39840400004)(86362001)(2906002)(4001150100001)(31686004)(2616005)(5660300002)(508600001)(31696002)(83380400001)(6506007)(4326008)(66556008)(186003)(6512007)(36756003)(66946007)(36916002)(6916009)(66476007)(53546011)(8936002)(6486002)(26005)(316002)(8676002)(54906003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEhrd1VYL1NuSXVmNXYrbUJIMUE2bmdwQkh3VDhMVFpybGpFOUNQRjFXSS9S?=
 =?utf-8?B?YklSZk1LRjVrL0NpNmhIbVRVS0hsOVdmemFFL2lLeGNkY0MyYWRJQTRuVTcy?=
 =?utf-8?B?d2JWQWpIQmtPYUV1VmozaUQ5N1BrTDZlQTFLTExIdXZzTTRyQ1hQbjEwVGgw?=
 =?utf-8?B?dWJZb1d2ZWFaU3Q5KzQ1a1R4YWZRa20zdk9vWis3dENRWFNDaHYrWlMwOGU4?=
 =?utf-8?B?aDNEU2xMY1V4WHJETlpTOGo5azRYMFVzWDVMRVNiTVNSQTlndE9vMjFlN3ox?=
 =?utf-8?B?TmFXVFJTMHdGU013dFpiVmxyMVFHNDhxN2tLdE5SSlJYZ3YxNHMxd0ZsREJO?=
 =?utf-8?B?V2lOWXlOMEp2Y080QmhEODIzVnRuamtFaXNTVHdPR2M3UGhGWWh2allVYnF4?=
 =?utf-8?B?WEo4Y2xNM3FPNmdwUGkvbzFmU3RjQXVibncrTURmMldiUjJJbEgxbEFrZlRt?=
 =?utf-8?B?VUhsVUt6eGk4RkNXRC81Z3BmR0c0UnNjVlBkbkpNUkMxWVZpMW1xVE82TVVH?=
 =?utf-8?B?OHB2U3YzRVFHSXBOdE1vc3VTYmlSUzkzSlFmY3FiRDJSS0ozdStjOGIwUlpS?=
 =?utf-8?B?N2VmekdKNktwRFlud2Q2UUFSRm5ZWVNieDA5N2lLYkRmdlN0KzUxQkRpUGhy?=
 =?utf-8?B?eVhJeHN2a3J5eHkrK1JUNHhiSERaSjkyNzhNTmpvWkpVUFIzcmI0Q0RVaCto?=
 =?utf-8?B?QlMybmQwZ2hpNld5eXJEWFZCT2lEajdLenlJYTU0TVVYL1pmQlJkT3VITElH?=
 =?utf-8?B?ZmFMVVRhcjVEQVpTQ0c1elBoenZCV0xnajByeWVpUVlqdTU5TkNZdXVHQUxj?=
 =?utf-8?B?UitLZzFlWjBpNGZoVnpUT2dyWkdyREt4OFNvV28zSTdhZ3VaRlB0aldvVzdx?=
 =?utf-8?B?MFFVTU8yWmFjWnozU0JqdVMySVBETUJyN2Q4d0pTQ0c4cmRMMWxwdDdFVXhy?=
 =?utf-8?B?Mmdxalc5ZHFyaFgwUFk3ZjNkd0dJYVZOeHZWOVRkT1l2eVFVR1pMKzBsNjNz?=
 =?utf-8?B?QWg2VlFzVC9XTVpyMDFKdUtOU1BFaHk4OWNTK2lZSFNNaXcydi9VTWxSNDY2?=
 =?utf-8?B?aXc3SGxqa1RpY0p6WjYzN1JiQ2FmNUNsejJlQ0pBRmdZMnB0Uy8rWlgvV1N1?=
 =?utf-8?B?QWlMNmkwenVORXAzS1NEMUZCTG5pU3NieURXMGFIQUdNc0xwR2Z3OGNSQmtO?=
 =?utf-8?B?alI4eS95bnpNNHNsbWNrd2NrZWU0VHFCbllINFFiQ2ZFUUhUcG5NNHRkZERZ?=
 =?utf-8?B?dm5PK1NiK3VpSHpBYnkzQWQ4NlpMMWo3QnQ1M0FSaEF4YmZMWk1NaW9qcmNi?=
 =?utf-8?B?QmpoLzVTUGhILzc0dWhPMTVvQTM5ZHo2VmJOSDBDeUdLV0h2TGdTNXcrcXR1?=
 =?utf-8?B?QmwxZjVVdXhhWnJkWGgvbktWMXBibUNMQzloc1VocHF5VUJWcUVCY01VaVFI?=
 =?utf-8?B?REJOQ1ZTTXBCS2hUT01WeEY3Q2ZIcUd5aHFibllYR1ZTajVpa1BWOFh4RWJF?=
 =?utf-8?B?ZC9RQ0dpWXM0WVZkanFoWmNVVTVGZjdrNFJ5Y255MEtmUTN0WjEzNWJoVGxY?=
 =?utf-8?B?eEJOYzd3ZGhzd0pnblJEUU42aldZVENTdzVlVldPNEtZbUFLOVExN0lPaHZq?=
 =?utf-8?B?RWhpbkNUVzNDbDdiWlBnYlFYbEQxdHlkcTdQYUh2WEZUM1dveE9lK0lWeUZI?=
 =?utf-8?B?NTZ1STYwTHQrZk5GUGJxL1FHQ3J5VzRaWTAyUk5RU0dDZGtoVUd4a2lFei8y?=
 =?utf-8?B?MzgrdDk4V1VLTnJDOCsrZTRlZTR1VStJa3dTZTcwanpmQlZhdTdQWldFeHAw?=
 =?utf-8?B?c0tlVThzTlpwMms0OXFnc09yK1lUelYxdUwwU3ZSUFZuSkVVVzhhVzZVQmti?=
 =?utf-8?B?enJqUjBIY0tudWZrRUdNaGhIdXowSTA1VG9ZVCsvMkZvdUR4ZXEwd0VQMlhR?=
 =?utf-8?B?c0t4YmEwTVdtc0VQZjFQSmQzTkV1NzlhTEoxbjRkZXgzMXkvTmVQazRYYUg4?=
 =?utf-8?B?TEg5SlRWNHZFMVZvZ1lIdnNRWEx2Z3lUZkhLWXFFZTROSXVDNUdaQkRJYzZq?=
 =?utf-8?B?Q0JpSnlUVEhrSjZvMW50N1FwT1JRZlFyZWMvUGo3N3VNYkRrb1FhU1UxeDNP?=
 =?utf-8?Q?8sbU=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a530da56-f6bc-4df2-fd95-08d9c1263792
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 06:26:53.7092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ED2p3SiJpT0zQs2KI8xV/nAYnDWoBLuEeAwoyyloWBsG9s5hcOKVBFWjtT6HTxn+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On 2021-12-17 06:57, Peter Rosin wrote:
> Hi Aswath!
> 
> On 2021-12-02 13:40, Aswath Govindraju wrote:
>> The following series of patches add support for reading mux
>> state from the device tree.
>>
>> changes since v1:
>> - Made grammer corrections and added more information
>>   on the usage for mux-states and mux-controls
>>
>> Aswath Govindraju (2):
>>   dt-bindings: mux: Document mux-states property
>>   mux: Add support for reading mux state from consumer DT node
>>
>>  .../devicetree/bindings/mux/gpio-mux.yaml     |  11 +-
>>  .../devicetree/bindings/mux/mux-consumer.yaml |  21 ++
>>  .../bindings/mux/mux-controller.yaml          |  26 ++-
>>  drivers/mux/core.c                            | 219 ++++++++++++++++--
>>  include/linux/mux/consumer.h                  |  19 +-
>>  5 files changed, 271 insertions(+), 25 deletions(-)
>>
> 
> I finally found some time to have a last look at this (fingers crossed) and
> pushed it out for testing in linux-next.
> 
> I did end up squashing in these trivial changes in patch 2/2, I hope that's
> fine with you. Just holler if not...
> 
> Cheers,
> Peter
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 148e19381b79..5018403fe82f 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -368,6 +368,7 @@ MUX
>    devm_mux_chip_alloc()
>    devm_mux_chip_register()
>    devm_mux_control_get()
> +  devm_mux_state_get()
>  
>  NET
>    devm_alloc_etherdev()
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 7355c5ad41f7..bf448069ca85 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -30,12 +30,13 @@
>  #define MUX_CACHE_UNKNOWN MUX_IDLE_AS_IS
>  
>  /**
> - * struct mux_state -	Represents a mux controller specific to a given device
> - * @mux:		Pointer to a mux controller
> - * @state		State of the mux to be set
> + * struct mux_state -	Represents a mux controller state specific to a given
> + *			consumer.
> + * @mux:		Pointer to a mux controller.
> + * @state		State of the mux to be selected.
>   *
> - * This structure is specific to a device that acquires it and has information
> - * specific to the device.
> + * This structure is specific to the consumer that acquires it and has
> + * information specific to that consumer.
>   */
>  struct mux_state {
>  	struct mux_control *mux;
> @@ -354,7 +355,8 @@ static void mux_control_delay(struct mux_control *mux, unsigned int delay_us)
>   * On successfully selecting the mux-control state, it will be locked until
>   * there is a call to mux_control_deselect(). If the mux-control is already
>   * selected when mux_control_select() is called, the caller will be blocked
> - * until mux_control_deselect() is called (by someone else).
> + * until mux_control_deselect() or mux_state_deselect() is called (by someone
> + * else).
>   *
>   * Therefore, make sure to call mux_control_deselect() when the operation is
>   * complete and the mux-control is free for others to use, but do not call
> @@ -384,16 +386,15 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
>  EXPORT_SYMBOL_GPL(mux_control_select_delay);
>  
>  /**
> - * mux_state_select_delay() - Select mux-state
> - * @mstate: The mux-state to select
> - * @delay_us: The time to delay (in microseconds) if the mux control
> - *            changes state on select
> + * mux_state_select_delay() - Select the given multiplexer state.
> + * @mstate: The mux-state to select.
> + * @delay_us: The time to delay (in microseconds) if the mux state is changed.
>   *
> - * On successfully selecting the mux-state, it will be locked until
> - * there is a call to mux_state_deselect() or mux_control_deselect().
> - * If the mux-control is already selected when mux_state_select() is
> - * called, the caller will be blocked until mux_state_deselect() or
> - * mux_control_deselect() is called (by someone else).
> + * On successfully selecting the mux-state, its mux-control will be locked
> + * until there is a call to mux_state_deselect(). If the mux-control is already
> + * selected when mux_state_select() is called, the caller will be blocked
> + * until mux_state_deselect() or mux_control_deselect() is called (by someone
> + * else).
>   *
>   * Therefore, make sure to call mux_state_deselect() when the operation is
>   * complete and the mux-control is free for others to use, but do not call
> @@ -415,7 +416,7 @@ EXPORT_SYMBOL_GPL(mux_state_select_delay);
>   * @delay_us: The time to delay (in microseconds) if the mux state is changed.
>   *
>   * On successfully selecting the mux-control state, it will be locked until
> - * mux_control_deselect() or mux_state_deselect() called.
> + * mux_control_deselect() called.
>   *
>   * Therefore, make sure to call mux_control_deselect() when the operation is
>   * complete and the mux-control is free for others to use, but do not call
> @@ -444,12 +445,12 @@ int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
>  EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
>  
>  /**
> - * mux_state_try_select_delay() - Try to select the mux-state.
> - * @mstate: The mux-state to select
> + * mux_state_try_select_delay() - Try to select the given multiplexer state.
> + * @mstate: The mux-state to select.
>   * @delay_us: The time to delay (in microseconds) if the mux state is changed.
>   *
> - * On successfully selecting the mux-state, it will be locked until
> - * mux_state_deselect() or mux_control_deselect() is called.
> + * On successfully selecting the mux-state, its mux-control will be locked
> + * until mux_state_deselect() is called.
>   *
>   * Therefore, make sure to call mux_state_deselect() when the operation is
>   * complete and the mux-control is free for others to use, but do not call
> @@ -642,26 +643,6 @@ static void devm_mux_control_release(struct device *dev, void *res)
>  	mux_control_put(mux);
>  }
>  
> -/**
> - * mux_state_put() - Put away the mux-state for good.
> - * @mstate: The mux-state to put away.
> - *
> - * mux_control_put() reverses the effects of mux_control_get().
> - */
> -void mux_state_put(struct mux_state *mstate)
> -{
> -	mux_control_put(mstate->mux);
> -	kfree(mstate);
> -}
> -EXPORT_SYMBOL_GPL(mux_state_put);
> -
> -static void devm_mux_state_release(struct device *dev, void *res)
> -{
> -	struct mux_state *mstate = *(struct mux_state **)res;
> -
> -	mux_state_put(mstate);
> -}
> -
>  /**
>   * devm_mux_control_get() - Get the mux-control for a device, with resource
>   *			    management.
> @@ -692,6 +673,26 @@ struct mux_control *devm_mux_control_get(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_mux_control_get);
>  
> +/**
> + * mux_state_put() - Put away the mux-state for good.
> + * @mstate: The mux-state to put away.
> + *
> + * mux_control_put() reverses the effects of mux_control_get().

And, a couple of minutes later, I squashed in this on top:

- * mux_control_put() reverses the effects of mux_control_get().
+ * mux_state_put() reverses the effects of mux_state_get().

Cheers,
Peter

> + */
> +void mux_state_put(struct mux_state *mstate)
> +{
> +	mux_control_put(mstate->mux);
> +	kfree(mstate);
> +}
> +EXPORT_SYMBOL_GPL(mux_state_put);
> +
> +static void devm_mux_state_release(struct device *dev, void *res)
> +{
> +	struct mux_state *mstate = *(struct mux_state **)res;
> +
> +	mux_state_put(mstate);
> +}
> +
>  /**
>   * devm_mux_state_get() - Get the mux-state for a device, with resource
>   *			  management.
> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
> index bf5abf062c21..babf2a744056 100644
> --- a/include/linux/mux/consumer.h
> +++ b/include/linux/mux/consumer.h
> @@ -27,6 +27,7 @@ int __must_check mux_control_try_select_delay(struct mux_control *mux,
>  					      unsigned int delay_us);
>  int __must_check mux_state_try_select_delay(struct mux_state *mstate,
>  					    unsigned int delay_us);
> +
>  static inline int __must_check mux_control_select(struct mux_control *mux,
>  						  unsigned int state)
>  {
> @@ -37,6 +38,7 @@ static inline int __must_check mux_state_select(struct mux_state *mstate)
>  {
>  	return mux_state_select_delay(mstate, 0);
>  }
> +
>  static inline int __must_check mux_control_try_select(struct mux_control *mux,
>  						      unsigned int state)
>  {
> 
