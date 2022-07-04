Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C435C565994
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiGDPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGDPOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:14:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ADEBC83;
        Mon,  4 Jul 2022 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656947623;
        bh=lw9l19cpkr4yCqcc6HT5BAREEapDuSh+BtMq4Z73ojA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=joU5t0cevbn9FI0a3XUrCa89xeWo84Gyc3+bVds9L2qAWszvbCKziivpG4hR6r7oB
         m0dNdOh+uhTlrn3MmgupsNYjZWUz9xS3REe5+Hy2d34gM7NSFCRv+OhaHNl6z5iMx+
         wQeOcrfhPoI0h6AGR585T0/XEYi1H3MvdPBWcaBA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.210]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1nh3Ep2wyy-00h9Fb; Mon, 04
 Jul 2022 17:13:43 +0200
Message-ID: <576feae5-87f3-fbac-4349-126cf5244821@gmx.de>
Date:   Mon, 4 Jul 2022 17:13:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/9] serial: core, 8250: set RS485 termination gpio in
 serial core
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de>
 <20220703170039.2058202-3-LinoSanfilippo@gmx.de>
 <355354ef-61ff-692d-aad-3b5721db420@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <355354ef-61ff-692d-aad-3b5721db420@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7BLvkQ8Daoruut0OeY5prEW4I+47ILt1MxrQ+u1s/fM+oDJ3G5M
 bU/gqksPJ/AyAYj+2nJd1fnExnWNC9/G+8lOKaqIcdN0o5ssnKLE9PIjN0MUsjeb6+wdoXj
 TX+pNEdkIzjEUa2ZO21peLKT/Mf/pD3CXVPX7FxAXp2Blh7xic3KbOwVgyv2Sw3p9ydPqCG
 gj+B0zgEZm2dv1aMRZXlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VKzmQ5Nig5Y=:Hu9TT4m/x7bFkXRNGtkvXi
 VEQsvAW6y0StxIsUHP9ibrObGi7xmCvpqp7nptXo6k/eJ2n+cRX6BQRndmCpqx675G7a9oQg0
 hpZ6IuKw8b3x5RKOOXBOVNejCFekRl1pfqgxBNI4N8IGv5UiUXHnhSzeRtUND4dHYzCDq/+DO
 s2CEr3O5t4H0ajc5xgSY7xO+7A9pa9PTZeLtwm3V890C8cN/cEkh1KY3AMP4ibFoU54W/qm1A
 Ecw1Ih3SMJ30cg/UAYfNaZ2RpaPGP6wGiyk4wVZSyua3EXfObaiNVRiPuk53roIylG1I0OCzZ
 j2FhUAhG2DMvl2tq5M0WXw9TdSN1E9bV3vEnChf3vmQFtqeddwl3A+5Q7igmn4IFruaYgyB6+
 /zjGAdWpqEv/jFTCgCPS73PbnUYtPrTBFyb4i5xUD0x7Yc/SqXwFLOgmt3SsggF49L3IqOZxy
 hcsEk/zTIjeR6apEVO990gHnPZJ/Hsxschu/1Cr4RUPHn+TT4N8vBMG5JEesWaCvbTTeaHhF2
 0fkXz+0FXVO777VmZHUxLIl1PKg8di9gBYXpLrVCtRJ9qK33KAcMxNCF1ChWNpt5O+qfldL9N
 YnLocx5qSCyie5iX1QtfPElnPTl9X683qFED+vLL5NzhyaSafgfGyttbdWg/3w0XjmkhlQ2VL
 WO2BaJtgQaIcPA8dg8CDRsTz4IW98RCwnc3X1LqpzfzFs8EoNNOJnEdxNUxjGVvvbWQ/mgHUU
 UV8LvkfbtDM724J8gJhheZEd6CTfUYt2EgU5Pa+G8T1atE5uK4RZkZuIWNVeowRHUgtUcAC3f
 l7AmwgUJJo9J/M5sNJeFg0vxO3Nv5nWQBbOmZcmwOlW0z9Onudj3JDs87ZoYBXXL0me7WVjPy
 npO1ARNdrYRHokIAVmoxBnyyw2u9yCXaqfomjutlCg1cZFGQFzDlqoLHYndVQJS2uRK0NQ/lZ
 vv//o4SAoXC//ux4t7fJC+NXcIRkdJI0G70VxQe1dZaArlXSONgr2tHPxd44tBSOKRYz17Gij
 VQ0EOFYHHgo0opMIy0ZEoNJxhzXkyZGg0da7GL5a1wSoHGrWqF7iusMTgycLowjmc+ZuHWL/b
 l+49bBwS5aShZ8fs31cPGs1dspSVcxR+K28Z9PlIVkh+3PAXR4eZ7TDLw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.07.22 11:51, Ilpo J=C3=A4rvinen wrote:
> On Sun, 3 Jul 2022, Lino Sanfilippo wrote:
>
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
>>
>> Beside fixing the termination GPIO line setting for the 8250 driver thi=
s
>> change also makes setting the termination GPIO generic for all UART
>> drivers.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/tty/serial/8250/8250_port.c |  3 ---
>>  drivers/tty/serial/serial_core.c    | 12 ++++++++++++
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
>> index ed2a606f2da7..72252d956f17 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -676,9 +676,6 @@ int serial8250_em485_config(struct uart_port *port,=
 struct ktermios *termios,
>>  		rs485->flags &=3D ~SER_RS485_RTS_AFTER_SEND;
>>  	}
>>
>> -	gpiod_set_value(port->rs485_term_gpio,
>> -			rs485->flags & SER_RS485_TERMINATE_BUS);
>> -
>
> I sent a series to make .rs485_supported per uart_port and properly set
> SER_RS485_TERMINATE_BUS according to DT config. With that series added
> first, SER_RS485_TERMINATE_BUS should also be removed from
> serial8250_em485_supported so that serial core can properly manage
> it all.
>

Ok, I will rebase the next version of my patches on your series then.

Regards,
Lino
