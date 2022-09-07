Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070575AFD46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIGHTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiIGHTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:19:34 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF53659B;
        Wed,  7 Sep 2022 00:19:31 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id e18so18347743edj.3;
        Wed, 07 Sep 2022 00:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eDvuVooWlYd/7ooTWAPT8QHm6WSx0ZyUhFCklwIvD6g=;
        b=x3zcoR5HYELubslUbVyJnx45vEkofm7KS3nlW15exj1s59CsNCGBEg2l7R6nX+thQP
         S4ehsEHff2wyaeH3ygSgnuTSTpncDzuJlgnawe1DSPZl8OtWxkffh+bzBEbb2yAXgMeL
         +Izwo7do5u9eCk3SGkwbK9TqFFBbAkPUEzHHenfdZXwjYBq7yRSeUkyQRdSoUbphE5D3
         SRixIV2GgneREWiUaYKUFfGdxHoC+k00yEwHSrnqA0csuFmFY6MUOxErB03UX309UgKh
         IJn3WSy3w6EeooIZzuAgoNnEV/5hTSK03fo9Ad4yxHkSD2EYajMqbbUM4bXvlsArkeAM
         oUjg==
X-Gm-Message-State: ACgBeo3vRNNzH0iV/nqnko+uNwUcfN+HriLnB9c2dTOubQvaOukPqQps
        kGKPWM6sUIa9yZA5QMbkA0s=
X-Google-Smtp-Source: AA6agR4b6OMs7NVyOZD3BsZ4zUiY75eVpvTNS6XTGEyiiqFaTR2tpXrKInonOeWWvimI/BEGP2wN9g==
X-Received: by 2002:a05:6402:190d:b0:447:ed22:4d0d with SMTP id e13-20020a056402190d00b00447ed224d0dmr1966781edz.309.1662535169471;
        Wed, 07 Sep 2022 00:19:29 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906318c00b0073923a68974sm7643700ejy.206.2022.09.07.00.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 00:19:28 -0700 (PDT)
Message-ID: <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
Date:   Wed, 7 Sep 2022 09:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 0/4] tty: TX helpers
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        Manivannan Sadhasivam <mani@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
References: <20220906104805.23211-1-jslaby@suse.cz>
 <Yxcvbk281f/vy4vb@hovoldconsulting.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <Yxcvbk281f/vy4vb@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 09. 22, 13:30, Johan Hovold wrote:
> On Tue, Sep 06, 2022 at 12:48:01PM +0200, Jiri Slaby wrote:
>> This series introduces DEFINE_UART_PORT_TX_HELPER +
>> DEFINE_UART_PORT_TX_HELPER_LIMITED TX helpers. See PATCH 2/4 for the
>> details. Comments welcome.
>>
>> Then it switches drivers to use them. First, to
>> DEFINE_UART_PORT_TX_HELPER() in 3/4 and then
>> DEFINE_UART_PORT_TX_HELPER_LIMITED() in 4/4.
>>
>> The diffstat of patches 3+4 is as follows:
>>   26 files changed, 191 insertions(+), 823 deletions(-)
>> which appears to be nice.
> 
> Not really. This is horrid. Quality can't be measured in LoC (only).
> 
> The resulting code is unreadable. And for no good reason.

IMO, it's much more readable than the original ~ 30 various (and buggy 
-- see Ilpo's fixes) copies of this code. Apart from that, it makes 
further rework much easier (I have switch to kfifo in my mind for example).

> [ And note that you're "saving" something like 20 lines per driver:

It's not about saving, it's about deduplicating and unifying.

> 	 12 files changed, 84 insertions(+), 349 deletions(-)
> ]
> 
> NAK

I'd love to come up with something nicer. That would be a function in 
serial-core calling hooks like I had [1] for example. But provided all 
those CPU workarounds/thunks, it'd be quite expensive to call two 
functions per character.

Or creating a static inline (having ± the macro content) and the hooks 
as parameters and hope for optimizations to eliminate thunks (also 
suggested in the past [1]).

[1] https://lore.kernel.org/all/20220411105405.9519-1-jslaby@suse.cz/

thanks,
-- 
js
suse labs

