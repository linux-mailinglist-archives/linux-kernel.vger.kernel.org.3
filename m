Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FC950265D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351198AbiDOHuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiDOHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:49:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA3499EC5;
        Fri, 15 Apr 2022 00:47:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D70B321618;
        Fri, 15 Apr 2022 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650008846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQD0Ms26XUsvrFHAFoIYCO3UB2GzxcBPOeHxgYmh/ig=;
        b=nOLxROqroN3gLa1Fds6VhHXY09DM1gd+sLd/2H7ALUiZUw3tE0P8r98hvtX5AdIFAF0qzh
        bOMCW5/C/LnyU32NpbQ18cM8wMCtMr31hjhzpWgJMMaaPsaKLjoCr7qZd32CZxmMvJgqV6
        1IWgU2BEfOEgBziR4pYS9dmmjQ3VljI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650008846;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQD0Ms26XUsvrFHAFoIYCO3UB2GzxcBPOeHxgYmh/ig=;
        b=Wjaim/t9ELK0OY9vS0C2GioSo/Fc2a2lwyNVliYiB9lcu6BQkrZRnimove2ZYiuk2Po8Yk
        S++JQtCN5psjXVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A869A139B3;
        Fri, 15 Apr 2022 07:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7p4eJw4jWWLbCwAAMHmgww
        (envelope-from <jslaby@suse.cz>); Fri, 15 Apr 2022 07:47:26 +0000
Message-ID: <d8d4236e-3b76-1dde-e952-76a64c906c85@suse.cz>
Date:   Fri, 15 Apr 2022 09:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] tty: serial: introduce uart_port_tx{,_limit}()
 helpers
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220411105405.9519-1-jslaby@suse.cz>
 <20220411105405.9519-2-jslaby@suse.cz> <YlhMhy9FhK0j3MId@kroah.com>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <YlhMhy9FhK0j3MId@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 04. 22, 18:32, Greg KH wrote:
> On Mon, Apr 11, 2022 at 12:54:03PM +0200, Jiri Slaby wrote:
>> Many serial drivers do the same thing:
>> * send x_char if set
>> * keep sending from the xmit circular buffer until either
>>    - the loop reaches the end of the xmit buffer
>>    - TX is stopped
>>    - HW fifo is full
>> * check for pending characters and:
>>    - wake up tty writers to fill for more data into xmit buffer
>>    - stop TX if there is nothing in the xmit buffer
>>
>> The only differences are:
>> * how to write the character to the HW fifo
>> * the check of the end condition:
>>    - is the HW fifo full?
>>    - is limit of the written characters reached?
>>
>> So unify the above into two helpers:
>> * uart_port_tx_limit() -- the generic one, it performs the above taking
>>    into account the written characters limit
>> * uart_port_tx() -- calls the above with ~0 as the limit. So it only
>>    checks the HW fullness.
>>
>> We need three more hooks in struct uart_ops for all this to work:
>> * tx_ready() -- returns true if HW can accept more data.
>> * put_char() -- write a character to the device.
>> * tx_done() -- when the write loop is done, perform arbitrary action
>>    before potential invocation of ops->stop_tx() happens.
>>
>> NOTE1: Maybe the three hooks in uart_ops above are overkill. We can
>> instead pass pointers to the three functions directly to the new helpers
>> as they are not used elsewhere. Similar to uart_console_write() and its
>> putchar().
>>
>> NOTE2: These two new helper functions call the hooks per every character
>> processed. I was unable to measure any difference, provided most time is
>> spent by readb (or alike) in the hooks themselves.  First, LTO might
>> help to eliminate these explicit calls (we might need NOTE1 to be
>> implemented for this to be true). Second, if this turns out to be a
>> problem, we can introduce a macro to build the helper in the driver's
>> code instead of serial_core. That is, similar to wait_event().
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>   Documentation/driver-api/serial/driver.rst | 28 ++++++++++++
>>   drivers/tty/serial/serial_core.c           | 53 ++++++++++++++++++++++
>>   include/linux/serial_core.h                |  9 ++++
>>   3 files changed, 90 insertions(+)
>>
>> diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
>> index 06ec04ba086f..7dc3791addeb 100644
>> --- a/Documentation/driver-api/serial/driver.rst
>> +++ b/Documentation/driver-api/serial/driver.rst
>> @@ -80,6 +80,34 @@ hardware.
>>   
>>   	This call must not sleep
>>   
>> +  tx_ready(port)
>> +	The driver returns true if the HW can accept more data to be sent.
>> +
>> +	Locking: port->lock taken.
>> +
>> +	Interrupts: locally disabled.
>> +
>> +	This call must not sleep.
>> +
>> +  put_char(port, ch)
>> +	The driver is asked to write ch to the device.
>> +
>> +	Locking: port->lock taken.
>> +
>> +	Interrupts: locally disabled.
>> +
>> +	This call must not sleep.
>> +
>> +  tx_done(port)
>> +	When the write loop is done, the driver can perform arbitrary action
>> +	here before potential invocation of ops->stop_tx() happens.
>> +
>> +	Locking: port->lock taken.
>> +
>> +	Interrupts: locally disabled.
>> +
>> +	This call must not sleep.
>> +
>>     set_mctrl(port, mctrl)
>>   	This function sets the modem control lines for port described
>>   	by 'port' to the state described by mctrl.  The relevant bits
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 6a8963caf954..1be14e90066c 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -107,6 +107,59 @@ void uart_write_wakeup(struct uart_port *port)
>>   }
>>   EXPORT_SYMBOL(uart_write_wakeup);
>>   
>> +static bool uart_port_tx_always_ready(struct uart_port *port)
>> +{
>> +	return true;
>> +}
>> +
>> +/**
>> + * uart_port_tx_limit -- transmit helper for uart_port
>> + * @port: from which port to transmit
>> + * @count: limit count
>> + *
>> + * uart_port_tx_limit() transmits characters from the xmit buffer to the
>> + * hardware using @uart_port::ops::put_char(). It does so until @count
>> + * characters are sent and while @uart_port::ops::tx_ready() still returns
>> + * non-zero (if non-NULL).
>> + *
>> + * Return: number of characters in the xmit buffer when done.
>> + */
>> +unsigned int uart_port_tx_limit(struct uart_port *port, unsigned int count)
>> +{
>> +	struct circ_buf *xmit = &port->state->xmit;
>> +	bool (*tx_ready)(struct uart_port *) = port->ops->tx_ready ? :
>> +		uart_port_tx_always_ready;
>> +	unsigned int pending;
>> +
>> +	for (; count && tx_ready(port); count--, port->icount.tx++) {
>> +		if (port->x_char) {
>> +			port->ops->put_char(port, port->x_char);
>> +			port->x_char = 0;
>> +			continue;
>> +		}
>> +
>> +		if (uart_circ_empty(xmit) || uart_tx_stopped(port))
>> +			break;
>> +
>> +		port->ops->put_char(port, xmit->buf[xmit->tail]);
> 
> That's a lot of redirection and function pointer mess per each character
> sent now.  With the spectre overhead here (and only getting worse), this
> feels like a step backwards.
> 
> I doubt throughput matters here given cpu speeds now, _but_ the cpu load
> should go up.
> 
> Although on smaller cpus with slower Mhz and faster line rates, this
> feels like a lot of extra work happening for no real good reason.

I know… Did you miss NOTE2 in the commit log? Any idea on that?

thanks,
-- 
js
suse labs
