Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12364CB76B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiCCHGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiCCHGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:06:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736A55E157;
        Wed,  2 Mar 2022 23:06:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EEA61F37E;
        Thu,  3 Mar 2022 07:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646291162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YP2M04W2O17IP9XPUCtCo3XVP+VCvTcwNEwKuTXddlo=;
        b=LpFjZViUovJ/t+ZtAdjERkkIsMchlvCBmyjZlXMeqFjjbPU7KqMi8aWRto63OLyYzh0QFO
        6SMi1TdhKGZBvigqediLBxpp+cf7V9VelaPP0Xs5JCNhTaonHZZP8Y6fU2rLn1gJUX37GH
        jk6pmIdvWXgbIpdV+k52C81gD9ACx/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646291162;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YP2M04W2O17IP9XPUCtCo3XVP+VCvTcwNEwKuTXddlo=;
        b=ccgI+Th04diEqYxHCda5BSdWk1vNZ9E0ycq5lYRncqSIx2IzaE3UmoLx+nuQkf01Fl4UQF
        XiAnUvYPmSHdm6Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A77A513AB4;
        Thu,  3 Mar 2022 07:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VwjXJ9hoIGKKLgAAMHmgww
        (envelope-from <jslaby@suse.cz>); Thu, 03 Mar 2022 07:06:00 +0000
Message-ID: <84ad3854-28b9-e450-f0a2-f1448f32f137@suse.cz>
Date:   Thu, 3 Mar 2022 08:06:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3] serial: make uart_console_write->putchar()'s character
 an unsigned char
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        =?UTF-8?Q?=27Uwe_Kleine-K=c3=b6nig=27?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabio Estevam <festevam@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Andy Gross <agross@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Takao Orito <orito.takao@socionext.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20220302072732.1916-1-jslaby@suse.cz>
 <20220302175242.ejiaf36vszr4xvou@pengutronix.de>
 <5c7045c1910143e08ced432d938b5825@AcuMS.aculab.com>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <5c7045c1910143e08ced432d938b5825@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 03. 22, 0:57, David Laight wrote:
> From: Uwe Kleine-König
>> Sent: 02 March 2022 17:53
>>
>> On Wed, Mar 02, 2022 at 08:27:32AM +0100, Jiri Slaby wrote:
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
>>
>> I always thought this was bigger than 8bit for hardware that supports
>> wider characters. But if that's the case that's completely unsupported,
>> there isn't even CS9.
> 
> The real problem is that using char (or short) for a function parameter
> or result is very likely to require the compile add code to mask
> the value to 8 (or 16) bits.
> 
> Remember that almost every time you do anything with a signed or unsigned
> char/short variable the compiler has to use the integer promotion rules
> to convert the value to int.
> 
> You'll almost certainly get better code if the value is left in an
> int (or unsigned int) variable until the low 8 bits get written to
> a buffer (or hardware register).

So should we use int/uint instead of more appropriate shorter types 
everywhere now? The answer is: definitely not. The assembly on x86 looks 
good (it uses movz, no ands), RISC architectures have to do what they 
chose to.

Note the patch unifies the type with preexistent uchar use in the whole 
uart layer. I.e. before the patch, char was upcast to int, and later, it 
was downcast to u8 again when talking to HW.

thanks,
-- 
js
suse labs
