Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCBF4D2235
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbiCHUKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346885AbiCHUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:10:15 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD60C3818F;
        Tue,  8 Mar 2022 12:09:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wtxh/9dAQclbK212RSw8UDQTS0FUV9CipmSnHUqN7SwH3EDLGhX9nInfM3QJ6dyx2Qv3iAEhcakPCKhUiQDYd0+oZjVP5PE+SJt1HgCbwZgt1R1vGBv2VKmMLOe7slQ1E73aE32Xfd+XLdxVZ5ymusS2dHJi5CGJQGmp9xi0JvmvtbUjKm7O+QFstF//x5Xr9l3LKQx6TjwCjqr4rK0L2fymxEOSTxqF/WkIijLWR3P0Pvq0CbvrtqIpkmCvQXos+MVjC96eJIC7o5y8xaxYRr/HERBMvM0To6Nv8WVDA83/Zc59N5RKMUx/rlipmxCWPXQVQRlqjxdr/rWtdLaU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTaPshbUgWsS+/A5lBRI9iYlQTJKr73aohHFvDeVIGY=;
 b=WyigJQKEPIBFtSHZ+c1tBiXiSXXknYFFj8H9Z5ePklB8BeMMIMMMabUQdRk51jz6V7hSquplGWiO6S2PYeF7MPAKvS2/PY9n2uWfqMa4OPIF/BKK/kkC9e7owWJmYHvgzdsoOlgvWrp188Mkw2YOQl7NR7yyx3EVKa6qAGElliI1hWtGT5bWuPcQcoi5feE1SrO8Ax+1em/4NUxftakhCCfuB8VcSH+2S5NVLUbS9vPKKDtptyeOXvo3Ti8wrb8a028ZPQ61IWWn5KqUGCEwd9j719swcnxfjrJ2ZZ0rYQ7wzkWy69UvP6sd15djxMCGVozlKwJateI0Y1fNVMmazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTaPshbUgWsS+/A5lBRI9iYlQTJKr73aohHFvDeVIGY=;
 b=YO0gF+tcTH1CVvGP90gJr6oUVKGxFIMJ8MHjphXmC8A+mm+kXaHet8ptSXsJjzVJC8B3XBvpgcOGwVFu/Aaq6fS+2U70H922TW5X/WziPcM4qPoifugXQihsN5TEvYiTn1DFvFHZssq5/+nhT+CyRYeEE0b0KxCuVd8PwD7f7lxO1VAiHSzQWU4y9IcnSrObjf6+TnBO39nYpTEPANSN/74/0Tascbxa/xpGS3YKyxU9itT4HrIwrc0St+oYwhlBDmrQqEcRNfDtMeRRuHiYHOxSe527bmCiGjDJKL9lo4zNS/jgnjfBlCX7tFDTHLSrww+WzmuOyezjaYMPuybSaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3459.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::20)
 by AM6PR10MB2885.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:ea::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 20:09:15 +0000
Received: from AM0PR10MB3459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d433:79c4:958b:1551]) by AM0PR10MB3459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d433:79c4:958b:1551%7]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 20:09:15 +0000
Date:   Tue, 8 Mar 2022 21:09:12 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH 1/2] simatic-ipc: convert to use common P2SB accessor
Message-ID: <20220308210912.20cf8cab@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220308193522.26696-2-henning.schild@siemens.com>
References: <20220131151346.45792-1-andriy.shevchenko@linux.intel.com>
        <20220308193522.26696-1-henning.schild@siemens.com>
        <20220308193522.26696-2-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::10) To AM0PR10MB3459.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:155::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 658e1b6d-11ed-4bf7-69df-08da013f84d2
X-MS-TrafficTypeDiagnostic: AM6PR10MB2885:EE_
X-Microsoft-Antispam-PRVS: <AM6PR10MB2885B0CFB1B5AAF2E7F5A06F85099@AM6PR10MB2885.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfEI/O67+AMQC/Q79NXS84qbfOwmPwE2MABT9OfP7H0qrU8lrAsmpM0GJtFuyJVCaNPf+6H/B8hPorwwg5D0NugGN3QRvOnPc4/u4lJjGWriEF/JcOIJKp4oEUsMiqsLuYIN0M9qBQgebWW10hOZNAy2L5ptT79tUZSI6LTtSOmegfvTCrYH3/uL/7Hw8UdZH1JZo5/zlhm16ic1wQM9zytV93KT61ffLEzWQm6hQKAK0W69tPPR33LuLfH5n2yrTQAl+DvH1aYVvnXVsglwS3qOe8N0rsE+1HYCsQ40VeVRM2AEZpJiXq+Tk5gp3MWnvLvrwwEZbyy/j9xcsIDZjqld2oKuBhtHKKNunYPGfn9l/0p4LGvnbL0GfwXcJFV7IsKNiausEurNGgToEOILA4FsB4tprNsVB2cUe9YSrY3TU2wpv+XcQICT//Bn+WlLJBO+zuMoo7Ox69ll3jvi3l3IaVi5Dbivu9P+eCtIzBG9AxkomgSufcKGAuirUwIc0sYvyKB/J70p//QFZjAVFk2T+Kx12mZd7O1UeB+LDE9oIjRbqfL1Bos6pzO/+vTUxILB2N9tKqqL1BUW8ZGFTkiBTtSzgo/AZOWE3LjqkgH5nKiUelBQ75d3lnOPDRWxqzYsg8imQxHhBCNrcdEIkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3459.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(82960400001)(83380400001)(5660300002)(66556008)(66946007)(2906002)(4326008)(66476007)(8676002)(8936002)(44832011)(6916009)(1076003)(6486002)(186003)(508600001)(107886003)(38100700002)(54906003)(9686003)(6666004)(6512007)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MaF9COSToYqCwBzdPRAukAHEvf4fcRrjNX8ftELoo3Ljc5SrhAE8epbMfD49?=
 =?us-ascii?Q?fPYpDwzRvrSIhunDpRKFTTlFU9m0AcdIB0vH0txkzFzNnAOVPNonWhZBt9Wr?=
 =?us-ascii?Q?Dd0Op/lR2g8FT/Ic5hQDrANQ8ywZMD6tR1DWI6FSjvIKJW3BY71VxW6vVEmt?=
 =?us-ascii?Q?ChiF1VF+jfVsIUdrUizMR8QLV9UQBHxT0QhoDHZeCschyX1myTx4ncHo7V+u?=
 =?us-ascii?Q?DW+Ybs1zRaBBAg/aeamU2/7bzUTKzLqVVIhPYVswnlzLhWZL0GdTczthyqtH?=
 =?us-ascii?Q?wghe5SqgYWf6CHcrliu2r6jOk97HkGNuUBHUJFhMItMR0XVgePg5dt+G7D64?=
 =?us-ascii?Q?/zW29tDZTKFU5WIfQa5OtWhKryaAtIQ/GO7c9aY1oQ5Gv/oQuO8PG+E7CAlr?=
 =?us-ascii?Q?GUS+6Qb/HgLIfREaHjd0UERzfBiifrUxV7g2+afK2upx5kMMgvZQ6Xi+/Nbh?=
 =?us-ascii?Q?LMnfp7FAWks9U6NTKT+yCkaP4etWlCKvaiSTaPTgQRGiYqh+VrUUAyXxAkDU?=
 =?us-ascii?Q?wFgJ7iJGQX3pQh2c8sy6glM+TwtGEaKdk66JJENIlAlq8SIEdCUZ2kF3+yyF?=
 =?us-ascii?Q?2R4eKdmhLRy9nRYRcGVC9cEDZktT54RC5NjVirkWpp1cTSaqvqgPOqjxm0m2?=
 =?us-ascii?Q?EcU0psXdb0TW16bOzzEGWw0V9kKT7hX1fZruGbHudL8x0rwA4bERKRBUQl6E?=
 =?us-ascii?Q?MZuQlMEqZ2QrFIJprXnEf4Zn8qzZ1OmZbLm5xtJhKelq7FjlbZMH0e2OCy24?=
 =?us-ascii?Q?C8llq2kYerRPG25xwBx6YO0w3CBzox/pj3WyYui1tnKI9BjR+LcImWg+6ZA7?=
 =?us-ascii?Q?o1MKOXQsjdVXVLjrHYyt11C7sDNd28bVbyNwZN4nkQz+M6q5PV2fjShSg3Av?=
 =?us-ascii?Q?ifg7rhaw+kgTdULVi1MdXy2glJmijuhSDFBmvt4DHQAKyH9rQhEFXkkSaLeE?=
 =?us-ascii?Q?s2i67GVFqRaRMy8qcDyg2OFM1KrxvULR0x3yOmgg9MqsiuIZOZ+wStdCsv5i?=
 =?us-ascii?Q?kKU4hEETl7SXNtVnEqDQLQHH+KrYoW6yBXczxU+3YDQnX3uEVHYWPoyKFEIs?=
 =?us-ascii?Q?jwFD6Urg715Xz3kfs6/zj1BJUc3+DTeinE0McnOh3bWmwanSv4KS4te3JCL1?=
 =?us-ascii?Q?HUbI2IDglNLvgrGUGPqk7KatppPdztlqz/Nqn5sIq6oiFGDBVfq633SmzqWf?=
 =?us-ascii?Q?PhKlDnvVEVjD08EvFfZdCC44v8JlcAgDXWnc6iUZwyEG7aGOoTnrw1LGxqeN?=
 =?us-ascii?Q?WuX/UR8Y03AYymcI8VCn5xKnK7XDvy4JKIOH6RiFtJ3Kb+bhSKhSg08vqwF0?=
 =?us-ascii?Q?k4CrefozfNpF5Iqn6UCK5BA3lwWI2LN+qiTDvL4t9iTK3il3Xspx/NjfmXDl?=
 =?us-ascii?Q?Gg0GTKoQL5QbBAIMjvb1d1gZcbdBCshhIpuDBvLzq2YRdN4iN4iAQ0/lVpYd?=
 =?us-ascii?Q?8YTXx8FF3OU5DSMs9CgiJ+sE5OIgwrjOJOgwP7HfxzonvZJmWsN9Y9bzD0n8?=
 =?us-ascii?Q?pfKXNh4vE8fpqppXiH59TZRPkZJSC11SD3PZsTRJibMqIKMDPj1+lynv6o0X?=
 =?us-ascii?Q?ATS9lH+zeDb0I9fcdQ8HLzfoY4cg69maTr9N2KW8Hx71oxWiLTcaBYCMJ+67?=
 =?us-ascii?Q?7+otGm/kMAs4mGjW8PnRXANn8X8FnpyS8zZ9m4aLPXcrdg4KF2Zvvq98o/em?=
 =?us-ascii?Q?gXU/sOaftV5qJCQYul9iO6Z7fy2oUAmcRk3+SreMKmpiGB3d5FNqzrZp4Vx9?=
 =?us-ascii?Q?+wTI6DjYS914f2PoVI6F9KL2mZcEJ/Y=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658e1b6d-11ed-4bf7-69df-08da013f84d2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3459.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 20:09:15.0702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeZH4PsYHd/q0cvPvTRcSmgWbipYcpf8yvqQ0dEJpxQ1WKodM/HvR6BcJyHhd26i3RhOJSzrwwX7UmMFSY69o7NZtTMVCb5pXimOuNYBWME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2885
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 8 Mar 2022 20:35:21 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> Since we have a common P2SB accessor in tree we may use it instead of
> open coded variants.
> 
> Replace custom code by p2sb_bar() call.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/Kconfig                   |  1 +
>  drivers/leds/simple/simatic-ipc-leds.c        | 14 +++----
>  drivers/platform/x86/simatic-ipc.c            | 38
> ------------------- drivers/watchdog/Kconfig                      |
> 1 + drivers/watchdog/simatic-ipc-wdt.c            | 15 ++++----
>  .../platform_data/x86/simatic-ipc-base.h      |  2 -
>  6 files changed, 17 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
> index 9f6a68336659..9293e6b36c75 100644
> --- a/drivers/leds/simple/Kconfig
> +++ b/drivers/leds/simple/Kconfig
> @@ -3,6 +3,7 @@ config LEDS_SIEMENS_SIMATIC_IPC
>  	tristate "LED driver for Siemens Simatic IPCs"
>  	depends on LEDS_CLASS
>  	depends on SIEMENS_SIMATIC_IPC
> +	select P2SB if X86
>  	help
>  	  This option enables support for the LEDs of several
> Industrial PCs from Siemens.
> diff --git a/drivers/leds/simple/simatic-ipc-leds.c
> b/drivers/leds/simple/simatic-ipc-leds.c index
> ff2c96e73241..215ef5b74236 100644 ---
> a/drivers/leds/simple/simatic-ipc-leds.c +++
> b/drivers/leds/simple/simatic-ipc-leds.c @@ -15,6 +15,7 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/platform_data/x86/p2sb.h>
>  #include <linux/platform_data/x86/simatic-ipc-base.h>
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
> @@ -38,8 +39,8 @@ static struct simatic_ipc_led simatic_ipc_leds_io[]
> = { { }
>  };
>  
> -/* the actual start will be discovered with PCI, 0 is a placeholder
> */ -struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0,
> SZ_4K, KBUILD_MODNAME); +/* the actual start will be discovered with
> p2sb, 0 is a placeholder */ +struct resource simatic_ipc_led_mem_res
> = DEFINE_RES_MEM_NAMED(0, 0, KBUILD_MODNAME); 
>  static void *simatic_ipc_led_memory;
>  
> @@ -143,14 +144,13 @@ static int simatic_ipc_leds_probe(struct
> platform_device *pdev) ipcled = simatic_ipc_leds_mem;
>  		type = IORESOURCE_MEM;
>  
> -		/* get GPIO base from PCI */
> -		res->start = simatic_ipc_get_membase0(PCI_DEVFN(13,
> 0));
> -		if (res->start == 0)
> -			return -ENODEV;
> +		err = p2sb_bar(NULL, 0, res);
> +		if (err)
> +			return err;
>  
>  		/* do the final address calculation */
>  		res->start = res->start + (0xC5 << 16);
> -		res->end += res->start;
> +		res->end = res->start + SZ_4K - 1;
>  
>  		simatic_ipc_led_memory = devm_ioremap_resource(dev,

After "mfd: lpc_ich: Add support for pinctrl in non-ACPI system" this
will fail because the region will be claimed by pinctrl, did not check
if it would work with !CONFIG_LPC_SCH.

But not a big deal and was expected to happen. I do have a version that
will devm_ioremap (no region) but that seems too hacky to put here.
After all the next patch will remove all that and switch to GPIO.

If we have to propose things in two series i propose to make
CONFIG_LPC_SCH and CONFIG_LEDS_SIEMENS_SIMATIC_IPC conflicting for
intermediate steps.

regards,
Henning

> res); if (IS_ERR(simatic_ipc_led_memory))
> diff --git a/drivers/platform/x86/simatic-ipc.c
> b/drivers/platform/x86/simatic-ipc.c index b599cda5ba3c..26c35e1660cb
> 100644 --- a/drivers/platform/x86/simatic-ipc.c
> +++ b/drivers/platform/x86/simatic-ipc.c
> @@ -101,44 +101,6 @@ static int register_platform_devices(u32
> station_id) return 0;
>  }
>  
> -/* FIXME: this should eventually be done with generic P2SB discovery
> code
> - * the individual drivers for watchdogs and LEDs access memory that
> implements
> - * GPIO, but pinctrl will not come up because of missing ACPI entries
> - *
> - * While there is no conflict a cleaner solution would be to somehow
> bring up
> - * pinctrl even with these ACPI entries missing, and base the
> drivers on pinctrl.
> - * After which the following function could be dropped, together
> with the code
> - * poking the memory.
> - */
> -/*
> - * Get membase address from PCI, used in leds and wdt module. Here
> we read
> - * the bar0. The final address calculation is done in the
> appropriate modules
> - */
> -u32 simatic_ipc_get_membase0(unsigned int p2sb)
> -{
> -	struct pci_bus *bus;
> -	u32 bar0 = 0;
> -	/*
> -	 * The GPIO memory is in bar0 of the hidden P2SB device.
> -	 * Unhide the device to have a quick look at it, before we
> hide it
> -	 * again.
> -	 * Also grab the pci rescan lock so that device does not get
> discovered
> -	 * and remapped while it is visible.
> -	 * This code is inspired by drivers/mfd/lpc_ich.c
> -	 */
> -	bus = pci_find_bus(0, 0);
> -	pci_lock_rescan_remove();
> -	pci_bus_write_config_byte(bus, p2sb, 0xE1, 0x0);
> -	pci_bus_read_config_dword(bus, p2sb, PCI_BASE_ADDRESS_0,
> &bar0); -
> -	bar0 &= ~0xf;
> -	pci_bus_write_config_byte(bus, p2sb, 0xE1, 0x1);
> -	pci_unlock_rescan_remove();
> -
> -	return bar0;
> -}
> -EXPORT_SYMBOL(simatic_ipc_get_membase0);
> -
>  static int __init simatic_ipc_init_module(void)
>  {
>  	const struct dmi_system_id *match;
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c8fa79da23b3..ce44a942fc68 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1628,6 +1628,7 @@ config SIEMENS_SIMATIC_IPC_WDT
>  	tristate "Siemens Simatic IPC Watchdog"
>  	depends on SIEMENS_SIMATIC_IPC
>  	select WATCHDOG_CORE
> +	select P2SB if X86
>  	help
>  	  This driver adds support for several watchdogs found in
> Industrial PCs from Siemens.
> diff --git a/drivers/watchdog/simatic-ipc-wdt.c
> b/drivers/watchdog/simatic-ipc-wdt.c index 8bac793c63fb..6599695dc672
> 100644 --- a/drivers/watchdog/simatic-ipc-wdt.c
> +++ b/drivers/watchdog/simatic-ipc-wdt.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/platform_data/x86/p2sb.h>
>  #include <linux/platform_data/x86/simatic-ipc-base.h>
>  #include <linux/platform_device.h>
>  #include <linux/sizes.h>
> @@ -54,9 +55,9 @@ static struct resource io_resource_trigger =
>  	DEFINE_RES_IO_NAMED(WD_TRIGGER_IOADR, SZ_1,
>  			    KBUILD_MODNAME " WD_TRIGGER_IOADR");
>  
> -/* the actual start will be discovered with pci, 0 is a placeholder
> */ +/* the actual start will be discovered with p2sb, 0 is a
> placeholder */ static struct resource mem_resource =
> -	DEFINE_RES_MEM_NAMED(0, SZ_4, "WD_RESET_BASE_ADR");
> +	DEFINE_RES_MEM_NAMED(0, 0, "WD_RESET_BASE_ADR");
>  
>  static u32 wd_timeout_table[] = {2, 4, 6, 8, 16, 32, 48, 64 };
>  static void __iomem *wd_reset_base_addr;
> @@ -150,6 +151,7 @@ static int simatic_ipc_wdt_probe(struct
> platform_device *pdev) struct simatic_ipc_platform *plat =
> pdev->dev.platform_data; struct device *dev = &pdev->dev;
>  	struct resource *res;
> +	int ret;
>  
>  	switch (plat->devmode) {
>  	case SIMATIC_IPC_DEVICE_227E:
> @@ -190,15 +192,14 @@ static int simatic_ipc_wdt_probe(struct
> platform_device *pdev) if (plat->devmode == SIMATIC_IPC_DEVICE_427E) {
>  		res = &mem_resource;
>  
> -		/* get GPIO base from PCI */
> -		res->start =
> simatic_ipc_get_membase0(PCI_DEVFN(0x1f, 1));
> -		if (res->start == 0)
> -			return -ENODEV;
> +		ret = p2sb_bar(NULL, 0, res);
> +		if (ret)
> +			return ret;
>  
>  		/* do the final address calculation */
>  		res->start = res->start + (GPIO_COMMUNITY0_PORT_ID
> << 16) + PAD_CFG_DW0_GPP_A_23;
> -		res->end += res->start;
> +		res->end = res->start + SZ_4 - 1;
>  
>  		wd_reset_base_addr = devm_ioremap_resource(dev, res);
>  		if (IS_ERR(wd_reset_base_addr))
> diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h
> b/include/linux/platform_data/x86/simatic-ipc-base.h index
> 62d2bc774067..39fefd48cf4d 100644 ---
> a/include/linux/platform_data/x86/simatic-ipc-base.h +++
> b/include/linux/platform_data/x86/simatic-ipc-base.h @@ -24,6 +24,4
> @@ struct simatic_ipc_platform { u8	devmode;
>  };
>  
> -u32 simatic_ipc_get_membase0(unsigned int p2sb);
> -
>  #endif /* __PLATFORM_DATA_X86_SIMATIC_IPC_BASE_H */

