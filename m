Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4B44CB81D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiCCHue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiCCHub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:50:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EE0DD94B;
        Wed,  2 Mar 2022 23:49:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB6801F383;
        Thu,  3 Mar 2022 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646293785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXHHa8eiFVvmtGHsT8guaAe6cSZd25ewtaiyJj7lKDY=;
        b=A1l780980pmpbWz22urysX9J97xlrUbXHHTY7+T75LqTr0SL6NqlWVA8CFtiWmH/rHdcJW
        /OjPG2I+et1BeE/YbsNiCcHwbrnp0zjzA1PnYI5E1DnTOZ9MzR+p4dOrrxqEV/3DlI1fqh
        a3Sl0mr2C0MyYqFDF/OiwsxMSHiuMC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646293785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXHHa8eiFVvmtGHsT8guaAe6cSZd25ewtaiyJj7lKDY=;
        b=F4bG/y/XyeO28RAqRFqMNQtKom0hnO+8V/AeyaUcpka38+nnnPyzSBwl/8WDQeTDdfMTmT
        VFJW09AEE3ax2cAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4018132C1;
        Thu,  3 Mar 2022 07:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bvjFLhhzIGKDPQAAMHmgww
        (envelope-from <jslaby@suse.cz>); Thu, 03 Mar 2022 07:49:44 +0000
Message-ID: <0ed348d2-a3dd-22a1-0773-83369c35794e@suse.cz>
Date:   Thu, 3 Mar 2022 08:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3] serial: make uart_console_write->putchar()'s character
 an unsigned char
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Paul Cercueil <paul@crapouillou.net>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <peter@korsgaard.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220302072732.1916-1-jslaby@suse.cz>
 <1be133eb-bfe8-b644-6aad-00a0a606aa05@suse.cz> <YiByDgvP3epfDfhX@kroah.com>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <YiByDgvP3epfDfhX@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 03. 22, 8:45, Greg KH wrote:
> On Thu, Mar 03, 2022 at 07:32:59AM +0100, Jiri Slaby wrote:
>> On 02. 03. 22, 8:27, Jiri Slaby wrote:
>>> Currently, uart_console_write->putchar's second parameter (the
>>> character) is of type int. It makes little sense, provided uart_console_write()
>>> accepts the input string as "const char *s" and passes its content -- the
>>> characters -- to putchar(). So switch the character's type to unsigned
>>> char.
>>>
>>> We don't use char as that is signed on some platforms. That would cause
>>> troubles for drivers which (implicitly) cast the char to u16 when
>>> writing to the device. Sign extension would happen in that case and the
>>> value written would be completely different to the provided char. DZ is
>>> an example of such a driver -- on MIPS, it uses u16 for dz_out in
>>> dz_console_putchar().
>>>
>>> Note we do the char -> uchar conversion implicitly in
>>> uart_console_write(). Provided we do not change size of the data type,
>>> sign extension does not happen there, so the problem is void.
>>>
>>> This makes the types consistent and unified with the rest of the uart
>>> layer, which uses unsigned char in most places already. One exception is
>>> xmit_buf, but that is going to be converted later.
>>
>> Kbuild seems to serve me this one by one. So this patch is still incomplete:
>>> drivers/tty/serial/sunplus-uart.c:526:7: error: incompatible function
>> pointer types passing 'void (struct uart_port *, int)' to parameter of type
>> 'void (*)(struct uart_port *, unsigned char)'
> 
> Let me just add this to my -testing branch, that will give us much
> quicker kbuild responses and handle stuff like this easier and I can fix
> the errors up when they are reported.

Note this was missed as this driver was added only few days ago, so it 
was not covered by kbuild against my tree until then. And to me, it 
looks like kbuild is run on my tree only when it has nothing better to 
do (which is perfectly fine, as even that catches a lot of things).

Besides that, there are two places in the driver which need update.

So should I send a v4 or wait?

thanks,
-- 
js
suse labs
