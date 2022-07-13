Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1741A573C33
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiGMRx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiGMRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:53:26 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274E62D1C9;
        Wed, 13 Jul 2022 10:53:25 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id r3so20531451ybr.6;
        Wed, 13 Jul 2022 10:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWJYVhIsSaOySNu/uWyUWms8khqO/2XtexmfoLNvV70=;
        b=wWomImL7HRJ8U5gV94PFrbJ5LovvWw4n1B17yPtaFC2UCbj3L+U3kUKJB+klh0RmeV
         JB9QoQTJw8h70zfOwCrj2TnrQz8yimNLoaapK00txxD9rY2Ozc0PD06rVEg7Ov2Ur5V3
         U6CY9eyw8ydrEAZAXcrYpIlUp8lw5YjBqgGZNXb+Kj3Ahp3sk6GFpD1m6qpeZE4c3ljU
         rf3THJlDSw+/9nVGMOdrn8npYM5IldZr8L+BZBKYNwSmdbQEFc/+kL+5mOzIwLH3yEde
         ZFVubpCZ+OOEDwM41CF+xcuFA5S4LyPlZcqeoqnQxPL6sgWhrxOpYRmYoWHqwbUs5s1n
         /vWQ==
X-Gm-Message-State: AJIora/PJMlJ002lDmxvZAK/GXDOG+tcorgPusvmRiOsslNXG1Vi13cS
        1vrop1GmA9EsLa6e0G/qPse4xtDZvO1l5AVGLv0=
X-Google-Smtp-Source: AGRyM1stj7HNu+Gwe80jnYn/KS7CMpoCF+eOJmC+kNikMigejw5Yf5InTmPNR76zSdmzBxS209OilDeV+DULcZs+3bc=
X-Received: by 2002:a25:d714:0:b0:66f:5898:9eb1 with SMTP id
 o20-20020a25d714000000b0066f58989eb1mr4809209ybg.633.1657734804438; Wed, 13
 Jul 2022 10:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220713082426.850911-1-dapeng1.mi@intel.com>
In-Reply-To: <20220713082426.850911-1-dapeng1.mi@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jul 2022 19:53:13 +0200
Message-ID: <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
To:     Dapeng Mi <dapeng1.mi@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 10:21 AM Dapeng Mi <dapeng1.mi@intel.com> wrote:
>
> As long as Kconfig ACPI_PROCESSOR is enabled, ACPI_PROCESSOR would
> select ACPI_PROCESSOR_IDLE and acpi_idle driver is enabled. But
> in current driver loading order acpi_idle driver is always loaded
> before cpuidle_haltpoll driver. This leads to cpuidle_hatpoll driver
> has no chance to be loaded when it's enabled.
>
> Thus, move cpuidle driver forward before acpi driver and make
> cpuidle-hatpoll driver has a chance to be run when it's enabled.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@intel.com>
> ---
>  drivers/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 9a30842b22c5..921ed481b520 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -26,6 +26,7 @@ obj-y                         += idle/
>  # IPMI must come before ACPI in order to provide IPMI opregion support
>  obj-y                          += char/ipmi/
>
> +obj-$(CONFIG_CPU_IDLE)         += cpuidle/
>  obj-$(CONFIG_ACPI)             += acpi/
>
>  # PnP must come after ACPI since it will eventually need to check if acpi
> @@ -126,7 +127,6 @@ obj-$(CONFIG_EDAC)          += edac/
>  obj-$(CONFIG_EISA)             += eisa/
>  obj-$(CONFIG_PM_OPP)           += opp/
>  obj-$(CONFIG_CPU_FREQ)         += cpufreq/
> -obj-$(CONFIG_CPU_IDLE)         += cpuidle/
>  obj-y                          += mmc/
>  obj-y                          += ufs/
>  obj-$(CONFIG_MEMSTICK)         += memstick/
> --

Well, this change doesn't guarantee loading haltpoll before ACPI idle.

Also what if haltpoll is enabled, but the user wants ACPI idle?
