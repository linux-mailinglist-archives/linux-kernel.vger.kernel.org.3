Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBE588335
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiHBUrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiHBUpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:45:41 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35E81147C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:45:38 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f14so11573402qkm.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kGCFQktL9LEp0y8IboY5IhTEHaLuC/gj8xxem3T8C/Y=;
        b=qbPlwMtMO5h/PDQTD8omxj4fSd7e7PJsjjKJOHmg6R8Y6RwqvKQtLeDFdaUz7pKZH7
         b97h1eWAK77yYBaSl8vDfywpavsYhldW93mZi8CqRdUlnjKyeLQ+fIOVrk/PF3KEVSgX
         TOoGLjsfn54mSJesiRUE07L8lhbBGwGbqjQsri2+AE56hIeM0W4KgWTQf3nbCvDt3BPG
         O3XK6HrtsOAhjoNfeO6aWc2YD7T2pzNIig11vNuREQeuVq1YW/CQiaHeNk8c3xbg+liW
         Ic61OcBVAgXD4+URBD3+Id0NMZr+1CKA4OG/rUlpbbMOCtafkqYdcgjRpmaxgFS6zo4v
         De1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kGCFQktL9LEp0y8IboY5IhTEHaLuC/gj8xxem3T8C/Y=;
        b=YQ1mBc0q4dd8iUpcoERe8y7lH1GRzDWtWzFaZ2B4mek/P22Qxj+Ty892K7QSfpUJ4n
         /FvfVbk38mg6cWpa79kvcK+vuMIvZuykI/5tSAV6vhy85MbKy9cOSDpxjogeRpZQI0KE
         6GRMEXLaY1xinxbvSyHZTndxJu64ysb/tIiLcQ0+FRouOSbn4R2Q8QKWOK2RnKVQf4QS
         oWsUj3WVjokhvlnyIw60vC2KQs0fAqL0LcGSeFhFsffjaQ0LGyQKCsjWXWZawxkS6jqL
         zXQtLqoLKcMJnhsAJSA576YbldlNu6lO0ViB8kkFIKfXZr1eBkPG42K2b3zUkvyif6MJ
         Rekw==
X-Gm-Message-State: AJIora/MPO/SnlBjdqEsv39hmhpP/gP8KD9bK59WWjT9JIDE419VEEZ9
        37E4FDs1rZ0V2I+UIT7NBK4pNwZCn6YJdI0qaWa0dyahN9M=
X-Google-Smtp-Source: AGRyM1umKJtNCrs4hrfgwN7muG5bVwvcpGitnzHL6ZwMvrU+pP803PG5HaODUCUcvMiIZjeqUwDAGyAObHQdJMFB6yk=
X-Received: by 2002:a05:620a:f93:b0:6b5:c8ff:d2d8 with SMTP id
 b19-20020a05620a0f9300b006b5c8ffd2d8mr16640819qkn.386.1659473137334; Tue, 02
 Aug 2022 13:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658189199.git.andreyknvl@google.com> <0e910197bfbcf505122f6dae2ee9b90ff8ee31f7.1658189199.git.andreyknvl@google.com>
 <CANpmjNMrwXxU0YCwvHo59RFDkoxA-MtdrRCSPoRW+KYG2ez-NQ@mail.gmail.com> <CA+fCnZcT2iXww90CfiByAvr58XHXShiER0x0J2v14hRzNNFe9w@mail.gmail.com>
In-Reply-To: <CA+fCnZcT2iXww90CfiByAvr58XHXShiER0x0J2v14hRzNNFe9w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 2 Aug 2022 22:45:26 +0200
Message-ID: <CA+fCnZfU5AwAbei9NqtN+FstGLJYkRe7cZrYZN1wtcGbPkqVZQ@mail.gmail.com>
Subject: Re: [PATCH mm v2 30/33] kasan: implement stack ring for tag-based modes
To:     Marco Elver <elver@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:41 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Tue, Jul 19, 2022 at 1:41 PM Marco Elver <elver@google.com> wrote:
> >
> > > +       for (u64 i = pos - 1; i != pos - 1 - KASAN_STACK_RING_SIZE; i--) {
> > > +               if (alloc_found && free_found)
> > > +                       break;
> > > +
> > > +               entry = &stack_ring.entries[i % KASAN_STACK_RING_SIZE];
> > > +
> > > +               /* Paired with smp_store_release() in save_stack_info(). */
> > > +               ptr = (void *)smp_load_acquire(&entry->ptr);
> > > +
> > > +               if (kasan_reset_tag(ptr) != info->object ||
> > > +                   get_tag(ptr) != get_tag(info->access_addr))
> > > +                       continue;
> > > +
> > > +               pid = READ_ONCE(entry->pid);
> > > +               stack = READ_ONCE(entry->stack);
> > > +               is_free = READ_ONCE(entry->is_free);
> > > +
> > > +               /* Try detecting if the entry was changed while being read. */
> > > +               smp_mb();
> > > +               if (ptr != (void *)READ_ONCE(entry->ptr))
> > > +                       continue;
> >
> > I thought the re-validation is no longer needed because of the rwlock
> > protection?
>
> Oh, yes, forgot to remove this. Will either do in v3 if there are more
> things to fix, or will just send a small fix-up patch if the rest of
> the series looks good.
>
> > The rest looks fine now.
>
> Thank you, Marco!

Hi Marco,

I'm thinking of sending a v3.

Does your "The rest looks fine now" comment refer only to this patch
or to the whole series? If it's the former, could you PTAL at the
other patches?

Thanks!
