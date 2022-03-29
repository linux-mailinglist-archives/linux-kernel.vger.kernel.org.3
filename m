Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31E24EAAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiC2KFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiC2KFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:05:15 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0106E5A588;
        Tue, 29 Mar 2022 03:03:30 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6E128102EF014;
        Tue, 29 Mar 2022 12:03:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4C2A6371B2; Tue, 29 Mar 2022 12:03:28 +0200 (CEST)
Date:   Tue, 29 Mar 2022 12:03:28 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH] serial: Revert RS485 polarity change on UART open
Message-ID: <20220329100328.GA2090@wunner.de>
References: <20220329085050.311408-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329085050.311408-1-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc += Ilpo, Lino]

On Tue, Mar 29, 2022 at 10:50:50AM +0200, Matthias Schiffer wrote:
> While the change of the RS485 polarity in
> commit d3b3404df318 ("serial: Fix incorrect rs485 polarity on uart open")
> might have made sense based on the original intention of the
> rs485-rts-active-low flag (*), this is not how it is implemented in
> various drivers:
[...]
> [(*) My understanding of the mentioned commit's description is that
> rs485-rts-active-low should have referred to the electical signal level
> of the RTS pin, rather than the logical RTS state as understood by the
> UART controller.]

Since RTS is often just a GPIO on a pin controller that's configured
to function as RTS, my expectation would be that the same rules apply
to RTS polarity as those that apply to *any* GPIO.

According to Documentation/devicetree/bindings/gpio/gpio.txt:

"A gpio-specifier should contain a flag indicating the GPIO polarity; active-
 high or active-low. If it does, the following best practices should be
 followed:
 The gpio-specifier's polarity flag should represent the physical level at the
                                                         ^^^^^^^^^^^^^^
 GPIO controller that achieves (or represents, for inputs) a logically asserted
 value at the device."


> At least the 8250 and the i.MX UART drivers interpret rs485-rts-active-low

Which 8250 driver are you referring to specifically?  When developing
d3b3404df318, I tested with 8250_bcm2835aux.c and amba-pl011.c.  Both
worked exactly the way they should.

If imx.c and others have historically interpreted rs485-rts-active-low
to mean that the physical level is "high" when active, then we could just
amend imx_uart_probe() such that after calling uart_get_rs485_mode(),
the SER_RS485_RTS_ON_SEND and SER_RS485_RTS_AFTER_SEND bits are
flipped.  Would that work for you?

I'll go through the drivers to check which ones are affected.  I'm sorry
that you're seeing breakage, it's surprising to me that these different
interpretations of rs485-rts-active-low exist.

Thanks,

Lukas
