Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5312564E07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiGDG4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGDG4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:56:09 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE70D2DE3;
        Sun,  3 Jul 2022 23:56:07 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id ay16so15023518ejb.6;
        Sun, 03 Jul 2022 23:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=sLZxcn/mwX9NSWhtBrUUwKBfPIOzguHlMVriisP3s50=;
        b=TZ+YeaivxyquGpUj9WAT5oZJzBe9q7qqSEvCh9sRVq6Ise13FvGMicVNaSSDKcYy2W
         5m9dXWM5yDagZYNYL2ZBOHBLBzd+FA/pFC19HLwzO6yQYliFhAJ4INpET7f+nvDzCCVp
         xCdpT3y+sUDwPQguyVbNzffIvbVZsCJoNU7MGlmBUWDFSM05TvxTkBwTAIfSME1JbY0E
         0rlkl1X4KIg6ybbLllhGNhEFSoWpL+gca4RxN/S3Uh66ylnwpj7R8hOmvgCtTxnW5mc/
         bhyAyjnWJ3wb/OqDN09qfguzOFsp+lK+D7v/3nQ84tyiLJ63wqTpYRlcVizGB955BxGO
         N+8w==
X-Gm-Message-State: AJIora9+LaWoaBDXDyqlY6+Qt/JYlrYVPJWA7cmDtARcGDyMsEcFUqzm
        MBF4ZEzr5VYzq2Y8/vgSoXo=
X-Google-Smtp-Source: AGRyM1uwNoj8eGbBYscqhKNT3kl/EICy8stzzbFwhI67Gi9CQ9Ux4HU0BLwYn9CX17sMulpmdbgQ5w==
X-Received: by 2002:a17:907:6d86:b0:726:99d7:20e4 with SMTP id sb6-20020a1709076d8600b0072699d720e4mr27177070ejc.342.1656917766291;
        Sun, 03 Jul 2022 23:56:06 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id w14-20020a056402128e00b004356894a3f8sm20136747edv.89.2022.07.03.23.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 23:56:05 -0700 (PDT)
Message-ID: <06e40c1c-d8e3-b1c1-276a-e32e579371b8@kernel.org>
Date:   Mon, 4 Jul 2022 08:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 4/6] serial: take termios_rwsem for ->rs485_config() &
 pass termios as param
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
References: <20220624204210.11112-1-ilpo.jarvinen@linux.intel.com>
 <20220624204210.11112-5-ilpo.jarvinen@linux.intel.com>
 <60678c81-27bf-6f37-bae5-ccc91d714204@kernel.org>
In-Reply-To: <60678c81-27bf-6f37-bae5-ccc91d714204@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 07. 22, 8:51, Jiri Slaby wrote:
> Anyway, I'm not sure I buy the above. Why is termios_rwsem needed to 
> alter ADDRB?

Nevermind, reading patch 5/6 gives a clue.

-- 
js
suse labs
