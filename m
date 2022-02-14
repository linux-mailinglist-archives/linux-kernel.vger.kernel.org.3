Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1980C4B5AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiBNTvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:51:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBNTvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:51:40 -0500
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142A9B8B56;
        Mon, 14 Feb 2022 11:51:24 -0800 (PST)
Received: by mail-pf1-f182.google.com with SMTP id i6so29133560pfc.9;
        Mon, 14 Feb 2022 11:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BNtqX+7uvTQOF9osDPU3/unph62s+HvVhw55rwLU7yY=;
        b=pHUDZf/nr1RMYwaVIYYSGzLX8uyObTWa3UzSvYgD1toNEPo5FQflZ6Hl2R9235JXro
         tSw4hmWKYZ/UEEmM/97M5SGTUCB7LR7K63CvKpi2PDbX4WRSAZKasFsPzrdSR+jy2dbP
         FFGrI/+qxbsM2IkJzhUXYmcNJ9DNX31ecGqXSemDc7Xg7sknGbUdXAcMe1Zsk9EyA01/
         p5BoNxDN4gjBXclJL/z8TsTrSyjAD3Byl4Msg902wpcZPwyHptBL57vY0xIiKWwdMYbZ
         bL1qCjabSwMnpZDxlw33ZPyVP5gEMSqpqEN8baNS4Crp6QXXvMkcTQT9+AgXaeoZ4pNT
         LJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BNtqX+7uvTQOF9osDPU3/unph62s+HvVhw55rwLU7yY=;
        b=eYukKyFNNMV/xk7K5T+pxAyCUAyjOUgSZvNwDAy0cCel/6x+1gJlnxOudZ6yPrI8xK
         VPBd9pGOTnTPLWPbS8t1GG93MucTYeYpNI58y1F1k8H8gB2RbVOaBXH/A2JCs+/LafyS
         YI0kH3Ox/WdbAe7hwNEBOZXGt1USHHb96s7j+6H0DVtEVBlXh+0DPoutqPoLqWgZCdsv
         70D2cIAIoJZYMdhvPNdU1sQdEGRpfVuXD+6forUnbAsp3CmC3bmTx6b7puOmBUwDMbdU
         60T2N7qmlyZXnoWbYdixkBfq31peRXa9k7TtvfT5xMGv6yXloABnkHT8EQu6xAe9l3DN
         c3Hg==
X-Gm-Message-State: AOAM532v3MWhLtZuRmdt0xc9YEovvWHOjOncBnV4idyyK4x/OVb+YgV2
        gqnG3hmEUG8Pzrs0o1+CVJPUzHJiipw=
X-Google-Smtp-Source: ABdhPJz5a5A9yqk3YI9JbMFsk80ZxPdTtobV0MgI0VTmPpVYi8GO0k6rMjM5AY0N1sbI0nRGC8zmbA==
X-Received: by 2002:a05:6602:2f01:: with SMTP id q1mr228919iow.13.1644867377648;
        Mon, 14 Feb 2022 11:36:17 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id f5sm31096iox.32.2022.02.14.11.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:36:16 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:34:04 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
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
Subject: Re: [PATCH 45/49] ACPI: replace nodes__weight with nodes_weight_ge
 for numa
Message-ID: <YgqurDJYAqHjpKmf@yury-laptop>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-46-yury.norov@gmail.com>
 <CAJZ5v0hWse+A6ipWiAgfgzSQA52=e45WZgrRX9hUTsekkQjBig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hWse+A6ipWiAgfgzSQA52=e45WZgrRX9hUTsekkQjBig@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 08:18:27PM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 11, 2022 at 1:31 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > acpi_map_pxm_to_node() calls nodes_weight() to compare the weight
> > of nodemask with a given number. We can do it more efficiently with
> > nodes_weight_eq() because conditional nodes_weight may stop
> > traversing the nodemask earlier, as soon as condition is (or is not)
> > met.
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  drivers/acpi/numa/srat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 3b818ab186be..fe7a7996f553 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -67,7 +67,7 @@ int acpi_map_pxm_to_node(int pxm)
> >         node = pxm_to_node_map[pxm];
> >
> >         if (node == NUMA_NO_NODE) {
> > -               if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
> > +               if (nodes_weight_ge(nodes_found_map, MAX_NUMNODES))
> >                         return NUMA_NO_NODE;
> >                 node = first_unset_node(nodes_found_map);
> >                 __acpi_map_pxm_to_node(pxm, node);
> > --
> 
> Applied as 5.18 material, thanks!

It depends on patches 44 and 26. Are you applying them too?
