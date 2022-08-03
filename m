Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C68E589338
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiHCU3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiHCU32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:29:28 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91E25B7B1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:29:26 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 123so30107733ybv.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8saFETww7GFwNaVKj2+9mgk73FWbmx4D6GhCwjyv5M=;
        b=dtquUVtEm7eDqX1KhcLh8OG00MYA9mSMXcpdMJAmFidFvZzAXptIdhxhQ9CDvUoxzd
         vU2nams+2CWA6TGpDhOXwF9jzfex88IXhKUPhevREfzcXVgK/lSzcKgHaLbTSoRzH98Q
         rxSLgycwNz21N88HbezJz6PPxhZEH9nLZ54Elmy4gTO19Xo5ues1xh9ivwU288T7Omli
         SlgkEIqVMn/Qko2uEeTHptGkLznvws+vwtK3WMCI7EATm7GDNYnwT7WIdMP9pXtU/wJ8
         YX+dOjm5ODwXpGv+Itz40X1uo4tzK5WdLxIS/2ibk9ju+OCNIamGs3uJAhyqHfEK7GdR
         T9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8saFETww7GFwNaVKj2+9mgk73FWbmx4D6GhCwjyv5M=;
        b=BhVlIJKh+QxvKj+6q/rWG3oCCJyTl0tdlcYiQW/foxHmZXjmoHsBjYNNY3X4PCsMNA
         Wor2tIHtYFy65N4mnrA8o5L4HYbXhOzFR8VT+eTp//zx/6a7p7+BdiQCbuGeVQEWePZ+
         PAlY71IMYyMuve3HF2hxTap7e0oxSERJc2959N8r7a2Ksc9unTRHm/S5qr2xmZFskgsF
         7aha54rzrEqYHw5B4TFztAglN/Zos4MViPO4UVVNmdOp4q10aKQs5KAr0/BzCIFX1CrD
         KIgMxAaVxacEMbt7h2SnAG2WMeu7KNL+nCaQsZ+aQlT+hhOSEl32FOikccAnvirwhaN1
         gVjQ==
X-Gm-Message-State: ACgBeo2+hDRoDjYH8015U8o3AwBcvgn3ss+z4J6NmOVnUielRpAvr5kS
        zUKX7RzOkM/fOwObZ+46atmFEJ1g+dugs/eT/hP5Dw==
X-Google-Smtp-Source: AA6agR41ikKlGdT1pV9DU6nb5ECl25sAkg4s266UVv0+QPmzjPHL/AlUslFveTN5siWHHR/tZQqOJjPCw28C/FfXiBk=
X-Received: by 2002:a25:2454:0:b0:67a:7426:25d9 with SMTP id
 k81-20020a252454000000b0067a742625d9mr3223631ybk.93.1659558565851; Wed, 03
 Aug 2022 13:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658189199.git.andreyknvl@google.com> <0e910197bfbcf505122f6dae2ee9b90ff8ee31f7.1658189199.git.andreyknvl@google.com>
 <CANpmjNMrwXxU0YCwvHo59RFDkoxA-MtdrRCSPoRW+KYG2ez-NQ@mail.gmail.com>
 <CA+fCnZcT2iXww90CfiByAvr58XHXShiER0x0J2v14hRzNNFe9w@mail.gmail.com> <CA+fCnZfU5AwAbei9NqtN+FstGLJYkRe7cZrYZN1wtcGbPkqVZQ@mail.gmail.com>
In-Reply-To: <CA+fCnZfU5AwAbei9NqtN+FstGLJYkRe7cZrYZN1wtcGbPkqVZQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 3 Aug 2022 22:28:49 +0200
Message-ID: <CANpmjNPk13ib57zFzL1rmWiuhZVvS4bmD-yfoMJOYVWT1FdynQ@mail.gmail.com>
Subject: Re: [PATCH mm v2 30/33] kasan: implement stack ring for tag-based modes
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, 2 Aug 2022 at 22:45, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Thu, Jul 21, 2022 at 10:41 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > On Tue, Jul 19, 2022 at 1:41 PM Marco Elver <elver@google.com> wrote:
> > >
> > > > +       for (u64 i = pos - 1; i != pos - 1 - KASAN_STACK_RING_SIZE; i--) {
> > > > +               if (alloc_found && free_found)
> > > > +                       break;
> > > > +
> > > > +               entry = &stack_ring.entries[i % KASAN_STACK_RING_SIZE];
> > > > +
> > > > +               /* Paired with smp_store_release() in save_stack_info(). */
> > > > +               ptr = (void *)smp_load_acquire(&entry->ptr);
> > > > +
> > > > +               if (kasan_reset_tag(ptr) != info->object ||
> > > > +                   get_tag(ptr) != get_tag(info->access_addr))
> > > > +                       continue;
> > > > +
> > > > +               pid = READ_ONCE(entry->pid);
> > > > +               stack = READ_ONCE(entry->stack);
> > > > +               is_free = READ_ONCE(entry->is_free);
> > > > +
> > > > +               /* Try detecting if the entry was changed while being read. */
> > > > +               smp_mb();
> > > > +               if (ptr != (void *)READ_ONCE(entry->ptr))
> > > > +                       continue;
> > >
> > > I thought the re-validation is no longer needed because of the rwlock
> > > protection?
> >
> > Oh, yes, forgot to remove this. Will either do in v3 if there are more
> > things to fix, or will just send a small fix-up patch if the rest of
> > the series looks good.
> >
> > > The rest looks fine now.
> >
> > Thank you, Marco!
>
> Hi Marco,
>
> I'm thinking of sending a v3.
>
> Does your "The rest looks fine now" comment refer only to this patch
> or to the whole series? If it's the former, could you PTAL at the
> other patches?

I just looked again. Apart from the comments I just sent, overall it
looks fine (whole series).

Does test_kasan exercise the ring wrapping around? One thing that
might be worth doing is adding a multi-threaded stress test, where you
have 2+ threads doing lots of allocations, frees, and generating
reports.
