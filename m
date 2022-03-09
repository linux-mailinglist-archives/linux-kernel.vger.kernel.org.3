Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7394D2F90
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiCINAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiCINAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:00:09 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7C514FFEF;
        Wed,  9 Mar 2022 04:59:10 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 794E5300271E9;
        Wed,  9 Mar 2022 13:59:08 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6E99C43D590; Wed,  9 Mar 2022 13:59:08 +0100 (CET)
Date:   Wed, 9 Mar 2022 13:59:08 +0100
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
Message-ID: <20220309125908.GA9283@wunner.de>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com>
 <20220306184857.GA19394@wunner.de>
 <c2607267-798b-d7a0-86f6-4a729c22911f@linux.intel.com>
 <9c2d96c0-44cf-c84c-5ff7-34c74716a23b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c2d96c0-44cf-c84c-5ff7-34c74716a23b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 02:19:39PM +0200, Ilpo Järvinen wrote:
> Now that it has been pretty much established that anything called "rts" 
> should be applied to DE as well, I took another look on implementing these 
> delays.
> 
> It turns out to be impractical to do/ineffective because "serial clock 
> periods" are used as the unit by the HW ("serial clock periods" is not as 
> clearly defined by the datasheet as I'd like but it is most likely based 
> on the high-rated uartclk cycles). With the uartclk I've on test HW, the 
> combined delay with max turnaround time and DE assert/de-assert timings 
> cannot do even the smallest possible non-zero value (1 msec). That's 
> because the TAT and DET registers allow only 16-bit and 8-bit values for 
> delays.

A mistake was made when RS-485 support was introduced in the kernel
more than 10 years ago with commits c26c56c0 and 93f3350c:

The delays were defined in msec, but if you look at datasheets of
RS-485 transceivers, they only need a delay in the nanosecond or
single-digit usec range.

Here's a collection of delays I compiled two years ago:

                                 DrvEnable-to-Output    DriverPropagation
          MAX13450E/MAX13451E    5200 ns                 800 ns
          MAXM22510              2540 ns                1040 ns
          MAXM22511                80 ns                  65 ns
          SN65HVD72              9000 ns                1000 ns
          SN65HVD75              7000 ns                  17 ns
          SN65HVD78              8000 ns                  15 ns
          SN65HVD485E            2600 ns                  30 ns
          ADM1486                  15 ns                  17 ns
          ADM3485/ADM3490/ADM3491 900 ns                  35 ns
          ADM3483/ADM3488        1300 ns                1500 ns
          XR33193                2000 ns                1300 ns

Because these delays are so short, it is usually sufficient to set
them to zero in struct serial_rs485.

I've begun a commit to change the delays to nsec, it's still a WIP:

https://github.com/l1k/linux/commit/2c08878b63d6

This is a little tricky because the delays are user-space ABI,
so great care is needed to avoid breakage.  Also, every rs485
driver with support for delays needs to be touched.  Some
UARTs have fixed delays which depend on different clocks,
other UARTs support configurable delays.  Another complication
is that delay calculations easily overflow with nsec because
the numbers become quite large.

A positive side effect of changing the delays to nsec is that
the horrible hrtimer kludge for rs485 software emulation in the
8250_port.c can be eliminated.  Also, all the illegal mdelay()s
in spinlocked context (e.g. serial console output) are replaced
by much more reasonable ndelay()s.

Eliminating the hrtimer kludge in 8250_port.c might also make these
runtime PM patches by Andy simpler:

https://lore.kernel.org/linux-serial/20211115084203.56478-8-tony@atomide.com/

My suggestion would be to set the delays to zero for now in 8250_dw.c
and implement proper delay handling after I've finished the conversion
to nsec.

Thanks,

Lukas
