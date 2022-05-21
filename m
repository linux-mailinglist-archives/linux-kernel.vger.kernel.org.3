Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB29152FE0C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241791AbiEUQLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiEUQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:11:44 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488AE3584B;
        Sat, 21 May 2022 09:11:43 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ef5380669cso112662627b3.9;
        Sat, 21 May 2022 09:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7F6oCzNYFBxHPnk12TdNoHJALNY+iFdjEcmlwUydIPo=;
        b=q/3tfnlNiCI12EMTttZmr0txPlCxd4unoiAaljjYrqRcZ9FD3+NBNPdwIggTVVdzej
         NoDVSDstomX1+OP0kiclTx1sYdAUgo3kSLPkR+MFJtNz3QoCnQ0Uiyf6SAvxMhs+nZXt
         C5sdxri74eufjsoHlcC1XlH6PpQycttEhCuzFUkMjVKhdJ7BIGrOjCr/PV9PqHCddeJS
         mpIcdnmoNX8T0l5tfaW3UVw6K9OchngaIwg+WTPe25B0wed5utawB7rQdTLq9wzb28ty
         F8x7wqc+AYLQ4/C76akOB4BdW13qEmt6sakgBF7xECfgm5sz5v5LU6iFxgV/FX+c1WRw
         6ZVg==
X-Gm-Message-State: AOAM533/F9N7qjwY6VEE06h6zszdf+WoDr81NhAOcZxoee8igjdr1H5V
        en1ZZF5IpBTmpd4LscwlQhOfStz5D7gQlU+zhGP26sMKPW0=
X-Google-Smtp-Source: ABdhPJyPmchyL2rUrrZadOciabAgIi21N61kdrjslr9zf8LLd29IHUhRCfL05KermlwYqyh0coSJQ/aI/TA2uRmviEA=
X-Received: by 2002:a81:6d8e:0:b0:2ff:a8d9:d574 with SMTP id
 i136-20020a816d8e000000b002ffa8d9d574mr3990143ywc.301.1653149502506; Sat, 21
 May 2022 09:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <5578328.DvuYhMxLoT@kreacher> <4200238.ejJDZkT8p0@kreacher>
In-Reply-To: <4200238.ejJDZkT8p0@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 21 May 2022 18:11:31 +0200
Message-ID: <CAJZ5v0gWYZ_BSonhLGT7L4wPQvXLVyobPptE1Nx6PoNSGn4yXg@mail.gmail.com>
Subject: Re: [PATCH 15/20] ACPICA: executer/exsystem: Warn about sleeps
 greater than 10 ms
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bob Moore <robert.moore@intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
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

On Mon, Apr 11, 2022 at 9:04 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Paul Menzel <pmenzel@molgen.mpg.de>
>
> ACPICA commit 2a0d1d475e7ea1c815bee1e0692d81db9a7c909c
>
> Quick boottime is important, so warn about sleeps greater than 10 ms.
>
> Distribution Linux kernels reach initrd in 350 ms, so excessive delays
> should be called out. 10 ms is chosen randomly, but three of such delays
> would already make up ten percent of the boottime.
>
> Link: https://github.com/acpica/acpica/commit/2a0d1d47
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I have decided to revert this, because it spams logs with unuseful
warnings on many production systems.

Power management AML uses sleeps above 10 ms for PCI spec compliance
and polling is not useful in those cases.

I will submit an analogous revert for upstream ACPICA.

> ---
>  exsystem.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff -Nurp linux.before_name/drivers/acpi/acpica/exsystem.c linux.after_name/drivers/acpi/acpica/exsystem.c
> --- linux.before_name/drivers/acpi/acpica/exsystem.c    2022-04-01 18:26:54.958046947 +0200
> +++ linux.after_name/drivers/acpi/acpica/exsystem.c     2022-04-01 18:26:51.760086923 +0200
> @@ -170,6 +170,16 @@ acpi_status acpi_ex_system_do_sleep(u64
>         acpi_ex_exit_interpreter();
>
>         /*
> +        * Warn users about excessive sleep times, so ASL code can be improved to
> +        * use polling or similar techniques.
> +        */
> +       if (how_long_ms > 10) {
> +               ACPI_WARNING((AE_INFO,
> +                             "Firmware issue: Excessive sleep time (%llu ms > 10 ms) in ACPI Control Method",
> +                             how_long_us));
> +       }
> +
> +       /*
>          * For compatibility with other ACPI implementations and to prevent
>          * accidental deep sleeps, limit the sleep time to something reasonable.
>          */
>
>
>
