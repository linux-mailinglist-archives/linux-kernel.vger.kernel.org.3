Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EB555B250
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiFZNgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 09:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiFZNgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 09:36:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92663F5B0;
        Sun, 26 Jun 2022 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656250581;
        bh=hZku3pKad6YdlzoC5bnphtrI9Ac066vFM1ZhUPMS+rw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=b9ZE/z5GSMtb3BZtVIzM6M5tJ8rCPS4Q1ppvhyuXq4Hw9hlcyZwxKwPJhrWT9fB0s
         Tuy0KbphosNndDXxRMpFLwjeAyXNEKai+9tbiZDE83nEEbKyYWz8uplZro+WQAiFKy
         tVjed0FRXJRJ91nKtCAfYoChINNKhwngzRw9U+iE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.248]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79yG-1nZciH1HW0-017XzA; Sun, 26
 Jun 2022 15:36:21 +0200
Subject: Re: [PATCH 2/8] serial: core, 8250: set RS485 termination gpio in
 serial core
To:     Lukas Wunner <lukas@wunner.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-3-LinoSanfilippo@gmx.de>
 <20220625195844.GB2879@wunner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <067e6fa2-6015-2eea-5719-8b75fb08882c@gmx.de>
Date:   Sun, 26 Jun 2022 15:36:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220625195844.GB2879@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hGacXh8oLZwt9FXVfKQ60JrkzhKSJzVtnlbg7gxtB/Y8cLLiTZX
 0UudFxjwIY6NNCUIvHA9id3q9rsmkt2Yb1CUX3ZQmqxbGf99XceXBTanC75Eu3CFG6wNSgz
 Y181rwQmovaKbb/4m+R++hxGVjXzJWvnP4YhlkXnh/tUTlSyEyH3YrPEA7WWNLFrSsPxr/F
 +/t156IfegsjgTCUv6j+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:64O+XQE5+sw=:qLnwlZq1Yx43Hro9ph4Hvz
 mU2ImpgbsRpC8OWld0hX7Hgqn64mxGHNzRzOuXE21AFnd+h0NPn1SFS35RThbriuO9euOaw2x
 QdOPMJhZ2nCBM7Ui5UzIxOZCaoqz1EUZufuoMWEMlkFDd6srLb3+RC/NpV0iPYRJ5BaWmsOG7
 oYGyVqZtbS6IGKADr3T8o0Bl+hF55PHUXA2xGqQx1KShqdp//cxMEPrL9QWZwhKxnEh4fWR4F
 vxJoGOHWf8zDiUeSJDXH45ETwQt4hJ8yZvNu9RFLi26mIY0XLE6h1EJGripG7W9OOC6LafcIu
 p9cZMK9WRW9MyPzMILT5TMbxpwHsLlNwKOPTxLCrKrE4rRirF2i2p5bgDboJMnYonxcxgiwpm
 2zGFtJYmR7bsjLELi6Pt1LBEyRyv6RMAXBjE3+x+HGV/k6i86OQfaj27GIpktkqvIILByPEgG
 uz/XKNbVe6JBtXhXXWJvI2glHUFumDpeA5wQmdp/5G7YfRUZvusPPZu35voYNRM7Ag8nia7/J
 kEBQQmy2L2dQ+/dD1yln/EmIWvncPD0tYLFpX8QFHt+zKAzCNuwwHbmWkqPFcswaXQryZ6dYb
 viRve4kwhWq1WK6aqRyL/Em7kQ2QGUQag2g00hxv5m66kWvpzFm+QxpwSyPudw+4sTr3WcJwT
 aCXb71RjOfQyyEvjWKRU+2UDCLb/+5ZnhHuxKvHmaRRAdJyX3VbyD184jf13TDn/ZrLzRdN/4
 +GFBaaNttECHxY2fgYrNGq8oiat3REVsFr2RGqJMfdcJbXzRw+NfbsVwtYEOXPX6L7+9bKLlR
 v2ZdyR+KxuGo2P5wM6t7ZIbL7RnZgE/GJ6eeGOpBeh7tM4wEjKT1AOFTcVoqezR3Xm986Cpni
 tTkSzyG3vAmV4SfYpILmmtQ65QsKYFMwEGaJoKDj5aeLFWKHM22CEEbHfObEvIzMAMnz2W7Om
 BZ9qk9IXnyF7iCpCbqCp+/IVNCuFWPy4tW4Ug0JAfEKBdqpeDPT6dCb7TUU5clGpITG2vS2lr
 kn35cd+DVX2YnHAYAtGnEfeptJPWDumIF04r+TDyvxJ16tjGoeBxwKY0lAUA1/Hk7FElzNBtR
 i3ce1JeFkkRsUjpftXWlVQz/MdFnwkhKtyLaQf26XHaoLR2nWYGlnwa/A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.22 at 21:58, Lukas Wunner wrote:
> On Wed, Jun 22, 2022 at 05:46:53PM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> In serial8250_em485_config() the termination GPIO is set with the uart_=
port
>> spinlock held. This is an issue if setting the GPIO line can sleep (e.g=
.
>> since the concerning GPIO expander is connected via SPI or I2C).
>>
>> Fix this by setting the termination line outside of the uart_port spinl=
ock
>> in the serial core.
> [...]
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1400,6 +1411,7 @@ static int uart_set_rs485_config(struct uart_port=
 *port,
>>  	if (ret)
>>  		return ret;
>>  	uart_sanitize_serial_rs485(port, &rs485);
>> +	uart_set_rs485_termination(port, &rs485);
>>
>>  	spin_lock_irqsave(&port->lock, flags);
>>  	ret =3D port->rs485_config(port, &rs485);
>
> That's one way to solve the issue.  Another would be to push
> acquisition of the port spinlock down into drivers.
>
> I think in most drivers we don't need to take the port spinlock at all
> or only for a few specific register accesses.  So taking the lock here
> in the midlayer is likely unwarranted.  However, changing that requires
> going through every single driver's ->rs485_config() callback and
> checking whether it needs the lock or not.

As a first step its sufficient to take the lock in each drivers rs485_conf=
ig()
function and remove it from uart_set_rs485_config(). Then after time sort =
out
the drivers that dont require the lock and remove it from their function.

However the point of this patch was also to generalize the handling of the
termination GPIO, so I would still see this placed in uart_set_rs485_confi=
g().

Regards,
Lino



