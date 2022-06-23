Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB695589E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiFWUSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiFWUSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:18:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FEE1117A;
        Thu, 23 Jun 2022 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656015467;
        bh=vfPNIRhnq1OdqJcq3jU+UUkt3Jq6ykiRIvEk6ESnqV0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DkyC7OozGGUP4BgihSdq1Ua5uwN0i8zct8Io6R/54SEo6xP03uyPzTKb8mFcBfN1G
         ECmXjjaYQIWMQOuYB5TJs7HZz5nJsnpqbQm/yEM7G261RIIjmvo+dpJ2YQefLT6FdY
         Mxfiq6rtQkpCOUMFL7ilV+UFKtcOxvonCtHio5/g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp5Q-1o9wta45ts-00Y6cL; Thu, 23
 Jun 2022 22:17:47 +0200
Subject: Re: [PATCH 3/8] serial: core: move sanitizing of RS485 delays into
 own function
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-4-LinoSanfilippo@gmx.de>
 <YrST4zDJjSo5aNZh@smile.fi.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <f87a7afa-4e71-89e0-180d-838ee571f034@gmx.de>
Date:   Thu, 23 Jun 2022 22:17:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YrST4zDJjSo5aNZh@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MlIZNCB/cKHnao/KkKQQo64o6gBA+Mg8XtF0OQE+LZm4qmSzN6e
 bBYdoqQDTqaOs+uf9KVAYNz1svthz8PFn9hqYe0V5pis0o8lWanxkWT3WgIZIXAchlK45r2
 OTHQaUtfh2heN8cBnjYyzDnLAQ6JxcH8OlVnmEtwh5yAG52fKskOqjHinh3rXhvwHUVcGXT
 8vqVOeBuG6cx9fQYaJEaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PnFNSWXGN20=:K+VZ+fdpijAzxGztybVAVH
 MjuGYf4WgKe3wfNEMWZyYPUi935zXEmIMHFvHrfX8IKHUzdrQG2/tuvjfnhd+Fe/grqaHUAnM
 PgtGxHoCxxaLMk/9fJID5brHC+jaDjNTaouZHlI+fitIStgEPICYlbgT9y9+RMwxGJ1gaSAT5
 KyIsm86v1/hEXtV00kmFFuXXm/jeAL0XwM+uHPmYfZQjCkiGMCHyNMXFo/MvwpPnkyq2KiUiq
 6auWmOG1cr0IYK4rBLungRIUI7fI+qeM+/qP7v3xMf3+IlmtviEJvdRkwWuD/KyC0HSjRaI+h
 4/x8bYT5cf6DF+YluT+9jkkEwNKV0X+7Tq0yLgZBzJ8UeFWpz0R3Qa1sk+aYc1vbyYc5CfzuX
 1vbXLA8rkI9VhpEdnHKlk3FX9O3ThwDjTdClxFSCdsBzaUNJiHfA05V4s0r6K9CkpCCP5vHkR
 ZEgN7nen9/rMBTggOBQH4WqRfDTIzTO86iqmq51PGh+tQa1il2goEEK+ut8UcN1SVqchykk65
 sLCpJ8dY/5jHRLVlKfB6oVIlBoVhf691HpREc41rO7O6yovAwjuvKPmVJNyUOTwwsvrG9AV4g
 FMBFbPvZBzLo9fMrQfibAHCW+D2CSE1CC1sOn6X45+x4QFja8QfiKiQvFNARi1CswiHwIqI1h
 sepg5ldUdIjiC/0134TAwxWqQG3+ynO8kmmxqd1VW81qh5OrO9/ogTHW2wBaMFARpmVkycjxO
 cH6n3nmnrLaI6lRad3JJEq0XusEega0VPzbjYNIVDoCj2XkgAJ/heja4idQNovT3SsWm3qXII
 8IEmSJ/ryIcMjLfQyVPXgPuxquKkgAN5h0S2rj8mcPWOljRCqszRNbku3ZbtthIEGHs86/Sqo
 YKugJ1syxvjtw9eFJAJ3sfb9LZIK7dwD3UcrV4KlftiCJlIHPwQhq6M3qRyYgHDnU0RK+tg+D
 QR4TdNwFczfg+6F5jC/js//NTPX3lBY37uXBtSPobjEfN37i8Int0CBoUCLsTZHRMTipbG+Fz
 n5+Ip5yXDTSMVSslnTUXxkEMy/qNuGe/0lzZMexrzbfx+dcYds2JPcrxAbV6qMKdkrn9X6z/e
 vWHYTvS7LDPw3Hz45sss0Xm9EFoTg/o6eFnuTwOM3rQ45w0j3W4iRVchg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.06.22 at 18:25, Andy Shevchenko wrote:
> On Wed, Jun 22, 2022 at 05:46:54PM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> Move the sanitizing of RS485 delays out of uart_sanitize_serial_rs485()
>> into the new function uart_sanitize_serial_rs485_delays().
>
> ...
>
>> +	/* pick sane settings if the user hasn't */
>
> Be consistent with the style (capitalization) of one-line comments.

Ok, I will adjust this.

> (Below is left for a context)
>
>>  	/* Return clean padding area to userspace */
>
Regards,
Lino
