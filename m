Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD9C55B2AB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 17:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiFZPmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 11:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZPmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 11:42:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F39EDFDB;
        Sun, 26 Jun 2022 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656258099;
        bh=9wnn2viNtYo2HS4a6b8V2lbF+SSHfd4WFAFaclgRsso=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SHlhQLJT8dgGcqR+X5nHvn7Yjw4el0brNLtT897XUkjePIvV7HSm8fOECnfOBmutl
         x6KPuUYG554QgIvtaUVlD7FQ+d0+i/+9+eK0kxF/jy2xDFddJR5rmueyp6NRelRDzk
         wCOCGuqjgcXIdlJrmnUVtAgIv3A+7RhI+qgSCuuA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.248]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1o0Ef93eAf-0085OH; Sun, 26
 Jun 2022 17:41:38 +0200
Subject: Re: [PATCH 2/8] serial: core, 8250: set RS485 termination gpio in
 serial core
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
 <20220622154659.8710-3-LinoSanfilippo@gmx.de>
 <83762813-70ec-93c3-4015-5676ce9534fd@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <aa851698-ff26-a319-500a-575a9c669d95@gmx.de>
Date:   Sun, 26 Jun 2022 17:41:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <83762813-70ec-93c3-4015-5676ce9534fd@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cyIQlMtZ+G8jaNtEoKMkpMf21pMZu7+zmG4ZsrBrWfjfJ8shTgY
 pupK7k4b3RxBSSU6r9jfqTCB/AphGTAU8V3S3pjE2iwtUCvrYjHGrkDi+IPTZtbaekmMP+j
 XLGfEG2lV+c8+nuB09tRdgrxUIbTeEoRaX28TCdEgdjkjYfN9fyuas6tcj1o9kLXhp5/HUn
 m8SricM+TNI9EiH/EpPHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fIJ5qj6lHQc=:8S6VSR7PdExKw8bJkX+MlF
 H3suE7c7Pe31QjpiBufX07LOqmrqcIPg9Fb74x6UYoHX0oIemab+QCZnQBoipJ+ZRU2MrHS5x
 YbZZsMXFkSyd/jraIb1QkxALtwaYRC2TVItcrFAP2khOCzjkahUGtg7Xo1vQzri/EgV1fureK
 ZnJ8BWp32B9RgiCm1+6YaDmTDvNwEC3AH64mKc7RWIGcOuJG+v96COjpg6GFgMmakS4TDCUiA
 qePKp9BlPyrft6XyxHuFMXGe9lPiwzUHBNljEGGDaLLLiHr5DpWOQ55YRFZz95yDMhFddqdLP
 w/It7/0N/09QO+MWw2n+/CZfkxqxFyW9+WLEkz8pZ78Yg41AsXS6TFvKfwy7HfhbBNkfs7kGG
 M65SooRgYaOFRySABeQHafEaPv3vn6eo9Aizb7ntyPC3sYHoDpBMQbIyFgDixyd0atKw1rXhj
 IxmzzuSac633dPs8pwy537nD1TGox6uBlR2ibk5Lmf1RvI2TnTyL9en4iPXiyHvhnDIdvYr2p
 WURTyDybVg/jtC445+TLuZtbGkdxV7M3f+dYrJV7AQozPjQMJ7NqNkOHCBd5tgxsQhNKp9ZKh
 DHnukgvivd57KVUuh/Btq3PbkAWd9s2fkNWRZICTJDaytt2dlBBBOZXGzhrDTJPhJgaakrcqa
 43vh758Dkg1bf8ZKqb++q0PLM+0QWAAWwqkaHD9Dlh3cXOmg0x22nwN/wqW7onSPqbLMB+Rm5
 ZbXnuqPM9JBXQQZvLtiwphigpARm/8JWzI6syf/EH4VF9oU2KrVtU3b6oFDbAbZVXQqBhY0PL
 2xfoyQR7UUYsYt8hyKBG9cCwLrcNwjxeUjOVFTyUuOoegcCADElKZMxE63J6UU6MaBCRVlkNp
 LYkOPRUGYyrFZpctUonaYlx4cWvaMifyDxhe7g2aXBjPtjkuYPHWmy7YLxxuAhiugVFmkKaQW
 eRtw+y89NGeDycpISmXxIdc2u4mt12L3+LMCMwc8cGaaHYbekAAvdjIiVBL+aJJswjPSnc8c5
 FCwh/4nmH8Ruo8qTnNeSjZqJKOXWJ+/i9ftc7HxCGup0W2J/vsr64f1jZwObNz6n4/i7UdFNN
 eepTFF5kuDkJc12KYI927EsBzYxv0oAaKKj7n9hqdRjENbw/9nZfNcuPg==
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

On 25.06.22 at 12:40, Ilpo J=C3=A4rvinen wrote:
>> +
>>  int uart_rs485_config(struct uart_port *port)
>>  {
>>  	struct serial_rs485 *rs485 =3D &port->rs485;
>>  	int ret;
>>
>>  	uart_sanitize_serial_rs485(port, rs485);
>> +	uart_set_rs485_termination(port, rs485);
>>
>>  	ret =3D port->rs485_config(port, rs485);
>>  	if (ret)
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
> When port->rs485_config(port, &rs485) returns non-zero, the input got
> partially applied?
>
>
The thing is we dont know what the state of the termination GPIO (asserted=
 or deasserted)
was before we set it and port->rs485_config() failed, so we cannot restore=
 it.
We could read the GPIO before we change it but AFAIK this is unsafe since =
it is an output
pin. Maybe add a boolean variable "rs485_termination_gpio_asserted" to uar=
t_port to track the
current state?


Regards,
Lino



