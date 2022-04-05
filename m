Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4084F50FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573317AbiDFBuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456320AbiDEQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:01:31 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9895313EFAD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:22:30 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 9so15563699iou.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUTUxfwx0BMlegLzejTeqPrh28XK1GfyeFHo2+PzHSA=;
        b=X/ggfC92FSIBBaIJoh4Lvf2OOxCHxifc1+KXsolz68JKkTf66vNMPiFv0uTbW3X+Tf
         MCWTL/SWwwjYkxJkqYzHr5nKXuxeQ2ITjuWzPSExmX/xC8cWsOEbmvFkpDYRaUfhHyjF
         YDuhAf4nBhRafZIn8gieNVZVSKekDKyUhpxYKncULsJxdUSIzmoZm1iJrwEa/WyoI0QE
         KkpHVKUW8usvg+8kVn+Z2s+7MMLsuGK6iV9Wd0j31rEPo2merxQ82OdhC1wIctLAeJuO
         VWjT3E/mBoFcavJc6nyq1omw2lBkJpB44ymHsBeFQsffZIdjl9VvqWhL581O44uA3Mwf
         +Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUTUxfwx0BMlegLzejTeqPrh28XK1GfyeFHo2+PzHSA=;
        b=fVrScaPYYjUXs0AWCQvrKqRQ6LvyZlE6GNYg/wWtUE5hd8ELjW5Z3MHq7QG9JXJb8Q
         3Jae/NEOTAAl0mBkX/AMM/6+CX+OUl8AnolgcnrTzpGIHQkqkha2d0nj+Vcqd38Ifg/r
         zdV0bbC90KWbDoTwXGBoZ4HDEtiqIq69AvUCzqG6VIpB6lZkN6B/3BKZfvoykhRlVXP8
         Dzo1g9/wH+Lmw/y0fLlALiZQRn+sAmnvz/d4RVYeZqD6KJenvVEh2GY1rs6qTAcqdHGg
         0qLrGpKQJoaXoitvTIsfJFhgRx1t1OKbp0yD30GAnOSLAHbBnGu7dP8B5RyZJDYxfT8A
         HjDQ==
X-Gm-Message-State: AOAM533plD2j+AeXR0/9I8zIYkao4Hb8U5tfqjvl6ZF+YjKQ5nsCqzSV
        Z9rTOy7H6SBzwIaXAhp/maXOMWX/1goo4I34KJw=
X-Google-Smtp-Source: ABdhPJxDUFQSp6D1AlpXJtxXe8348cZazMDEkUmEcoM1Vu4ZcFMv1Ssr3lWia7cZ321svVePcrIfn7/ykSnzvdg5K14=
X-Received: by 2002:a6b:116:0:b0:648:bd29:2f44 with SMTP id
 22-20020a6b0116000000b00648bd292f44mr1993367iob.56.1649172150007; Tue, 05 Apr
 2022 08:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648049113.git.andreyknvl@google.com> <f75c58b17bfaa419f84286cd174e3a08f971b779.1648049113.git.andreyknvl@google.com>
 <YkVzTbafttTHWETU@FVFF77S0Q05N>
In-Reply-To: <YkVzTbafttTHWETU@FVFF77S0Q05N>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 5 Apr 2022 17:22:19 +0200
Message-ID: <CA+fCnZekoAMEcS+0905JzP=Gu81R_F_em5Un8JL+FOF2Jj3rqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64, scs: save scs_sp values per-cpu when
 switching stacks
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Thu, Mar 31, 2022 at 11:24 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Mar 23, 2022 at 04:32:53PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Instead of trying to retrieve the SCS pointers from the stack, change
> > interrupt handlers (for hard IRQ, Normal and Critical SDEI) to save the
> > previous SCS pointer in a per-CPU variable.
>
> I'm *really* not keen on *always* poking this in the entry code for the
> uncommon case of unwind. It complicates the entry code and means we're always
> paying a cost for potentially no benefit. At a high-level, I don't think this
> is the right approach.

This also gives a 5% slowdown, which is not acceptable.

What we can do instead, is to not collect frames from the higher
exception levels at all. This would leave SCS-based stack collection
method impaired, but this is probably fine for KASAN's use case:
currently, stack depot filters out higher-level frames anyway, so
KASAN never saves them. And the lower-level part of the stack trace is
enough to identify the allocation.

Thanks!


> For the regular unwinder, I want to rework things such that we can identify
> exception boundaries and look into the regs (e.g. so that we can recover the
> PC+LR+FP and avoid duplicating part of this in a frame record), and I'd much
> prefer that we did the same here.
