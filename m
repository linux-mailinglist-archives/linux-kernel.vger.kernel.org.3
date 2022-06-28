Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99B455EB08
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiF1R2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiF1R1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:27:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3DE3A1AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:27:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ay16so27232395ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8enEY7C1gWoeSidj5O4iKotu18rloK7WpGazqUwbRIY=;
        b=TJkTA81PK2rsKdDhsaZqdWiQNHpCCo0Drc1YQmCq2L8M1HNJZakhKjYssJNfe258So
         qMcO5/9BPWEInBQVKtHeh+NkXQkpr3XNj1ioGaz1To85geFjNdcjMnAECWwkZYSH9sx/
         W2cjvoSUQE3GTSz9eC/albPMpyfb2xbdIMyUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8enEY7C1gWoeSidj5O4iKotu18rloK7WpGazqUwbRIY=;
        b=cQ6A468sngGZODIA3eOGSLxJ+U+zCZA2FVpSc5sotju476O2Xp6OAMGvdg59TFqAGW
         YMKj/NQc/79tJYJt7rkfp/TXVVxosTPvb7iPthW7BxKvnDATu1mwJ4Vdx8TbYdlCtqmh
         j7DFjvpiqmSAA+vJG6qw0qYsGgK0AMY0RpWxDMQF4ykHrjBWQ6uMdh4rxz9bgHAh5Utf
         BU6D3BRkvu60DtB7Q1uFPNrVOJeVty18UU1hY3MJZjNeXkAYwTgzoXIXXaDkSZeAZEyk
         n3TsEp8EmVikQ6OckWJWRwlX+vyeMe67FVJpgvSjtdkOhnYDd3R240cFKaEjwMrp6XGA
         2ZUA==
X-Gm-Message-State: AJIora+umg8zVaE1CXydnBYzAvKNEHXCiwyG11Kn3OZ+yKaCHoOp3xEc
        ePel0HzGuxRuYmu+nidLIcVX6TgsLXNFpzE5W44=
X-Google-Smtp-Source: AGRyM1tBfIEAdnOhAhM7YlOt5pB4ojg9ID8iEN6/3msRuLmRYvciDG5nzMKBVIm8c1PAheTacyXk1A==
X-Received: by 2002:a17:907:6d9e:b0:726:8f7a:7a7a with SMTP id sb30-20020a1709076d9e00b007268f7a7a7amr15908831ejc.425.1656437270010;
        Tue, 28 Jun 2022 10:27:50 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090605c400b00706242d297fsm6560538ejt.212.2022.06.28.10.27.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 10:27:48 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id v193-20020a1cacca000000b003a051f41541so1656552wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:27:48 -0700 (PDT)
X-Received: by 2002:a05:600c:681:b0:3a0:2da6:d173 with SMTP id
 a1-20020a05600c068100b003a02da6d173mr793598wmn.68.1656437268408; Tue, 28 Jun
 2022 10:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
 <20220627184232.tjfuzeir57l3h5ll@mail> <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
 <CAK-6q+g795MwPvUGxWXTE+s-TfJnbh2wf=Udb1k7r6ru-4FTMQ@mail.gmail.com> <20220628085821.kn3jjrviyprgai4w@mail>
In-Reply-To: <20220628085821.kn3jjrviyprgai4w@mail>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Jun 2022 10:27:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wie9HSY-MmFr9zHeizRTgSfdONop0-4ezBiq5hYNp4U6g@mail.gmail.com>
Message-ID: <CAHk-=wie9HSY-MmFr9zHeizRTgSfdONop0-4ezBiq5hYNp4U6g@mail.gmail.com>
Subject: Re: sparse warnings related to kref_put_lock() and refcount_dec_and_lock()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Alexander Aring <aahringo@redhat.com>, jacob.e.keller@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        thunder.leizhen@huawei.com,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 1:58 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I would certainly not recommend this but ...
> if it's OK to cheat and lie then you can do:
> +       bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __acquires(lock);

Actually, we have "__cond_lock()" in the kernel to actually document
that something takes a lock only in certain conditions.

It needs to be declared as a macro in the header file, with this as an example:

   #define raw_spin_trylock(lock)  __cond_lock(lock, _raw_spin_trylock(lock))

ie that says that "raw_spin_trylock() takes 'lock' when
_raw_spin_trylock() returned true".

That then makes it possible to write code like

    if (raw_spin_trylock(lock)) {..
                 raw_spin_unlock(lock));
    }

and sparse will get the nesting right.

But that does *not* solve the issue of people then writing this as

    locked = raw_spin_trylock(lock);
    .. do_something ..
    if (locked)
                 raw_spin_unlock(lock));

and you end up with the same thing again.

Anyway, for things like refcount_dec_and_lock(), I suspect that first
pattern should work, because you really shouldn't have that second
pattern. If you just decremented without any locking, the actions are
completely different from the "oh, got the last decrement and now it's
locked and I need to free things" or whatever.

                Linus
