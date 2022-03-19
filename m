Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921394DE738
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 10:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbiCSJ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 05:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiCSJ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 05:26:09 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAB9205BFD
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 02:24:49 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id k125so8484899qkf.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 02:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/vQVG0dsvXiKvTeGXeXwf1PIXee60jvWMmXOwq1e7g=;
        b=LCTjjOizIDGfm+2CDEgJFSrGhx3yCNmc02IwrsvsNjdWIENf3fjFyOK4494DiTLg5L
         49qgd5qbYM5mKb7bN0FlEuOLkz1pFf3/nbsRmvJuiDBoBsTmGrGXc1Pd5VXNpoYOybMm
         qztmeBuyvOUx12Al0nsjcIeNnRQ2mk/mojsvTGO5/woU+qn8XZXBNHED5oRRqpW0t1Zw
         ap+vDnWy17Q7mpUI97fVEZu6jXR01us0cEjMb09mULhAuTT+5317fHUbAkh5SSTKLEDp
         32vt7j6WZMZTQHIUweVm0PjYL6qIVuamlRAN07HpvwGihYRGsUqlARbObaBs/hMOrtww
         3prw==
X-Gm-Message-State: AOAM530frKYieg738tfxgdugRyjuWIkBlMkLRNnMsuh69v9KLu2EDcT3
        Yimdl27glb3tNaRTq0H7/S8fweNrlHL7rA==
X-Google-Smtp-Source: ABdhPJwnq3rvRLS39qtRHMzhDFBIVS38kvKsq//KA7wFQWa8S1MxoHzZHBqeRmf+SlfdtRzZNKRcQg==
X-Received: by 2002:a05:620a:c96:b0:67d:4837:e381 with SMTP id q22-20020a05620a0c9600b0067d4837e381mr7674706qki.107.1647681887715;
        Sat, 19 Mar 2022 02:24:47 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id w3-20020a05622a190300b002e1f084d84bsm5499495qtc.50.2022.03.19.02.24.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 02:24:47 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2e5e9025c20so29200537b3.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 02:24:47 -0700 (PDT)
X-Received: by 2002:a81:5a08:0:b0:2db:d8c6:7e4f with SMTP id
 o8-20020a815a08000000b002dbd8c67e4fmr15567904ywb.256.1647681886843; Sat, 19
 Mar 2022 02:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <cb1828050f8c9ef801b2bdf79eccd6c52afed26b.1647663509.git.fthain@linux-m68k.org>
In-Reply-To: <cb1828050f8c9ef801b2bdf79eccd6c52afed26b.1647663509.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 19 Mar 2022 10:24:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVLCX0uPOCQos=cd5Z5pbm-++uVyV-fzMGyPi6oD3+SZw@mail.gmail.com>
Message-ID: <CAMuHMdVLCX0uPOCQos=cd5Z5pbm-++uVyV-fzMGyPi6oD3+SZw@mail.gmail.com>
Subject: Re: [PATCH] macintosh/via-pmu: Fix build failure when CONFIG_INPUT is disabled
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Finn,

On Sat, Mar 19, 2022 at 5:23 AM Finn Thain <fthain@linux-m68k.org> wrote:
> drivers/macintosh/via-pmu-event.o: In function `via_pmu_event':
> via-pmu-event.c:(.text+0x44): undefined reference to `input_event'
> via-pmu-event.c:(.text+0x68): undefined reference to `input_event'
> via-pmu-event.c:(.text+0x94): undefined reference to `input_event'
> via-pmu-event.c:(.text+0xb8): undefined reference to `input_event'
> drivers/macintosh/via-pmu-event.o: In function `via_pmu_event_init':
> via-pmu-event.c:(.init.text+0x20): undefined reference to `input_allocate_device'
> via-pmu-event.c:(.init.text+0xc4): undefined reference to `input_register_device'
> via-pmu-event.c:(.init.text+0xd4): undefined reference to `input_free_device'
> make[1]: *** [Makefile:1155: vmlinux] Error 1
> make: *** [Makefile:350: __build_one_by_one] Error 2
>
> Don't call into the input subsystem unless CONFIG_INPUT is built-in.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Thanks for your patch!

> --- a/drivers/macintosh/Makefile
> +++ b/drivers/macintosh/Makefile
> @@ -12,7 +12,10 @@ obj-$(CONFIG_MAC_EMUMOUSEBTN)        += mac_hid.o
>  obj-$(CONFIG_INPUT_ADBHID)     += adbhid.o
>  obj-$(CONFIG_ANSLCD)           += ans-lcd.o
>
> -obj-$(CONFIG_ADB_PMU)          += via-pmu.o via-pmu-event.o
> +obj-$(CONFIG_ADB_PMU)          += via-pmu.o
> +ifeq ($(CONFIG_INPUT), y)
> +obj-$(CONFIG_ADB_PMU)          += via-pmu-event.o
> +endif

Alternatively, you can introduce an invisible Kconfig symbol that
is y if ADB_PMU && INPUT, to control the build of via-pmu.o.

>  obj-$(CONFIG_ADB_PMU_LED)      += via-pmu-led.o
>  obj-$(CONFIG_PMAC_BACKLIGHT)   += via-pmu-backlight.o
>  obj-$(CONFIG_ADB_CUDA)         += via-cuda.o
> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
> index 4b98bc26a94b..55afa6dfa263 100644
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -1457,12 +1457,14 @@ pmu_handle_data(unsigned char *data, int len)
>                 if (pmu_battery_count)
>                         query_battery_state();
>                 pmu_pass_intr(data, len);
> +#ifdef CONFIG_INPUT
>                 /* len == 6 is probably a bad check. But how do I
>                  * know what PMU versions send what events here? */
>                 if (len == 6) {
>                         via_pmu_event(PMU_EVT_POWER, !!(data[1]&8));
>                         via_pmu_event(PMU_EVT_LID, data[1]&1);
>                 }
> +#endif

Additionally, if that new symbol is not enabled, a dummy via_pmu_event()
can be provided, so you don't need to add an #ifdef to the driver anymore.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
