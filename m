Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5C59DC9D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354433AbiHWK1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353952AbiHWKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:12:20 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D937B2B19E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:58:43 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3321c2a8d4cso361813287b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=m5qgqqFpqA6eOgQn4O8247QrJrav2qzsMmpmi/SnFuE=;
        b=i9OHop8RyO9zg6AiErKW2wooPRB8ZRjrAFyFzN03hcvpDNJLYZ2HwIUe8SYMfme3fT
         8f1iUiI6YR2v632HdWZ1ZJF9dhjmecGB5IM9YlTP7quv65nWIZIh19aaI6DrDJfw4JLZ
         zEO2jZDQRfJhncwfceQWEgIGLkzGtaYVfuXWe/oALbyKO48RziMymUOpSU48uwm4sxD6
         vtPzLVl2fMVXH6UdMtI8Zt1QUq3t7W7H0dcOHDymMFQ1nK08OEyo/CGGej7U6Drpg80d
         AkSI5iMH4vHqHIIYEOH7aAyb0/uVXZsgpSrEwyghkEr8TGR6aNxL87tLDUorqwQ4r/ux
         dTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=m5qgqqFpqA6eOgQn4O8247QrJrav2qzsMmpmi/SnFuE=;
        b=4zEx1QITKbaScel3Hs4HYYrUuycMjL8WeV35wNStBd3ZmOe3qLhGKPgeybwE6fW3Fs
         6ZzKddE/graS2gY6Rdn+P6RqBzDDXcoUGtISwGi65amp7JxN3lPf6JVqYAkyoucEHWmM
         5yVDkh6eQzKTn68uV1VvtiB2M0NivTIalSf2BoYhe9sRfcr9pyJzd7HB9IO6JYAnRLYr
         vAaP58ERJivusbn+P5WrT8Y7suzDKzG7T4paJSyoXW3Q1sRnkiD7AwVznyOIQVR/KwN7
         nXxlbTuy4Fc1xOBRQTfZgJnBv/hiJvwWYBwOljWjOZf7LZDFmyRfuCCBJ8Fpwm2MIbnU
         ob5A==
X-Gm-Message-State: ACgBeo36x8vdqBGZ4+/xVMxSVcT/QdGkIv1+GKieGf7p4o0oOrr/sEMP
        nWjPKFC+8TIh6oClUYg5sMlPpZHGgbcTMkxiWDepnA==
X-Google-Smtp-Source: AA6agR7xmuJFAP+rGE/67ETVeD9dm4lCQyCx2YDiGRV15JuqADdedKk2xu3EcUZ4pmbLSKy6CJ9UfRlpAgdIlWb1EZA=
X-Received: by 2002:a25:bc3:0:b0:673:bc78:c095 with SMTP id
 186-20020a250bc3000000b00673bc78c095mr23017612ybl.376.1661245122544; Tue, 23
 Aug 2022 01:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com> <YvpNlqnxRkeZ/Tfi@worktop.programming.kicks-ass.net>
In-Reply-To: <YvpNlqnxRkeZ/Tfi@worktop.programming.kicks-ass.net>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 23 Aug 2022 10:58:06 +0200
Message-ID: <CAG_fn=XA08N+rnpebvXpRHwXJXBtaWNODJ_h0xhGxnsFSykF+A@mail.gmail.com>
Subject: Re: [PATCHv6 00/11] Linear Address Masking enabling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 3:43 PM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Mon, Aug 15, 2022 at 07:17:52AM +0300, Kirill A. Shutemov wrote:
>
> > Kirill A. Shutemov (7):
> >   x86/mm: Fix CR3_ADDR_MASK
> >   x86: CPUID and CR3/CR4 flags for Linear Address Masking
> >   mm: Pass down mm_struct to untagged_addr()
> >   x86/mm: Handle LAM on context switch
> >   x86/uaccess: Provide untagged_addr() and remove tags before address
> >     check
> >   x86/mm: Provide arch_prctl() interface for LAM
> >   x86: Expose untagging mask in /proc/$PID/arch_status
>
> Over-all these are not terrible.. I've replied with a few nits; with
> those fixed:
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>


The patchset is green on the LLVM buildbot:
https://lab.llvm.org/buildbot/#/builders/169, so my Tested-by: tags
persist.
I'm going to make minor changes to HWASan runtime to accommodate for
the new arch_prctl().


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
