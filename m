Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEF34DC78A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiCQN1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbiCQN1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:27:08 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1222F16C0BF;
        Thu, 17 Mar 2022 06:25:48 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id z8so10188013ybh.7;
        Thu, 17 Mar 2022 06:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPvFn4zW+HYII4PeZtiMT7obVyqt+EFe8DrLP0fyVsc=;
        b=0ONC3Sqcv0yhwGOYQfs+IWzT/1Yy867R/6KlO6U/15l8yVCbe0I5oRPeHdqKhvMDx8
         V1R6p9cRNTlu9iLTtOis6RNfHkYfyFohw/OYY16a+QTEdrDpOE5IJ5oOvmOhtVPZ1qEU
         69X9pIaNTaqBIsbXdVli6EtADvbw+89EE3WKj9gu0q2eqadvXL6YmfDtVYy/2bvrmgDW
         VGQ0Bhu3vDE0Hjp+Va5arqkIpKZVqB4uD85KZtIgQOfWJA7NpcRw9S9FmLRNO4/af7cW
         JV/QqWCkktshEzSrIfqKqbLCSAGsQs5+ocKmcPNn4AmvynLJ1u+PNn6iLFb8X4e2FS3I
         mPlA==
X-Gm-Message-State: AOAM533T6A/l/PemIByepgZEr5JHk0l4riLxMWmRtMzASRLhag05gs4C
        iDP/9HMFUJ3uHhVBUlp/IpMZrVbGakP21THWNc3f0LdH
X-Google-Smtp-Source: ABdhPJwpVcWHCzDs4bdzn3PSpncbPClTGTX/VWTmFLkrF4UgAGPaJFl9wWh5enimlaxnjW8mZzIQjlC/EPpg1q6wCDc=
X-Received: by 2002:a25:6d05:0:b0:633:b0f5:6c1e with SMTP id
 i5-20020a256d05000000b00633b0f56c1emr1259417ybc.137.1647523547193; Thu, 17
 Mar 2022 06:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220315144122.23144-1-rdunlap@infradead.org>
In-Reply-To: <20220315144122.23144-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Mar 2022 14:25:36 +0100
Message-ID: <CAJZ5v0gfX2weU++t4szknB16PxufzGZ26NHgqe__B-+VdAmCQw@mail.gmail.com>
Subject: Re: [PATCH v3] clocksource: acpi_pm: fix return value of __setup handler
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        John Stultz <john.stultz@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 3:41 PM Randy Dunlap <rdunlap@infradead.org> wrote:
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
> From: Igor Zhbanov <i.zhbanov@omprussia.ru>

What does this From tag mean?

> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
> v3: also cc: linux-acpi (Rafael)
> v2: correct the Fixes: tag (Dan Carpenter)
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
