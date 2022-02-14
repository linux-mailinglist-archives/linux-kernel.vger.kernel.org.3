Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509E14B5CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiBNV15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:27:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiBNV1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:27:55 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A793D205CC;
        Mon, 14 Feb 2022 13:27:43 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id v5so8833640uam.3;
        Mon, 14 Feb 2022 13:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kI/su3rLIeICfLlNKWmUFjgPBcsY2C15d0MI7GuavKc=;
        b=wCG6p/+P3vdcrqHorWmabfT4JogzaP2GngcXL6Rxslb9pFcQ3qhxmXb4vIwbzI+D9x
         QE6A6BnOGaCW2ByXnXT+9bo8CUpRDavYWaNQyU5w7fw1/aH7//yyy5tE6dTwFca6ildI
         eWcA4h2F2Es8No5XO25NjGEod83i0wh050SkVgIX32EoyNqEJjnw4uaLAU1gVruG+AI0
         HvUXLFPhcyClkkzAoKwE1ook66cfajOied7mYCEzClRYoYu3nufRvMYOkrN67iMlJRet
         tGh6ojISA+4lTGp1SE9fygp5ToV03w8D89bQfP49oACIfF/HTsugq7I1u5H0VOSMFHbh
         ldAA==
X-Gm-Message-State: AOAM531I1BEuY5+JcROkHhgPhMkhwU/5T3l36VuBURdqL5vVUluJjbjp
        vYof5q4Dr7+ruzp1aRcpuDinLJNBLq/rf03+U6DoPDcj
X-Google-Smtp-Source: ABdhPJxGZGt2fPgzAqcgORvIh0/Y5CWB2tlTZbwqTAX/KQ7CW6L1r5+mAHGuDyElx2Pd5u2NGjMMyir7212xQ8cyY/A=
X-Received: by 2002:a25:7e81:: with SMTP id z123mr550858ybc.466.1644866318513;
 Mon, 14 Feb 2022 11:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20220210224933.379149-1-yury.norov@gmail.com> <20220210224933.379149-46-yury.norov@gmail.com>
In-Reply-To: <20220210224933.379149-46-yury.norov@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Feb 2022 20:18:27 +0100
Message-ID: <CAJZ5v0hWse+A6ipWiAgfgzSQA52=e45WZgrRX9hUTsekkQjBig@mail.gmail.com>
Subject: Re: [PATCH 45/49] ACPI: replace nodes__weight with nodes_weight_ge
 for numa
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alison Schofield <alison.schofield@intel.com>,
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

On Fri, Feb 11, 2022 at 1:31 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> acpi_map_pxm_to_node() calls nodes_weight() to compare the weight
> of nodemask with a given number. We can do it more efficiently with
> nodes_weight_eq() because conditional nodes_weight may stop
> traversing the nodemask earlier, as soon as condition is (or is not)
> met.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/acpi/numa/srat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 3b818ab186be..fe7a7996f553 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -67,7 +67,7 @@ int acpi_map_pxm_to_node(int pxm)
>         node = pxm_to_node_map[pxm];
>
>         if (node == NUMA_NO_NODE) {
> -               if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
> +               if (nodes_weight_ge(nodes_found_map, MAX_NUMNODES))
>                         return NUMA_NO_NODE;
>                 node = first_unset_node(nodes_found_map);
>                 __acpi_map_pxm_to_node(pxm, node);
> --

Applied as 5.18 material, thanks!
