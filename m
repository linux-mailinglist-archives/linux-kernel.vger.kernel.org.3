Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7EC4612F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354128AbhK2KzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:55:18 -0500
Received: from smtpcmd14161.aruba.it ([62.149.156.161]:46912 "EHLO
        smtpcmd14161.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351661AbhK2KxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:53:17 -0500
Received: from [192.168.50.18] ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id rSUYmwZPnrIRlrSUZmkupp; Sun, 28 Nov 2021 23:17:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638137874; bh=aXY7K66LArue7ekBfUqC+O3Vdu3DF45DOCQggVHhyRk=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=UWFMkiSsKQ62KY+0ZURyD6NV1IdL1jjXBcAjrqYTEE7wNQN3tR/3plBoFRl5Ymo9R
         XdqL6804DiwhYuUrxfCjxoLtDxrlexLUjPjMzPphMcHQvejZNlErXgIocjFwb5BveM
         uKZRBszKtpbKIn99ZaSStwtUV0M4Vn7/SaGIDfbh5TJaEPIxhTOldS1rBY0FcN9jYk
         vy4iDf7ox+ZK7PCY0a+RqgJi1gRitzGTPBUkS90y5rQ+4tBVARx/tXovG+j5B3l3nh
         Fb2NKuGqmbVxEcmQN2J18zlZ4+0SGUgvN0BJF64Be+wfqVL8sOov9cVBJ7itP+l8av
         J/EPoY0WuV66w==
Subject: Re: [PATCH v3 07/13] clk: imx: Add initial support for i.MXRT clock
 driver
To:     Jesse Taube <mr.bossman075@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
        Abel Vesa <abel.vesa@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org
References: <20211125211443.1150135-1-Mr.Bossman075@gmail.com>
 <20211125211443.1150135-8-Mr.Bossman075@gmail.com>
 <CAOMZO5Dqo6c=4nGCOakMKG8fn=V1HA7-O26t3GmwWtD-FbZiPg@mail.gmail.com>
 <dae68360-456e-3db8-57ed-2287dc7cfd57@gmail.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <de705094-1b8c-3950-b7f5-f7150b525ea5@benettiengineering.com>
Date:   Sun, 28 Nov 2021 23:17:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <dae68360-456e-3db8-57ed-2287dc7cfd57@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC2+WimnYT4jDoL/5Qj39vMuFzShQz7FE/Z8sP1XkxBcrbdPos5MDmBJUX4HG5hh+ebK3KAL0how8VdRfqKsNrF/aWMVS2LsH/RZ6zyMVg9un5zPZZoN
 XpWsgys9jMAvtyErhZCjCg6c2qhQ+1ryfHitGjvwSIq5/z+GPvn8Trh3JpwusaUYelmuQOw2GUitDYe0RYkp4D3mLVXw0OnHmiwx+4fe8w/7q5wJwvTomNpJ
 RvxQo74zbj9Agg42zgej+InyJTDpxrNNx/mrojuEwwl4wApu4ST1yBYJnBnay9L9MUd2JBbfZbybNuev6n+VxbA0jqan6TpaUXOZMhe8s6zXc/u8Spgbevwh
 9ZrFmJjLHacRXAUklqpbukFqImaltYXulxze8paExwJkEn6GWfP8Ugsf9jQmusZmVhIEQd9+Ec99+fR1zFkK+QkYq6FVavA+WR9oUwBVQlDnMIAQHOZLJjvp
 otERI3O0iDAgTl5EZdtf7dN4utkZsrZpvLi8k6HhcXHI+PQzJS4Aas31z6ZtCWB3H+IFlnoEXGhgwvOA2WaMwM4E6ftEDDfx4ugg6iQy40iiIU9wRElp/BN+
 1L2+DjRbjnQnZYFTnm6f5Bm+PYSmRi2LVrVvuLTLCRtX1gYD58LEPYbY6XKhdwVes39RaJNEhwK4dC0kSU3jWJF6qnrRDnvVPi5GYWDbzXQLqzhCD07w8Cyn
 mgrkecLsHm8q471VM2FCy03c+/h6WDPublFMtL/ySznu61+FmUMDh4MrgwBY8EOLyvbI3tDnECr0J223wqwHMpLYKCTrvfsPDv5mhiWdg7JJycF0kukdo9WS
 +d/fkpVfyZe6uh431ToarZWHxPmF3B9FAZdPXfouVHuOBzpV+Pdm/y66C7BACVeSJ7mkyNedf/uG8K5coWzFH6OSWlxKNBAiXqV1qfX6pXrwuhFO+VfyT1ph
 tK6Xf/dA4Eq5QYjFtXbrPcZUCYJ5drhXeQTIE3Sqx1sFYqrVaI6OfdJKfri3Y/VQBRVuPxC5esevDY0AEBxqnXhbd/OHAy3lNN2ed2wC2Gi7NBglCsPvYTIj
 wNSHJHBqkWZds8O5IqlT4MxLNfDNRUjkPEDCZTJ3wQ5sIsRQ6G5/LeofgvkQSHRXAcwrPTSqAiUIWl+k2ItjIeC/vfPHKzM0TR4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse, Fabio,

On 28/11/21 21:52, Jesse Taube wrote:
> 
> 
> On 11/28/21 15:50, Fabio Estevam wrote:
>> On Thu, Nov 25, 2021 at 6:14 PM Jesse Taube <mr.bossman075@gmail.com> wrote:
>>>
>>> From: Jesse Taube <mr.bossman075@gmail.com>
>>>
>>> This patch adds initial clock driver support for the i.MXRT series.

Also the commit log must be modified according(Summary+body).

Thank you
-- 
Giulio Benetti
Benetti Engineering sas

>>> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>>> Suggested-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>>> ---
>>> V1->V2:
>>> * Kconfig: Add new line
>>> * clk-imxrt.c: Remove unused const
>>> * clk-imxrt.c: Remove set parents
>>> * clk-imxrt.c: Use fsl,imxrt-anatop for anatop base address
>>> V2->V3:
>>> * Remove unused ANATOP_BASE_ADDR
>>> * Move to hw API
>>> * Add GPT's own clock
>>> * Add SEMC clocks to set muxing to CRITICAL
>>> ---
>>>    drivers/clk/imx/Kconfig     |   4 +
>>>    drivers/clk/imx/Makefile    |   1 +
>>>    drivers/clk/imx/clk-imxrt.c | 156 ++++++++++++++++++++++++++++++++++++
>>
>> Wouldn't it be better to name it clk-imxrt1050.c instead?
> we can have multiple imxrt versions in there like the other IMX clk
> drivers, is this okay?
>>

