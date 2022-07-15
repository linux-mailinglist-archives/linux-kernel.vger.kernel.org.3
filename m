Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298645758F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbiGOBEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbiGOBET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:04:19 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B1614D10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:04:16 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10bf634bc50so4578778fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DyAmjn1tfyLJ1+MZi8YDqDhzALNsQ4q0fCyYaxrq/jA=;
        b=l9NlUUrsp6rSwCAygSBrXAux2+uiGAlfWzuy1x7pOMa0BgEKbEQeNEJ9QbCKxC55t6
         a/Q/ach264tEk3U/YQYqMhieQz0LM7my3mj4iQCVM+1rCyYezU1EWdGOgugYzM/7F2TC
         f06+Dp7DnsbbvZu9hPcnsH75j3cHBxMT35oBBN7W+h1lABCLZPRTP0G3ob0QczEaMLCZ
         zAN3g09XW4eWXB6Kh7uc9WVcTXj1OfQFER3W8HQw/jDm6Wu2RWUQuBWpqlN1hLmiNKEM
         EZa5QSZPzcekkL7vDQmS3eJIsM/7Zs7DRF4RQF8lDQOIpbsyH/3BcX1icfLsJB1hpfE4
         dq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DyAmjn1tfyLJ1+MZi8YDqDhzALNsQ4q0fCyYaxrq/jA=;
        b=5alpKPbpm5X6Zrt3Fovc7fGqZC6ybytwM9XxRHHURSy42uOe2BValmwwOr7814LI8y
         DS5/9s8k3DRbBdjw8nueCp9x8dRmx+svUcQGSiUmRyWYHRQkmoHlhcsQ3v3h4xBxXi4g
         UbHcqaw3wqzFXeXO3xJnrGQi5SRqBrweCdQDsPMD3lk8pqm3GcB/a1FLaHDATDqXgEcI
         VaG9xYRIDHNvzqRxM8Ck2EKhJ87OJlk4pvGcYR8fGIMOTS3YhvI7KEsiMLzaVXZswyvY
         42BX6DgqK+WkEaAQZx2Rbgnb1Ss3VeWESHSMp2/8HqLQ/iWmBXtrbC6XVGW5vSvFBdbJ
         +ZzQ==
X-Gm-Message-State: AJIora/baOX51P9VBwKwJ7KwXDNQoahDX07C5q/AVX//QTcSNW0s9XGP
        xvx/cbqSYM1xqJB7MPEh3IQ=
X-Google-Smtp-Source: AGRyM1vm0kFOBqyfsKpIn1FWiDINsjFmNuybOAV32x1xaoO8FUwPyOPuVDzHr0Aymwdxvy4Hw2l7JA==
X-Received: by 2002:a05:6870:d1d2:b0:10c:d05:7588 with SMTP id b18-20020a056870d1d200b0010c0d057588mr8949333oac.180.1657847055894;
        Thu, 14 Jul 2022 18:04:15 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id l12-20020a4aa78c000000b0035ef3da8387sm1275519oom.4.2022.07.14.18.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 18:04:15 -0700 (PDT)
Date:   Thu, 14 Jul 2022 18:04:14 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH v2 0/5] lib/find: add find_nth_bit()
Message-ID: <YtC9Dszub85NuABB@yury-laptop>
References: <20220711044711.466822-1-yury.norov@gmail.com>
 <CAHp75Vf8EhRYWdQN6Oc79GzWCvo-sRJDvy7_Aek_Z63GCu2dMQ@mail.gmail.com>
 <CAAH8bW_RYG_Tbpip=BkSFAymDm2y3jJBqTi0PJWA=H-a-L_3tg@mail.gmail.com>
 <CAHp75VcQq3wmwmpaDtu6HC2yrK4rWp+4HOcqMaOHQ3EQQ0c=DA@mail.gmail.com>
 <Ys4j+graZRVH8RO2@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys4j+graZRVH8RO2@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 06:46:35PM -0700, Yury Norov wrote:
> On Tue, Jul 12, 2022 at 08:28:42PM +0200, Andy Shevchenko wrote:
> > On Tue, Jul 12, 2022 at 6:26 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > On Mon, Jul 11, 2022 at 1:55 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Mon, Jul 11, 2022 at 6:51 AM Yury Norov <yury.norov@gmail.com> wrote:
> > 
> > ...
> > 
> > > > 2) fns() is not good abbreviation, because among ffs (First) and fls
> > > > (Last), fns would be read as Next, which is misleading, I'm not sure
> > > > fnths(), which is correct, is good for readers.
> > >
> > > I agree that fns() may be confusing, but fnths() is even worse to me.
> > 
> > I also think it's not the best choice.
> > 
> > > I expect that it will be mostly used indirectly via find_nth_bit(), and
> > > will not create a lot of confusion for users.
> > 
> > Perhaps in that case we can survive with something else? Naming is hard...
> 
> OK, I'll move it to find.h and call __find_nth_bit().
> 
> Is this the only issue, or I'd wait for more comments?

I looked again, and I think that the structure of the code requires
to have fns() in bitops.h

Just because we can't think out a good name doesn't mean that we
should break existing structure. Let's keep things as is, and if
one day we'll find a better name - we'll rename it.

Regarding this:

> > > I expect that it will be mostly used indirectly via find_nth_bit()

It's not too important what I expect. For available functionality it's
much easier to find a place to use, and breaking people from doing it 
is silly.
 
> Thanks,
> Yury
