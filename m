Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BA45171DB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385595AbiEBOtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385685AbiEBOtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B993B766D
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651502745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4pQrxwbMkCLJ5ROt7mPOSwd6NiZcg0UnB/It7+vur8=;
        b=Emo2+bVJsNMD5NIa/uHZ2TEiWacSZH+3o7UHUc7BMPOHavluFfTvqUNTmgw9c/GHYb86cu
        rSvhWMBhFULRol/QjwUQu6i9nnkln1hcr++/rWbgYUNJRO86z6yYzKXRgP3+kkmFFUmY3k
        AC5t5b4TWq3L9F/8CVSJsPBbWfPT7b4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-Yq0OadoIP4OF8pP0OOCN-Q-1; Mon, 02 May 2022 10:45:44 -0400
X-MC-Unique: Yq0OadoIP4OF8pP0OOCN-Q-1
Received: by mail-ed1-f70.google.com with SMTP id k13-20020a50ce4d000000b00425e4447e64so8806277edj.22
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 07:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B4pQrxwbMkCLJ5ROt7mPOSwd6NiZcg0UnB/It7+vur8=;
        b=sfdc7Jv7H05h580umMxNN3AOoOEQi2OflJYlwO7+qIk4hL1hAUuF/6RgDuDNMw1U3r
         ELHelMbf6PbqfQI7tZ0BJ8VLM53bxv/tC9uoHMJ3QYUPWWwz8xC93HT3cxDu49Rhw0sL
         n/Xy2GPFzxct22Nc4o8bC4IaL4srhhsWn1s4gS9CbrdZlk0VYGLHb8kVPEw/TssyhU2k
         D7hITUL7/tbqcfiaEKktAs06DVaDR02qZujMB69pbVZB0af102ZzZQI9uL9J2hy9PH7V
         FdOBeBUp13eKxSdsK7qy7Pu50p8YmZedjl2OwW3xB3YHFnIKOHdOMRG4wIuQELXvv+4U
         U9PQ==
X-Gm-Message-State: AOAM533nhYV4tAZ4IWlLnmuSQWbudrOnw8UYbtTox7jUYcwaJuFhynKA
        gFbx7zzpCKwm30GLPQCRODOsSCCg9W+KHaSP40xl0plvAHwtVzLUtO6AE2KN4R1ChZL0PHIt+XQ
        u/w/+XdpzPMNk5SNBqjarIKu6
X-Received: by 2002:aa7:d416:0:b0:425:f5c7:d633 with SMTP id z22-20020aa7d416000000b00425f5c7d633mr13503786edq.105.1651502743724;
        Mon, 02 May 2022 07:45:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvSFWfM2G/qAaAHK+B/XTlThC9zby/KRVnSdmSjo6AXVwHq4i/vQblfOGY/9duxKZi86DgHQ==
X-Received: by 2002:aa7:d416:0:b0:425:f5c7:d633 with SMTP id z22-20020aa7d416000000b00425f5c7d633mr13503769edq.105.1651502743524;
        Mon, 02 May 2022 07:45:43 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id h21-20020a1709070b1500b006f3ef214e17sm3645444ejl.125.2022.05.02.07.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 07:45:42 -0700 (PDT)
Message-ID: <7609be8e-6331-2b4b-3349-bf300bb6af15@redhat.com>
Date:   Mon, 2 May 2022 16:45:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] platform/x86: pmc_atom: make the PMC driver actually
 unselectable
Content-Language: en-US
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
 <20220428062430.31010-5-paul.gortmaker@windriver.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220428062430.31010-5-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/28/22 08:24, Paul Gortmaker wrote:
> This caught my eye when I saw it was def_bool and hence largely
> pointless to have a Kconfig for it at all.
> 
> Yet there is no reason why you shouldn't be able to opt out of Atom
> platform support if you only care about desktop and server class CPUs.
> 
> It was introduced as def_bool, but there is no obvious reason as to why
> it was forcibly built-in for everyone, other than LPSS implicitly
> relying on it (which is now fixed).  So here we fix up the Kconfig and
> open the door for people to opt out.
> 
> Since putting "default y" on anything that isn't absolutely essential is
> generally frowned upon, I made the default be CONFIG_MATOM.  People who
> use "make oldconfig" or similar won't notice any difference.
> 
> The two "unchanged" lines for PCI and COMMON_CLK appear in the diff from
> fixing a whitespace issue that somehow managed to live on despite being
> moved between two different Kconfig files since its introduction.
> 
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/platform/x86/Kconfig | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index f08ad85683cb..86459e99d831 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1163,6 +1163,11 @@ config WINMATE_FM07_KEYS
>  endif # X86_PLATFORM_DEVICES
>  
>  config PMC_ATOM
> -       def_bool y
> -       depends on PCI
> -       select COMMON_CLK
> +	bool "Intel Atom SOC Power Management Controller driver"
> +	default MATOM

Besides the remarks from Andy, this does seem like a weird default,
MATOM means that gcc is passed -march=atom nothing more and nothing
less. For a distro kernel which may e.g. set 
CONFIG_GENERIC_CPU we still want this enabled. But as said it is
brought in by CONFIG_X86_INTEL_LPSS when that is set. 

Thinking more about this I think it might be best to just do this
instead, replacing patch 2 + 4 of this set:

diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
index 1244c4e568ff..c2088b3c4081 100644
--- a/drivers/clk/x86/Makefile
+++ b/drivers/clk/x86/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
 obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-fch.o
-clk-x86-lpss-y			:= clk-lpss-atom.o
-obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
+obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-lpss-atom.o clk-pmc-atom.o
 obj-$(CONFIG_CLK_LGM_CGU)	+= clk-cgu.o clk-cgu-pll.o clk-lgm.o
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f08ad85683cb..85c396a43048 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1161,8 +1161,3 @@ config WINMATE_FM07_KEYS
 	  that delivers key events when these buttons are pressed.
 
 endif # X86_PLATFORM_DEVICES
-
-config PMC_ATOM
-       def_bool y
-       depends on PCI
-       select COMMON_CLK
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 4a59f47a46e2..cc2a74713313 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -126,7 +126,7 @@ obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
 obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
 obj-$(CONFIG_INTEL_SCU_WDT)		+= intel_scu_wdt.o
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
-obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
+obj-$(CONFIG_X86_INTEL_LPSS)		+= pmc_atom.o
 
 # Siemens Simatic Industrial PCs
 obj-$(CONFIG_SIEMENS_SIMATIC_IPC)	+= simatic-ipc.o


This just folds the enabling of the pmc_atom code into the same
Kconfig option as the one used the the LPSS code, so this actually
simplify things; while at the same time making it possible to
not build the pmc_atom code by unselecting the CONFIG_X86_INTEL_LPSS
option.

Regards,

Hans

