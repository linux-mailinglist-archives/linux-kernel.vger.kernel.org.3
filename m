Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B87F5A5D99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiH3ICO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiH3ICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:02:05 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C9D25FD;
        Tue, 30 Aug 2022 01:02:03 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id se27so12744264ejb.8;
        Tue, 30 Aug 2022 01:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ydfrnuw+55leI10v9SJBVImy0rWUjcTdkZR1kZGXwFw=;
        b=sCZHtuEJbBNTCPPXnFKl1I/vDNoEd4x6jEQ/dfUciIobmxcR/mka6M4ftEPzmZkT6h
         DPpIUmDGkn6nRWj3T/vmNKaH1F59vdUmDKFczzUqZ43ZBsoJ6VCd/TDz9pDI9YDjAhrO
         fW2bCiW5nNrZAUAFXTIaZdb5UW2FoKClEBBBaYYOJbfCvz1iwKuU3wdQx7QpnBhuB2qP
         O6kNEELllG4+3XxhKvOls6EUXKAp29KTOfm3CJ8STllBKTkMeHbPgfD4zN56GxA4J7Lt
         /i02ys49bs8iWtcf2NJhpAn/zVJ8L4SwlxYvISf1pW9qzoYDA5WOaUXj63D/mBca/+I2
         L+vw==
X-Gm-Message-State: ACgBeo2zHnlL5tdbvH9rR7q6RMlFhyNV7G1mndAhxx1QAPBT+cWUsC+R
        8mKRm2t183oQdAvEECrEEVo=
X-Google-Smtp-Source: AA6agR5gDrSS4cPDXB6O0pPRBT0lOuKdfVV/ExsAVlNsE2XddNhK40qAq02POdSU0t1LhaH7OI+8WQ==
X-Received: by 2002:a17:906:ee89:b0:73d:70c5:1a4e with SMTP id wt9-20020a170906ee8900b0073d70c51a4emr15397045ejb.683.1661846522007;
        Tue, 30 Aug 2022 01:02:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h3-20020a056402094300b00445e037345csm6832470edz.14.2022.08.30.01.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 01:02:01 -0700 (PDT)
Message-ID: <1068ad37-d80c-6e63-6cd9-6ecf6c256d46@kernel.org>
Date:   Tue, 30 Aug 2022 10:01:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 4/4] serial: Add kserial_rs485 to avoid wasted space
 due to .padding
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
References: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com>
 <20220830072956.3630-5-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220830072956.3630-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 30. 08. 22, 9:29, Ilpo Järvinen wrote:
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -31,6 +31,29 @@ struct serial_struct;
...
> + * Must match with struct serial_rs485 in include/uapi/linux/serial.h excluding
> + * the padding.

Have you considered BUILD_BUG_ON() checks with few offset_of()s to 
enforce the above?

> +struct kserial_rs485 {
> +	__u32	flags;
> +	__u32	delay_rts_before_send;
> +	__u32	delay_rts_after_send;
> +	struct {
> +		__u8    addr_recv;
> +		__u8    addr_dest;
> +	};
> +};

thanks,
-- 
js
suse labs

