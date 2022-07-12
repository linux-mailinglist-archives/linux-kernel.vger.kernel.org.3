Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD465720D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiGLQ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiGLQ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:28:35 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEDEFDD;
        Tue, 12 Jul 2022 09:28:33 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id l190so8347657vsc.0;
        Tue, 12 Jul 2022 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tiAl750NkryVpXr5atyiwu0K6pH2JObLoKDMkX+rdZc=;
        b=jDj2Q4kGP+6WTtEGNU9gH0eLDiB33OYoN6hsT17mc7uZkEixfeH6bWy2OBQBioNJDe
         d3mxksZIuDMwBILgq5PYJ8mHATPQkxS3SdfP59tYL+r61jlgmG+4JaxY747Clw/mDIK+
         q+1PlZbSBtfSW68HfoG1BpeenZ2+KsYO+G963m3ntwkwTKhO8IzaQ06LONtCi0JdQWLO
         qVW1eUsLvVlNHWuXcomKQ++LICwSqesV2DhYlagIAjQL1eirFtGQ78lrXaOk6RonaEtk
         lGZbO39tpvK0RzRbvSjDnN1yQDqialhFRwKIiYobiHOScAdw8Ye1buHnvTQupNk46Ke/
         mAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tiAl750NkryVpXr5atyiwu0K6pH2JObLoKDMkX+rdZc=;
        b=z4KJtu6O7VAMB/BzDcq7GUz5C9UF59GEI2379D06atxEcbmFqzDmhKAB2mtatAAjBI
         rBZXYJ5kWG42bYgyN3ukSN0IyzB7bzNt0KjyM7rrg/w8Xi2tzsiej3y91o4nwMDtWq+d
         isbzEIC/CG/4XugwFW0ECKPyk9sqlpJZklbnInHqtX8kkfAVFFLMyCs3dcMXM0fAqY4E
         GLSHPbzCLUmBArZvr/PyAyeWjjPLvOuZu80yvj79vSySaZQMZvhCMzGxovhdGTMJk7cd
         OuEOQtmba6y7QMMvywX2P0uOuLPwVjPuBaAdFrY7/jumC/sQDXy5Z4asCuhPLezJnZeG
         f2GA==
X-Gm-Message-State: AJIora9mb+dQ86ZejRNh2YChpKesT4CZvwMUZjsfOPMWVNjePdmTKvwV
        EselS6bAIvM/0R/oHL72T6Vurlar1cm8Q7IYevoOWCopNFI=
X-Google-Smtp-Source: AGRyM1v9GRItLGO0NnGY3JtDJRItJWeaCsgUSGiyjHvuYIi2OIAx399f5fn1YueSY+InobD1Z531rCGN5BEZbEbufts=
X-Received: by 2002:a05:6102:3d9e:b0:357:4526:ae58 with SMTP id
 h30-20020a0561023d9e00b003574526ae58mr7640346vsv.56.1657643312206; Tue, 12
 Jul 2022 09:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220706174253.4175492-1-yury.norov@gmail.com>
In-Reply-To: <20220706174253.4175492-1-yury.norov@gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 12 Jul 2022 09:28:21 -0700
Message-ID: <CAAH8bW-OcdzetthsBanbkObVQxF1J6CiyBBnab=VXd2wcj517Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] lib: cleanup bitmap-related headers
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
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

On Wed, Jul 6, 2022 at 10:42 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> This series unifies declarations of bitmap-related functions and aligns
> return types with values that actually returned. Also, it moves one-liner
> wrappers around cpumask functions into headers, so that compiler has a
> chance to optimize better.
>
> With this series, GCC 11.2 for ARM64 with kernel v5.19-rc4:
> add/remove: 15/7 grow/shrink: 461/164 up/down: 14844/-4580 (10264)
>
> This +10K didn't surprise me because  modern compilers are more aggressive
> in inlining, loop unrolling, and other techniques that increase size of
> the image.
>
> v1: https://lore.kernel.org/linux-mm/YsAzU3g2QpgmIGre@smile.fi.intel.com/T/
> v2: - Align whitespaces in headers;
>     - Make bitmap_weight() unsigned long consistently;
>     - Pick 2 patches from Ingo's sched/headers series [1] that split
>       linux/gfp.h, and drop my similar patch for it.

Ping?
