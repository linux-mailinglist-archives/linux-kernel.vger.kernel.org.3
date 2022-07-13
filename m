Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84EC572B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiGMBqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiGMBqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:46:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB4D2155
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:46:36 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id i21so9560964qtw.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yrXtUecsmBg0K4L1DUREg8dlroAqnP1q7zD25CeSLTo=;
        b=UCAgNpWtV0pjlqA0EsR1TRQee1COJiv6CTfG334Z/15eK8FXww1AGoVkAuYpx3M8zm
         gHJoTHs+vNK7aF/fFWrKQ0qeKW2071nRBGdkdfXF2nGPBuVoySEd/zKG5V/FgNEyigvF
         huQHR/ELQsOS6Gld8+c9sd9hZ+T6s6OVVdkHplcRKCMsCixlSp0Y1oT683Lm90UVRndZ
         TboD4zlY3bLUXxDc3qj5r8WPoAHzU17kyguZQWvfRefBQiuMZz8NuDJA8EVYklRDM3cO
         3iqjoIxrWm2j4x+jrR3muXhkBi3vPAr0Xod2VwuR0YcAq9ektqm14w90AdSXYXmEVXbe
         j9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yrXtUecsmBg0K4L1DUREg8dlroAqnP1q7zD25CeSLTo=;
        b=jZ2x0uQgqzJqD+d/fCfjcsOrjHv1w0a4rf0NvRdZ4LHl7to4pbTEJ43XI46JSHwaNg
         TDUKRaNbzhPx0IIFKciMTca1KBafGwOCQLq7IdQ2rIruyu1HVm5fcmtx2/kCFYFtjjEV
         go9OJSVU7DASMQ02tinC4v6Md3eRy5l7t1jf9krxOXafufMaSfpaGNryq4rwklaZ7rP+
         6fvG5fkzPrZ1C7IuADl4ynIsghguFGsesA1QBZyS1vm3Gd3sGzlYTRFd1mMb4CunjNPK
         p3q40EC8DItZtWSbv6/XEfps9K8VHoKsXKHyFRNqwSyQbcHypxgSE6ObSfU56FYQe2mT
         RWFA==
X-Gm-Message-State: AJIora953mbxrTL7Jl/fHEP1TohGNGytPCwd3vM9HFHEjQHljSnlt9MF
        VBFQzt+38YMBUfTY6SDt0aw=
X-Google-Smtp-Source: AGRyM1sdH714eDcooDa84IOTM+iYum1KsaHrSnmyJwSY0ba0ykZ5/mdGk+9SFyvj4lpFEEHdWki/CA==
X-Received: by 2002:a05:622a:588:b0:31e:b37d:b93 with SMTP id c8-20020a05622a058800b0031eb37d0b93mr900093qtb.461.1657676795605;
        Tue, 12 Jul 2022 18:46:35 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id o4-20020ac84284000000b00304e5839734sm8447639qtl.55.2022.07.12.18.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:46:35 -0700 (PDT)
Date:   Tue, 12 Jul 2022 18:46:34 -0700
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
Message-ID: <Ys4j+graZRVH8RO2@yury-laptop>
References: <20220711044711.466822-1-yury.norov@gmail.com>
 <CAHp75Vf8EhRYWdQN6Oc79GzWCvo-sRJDvy7_Aek_Z63GCu2dMQ@mail.gmail.com>
 <CAAH8bW_RYG_Tbpip=BkSFAymDm2y3jJBqTi0PJWA=H-a-L_3tg@mail.gmail.com>
 <CAHp75VcQq3wmwmpaDtu6HC2yrK4rWp+4HOcqMaOHQ3EQQ0c=DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcQq3wmwmpaDtu6HC2yrK4rWp+4HOcqMaOHQ3EQQ0c=DA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 08:28:42PM +0200, Andy Shevchenko wrote:
> On Tue, Jul 12, 2022 at 6:26 PM Yury Norov <yury.norov@gmail.com> wrote:
> > On Mon, Jul 11, 2022 at 1:55 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Jul 11, 2022 at 6:51 AM Yury Norov <yury.norov@gmail.com> wrote:
> 
> ...
> 
> > > 2) fns() is not good abbreviation, because among ffs (First) and fls
> > > (Last), fns would be read as Next, which is misleading, I'm not sure
> > > fnths(), which is correct, is good for readers.
> >
> > I agree that fns() may be confusing, but fnths() is even worse to me.
> 
> I also think it's not the best choice.
> 
> > I expect that it will be mostly used indirectly via find_nth_bit(), and
> > will not create a lot of confusion for users.
> 
> Perhaps in that case we can survive with something else? Naming is hard...

OK, I'll move it to find.h and call __find_nth_bit().

Is this the only issue, or I'd wait for more comments?

Thanks,
Yury
