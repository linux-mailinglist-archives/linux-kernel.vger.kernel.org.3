Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7914DDB24
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiCRODR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbiCRODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:03:13 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A921F74D;
        Fri, 18 Mar 2022 07:01:53 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2e5e176e1b6so14460057b3.13;
        Fri, 18 Mar 2022 07:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VArFVcUzcHgwGcBdrmCG7NoSNoulRRst2M2L56rKO0=;
        b=3irpL0IJrA5Bs1v1tKtLyXNcM4V2DzmBYk5cg8XzFiZhljZ+7v+qjsb4r8Wnh1RuX+
         x53LEqjuR64VUOXUbvHmxLGHMny9RZBCIarVy5tfT1sJDGjdYgBs4tvssAlcoWrMfmgk
         D47xH0lj3z302XDLLe2sUenmunIYMQM2FQi+ya1sqs4QSg4udpeHeyD/WlUWJJwnwlup
         lyDI04vn8Smqfe+G9sWgnw0vNvAg8Zlzha8V7fx5GbvqyuEXFoUjPYqQt2rOrEb65DYc
         9t/9SXNl9/FuZ4J3lWjvjWpoRVbHm3qU4SISKZ8EA5n3Jy9HcBI9m+Ke2TQlPKQSN0uo
         bpqQ==
X-Gm-Message-State: AOAM533aFB6bueoHoMgoDyl8L4NFlBp6fT6kJPMgF4DgSzxE32vB4xQx
        oUVv7cFA4nhUU/RgIJMYtahjcQsH+nCXWARu9FE=
X-Google-Smtp-Source: ABdhPJzwQecTT2Agccf/LxIghc1zMAMSnNZ2nyhoX5sX6HqhZGbPV01RH30w0pao+y+fr0MowFnI4C+xlatme6Nf4eo=
X-Received: by 2002:a81:36cf:0:b0:2e5:2597:a026 with SMTP id
 d198-20020a8136cf000000b002e52597a026mr11225028ywa.301.1647612112897; Fri, 18
 Mar 2022 07:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220317153939.31542-1-rdunlap@infradead.org>
In-Reply-To: <20220317153939.31542-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Mar 2022 15:01:42 +0100
Message-ID: <CAJZ5v0i_70DuJdHZLcv_eDdXKE=txCSrYR0kMetyk5D22_p7Eg@mail.gmail.com>
Subject: Re: [PATCH v4] clocksource: acpi_pm: fix return value of __setup handler
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 4:39 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> __setup() handlers should return 1 to obsolete_checksetup() in
> init/main.c to indicate that the boot option has been handled.
> A return of 0 causes the boot option/value to be listed as an Unknown
> kernel parameter and added to init's (limited) environment strings.
>
> The __setup() handler interface isn't meant to handle negative return
> values -- they are non-zero, so they mean "handled" (like a return
> value of 1 does), but that's just a quirk. So return 1 from
> parse_pmtmr(). Also print a warning message if kstrtouint() returns
> an error.
>
> Fixes: 6b148507d3d0 ("pmtmr: allow command line override of ioport")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
> v4: correct Igor's email address to be Reported-by: (Rafael)
> v3: also cc: linux-acpi (Rafael)
> v2: correct the Fixes: tag (Dan Carpenter);
>     remove Cc: John Stultz <john.stultz@linaro.org> (bouncing)
>
>  drivers/clocksource/acpi_pm.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --- linux-next-20220315.orig/drivers/clocksource/acpi_pm.c
> +++ linux-next-20220315/drivers/clocksource/acpi_pm.c
> @@ -229,8 +229,10 @@ static int __init parse_pmtmr(char *arg)
>         int ret;
>
>         ret = kstrtouint(arg, 16, &base);
> -       if (ret)
> -               return ret;
> +       if (ret) {
> +               pr_warn("PMTMR: invalid 'pmtmr=' value: '%s'\n", arg);
> +               return 1;
> +       }
>
>         pr_info("PMTMR IOPort override: 0x%04x -> 0x%04x\n", pmtmr_ioport,
>                 base);

Applied as 5.18 material, thanks!
