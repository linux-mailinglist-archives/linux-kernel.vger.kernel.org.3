Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05E557F75
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiFWQJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiFWQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:09:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523B122282;
        Thu, 23 Jun 2022 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656000540;
        bh=LVfs23vytr0zimb1O5cVH3Onv4wtchEeptMsy7Lizb8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aP70jm3yuTSxnnWrofiS/XAV0Rq51NX9yWAW5auMxsH295cKp8c7M5JjYMH08N4tA
         hw6qkz9cRLISCJtqFAeEz80+7acYUTLVmfjTe4E7QBnGmU1k3J18EUVDgOlxCjxPpQ
         Unvkxip1Q5Y5YuRxGZAIVL9tCk8cuYWvOMXENXU0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.134]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1ndi2N1AFb-011fcS; Thu, 23
 Jun 2022 18:09:00 +0200
Subject: Re: [PATCH 1/8] serial: core: only get RS485 termination gpio if
 supported
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-2-LinoSanfilippo@gmx.de>
 <YrNLtg+BZlwKsBbF@smile.fi.intel.com>
 <2dda5707-6f13-6d33-863d-a88b89e88a88@gmx.de>
 <CAHp75Vd_ix=bJs9k6bYM8S+3f_Pw7Tvs9DhPcZxu1=33T=mQ7A@mail.gmail.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <52ea773c-b5b0-fc4d-9b85-022676778af7@gmx.de>
Date:   Thu, 23 Jun 2022 18:08:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd_ix=bJs9k6bYM8S+3f_Pw7Tvs9DhPcZxu1=33T=mQ7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:09XTQUkSt2KXRLTcHveNlWJxbi5ICmeBBHYjgPq0t9NN6SR5HoN
 JNMAOBmYFpLQyJvY2jUS6XHEgS07YECTGNZdYfIB2Tv/Zgij25TFOcRXoavvP9rvqroBfUr
 RnrR/naa6+i/5ahobZX0fXMOdICMNhGrUU+xf5QyMln54NkSawBRiC32TBc3WWcW3KSfdjZ
 Kr66M2gS3fbtPD1+8MMBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EUuBWbEln+g=:k8XzOmHstXmjcO9E8XODLS
 wOIV1JjDZZww3YWcaEYximVeITRW4FoZv4d+of6VLVNpMcsOXwu4WGApKcDkRVKPGelsn5ct9
 9aiHcuBSHmt2eOT5NhbZRY1zGJBXKO5enRVawMJW0BZF5E/UKeZqb3Ye/CpdppusNzMm3/C/W
 AumT79XHSE1VvTmisrbBdWw6/yKS/5dvKGyBRF54dUVeWsL6JazUvKNdfHl8Z8lFZKq3Udes7
 P1Xi0qmjA0IRiL305amODwDzkQSQOC36K8qX+Zqv6lJ9aD7h7wWyhSVs/ZTxt34m9M8B5YoBN
 /q1+03gYj0JD9B27AggWWYPIxVwApUP6jhkNLMmXOzn1q5BOpn1qBxCf8ZUjPEGc0ZsQ9o/Wc
 fAUV8fEXqeppeQdRN0XprCTecqgANaPfsC0BeSd2ZsDoxRPrjAYgVU6/cNoyIukHlvijvsZhO
 jSgxze6JXnT7LCYPhGmG7yrFk6+VVEQy3jglhBO2XTYLXzUwyPBVF77GETVr3g+NqY9iYnBNC
 l1gB8Np2z8VGFk6M3vREm2tItnFjXf5AfvuQVKu0jOjV7aVye6hyt4JS/Q0IfuKoOkRGOwyZs
 LvIDH+tcSKPuy+yMsb7XMS9Bf1QDCQUSZvtvAhlteMAC+yb5XktFRFCnpu+dw06CVO7tbTKwC
 vgr/nkTfKN6X7zJhp2J4/KrlSFHxW/FBm8M5itVxSpqWrYwCSCMa5qtirB4G5oXjApaXR5D95
 VAm36lC/Bd6+xhOvVNY0u5MNNOlX5sl7W3/iyQ7WEFBAm5JPBaUhQYEH9/sL+pg5ce6yoYRdx
 mpRb6AMK/53Y5ArRywj/J8LikQ4ZTglp/t5mnqy2QLjerMlXsl9ghWIi7ZOy9GaEAlnfLymBa
 sjWpjU4L0sMbMzCINLawm0siI0I+2uwHwXTgUCapxRxJ/t9foBh9d4Z0t0/i9OSCYc1DFFKkc
 MmnDoqs7jiimrl7BXYdGjjTNc524DsAelHgklrwL2mqrU1r9y3S/i33ZaJgCLM+/gLRYz4+XR
 j0LdlX9aKsLRv5zvcDKqFeZcZ/cNSTjy+w/9xEJRAOIwILoz9YGxdBKCiZGJclh2Ie56QncCa
 HaEfQchx7lkRERTPzx3VaTmjMR4summMTYSQRxq/KUHLUIQhvAtsbRXug==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.22 at 11:45, Andy Shevchenko wrote:
> On Thu, Jun 23, 2022 at 4:00 AM Lino Sanfilippo <LinoSanfilippo@gmx.de> =
wrote:
>> On 22.06.22 at 19:04, Andy Shevchenko wrote:
>>> On Wed, Jun 22, 2022 at 05:46:52PM +0200, Lino Sanfilippo wrote:
>>>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>>
>>>> In uart_get_rs485_mode() only try to get a termination GPIO if RS485 =
bus
>>>> termination is supported by the driver.
>>>
>>> I'm not sure I got the usefulness of this change.
>>> We request GPIO line as optional, so if one is defined it in the DT/AC=
PI, then
>>> they probably want to (opportunistically) have it>
>>>
>>> With your change it's possible to have a DTS where GPIO line defined i=
n a
>>> broken way and user won't ever know about it, if they are using platfo=
rms
>>> without termination support.
>>
>> This behavior is not introduced with this patch, also in the current co=
de the driver
>> wont inform the user if it does not make use erroneous defined terminat=
ion GPIO.
>
> It does. If a previously stale GPIO resource may have deferred a probe
> and hence one may debug why the driver is not working, after this
> change one may put a stale GPIO resource into DT/ACPI and have nothing
> in the result. Meaning the change relaxes validation which I consider
> is not good.
>

Ok I see the point. So what about changing it to:

	if (port->rs485_term_gpio &&
	    !(port->rs485_supported->flags & SER_RS485_TERMINATE_BUS)) {
		dev_warn(port->dev,
			"%s (%d): RS485 termination gpio not supported by driver\n",
			port->name, port->line);
		devm_gpiod_put(dev, port->rs485_term_gpio);
		port->rs485_term_gpio =3D NULL;
	}

This would also be consistent to the warnings we print in uart_sanitize_se=
rial_rs485() for invalid
RS485 settings.


Regards,
Lino



