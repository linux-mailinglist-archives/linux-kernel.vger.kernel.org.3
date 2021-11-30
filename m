Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935DE463BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbhK3Qfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:35:55 -0500
Received: from mail-vi1eur05on2121.outbound.protection.outlook.com ([40.107.21.121]:27560
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231822AbhK3Qfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:35:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjiCHt2Dr0+eSfRK9SW7wM+wbm6qZVfvjhVui2uI4hCtDSchsH59FcLb34WM2UMmsBGGQ9uRXrmpEc8yoayaxADgC7Xh0nhju7ETJxe/jssFLPxflwA0x3yOfLwN+vY5dYjjknCf8xOFy8GcjAfjVN7ms+yr+fTmxS73LUQgYTU3XFr2ZVYEFtVuUJ4+jUtj6t4NDGFl2yylw4iLCpdBoL2cpLpUwP8VQj22HdrhIqhZYvqBbwCRkpFyLo+Ua4FGSZnB8shnjYUhR4KrkNSQGhanpD4x0ArIjdfPbIg8AQGXANPApfps5ZQlSsxsy9Ghf5eylENc7tnfWy1bIRcxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NWEqKcIMvqzW+pEKEhQTTnaSMTvffofnK+PLzeuTAc=;
 b=I4JUr9+5BjxWHaqsJzi3Zn/6ig1KomUEToZtWseDuL58/7g8/Ix9uEjKJ1QOrn78tjGajEDxMx5N4NiSfovv8HpW40XvvnmTc+BDsgPCYcv0G6cuj/oD0KAKL9swgf/Ac9MUaFImDk576Pf7Frnqzl77g67MbdJjMKB4RKiXTC4TAFNqPbECS2yRvq3WEb1VvyTSHJg5iUBZpbFf7lFG1ArsYej+UOUvAloSNOkLGRQ+mP25Za4jFayX68yzZti7C44R3eDdVGEgNJmFt6onwwJaKjdFSr0FMc/NxXEn+nCjV/qC2VDlTK0R9cmHiCLGMInYXsUGzYv2HPLv/ya7pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NWEqKcIMvqzW+pEKEhQTTnaSMTvffofnK+PLzeuTAc=;
 b=HBJygaaLdcJQWjX24YdDc83eJawkZlAsISwM68+rSkwc+9Kfv4tm3L2gCeyfqD0Z1E1oJDiJpGgpEuMeRRRIzgXkuYTd5D9yMiiRDIs9sgGI0fwIjoScs03iHmU0mi33XWYJ3UrHrEUjkFp9PgpvwBNZo7Ws2sBkTMBxyyT0Asc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6421.eurprd02.prod.outlook.com (2603:10a6:10:195::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 16:32:29 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 16:32:29 +0000
Message-ID: <62c04e5a-cd6b-5081-69d6-ce8ad1612560@axentia.se>
Date:   Tue, 30 Nov 2021 17:32:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] mux: Add support for reading mux state from consumer
 DT node
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20211130121847.11112-1-a-govindraju@ti.com>
 <20211130121847.11112-3-a-govindraju@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211130121847.11112-3-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0097.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::29) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0097.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 16:32:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c256673-3640-4390-91e0-08d9b41f001b
X-MS-TrafficTypeDiagnostic: DBAPR02MB6421:
X-Microsoft-Antispam-PRVS: <DBAPR02MB64211302253612F1DEEB0ED0BC679@DBAPR02MB6421.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOV8qYnbYjajyWF19XUCJW18U73QZ+igLLANDakWVwPH2v3kWrhfBLcMxNJMhqubsLF7NYV/PcSfRxHDcxO1RsvoisEPLpw3Wg72h+jNL75SBCPSZmNXFsNSJ+/E+wnZg+Gceh5AO4sILWvyyFH6yA36EuoQh+26XgTn81Bb/ntQekOo7hdn2j154WhSVv7X7gWeVf+95hMW3E1Wb5ENundWoMrOmSF1ToW/khZ865Y5Kv6Hu6wk+PDz75QlTno6PRF3e+nXessGIfCE+7wPES/EAnQRgOE9hsh0bY+OY9SmBf6H+bFIK/vaGxcL54u3wZXt1I9Ly4yxvN76ZTFccDAxGTLzHArzlhP1ICZDVvEcfG4pSkxh5laJe0AmxB96Asj8Y70pcZA0oSSX3XLDKglKRO+W2KjefU6ju4OD36vcksx1+4j13xPbjftE5DJ5YGW2LLBCTy1tovSzZPjThE5jZmf4qze4O3xGbhNplTITrzZkQvckOlNO25wTq4lAZ6WzOg9YKkFFuFwkUPibe1a3v1YdJ6g6zpBHv6ASO6swUu27p+W1jA/5nn4Mp0tOwd4YlbfXysLoHBpPVzrBglunODRXPaPRtOwTa2QcK25EEDl/Lt73o7HRIMLdu1ttqPdZS2MsputrMgqWHDkpEEZ+b5yowSVNg48qbwsLAFqwbnYVQZupDupR/qZGwGTGoHTJblcWtl+2aM4MdEV1ZxepRHzzbvX7GB/xsQVrDFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(136003)(39840400004)(8676002)(26005)(86362001)(83380400001)(53546011)(186003)(31696002)(5660300002)(2616005)(8936002)(66946007)(38100700002)(36916002)(66476007)(66556008)(30864003)(316002)(54906003)(16576012)(31686004)(4001150100001)(2906002)(36756003)(6486002)(508600001)(956004)(6916009)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzZIaFNFdUVDclBLc1ZnSDEwWm94dkN2bEpiQWtESVdDeUREeHVKY0lLS2hm?=
 =?utf-8?B?ZFRXWGR3T1JPVFJuSnRHQ0Vqb2VMd3ltQmJlVkZtSU1uaCt4STNSb3Bjbm5o?=
 =?utf-8?B?SGRZZ0trdkV6d2NhSVFENlF5TEorZXVMaDcxc0JvdzRUNit6T01kTmtTS0xm?=
 =?utf-8?B?N1pKMnZGd0hnVzQzampYWjg2Y1VURnc5QmUxZXZTK1VSS0RMZ2dta3Z2TnV2?=
 =?utf-8?B?SkQxc1U0SWtYMU9uNmJnMzlnOEtuUUlzelpKZTJ4R0RUOTUwVEMzS3g2Uk1K?=
 =?utf-8?B?R3Bnd280b0p3eFpJcXdqNmEwd21tbndqYWYvYldZYlc3TzFzbk9jbFdES3hQ?=
 =?utf-8?B?R1I0QU56WCt4ZnhFZFd5c3dsdTV2OFhqT0xwQjRWR0VTaWhCOWgyYStUbS9O?=
 =?utf-8?B?MTBkOE8xK3VER0hPRVZMc09IUkk3RnJ2UitNR1dCbG1zVHRQME5wNHRjcGJQ?=
 =?utf-8?B?emtVbDdYNXVEMFdMbnFHd0xlOFNod3J6c3cxbXQ4L25pdEJMMmQ4cC9ncEJ0?=
 =?utf-8?B?TUJYQTFLcS8xMGkxZjZCK1R1U0pzbWxzZm5zOTZ1OXNRZGV1ZFV4N0ZGN3FR?=
 =?utf-8?B?S2ZOOVBFZEc5bkcyZW9Ta2M0cnVmb2ZHazNMa0Z6dGtJVVNkc2VFOXJJbGNV?=
 =?utf-8?B?QUZPYW9KL2ZHc0tFQXRBN3JCYzVhenBYVG1tMWh5UVVJMkxnd1NVN0wxNlFx?=
 =?utf-8?B?TXVJT1R2WnRFWDNZY1hEbTV2YkxxblJpeUVpUmVHWS9xSmY3dFZpc29iQW0z?=
 =?utf-8?B?L29kc1AwN0hTM2pIM3ZqdElSdWoxKytOZGFwZkwxZUJTZjZxbXgxVHF6Z2lx?=
 =?utf-8?B?VUJhNXhDOXRzRGsxN1J1T2VIblhqeU9mQzQ2T29pcTUrVWx4Zk1McHBiakNl?=
 =?utf-8?B?SXZ3Mlgxa2krMkx6L1NnUFNQNlU3UVJZOEVGWUVjcnZWZ3ppSzZtSXlkNGVI?=
 =?utf-8?B?VU9iNmErU1Vzd0piOVpyTUxCc0xsZlJOMTlyUW5mQW5yaUplemhsV3hQVDg0?=
 =?utf-8?B?dlFLYmJFaE5XTDlPSFcrMTNWdDZQL2pXWkFEbU01S1h0a3FzMUUycDhSUlhw?=
 =?utf-8?B?Vk80THF2cVVKK1hYSmNwck8zaDdjckJpSjhzbnRJOTZ1UjhyYXJhMTFobElB?=
 =?utf-8?B?eTNleGtGeUgrTUtPNnhIa2czR3V1MTl1QlduNlA3YXpuZUM0UE5DU25OQUJS?=
 =?utf-8?B?dHU0aTk1a0xlbEpqRHZRRG9ud0NvY3VRd0ltM0hFQzJ4MUZxSUU2WGxPTHA4?=
 =?utf-8?B?QnRURkg3RmtBM1QvejhxSlhwcjI0Z2hyZFhXMDFTM2lVMERxbUtvTENyUGVS?=
 =?utf-8?B?TzkxckN2SzJrWVVVKy8vdEo2cDl6NkliR3EzRElrb2pHdWZoOWpackxrWFhz?=
 =?utf-8?B?OFBLK3NyYU12bHJlRDVtVDJ5aE90SGRkRDU2bTEvSFZJM0d0RVNDWThHN1Nj?=
 =?utf-8?B?bGlEdWR6WUFCUUVFN3J5WUhhbjlqMVpseHh0MXJIUGdaczZjMkFERDU5Zm5o?=
 =?utf-8?B?VDZOZFowclFnSCtxU2tjbGp6N2JtaEx0TlpkeGhNOFdKYVh5dEVHczVTNkMr?=
 =?utf-8?B?Z21PY08zSThDbnBpeVljTm1KNjJObTMrMjdBVmFFWTZDdC9KRGFJSHZNZlEr?=
 =?utf-8?B?TGIwVnYyT3JWUi96YnVNcUpiZlFJMlg5RTRVc05Dcld4SkdRajVNT2N3ejlX?=
 =?utf-8?B?bHJvWktFVTB4OGRSS3Q4WGpDRmQyYVRIT2JKT1BkQllGM2lMUUxGeFJ4Ungr?=
 =?utf-8?B?VzJ0cHA0bU9XaTJoTHdDeVY1STdPd243OGZBeWNVMENxZkhrUnkyUVU2ZTlJ?=
 =?utf-8?B?K3lwL1BUbm5QOTk4U010dkkzUzNNc0lhUWRzNTVvaC9MMGo0VWFEcmdxMGdW?=
 =?utf-8?B?MTBTUnpaQlhiUm5MN2J3SDVheUhMUVRTVmV3czdUZDAwckRMVXJGdlJmbkkr?=
 =?utf-8?B?QjN6VEpVRlZiQnp1M3VHdTl2WGxaZ09XbEhwcjM3LzRJZE9HR0MvM1VqODVP?=
 =?utf-8?B?TktTR3BZSEQrRzhGc09Vb2paOXBTMVBHUVJDbk9rV0tZYVNUaE80b3dCdVRL?=
 =?utf-8?B?UCtRczdkcUhsaDBRc2pBT2VscmpOV0dEbUhCZUhVNHJkbm4razBSSmlXcU1x?=
 =?utf-8?Q?wI6k=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c256673-3640-4390-91e0-08d9b41f001b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 16:32:29.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A04c0YIO4KYDgVEbD7TgkphWFsflBN7yzPtDA53WRUuV4dcF28GrBjxyVU1+Cs0L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6421
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Looks good, I think. I have some nits, but nothing major...

On 2021-11-30 13:18, Aswath Govindraju wrote:
> In some cases, we might need to provide the state of the mux to be set for
> the operation of a given peripheral. Therefore, pass this information using
> mux-states property.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/mux/core.c           | 213 +++++++++++++++++++++++++++++++----
>  include/linux/mux/consumer.h |  19 +++-
>  2 files changed, 212 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 22f4709768d1..38869c3680a8 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -29,6 +29,19 @@
>   */
>  #define MUX_CACHE_UNKNOWN MUX_IDLE_AS_IS
>  
> +/**
> + * struct mux_state -	Represents a mux controller specific to a given device
> + * @mux:		Pointer to a mux controller
> + * @state		State of the mux to be set
> + *
> + * This structure is specific to a device that acquires it and has information
> + * specific to the device.
> + */
> +struct mux_state {
> +	struct mux_control *mux;
> +	unsigned int state;
> +};
> +
>  static struct class mux_class = {
>  	.name = "mux",
>  	.owner = THIS_MODULE,
> @@ -370,6 +383,30 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
>  }
>  EXPORT_SYMBOL_GPL(mux_control_select_delay);
>  
> +/**
> + * mux_state_select_delay() - Select mux-state
> + * @mux: The mux-state to select

@mstate

> + * @delay_us: The time to delay (in microseconds) if the mux control
> + *            changes state on select
> + *
> + * On successfully selecting the mux-state, it will be locked until
> + * there is a call to mux_state_deselect(). If the mux-control is already
> + * selected when mux_state_select() is called, the caller will be blocked
> + * until mux_state_deselect() is called (by someone else).

If the other consumer has the whole mux control, that consumer will
deselect with mux_control_deselect() (i.e. not mux_state_deselect()).

> + *
> + * Therefore, make sure to call mux_state_deselect() when the operation is
> + * complete and the mux-control is free for others to use, but do not call
> + * mux_state_deselect() if mux_state_select() fails.
> + *
> + * Return: 0 when the mux-state has been selected or a negative
> + * errno on error.
> + */
> +int mux_state_select_delay(struct mux_state *mstate, unsigned int delay_us)
> +{
> +	return mux_control_select_delay(mstate->mux, mstate->state, delay_us);
> +}
> +EXPORT_SYMBOL_GPL(mux_state_select_delay);
> +
>  /**
>   * mux_control_try_select_delay() - Try to select the given multiplexer state.
>   * @mux: The mux-control to request a change of state from.
> @@ -405,6 +442,27 @@ int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
>  }
>  EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
>  
> +/**
> + * mux_state_try_select_delay() - Try to select the mux-state.
> + * @mux: The mux-state to select

@mstate

> + * @delay_us: The time to delay (in microseconds) if the mux state is changed.
> + *
> + * On successfully selecting the mux-state, it will be locked until
> + * mux_state_deselect() called.
> + *
> + * Therefore, make sure to call mux_state_deselect() when the operation is
> + * complete and the mux-control is free for others to use, but do not call
> + * mux_state_deselect() if mux_state_try_select() fails.
> + *
> + * Return: 0 when the mux-control state has the requested state or a negative

 * Return: 0 when the mux-state has been selected or a negative

> + * errno on error. Specifically -EBUSY if the mux-control is contended.
> + */
> +int mux_state_try_select_delay(struct mux_state *mstate, unsigned int delay_us)
> +{
> +	return mux_control_try_select_delay(mstate->mux, mstate->state, delay_us);
> +}
> +EXPORT_SYMBOL_GPL(mux_state_try_select_delay);
> +
>  /**
>   * mux_control_deselect() - Deselect the previously selected multiplexer state.
>   * @mux: The mux-control to deselect.
> @@ -431,6 +489,24 @@ int mux_control_deselect(struct mux_control *mux)
>  }
>  EXPORT_SYMBOL_GPL(mux_control_deselect);
>  
> +/**
> + * mux_state_deselect() - Deselect the previously selected multiplexer state.
> + * @mux: The mux-state to deselect.

@mstate

> + *
> + * It is required that a single call is made to mux_state_deselect() for
> + * each and every successful call made to either of mux_state_select() or
> + * mux_state_try_select().
> + *
> + * Return: 0 on success and a negative errno on error. An error can only
> + * occur if the mux has an idle state. Note that even if an error occurs, the
> + * mux-control is unlocked and is thus free for the next access.
> + */
> +int mux_state_deselect(struct mux_state *mstate)
> +{
> +	return mux_control_deselect(mstate->mux);
> +}
> +EXPORT_SYMBOL_GPL(mux_state_deselect);
> +
>  /* Note this function returns a reference to the mux_chip dev. */
>  static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
>  {
> @@ -442,13 +518,15 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
>  }
>  
>  /**

I think this should be an ordinary comment now that this function is refactored
into a static helper, so just go with a plain old /* instead of /**

> - * mux_control_get() - Get the mux-control for a device.
> + * mux_get() - Get the mux-control for a device.
>   * @dev: The device that needs a mux-control.
>   * @mux_name: The name identifying the mux-control.
> + * @state: The variable to store the enable state for the requested device

 * @state: Pointer to where the requested state is returned, or NULL when the
           required multiplexer states are handled by other means.

>   *
>   * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
>   */
> -struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
> +static struct mux_control *mux_get(struct device *dev, const char *mux_name,
> +				   unsigned int *state)
>  {
>  	struct device_node *np = dev->of_node;
>  	struct of_phandle_args args;
> @@ -458,8 +536,12 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  	int ret;
>  
>  	if (mux_name) {
> -		index = of_property_match_string(np, "mux-control-names",
> -						 mux_name);
> +		if (state)
> +			index = of_property_match_string(np, "mux-state-names",
> +							 mux_name);
> +		else
> +			index = of_property_match_string(np, "mux-control-names",
> +							 mux_name);
>  		if (index < 0) {
>  			dev_err(dev, "mux controller '%s' not found\n",
>  				mux_name);
> @@ -467,12 +549,17 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  		}
>  	}
>  
> -	ret = of_parse_phandle_with_args(np,
> -					 "mux-controls", "#mux-control-cells",
> -					 index, &args);
> +	if (state)
> +		ret = of_parse_phandle_with_args(np,
> +						 "mux-states", "#mux-state-cells",
> +						 index, &args);
> +	else
> +		ret = of_parse_phandle_with_args(np,
> +						 "mux-controls", "#mux-control-cells",
> +						 index, &args);
>  	if (ret) {
> -		dev_err(dev, "%pOF: failed to get mux-control %s(%i)\n",
> -			np, mux_name ?: "", index);
> +		dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
> +			np, state ? "state" : "control", mux_name ?: "", index);
>  		return ERR_PTR(ret);
>  	}
>  
> @@ -481,17 +568,35 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  	if (!mux_chip)
>  		return ERR_PTR(-EPROBE_DEFER);
>  
> -	if (args.args_count > 1 ||
> -	    (!args.args_count && (mux_chip->controllers > 1))) {
> -		dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
> -			np, args.np);
> -		put_device(&mux_chip->dev);
> -		return ERR_PTR(-EINVAL);
> -	}
> -
>  	controller = 0;
> -	if (args.args_count)
> -		controller = args.args[0];
> +	if (state) {
> +		if (args.args_count > 2 || args.args_count == 0 ||
> +		    (args.args_count < 2 && mux_chip->controllers > 1)) {
> +			dev_err(dev, "%pOF: wrong #mux-state-cells for %pOF\n",
> +				np, args.np);
> +			put_device(&mux_chip->dev);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		if (args.args_count == 2) {
> +			controller = args.args[0];
> +			*state = args.args[1];
> +		} else {
> +			*state = args.args[0];
> +		}
> +
> +	} else {
> +		if (args.args_count > 1 ||
> +		    (!args.args_count && mux_chip->controllers > 1)) {
> +			dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
> +				np, args.np);
> +			put_device(&mux_chip->dev);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		if (args.args_count)
> +			controller = args.args[0];
> +	}
>  
>  	if (controller >= mux_chip->controllers) {
>  		dev_err(dev, "%pOF: bad mux controller %u specified in %pOF\n",
> @@ -502,6 +607,18 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  
>  	return &mux_chip->mux[controller];
>  }
> +
> +/**
> + * mux_control_get() - Get the mux-control for a device.
> + * @dev: The device that needs a mux-control.
> + * @mux_name: The name identifying the mux-control.
> + *
> + * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
> + */
> +struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
> +{
> +	return mux_get(dev, mux_name, NULL);
> +}
>  EXPORT_SYMBOL_GPL(mux_control_get);
>  
>  /**
> @@ -523,6 +640,26 @@ static void devm_mux_control_release(struct device *dev, void *res)
>  	mux_control_put(mux);
>  }
>  
> +/**
> + * mux_state_put() - Put away the mux-state for good.
> + * @mux: The mux-state to put away.

@mstate

Cheers,
Peter

> + *
> + * mux_control_put() reverses the effects of mux_control_get().
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
>   * devm_mux_control_get() - Get the mux-control for a device, with resource
>   *			    management.
> @@ -553,6 +690,44 @@ struct mux_control *devm_mux_control_get(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_mux_control_get);
>  
> +/**
> + * devm_mux_state_get() - Get the mux-state for a device, with resource
> + *			  management.
> + * @dev: The device that needs a mux-control.
> + * @mux_name: The name identifying the mux-control.
> + *
> + * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
> + */
> +struct mux_state *devm_mux_state_get(struct device *dev,
> +				     const char *mux_name)
> +{
> +	struct mux_state **ptr, *mstate;
> +	struct mux_control *mux_ctrl;
> +	int state;
> +
> +	mstate = devm_kzalloc(dev, sizeof(struct mux_state), GFP_KERNEL);
> +	if (!mstate)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mux_ctrl = mux_get(dev, mux_name, &state);
> +	if (IS_ERR(mux_ctrl)) {
> +		devres_free(ptr);
> +		return (struct mux_state *)mux_ctrl;
> +	}
> +
> +	mstate->mux = mux_ctrl;
> +	mstate->state = state;
> +	*ptr = mstate;
> +	devres_add(dev, ptr);
> +
> +	return mstate;
> +}
> +EXPORT_SYMBOL_GPL(devm_mux_state_get);
> +
>  /*
>   * Using subsys_initcall instead of module_init here to try to ensure - for
>   * the non-modular case - that the subsystem is initialized when mux consumers
> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
> index 7a09b040ac39..bf5abf062c21 100644
> --- a/include/linux/mux/consumer.h
> +++ b/include/linux/mux/consumer.h
> @@ -14,33 +14,50 @@
>  
>  struct device;
>  struct mux_control;
> +struct mux_state;
>  
>  unsigned int mux_control_states(struct mux_control *mux);
>  int __must_check mux_control_select_delay(struct mux_control *mux,
>  					  unsigned int state,
>  					  unsigned int delay_us);
> +int __must_check mux_state_select_delay(struct mux_state *mstate,
> +					unsigned int delay_us);
>  int __must_check mux_control_try_select_delay(struct mux_control *mux,
>  					      unsigned int state,
>  					      unsigned int delay_us);
> -
> +int __must_check mux_state_try_select_delay(struct mux_state *mstate,
> +					    unsigned int delay_us);
>  static inline int __must_check mux_control_select(struct mux_control *mux,
>  						  unsigned int state)
>  {
>  	return mux_control_select_delay(mux, state, 0);
>  }
>  
> +static inline int __must_check mux_state_select(struct mux_state *mstate)
> +{
> +	return mux_state_select_delay(mstate, 0);
> +}
>  static inline int __must_check mux_control_try_select(struct mux_control *mux,
>  						      unsigned int state)
>  {
>  	return mux_control_try_select_delay(mux, state, 0);
>  }
>  
> +static inline int __must_check mux_state_try_select(struct mux_state *mstate)
> +{
> +	return mux_state_try_select_delay(mstate, 0);
> +}
> +
>  int mux_control_deselect(struct mux_control *mux);
> +int mux_state_deselect(struct mux_state *mstate);
>  
>  struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
>  void mux_control_put(struct mux_control *mux);
> +void mux_state_put(struct mux_state *mstate);
>  
>  struct mux_control *devm_mux_control_get(struct device *dev,
>  					 const char *mux_name);
> +struct mux_state *devm_mux_state_get(struct device *dev,
> +				     const char *mux_name);
>  
>  #endif /* _LINUX_MUX_CONSUMER_H */
> 
