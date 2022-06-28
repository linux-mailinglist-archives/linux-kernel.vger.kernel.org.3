Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7672055E429
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbiF1NOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344658AbiF1NOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:14:36 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0DFD21
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:14:36 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id o4so8109501ilm.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsbdvFQeUqASiOkCBKpg+u5M35Pu57mB+0bBgUEwlQ0=;
        b=e3IN4akWLzaub9ywIDYCYrfEyGuFBmMblSI41OFofhQ4XvQEGGqcB/NQAP1fb6z2FH
         1d94xUlOJ6n7jq3jhTc3C0CGfSjMuQXczYG9alx8yvCp++pzOQidiV3DMyN6MpjiCY0d
         akT4G0JYvOCKNsQG7ifLR7msuI1KDvYNs8pM5qnDqageC+k4nwa9SCbZEjlk4dc8Egbk
         vVym9uL5msvGncCMZWfqYwOopOTYjHZvoj91GGuFWNrJ3h02UkrLIRTLj5ziGF/gjtJD
         AxmLiKNyx+ozU5LircPBJ8VtDgNHK+whPKrC6v6+GLd3oN3rIVbgEPz9s8DiOrPtMhsy
         Cytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsbdvFQeUqASiOkCBKpg+u5M35Pu57mB+0bBgUEwlQ0=;
        b=XLWL36GD8xcoPX2531nIRvUAXCV4gJMDLg81ceJ1yVyB5wqpqUhtChd+MhQlXSLAQ6
         mKEHzwCep428+spGuRGdbrfBWzyi+ytztkbqjvAjg+gOIUFC2WRq6SfVhMxnr5lLdG34
         SGC7RKJ9uClzkzuNswQiGEnOzYyyq+rrQSTpKDi7fPkt0Co78qrzDFzQptH5s/Dy9LRy
         S0RZ29MeT6sdI1b9WJwhJuKE1iU5GmFIUyBKao4Lan8fC9qsaRqVZZYvSGL06MTuVp4+
         iF6gZ5BOyF15E65Rhjz/chWoTLRExsWBvPIYBuLL+04sk/IfwpbmcMMI+vCpIHGK30hO
         QJ8Q==
X-Gm-Message-State: AJIora8s0NOsiecIR99bzQC4RuXsZszu8hGFYfh5n4o7jzUxxpJ56S51
        JCpS4xAGgtepgejZc7XeEPq9lclqk/UX+wVj+xoORMHL
X-Google-Smtp-Source: AGRyM1sOpei4NsJ6JnrkAst+YjmOz4L2eLYJccjSpETHJn4R/guuke1HkZCCXUymIogME5FE2tvh3HHL7fVBc2rZZbs=
X-Received: by 2002:a92:b10e:0:b0:2d8:d8a7:8b29 with SMTP id
 t14-20020a92b10e000000b002d8d8a78b29mr10510693ilh.233.1656422075643; Tue, 28
 Jun 2022 06:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <c4c944a2a905e949760fbeb29258185087171708.1653317461.git.andreyknvl@google.com>
 <165599625020.2988777.9370908523559678089.b4-ty@kernel.org>
In-Reply-To: <165599625020.2988777.9370908523559678089.b4-ty@kernel.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 28 Jun 2022 15:14:24 +0200
Message-ID: <CA+fCnZcLsGVpP_bJ=OLkPe=DXwAzyzv2eS2jsMv9RZV58sjGZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: kasan: do not instrument stacktrace.c
To:     Will Deacon <will@kernel.org>
Cc:     andrey.konovalov@linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com, Alexander Potapenko <glider@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Jun 23, 2022 at 9:31 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, 23 May 2022 16:51:51 +0200, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Disable KASAN instrumentation of arch/arm64/kernel/stacktrace.c.
> >
> > This speeds up Generic KASAN by 5-20%.
> >
> > As a side-effect, KASAN is now unable to detect bugs in the stack trace
> > collection code. This is taken as an acceptable downside.
> >
> > [...]
>
> Applied to arm64 (for-next/stacktrace), thanks! I had to fix conflicts
> in both of the patches, so please can you take a quick look at the result?
>
> [1/2] arm64: kasan: do not instrument stacktrace.c
>       https://git.kernel.org/arm64/c/802b91118d11
> [2/2] arm64: stacktrace: use non-atomic __set_bit
>       https://git.kernel.org/arm64/c/446297b28a21

Hi Will,

The updated patches look good.

Thanks!
