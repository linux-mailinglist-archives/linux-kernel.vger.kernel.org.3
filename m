Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C625521038
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbiEJJHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbiEJJHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:07:05 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150084.outbound.protection.outlook.com [40.107.15.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15942AD770;
        Tue, 10 May 2022 02:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2vsBa7K0WIquKyN9UEKb2yZ4QrQdod0juR6SHnxiyBiEB8zh1C5dBtzlg/FUSorS9z0m/8FIxT+1T3P4WdJad8cIcxEAHqwMG1jXOy4gmS2lyFwXLjC3exvZ2S4/Ro6XvqTfonGx9M4zray0Vs0RCbwVdK6Cc2hfstxtnP5AqjsrNpbG0UNjqf6ORY191Dy4beQqLI/VDoN6mkYCyFQty1HG9jvlkHymuvWcxP2fxC0HKwawx41LFh0Iz4KHT4fzExpnSLXTqShUYkTNnQOfmUCZxWdWx0hdHMOKZ1BKxC7fawzVJxqNyqjJfU4nqEmFGpaFz2MgYR8RX0oFiqRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2N2gDHdI1vq7JzrQUX1BnQNtc+POe9Jit867Dq0ulNU=;
 b=jMWbTP+vegSvgEfwxo0a/tSSEjLd0iB/KeP/VoG51CsEz8LNDPbip3TRMPB5tIeJYeEAXOuF7XSdXsyM8p9FtBuM2Sdob/sL40VsA8GAh/SSumg4hGtj3QgqG9QS+U1B6u0/mlo0ZkCbGFiJzZLdr5X6k+3ZoAY/BV8CqSoMM/Atuxvnk+VdNc3Zterpi/sy2a0ROyExDzLs9ReB1DOvkX+PyKXEr4+EvMt5O9fFQOulOKWGbvPcNkiKhhaStSAV7Z4F33r1btdjD/RMWpX6Ujk3Kgx1bkY1uTQ0L3oilYI90SoOzLkXYbJZVt1c04qrGFX/j7mxpouPJiVHpdh2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2N2gDHdI1vq7JzrQUX1BnQNtc+POe9Jit867Dq0ulNU=;
 b=QnlHdOjwU50W6wSXLcC2tyW4mFb8TZtLJt7uRZAKlCEIk74W5iuzZnrQDhkIfiw7WRjFjRGdIZ+S0Hly48V5lnyRcQxZqmJf6UrBVw01ON16ZK8GjweoyL6UHNZkUId7l7e1mWqRPAB0B0U3ha6NposbW6J19tJt1zhfSa/EBak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8484.eurprd04.prod.outlook.com (2603:10a6:20b:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 09:02:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 09:02:57 +0000
Subject: Re: [PATCH] gpio: gpio-vf610: do not touch other bits when set the
 target bit
To:     haibo.chen@nxp.com, linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <1651920846-31721-1-git-send-email-haibo.chen@nxp.com>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <4b18b894-8f81-8865-06c4-d112aaa85c8b@oss.nxp.com>
Date:   Tue, 10 May 2022 17:02:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <1651920846-31721-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e40b5aa1-abcb-41a8-5e56-08da3263e026
X-MS-TrafficTypeDiagnostic: AS8PR04MB8484:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB84847D69A4B54A04345D29C4C9C99@AS8PR04MB8484.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UESZs/WyJB9FWZSBjmk9plZcBkj3eBx27COgjYlncCRGHXHtmQxegTLb4np4rjCzyzRmodkt1+Z1vIuAD3wZlQZLfQD3pQVUbm0BrsMqaP7jVqd85b6Blz7jPJtuIfvD9nWjhR8SaqYA+AYSwRFQM7OL7HllsdShKQIoQJY4bxDPN+P6gFaJdtSL81oQ/cWboSDsHeekmu5x6XvHabrDdas1Ei3oeoxEt96hskFPPe1WD3RewSUnOMyxPK18Ko6pAtvDUg+rqGCCRwpVnbb5/E+n676BBbqi5diaSyWWovxBTzZFnKUbfUKyqD/GN5FTttATBGyFV/pJZeCMgaulB+bPdasftOmI4wfLz36a6g+rpeqT/GPw2N8jz2jrZ+/9ieJIHp0zzoa4NaF15nD1BQtVMVVHnylLF/mlfx+dnyr+c4LIqK5bgaHHdTWuu9A5BjcrbtCEfQJRzz1n/HkwEP2sLjeCnwjvTlxN47hfyKoiq/Jc7kUEPlWbj7US9+QjuCtzPZDbZES+nn5eG14IeBfzzGlNC0RAI8DXrgh+np6p3O8D+6HzfswQYlaIsnCfeblKPYAW3h8kiL6gaVBpIrfQpgcjhcy3L9hZFbmVgPUQZ9qZudig/EooYp64tzs8k0z5SzyLnKmAFTuUFJ7KcZgK7L2qKjHtmZS3+phUTqwoxLLjOfPRgQBIAb9drfzF5wq6Ry7IIn1Vnp9fXDXOJhs9GUs2U4NrX5jEHri8hzBbvikvvTirLH2mlDauJ6YZAhIAIh6tZ0gFyNSzP+DJ4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6512007)(31686004)(26005)(8676002)(4326008)(53546011)(31696002)(186003)(38100700002)(38350700002)(316002)(2616005)(66946007)(66556008)(66476007)(6506007)(2906002)(83380400001)(6666004)(6486002)(8936002)(508600001)(52116002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnFGeFZHZ3JrcWNZZ1hHRWVIT1dad21GbGZrdUlKeVljZ0p3aXpnQ1FBelo5?=
 =?utf-8?B?dnI5YmQ4VUIrQ1YrejJqSWVxWWNZNGthaUZySGtIc0xNNDhUYnRnSUp3VXdj?=
 =?utf-8?B?cFNnWXl6czNjU3Z0T01MM0syNE5OQjJIdDl2TjZMZERUSUticDA1NXQ3OW00?=
 =?utf-8?B?TWNYbm5xMTVocE9MK1h2Q3UyT2FQVHU4OHBBbnNOcjljRHd1UFFOcDl4Y0l3?=
 =?utf-8?B?L25jeFd3VGNsd2NoMyszV2thZU5sV3RJUFJxaGVUbzhab1JsSGFsOWdVTDNC?=
 =?utf-8?B?Rk40cWY1T1FTSEFyMkdkNzN4NGN6bUJ0TDFZVTRqdjZNd0xLRTIyUmdwSDhB?=
 =?utf-8?B?Vlhka2x0NjE1T3crTm5WL05ZRGVsVkI4SjhPMXRqTEJFYjBRZUpYMTF5SHVW?=
 =?utf-8?B?dU1qaUVGY1dHdDgvSDdUOTNTNjhLRUUwcnBMMlc0TlB6QnowSmcxbTFaQngz?=
 =?utf-8?B?bks5R3FlbUJYTEovN3Y4MXlnZktuMTVMeW0rNStieE1pVFg5cTdhR2c5TFlK?=
 =?utf-8?B?QWQzOW0xMUlUS25wTU9IV2NtQzB0amwxRG8zVWxzTUw0cUpHRWRtNm1tL2lm?=
 =?utf-8?B?UGRQN3UwNkdaK0xlb1cyQ0VkUEpab1JkR0FoQmY3bjZCMmVwR1RkR1dBMyt5?=
 =?utf-8?B?RUV3N2ZIa2pMNTliVEhmZkdwTnAxL295VUl4cDE1WnBFWDF2cWlVeDdEbTV5?=
 =?utf-8?B?QXpuaUF2dmw3YUQza2E4T1JPMElZcUNTNUdQQW1DWWJZNlN1Q0ZteFNsUDNi?=
 =?utf-8?B?UklreHpHTGZIeGFhWXh3YVZtR09hVWFFVVg0YldacUdjbkRhNW1KbkdPc29z?=
 =?utf-8?B?OS9hWnE4SmxXOUJlMjQ3NXVnWmo5YWdwamJLNWRlZ0VzU0FMZmgwWWtIWDhL?=
 =?utf-8?B?MFpMbE1lZThRcTVSeVp6YVFEcUduY1ZjakFLVkNqQ3lEZnRuRFpqeHl2blJ2?=
 =?utf-8?B?dVIzRkVGUm1KSDArYS9EVFY1amhsbzdQRXBNcE1JV2ZmeTdydlpha0hWZUlm?=
 =?utf-8?B?MG5VS09YcVh0SWwwM3oyaWg3aitobmZJbk0rNnhnNTExUm9WQVlnYlcrdU9v?=
 =?utf-8?B?NVVhM3NhTThGdm5QRE9nM0pJZlBrQlJWTUJpbWR4RFFVOXBvajVHNVRHWWxl?=
 =?utf-8?B?YXg0dXp2NitQVSs0eGs1aWpPbFdtR3AwYUJadkYvRy9CcUl5WXpKSk14c21T?=
 =?utf-8?B?dWJDS3NPQ2tNdkNPTzg3dXAzSk5FNHcyUE1CM2ZlWlVteWRxdFlmQUkrSHBW?=
 =?utf-8?B?VEh4WUZBeE94blRVODBvazA5NWw2RSt2aVBNcWRoc1kvNHpTOGdXREdCK0pq?=
 =?utf-8?B?aU1XRlAvS0ZKdDVXcmlkTFBFWkZmU3JXUTdvNVVzY2MrL1k5cnFsU2FpWlRF?=
 =?utf-8?B?TnFZbDdQeUd5bG9UamhDZ1lIbmYzT3BGb1UvWUkveVRTRzZ0TjFnMGsvdUFu?=
 =?utf-8?B?V2RJeVhjL2QvUjNFUWlHT01GVllDTm9GMDNXN0psUWZzK3JBRGh1MDNJLy9L?=
 =?utf-8?B?MURoY2tuYU14aHh4K29HZG8vZnJrZWwzSHdqckRVSTlXeUJoYXpJT2lnamha?=
 =?utf-8?B?d0Z0VHIvdTFFMWZhcFRUZGdOM2t3S1FJYUZ3dmhXMXMzaWxXS3RlZzhiMXhK?=
 =?utf-8?B?dlFDY1RmVUNza2NoWGN4NFgzTm9iYUZKczJYaUhYUHdUYzgvRmdvSTJiTUZI?=
 =?utf-8?B?c3VPTUYrSG1SRGNmL3JYN1ZPMm03TXVPKzZMWDBsNHhmMGprdDh0SENDd3VQ?=
 =?utf-8?B?dFl6cDdTT2tVQW52QWVXRllvSnNQcE9FcCtHMUcyd1NKT3dFeFFid3RTN2lR?=
 =?utf-8?B?SkdSNDArenF2bmgzRFNnV2pRZTNaSXlMb2g0bUR5ajRTVW9VVGZQVU4zMVdH?=
 =?utf-8?B?RWc1dnpCSk05S21mbWtTdmF5NjRHTWlaa00xTTNZOEFuRTdndXFTQUxKSENi?=
 =?utf-8?B?RVVEc2UvQWIydnUwa3YwWElvckYvTTM5dWRUdnp3OTVVNzQreE9jQ2VrSEY4?=
 =?utf-8?B?eXpUTmcyVWhVaTNabXljRmZQZkVEOXRrUGQ2QzdqRmllSllTSzRpelE2RXVU?=
 =?utf-8?B?RTQ5YWdxY3lsVUlUREdxbUtIdmd4eFR0dEkrdnArMDB3ZEFmTzAwcUJGQXlr?=
 =?utf-8?B?R0VLTVVUUFlNemVhRWhUVjFTdHVXK3ZYaGJBY1BZWTkvNDVPRm1KNm9GcGhQ?=
 =?utf-8?B?QzFtWWFnYWUrdFREdC9ReGkxYm5zd25RaUdNV3ZxYmtjTXB5dHhRZjFkQVpO?=
 =?utf-8?B?UzZUTDIreTlGcTljbG13ai9IWEFjVzBxeFIvK1I0YldvbnlJMSs5cUZreDhm?=
 =?utf-8?B?U1ZDYnB3NkdvTTRPelRLL1lwUzhYUDRKeTNwcUdncGtKMDc0UStwdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40b5aa1-abcb-41a8-5e56-08da3263e026
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:02:57.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFQEOG71te9kgwrDxPfWerR9KAJJoBN2O4BFxFl2xzTNQZBBygRqVVxbu1zDIv7kgSW7zXshVk8sWrUNir6X2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8484
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/7 18:54, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> For gpio controller contain register PDDR, when set one target bit,
> current logic will clear all other bits, this is wrong. Use operator
> '|=' to fix it.
> 

A fixes tag required, since this is a fix. With fixes tag added:
Reviewed-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.

> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>   drivers/gpio/gpio-vf610.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> index 20780c35da1b..23cddb265a0d 100644
> --- a/drivers/gpio/gpio-vf610.c
> +++ b/drivers/gpio/gpio-vf610.c
> @@ -125,9 +125,13 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
>   {
>   	struct vf610_gpio_port *port = gpiochip_get_data(chip);
>   	unsigned long mask = BIT(gpio);
> +	u32 val;
>   
> -	if (port->sdata && port->sdata->have_paddr)
> -		vf610_gpio_writel(mask, port->gpio_base + GPIO_PDDR);
> +	if (port->sdata && port->sdata->have_paddr) {
> +		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
> +		val |= mask;
> +		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
> +	}
>   
>   	vf610_gpio_set(chip, gpio, value);
>   
> 
