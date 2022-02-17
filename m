Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628094BABCD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbiBQVgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:36:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiBQVgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:36:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897666622F;
        Thu, 17 Feb 2022 13:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645133771;
        bh=sh1DPaASGW9V2zkfziMd7+l7s/QlEn4SX5JpX6nJ3v0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Sv9dWkeaeIzH6NL8B8qO33aTGzXF3HAl1zMMXwbQNLdhi71L+zlgBC6dtaKPZUpFx
         xzOZwnQuqLJNu1Wdknq3ofxY0lqbUeC/Sz8teI9J5qNLX3AcU6AUrjTK/8DGdejZps
         pMc152GcOaHIrSnBodvvbrxqxqmWpNBiK56mQ3KU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.78] ([149.172.237.68]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1nNGDq1hlJ-006vSG; Thu, 17
 Feb 2022 22:36:11 +0100
Subject: Re: [PATCH 2 1/9] serial: core: move RS485 configuration tasks from
 drivers into core
To:     Lukas Wunner <lukas@wunner.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de, linux@armlinux.org.uk,
        richard.genoud@gmail.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
 <20220216001803.637-2-LinoSanfilippo@gmx.de>
 <20220217113354.GA7826@wunner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <03604709-fcc5-f528-c5cf-5b8c2d0abfd0@gmx.de>
Date:   Thu, 17 Feb 2022 22:36:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220217113354.GA7826@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PcdHdcVTNQnY7ZlbLSzK1FYNltMg8wlri9F+ts0o/nBFWnhsy/c
 Hlc15FyNnhioUoOXzxbM8tXwQoeXFbMUBz1tsYOT4YJoUK0jxiliABFzWMk9sHnGe7vPSB1
 OyL/7wbDzgYfoW1TZ1NlBmTePPoZTBDHT1dpysRDSix2U1GGAnFYItw5L+7q9SUsjEuzSNS
 YPgzJx7tkshMeWH06iKaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xXdSJIbiOW0=:L/EqqrP/p+Od95kAdJz4ji
 PkLd8shzbwi6IeBHYYnj1MpaKOEH7qWPcUeLnr0TWq6flKTKD8XLn9GGoJIhRJrSNXXVSH95c
 12s98dOcePln5dU0gyx9Q9xBDG8q4JWPEkz7DP2UgxIuuDQlaug4yvZZtDVctcvxznyRVS42n
 QsZPDSAtmdWHZURFupjPukhALS3V6wgpaKE80LMMFVrHQtqib6mgr3Jau5yC53RiHjxNfNY/w
 Pa5rYvJe9DJZJHo7kL5tWE6J7N9m7lCY/RKIqp6LooTJ2dLlY+sDA71Nm/tsqVoScG4XqY9VE
 E7TfCN/ySf7sySMWgYE7q0fRZ40V+F5u+LG69UCiYTrQQk5330n9WmE8u18qoyvkbNrTyr6DR
 KbIQBYYMeueM3iENiL93ITWMV3sQtCdnOXTxepFwLspvdfy2aTxKriuptJe4eEv9jwhJDMKwk
 l1IEW1UWsOAr6g3Z+mSGl7URXYU/lIenXz6/D0YsBRi3z04bkMYupb1h1XfaBMd8KZuMnLWsK
 Lloj6OGuzpsSlC4fMe/Eua2+aTDfVN1Nbre7ytJI66S6DeB8Fs4xYkMjX6cK2Vl42rb3ip5Jy
 yaV0m0g3CohOJqHAiHaj7Uo0/hlhDa3svNBrohCs3wi10iSzwF5ISuZKmkkIM8vegnqDpsOXD
 WMhpDWmJUHbhvxehZq3vVQsqG6/mIclu4ZkKCbeeuQ+NDgxp2iI7YGxBalUcwZPnpHnTAt2m7
 HlAFYgdKT/v37sQzewNVPb9JaByjNFW7n3/Dls4G/QKwzt8l4FBveKuFkmSuvaoYWQIyrLuIi
 giW9tw65el1SK9hvIHR5lC5178r1nZvxQuG/4MGiFdt+0PGCTvETeHJ29Ag/bQJIx88ZfzgpR
 mM2DkCdmhNOflrjfl7q9A2HnfLGbcR1Z5KLdv2YOojDJnk2/gzwDc/SS6kSmPQVCcK1J9utq9
 HfxbOdlA7FK4ffiIjW5/BdC+JOplPo7udayLSrdLc24EBoatBHeuFC2c4jtm4qXeHLR73yg7a
 5oW4SXhSpUxDU5Xwv+nVeXxTequntWXJqZE+Htr5k5y2CYnOG3mzoUamUmcXp1+Cyga4die2g
 ZCASi7QtpGgsNU=
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

On 17.02.22 at 12:33, Lukas Wunner wrote:
> On Wed, Feb 16, 2022 at 01:17:55AM +0100, Lino Sanfilippo wrote:
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1282,8 +1282,26 @@ static int uart_set_rs485_config(struct uart_por=
t *port,
>>  	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
>>  		return -EFAULT;
>>
>> +	/* pick sane settings if the user hasn't */
>> +	if (!(rs485.flags & SER_RS485_RTS_ON_SEND) =3D=3D
>> +	    !(rs485.flags & SER_RS485_RTS_AFTER_SEND)) {
>> +		rs485.flags |=3D SER_RS485_RTS_ON_SEND;
>> +		rs485.flags &=3D ~SER_RS485_RTS_AFTER_SEND;
>> +	}
>
> The policy you're enforcing here is:  If settings are nonsensical,
> always default to active-high polarity.
>
> However some drivers currently enforce a completely different policy:
> E.g. with 8250_lpc18xx.c, if SER_RS485_RTS_ON_SEND is set, use active-hi=
gh
> (and fix up SER_RS485_RTS_AFTER_SEND), else use active-low polarity.
> This yields a different result compared to your policy in case both bits
> are cleared.
>> Similarly, sc16is7xx.c defaults to active-low if SER_RS485_RTS_AFTER_SE=
ND
> is set, else active-high polarity.  This yields a different result compa=
red
> to your policy in case both bits are set.
>
> You risk breaking existing user space applications with this change
> if those applications specify nonsensical polarity settings.
>

Ok, but IMHO this is a very small risk. I cannot imagine that there
are many (or any at all) userspace applications that do not
specify any RTS setting and then rely on a driver specific fallback
implementation. I would not like to remove the RTS check from
uart_set_rs485_config() only because of that.

>
> I happen to have created a similar commit to this one a month ago
> and I came to the conclusion that all one can do is offer a library
> function uart_sanitize_rs485_mode() which drivers may elect to call
> if that helper's policy is identical to what they're doing now:
>
> https://github.com/l1k/linux/commit/637984111e42
>>
>> +
>> +	rs485.delay_rts_before_send =3D min_t(unsigned int,
>> +					    rs485.delay_rts_before_send,
>> +					    SER_RS485_MAX_RTS_DELAY);
>> +	rs485.delay_rts_after_send =3D min_t(unsigned int,
>> +					   rs485.delay_rts_after_send,
>> +					   SER_RS485_MAX_RTS_DELAY);
>
> Nonsensical delays may not only be passed in from user space via ioctl()=
,
> but through the device tree.  That's another reason to use a library
> function:  It can be called both from the ioctl() as well as after (or i=
n)
> uart_get_rs485_mode().
>

The idea of my patch set is actually to provide a common behavior for the
RS485 configuration by userspace similar to what uart_get_rs485_mode()
provides for the configuration by device tree.

However with the solution you propose sanity checks for userspace
configuration are still up to each single driver and thus can vary
from driver to driver or not be implemented at all. I dont think that
this is the better approach in the long term.


>
>> +	/* Return clean padding area to userspace */
>> +	memset(rs485.padding, 0, sizeof(rs485.padding));
>
> Unlike the polarity and delay handling, this one makes sense.
>
> Thanks,
>
> Lukas
>

Regards,
Lino
