Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7689577847
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 23:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiGQVMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 17:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGQVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 17:12:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A354D1054B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 14:12:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id k30so12949855edk.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UW6ne7NX/MQH2keCY1T28GqN5Odh8+bR3Y4JfckUjzw=;
        b=fGm8hQQ8eUxP06yf85F7pPFkaBx3O3yo1wK9DD4XbIeo2GtzbzmYzDExIju1C1a60R
         Dzv0oONPL/fyrzdC81wDNIz/pDLCzxAPalxwEibU19Ogw3dmD4kDZ0qJ6xELiZw4kP9D
         8KUm870xtTCqoYrYUBQZlFDq0IBMxvsinLQd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UW6ne7NX/MQH2keCY1T28GqN5Odh8+bR3Y4JfckUjzw=;
        b=dfQ9KaHcoHN0vRwglvRqwYP1rRVp7kWy2ONoLb5+YD+OA3Nnb9415TOmmMxySaryHr
         W8TweG2yZP7BIjESFCXjNEVtsG5TpHT/B4FPdclHz2ZKSyBL6NcSlYhJJR+B+vNCM/aS
         2PcNrczCm247EZZu9SY7LqRbgIj60hdQBS2ry3wqfg18QFov9kBnJwjU0D3u0P40d49d
         TNjbZYmpFqaWUX5ShE76wAVS9tB04LBr7KMajCnIS2qeAqoyJQScYQjaXjnRpR5g7JFs
         F3DtqUMSGu0lAC0ccWt82uqnjZnJVK6yndv5FWDp/aIVdeDuFr75AyGWQqU/UAcvq8kW
         trFg==
X-Gm-Message-State: AJIora91kkfcV6L2kk0byv7MP9rKtlZ9VG2vCrLDhPi3lK5LJKGqG00w
        e70yOvtm6JpgSgGoHFQ/X/EmaipeqalUIc7me1s=
X-Google-Smtp-Source: AGRyM1vUbXTXcajykRStXOTt9GqxGY5yE3m+6zRUN3PRNU+TyPJsX8D+QIE5c2X7mMYMmxXnj0908A==
X-Received: by 2002:a50:c209:0:b0:435:6b37:46cb with SMTP id n9-20020a50c209000000b004356b3746cbmr33527834edf.341.1658092329912;
        Sun, 17 Jul 2022 14:12:09 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id uz7-20020a170907118700b0072b6d93b9afsm4739259ejb.210.2022.07.17.14.12.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 14:12:09 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id r2so13544844wrs.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 14:12:09 -0700 (PDT)
X-Received: by 2002:a5d:544b:0:b0:21d:70cb:b4a2 with SMTP id
 w11-20020a5d544b000000b0021d70cbb4a2mr20297261wrv.281.1658092328759; Sun, 17
 Jul 2022 14:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
 <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com>
 <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com> <20220717205615.GC25951@gate.crashing.org>
In-Reply-To: <20220717205615.GC25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 14:11:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-6b_=XQbwKqEwuAbQCOcXx7_mw78-GopQ5==_TuTPLQ@mail.gmail.com>
Message-ID: <CAHk-=wg-6b_=XQbwKqEwuAbQCOcXx7_mw78-GopQ5==_TuTPLQ@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 2:00 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Calling mem* on a volatile object (or a struct containing one) is not
> valid.  I opened gcc.gnu.org/PR106335.

Well, that very quickly got marked as a duplicate of a decade-old bug.

So I guess we shouldn't expect this to be fixed any time soon.

That said, your test-case of copying the whole structure is very
different from the one in the kernel that works on them one structure
member at a time.

I can *kind of* see the logic that when you do a whole struct
assignment, it turns into a "memcpy" without regard for volatile
members. You're not actually accessing the volatile members in some
particular order, so the struct assignment arguably does not really
have an access ordering that needs to be preserved.

But the kernel code in question very much does access the members
individually, and so I think that the compiler quite unequivocally did
something horribly horribly bad by turning them into a memset.

So I don't think your test-case is really particularly good, and maybe
that's why that old bug has languished for over a decade - people
didn't realize just *how* incredibly broken it was.

             Linus
