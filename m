Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634F857CB83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiGUNKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiGUNJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:09:51 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5835820E5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:09:38 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i14so2691917yba.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=helfzrGgYuErFKUHoxu4xJhqLDpOC/RmZFHNZgYAfKo=;
        b=Sx7jP9r3YT3aPeole6+tZCcgCvZuqY0xN8mk9Rs/YHsbEZEmuao10TL3q515Af3tiA
         Cpw8+dZf7N0JnqL/ajolRjAktRS3LoWpZXs6TumaSiAJJTBJVDz88L9NII3YYgs3HqL9
         oRjxaPFtsimYccxZ86AgGhd9ZctW6b5QdURBi8TEZs0QQZgBPb8I32AWEJB2W9JdXb+v
         eftfmyRYN9EbQ0uJ61NqGaNRNt4GicrX2Fo8J9IlzONDsZuhaROt33+0ePSmN+yoc3Nw
         nVf+ZjCLYKd8PoH29GixFdzeTo+2EpP4N6ZoTnF2QWQiNvjR/uXvkARnOKaIqg9M1koe
         DQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=helfzrGgYuErFKUHoxu4xJhqLDpOC/RmZFHNZgYAfKo=;
        b=B2dPQ3k8jwWMF8dVO2Emh+8vnXVWvUlZJnHGIiFtcOGquJh0UrdyxRrriU/Z05dEZz
         CYvvq15nNiZ/4W29+aFW4qEgdyCOWt/dNJCnviO4AZ1yWQvaPo92KXhoAVhh7Qo7KK0G
         jYWZmZ/0kLuemwG7RlCXw27K0Tk6NuO0kcfzjdIbkFQOrWxoH0HffgXvGwuZyQ/Jd74q
         pkZzBq/O+ywMiP9HNHr9ILPAeAYkk3VT/kfQq8G7Hy42v344DosTt5bxdzyjBhUPC0c9
         e3AyOpaBjvSzCWVxs8Hh7FIs/I1w6KkR2d5VtxckNCwUpl5vzV9m3Y8R+2m8cxldxRx+
         +E2Q==
X-Gm-Message-State: AJIora/Qu/4ljVkraaH/wY7wzN+ikCChpGS8/ZRP525/OSnj/Gi9Hyoz
        oFqva9i5lpErewbJfYy7Uj0a7n8iDZovjt8MZLlHQQ==
X-Google-Smtp-Source: AGRyM1u2HXBoOdDRhhWpXvxbBfK5Qjy2aPfjbJTF/wn9rE9BeDWtwoRKtyLesAGosnz5RfL4p6l/+HIIEIXzWJv04FU=
X-Received: by 2002:a25:3491:0:b0:66f:a7f5:f5dd with SMTP id
 b139-20020a253491000000b0066fa7f5f5ddmr40578478yba.274.1658408977145; Thu, 21
 Jul 2022 06:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
 <CAG_fn=WR3s3UMh76+bibN0nUpZk9AS_M18=oxP+pc_vtqKt34A@mail.gmail.com> <20220720005950.fonulr4kkwbh6kbz@black.fi.intel.com>
In-Reply-To: <20220720005950.fonulr4kkwbh6kbz@black.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 21 Jul 2022 15:09:00 +0200
Message-ID: <CAG_fn=W92Ug+=pS2SPZcSaEWSOagTE99TGT8Hi-KRxYdFzbonQ@mail.gmail.com>
Subject: Re: [PATCHv5 00/13] Linear Address Masking enabling
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 2:59 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Mon, Jul 18, 2022 at 07:39:22PM +0200, Alexander Potapenko wrote:
> > On Wed, Jul 13, 2022 at 1:13 AM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > > 64-bit linear addresses, allowing software to use of the untranslated
> > > address bits for metadata.
> > >
> > > The patchset brings support for LAM for userspace addresses.

For what it's worth, there's an LLVM bot running basic HWASan tests on
QEMU with the latest LAM patches here:
https://lab.llvm.org/buildbot/#/builders/169
So far the bot is happy, giving us some sense of LAM_U57 support being sane.
I'll add some tags to individual patches.
