Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D141474DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhLNWJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhLNWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:09:00 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40804C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:09:00 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y16so26824988ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP6csCLv+Ba35Rqxl/QI5p1YOyxnicuG22GVHFYUF1U=;
        b=Cc38oMKWk2brJxZDGoC8suov16Oq0YtG58O6cq6oiQTqRNg/SL4mIz90EmLVAnObiB
         T7MdVO+WibnifiPKGbqd2HGhMmcWOMEn2wfqt1mhmUPmVvzMluNpItXKYi7r4obpZ14+
         vEFYVpcIlu/68azAW/1nmUbUNTCpl7nYCIhSlSC4KANXjv8kfbJKMVYOKmujbfqthcLf
         W4/BnybqvyIUBWy+8dQwZfyl/Sc2sVvnLpTESUfTCtXCnh6Hl6KPPW8y2+aFdxUu66nf
         odPDm2tHTZN8EIG9pVT3cmkNAjRykGS+FWUaUZ2ew7iGjYi7CuY5sHtqr1yl4RqnBTd8
         mLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP6csCLv+Ba35Rqxl/QI5p1YOyxnicuG22GVHFYUF1U=;
        b=H31WvnDwEvaCeGJR8sovt/wc50IFtupgP5WzSdHfER0veTHCthP0J2//0UaNW2oTKS
         LvuJVeFqHd/Kd4WpmYrsNk9ozfGmBZj2DcwmJQpC2KhwzpeEL2NhMDlBrxAda5Txq2B6
         lmXy5wrduBgywUzFq+swZsKra60HBt1dBxEmCVV7Zz97VR3xxWbmzo9MHTpYunaI4Mu1
         l84B3fQdxnP3skOPGoqycYMUdBa4WavFJVa/YbFT4+mKvc5YgXoq54gwUAejgk/o7nKk
         8NcN/K0hfMmncIr+/5a0TvD8e0cTc+SnBdrPkHxua48/hX3BKWwZ0pVebd8OAaOvfHT6
         Sm7A==
X-Gm-Message-State: AOAM533wfDptVtyypFjReLCvdfu78HVriCRbD9aJSiIQGTS0EYo4Ng2b
        prEgtHNVZWlze0AgEBGgzVxMPTPCDBzmdgf1L3Q=
X-Google-Smtp-Source: ABdhPJwZpEx7lKlhd9sQu94o+KABcOC4exIObwhJKgQluloyoysImPofu+FfrETOdJsyEK7m/4nW5u+WBFq9eHEUhNw=
X-Received: by 2002:a5e:d502:: with SMTP id e2mr5381245iom.118.1639519739580;
 Tue, 14 Dec 2021 14:08:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <af3819749624603ed5cb0cbd869d5e4b3ed116b3.1639432170.git.andreyknvl@google.com>
 <Ybj2zms+c6J3J/pf@elver.google.com>
In-Reply-To: <Ybj2zms+c6J3J/pf@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 14 Dec 2021 23:08:49 +0100
Message-ID: <CA+fCnZeY+AEXrPyuWjq9yQ+HOsDxqqp-gw9scvEdLqV5v7q2dA@mail.gmail.com>
Subject: Re: [PATCH mm v3 29/38] kasan, vmalloc: add vmalloc tagging for HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 8:56 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, Dec 13, 2021 at 10:54PM +0100, andrey.konovalov@linux.dev wrote:
> [...]
> >
> > +     /*
> > +      * Skip page_alloc poisoning and zeroing for pages backing VM_ALLOC
> > +      * mappings. Only effective in HW_TAGS mode.
> > +      */
> > +     gfp &= __GFP_SKIP_KASAN_UNPOISON & __GFP_SKIP_ZERO;
>
> This will turn gfp == 0 always. Should it have been
>
>         gfp |= __GFP_SKIP_KASAN_UNPOISON | __GFP_SKIP_ZERO

Oh, this is bad. Thanks for noticing! Will fix in v4.

> Also, not sure it matters, but on non-KASAN builds, this will now always
> generate an extra instruction. You could conditionally define GFP_SKIP*
> only in the KASAN modes that need them, otherwise they become 0, so the
> compiler optimizes this out. (Although I think it does does complicate
> GFP_SHIFT a little?)

I can implement this, but I don't think a single extra instruction per
vmalloc() matters.
