Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4D659E590
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbiHWPDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243169AbiHWPBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:01:50 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C8B316D7E;
        Tue, 23 Aug 2022 05:27:11 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3378303138bso334304787b3.9;
        Tue, 23 Aug 2022 05:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tVM0oU+KcbkkR1L5Juny7z91kUbxlvKKQy9MlCqydrk=;
        b=ta8Gc7uW8JjuvoueFcVes9t4Nh3UVPVyNxcOCv9F8wb9mZPu6hUhoRBGFhl+Y/ood9
         GHfICMkHLUR6FXBYMNsHD2BNgNMFDNDhdTntt/HJwUfW2Q0kFWLV5aq97FBOtFile1Ef
         Ge/5T8iTiql1L2CsIQUpAEp/upW710+aMoqgSax/J0lcOeL0kxMcYnjnfOw4QW3G+TMm
         H9RK1lfCEiiVejZmyfBe4675ifGtbst/UgRxHYvW126CBpWXRSDtJQxHoQ9zr5/X2QEe
         5WeBZWt6f1dzjZhPzjP1W4dmpZU3H6lUxJUqZCMaI6+AUU59llr++9kea4CAEOblpviL
         LsTQ==
X-Gm-Message-State: ACgBeo0/XVE3pYkgD7ccCEPtAnNrbFCRzoD/l78ExDSCmp/V3XW5lsg9
        9Pddt51D3JAVbqBg3hQVS74C2avaxgQmEu1mY1CR6FyOJe8=
X-Google-Smtp-Source: AA6agR6cbLxf0awmSoS2RotgXzr+QV6sCWMAmySkdgA45suCn8OrOsRPCjTsjURLGQuQIuNwNyb4XjTWwSQq22fg0fw=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr24451642ybm.137.1661257592999; Tue, 23
 Aug 2022 05:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <TYWP286MB2601183235622B29FAF707B5B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYWP286MB2601183235622B29FAF707B5B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 14:26:22 +0200
Message-ID: <CAJZ5v0jH2B2UHVtpCo8w-F6y+gr70yni+WDwuJMLuC_M_tNxQA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: processor: Remove freq Qos request for all CPUs
To:     Riwen Lu <luriwen@hotmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Riwen Lu <luriwen@kylinos.cn>
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

On Tue, Aug 23, 2022 at 9:44 AM Riwen Lu <luriwen@hotmail.com> wrote:
>
> From: Riwen Lu <luriwen@kylinos.cn>
>
> The freq Qos request would be removed repeatedly if the cpufreq policy
> relates to more than one CPU. Then, it would cause the "called for unknown
> object" warning.
>
> Remove the freq Qos request for each CPU relates to the cpufreq policy,
> instead of removing repeatedly for the last CPU of it.
>
> Fixes: a1bb46c36ce3 ("ACPI: processor: Add QoS requests for all CPUs")
> Reported-by: Jeremy Linton <Jeremy.Linton@arm.com>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> ---
>  drivers/acpi/processor_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index db6ac540e924..e534fd49a67e 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -151,7 +151,7 @@ void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
>         unsigned int cpu;
>
>         for_each_cpu(cpu, policy->related_cpus) {
> -               struct acpi_processor *pr = per_cpu(processors, policy->cpu);
> +               struct acpi_processor *pr = per_cpu(processors, cpu);
>
>                 if (pr)
>                         freq_qos_remove_request(&pr->thermal_req);
> --

Thanks for fixing my mistake!

I've applied this one instead of the revert of commit 7fdc74da940d, as
6.0-rc material.
