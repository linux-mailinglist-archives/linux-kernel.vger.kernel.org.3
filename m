Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57285564DFC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiGDGv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGDGv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:51:57 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C151A1;
        Sun,  3 Jul 2022 23:51:56 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id d2so15054568ejy.1;
        Sun, 03 Jul 2022 23:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V3WLzRQE5hlj9Ag2r0vYMFsjKsgZON5RNX5KPeYiXww=;
        b=INexnmujA72hd1cSfEjJYi3EV6fpTDEUwkgIi6uIKB1St+EjgHcYc7RW5IM7bD6jyD
         uMB3fKl8wb41IHpcfhw4RC7aLboZ88PVtB0jt2IG2UfhV5eACroeHWvXzGVWxgyPWc3j
         /OWE2e8VG3cNmM+FDEvBcqTM1iHBrjFbywUPX6/mL2nvNQzYoRNbS4FOFfi3dp8d9sHf
         XuDXqMDzvOc1KjM3gJc7PyhFwvnOHasVnDc7mbF3O3XV/qbg/B1k62Yisa0kDqP9J52T
         /QTYjf9Q3H1E4138ac1yLuyY+wA10WmQ/RAEMiHQ9tGnJgnpVse56XCLxMjhsTSZnkb0
         il4w==
X-Gm-Message-State: AJIora+TLmBlC85CkcbaIpMzCp2o4sczhnwP5AIwyrpl/+3/O1ZGsrCg
        DA5kzOZA0u2UNLBcrwqCITw=
X-Google-Smtp-Source: AGRyM1v8dChAQI8X41cjbxblEKGrrl0gDwkuRmFOZKgWiz0FHKJWfFar01jZsrywV4UoVL2Tkx3+Ww==
X-Received: by 2002:a17:906:8315:b0:726:38da:f0f with SMTP id j21-20020a170906831500b0072638da0f0fmr27302882ejx.462.1656917514750;
        Sun, 03 Jul 2022 23:51:54 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id q16-20020a056402249000b00438a13508c4sm8472754eda.51.2022.07.03.23.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 23:51:54 -0700 (PDT)
Message-ID: <60678c81-27bf-6f37-bae5-ccc91d714204@kernel.org>
Date:   Mon, 4 Jul 2022 08:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 4/6] serial: take termios_rwsem for ->rs485_config() &
 pass termios as param
Content-Language: en-US
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
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220624204210.11112-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 06. 22, 22:42, Ilpo Järvinen wrote:
> To be able to alter ADDRB within ->rs485_config(), take termios_rwsem
> before calling ->rs485_config() and pass termios.

OK, FTR, worth noting the tty->termios_rwsem -> port->mutex lock chain 
is preexisting.

Anyway, I'm not sure I buy the above. Why is termios_rwsem needed to 
alter ADDRB?

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 621fc15e2e54..44c3785445e3 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
...
> @@ -1511,6 +1511,10 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>   	if (ret != -ENOIOCTLCMD)
>   		goto out;
>   
> +	/* rs485_config requires more locking than others */
> +	if (cmd == TIOCGRS485)
> +		down_write(&tty->termios_rwsem);
> +
>   	mutex_lock(&port->mutex);
>   	uport = uart_port_check(state);
>   
...
> @@ -1551,6 +1555,8 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>   	}
>   out_up:
>   	mutex_unlock(&port->mutex);
> +	if (cmd == TIOCGRS485)
> +		up_write(&tty->termios_rwsem);
>   out:
>   	return ret;
>   }

thanks,
-- 
js
