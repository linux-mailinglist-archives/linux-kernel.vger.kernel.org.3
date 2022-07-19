Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7A657A1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbiGSOdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiGSOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:33:18 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B3D13E29
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:22:23 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id i4so1523627qvv.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOo3Dh+u9eIpXPuxQ5+/nrksBNh/wB+hD8XQEf+YRJo=;
        b=hl1Wr5vrpJufHnLK2X4a8LY+6TjFmlkZIR4qxovonfYOzA1EosMaj4hAzduvTkSONI
         d51GnavzRFAfpwIGNv2ecjaA/+DlIV0nnlPH2OBiHcZiiKlU1Af9MhO3YPMn+MYC0Hz4
         i1TPTZmw9LEv4LD+8SNwmBdYv7EIvPR/C4WriBG694HymqmLwsZp4aY8/hazcsRBYCAI
         /04AWdHSWqY/t6he3jRLA0LXZFL2GGNTQTRWcHg8U3FJCB6h+hz11yU6+tLJIY7aok8H
         2Wp2F0pz/XABeYIG7wF42Wp1iko9NOO78T5+WF9glg+21JVwveo7RpK+GkZu8d4Q6GpV
         zUaA==
X-Gm-Message-State: AJIora9Dkpk0a0FRMjedHnoYIdWZn71FHzsb536EQJZh9uT+1GPmrzt9
        Hl3kUvrFo62gHcFmluSahuh/SAoYdXDnvA==
X-Google-Smtp-Source: AGRyM1v7Pk3G+u9CYmybrdbTE2vcVPwNdTKs9pr7/viJjg7f40P0MbCeN2Gdtm+ntzeaaahpw79kFg==
X-Received: by 2002:a0c:e501:0:b0:473:fdb3:dae3 with SMTP id l1-20020a0ce501000000b00473fdb3dae3mr1361361qvm.129.1658240541814;
        Tue, 19 Jul 2022 07:22:21 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id bq6-20020a05620a468600b006b5fbc3035bsm2336467qkb.117.2022.07.19.07.22.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 07:22:21 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 75so26720999ybf.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:22:20 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr30846962ybq.543.1658240540695; Tue, 19
 Jul 2022 07:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220704101605.1318280-1-sudeep.holla@arm.com> <20220704101605.1318280-10-sudeep.holla@arm.com>
In-Reply-To: <20220704101605.1318280-10-sudeep.holla@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 16:22:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUBZ791fxCPkKQ6HCwLE4GJB2S35QC=SQ+X8w5Q4C_70g@mail.gmail.com>
Message-ID: <CAMuHMdUBZ791fxCPkKQ6HCwLE4GJB2S35QC=SQ+X8w5Q4C_70g@mail.gmail.com>
Subject: Re: [PATCH v6 09/21] arch_topology: Add support to parse and detect
 cache attributes
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Mon, Jul 4, 2022 at 12:19 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> Currently ACPI populates just the minimum information about the last
> level cache from PPTT in order to feed the same to build sched_domains.
> Similar support for DT platforms is not present.
>
> In order to enable the same, the entire cache hierarchy information can
> be built as part of CPU topoplogy parsing both on ACPI and DT platforms.
>
> Note that this change builds the cacheinfo early even on ACPI systems,
> but the current mechanism of building llc_sibling mask remains unchanged.
>
> Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks for your patch!

> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/cacheinfo.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/device.h>
> @@ -780,15 +781,28 @@ __weak int __init parse_acpi_topology(void)
>  #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
>  void __init init_cpu_topology(void)
>  {
> +       int ret, cpu;
> +
>         reset_cpu_topology();
> +       ret = parse_acpi_topology();
> +       if (!ret)
> +               ret = of_have_populated_dt() && parse_dt_topology();
>
> -       /*
> -        * Discard anything that was parsed if we hit an error so we
> -        * don't use partial information.
> -        */
> -       if (parse_acpi_topology())
> -               reset_cpu_topology();
> -       else if (of_have_populated_dt() && parse_dt_topology())
> +       if (ret) {
> +               /*
> +                * Discard anything that was parsed if we hit an error so we
> +                * don't use partial information.
> +                */
>                 reset_cpu_topology();
> +               return;
> +       }
> +
> +       for_each_possible_cpu(cpu) {
> +               ret = detect_cache_attributes(cpu);
> +               if (ret) {
> +                       pr_info("Early cacheinfo failed, ret = %d\n", ret);

This is triggered

    Early cacheinfo failed, ret = -12

on all my RV64 platforms (K210, PolarFire, StarLight).
-12 = -ENOMEM.

The boot continues regardless, and the K210 even has enough spare
RAM after boot to run "ls", unlike two weeks ago ;-)

> +                       break;
> +               }
> +       }
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
