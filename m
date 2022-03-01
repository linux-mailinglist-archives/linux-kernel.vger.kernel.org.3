Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A243A4C8C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiCANSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiCANSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:18:44 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D943EF3E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:18:00 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220301131755euoutp01ac7f29e4e21c73a3b00759bfc328efe2~YRDj1VKpH2288222882euoutp01y
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 13:17:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220301131755euoutp01ac7f29e4e21c73a3b00759bfc328efe2~YRDj1VKpH2288222882euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646140675;
        bh=RFRYDTItJPdh/YtgDLQoy2aBC1+Ncipe/6U+zaeuePw=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=aIkH1FqqBKCVCpHVdHzF44X2DRIGDhPk5oNLr7/nYc0KuI0xfxNNaekhGQ5qIXskB
         JQk7h43hgnY10VjoPbS24nIpYn49mI0Xs+DRMWd9k/qx16sIfg7dQu8msmF/xi+4ZW
         hPJu+ox6XleypmJSdXAIN3sjlG3jkIPabXUmFcOk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220301131754eucas1p1b6deea8652ce4ec547d9a45fb2baeee6~YRDjivsfd3185831858eucas1p1i;
        Tue,  1 Mar 2022 13:17:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C4.5E.10009.20D1E126; Tue,  1
        Mar 2022 13:17:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220301131754eucas1p1b8d762c90f4677b92a305f3eefec761f~YRDi5mTrQ0165801658eucas1p1b;
        Tue,  1 Mar 2022 13:17:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220301131754eusmtrp2baa54d4564a8bc6172510fa33af157db~YRDi4ethb1822018220eusmtrp2g;
        Tue,  1 Mar 2022 13:17:54 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-de-621e1d026977
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.43.09404.20D1E126; Tue,  1
        Mar 2022 13:17:54 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220301131753eusmtip11201b59346ddd972961f28c111d6b979~YRDiPHyNC0062800628eusmtip1c;
        Tue,  1 Mar 2022 13:17:53 +0000 (GMT)
Message-ID: <180d7038-4ae2-80d4-0760-4be24ec11836@samsung.com>
Date:   Tue, 1 Mar 2022 14:17:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH V7 3/6] tty: serial: meson: Describes the calculation of
 the UART baud rate clock using a clock frame
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220225073922.3947-4-yu.tu@amlogic.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djP87pMsnJJBksumlg0L17PZvHm0RFm
        i3dzZSx+tm9hslgwm9ti0+NrrBaXd81hszizuJfd4tiikywWh/qiLZq3/2dx4PY4smY1o8f7
        G63sHk8nTGb32LSqk81j/9w17B6bl9R7fN4kF8AexWWTkpqTWZZapG+XwJWxfus71oKjURX/
        X61ka2Bc7N7FyMkhIWAice3jPKYuRi4OIYEVjBI9bw4zQjhfGCW+HrkA5XxmlLi3YzITTMvD
        WbuhWpYzSqy/2s4K4XxklPjcu4UFpIpXwE6idd9XRhCbRUBF4u+B9YwQcUGJkzOfgNWICiRJ
        PDjQxw5iCwtUS/w61QsWZxYQl7j1ZD7YBhGBZYwSv4+8A3OYBbqZJL6v/gc2iU3AUKLrbRdb
        FyMHB6eAmUTndUWIZnmJ5q2zmUHqJQSaOSWe/JvFAnG3i8TNl2uhfhCWeHV8CzuELSPxfyfE
        NqAGRomH59ayQzg9jBKXm2YwQlRZS9w59wtsG7OApsT6XfoQYUeJiw9vM4GEJQT4JG68FYQ4
        gk9i0rbpzBBhXomONiGIajWJWcfXwa09eOES8wRGpVlI4TILyf+zkLwzC2HvAkaWVYziqaXF
        uempxYZ5qeV6xYm5xaV56XrJ+bmbGIHJ6/S/4592MM599VHvECMTB+MhRgkOZiUR3os/ZZKE
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MJUFs3xgXfF5
        RlbMC8Wn/Ks6f6Ss/zLjTfe9VRMT7WMPrMxrzRL9dWTS/gWf55188GCHMXvbx0cCNp6fuM4v
        Sew1CvD8YNFwIzRVxiChaOqFvVL+etszgzwdz+is6kplKp9vff7u9nRj60t/FRcqtdx1uBWw
        h7W3/LZQXHW14a5FoqsuGa8UnHAl3OZHaS/b8t8/tfVFKs6Jsgoffil6Prlg8p+fpwV5Iiq0
        +ctV/m96lX4x5Lxn2zS1awsi2e/8s5xuWqFypOtooILVtdx/BWaOpsZcKisu3v5laXLbyjG5
        JqNDbq/zRr07PDGJ1t8djIMnCy1d2dK6JV3J7sRDhur/e3R12m9VGrPKzs0qUmIpzkg01GIu
        Kk4EANClOsbNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7pMsnJJBvs3cFo0L17PZvHm0RFm
        i3dzZSx+tm9hslgwm9ti0+NrrBaXd81hszizuJfd4tiikywWh/qiLZq3/2dx4PY4smY1o8f7
        G63sHk8nTGb32LSqk81j/9w17B6bl9R7fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexfus71oKjURX/X61ka2Bc7N7FyMkhIWAi8XDW
        bqYuRi4OIYGljBKbdk5ng0jISJyc1sAKYQtL/LnWxQZR9J5R4vxviCJeATuJ1n1fGUFsFgEV
        ib8H1jNCxAUlTs58wgJiiwokSbzcthFskLBAtcSvU71gcWYBcYlbT+aDbRYRWMYoseTuYkYQ
        h1mgm0mi7ewnoA4OoHWJEiv+aII0sAkYSnS9BbmCg4NTwEyi87oixBwzia6tXYwQtrxE89bZ
        zBMYhWYhOWMWknWzkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmCkbjv2c8sO
        xpWvPuodYmTiYDzEKMHBrCTCe/GnTJIQb0piZVVqUX58UWlOavEhRlNgWExklhJNzgemiryS
        eEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqbJO7vfbmvxco4TPdB8
        287/UuGZI0KfE/4GKqt5XJ23auoVa7MvSpvCZrx8KeO3tlN8aWfhugm7t069fdDAa6XN5/L1
        7B9CSh7H/On1a0rwm3UvIvy356H3LEd3PF845cuBT3afZrjMPV//N/7HulUmqrwsz+dIGjML
        eCWYiPEzTHedXB3QFRdzTtPkbosqp+YS5yubVEVnzD9wo9aYsVhwd+hjK8kiwdZ3Szozj294
        qeoYr5ZqGzpxqpY+p2dXxK+SLytF+oV9csVXPpbXmLqUK8qH3+xsZtnKQ9ZmWxQY5VK5jrOa
        ZYZFsfXZ7anIabx1f2/hKaVlrTlfLddGG91Q018tJ15xILtia1bmMiWW4oxEQy3mouJEAChE
        3dVdAwAA
X-CMS-MailID: 20220301131754eucas1p1b8d762c90f4677b92a305f3eefec761f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220301131754eucas1p1b8d762c90f4677b92a305f3eefec761f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220301131754eucas1p1b8d762c90f4677b92a305f3eefec761f
References: <20220225073922.3947-1-yu.tu@amlogic.com>
        <20220225073922.3947-4-yu.tu@amlogic.com>
        <CGME20220301131754eucas1p1b8d762c90f4677b92a305f3eefec761f@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25.02.2022 08:39, Yu Tu wrote:
> Using the common Clock code to describe the UART baud rate clock
> makes it easier for the UART driver to be compatible with the
> baud rate requirements of the UART IP on different meson chips.
>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>

This patch landed recently in linux next-20220228 as commit 44023b8e1f14 
("tty: serial: meson: Describes the calculation of the UART baud rate 
clock using a clock frame"). It causes kernel crash on my Amlogic based 
test boards: Odroid C4/N2 and Khadas VIM3:

Unable to handle kernel paging request at virtual address 96e12b756a77c400
Mem abort info:
   ESR = 0x96000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
[96e12b756a77c400] address between user and kernel address ranges
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc6-next-20220228+ #4588
Hardware name: Hardkernel ODROID-C4 (DT)
pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __pi_strlen+0x14/0x150
...
Call trace:
  __pi_strlen+0x14/0x150
  kstrdup_const+0x34/0x40
  __clk_register+0x280/0x760
  clk_hw_register+0x1c/0x68
  __clk_hw_register_mux+0x180/0x1a8
  __devm_clk_hw_register_mux+0xbc/0x118
  meson_uart_probe+0x398/0x5d0
  platform_probe+0x90/0xd8
  really_probe+0xb4/0x2d0
  __driver_probe_device+0x78/0xd8
  driver_probe_device+0x3c/0x110
  __driver_attach+0xcc/0x118
  bus_for_each_dev+0x68/0xc8
  driver_attach+0x20/0x28
  bus_add_driver+0x168/0x1f8
  driver_register+0x60/0x110
  __platform_driver_register+0x24/0x30
  meson_uart_init+0x40/0x64
  do_one_initcall+0x74/0x410
  kernel_init_freeable+0x310/0x380
  kernel_init+0x20/0x128
  ret_from_fork+0x10/0x20
Code: 92402c04 b200c3e8 f13fc09f 5400088c (a9400c02)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x80,0000000c,19801c86
Memory Limit: none
---[ end Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b ]---

The issue is caused by using a stack for the newly registered clock. 
Making the 'use_xtal_mux_parents' static fixed the issue, but I don't 
know if this is the way of fixing it you like to apply.

> ---
>   drivers/tty/serial/meson_uart.c | 194 +++++++++++++++++++++++---------
>   1 file changed, 142 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 7570958d010c..4768d51fac70 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>   #include <linux/console.h>
>   #include <linux/delay.h>
>   #include <linux/init.h>
> @@ -65,9 +66,7 @@
>   #define AML_UART_RECV_IRQ(c)		((c) & 0xff)
>   
>   /* AML_UART_REG5 bits */
> -#define AML_UART_BAUD_MASK		0x7fffff
>   #define AML_UART_BAUD_USE		BIT(23)
> -#define AML_UART_BAUD_XTAL		BIT(24)
>   
>   #define AML_UART_PORT_NUM		12
>   #define AML_UART_PORT_OFFSET		6
> @@ -76,6 +75,11 @@
>   #define AML_UART_POLL_USEC		5
>   #define AML_UART_TIMEOUT_USEC		10000
>   
> +struct meson_uart_data {
> +	struct clk	*baud_clk;
> +	bool		use_xtal_clk;
> +};
> +
>   static struct uart_driver meson_uart_driver;
>   
>   static struct uart_port *meson_ports[AML_UART_PORT_NUM];
> @@ -293,19 +297,17 @@ static int meson_uart_startup(struct uart_port *port)
>   
>   static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
>   {
> +	struct meson_uart_data *private_data = port->private_data;
>   	u32 val;
>   
>   	while (!meson_uart_tx_empty(port))
>   		cpu_relax();
>   
> -	if (port->uartclk == 24000000) {
> -		val = ((port->uartclk / 3) / baud) - 1;
> -		val |= AML_UART_BAUD_XTAL;
> -	} else {
> -		val = ((port->uartclk * 10 / (baud * 4) + 5) / 10) - 1;
> -	}
> +	val = readl(port->membase + AML_UART_REG5);
>   	val |= AML_UART_BAUD_USE;
>   	writel(val, port->membase + AML_UART_REG5);
> +
> +	clk_set_rate(private_data->baud_clk, baud);
>   }
>   
>   static void meson_uart_set_termios(struct uart_port *port,
> @@ -395,11 +397,20 @@ static int meson_uart_verify_port(struct uart_port *port,
>   
>   static void meson_uart_release_port(struct uart_port *port)
>   {
> -	/* nothing to do */
> +	struct meson_uart_data *private_data = port->private_data;
> +
> +	clk_disable_unprepare(private_data->baud_clk);
>   }
>   
>   static int meson_uart_request_port(struct uart_port *port)
>   {
> +	struct meson_uart_data *private_data = port->private_data;
> +	int ret;
> +
> +	ret = clk_prepare_enable(private_data->baud_clk);
> +	if (ret)
> +		return ret;
> +
>   	return 0;
>   }
>   
> @@ -629,57 +640,106 @@ static struct uart_driver meson_uart_driver = {
>   	.cons		= MESON_SERIAL_CONSOLE,
>   };
>   
> -static inline struct clk *meson_uart_probe_clock(struct device *dev,
> -						 const char *id)
> -{
> -	struct clk *clk = NULL;
> -	int ret;
> -
> -	clk = devm_clk_get(dev, id);
> -	if (IS_ERR(clk))
> -		return clk;
> -
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "couldn't enable clk\n");
> -		return ERR_PTR(ret);
> -	}
> +static const struct clk_div_table xtal_div_table[] = {
> +	{ 0, 3 },
> +	{ 1, 1 },
> +	{ 2, 2 },
> +	{ 3, 2 },
> +};
>   
> -	devm_add_action_or_reset(dev,
> -			(void(*)(void *))clk_disable_unprepare,
> -			clk);
> +static u32 use_xtal_mux_table;
>   
> -	return clk;
> -}
> -
> -static int meson_uart_probe_clocks(struct platform_device *pdev,
> -				   struct uart_port *port)
> +static int meson_uart_probe_clocks(struct uart_port *port)
>   {
> -	struct clk *clk_xtal = NULL;
> -	struct clk *clk_pclk = NULL;
> -	struct clk *clk_baud = NULL;
> +	struct meson_uart_data *private_data = port->private_data;
> +	struct clk *clk_baud, *clk_xtal;
> +	struct clk_hw *hw, *clk81_div4_hw;
> +	char clk_name[32];
> +	struct clk_parent_data use_xtal_mux_parents;

static struct clk_parent_data use_xtal_mux_parents;

> -	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
> -	if (IS_ERR(clk_pclk))
> -		return PTR_ERR(clk_pclk);
> +	clk_baud = devm_clk_get(port->dev, "baud");
> +	if (IS_ERR(clk_baud)) {
> +		dev_err(port->dev, "Failed to get the 'baud' clock\n");
> +		return PTR_ERR(clk_baud);
> +	}
>   
> -	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
> +	clk_xtal = devm_clk_get(port->dev, "xtal");
>   	if (IS_ERR(clk_xtal))
> -		return PTR_ERR(clk_xtal);
> -
> -	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
> -	if (IS_ERR(clk_baud))
> -		return PTR_ERR(clk_baud);
> +		return dev_err_probe(port->dev, PTR_ERR(clk_xtal),
> +				     "Failed to get the 'xtal' clock\n");
> +
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +		 "clk81_div4");
> +	clk81_div4_hw = devm_clk_hw_register_fixed_factor(port->dev,
> +							  clk_name,
> +							  __clk_get_name(clk_baud),
> +							  CLK_SET_RATE_NO_REPARENT,
> +							  1, 4);
> +	if (IS_ERR(clk81_div4_hw))
> +		return PTR_ERR(clk81_div4_hw);
> +
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +		 "xtal_div");
> +	hw = devm_clk_hw_register_divider_table(port->dev,
> +						clk_name,
> +						__clk_get_name(clk_baud),
> +						CLK_SET_RATE_NO_REPARENT,
> +						port->membase + AML_UART_REG5,
> +						26, 2,
> +						CLK_DIVIDER_READ_ONLY,
> +						xtal_div_table, NULL);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	if (private_data->use_xtal_clk) {
> +		use_xtal_mux_table = 1;
> +		use_xtal_mux_parents.hw = hw;
> +	} else {
> +		use_xtal_mux_parents.hw = clk81_div4_hw;
> +	}
>   
> -	port->uartclk = clk_get_rate(clk_baud);
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +		 "use_xtal");
> +	hw = __devm_clk_hw_register_mux(port->dev, NULL,
> +					clk_name,
> +					1,
> +					NULL, NULL,
> +					&use_xtal_mux_parents,
> +					CLK_SET_RATE_PARENT,
> +					port->membase + AML_UART_REG5,
> +					24, 0x1,
> +					CLK_MUX_READ_ONLY,
> +					&use_xtal_mux_table, NULL);
> +
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	port->uartclk = clk_hw_get_rate(hw);
> +
> +	snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(port->dev),
> +		 "baud_div");
> +	hw = devm_clk_hw_register_divider(port->dev,
> +					  clk_name,
> +					  clk_hw_get_name(hw),
> +					  CLK_SET_RATE_PARENT,
> +					  port->membase + AML_UART_REG5,
> +					  0, 23,
> +					  CLK_DIVIDER_ROUND_CLOSEST,
> +					  NULL);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +
> +	private_data->baud_clk = hw->clk;
>   
>   	return 0;
>   }
>   
>   static int meson_uart_probe(struct platform_device *pdev)
>   {
> +	struct meson_uart_data *private_data;
>   	struct resource *res_mem;
>   	struct uart_port *port;
> +	struct clk *pclk;
>   	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>   	int ret = 0;
>   	int irq;
> @@ -705,6 +765,15 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	if (!res_mem)
>   		return -ENODEV;
>   
> +	pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(pclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
> +				     "Failed to get the 'pclk' clock\n");
> +
> +	ret = clk_prepare_enable(pclk);
> +	if (ret)
> +		return ret;
> +
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0)
>   		return irq;
> @@ -724,9 +793,13 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	if (IS_ERR(port->membase))
>   		return PTR_ERR(port->membase);
>   
> -	ret = meson_uart_probe_clocks(pdev, port);
> -	if (ret)
> -		return ret;
> +	private_data = devm_kzalloc(&pdev->dev, sizeof(*private_data),
> +				    GFP_KERNEL);
> +	if (!private_data)
> +		return -ENOMEM;
> +
> +	if (device_get_match_data(&pdev->dev))
> +		private_data->use_xtal_clk = true;
>   
>   	port->iotype = UPIO_MEM;
>   	port->mapbase = res_mem->start;
> @@ -740,6 +813,11 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	port->x_char = 0;
>   	port->ops = &meson_uart_ops;
>   	port->fifosize = fifosize;
> +	port->private_data = private_data;
> +
> +	ret = meson_uart_probe_clocks(port);
> +	if (ret)
> +		return ret;
>   
>   	meson_ports[pdev->id] = port;
>   	platform_set_drvdata(pdev, port);
> @@ -766,10 +844,22 @@ static int meson_uart_remove(struct platform_device *pdev)
>   }
>   
>   static const struct of_device_id meson_uart_dt_match[] = {
> -	{ .compatible = "amlogic,meson6-uart" },
> -	{ .compatible = "amlogic,meson8-uart" },
> -	{ .compatible = "amlogic,meson8b-uart" },
> -	{ .compatible = "amlogic,meson-gx-uart" },
> +	{
> +		.compatible = "amlogic,meson6-uart",
> +		.data = (void *)false,
> +	},
> +	{
> +		.compatible = "amlogic,meson8-uart",
> +		.data = (void *)false,
> +	},
> +	{
> +		.compatible = "amlogic,meson8b-uart",
> +		.data = (void *)false,
> +	},
> +	{
> +		.compatible = "amlogic,meson-gx-uart",
> +		.data = (void *)true,
> +	},
>   	{ /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, meson_uart_dt_match);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

