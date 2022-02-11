Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A328F4B2EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353325AbiBKUmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:42:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiBKUmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:42:42 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B539FC55;
        Fri, 11 Feb 2022 12:42:40 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 07AED425;
        Fri, 11 Feb 2022 12:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1644612160;
        bh=NcOgnI4XVfpjdB5tu79X+6ZPVwodL2Y1hcUhjUhpw9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfUd4S7cGL8zKJd82OGDd1XIqCApewYFWIxJI5wLhD903V4RL8n0s2Cm76sHf6R1i
         zhGdpyg4u988T8ydyEMqDch6dmqiLAK09eZHet/sISpXXK0wuSY/KRuRSAc634kUEr
         EQorTx2VE6+tCSUdsTYEdI2WzP5Znhm/gUcMgEtc=
Date:   Fri, 11 Feb 2022 12:42:38 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konstantin Aladyshev <aladyshev22@gmail.com>,
        Oskar Senft <osk@google.com>, openbmc@lists.ozlabs.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_aspeed_vuart: add PORT_ASPEED_VUART port
 type
Message-ID: <YgbKPmZIpfRPKg1k@hatter.bewilderbeest.net>
References: <20220211004203.14915-1-zev@bewilderbeest.net>
 <YgY4IODZlKTG7yzn@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YgY4IODZlKTG7yzn@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 02:19:12AM PST, Andy Shevchenko wrote:
>On Thu, Feb 10, 2022 at 04:42:03PM -0800, Zev Weiss wrote:
>> Commit 54da3e381c2b ("serial: 8250_aspeed_vuart: use UPF_IOREMAP to
>> set up register mapping") fixed a bug that had, as a side-effect,
>> prevented the 8250_aspeed_vuart driver from enabling the VUART's
>> FIFOs.  However, fixing that (and hence enabling the FIFOs) has in
>> turn revealed what appears to be a hardware bug in the ASPEED VUART in
>> which the host-side THRE bit doesn't get if the BMC-side receive FIFO
>> trigger level is set to anything but one byte.  This causes problems
>> for polled-mode writes from the host -- for example, Linux kernel
>> console writes proceed at a glacial pace (less than 100 bytes per
>> second) because the write path waits for a 10ms timeout to expire
>> after every character instead of being able to continue on to the next
>> character upon seeing THRE asserted.  (GRUB behaves similarly.)
>>
>> As a workaround, introduce a new port type for the ASPEED VUART that's
>> identical to PORT_16550A as it had previously been using, but with
>> UART_FCR_R_TRIG_00 instead to set the receive FIFO trigger level to
>> one byte, which (experimentally) seems to avoid the problematic THRE
>> behavior.
>
>...
>
>> +	[PORT_ASPEED_VUART] = {
>> +		.name		= "ASPEED VUART",
>> +		.fifo_size	= 16,
>> +		.tx_loadsz	= 16,
>> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
>> +		.rxtrig_bytes	= {1, 4, 8, 14},
>> +		.flags		= UART_CAP_FIFO,
>> +	},
>
>This is quite similar to AR7 type. Can that be (re-)used?
>

I suppose that could work if there's a strong preference for it, but I'd 
sort of prefer to keep it as a separate entry if that's alright.

Firstly, I haven't yet heard back from ASPEED confirming the nature of 
the underlying problem, so it seems entirely possible we'll end up 
wanting to tweak it further if they can suggest a better workaround, and 
I believe having rxtrig_bytes defined (which AR7 doesn't) enables 
adjusting the trigger-level FCR bits from userspace via sysfs, which 
could be useful for experiments relating to that.

Secondly, there are a half-dozen or so other existing entries in the 
uart_config[] array that differ only in name, so it doesn't seem to be 
something that's generally been deemed worth optimizing thus far, and 
now that the constant value has been shifted down it's just filling in a 
previously-empty slot in the array instead of expanding it further.

But mostly it strikes me as a bit...gratuitously confusing to label the 
port as something it ultimately isn't, even if they're functionally 
"close enough" (calling it an 8250 or 16550A is a bit different, as 
those are well-established, widely-emulated ones that have become 
generic nomenclature, which isn't so much the case for AR7).  While in 
the source code it could be explained with a comment, having 
/proc/tty/driver/serial (and wherever else that name might end up) 
referencing a totally unrelated MIPS SoC just seems kind of weird to me.


Zev

