Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD24B55F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356264AbiBNQT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:19:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiBNQTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:19:25 -0500
X-Greylist: delayed 325 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 08:19:16 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC9142EE7;
        Mon, 14 Feb 2022 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644855555;
        bh=uSiLH41ols2or+PlxwtXv6HH6qStx8ca3yFi6b4NLDA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZC7ys4YhFML+XPJP4mpPLukOKwb3QxulUMHO1uX8Hq+HpNupjBq/FCaMNZWCyzOrC
         j4XAOTnkQ82dP5VK3x9FkaVwl9jvII4DfttWmiXFtUL3EXEeKXVKBdSWBH71mgYOo8
         29J1VuwkZ/58p81/nn9SE5mDcQhIMg3Fxj+h3Vas=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.70] ([149.172.237.68]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hzZ-1oK5ig2JyZ-011et8; Mon, 14
 Feb 2022 17:13:21 +0100
Subject: Re: [PATCH 1/9] serial: core: move RS485 configuration tasks from
 drivers into core
To:     Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
 <20220213222737.15709-2-LinoSanfilippo@gmx.de>
 <aa45fed9-7a40-7ac1-a000-18d2805d088f@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <9791fb9a-0c27-bfeb-5ff8-fb70f1968048@gmx.de>
Date:   Mon, 14 Feb 2022 17:13:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aa45fed9-7a40-7ac1-a000-18d2805d088f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YBdfvrtYI85+zaH+ORjAj6/z8NhLNObYZSKxNdCEkYmHpFKgUBz
 cvg3dOdbbi7AbkXhFtpSGhjhlkoJcur1g466o350MRispTjbtggc/xvrNm0IEnPKTmC4Fkg
 ROY/D/pVATsNvg4nEopPdn+DX0L1U4hzKUnMq65l9KuxdLJPNytzgJQ4VZ54vUVWFPmvQlR
 C3w+lEE3o7q8OAa4qDaLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pSOpZ7x17Fc=:woJNeKPRbcarBQfg1Sp6p7
 EZIgFKw/ObO5hG40inIuLkbDrW1Cy7/VwTqs4SL8vVgokDaexgmTkVpPcpfkMVgEGXaC+131K
 4MOJ40qg77xhl/2+g7sROXl0Gpev4OgRHgi8d8TOCHryUcg0C+xeH3jJUQ4rsAMO43iFAwH8F
 75Toj4COP0vB9E19Bwik9eh0ykb+6Kf4ASJttjlHCAXoe0XfAdyyBSunQKrlCAglRtZe9HzUK
 oi1hvv9ayePRgRydJopIP6VlkO4I548O+ARH7wjVq1nTcLYa/y6XJaepY4Xa785OyxBEeK97Q
 r4HO7QJ0NVzeQmMR/TaaMX5d+1SBy3p7iXyk+fGvAALLUQIEwGDmjC80me3wmv25Y09Thsd+P
 r3TDp5YYU5zxoH0fDwewDIB0NN00k/daykXSa5lZEryBsk7L2KFj6LavAYexzwxTtkfWzNJJk
 FbWUzMRTW1utAZqfn79VzUjdHp8CyChiPxrEvTxxkBaAXqgn5bWjXGSLe79ZnvHjtbdi/INY1
 rFGKejQMMz7kUqwAYqTf2ZqwAyvKR8csmuMT7fcvk1NAvx7bFgXd6MQUIBrrumCAGpmMyfmvU
 aZz2Ly5EU7gSzjXoeKvKZEuqiTKRH63DGcBKlFEUIk3RaRoeW6oi6byeqAHBmR+iXwBcHbKu6
 a/G9Hv63wvfuUBBDVJCwWQztHY7+uOg+KlLHzLqKfqoDXAVZfyuvWOJKiuAS+redDyvtLbQGB
 V2eXimZUERoDCGoFgvy2jkR0q2k2wg82foqSOhBQTbMvJVf4eMnPCSTTaO/c5b+HzflTN8VlF
 24OW7D3XS9fDozKPj5Z3MYrX3GKAkiDzuEbp2vbXBndwDASH3mm0UVetIVI+g/39rI+UwN9YM
 GWJbDrnRsL3NKXXssaoqD8JtDdPk3F/jMtg8Naw8KEnJBfPmuHkZjIoptMzEymDsDpWZGZljI
 er4IGuIcrlknVgq173Hrr1C+2dX5woLtmBq7AXP3JnUfZs3Qowf4HQAWUPPEAkV/rJ7fTMs52
 br0Rg8YOY1vLM1kQ58Gt+ffgs02crf7kRhTh2xwNgKGy3tnH4D2fPtXZsKNMQGm4LrkbAVBoH
 wngwmUzMkytIXs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 14.02.22 at 06:41, Jiri Slaby wrote:
> On 13. 02. 22, 23:27, Lino Sanfilippo wrote:
>> Several drivers that support setting the RS485 configuration via usersp=
ace
>> implement on or more of the following tasks:
>>
>> - in case of an invalid RTS configuration (both RTS after send and RTS =
on
>> =C2=A0=C2=A0 send set or both unset) fall back to enable RTS on send an=
d disable RTS
>> =C2=A0=C2=A0 after send
>>
>> - nullify the padding field of the returned serial_rs485 struct
>>
>> - copy the configuration into the uart port struct
>>
>> - limit RTS delays to 100 ms
>>
>> Move these tasks into the serial core to make them generic and to provi=
de
>> a consistent beheviour among all drivers.
>>
>> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
>> ---
>> =C2=A0 drivers/tty/serial/serial_core.c | 13 +++++++++++++
>> =C2=A0 1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
>> index 846192a7b4bf..3fab4070359c 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1282,8 +1282,21 @@ static int uart_set_rs485_config(struct uart_por=
t *port,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (copy_from_user(&rs485, rs485_user, s=
izeof(*rs485_user)))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /* pick sane settings if the user hasn't */
>> +=C2=A0=C2=A0=C2=A0 if (!(rs485.flags & SER_RS485_RTS_ON_SEND) =3D=3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(rs485.flags & SER_RS485_R=
TS_AFTER_SEND)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rs485.flags |=3D SER_RS485_=
RTS_ON_SEND;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rs485.flags &=3D ~SER_RS485=
_RTS_AFTER_SEND;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /* clamp the delays to [0, 100ms] */
>> +=C2=A0=C2=A0=C2=A0 rs485.delay_rts_before_send =3D min(rs485.delay_rts=
_before_send, 100U);
>> +=C2=A0=C2=A0=C2=A0 rs485.delay_rts_after_send =3D min(rs485.delay_rts_=
after_send, 100U);
>
> Why is this magic 100?

The only drivers that seem to care about a max value for the RTS delays us=
e 100 ms
(omap-serial, amba pl011, 8250) so I chose this to stay compatible with th=
e current
driver implementations. 100 ms also seems large enough to be used as a gen=
eral max value.

> Can we have that number somehow documented? You should define a macro fo=
r that anyway.

Ok, I will do so.

>
>> +=C2=A0=C2=A0=C2=A0 memset(rs485.padding, 0, sizeof(rs485.padding));
>
> What is this memset good for?

Drivers like max310x, amba-pl011, 8250_pci, 8250_fintek, 8250_lpc18xx seem=
 to care about
returning a serial_rs485 struct with cleared padding field to userspace. S=
o they all clear
that field on their own. Although not really necessary, to me this seems t=
o be a good
default behavior, so I added it to the serial core.

>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&port->lock, flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D port->rs485_config(port, &rs485)=
;
>> +=C2=A0=C2=A0=C2=A0 if (!ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port->rs485 =3D rs485;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&port->lock, flag=
s);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>
> thanks,

Thanks for the review!

Regards,
Lino
