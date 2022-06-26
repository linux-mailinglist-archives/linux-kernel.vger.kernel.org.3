Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DE755B272
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 16:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiFZOZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiFZOZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 10:25:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE18DFE2;
        Sun, 26 Jun 2022 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656253505;
        bh=V2zLP+Q6I1/UFW3ZsVkjipSTGPK6qygTlMrwpvwc3qs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iDpI0X4c4EvjZ8K4GQRqgIdqOp/HEbZhDDbDSXNyk5rgbHJNgHI337HQOKD9sJ1Cx
         thZ6DBVg63qnXqKrKyQCpUggIIEThbzsD/2YrlcafB78FOnUVJfsNkIXkpQWsnFd0X
         81sHAwsAOHozynaJVDbEWzKWn9RT1Z/8FJwcnG8c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.248]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1nUknr1To2-00cDcr; Sun, 26
 Jun 2022 16:25:05 +0200
Subject: Re: [PATCH 4/8] serial: core: sanitize RS485 delays read from device
 tree
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-5-LinoSanfilippo@gmx.de>
 <5d406271-3290-f321-5984-bbc1f9a3bd96@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <5f4f4750-95c1-fb39-fefc-dbd2cd51e4a7@gmx.de>
Date:   Sun, 26 Jun 2022 16:25:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5d406271-3290-f321-5984-bbc1f9a3bd96@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yktu9u31aqAs7jhThOJR32JZKvmscc7SXjC6uQl83fXmjNX5LCa
 +KujvR9Yq4KmSO6XN356rP2y89A8P/5QmKIWhR0/s/iEK4Itgsp/jPKcmHMKeSklzckq5I8
 63QtTKqOf/SAsaI4EM6TT70hq1kUg5W8UwybyBOSoF0mvQYE2Bu5g2VOJptWtGnvuGc0cln
 v7LGYeDTn0sRPMwLm7U/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sUCrIRbOmUU=:5U5Fg4XJWkc97wRA6PNARj
 43tXT3PdoRp/nlr1ltlHtbVOKqRkOtGu6LCPk5SyWHZQksZMAgm4g4lBfliipjE+xDO9nQJQX
 /viu8lqNzzvMu1O7A3ChaNZl889/ZnhKGjy/qOLaAg9X0smd8tdGTEnPMm3+c2QkqhJ6TJWjV
 TlS4RUx/QAGRL4L/Ve1Mz4/u/LvWU6wbzM/V3MYIH7bSIK9wH2MSNo6/BzZxjv3wJH4YoTUZP
 ITNoIE8IklxT4r+WTiwmGCc6Y/HNR3YLI0JEY7/kLbMl2qRv/jQbIqQiceXWO+MXTu+a3WQ5w
 tZCR8NiMrKPHkpuyivJN0gGI8mk/gx3Dsm8ts+iUjh2emDiHamvvm5G+MnKukFVLOGgWAQ4OR
 BMLzBrzHU1TOEN1lXVng3uBXDnuUteCRcGG3r/gtqpL5dQEAwUNSkPHaBQkJlLRW0lfK4yK5Q
 W8G9kTxuQ/II9Vm7ccIzSK9HrlpsStuSu792oFRXfSX+DnrSU9a36ptzd0cv3EaNdkLs3F1nU
 RQNb6dha+CT5HyRjUwBwUE48DmnKiGjVSXT9sdW2TSqOhm3gkXRBEK0ISnAHS30cHnEJMJGZc
 /mou3PYhKnNg2x6g3XPyY/0Ul8zC3K70vbQ8vnS+6oWPQlE2b/YQgvUde1PBm4Ur+diOLDo6s
 YFwoT1Q21fag/xUWhRD0BFa267LUM6uOuTWh8ZdbkxzQmWV9RbVjZZAdCSC0lVXibAI0yQX5w
 436xTsyu3FjNwUsvj+c/XpJ4uqwUjJKAJRNkQS82DjmCIOem4fUS2Df+t9bXu5/IgbrImeqAB
 Xeg7SGH/9nM8X0RKLjW/Y2fHbu/Udhq5k6UPrfmot/RvYs0imOe7JBgSxTt2eJ5Hik+aO9uPi
 NQmqDyGuFFN4qB8sBy3KLBoflRgfZQeCSndiAg1L/AAy8ss6z8saRhU3jxeQK29l90yUSFh1R
 hv+D45VhabFJfOQTO/ek6LTIfrQ8m/xq9lU7ceWIV4lOjlIXuHoIrkjTwGu1Kkz08QNG5kYXC
 7HXk6ewfowZeB9f5fnSWlPGWasI+my6ZadFmEK4BqbXVQQ7ICUYJPkcHXBTwHVIJNl/jy0PEa
 h9ss6mjMXq6oQ+R7spVx0iWQz4LsNHwkKEUTNBVqsoa+4ZiOaLc24kaJg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.22 at 12:05, Ilpo J=C3=A4rvinen wrote:
> On Wed, 22 Jun 2022, Lino Sanfilippo wrote:
>
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> When setting the RS485 configuration from userspace via TIOCSRS485 the
>> delays are clamped to 100ms. Make this consistent with the values passe=
d
>> in by means of device tree parameters.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/tty/serial/serial_core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
>> index fa6acadd7d0c..2e9f90e73e62 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3382,6 +3382,8 @@ int uart_get_rs485_mode(struct uart_port *port)
>>  		rs485conf->delay_rts_after_send =3D 0;
>>  	}
>>
>> +	uart_sanitize_serial_rs485_delays(port, rs485conf);
>> +
>>  	/*
>>  	 * Clear full-duplex and enabled flags, set RTS polarity to active hi=
gh
>>  	 * to get to a defined state with the following properties:
>> --
>> 2.36.1
>
> While above works, if we go to this change user-visible behavior route,
> uart_get_rs485_mode() could just call full uart_sanitize_serial_rs485()?

As it is now uart_sanitize_serial_rs485() will clear the entire serial_rs4=
85 struct and
return immediately if rs485-enabled-at-boot-time (and thus SER_RS485_ENABL=
ED)
is not set. That was one of the reasons I moved the delay checks into an o=
wn fucntion. The other
reason is that the remaining sanity check for RTS on send/after send in ua=
rt_sanitize_serial_rs485() is not
required in uart_get_rs485_mode() since here we already ensure a sane sett=
ing.

Regards,
Lino
