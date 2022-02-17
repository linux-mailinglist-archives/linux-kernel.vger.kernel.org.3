Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAB84BAC5E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbiBQWLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:11:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbiBQWLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:11:53 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0253D43AF9;
        Thu, 17 Feb 2022 14:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645135875;
        bh=0KjJ3nEZ8kESxVKEPQdyOatinf7wfIYti/GBayHCGqs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GmFoXBFZtF7bBbOltR52vLe24JIWWh3AyXmZtMGhOhlX40FC5TkqT2ERjA78Sn3U/
         gK6Z7FPAeGQy056X+i+asAfKhnHBEtREp0v5+KtPK5WFvexXl7wJvcaeS8HaqPQcQ6
         TqxHpHErb89NpccJ86eaxXQd4EbERvhEunLNHIpo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.78] ([149.172.237.68]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1nyIc72WsC-00dnCU; Thu, 17
 Feb 2022 23:11:15 +0100
Subject: Re: [PATCH 2 4/9] serial: sc16is7xx: remove redundant check in
 rs485_config
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
 <20220216001803.637-5-LinoSanfilippo@gmx.de>
 <20220217114732.GB7826@wunner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <c10505d2-f8ee-0566-af28-45da59ecd99b@gmx.de>
Date:   Thu, 17 Feb 2022 23:11:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220217114732.GB7826@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LDlBc3jcPBZ7hh4E3miuvkAn8yQxJNZHrOgWRkl4+bOdByau3rY
 Xq28u5HUzXHh4aJCAZCXN+d7oF605/F76LP2lpGFZpcyQsejf/m57p88F91d9XXP1x/QtFz
 1WGpW8CArQel2FNazX6c2Klp2tf1UabxpPnQpfPR07Go5sfN457NFSRHux0qYbBT/zqLJut
 1+CQgj4eQSO38fJS2nrHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZshnL656ssU=:k7WyTvNEtAyT+v2CPkGHo+
 Y+jrlwuuTPjrZICC94MIaWOuRkmHK/bE9pZj3HotzSqTTPOIW00N2ph03i1vC95xLvEzvsXjy
 m8D6h2c7/7usoldpHL0E7t4twQ005yho7Q4KaZzJG9t23vurgOIRpsvC+f8AdZdQkRSfMK6aF
 RrelfYXvNbg8LujGu93pilNjtLuypY2pKeS3zBI/sG91Cj4HrO5wL7mX2mp1GQHqFzPNYrjZe
 hQw3bv2sPUNFBMoTFPbXVN6nsTNwTDe1MUllUXO3v/c2ly3J5jbqRs1hMjNdXVcEvXgOvANIn
 iSuFU7n7cklDqVB9XHRYmujCXQF1EgpVj3Zp+vAu1aMwQsNiv+PBhzc0wf3ou0kZW2zxvPnnQ
 +ODjGmEa2xfu0k9E9w8wYL6BNl8indogvZIu0ihYYtfle+7S4RxNfQ/Paec0sTMPQZqd9wDv1
 viZToYaq4SAGM15DjALr0nvPp/zF27qaoGUXlJA+dO/Wxu0+8qlpd8WayRsmTR0uws+m4aHAc
 Y4UvZRgAQLPWB/MdIIGLLhufsbsaxudm4CtR/iZnW4GDFtZ69knjofpZXY8DgtpwTOPrPpmgi
 me8lqnxFZKoaxElxvr0PGFT+9kGV/atUxSx4g5zBs5W8ZJh4saiJQ6MH1k/m9Twl1cwiwBuqZ
 Kv0ebKHZffWd/YuzEOq4SDGANPCwP6xXPKhCqggaTX/m50BHGhXT1eUIFL8M1/MSB8+kQDZ3P
 X1CVXeA8WLF/t/WmtYU1w5BggTH15yomcabKrlLk2bPMC4xWCn8VV4QB2BG7AjpYfIvPjQFxC
 WcscmQv9yldtvjOTYfz1w2kHSoAeHkcLReDJEDIIYKmhBOSLAEqlwW6vNSYBmrnmBMCwWi28h
 dhjk2CdmK3D82nO0AlnZgtraHGQKZoUdZbXlEgtc9kwwagPNAyCYYnudLgVJG8opyO0Al/gLv
 lEB1JMUSpOEQ4UEJdQbZc78WqXmpe2iDSLqvzwgLtK6R+3LOD0fH3HahNSFmkMDr3nxUpJw2h
 A5J5WrbCSrm2YjevI0WtdLoyGPLsaSEQhmUj11unv+uEuauZv/45jJ/jDetY31GF/2FJ1SXTe
 kADmNWyVlFwq34=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17.02.22 at 12:47, Lukas Wunner wrote:
> On Wed, Feb 16, 2022 at 01:17:58AM +0100, Lino Sanfilippo wrote:
>> --- a/drivers/tty/serial/sc16is7xx.c
>> +++ b/drivers/tty/serial/sc16is7xx.c
>> @@ -959,16 +959,6 @@ static int sc16is7xx_config_rs485(struct uart_port=
 *port,
>>  	struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
>>
>>  	if (rs485->flags & SER_RS485_ENABLED) {
>> -		bool rts_during_rx, rts_during_tx;
>> -
>> -		rts_during_rx =3D rs485->flags & SER_RS485_RTS_AFTER_SEND;
>> -		rts_during_tx =3D rs485->flags & SER_RS485_RTS_ON_SEND;
>> -
>> -		if (rts_during_rx =3D=3D rts_during_tx)
>> -			dev_err(port->dev,
>> -				"unsupported RTS signalling on_send:%d after_send:%d - exactly one=
 of RS485 RTS flags should be set\n",
>> -				rts_during_tx, rts_during_rx);
>> -
>
> Hm, patch 1 in this series doesn't emit such a message, so unlike now,
> users will no longer be warned that they passed in nonsensical settings.=
..
>

what about logging a warning for both RTS polarity and delay correction?

Regards,
Lino
