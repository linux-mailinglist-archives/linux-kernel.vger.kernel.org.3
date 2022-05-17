Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED952A4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349003AbiEQOeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348940AbiEQOdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:33:55 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B8F4F9FD;
        Tue, 17 May 2022 07:33:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J38wd3VonpJefDtthwXiww3lLWQCS1fv/1vCedaqJpXXF6yCtfUGO2K1CbQ2HCCJrWnGrPOG08WD1lLMkv7FHU8syxKaZn0CELdcOyIK1xRdBDwytyDs6MWdgS79M2GxVcvrCu4C0o8Q13ei6lB2tq2GBV4CmoIaJUeYnGTduX2cG5dSpmVYNUNvdaeHfBEs3o7AHx+ooUOV20IvAAPXUJg8kKQ6+Y8XGV5pFuQuRqbdFOvCDiNsQeiGpuc55B6bCAwlhQspSmhBhp7NJx/8lAvxojA0kb7Iy3R2HLS/wfDBWBKvGrkZKJl1cL3xWAas8kc+yLRcckJ4uzx//Vq+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6j92IZ9QzXoqnu4bfRd5JKQxDys8j0bHudIod3TmtM=;
 b=DvVd4M7uoK2frCsS/RK9Rn/zhTBkgDU0tmG1JfS/HdczCSVIZ0Q37RBOLfGjdl6td122eFSjpnJ3edZkst2q1ywKOfa5ZQnQjDPQbAj5Hy+MeFIksA/Bbqth7SzuOGnFHIEOIAWCcF46EsbASen8DTuFHIam24/JLR+z/Qyud+Mp9RQbJ4ZNvxsRtDJZc+PAAEoZRApwleZxxYmCHcqRlAAFPBIRWMkGkvEyzXUIjMj27kZuUJ4AXArIfryHKVJhauAasTNLGyZDFx3tp0ScggbIWqOif9fwPQscqW1dd9gYsCx9o7u/CfjjpeM4XVpsYX6pDGx11CUBT+2Smy3vrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6j92IZ9QzXoqnu4bfRd5JKQxDys8j0bHudIod3TmtM=;
 b=Ls59krjSXhVwAJdvXmbwuOheD96M/WGKzHdzETxuNIBIkutpbJLn1OgJacY7bJqONH9D1wRPp1WTwBjym5Y0U3hqk9hZgakeA+RMSY6smdCXjrehPbnIa7vMwQfyKt+dZzGA+Sh03K/DsILXGzaYJRsS7XrJCJclSXKEecbBXzi4DciM7hsxY2/K2azC3Q2wXhG0XtnZTVIz/CxxiJrqgOrTjHeibI6/cBSnLV4oBDaGEvK7dakUg/XjY0yad3bwj/UEGciO1WGVhPk6B6wDDkKh4be3q0dY/yrRMxY9abKTOX0g4+w8lzXQiZbvmXc9NYii9oH4HDdhaX14veVcZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by VI1PR03MB6317.eurprd03.prod.outlook.com (2603:10a6:800:136::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 14:33:50 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::cc0b:c665:8330:89bc]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::cc0b:c665:8330:89bc%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 14:33:50 +0000
Subject: Re: [PATCH 1/9] serial: uartline: Fix BRKINT clearing
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        linux-kernel@vger.kernel.org
References: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
 <20220517110737.37148-2-ilpo.jarvinen@linux.intel.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <d96ccec0-f95e-4f56-a12c-c7c0461a1e7d@seco.com>
Date:   Tue, 17 May 2022 10:33:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220517110737.37148-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:208:23e::15) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dc1a467-0e7f-4046-6493-08da3812428d
X-MS-TrafficTypeDiagnostic: VI1PR03MB6317:EE_
X-Microsoft-Antispam-PRVS: <VI1PR03MB63173ECF87DECAA4CCB9C02B96CE9@VI1PR03MB6317.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXIaDWCPI6FG0QKXY+XCqsnE2Sc8GC5DFJJOURzEW0k4KKK/UJgUPUfp83UAHnH5W/SG3L5ip7N0fU36hz6QH5cQcCvg1RmCSmH5plAHiqLE+rGdecBsSvlxEubcpOY4pm3gEsQdlsKFWUhi9e6p1fYYuzIVrTdzQ5wY5vOcRubsnzrQDvdXGDWxigrvmJkWW4He2KGBkmaYP9UxxbUGZ3o4vmO4tdRAQ7i9xhHk2M++pmyFDnTJyPQv6l2Dlgs/ndFdZTqVXr1zLHEdotf5FlN88X3FbUaTBUXiAQmE9gcavGnt7CpVqDS/kGJMxFefNSZYxofb4taLTODZus7pT2I71Ta7IuQbLp5DFox3C4nXnkCS6RH0+kichS84NrggmtPoa7ob6pJxDM5Uhb7hA+alrEya+mMYP0N6kTM5MCy3WqKMbb/b9fJdV4+kgQPRYBGsluMJlXIpvSTNFCOqkuGvRAM8OPN34iltSXJFu7H6btKpF6Elfik8MI7KPJNBFZOGustdbnz90ajHbtRuh+HYu7UVlf8BtG1F73/FnsBzetOy06Vziy/uGfwJOXTvWgyHtm9y7f+eD2gyKpw69JfwBTHswS1k1zyP6/hG14WwHdX0nWLpijtpLYIEud9/U7cb6difK9iMtuZTReBWHKeVzDMsGqz+dQ5JWWfMkCDHYZWxWz5WeBxusWolW1+3yglouqC2spV/yLJ+DLpFkoWTl7hO6pqntXhysTl0FV5LYx91jUcKz9+ZTFDQhePH4klKmolP6XcDPEOv3eZJBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(83380400001)(110136005)(52116002)(31696002)(6666004)(186003)(6486002)(2616005)(66476007)(38100700002)(8676002)(53546011)(2906002)(66556008)(508600001)(38350700002)(44832011)(316002)(66574015)(26005)(8936002)(6512007)(36756003)(6506007)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0F5ZGo4VjRSSWp4MlV4Y2RLbndrYkNDNU50aVZoaXNsMVVmZUNRelF1cjMv?=
 =?utf-8?B?VkZyaE5vUHZPd1RJOVlzd0htelA0Tk8rSzNKRnVzYVJPMmtydGtQRWYwT1Ar?=
 =?utf-8?B?U1lUTWM5VEZKRWlvVUpKN3hSd1o3V2FjLzdlQi93dTdSNHF6UURteGZXZThP?=
 =?utf-8?B?RnVXR0JSb2I0UUZHaWxwSE1mUWFQZTRFOWt6ZmxhS2s1NzcwWDF4bDdock40?=
 =?utf-8?B?QndsNGtIOW4yR2lhNkVZd3VPVkllTkErNWE5d0lKWkkxVFR5all0VXpMVWJR?=
 =?utf-8?B?R2h0YThtY0E5bTkwQU5qcEY3NEE4amZxMzZscTQ5UW9HTFkzM1RCUmFUT2wz?=
 =?utf-8?B?L3R4ejllclQ3ODUwTWpla3pWdXRZT3VWMlB6UmRGZ3dleFM0ejR6WGRsWERj?=
 =?utf-8?B?WXZyaEFEL0J2UEcveVpKRDJGUXFJakxNaDNiS3hkSFVOZGp3OHFINHE0ZGw5?=
 =?utf-8?B?QkZLWVBob1hER3RTclRqUnBVVlhCek4vSzV2eEJaOGxWK0ppRStETmYxN3Jk?=
 =?utf-8?B?KzhCekw2aWhmVk1McjYrVDU1OVB5U05zb2VFYTJNQTBadjA3YTZrVTBHN0wr?=
 =?utf-8?B?Rk1kK0I4SnB1UnptT3ZldEkxL0ZYczU0eWVsS0QzOXdLNEd4cjBzdzR1cFlP?=
 =?utf-8?B?Y3diM1dEeHVCNU5sbzl3UEtJWVkybVlQTCt5S1pVZ3V5a2J5UmV0WnFvb1Y5?=
 =?utf-8?B?ZHNDWGJZYzhIR2dPM1hFQll0bXhwNWRtS2wxN0cyMnhpeU5rcG93Zk9GQUkz?=
 =?utf-8?B?SmRWVFBtMDdGeDE4dUo3eFVLWnNNYmF5cm1jQ2E1TzRLYTdoK0ZDTEszNkRw?=
 =?utf-8?B?VnBkWXJYMmQ0M2dKbjJuVmVPeFNoZjd1V1YvZ0FhOVVjUU5Lc3lHb3JBRVpT?=
 =?utf-8?B?U0tpenFXRlc0U2oxalNFUUNjWXZUYWNwLy9ZeE1YZU1IYzNIUkNxSnM1d1M1?=
 =?utf-8?B?SGRyQWNTMUxmVkt0bmQ2bTc2RFBjN00zSE92aFRSMDYwZ09MZ0l6UlVaK3dW?=
 =?utf-8?B?R2dMa0U3bmdoYWtkWVZ5d2piUDNDZEF2YnVIQkNUU092SHN6WXlBcmIrNlo3?=
 =?utf-8?B?UEhxQzBBSTBoTXpQN3cxMFlwVXNHQ01pMkJ2UjZlK0E1a2ErSnJQQVV1MENQ?=
 =?utf-8?B?bHdwUkpPUW15REJyclE2N0JMd01pYWxkamtYQ2VQYkxxODA0Vk9vNWRiTEFX?=
 =?utf-8?B?VmNpNDF6a200U0NOUThQeG42aTJ1V3JOK3hydkdad0R3MGZGekl3WlYvQXBY?=
 =?utf-8?B?ZW5RcEFtR2l0U053ZnZwL1dRWGdOUnNNdE5yT3E2dk83MExWY3NIT05EWGZj?=
 =?utf-8?B?SkdiS2dzS3BIa0d4NzRVcFRXckk1Ky9mcWF0MDlpQWoxRU5RT2JqTSt1aU9D?=
 =?utf-8?B?TXFVM3RWeW5lbU9jYzNVeHM0Z0hNc00rajhqWVRWN3oxN0FxWVdTZ3h0c2J1?=
 =?utf-8?B?TmxjaE9RRy9IR3crd3FLN3cxT0hFdy8rVE5EUEdxK3ZhcmtGSklhQTFseGhm?=
 =?utf-8?B?YUdBQis5N2tCUFlkdjc5VEhZenRuUWZrekVzNURpamlUK2JhRnpmTWlKWUQy?=
 =?utf-8?B?ZHFucHU4T01VZk1OY2JpMnNRQnVhTzM3RGVqYVNXZE0vUnFkUlBmbS92czBB?=
 =?utf-8?B?OHMxa3k0ZldGSWZndmRoYjhBSlFQQlRKM29TcWRJd2tGYjdYZXZ3ODZhTDFE?=
 =?utf-8?B?QXd0dHZrTFdUcjg4alRFVlEzTlJXamJFa1I3N080dUJ6S0pEeCsvS1piUmpu?=
 =?utf-8?B?M0YyeUNzaUZjbWRKN3hVdGJvckJ5SkVObnZwRnRBQ0NjaTRlemlTT3B1U2xU?=
 =?utf-8?B?MFA1ZmxIV1l6L2ZQa0RBczlCNWhrcmFsQVI2cTdsRFBTdDRmdFQ4WnVDcTB1?=
 =?utf-8?B?cGEzejBId09KWGFPSWZWRGVNMVFDb3kvcVNkL2lmWFlONzVoRkN4d24wWXFL?=
 =?utf-8?B?am1RbDRmV29LUEdpNms2QW5rbGZMUXRFbFBOTm9WbW5Uck1Cb0dtVHRidEEz?=
 =?utf-8?B?cnBwRktsWTdGT3pkeno2clhKeVVFWFUvWG1ha0lwRUUrM2NpcFMvdUJBS21P?=
 =?utf-8?B?S0wyTHQvSTNoYUdoWUw4d1JHSDg3Zy9zZGhjd1VreEVVRFpMZElhaFVUZnU4?=
 =?utf-8?B?WmFnU0U4RlRlR2I1b0FhYjV3eFl4RjNwbVc1Q1ZVWFFjZXlaWmtIeFJtR1No?=
 =?utf-8?B?RVlTSjVmWURrMUJnZ202SmcvZ202L3NKa0NjcGlEY0F4R1VLNkhnYVVycDZ5?=
 =?utf-8?B?Mk5hbHpoeFJFN3Z5Z2ZVakYwWHc4aEdENG9UakU2SWxCM2YyV2I5Q3h0dkdW?=
 =?utf-8?B?TUNjbTM0OUlqek1ZYVFjZjRiTkxabExaemRpY3poOUJid0dyOGRtdXhmTUd1?=
 =?utf-8?Q?L3x0yVlzSgVqIcww=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc1a467-0e7f-4046-6493-08da3812428d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 14:33:50.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aE4vMPHJRPd6fjFysFlgaLg5slMwhChc+E33aYcbHgj6Fo+yjCU2QRMdGz9UlTH8ZktJL230SnEhT+592PPs7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6317
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/22 7:07 AM, Ilpo Järvinen wrote:
> BRKINT is within c_iflag rather than c_cflag.
> 
> Cc: Sean Anderson <sean.anderson@seco.com>
> Fixes: ea017f5853e9 (tty: serial: uartlite: Prevent changing fixed parameters)
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/uartlite.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index 007db67292a2..880e2afbb97b 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -321,7 +321,8 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
>  	struct uartlite_data *pdata = port->private_data;
>  
>  	/* Set termios to what the hardware supports */
> -	termios->c_cflag &= ~(BRKINT | CSTOPB | PARENB | PARODD | CSIZE);
> +	termios->c_iflag &= ~BRKINT;
> +	termios->c_cflag &= ~(CSTOPB | PARENB | PARODD | CSIZE);
>  	termios->c_cflag |= pdata->cflags & (PARENB | PARODD | CSIZE);
>  	tty_termios_encode_baud_rate(termios, pdata->baud, pdata->baud);
>  
> 

Reviewed-by: Sean Anderson <sean.anderson@seco.com>
