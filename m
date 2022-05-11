Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B1523105
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiEKKxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiEKKxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:53:05 -0400
X-Greylist: delayed 1804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 May 2022 03:53:02 PDT
Received: from connect2.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618A0880EC;
        Wed, 11 May 2022 03:53:02 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect2.vanmierlo.com (Kerio Connect 9.4.0) with ESMTPA;
        Wed, 11 May 2022 12:22:16 +0200
MIME-Version: 1.0
Date:   Wed, 11 May 2022 12:22:16 +0200
From:   m.brock@vanmierlo.com
To:     David Laight <David.Laight@aculab.com>
Cc:     'Matthias Schiffer' <matthias.schiffer@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] serial: Revert RS485 polarity change on UART open
In-Reply-To: <df0034da2db14b6b9993c37422a6711d@AcuMS.aculab.com>
References: <20220329085050.311408-1-matthias.schiffer@ew.tq-group.com>
 <20220329100328.GA2090@wunner.de>
 <b2f29129f966685105e09781620b85c8f4f1a88e.camel@ew.tq-group.com>
 <749eee7dd2c7464a8c4d9ea5972205fa@AcuMS.aculab.com>
 <82266d339e09ad16963e16014cd836fa670b3a0c.camel@ew.tq-group.com>
 <df0034da2db14b6b9993c37422a6711d@AcuMS.aculab.com>
Message-ID: <8f44fa843e3053f19e3ec749e3083a5a@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight wrote on 2022-03-29 15:19:
> From: Matthias Schiffer
>> Sent: 29 March 2022 14:03
>> 
>> On Tue, 2022-03-29 at 12:55 +0000, David Laight wrote:
>> > From: Matthias Schiffer
>> > > Sent: 29 March 2022 11:39
>> > ...
>> > > I guess that would work. The fact that even the different
>> > > variants of the 8250 are implemented inconsistently makes this
>> > > especially ugly... It certainly puts a damper on the efforts to
>> > > make the handling of RS485 in serial drivers more generic.
>> >
>> > One thing to remember is that RS232 (IIRC really V.38) line driver
>> > chips are typically inverting.
>> >
>> > So the modem signals on a TTL level output will have the
>> > opposite polarity to that required on the actual connector.
>> >
>> > Normally a UART will have an 'active high' register bit for
>> > a modem signal that drives and 'active low' pin so you get
>> > the correct polarity with an inverting line driver.
>> >
>> > 	David
>> >
>> 
>> Indeed. As far as I can tell, this property of UARTs is what got us
>> into this mess: Some people interpreted SER_RS485_RTS_ON_SEND as "set
>> the RTS flag in the MCR register on send", while other thought it
>> should mean "set the RTS pin to high on send", leading to opposite
>> behaviours in different UART drivers (and even different UART variants
>> in the same driver, in the case of the 8250 family).
> 
> Hmmm... A complete mess.
> The 'RTS pin' that needs to go high is the one on the (typically) 'D'
> connector after the inverting line driver.
> Not the pin on the uart package.
> I'd expect TTL level serial interfaces to require active low
> modem signals.

A typical 'D' connector for RS485? I've seen all sorts of connectors
and I can't say one of them is typical. You're assuming there are
RS232 level shifters in play, but usually there aren't and the TTL
UART signals are directly connected to an RS485 transceiver. For
RS485 there is no outside RTS pin, so you will have to talk about
the UART TTL pin.

https://www.kernel.org/doc/Documentation/serial/serial-rs485.txt
is unfortunately not entirely clear:
	/* Set logical level for RTS pin equal to 1 when sending: */
	rs485conf.flags |= SER_RS485_RTS_ON_SEND;

Most (all?) UART chips have an RTSn, RTS# or /RTS pin which means RTS
inverted. So the "RTS pin" can't be set to logic level 1, but RTS can.

IMHO it would be best to let SER_RS485_RTS_ON_SEND mean that RTS is
asserted during sending. That means that RTSn should be 0V.

When the UART chip is connected directly to an RS485 driver with RTSn
connected to DE, you need SER_RS485_RTS_AFTER_SEND so RTS=0 and
RTSn=DE=1 during sending.

When a UART is not in RS485 mode and unopened it usually has RTS=0,
RTSn=1 which would make any directly connected RS485 driver claim
the bus. This is probably undesired behaviour and thus asks for an
extra inverter between RTSn and DE. With this added inverter one
would need SER_RS485_RTS_ON_SEND.

https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/serial/rs485.yaml
isn't much better either:
  rs485-rts-active-low:
     description: drive RTS low when sending (default is high).

Was this meant as "drive the RTSn pin low when sending"?

Finally, can these two methods be synchronized in their wording?
E.g. can we just drop "rs485-rts-active-low" and replace it with
"rs485-rts-on-send" and "rs485-rts-after-send"?

Maarten

