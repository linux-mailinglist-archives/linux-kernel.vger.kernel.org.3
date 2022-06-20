Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3F5521E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiFTQKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiFTQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:10:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D801C133;
        Mon, 20 Jun 2022 09:10:02 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e63so9176820pgc.5;
        Mon, 20 Jun 2022 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rBIAlvyACCv4oqM4b14a4QBXNbvV1T1iHe8svEuiAAw=;
        b=QMrWZIVTHTH9oYFZYWYSKbYr9x/YdYUZyN9p/qHWdHsNEKqpFwIrIo49F/9vNEBqAq
         9g+bIVMa/rGGpt/ng70XZ1t2pXOPNqqso8xYfMQYiJ7rHiC+pmOOkJJuNbh3yo4ADS3Y
         SDzlNIi4OHFBV3cfwdIYefp7d87WCKEYgjMXUWmwCXNfyGitwo4/9qoAXpF3EC61gbA1
         WNtY4KCRFGPcGCC23UK5RHcMgaDmySA2n5cXuwyDVjSbBIqWdX0DqL5RxZEcm+uJE40c
         QUgHNMWa03iewa9ZZcFM1XVPJuUfC+WvF2INGLRVcw5/wr4LQ7GKLDq66m2yDye/jhkB
         ku6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rBIAlvyACCv4oqM4b14a4QBXNbvV1T1iHe8svEuiAAw=;
        b=f0k4TbfR5Vrtkuk4hwsJQTuklpJtZCl33l6MBr7B6u6zk23buSPGiJ5dycdC6Jr2dd
         KRp7vUjZransfypnoCxqynHpRYJoOyH0qijrT03CB6y2B6/ebqV9w9AJtvsk9MmoBY1u
         H9tAWRI7TsWlsijcF8ZSgModJPWM4MxEX+PKd5Fc1SrZNZ7Jw9YRxZXZxeQ8miAuyXDY
         naGt6afPpgBG27QMy7snxbNhqinI3uVb9iPUXecglsJ+OE4Ze9gpfxiOLpMxO8LF7Geh
         V2Jcl0/XMtXHJtBkn3KQmimdhS9Giq3twLF8rL1rOMZVWG8byFlRqbPMzBPhBO88fmjh
         DnVA==
X-Gm-Message-State: AJIora85IE7LSululGrzERkS5Lo0MFGtGrguwh5u5v5Jb7yVcP3ge6++
        4MlSTlXXBtdiF11/U6S3/UA=
X-Google-Smtp-Source: AGRyM1tz9KzTVukoZW4ey4gS7ooBo6YPROyVpJ+1IZn9Q2owoPdqnsWoNM8WPAGKn2JBxG9Qd8yZJA==
X-Received: by 2002:a05:6a00:430e:b0:525:26c1:973e with SMTP id cb14-20020a056a00430e00b0052526c1973emr4489658pfb.52.1655741402397;
        Mon, 20 Jun 2022 09:10:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903120200b00168c523032fsm8913363plh.269.2022.06.20.09.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 09:10:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2280dc86-92eb-57b5-e67c-78731a9660f4@roeck-us.net>
Date:   Mon, 20 Jun 2022 09:09:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v10 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Content-Language: en-US
To:     Xin Ji <xji@analogixsemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220613095957.1669829-1-xji@analogixsemi.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220613095957.1669829-1-xji@analogixsemi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 02:59, Xin Ji wrote:
> USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> and a port controller (TCPC) - may require that the driver for the PD
> controller accesses directly also the on-chip port controller in some cases.
> 
> Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> V9 -> V10: Rebase on the latest code
> V8 -> V9 : Add more commit message
> V7 -> V8 : Fix Guanter's comment, remove unnecessary explain
> ---
>   drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
>   drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
>   drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
>   drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
>   {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
>   5 files changed, 5 insertions(+), 7 deletions(-)
>   rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index f33e08eb7670..812784702d53 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -13,11 +13,10 @@
>   #include <linux/property.h>
>   #include <linux/regmap.h>
>   #include <linux/usb/pd.h>
> +#include <linux/usb/tcpci.h>
>   #include <linux/usb/tcpm.h>
>   #include <linux/usb/typec.h>
>   
> -#include "tcpci.h"
> -
>   #define	PD_RETRY_COUNT_DEFAULT			3
>   #define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
>   #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index df2505570f07..4b6705f3d7b7 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -11,11 +11,10 @@
>   #include <linux/module.h>
>   #include <linux/regmap.h>
>   #include <linux/usb/pd.h>
> +#include <linux/usb/tcpci.h>
>   #include <linux/usb/tcpm.h>
>   #include <linux/usb/typec.h>
>   
> -#include "tcpci.h"
> -
>   #define PD_ACTIVITY_TIMEOUT_MS				10000
>   
>   #define TCPC_VENDOR_ALERT				0x80
> diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> index 8a952eaf9016..1b7c31278ebb 100644
> --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> @@ -11,10 +11,9 @@
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
> +#include <linux/usb/tcpci.h>
>   #include <linux/usb/tcpm.h>
>   
> -#include "tcpci.h"
> -
>   #define MT6360_REG_PHYCTRL1	0x80
>   #define MT6360_REG_PHYCTRL3	0x82
>   #define MT6360_REG_PHYCTRL7	0x86
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index b56a0880a044..3291ca4948da 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -10,9 +10,9 @@
>   #include <linux/i2c.h>
>   #include <linux/interrupt.h>
>   #include <linux/gpio/consumer.h>
> +#include <linux/usb/tcpci.h>
>   #include <linux/usb/tcpm.h>
>   #include <linux/regmap.h>
> -#include "tcpci.h"
>   
>   #define RT1711H_VID		0x29CF
>   #define RT1711H_PID		0x1711
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/include/linux/usb/tcpci.h
> similarity index 99%
> rename from drivers/usb/typec/tcpm/tcpci.h
> rename to include/linux/usb/tcpci.h
> index b2edd45f13c6..20c0bedb8ec8 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -9,6 +9,7 @@
>   #define __LINUX_USB_TCPCI_H
>   
>   #include <linux/usb/typec.h>
> +#include <linux/usb/tcpm.h>
>   
>   #define TCPC_VENDOR_ID			0x0
>   #define TCPC_PRODUCT_ID			0x2

