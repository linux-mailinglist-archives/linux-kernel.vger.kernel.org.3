Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6642B563997
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiGATJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGATJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 904843BBC0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656702583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0fTpQgJi583J8jUAwjwOMbnhXpGFLL7LTfUdXvC5nug=;
        b=J4uqQOf2lTrsTwpQYogF5xNpi7tX1HyLbGzEz4XWqZ+RpMWEHU/AgFzjuPUPnTWvvdk75e
        3AxD6KWm2qz5Ej+9NfIGDYlHQmdjTxJhw7QS6CMmWweifiWlnpZVnNE7ElWsEGjxBzz4Oh
        /pkpFZ3MAtIMbyWsQYczrqgNYdOOE64=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-vTE2hw5tNCO5YajVQXNDNA-1; Fri, 01 Jul 2022 15:09:22 -0400
X-MC-Unique: vTE2hw5tNCO5YajVQXNDNA-1
Received: by mail-qv1-f70.google.com with SMTP id jv13-20020a05621429ed00b0047048fce5bdso3114874qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 12:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fTpQgJi583J8jUAwjwOMbnhXpGFLL7LTfUdXvC5nug=;
        b=TDjnb/yNn4JvxF0oiLyvHGch19v8Y3N8za6weceZ8AfgXBfr30kVfGElO2LN5Y44QV
         Fdunof+PlMosWRBlESQRjmFyLSAK/304Me2SUUicLWr4yFrsO+aozZGEglfwXYG6QCKh
         7TS9Wumg8bs8NsecJg8NmyZHUuLeie23wWsyvFFAEYm4vHrCs3hM35DbP7ZmX25tbKfq
         V3fSF8miEiAB5boB6AlEg8sS1fNo53XvQtgmGCNOtDEjfJSbkbvt2nrxUaq24IvXF8uG
         h9I+4/LvJctv3/tEEiYL/SA+rtSSWDs2OxHMXCZ6QVjOkNCR1Zo6NiefPcG9c9uz616V
         zvjQ==
X-Gm-Message-State: AJIora+9URvzCCZRX19ki2hm88aE09qzREzw7qk+ELhwmwp+aSlV7D8q
        xRktBkKHoHA8pyZfJuz172Qb6ihB+n/S7eeClJr6ebCoSX9s3JO9gSDpP/O/mX/ESkWh2PK3u3G
        62FxlIBTXaIua3A+uqvdbGFqJpULX+OpftsY83O4J
X-Received: by 2002:ac8:4e8b:0:b0:31d:34c6:86a2 with SMTP id 11-20020ac84e8b000000b0031d34c686a2mr6376698qtp.526.1656702551835;
        Fri, 01 Jul 2022 12:09:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vmSaEwZdRV22oe7QtV5IzenWy25OI2oIP1ZZYcQg8tltXD2qNQp+JMu8VFupmj1poaUi8ytsw36XaCQrSfliI=
X-Received: by 2002:ac8:4e8b:0:b0:31d:34c6:86a2 with SMTP id
 11-20020ac84e8b000000b0031d34c686a2mr6376668qtp.526.1656702551575; Fri, 01
 Jul 2022 12:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220630135934.1799248-1-aahringo@redhat.com> <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
 <CAK-6q+jkNbotWK7cFsNGO+B+ApcdUd7+_4mdcF8=00YsDAATTA@mail.gmail.com>
In-Reply-To: <CAK-6q+jkNbotWK7cFsNGO+B+ApcdUd7+_4mdcF8=00YsDAATTA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 1 Jul 2022 15:09:00 -0400
Message-ID: <CAK-6q+i67rNeioq+=MzLyCJ_fh7DvDVWOHA02oOasKocvkhXSw@mail.gmail.com>
Subject: Re: [RFC 0/2] refcount: attempt to avoid imbalance warnings
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        thunder.leizhen@huawei.com, jacob.e.keller@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 1, 2022 at 8:07 AM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Thu, Jun 30, 2022 at 12:34 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Jun 30, 2022 at 6:59 AM Alexander Aring <aahringo@redhat.com> wrote:
> > >
> > > I send this patch series as RFC because it was necessary to do a kref
> > > change after adding __cond_lock() to refcount_dec_and_lock()
> > > functionality.
> >
> > Can you try something like this instead?
> >
> > This is two separate patches - one for sparse, and one for the kernel.
> >
> > This is only *very* lightly tested (ie I tested it on a single kernel
> > file that used refcount_dec_and_lock())
> >
>
> yes that avoids the warnings for fs/dlm.c by calling unlock() when the
> kref_put_lock() returns true.
>
> However there exists other users of kref_put_lock() which drops a
> sparse warning now after those patches e.g.  net/sunrpc/svcauth.c.
> I think I can explain why. It is that kref_put_lock() has a release
> callback and it's _optional_ that this release callback calls the
> unlock(). If the release callback calls unlock() then the user of
> kref_put_lock() signals this with a releases() annotation of the
> passed release callback.
>
> It seems that sparse is not detecting this annotation anymore when
> it's passed as callback and the function pointer parameter declaration
> of kref_put_lock() does not have such annotation. The annotation gets
> "dropped" then.
>
> If I change the parameter order and add a annotation to the release
> callback, like:
>
> __kref_put_lock(struct kref *kref, spinlock_t *lock,
>                void (*release)(struct kref *kref) __releases(lock))
> #define kref_put_lock(kref, release, lock) __kref_put_lock(kref, lock, release)
>
> the problem is gone but forces every user to release the lock in the
> release callback which isn't required and also cuts the API because
> the lock which you want to call unlock() on can be not part of your
> container_of(kref) struct.
>
> Then I did a similar thing before which would solve it for every user
> because there is simply no function pointer passed as parameter and
> the annotation gets never "dropped":
>
> #define kref_put_lock(kref, release, lock) \
> (refcount_dec_and_lock(&(kref)->refcount, lock) ? ({ release(kref); 1; }) : 0)
>
> Maybe a functionality of forwarding function annotation if passed as a
> function pointer (function pointer declared without annotations) as in
> e.g. kref_put_lock() can be added into sparse?

I think the explanation above is not quite right. I am questioning
myself now why it was working before... and I guess the answer is that
it was working for kref_put_lock() with the callback __releases()
handling. It has somehow now an additional acquire() because the
__cond_acquires() change.

Before the patch:

no warnings:

void foo_release(struct kref *kref)
__releases(&foo_lock)
{
        ...
        unlock(foo_lock);
}

...
kref_put_lock(&foo->kref, foo_release, &foo_lock);

shows context imbalance warnings:

void foo_release(struct kref *kref) { }

if (kref_put_lock(&foo->kref, foo_release, &foo_lock))
        unlock(foo_lock);

After the patch it's vice versa of showing warnings or not about
context imbalances.

- Alex

