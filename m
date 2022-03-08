Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62C54D146D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345732AbiCHKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345852AbiCHKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:11:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C1743AF5;
        Tue,  8 Mar 2022 02:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646734250; x=1678270250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7ejrIRDi0eLEWqSUSsS80pzyQyiNB/5BCzaO1wi9Cco=;
  b=GwzXJMdSRjynlRZ0qhbw+W+QjBQr9Nj0VLSkvtPPsuwiHvvRL/37LfR+
   jev5OHH3ucKBHj67VtNN64Xdixz/oQnkyJKNoOPw/HwZFgi0+z8/gB+Ho
   OeEAlJ+GhO70nWX5P18eB7Et/8NEKkFqYDXpdlT6ygOTy0RyswOeYQ0/t
   V51Z62Y+tp5qYhPwbQs9nnnCp1l3vmBAEyQCM4YJgo8w7BKeLx4Pzflf3
   dgukn9SjkOohixlceSEOi+taBfo/J9oECvNVQUZoCmI+Jnhm4qacEoCZ3
   wFZWej+8DFEGLnZYclzzBatFAVa96BJJA6vghowOP6owACbJi6WpFntgK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254587409"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254587409"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="687874826"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Mar 2022 02:10:46 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Mar 2022 12:10:45 +0200
Date:   Tue, 8 Mar 2022 12:10:45 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/ directory
Message-ID: <YicrpWig4kwdh2lg@kuha.fi.intel.com>
References: <20220308073431.1217890-1-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308073431.1217890-1-xji@analogixsemi.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 03:34:28PM +0800, Xin Ji wrote:
> As for convenience use TCPCI register definition, move tcpci.h to
> include/linux/usb/ directory.

To be honest, I was still hoping for a better explanation here.

The reason why this header is made global is because some USB PD
controllers - PD controllers consisting of a microcontroller
(acting as the TCPM) and a port controller (TCPC) - may require that
the driver for the PD controller accesses directly also the on-chip
port controller in some cases.

I was hoping that that was explained in the commit message somehow.

> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> 
> ---
> V7 -> V8: Fix Guanter's comment, remove unnecessary explain.
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
> index e07d26a3cd8e..9c907296596f 100644
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
> index f1bd9e09bc87..9e0338bce7ef 100644
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
>  #define MT6360_REG_VCONNCTRL1	0x8C
>  #define MT6360_REG_MODECTRL2	0x8F
>  #define MT6360_REG_SWRESET	0xA0
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

-- 
heikki
