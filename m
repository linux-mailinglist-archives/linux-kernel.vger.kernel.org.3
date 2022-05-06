Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB351DF4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388655AbiEFSvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358215AbiEFSve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:51:34 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F3D5F8E8;
        Fri,  6 May 2022 11:47:51 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id y76so14412968ybe.1;
        Fri, 06 May 2022 11:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keHWgDtz7S3VXIsgJT8jBHEk5J6pPJA7/dvmm/BYIcw=;
        b=oigCX+XYWz7gtp7znBvt5m6ymFlNmelZx8IMnTHk0FSnq8gYJLZzT6fYGjcGhZft+9
         0nwUDJQrrf3Z+SUc7vFSrZt7ZgAEPnFQr0VAdrbtIeN0ImApK2rSgzcRu3suteoHZTJ+
         f0/mZKjrV1UKaUk3D09JAGM+URRhwF7sW2mYzBbds+X54DtYe86C2BPL61y5vpCFk8Fp
         pySlfO+2/1EmsjheSGHehtYx+1GkdgZe9oNqw9D4CElI5UBWny3H9B7Si7bD2pqcxudO
         28xMOZCR7HX/lBjyrpHZkTWnR8xO8PURUoNi+7CMrutlazhvpyqZjjSJ3OoRAHThRQ+s
         63fQ==
X-Gm-Message-State: AOAM530bobpsklOXtoRqMAD7zk01ZS78q5LhYSNY7RPZBfXlB2/C6U+D
        g6SE7VJSKxkK8Ps9+PIf7WG+xLz2o9B0GdaWvSf7Mupd
X-Google-Smtp-Source: ABdhPJxvDQhccvN3sDAsVqxtedhAuMgwNyc0hZk60N+9BOH9ZEaIW/slD/s9fHY3sPIFfHGY8zN/X/SwoA8TojNA+io=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr3364072ybh.81.1651862870833; Fri, 06 May
 2022 11:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220428095413.2950758-1-yajun.deng@linux.dev>
In-Reply-To: <20220428095413.2950758-1-yajun.deng@linux.dev>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 May 2022 20:47:39 +0200
Message-ID: <CAJZ5v0h5Vc17rg5V_kHHV6A6=MdET9SpbQB6cvzekwFzH4Mxjg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: idle: expose max_cstate/nocst/bm_check_disable
 read-only in sysfs
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Thu, Apr 28, 2022 at 11:54 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>
> This patch exposes max_cstate/nocst/bm_check_disable in read-only sysfs.
> This will allow super users to verify them when changed in grub.
>
> The parameters "nocst/bm_check_disable" is only used to be enable/disable.
> So change them from integer to bool.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  drivers/acpi/processor_idle.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index e9c84d0ac55b..6a5572a1a80c 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -38,11 +38,11 @@
>  #define ACPI_IDLE_STATE_START  (IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX) ? 1 : 0)
>
>  static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
> -module_param(max_cstate, uint, 0000);
> -static unsigned int nocst __read_mostly;
> -module_param(nocst, uint, 0000);
> -static int bm_check_disable __read_mostly;
> -module_param(bm_check_disable, uint, 0000);
> +module_param(max_cstate, uint, 0400);
> +static bool nocst __read_mostly;
> +module_param(nocst, bool, 0400);
> +static bool bm_check_disable __read_mostly;
> +module_param(bm_check_disable, bool, 0400);
>
>  static unsigned int latency_factor __read_mostly = 2;
>  module_param(latency_factor, uint, 0644);
> --

Applied as 5.19 material with some edits in the changelog, thanks!
