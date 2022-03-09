Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D994D2AF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiCIIxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiCIIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:53:38 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDC913D1B;
        Wed,  9 Mar 2022 00:52:38 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7100A100DECB3;
        Wed,  9 Mar 2022 09:52:36 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4F75824ADCC; Wed,  9 Mar 2022 09:52:36 +0100 (CET)
Date:   Wed, 9 Mar 2022 09:52:36 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
Message-ID: <20220309085236.GA8259@wunner.de>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com>
 <20220306184857.GA19394@wunner.de>
 <c2607267-798b-d7a0-86f6-4a729c22911f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2607267-798b-d7a0-86f6-4a729c22911f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 12:54:19PM +0200, Ilpo Järvinen wrote:
> I don't have strong opinion on the actual names myself (every RS-485 
> transceivers I've come across name their pins to DE and RE).

It's true that transceiver datasheets usually call these pins DE and RE,
but on the UART side, by convention the RTS pin is used to drive DE.

And RTS is then either asserted/deasserted in software (by the kernel
driver), or by the UART hardware if it's capable of it.

Hence the properties in Documentation/devicetree/bindings/serial/rs485.yaml
and the members in struct serial_rs485 refer to "rts".  It's synonymous
to DE.  I suppose Synopsys wanted to afford the integrator of the IP core
as much freedom as possible and therefore offers separate RTS+DE pins
as well as an RE pin.  But that degree of freedom also leads to confusion,
particularly if firmware might mux the pins in an unexpected way
behind the OS's back.

The RE pin of transceivers is usually either pulled-up (i.e. always
asserted, full-duplex) or connected to negated RTS (half-duplex).
A lot of transceivers have a !RE pin so RTS can be wired directly
to DE and !RE.

Full-duplex is primarily for RS-422.  If full-duplex is enabled with
RS-485, you'll receive your own echo, which is often (but not always)
undesirable (depends on the application).

For simplicity and consistency, it is best if the existing properties
defined in rs485.yaml are used, instead of defining new ones which
have the same meaning.  For this reason I'd recommend using
rs485-rts-active-low for the polarity of the DE pin.


> What I think is more important though, is that RE would be by default
> active low which matches to about every RS485 transceiver expectations.
> Given what device_property_read_bool does when the property is missing,
> it would make sense to have the property named as -active-high but I
> don't know if that breaks some dt naming rule to have them opposites
> of each other like that?

That's a good point, I agree.  I don't think that would violate any
DT naming rule.

Thanks,

Lukas
