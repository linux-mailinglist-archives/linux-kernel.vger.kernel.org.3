Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C159A5760EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiGOLw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiGOLw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:52:27 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528389EA7;
        Fri, 15 Jul 2022 04:52:26 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E906522175;
        Fri, 15 Jul 2022 13:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657885944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qHIQnN1CQKPRNKNPt8IY1glg9IKOeRpM3quFOgpAShQ=;
        b=a0Hu8QXzwVmoABu7ntZQG/hoBsyTlCS7wQCMUZ5BChTxeQyggZrNPCzsvB0E+ke2Kn8mHA
        WV47FoCkiQxBpIjOBV6/q/FxZDS7yI1/RoqKZCg8VJp9VkGJcDglkZpM+BwkqA9qqKCyBk
        nn0N9Oy34YwynrNe+7UXznhWafk0slg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Jul 2022 13:52:23 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: writing a 1 and then a 0 to
 trigger a break character
In-Reply-To: <AS8PR04MB8404B8E3EB0FFCEE8ADDA283928B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220715025944.11076-1-sherry.sun@nxp.com>
 <20220715025944.11076-3-sherry.sun@nxp.com>
 <509669b26b5899088e9b77ed94d103ee@walle.cc>
 <AS8PR04MB840448675E64E4FCDEEF91A1928B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <e2560f01fd1731ea2422d82c97efcc6f@walle.cc>
 <AS8PR04MB8404B8E3EB0FFCEE8ADDA283928B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <61c525fc87d6586c024cd6e42fcf876d@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-15 11:18, schrieb Sherry Sun:
>> Am 2022-07-15 09:20, schrieb Sherry Sun:
>> >> Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: writing a 1 and
>> >> then a 0 to trigger a break character
>> >>
>> >> Hi,
>> >>
>> >> Am 2022-07-15 04:59, schrieb Sherry Sun:
>> >> > According to the lpuart reference manual, need to writing a 1 and
>> >> > then a
>> >> > 0 to the UARTCTRL_SBK field queues a break character in the
>> >> > transmit data stream. Only writing a 1 cannot trigger the break
>> >> > character, so fix it.
>> >>
>> >> I don't think this is correct. The tty core will already call this:
>> >>    .break_ctl(port, 1)
>> >>    usleep()
>> >>    .break_ctl(port, 0)
>> >>
>> >> So you'll have your 1->0 transition.
>> >>
>> >> My RM from the LS1028A says the following:
>> >>
>> >> | Writing a 1 and then a 0 to SBK queues a break character in the
>> >> | transmit data stream. Additional break characters of 10 to 13, or
>> >> | 13 to 16 if LPUART_STATBRK13] is set, bit times of logic 0 are
>> >> | queued
>> >> as
>> >> | long as SBK is set. Depending on the timing of the set and clear of
>> >> | SBK relative to the information currently being transmitted, a
>> >> second
>> >> | break character may be queued before software clears SBK.
>> >>
>> >> To me it seems that setting the SBK bit just pulls the TX line low
>> >> and releasing it will return to normal transmitter mode.
>> >>
>> >
>> > Hi Michael,
>> >
>> > Actually set break_ctl(tty, -1) then break_ctl(tty, 0) is only done in
>> > the send_break() function.
>> > If we call TIOCSBRK from user space, it will only set break_ctl(tty,
>> > -1) without break_ctl(tty, 0).
>> 
>> That is expected. no? There is also the TIOCCBRK which will clear the
>> break. TIOCSBRK will just turn the break on.
>> 
>> I'm not sure if the break is already transmitted when the SBK bit
>> is set, though. Is that your problem here? I'd need to check that
>> on the real hardware.
>> 
> 
> Hi Michael,
> 
> Seems we have the different understanding of the break_ctl(port,ctl)
> callback. The original break_ctl(tty,-1) in lpuart will not send the
> break signal until we call break_ctl(tty,0).

That is not correct. The TX linue goes low as soon as the SBK bit
is set. See below.

> Per my understanding of
> "If ctl is nonzero, the break signal should be transmitted", call
> break_ctl(tty,-1) is enough the send one break signal, now my patch
> makes the behavior align with my understanding.

As I said, Greg should clarify here.

In any case, I've checked the hardware (LS1028A) and as soon as you
set the SBK bit, the TX line goes low (TTL levels) as expected. It
will go to high again as soon as you clear the bit again.

So to me it seems there is nothing wrong here. Also have a look
at man ioctl_tty:

        TIOCSBRK
               Turn break on, that is, start sending zero bits.

        TIOCCBRK
               Turn break off, that is, stop sending zero bits.

So to send one break "character", you need to do ioctl(TIOCSBRK)
followed by an ioctl(TIOCCBRK).

-michael

> And my understanding of break_ctl(tty,0) is that it will terminate the
> break signal send requirement which has not been done instead of
> cooperate with break_ctl(tty,-1) to finish one break character send
> behavior.
> 
>    | break_ctl(port,ctl)
>    | Control the transmission of a break signal.  If ctl is
>    | nonzero, the break signal should be transmitted.  The signal
>    | should be terminated when another call is made with a zero
>    | ctl.
> 
> Best regards
> Sherry
> 
> 
>> > And from the definition of .break_ctl(port,ctl), the callback is used
>> > to Control the transmission of a break
>> > signal(Documentation/driver-api/serial/driver.rst), if ctl is nonzero,
>> > it should queues a break character. I don't think it is reasonable to
>> > call break_ctl() twice in order to send one break signal.
>> 
>> Maybe Gred can correct me, but to me it seems like the .break_ctl()
>> will set the *state* according to the argument, that is either
>> turning it on or turning it off (Except if TTY_DRIVER_HARDWARE_BREAK
>> is set, but that doesn't seem to be supported by the ioctl interface.)
>> 
>> > Also I have tried other uart IP, such as drivers/tty/serial/imx.c, it
>> > also queues a break character if we call break_ctl() once. So I
>> > believe the break_ctl() in lpuart driver should be fixed.
