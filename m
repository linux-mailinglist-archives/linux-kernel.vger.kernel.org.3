Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B3E58D5BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiHIIxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbiHIIw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:52:59 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C787C38B7;
        Tue,  9 Aug 2022 01:52:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id u24so582794qku.2;
        Tue, 09 Aug 2022 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kj+IBIcvmD9Bocwc77ln5rMdqZQ+fPOnDWWREVnTls0=;
        b=JrTJM90XjLXeMYorJpV2SEmeQpEzqiDpYQCbkZD4M7ibiGDL36UGezTp5dUhT5eoI5
         xQbHIqoJ/f3dasXBlCzMJ4/uwfOUHTRlQeP0BztvhkmW5rmBjEjlw2wV8vhG9dfh2Kkz
         dS6vdNS27YlaK2pQLSWbsQDyVDik3wGNMxtxyGEjZ8V3jThDiJ61U1ulgiRMuGbxnXQd
         LSMNzQOlSBc0NwjiUTO7TUiHeY+jXj5HjFP3HuYBIVyINOViXfNQdN+GVQHQG0Gnj+NZ
         1pKMGcwoMssxSveLrS91JMxB7sorjt6rsETSrS47cFUsqgSyCIXnM/BmCX5REYqhzlLy
         Uokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kj+IBIcvmD9Bocwc77ln5rMdqZQ+fPOnDWWREVnTls0=;
        b=kaUwdLeBRu+rHzr27tyY7UfL3uk0KuXn5wLJF6SGDGYNC07N7ZGvWfgXICAKAGHtaq
         t5g7pveCUfbJtHqFoQT4Dc4EtGgpRsagzGANxwYSerUDtzbNvQvO9Cx8JnBXvjkYaPG1
         RubYUZ6KI+43JRKkWw5JAOHWavtD2SEUTANnFtQ3Sma0gmnlCVUHZCXNWLIkUfs/R5Mg
         2Rr4LHZAdC21hQd8LCdLZ1egJk2ow9jaRCVevvZNi6HE3q1SgC4STK+E/vHmRGzQZ1kd
         PsvNllyb4uHf9iXYvRh8jJj/hl9E4kE5YjVgKTYlpAufNS+8nG84peg/bHHBBvKh7h+B
         of1w==
X-Gm-Message-State: ACgBeo3RtZqzqadPMCU/Mw+9KPGUCojT2zcv+da+QixSNEkwzx1ixNGB
        phJnJTzN65Q3mbMK/EXM93qqhXFArqGnfeGPBJl2nNznbdw=
X-Google-Smtp-Source: AA6agR6kZcoRcKdtrZ8kXkWgKT/W4OviW071Nnmosd8hPlPFwLT98UM3u+AoOHgOP2euLuyz1qSk3rQU8A7AZIP0GUI=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr17216266qkp.734.1660035177874; Tue, 09
 Aug 2022 01:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220809025054.1626339-1-luke@ljones.dev> <20220809025054.1626339-4-luke@ljones.dev>
In-Reply-To: <20220809025054.1626339-4-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 10:52:21 +0200
Message-ID: <CAHp75VenHd6JREvxjmcNbeshvgv-S_th9pqBBgQJ+FBgPzgWqA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] asus-wmi: Implement TUF laptop keyboard power states
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Adds support for setting various power states of TUF keyboards.
> These states are combinations of:
> - boot, set if a boot animation is shown on keyboard
> - awake, set if the keyboard LEDs are visible while laptop is on
> - sleep, set if an animation is displayed while the laptop is suspended
> - keyboard (unknown effect)
>
> Adds two sysfs attributes to asus-nb-wmi:
> - keyboard_rgb_state
> - keyboard_rgb_state_index

...

>                 until the keyboard_rgb_save attribute is set (write-only):
>                         * 0 - slow
>                         * 1 - medium
> -                       * 2 - fast
> \ No newline at end of file

^^^

> +                       * 2 - fast
> +
> +What:          /sys/devices/platform/<platform>/keyboard_rgb_state
> +Date:          Aug 2022
> +KernelVersion: 6.1
> +Contact:       "Luke Jones" <luke@ljones.dev>
> +Description:
> +               Set some RGB keyboard power states (write-only).
> +
> +               The accepted input is "boot awake sleep keyboard", where "n n n n n"
> +               options are:
> +                       * save - 0 or 1, if 0 then settings are not retained on boot
> +                       * boot - 0 or 1, controls if a boot animation is shown
> +                       * awake - 0 or 1, controls if the keyboard LED are on during awake
> +                       * sleep - 0 or 1, controls if a suspended animation is shown.
> +                                               This is only active if the AC is connected.
> +                       * keyboard - 0 or 1, unknown what effect this really has
> \ No newline at end of file

^^^

Be sure of not repeating the same mistake. I.e. add a newline as suggested.


> +       flags = 0;

Seems you ignored my comment here...

> +       if (sscanf(buf, "%hhd %hhd %hhd %hhd %hhd", &save, &boot, &awake, &sleep, &keyboard) != 5
> +               return -EINVAL;

> +       save = save == 0 ? 0x0100 : 0x0000;

...and here...

> +       if (boot)
> +               flags |= 0x02;
> +       if (awake)
> +               flags |= 0x08;
> +       if (sleep)
> +               flags |= 0x20;
> +       if (keyboard)
> +               flags |= 0x80;

...and here.

...

> +       err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
> +                       ASUS_WMI_DEVID_TUF_RGB_STATE, 0xBD | save | (flags << 16), 0, &ret);
> +       if (err)
> +               return err;

Also see another comment about how ret is supposed to be used.

-- 
With Best Regards,
Andy Shevchenko
