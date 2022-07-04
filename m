Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C7556596D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiGDPJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiGDPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:08:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9FF12AF8;
        Mon,  4 Jul 2022 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656947229;
        bh=K7RUmy5Limq+hSDDppl+PDSSH2S2TL2HjFu3L9C6A84=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RYMeRukIIZY0NySBb0GJ4pRIQUlwiCXqGgva4+QIXoveWGJofZ0BcoHViO6Z8y0QP
         PZv7V7gzReeaVZuBe65DgHZS7ve8e57sn0mWLIOWUNhkFX4UFogr8NTbmKo/IyiyGy
         lEK9BEOkenEhSg6mUwGwYVqIpr3c6zY/JYRIAX3M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1o0EkU3jeQ-00SB0W; Mon, 04
 Jul 2022 17:07:08 +0200
Message-ID: <f318294d-2641-5a38-6d9c-ec96f3ec2b5f@gmx.de>
Date:   Mon, 4 Jul 2022 17:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/9] serial: core: only get RS485 termination GPIO if
 supported
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
 <20220703170039.2058202-2-LinoSanfilippo@gmx.de>
 <9bc128a9-7ce3-d1e-dad6-ca91a5564ea8@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <9bc128a9-7ce3-d1e-dad6-ca91a5564ea8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F78mEPif5Gs2kOcs+5mq/KWWlBuEXGPYjtBh5mxK9oOEJMpfGIo
 OR5yhs5r4ovPoOCJt5q3K/q1nPcuQhsYyFZos/lk6mlBms4Pn8VtEMUN2amik0AVV7Hf/Mc
 Zv8MGpulkRMhBld/UXFFQ6GA6WeQSsTp006zT7pKHlxRPWqd0LQv36aEQF9qblcv4/RM3rj
 vrxSq2/eSfq2tBH5gOEvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w3Sj/bnMhPU=:etWO/zFLCTQMC9Vm/8oNZT
 ZUSqW/0YqLSBsBOjEIm0k30PV6cjGahSgQLQF0Bby8ZhB59TagpVvGz+QchQjBxHbT8Lv/Otd
 a+AifdGmvr62uiKuf86LoMsFCeAd9lYOnrApngKsDK0p9DMfNEcxHGmcdr7QEgkSDYWHUfPgq
 gkTXsyTWMMrO90p4/NIQXsPwFa7QuO0wMMGnWN0C20tsZmvZozgUR0xcfCgBt4tewAOoBtkX8
 K9znygeacU6oygankuiOn4CLI24bNMa1K4R13DQs+/nyLsrji42E+em5N0lcNZh0SbGW2PKc2
 qYuXOyJknG0+SVESRVLCNf4PvoTbwiCfI59kdXW7UhIq7eGRFjQoMytpUUtSjRgZWlRPnvJ2V
 sclMOg4JnPqecClD86M/BD/viZFVvsWdc626EHCHxB606qwz2tqiIEikzFVY4Se4feq/gNZkk
 STazAfi7ERd5RAvnTKL9Pm9Nx/a8JQjF5yZtiZckJaiNUmwvVmOPXGVr3YTt5PLvyE1t15qAA
 VTI0vzEa0D+H/61vsO4L8jHiul0cG7Z0jdQCOqtac2AWdh/ojSWQ2Q95YlDuZfjgSwqKZSfAh
 wYeTzsc930j7D7sgz+BPSx48pMnAZqITeauJtx7fK343SXgYhZYLOCn6gGPChDTdKssN3IX0P
 3DgA/mAkWimWllbKrrjhnwL0CTK8ca1ULCKPbazNasK6BAKin5mGFMq6AW8ExXPUt4+cXTkdP
 Zl2qFJm0jkI4al71k8MTIze7FL2tIHpPr4d5PPOMEJHOBQocCXvISmRoxZnWoAZPxH4xS4vt2
 b6MRTsD9dBN2UXnH6hvdzdspOgBkCal0Dt0ST4WkBN4ZzyizUwGiVOflck2SWtTOJ2ZLzzRXV
 JBCC97UGHPWVjIrt2wzhoMfuVe3Su/HykY10vDCWHwyh1Z9bA/fj+eGC2OLxDTJZ+idGs36HM
 xOU9j6xdyb7H/3cpvITGKJlzv6wY+nsBCLEifUcKhd2qWm5qSdPcDwWFIP10pq9JqW92bGGGW
 P9fRQr36EP+U3DydnLGYxdCYppigklzPGs0zzwqrU/E7oKxRX7kRmB0PdpGTv2SKM7hy6qHmz
 NLXHdGSP+U71WoQI4h60OHOLnPGCgB/8G3K6CxSsBJQJRJ/Jy60cDM/2w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.07.22 11:55, Ilpo J=C3=A4rvinen wrote:
> On Sun, 3 Jul 2022, Lino Sanfilippo wrote:
>
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> In uart_get_rs485_mode() only try to get a termination GPIO if RS485 bu=
s
>> termination is supported by the driver. This prevents from allocating
>> and holding a GPIO descriptor for the drivers lifetimg that will never =
be
>> used.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>
>> NOTE:
>> This patch follows the design decision that "rs485_supported" is
>> set by the driver at initialization and cannot be modified
>> afterwards. However the better approach would be to let the serial
>> core modify the termination GPIO support setting based on the
>> existence of a termination GPIO. If "rs485_supported" is not a
>> read-only value any more in future the logic implemented in this
>> patch should be adjusted accordingly.
>>
>>  drivers/tty/serial/serial_core.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
>> index 85ef7ef00b82..3768663dfa4d 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3404,6 +3404,16 @@ int uart_get_rs485_mode(struct uart_port *port)
>>  	 */
>>  	port->rs485_term_gpio =3D devm_gpiod_get_optional(dev, "rs485-term",
>>  							GPIOD_OUT_LOW);
>> +
>> +	if (port->rs485_term_gpio &&
>> +	    !(port->rs485_supported->flags & SER_RS485_TERMINATE_BUS)) {
>> +		dev_warn(port->dev,
>> +			"%s (%d): RS485 termination gpio not supported by driver\n",
>> +			port->name, port->line);
>> +		devm_gpiod_put(dev, port->rs485_term_gpio);
>> +		port->rs485_term_gpio =3D NULL;
>> +	}
>> +
>>  	if (IS_ERR(port->rs485_term_gpio)) {
>>  		ret =3D PTR_ERR(port->rs485_term_gpio);
>>  		port->rs485_term_gpio =3D NULL;
>
> I sent a series to embed supported_rs485 to uart_port and manage
> SER_RS485_TERMINATE_BUS properly so I think this won't be necessary
> with that?
>
>

This is why I wrote the "NOTE" above. But yes, this patch is not needed
any more. I will drop it in the next version.


Regards,
Lino
