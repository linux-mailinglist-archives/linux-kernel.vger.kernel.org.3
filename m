Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3725F4B5B68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiBNUpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:45:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiBNUpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:45:07 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA615C9F9;
        Mon, 14 Feb 2022 12:42:15 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so12387709ota.10;
        Mon, 14 Feb 2022 12:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgZfyYfU/uI+Wmb25cwyau5T9MIs8WHUtmpE4RDI30w=;
        b=sTSeryVvbqBjBttDZO2RuUF2F0lLOOWGLUPNBCDQXSmWQD5uf3+DRtD2qdBw0HCrBC
         3kqPM5BzAJrGfNABtL62RRaFRm4HyyMkvpCVsTFzVGBrqFx5FKAcbat57+1F7xNDI983
         TamxxEg+Cqo7EWbedifaS53PFTSmP34kOx5KhpWLqLlDGu0tjMuin1IiMbqUTnwYTcab
         PwvUvUX4c4RK9jyjspej4mmT8lRuE9rQMjhw0GWM1B19sTNOnbfMGowdC5CdtVYoL71H
         ztEr0U+NHrb4W+PqVYbYsdutTXCMKXIyALMppZTjGBLNpa2c53ONrZpW/hOBzFN/wZ5K
         Uvhw==
X-Gm-Message-State: AOAM530kV4DidXlGGTz0qB9uPiqQpGQ34V0ZbFNfiSpoAkzoTeWTh/DC
        jlx7Qadg030n3mziQAu3Ch6ndBf+dl2Y4L+AOsuRkal6
X-Google-Smtp-Source: ABdhPJz7A12UB0+8xTsSbw/O1RFK+7qXyXLo2zRb8niwiOIiKd06/kV5fhJSZwpoyfRqp+SHvgEbL/0HlYxaZDDGDYE=
X-Received: by 2002:a25:180a:: with SMTP id 10mr694003yby.552.1644867916973;
 Mon, 14 Feb 2022 11:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20220210224933.379149-1-yury.norov@gmail.com> <20220210224933.379149-46-yury.norov@gmail.com>
 <CAJZ5v0hWse+A6ipWiAgfgzSQA52=e45WZgrRX9hUTsekkQjBig@mail.gmail.com> <YgqurDJYAqHjpKmf@yury-laptop>
In-Reply-To: <YgqurDJYAqHjpKmf@yury-laptop>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Feb 2022 20:45:06 +0100
Message-ID: <CAJZ5v0jMwi7Jbx=tEC6GHW7iSe9_9EM6B31e949y0wFEp3V6qA@mail.gmail.com>
Subject: Re: [PATCH 45/49] ACPI: replace nodes__weight with nodes_weight_ge
 for numa
To:     Yury Norov <yury.norov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alison Schofield <alison.schofield@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 8:36 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Mon, Feb 14, 2022 at 08:18:27PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Feb 11, 2022 at 1:31 AM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > acpi_map_pxm_to_node() calls nodes_weight() to compare the weight
> > > of nodemask with a given number. We can do it more efficiently with
> > > nodes_weight_eq() because conditional nodes_weight may stop
> > > traversing the nodemask earlier, as soon as condition is (or is not)
> > > met.
> > >
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  drivers/acpi/numa/srat.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > > index 3b818ab186be..fe7a7996f553 100644
> > > --- a/drivers/acpi/numa/srat.c
> > > +++ b/drivers/acpi/numa/srat.c
> > > @@ -67,7 +67,7 @@ int acpi_map_pxm_to_node(int pxm)
> > >         node = pxm_to_node_map[pxm];
> > >
> > >         if (node == NUMA_NO_NODE) {
> > > -               if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
> > > +               if (nodes_weight_ge(nodes_found_map, MAX_NUMNODES))
> > >                         return NUMA_NO_NODE;
> > >                 node = first_unset_node(nodes_found_map);
> > >                 __acpi_map_pxm_to_node(pxm, node);
> > > --
> >
> > Applied as 5.18 material, thanks!
>
> It depends on patches 44 and 26. Are you applying them too?

No, I'm not (I've only received this one directly).

I'll drop this patch now and please feel free to add my ACK to it.

Thanks!
