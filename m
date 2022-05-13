Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5358D5260B2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379750AbiEMLIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245323AbiEMLIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:08:21 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366FE134E36
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:08:20 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2f7d621d1caso86112237b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JREMHrhRnmFXzY43T8lrU7YAoHvId1ic6AHyQlmWHr4=;
        b=jgU+agWozrb1Iq7qvHz+pWY/0Mhi1Ofby5FMgFiF/bU/yGxJSQJjUuNnG9tccTVIp3
         p1MOPGv1oewd6owpIyZL+v04n5lh99R1y4OcL2wMO1JezMI9rTrnvHjTrvlEDZjNj6el
         QiOl9R2uauDLODlhWxMxNhgZVf5MPqLxiWmsUOWh1wobGvy0Y6XAilfCRgav+H7BPD4m
         PZVJWYcUrVlpicrq1vfCzgzHHF8tgQ/flODi1ap93VdfyffUqGhTZt3XHkXPihLJdTcw
         9GYuJZN188L19XciJY7d0IqjnU8oeacAM9ufz6FazRLyPsmfm3MZciFwPkA6qb/uIIRk
         RmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JREMHrhRnmFXzY43T8lrU7YAoHvId1ic6AHyQlmWHr4=;
        b=RP0UxaMIKVDhb3dFyc71xIA9/o8RRIoyRAtwMkvDrVUOp7KJXdpclZhxokeGAIRpDt
         N2k+KLeHWlMB4TcaK7KhWdRtbsLWYjE02r0R9tU8s2bN5oXOYQY6Cn/TI/JSHRZXyuzC
         IBMbD8L4MPvIDPQNEkIKOzttGVoJiNnI9LWFmiPpE7c00/3wuepEnyNtkngekF8EsO3K
         +9AKKdMKCstydmypFzbr35ePeGdAaJHmHaQ8JoOvo/YKmKDMRYvvbdP5IrDZPycgcPxu
         ueJZVSqVBaaXM8BHw9jNjbvTsU88Gru3bhMIbBCDTjG56nSQv3bAjdwBG6k0GijCzdQ0
         eCTA==
X-Gm-Message-State: AOAM531+nEw3Zh4A0WXHR0djhyr8WDVYoIUcyS5GekDPKJ5+If23m9gN
        kt2X6uDZiZBlGIqY8Zb3Wt4YYBH/TIO8gsCzSWKJgA==
X-Google-Smtp-Source: ABdhPJzGOBX3yenemlairB/CBb3881W/vk+vs+5T3k6dV0sbJPG/UpCVQPhZN0hRrMn+P6ETO0NZVzhTFO/wYJy6FgM=
X-Received: by 2002:a0d:f0c3:0:b0:2f4:d291:9dde with SMTP id
 z186-20020a0df0c3000000b002f4d2919ddemr4969992ywe.437.1652440099204; Fri, 13
 May 2022 04:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx> <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
In-Reply-To: <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 13 May 2022 13:07:43 +0200
Message-ID: <CAG_fn=URUve59ZPWRawW+BN-bUy7U3QmFsfOz_7L8ndsL4kQFQ@mail.gmail.com>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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

On Thu, May 12, 2022 at 11:51 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/12/22 12:39, Thomas Gleixner wrote:
> >> It's OK for a debugging build that runs on one kind of hardware.  But,
> >> if we want LAM-using binaries to be portable, we have to do something
> >> different.
> >>
> >> One of the stated reasons for adding LAM hardware is that folks want t=
o
> >> use sanitizers outside of debugging environments.  To me, that means
> >> that LAM is something that the same binary might run with or without.
> > On/off yes, but is there an actual use case where such a mechanism woul=
d
> > at start time dynamically chose the number of bits?
>
> I'd love to hear from folks doing the userspace side of this.  Will
> userspace be saying: "Give me all the bits you can!".  Or, will it
> really just be looking for 6 bits only, and it doesn't care whether it
> gets 6 or 15, it will use only 6?

(speaking more or less on behalf of the userspace folks here)
I think it is safe to assume that in the upcoming year or two HWASan
will be fine having just 6 bits for the tags on x86 machines.
We are interested in running it on kernels with and without
CONFIG_X86_5LEVEL=3Dy, so U48 is not an option in some cases anyway.

> Do the sanitizers have more overhead with more bits?  Or *less* overhead
> because they can store more metadata in the pointers?
Once we have the possibility to store tags in the pointers, we don't
need redzones for heap/stack objects anymore, which saves quite a bit
of memory.
Also, HWASan doesn't use quarantine and has smaller shadow memory size
(see https://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.htm=
l
for more details).
Having more bits increases the probability to detect a UAF or buffer
overflow and reduces the shadow memory size further, but that one is
small enough already.

> Will anyone care about the difference about potentially missing 1/64
> issues with U57 versus 1/32768 with U48?
I don't think anyone will.

Having said that, I agree with Dave that it would be nice to have an
interface that would just request the mask from the system.
That way we could have support for U57 in the kernel now and keep the
possibility to add U48 in the future without breaking existing users.

I also may be missing something obvious, but I can't come up with a
case where different apps in the system may request U48 and U57 at the
same time.
It seems natural to me to let the OS decide which of the modes is
supported and give the app the freedom to use it or lose it.

--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
