Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CD94CBCD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiCCLhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiCCLg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:36:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B8B4B840;
        Thu,  3 Mar 2022 03:36:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6434D218E6;
        Thu,  3 Mar 2022 11:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646307360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDiQKJrDpIO7+2X0qZBOWb0f8AHNA+AoPBY4gI4/LKk=;
        b=cTmRBz8F83E1yHKbJThlcDmx0Lhn1CoJRik6ZO46mItJ1F5211m4z4XagQoi77clhsZ/2s
        19gDh0lYUziEm1ws5oWGZtcDbixOaAYNtzHlpJZ7pofO44JLPEev1jkNPVmJ3JxCc6dVxf
        wSlPR9WgwPVswQXZS5n/Pogpec3NxRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646307360;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDiQKJrDpIO7+2X0qZBOWb0f8AHNA+AoPBY4gI4/LKk=;
        b=AkhkNvd5C2h4CZs/sf+t+jQr9jypWdfbeSbPkPQLh7oD4tOmAFR1GgkQk4UPjn/mjVm0I7
        7uF6GmQZdb3BmKCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4566813AB4;
        Thu,  3 Mar 2022 11:35:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NFGoDx+oIGLmJAAAMHmgww
        (envelope-from <jslaby@suse.cz>); Thu, 03 Mar 2022 11:35:59 +0000
Message-ID: <67a0df7a-aa19-e323-3af5-00fda7e7dd62@suse.cz>
Date:   Thu, 3 Mar 2022 12:35:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3] serial: make uart_console_write->putchar()'s character
 an unsigned char
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        =?UTF-8?Q?=27Uwe_Kleine-K=c3=b6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, gregkh@linuxfoundation.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Baruch Siach <baruch@tkos.co.il>, linux-kernel@vger.kernel.org,
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
        bcm-kernel-feedback-list@broadcom.com,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
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
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
References: <20220302072732.1916-1-jslaby@suse.cz>
 <20220302175242.ejiaf36vszr4xvou@pengutronix.de>
 <5c7045c1910143e08ced432d938b5825@AcuMS.aculab.com>
 <84ad3854-28b9-e450-f0a2-f1448f32f137@suse.cz>
 <alpine.DEB.2.21.2203030738170.56670@angie.orcam.me.uk>
 <BIZ58R.9EXA9J3HVHS13@crapouillou.net>
 <alpine.DEB.2.21.2203031102570.50870@angie.orcam.me.uk>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <alpine.DEB.2.21.2203031102570.50870@angie.orcam.me.uk>
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

On 03. 03. 22, 12:30, Maciej W. Rozycki wrote:
>   It does, but, oh dear, it's a "solution" to a problem we have created in
> the first place.  Why do we ever want to have signed characters in the TTY
> layer,

We don't. We use char, which is signed or unsigned, depending on arch. 
After all, this is text coming from printk layer, i.e. char * by 
convention coming from the standard.

thanks,
-- 
js
suse labs
