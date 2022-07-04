Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D425650AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiGDJZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiGDJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:25:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C5A656D;
        Mon,  4 Jul 2022 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656926726;
        bh=7AgtTeOCjKY42gITCNPqcj2Bze43f73q5a4PmTDg/EI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=k7H9JiA61r612M/Og49HsCYUy2hEGIWOhLWpYhcXSy2SsrjnSXFHfbjEu6oObjK+M
         s+IOddX7ONigdHAFlAtWrbJnjQG7ugp9p4xsTA5bsiQz4YWimK8p98Ajuy+R6L25z8
         GFMmMLVNpvdMkoJuDgo/k9r/lm1OHnjgsT/uyj1c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.210]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1nNC1j1c17-00wkAp; Mon, 04
 Jul 2022 11:25:26 +0200
Message-ID: <bb228b42-e175-513e-0972-57552ef52dc2@gmx.de>
Date:   Mon, 4 Jul 2022 11:25:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/9] serial: core, 8250: set RS485 termination gpio in
 serial core
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
 <20220703170039.2058202-3-LinoSanfilippo@gmx.de>
 <CAHp75Vf7Lm9J3GONazY1OZdMLSWp3aa2iQNztsSVZOPWy3=cfA@mail.gmail.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <CAHp75Vf7Lm9J3GONazY1OZdMLSWp3aa2iQNztsSVZOPWy3=cfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dvsa0LVT82WeAEqY3B18IQwgHTM8am8FU0xKoRnYcHMxE1XxzeD
 gM1jVLYerT8KrnpsYY73G8Pu/Yk6BGn7pUI1Y6h6AtLXvQZ319kg66HR+BmzJxIVj1OAnCZ
 8aHZBUbt3BG2ABnZG4XqQTuk2ty7TqpVLzSS12kD1Hgk8xUqDRV0dL7egd4uGzq06hPE0mK
 5g08PqVnazwNXh7s5IDcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NWwClxxWj5I=:4NiUOBAjyjp7fBz9FmEYjy
 g086C/Kg0BEdwt5nhrb/PI6x1IXjgnW4JNrtsMhshhDwIGRso54O43Xi8lNGYTZ0OKqLTVLw8
 SCsnO9AGiCU9jSfqJ+K4J99ekKNd/rn+TDeZV9RZoJlN5od24A11POoHbxwM00yDFAoZSRVZY
 7vqjqwci7FKtBz9hrmzoxJk9dR+2hedibQQtpsKg8SBUwlyCyhL2krtGYLfQYbbI5RSRL5bdi
 kBGBr/7TJz3+HyiT3Rchx3MC0P+4vUHQaYbxJlfiEENLsz/540Zv8F6ZZEHdjuvGgJfjhndWt
 7lbQWONX62l0DhOxqzfrOxmn3naTW8h2vAMf6wkGjhrQGS3dlMjyB+ms0+YNWYJ82Kq+ie9sE
 WSsZbmCXkLUmvyFAGPyBLor/+uB+bAOBk5y5olkxwbOnwxT4O1mXlUF0pef8V2N0OSNoof1FQ
 74+RhKSvRtCitKCD/f4plyfDNzPsaqdCTC9D4IrO/GIC/LzHI31FnjWuozywR4p7j65pb/vjP
 PrBCqWosDwx5jG5BK0Wt3gUIcCB8ukECbPOTf36JZRb8bwZlkHeTYTFO80Z2aP86vDC5oYUpP
 Yf8TT5sVmAfKxrPfGiJXNy0DCtzieQGDhn1mxjPP144MvMUtTzYabs/xMaNtxaBrN1ur62TMt
 20aK1J/32fgG3Cw/5Kqa/yiKAuWcFkEUf4nzX4U3cDkGNxE4a8vBp95/IcY3mBqUoWIfWwvGp
 OxP9OxUPcV0XmUwP5GQIiRYuATeyptzF5kRMRXgsP7WZA5iQoVsP3PgIjKgpW4jtAAkPDz6BL
 aMysL6693f3w7ELI12IAETJ4ypvpeAnu/6Tnta4EFqHK+9RyMuBOBkGezx6hr6p/ZjYqMlhZX
 p1uWxSVorgkusZngVbuXPLOWW/QHG140RZjHxVZemJhfNjTfuQLjH2R2XdjMKkivvxrv1VzD0
 mp0Yn0R0E2QJKfXkDm+/z79uLK8wX0Qa8mUASCgQA1LBfMVsmTF09Zqi8EfZkPSutIUY6xyhM
 Eg7DpNgT42jrRkPmiAt/Yjej8bn91UMTISSohG++v6pcqt5pwKwsAXOdS90kw3v9aJPw1B78X
 3KQ4uIhmLn2PM1TrjiPt+ZzxUgA8E9Zn/7K/woEdOe7+YLcRC0p9JFn1w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.07.22 20:31, Andy Shevchenko wrote:
> On Sun, Jul 3, 2022 at 7:02 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> w=
rote:
>>
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
>> in the serial core and using gpiod_set_value_cansleep() which instead o=
f
>> gpiod_set_value() allows to sleep.
>
> allows it to
>

Ok.

>> Beside fixing the termination GPIO line setting for the 8250 driver thi=
s
>> change also makes setting the termination GPIO generic for all UART
>> drivers.
>
> ...
>
>> +static void uart_set_rs485_termination(struct uart_port *port,
>> +                                      const struct serial_rs485 *rs485=
)
>> +{
>
>> +       if (!port->rs485_term_gpio
>
> This duplicates the check the GPIO library does. Drop it.
>

Ok.

>> || !(rs485->flags & SER_RS485_ENABLED))
>> +               return;
>> +
>> +       gpiod_set_value_cansleep(port->rs485_term_gpio,
>> +                                !!(rs485->flags & SER_RS485_TERMINATE_=
BUS));
>> +}
>

Thanks for the review!

Regards,
Lino
