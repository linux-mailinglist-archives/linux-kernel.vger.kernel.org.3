Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9324F56037F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiF2OnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiF2OnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 941B52F9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656513783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7S0nWCPZZOEGbD8N2JmBW7Bz7rcl+xCGtpBNVP7MTQ=;
        b=WeQMoKghm8UCY7MWlojxuz3dXdXcpiNmZ9agKTsVzuGXyb788vb1Q55ZFyXwrCfNLv5SRF
        GYVtD09fMKPl6P0ghHQ/zLUU6O0nznTi5aU7Q1jLEInOsIV9KXZh+HXMzy/oZeP1au3SY+
        BxFRBzYXZtiMwcW8rZQe91YCgzbjvYs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-71tv71hoMjippjITdbyhXw-1; Wed, 29 Jun 2022 10:43:02 -0400
X-MC-Unique: 71tv71hoMjippjITdbyhXw-1
Received: by mail-qk1-f197.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso16426076qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7S0nWCPZZOEGbD8N2JmBW7Bz7rcl+xCGtpBNVP7MTQ=;
        b=IwZbll3KH99mwMQ81mEUIAIUkuVI9DW5NlNU6f/ybzWi7tcNs0BlQVHkIUOqHCVuwH
         qkrbG4Ao1u6uGlZyvcId+/g9eVNY+VUc83cyL4O7Nih9CWSOJpbAN5G0wqME3mw+5jMB
         IcA7GyO1Lqqq6gtUSOzUt63MFjKBAtWHbc2kyMdFoXq36fUKHsz8g4NqNBFbP7Ydkj+Y
         buwEoT9oDTuMBxZ27lI4IwVQR22qtn09zOSJdP60ttWZoVNyapoo1H1IEjSfrR9yBoNQ
         VKw6rdwgYpwrzBVhtgAWwUxL/ry1eNxxxb38g9OHpl7SgSiPmeydvBiGZoQFj63cRM8+
         uwEw==
X-Gm-Message-State: AJIora9cUWLGYBb632C8n4etaKQsTsqgSWDr+izNzVHlsObykluMHMhw
        cOIo+E8aMu7ZnGkj+EkiE6skG3PD2AClHb2MKv7zLpbAQ7guHSId3JtmqGJ8tLUKgkpMXpnZuEN
        eyathFJ/ww4f8Lzh8CfTj5M2KUMyOUEJxWkn9jOaP
X-Received: by 2002:a05:622a:90a:b0:31b:899:3070 with SMTP id bx10-20020a05622a090a00b0031b08993070mr2755599qtb.470.1656513781462;
        Wed, 29 Jun 2022 07:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1snXWlAR3sgWdAIaN3DlBIW0o4Fn6o5OCZioO1HkvOSAAI/43K9/YCye+hVbbMtLzZX4DAPjMyCEshh3UDDr/g=
X-Received: by 2002:a05:622a:90a:b0:31b:899:3070 with SMTP id
 bx10-20020a05622a090a00b0031b08993070mr2755577qtb.470.1656513781205; Wed, 29
 Jun 2022 07:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
 <20220627184232.tjfuzeir57l3h5ll@mail> <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
 <CAK-6q+g795MwPvUGxWXTE+s-TfJnbh2wf=Udb1k7r6ru-4FTMQ@mail.gmail.com>
 <20220628085821.kn3jjrviyprgai4w@mail> <CAHk-=wie9HSY-MmFr9zHeizRTgSfdONop0-4ezBiq5hYNp4U6g@mail.gmail.com>
In-Reply-To: <CAHk-=wie9HSY-MmFr9zHeizRTgSfdONop0-4ezBiq5hYNp4U6g@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 29 Jun 2022 10:42:48 -0400
Message-ID: <CAK-6q+jngywC7UZ6XG=yww16nJQgz0Z=VYKH8Fhg0kbZCkaypA@mail.gmail.com>
Subject: Re: sparse warnings related to kref_put_lock() and refcount_dec_and_lock()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        jacob.e.keller@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        thunder.leizhen@huawei.com,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 28, 2022 at 1:27 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jun 28, 2022 at 1:58 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > I would certainly not recommend this but ...
> > if it's OK to cheat and lie then you can do:
> > +       bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock) __acquires(lock);
>
> Actually, we have "__cond_lock()" in the kernel to actually document
> that something takes a lock only in certain conditions.
>
> It needs to be declared as a macro in the header file, with this as an example:
>
>    #define raw_spin_trylock(lock)  __cond_lock(lock, _raw_spin_trylock(lock))
>

I added a prefix of "raw_" to refcount_dec_and_lock() and similar
functions and replaced the original functions with the __cond_lock()
macro to redirect to their raw_ functions. Similar to how the
raw_spinlock_trylock() naming scheme is doing it. The "raw_"
functionality should never be called by the user then.

> ie that says that "raw_spin_trylock() takes 'lock' when
> _raw_spin_trylock() returned true".
>
> That then makes it possible to write code like
>
>     if (raw_spin_trylock(lock)) {..
>                  raw_spin_unlock(lock));
>     }
>
> and sparse will get the nesting right.
>
> But that does *not* solve the issue of people then writing this as
>
>     locked = raw_spin_trylock(lock);
>     .. do_something ..
>     if (locked)
>                  raw_spin_unlock(lock));
>
> and you end up with the same thing again.
>

Yes it mostly removed all sparse warnings I see. I needed to move at
one call of the refcount_dec_and_lock() function inside the if
condition and the sparse warning was gone. It should not be a problem
to change it in this way.

If there are no other complaints I will send a patch for the raw_
prefix to all those conditional refcount lock functions and the add a
__cond_lock() macro for the original function calls.

Thanks!

- Alex

