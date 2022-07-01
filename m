Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA23563326
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiGAMHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbiGAMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E5AD83F06
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656677235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXhzCgqTisWYCfLQ5y3NkLn493B5u6s+MotNFCqarsA=;
        b=ZuwpG/QjNpj313ijv1BiRWe6p5HG2Ind4jdi6hYtmZXYmrwPqXyQoLzYGeFN4Hn5MaXPma
        RBxE+xBJ7HnKpWNxYTczK+rmUJXO1ZMX/in/kwR9mfO1zRpsmd8KyeC5fJTHDu7W+Pwmsv
        ve0BD/9E9/MRE1T9z8wPtf4cgSU9ToM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-2dY3XtqZPzOXa2O40q33ZA-1; Fri, 01 Jul 2022 08:07:14 -0400
X-MC-Unique: 2dY3XtqZPzOXa2O40q33ZA-1
Received: by mail-qt1-f200.google.com with SMTP id y6-20020ac87046000000b0031a0c154b7eso233995qtm.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 05:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXhzCgqTisWYCfLQ5y3NkLn493B5u6s+MotNFCqarsA=;
        b=AE60tGfHGS4luePxkohtsbjV+DzhKAsRC0E3j0jQ/LPtzS2sOMw9z5HNSkye3ghiEn
         1t0ejtvcocXfKDGfYJiGx0ZZIz3BfboDJNwcA+x/tyB+xi1WsQ/elZBLG/R1ZPuOrKXA
         nke/CHpuD2cNEjh6JeB14gfqZM1OR3Xmvcxx+ygRBC3Sgu5ZLydIVQYYdvzdQyKs5i/e
         ZTWV+oP61cZtzOi+yzB6qwND9byzVRG4G2Ow7Av6aX/PUBlFAsHosbdy3sr3G+Vs6xue
         2qyOm9roBZX7hQT4iQvgQA19AMnq30qHgtPkXouH0ZhRtM6nm3gwRz4gJmmZRi+6wPNj
         D32g==
X-Gm-Message-State: AJIora/vd0ty8smGsRBi5ZwZ8igMgThjZFHKHg1uthvnosDO1FVNNz8G
        1FVeRur6NnM6Bs9iU9LgmMtqsHCDNgp+CO41iwIpDGOVHQwvQnK8AQyLocde9BY8XpBkJYaCoxf
        zEG0m7Swi9ztwMrHPaa7o1ZPii9w93KrTPr4z+RQy
X-Received: by 2002:ac8:5749:0:b0:305:1ea5:4a7 with SMTP id 9-20020ac85749000000b003051ea504a7mr12090125qtx.291.1656677233488;
        Fri, 01 Jul 2022 05:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vPEbyYUewayWbWLRAfTmQdi+voNzbdWmyNv7kpwUkdnn2VbxTjMzi9pHOfGl1Z0MPdfmMBqDhBInC3Hnk8Lhg=
X-Received: by 2002:ac8:5749:0:b0:305:1ea5:4a7 with SMTP id
 9-20020ac85749000000b003051ea504a7mr12090089qtx.291.1656677233207; Fri, 01
 Jul 2022 05:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220630135934.1799248-1-aahringo@redhat.com> <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
In-Reply-To: <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 1 Jul 2022 08:07:01 -0400
Message-ID: <CAK-6q+jkNbotWK7cFsNGO+B+ApcdUd7+_4mdcF8=00YsDAATTA@mail.gmail.com>
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

On Thu, Jun 30, 2022 at 12:34 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jun 30, 2022 at 6:59 AM Alexander Aring <aahringo@redhat.com> wrote:
> >
> > I send this patch series as RFC because it was necessary to do a kref
> > change after adding __cond_lock() to refcount_dec_and_lock()
> > functionality.
>
> Can you try something like this instead?
>
> This is two separate patches - one for sparse, and one for the kernel.
>
> This is only *very* lightly tested (ie I tested it on a single kernel
> file that used refcount_dec_and_lock())
>

yes that avoids the warnings for fs/dlm.c by calling unlock() when the
kref_put_lock() returns true.

However there exists other users of kref_put_lock() which drops a
sparse warning now after those patches e.g.  net/sunrpc/svcauth.c.
I think I can explain why. It is that kref_put_lock() has a release
callback and it's _optional_ that this release callback calls the
unlock(). If the release callback calls unlock() then the user of
kref_put_lock() signals this with a releases() annotation of the
passed release callback.

It seems that sparse is not detecting this annotation anymore when
it's passed as callback and the function pointer parameter declaration
of kref_put_lock() does not have such annotation. The annotation gets
"dropped" then.

If I change the parameter order and add a annotation to the release
callback, like:

__kref_put_lock(struct kref *kref, spinlock_t *lock,
               void (*release)(struct kref *kref) __releases(lock))
#define kref_put_lock(kref, release, lock) __kref_put_lock(kref, lock, release)

the problem is gone but forces every user to release the lock in the
release callback which isn't required and also cuts the API because
the lock which you want to call unlock() on can be not part of your
container_of(kref) struct.

Then I did a similar thing before which would solve it for every user
because there is simply no function pointer passed as parameter and
the annotation gets never "dropped":

#define kref_put_lock(kref, release, lock) \
(refcount_dec_and_lock(&(kref)->refcount, lock) ? ({ release(kref); 1; }) : 0)

Maybe a functionality of forwarding function annotation if passed as a
function pointer (function pointer declared without annotations) as in
e.g. kref_put_lock() can be added into sparse?

- Alex

