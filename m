Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAFD591AC5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiHMNsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbiHMNs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:48:28 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF214E00B
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:48:26 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id j2so3323060vsp.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Pz0X7r9P4fhORa6zQ8l+OIP4Zf/9buvW1VqePCB+roU=;
        b=aj8OEhNk+V/JANxmB9A/j7wqya96NiL396PG4ARekLXiaEDwJbeFnyeYxFI89dj/lR
         oKQClqTYUMAacFFP/ZfqLI20xUYrHBwo9cGQ0spap6cSdcT+pTnTsHSoxSbc0mqycCS3
         MYquuwJhYq3X34Z6B3Wk8QIoAWHgbtaHI8jcWb0+8ODXPi8shafNKaKBgY2Z96SFR9sR
         qxBMdyDh+SuB0Hxq7RVkX59jRkSsncS2KzmuGg2y71oe14VFh93/2WBYkW1Bf0ErvUGJ
         dNTGfk6w4fa7H8URKgtRUtnKvajkSZIhtisiZ7sopIARdiw4eHPEIbJRlaHxydUXC0yK
         Zdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Pz0X7r9P4fhORa6zQ8l+OIP4Zf/9buvW1VqePCB+roU=;
        b=e2BmVTmx3guSDsFKMZRRU1lhnEUwQQD+HC/VRXtOgRfy3p1Nv3FeJMHKM3pRPbFp8A
         El4sbv7ZI6Lq5UHzmOqIK3pxUPDKqZkhIOmRt9vDgT03gL75L+R5vt9oOFON4CRu7ZI0
         xDjRGFMMi2s2ZvH/94hgsIm0xmqAEa3GupUhH0Rb0q5WN1pFxi7hDvtA0xnWubRauye3
         8lg9eYckP1b+OpPJZgucq2Nk/SCYJ1NUZxlxqou6L8i8uRKPV5J2jFKiTKlF9w62egIB
         TmwtX/uDSgodcbBsLQ0BMSRjzF0kcVihZPagu0vpOLqa/zycnsF9KNuUrzNm6cSR/nn7
         B4Cw==
X-Gm-Message-State: ACgBeo0LkyqR7t7DCw5HtCGjS85mnG/vErJOLhOcN8HRZq2HPk2FQanq
        kbU1kS2P8T31CdgmTWTxZbB21rj4XCWerHwQ3M4=
X-Google-Smtp-Source: AA6agR6fwUCl4kg77JXPI38Qfb6+78rpDkYFRB8I6BHrC6LVPBywck+CWGO00d4pd9+LA3QSeVYczLEkuLOckahyH5Q=
X-Received: by 2002:a05:6102:300f:b0:383:c534:a3f2 with SMTP id
 s15-20020a056102300f00b00383c534a3f2mr3367810vsa.60.1660398505819; Sat, 13
 Aug 2022 06:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220711044711.466822-1-yury.norov@gmail.com> <20220711044711.466822-6-yury.norov@gmail.com>
 <20220729034638.GA2276915@roeck-us.net> <20220813131523.GA2787704@roeck-us.net>
In-Reply-To: <20220813131523.GA2787704@roeck-us.net>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Sat, 13 Aug 2022 06:48:16 -0700
Message-ID: <CAAH8bW8n+6-4fGYp-g_vXe3XKwC5AV_hCCyzj=h2Wx1XFBK5dQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] lib/nodemask: inline next_node_in() and node_random()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Sat, Aug 13, 2022 at 6:15 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Jul 28, 2022 at 08:46:40PM -0700, Guenter Roeck wrote:
> > On Sun, Jul 10, 2022 at 09:47:11PM -0700, Yury Norov wrote:
> > > The functions are pretty thin wrappers around find_bit engine, and
> > > keeping them in c-file prevents compiler from small_const_nbits()
> > > optimization, which must take place for all systems with MAX_NUMNODES
> > > less than BITS_PER_LONG (default is 16 for me).
> > >
> > > Moving them in header file doesn't blow up the kernel size:
> > > add/remove: 1/2 grow/shrink: 9/5 up/down: 968/-88 (880)
> > >
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> >
> > This patch results in
> >
> > Building powerpc:allmodconfig ... failed
> > --------------
> > Error log:
> > In file included from include/linux/nodemask.h:97,
> >                  from include/linux/sched.h:22,
> >                  from include/linux/sched/mm.h:7,
> >                  from arch/powerpc/lib/feature-fixups.c:16:
> > include/linux/random.h: In function 'add_latent_entropy':
> > include/linux/random.h:25:46: error: 'latent_entropy' undeclared
> >
> > and many more similar errors when trying to compile ppc:allmodconfig.
> >
>
> As a follow-up on this: The problem is still seen and now made it
> into the mainline kernel.

I submitted the patch:
https://www.spinics.net/lists/kernel/msg4468633.html
