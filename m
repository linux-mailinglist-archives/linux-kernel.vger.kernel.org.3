Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CA15AE5F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbiIFKxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiIFKwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:52:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD4E7C74F;
        Tue,  6 Sep 2022 03:50:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A324733B3F;
        Tue,  6 Sep 2022 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662461451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xDqAYOny8a4GZp9lQU20DqwzzLF8VePC5H3lgg4Lr0c=;
        b=hpYnwzXtwNmctKmpwUxO/1Vi96rDc8ufxofx8B5JZh5Q6B457yiyEcnmM+HYK/wgUqb6Ch
        OcllPU4Vh/r7YgcLJ/gGuaOvh5YXyE7KNMls0LdkXAJ5l66+9zkMkit2VQrNtIsROED5cw
        du4V++AH2tf06dNPht1c2Pv0jzE3w18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662461451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xDqAYOny8a4GZp9lQU20DqwzzLF8VePC5H3lgg4Lr0c=;
        b=2cuduUF22x8Q5pj0EfXxp62FaSpwasgZKMy2Kfu8N7QlCz/dfPL+4tj4R+TXcJCnL5BmQZ
        +On4r66BSXUOiPDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11D5A13A19;
        Tue,  6 Sep 2022 10:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UB3GAgsmF2NeFAAAMHmgww
        (envelope-from <jslaby@suse.cz>); Tue, 06 Sep 2022 10:50:51 +0000
Message-ID: <2130ad22-bf5d-f5df-e51a-12632055ab3c@suse.cz>
Date:   Tue, 6 Sep 2022 12:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/3] tty: serial: use DEFINE_UART_PORT_TX_HELPER()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20220901110657.3305-1-jslaby@suse.cz>
 <20220901110657.3305-3-jslaby@suse.cz>
 <89b44cd-6550-32b2-9bd-ae8dde6b48cd@linux.intel.com>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <89b44cd-6550-32b2-9bd-ae8dde6b48cd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 09. 22, 16:21, Ilpo Järvinen wrote:
>> --- a/drivers/tty/serial/sa1100.c
>> +++ b/drivers/tty/serial/sa1100.c
>> @@ -226,45 +226,34 @@ sa1100_rx_chars(struct sa1100_port *sport)
>>   	tty_flip_buffer_push(&sport->port.state->port);
>>   }
>>   
>> -static void sa1100_tx_chars(struct sa1100_port *sport)
>> +static bool sa1100_tx_ready(struct uart_port *port)
>>   {
>> -	struct circ_buf *xmit = &sport->port.state->xmit;
>> +	struct sa1100_port *sport =
>> +		container_of(port, struct sa1100_port, port);
>>   
>> -	if (sport->port.x_char) {
>> -		UART_PUT_CHAR(sport, sport->port.x_char);
>> -		sport->port.icount.tx++;
>> -		sport->port.x_char = 0;
>> -		return;
>> -	}
>> +	return UART_GET_UTSR1(sport) & UTSR1_TNF;
>> +}
>> +
>> +static void sa1100_put_char(struct uart_port *port, unsigned char ch)
>> +{
>> +	struct sa1100_port *sport =
>> +		container_of(port, struct sa1100_port, port);
>> +
>> +	UART_PUT_CHAR(sport, ch);
>> +}
> 
> Perhaps not to add into this change itself, but I just point out these
> would be useful in addition to what is changed:
> 	- Get rid of UART_PUT_CHAR()

Right, that would make the above easier.

> 	- sa1100_console_putchar() could use sa1100_tx_ready()
That could be a nice cleanup. But looking at the history, I am not sure 
anyone cares enough about the driver (and cleaning it up :P). And I'm 
not much into it.

I've just sent v3 including your comments addressed.

thanks,
-- 
js
suse labs

