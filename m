Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46AA56884E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiGFM3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiGFM3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:29:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C82252AE;
        Wed,  6 Jul 2022 05:29:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 128so14201985pfv.12;
        Wed, 06 Jul 2022 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hb++T+TqCvDDSG4SBCoSH1P7Ah+WnHjdFZYreo/Hfko=;
        b=BbLBe2M3A8AWYlkobJbHlvQGtkIi9eJ1fhKZi72SH5Q2ISxXT7FCisfhD8WM4lH4xn
         W0CMzEvgH43SmSf7IKjKCnmg/2Zng2dsdDfG0DO6WyudObcH2lWwXFZn438iwngDQTy9
         9lNAeMttwPLTSdmF32rO0PSm2NM7RttTK/QbVjE9AcaSXlFo/CwbSN7djMsEG32FDk9h
         YSj2jTqW4IDq6AxxSnDHYlwHdgI4WrUYVmVfTbq4JHR+k7uEkbAt5rIkYXFZSA32SsdC
         HFoTIk4jjeZsOxecJdOjOhupnXAp6o2zjzZnsywdRclt8yr/Fvg9yEPG+dn5ub7JJq6D
         KbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Hb++T+TqCvDDSG4SBCoSH1P7Ah+WnHjdFZYreo/Hfko=;
        b=hRNJquQKpeTCKZLo51JgLyfkfRKpuNyFFbOr73gqb6XvhiUuZi8C2Z7QGpOgJZYdti
         Oru7OLF6THIev3HNwLsq+KNmoH9gRVi5hyjeO/xE2LtDJn2m8jz+ObZ0c/6w22/TAant
         753pV3PkkZP9oiZccbZa19C1p1lwHSvyhnnn81+n+HtrBb7OrCgMXA0kng+16nv21/KZ
         jBqQc/TN7HthTz8n4wZfoIpiP25flaYuQYNm88r21VJdVQ9lujKn0nRdsiGdFM8IeA0B
         2cg4FH7bGVY7XlQJ2cyASK/pviTGaYs2s//ZICfBki53/xg3XSiE+bTFJ91m1kCsEZWI
         LlFA==
X-Gm-Message-State: AJIora/h728szld/aQ/DxXvAvUeaAb5qyrODr4unbgIEQk/dVptwmHnj
        Pj/p57uqTOU97+1TS9nEHt0=
X-Google-Smtp-Source: AGRyM1uoDB6L35OBcFGnbcqaTY9nnQDgNQnuXvTDk9jhj/6DUZ25v7WIWUrr9kdjfBQjynFmHIdieg==
X-Received: by 2002:a63:2b84:0:b0:412:5277:99dc with SMTP id r126-20020a632b84000000b00412527799dcmr12015920pgr.208.1657110581088;
        Wed, 06 Jul 2022 05:29:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r13-20020a63d90d000000b0041166bf9ca8sm15810700pgg.34.2022.07.06.05.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:29:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Jul 2022 05:29:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v13 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Message-ID: <20220706122937.GA492220@roeck-us.net>
References: <20220705053657.2340274-1-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705053657.2340274-1-xji@analogixsemi.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:36:54PM +0800, Xin Ji wrote:
> USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> and a port controller (TCPC) - may require that the driver for the PD
> controller accesses directly also the on-chip port controller in some cases.
> 
> Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> V9 -> V10: Rebase on the latest code
> V8 -> V9 : Add more commit message
> V7 -> V8 : Fix Guanter's comment, remove unnecessary explain
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
>  drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
>  drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
>  {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
>  5 files changed, 5 insertions(+), 7 deletions(-)
>  rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index f33e08eb7670..812784702d53 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -13,11 +13,10 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/usb/pd.h>
> +#include <linux/usb/tcpci.h>
>  #include <linux/usb/tcpm.h>
>  #include <linux/usb/typec.h>
>  
> -#include "tcpci.h"
> -
>  #define	PD_RETRY_COUNT_DEFAULT			3
>  #define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
>  #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index df2505570f07..4b6705f3d7b7 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -11,11 +11,10 @@
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/usb/pd.h>
> +#include <linux/usb/tcpci.h>
>  #include <linux/usb/tcpm.h>
>  #include <linux/usb/typec.h>
>  
> -#include "tcpci.h"
> -
>  #define PD_ACTIVITY_TIMEOUT_MS				10000
>  
>  #define TCPC_VENDOR_ALERT				0x80
> diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> index 8a952eaf9016..1b7c31278ebb 100644
> --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> @@ -11,10 +11,9 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/usb/tcpci.h>
>  #include <linux/usb/tcpm.h>
>  
> -#include "tcpci.h"
> -
>  #define MT6360_REG_PHYCTRL1	0x80
>  #define MT6360_REG_PHYCTRL3	0x82
>  #define MT6360_REG_PHYCTRL7	0x86
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index b56a0880a044..3291ca4948da 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -10,9 +10,9 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/usb/tcpci.h>
>  #include <linux/usb/tcpm.h>
>  #include <linux/regmap.h>
> -#include "tcpci.h"
>  
>  #define RT1711H_VID		0x29CF
>  #define RT1711H_PID		0x1711
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/include/linux/usb/tcpci.h
> similarity index 99%
> rename from drivers/usb/typec/tcpm/tcpci.h
> rename to include/linux/usb/tcpci.h
> index b2edd45f13c6..20c0bedb8ec8 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -9,6 +9,7 @@
>  #define __LINUX_USB_TCPCI_H
>  
>  #include <linux/usb/typec.h>
> +#include <linux/usb/tcpm.h>
>  
>  #define TCPC_VENDOR_ID			0x0
>  #define TCPC_PRODUCT_ID			0x2
> -- 
> 2.25.1
> 
