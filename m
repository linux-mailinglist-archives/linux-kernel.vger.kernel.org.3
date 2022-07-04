Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB779565031
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiGDJBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiGDJBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:01:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABB10CB;
        Mon,  4 Jul 2022 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656925280;
        bh=wunTrKVzz/kwW1pyTGsbdz6YZYVftor0tEd0kb7sjO0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SINC7RSlV4w99Cn6JlwtJRqAsE75zgeeyizf6OW6Gs1HO22tpejMX6cKxeN0Zws+u
         Vu2NuhfZCGAWgx+cEsaa2x6ZwPBe82IOWb8v1zApH1K6+BMNKWNxzuxZEvdVWU9Ftg
         dByJ/AghB9hVBd+cAz/l4M3kj1xUxtgWEFTynIe0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.210]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1oHbLa2NzK-00AXhd; Mon, 04
 Jul 2022 11:01:20 +0200
Message-ID: <5f0d2112-ce82-e1b9-d421-de1f8067dbe8@gmx.de>
Date:   Mon, 4 Jul 2022 11:01:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/9] serial: core: only get RS485 termination GPIO if
 supported
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
 <20220703170039.2058202-2-LinoSanfilippo@gmx.de>
 <CAHp75VcU-gLQBvuesoYp-G91SjzeYB7PNCN17PGL7u139VZY2g@mail.gmail.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <CAHp75VcU-gLQBvuesoYp-G91SjzeYB7PNCN17PGL7u139VZY2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MxMrBoebL/3ctFtCTUphQ8fbbzo0zgkURU2onWKweIoqv254Z0s
 t868OlGvUc6fhbcP7VeAiIhLgqlDBHdwcEFAF4U1gK0liSvZKMc6B6Bka+z56N7zo6uI4rj
 cRFVbR4YRXAce3cbcainF19L6917abn0iB2K4DjNy6K1jVnUyAqiGAWmbXtdNOSevkR6Hsh
 d5p2iLrkCVLQMyB1ymF3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q2fK6Uw51Ow=:1KxNQm6ApxAwqoouCLJ58d
 ZRcld4NUe4iHIi6CcURdsrTh5F3eKNUURC7YiXTwFqkJUB/ci5cwSrjLrlyDkxxngPTVB4kol
 4PIt6BFXRli9wA7BYNEKfx1ICufVxXUl3/rdFll/Aqv92ff/aULjCiOyQrpjiCmfaSlgLBTZO
 apqzmZJ72irdvnl0i1El72Ylir7x6VAB842gB4Tmpdk9jgzvxBvZ+4uG40Sx7Qv1Mb4764LT5
 o/KIBuA2Rucw2eh4SXCTnwYEfC6RnFRmOq7OfW5/pjg+QZCJogkWx68aOnqM8CeIHP75yZmGt
 2cZmQR4NEh0Y3zSp0jM8+WCSB9uO2go/eKaAOlFI+YRx24zeRNyz1Q0qeRRt5sA8ec9WNgH6h
 jRnOG42pGvw91Qdkt3BL5ndKCrmKhb0E3My/xw5zZDupb+TC+A1uGl4/xUQn6tgbnBTNgvqwr
 q11Bokv4gM4L5pf/5Hg/EeUmvrf1a+F33qT/JuJUbXS718GrqQY7K5ZVJQj10n320jERzZ6mg
 ZB0B2igMY1WEGCiATKuf34vSMkU46y7mHaq9WsBYNKMjRxdq+5kqnkR2BTfkoaFWMhmrMAymL
 pABYWpIpjAHf9G8KZNHcZGCxQrCs3KJORKW37R/j57TUVdZjkIn5YU1vIcSQRePnB3eh9dpor
 Wxz+F+9sEANPKFJvRqfQdqiP3JASn+LHGf4G1qpRzwy2BQrNrdkCEoN8XY/84zlNZL8g4EjF8
 FJTdc4Qdi/KY+QM5vritDQEj29yVYxdcESqBkKapr6hqiujRE8A6ajXeMLspOTtqBucVXpnBu
 ZQbNkmn0sLz5JkGj3rW3tMGV8XR1n1AHkxg0jbldVmu8sIHPPsONln+PKFcFzjglfUmu9ulNQ
 gbdE9JLkXcg9Q8WOTUtbq5f9fEsG4jzY52gE3Wexr7TNhpoueDoWO+UQyah7Aiw0OvgAUAg3q
 dKJAR3mGNcB2IjKxEQRQpWiAJsj+yzHVdqC3YZX1EQWzhUw0d9ZxYsclgfhOm39F7wuvlfVE+
 A4xS2v8HDJ+pJUN21dITJzl/5XATzepCAjf9gnqGWszxyqb3WRKPwtIuT4Sa4QOc3z5eW9WQ0
 8EQoh0lkmEda8nAwjEV6IT3pdZbW5nO/0hclIII1LConYckA1KxbTGoAw==
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

On 03.07.22 20:27, Andy Shevchenko wrote:
> On Sun, Jul 3, 2022 at 7:02 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> w=
rote:
>>
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> In uart_get_rs485_mode() only try to get a termination GPIO if RS485 bu=
s
>> termination is supported by the driver. This prevents from allocating
>> and holding a GPIO descriptor for the drivers lifetimg that will never =
be
>
> lifetiming
>
>> used.
>
> ...
>
>>         port->rs485_term_gpio =3D devm_gpiod_get_optional(dev, "rs485-t=
erm",
>>                                                         GPIOD_OUT_LOW);
>> +
>> +       if (port->rs485_term_gpio &&
>
> This check is incorrect. Either you need to move that after error
> checking (that's what I personally prefer), or use !IS_ERR_OR_NULL().
>

Right, a stupid mistake. I will fix this, thanks!

Regards,
Lino
