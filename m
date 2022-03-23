Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD414E590C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbiCWTWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiCWTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:22:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EBD887B1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:20:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qa43so4816536ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zb43V2bxAJ2SXfDM1H+R1ImG/pdyDgKYnKVKfixphNc=;
        b=lOuUK4cL7xU5D7fHvTqAKQiL1oJNrs4SwK1hRG9/cCbcOQqImp41ziRDXpXiKekQwx
         +heK6sgT1fSj17OVyCiQV2yaRGzYOiFU6smhslUFR19Yr9X9KYfh5bz9mv570CLA5Wol
         qKsu2qocf1lbePzG3eOGonFsWFo6QkccOBQuGmDDerWDbztqi8MYV5hTkBL3D/KT1uvd
         +oNEj3ddAaPn/MJ2jrIWSUX+yVr6cCJ7WxYgxJGRvRbmr/+Y8HGL9FTbW8CUwXz+XDQI
         cWndUH1IsRLxedvRZWiEOqB7He8W/o/NnORxtJojb4BHckQmtqmo07/eRJ0kn2r4e4Ik
         N3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zb43V2bxAJ2SXfDM1H+R1ImG/pdyDgKYnKVKfixphNc=;
        b=PShgFbSLJp51rQmZHT/xYa6jqFpKUuqI2fpClxut8jr6Fhit/831xRQbbviGz+iEOO
         yqXVhly2zM5kjVUoywpH5MKq2R4fzKvhgW2krKEJByeYkGanDJRB5NKWR4P7qAHDp+Um
         jgHqZa02ds9w+iqogia5xipetUZiHqpbsIHdGsP/H8y2/6jmUlqF0JlvRSH43Vi7CI4h
         0AnIWS1B6cODuzVYQuhh7n0/f9JNWSy0Bc3S3I0Bs59jUdarsLcyIIP6z2bWH7Uf5Zn5
         G53DpGHZrVS6NfJMAAt5LeiKQfaDo2Dfw+4XvFKF7cQBXRtAh5iukt6F31esf2AMCfMi
         emkw==
X-Gm-Message-State: AOAM5307ZbnU8myy+mun4iPjPITwGPcbd0SCUxOdsH9P7Qd7jWxJbKkn
        ip0kx7YnFi2sjPAyo/a6GESkfZDypw2BUCMlfWmvBg==
X-Google-Smtp-Source: ABdhPJw+4zoR1slj9y1WLKlDMIWrU+GMc6chsawuSs3JX3F/VTByN07KgC5UQTuQor6ETPoPIL9gmfbmV1rNePBE2Q0=
X-Received: by 2002:a17:906:c282:b0:6ce:369d:3d5 with SMTP id
 r2-20020a170906c28200b006ce369d03d5mr1783232ejz.425.1648063249321; Wed, 23
 Mar 2022 12:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220319055600.3471875-1-davidgow@google.com> <CAGS_qxpqcc8O2HpmF3qB-uzXZrDNg9=h3nE_f7si=aOxXkRA+Q@mail.gmail.com>
 <CABVgOS=sKWiDLN=GgyXQGOdmRn6t35mEA_0C7GrZyEApjVg1Pw@mail.gmail.com>
 <CAGS_qxobBt2gH3FB79m7sfQZ9thKXQ5exQEa_1GcQOmXFFEv1A@mail.gmail.com> <CAFd5g47ZJq8FmFFnAVdDEc6MKdeYBndrb=jbiiebLBdoG4hvCQ@mail.gmail.com>
In-Reply-To: <CAFd5g47ZJq8FmFFnAVdDEc6MKdeYBndrb=jbiiebLBdoG4hvCQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 23 Mar 2022 14:20:37 -0500
Message-ID: <CAGS_qxoPdA_6vthHjS8+958BSyMRwL+6A5ZG=EdbFbMJwbSFyA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Rework kunit_resource allocation policy
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Mar 23, 2022 at 2:22 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>

<snip>

>
> > The latter ~never need to get "found" (e.g. kunit_kmalloc() users).
> > The one exception: when people use kunit_kfree() to free things early,
> > which requires us to "find" these resources we otherwise wouldn't care
> > about.
> >
> > So I don't know how we can split the API unless we get rid of kunit_kfree().
> > Its presence means kunit_kmalloc() and friends need refcounting.
>
> Do we need to choose between dropping kunit_kfree() and refcounting? I
> think this is semantically different from other findable resources,
> and I think it fairly obviously entails the complexity of using it.

Yes, they're different.
We could do something different and just have a atomic bool "is_freed"
for the kunit_kmalloc() style resources.

But is it worth it?

Currently kunit_kfree() is defined as
697:void kunit_kfree(struct kunit *test, const void *ptr)
698-{
699-    struct kunit_resource *res;
700-
701-    res = kunit_find_resource(test, kunit_resource_instance_match,
702-                              (void *)ptr);
703-
704-    /*
705-     * Removing the resource from the list of resources drops the
706-     * reference count to 1; the final put will trigger the free.
707-     */
708-    kunit_remove_resource(test, res);
709-
710-    kunit_put_resource(res);
711-
712-}

i.e. the overhead of using a refcount is that we need to call
kunit_put_resource() bc we called kunit_find_resource().
IMO, this less semantic overhead than adding a different mechanism
specifically for kunit_kfree().

Tangent:
Huh, it segfaults if you call kunit_kfree() on a non-kunit allocated ptr.
res == NULL on 701 in that case, but kunit_remove_resource() doesn't
guard against that.
It also happens if you call kunit_free() twice.

That's analogous to how kfree() works, so I guess that's fine.
A difference though is
  kfree(NULL); // is fine
  kunit_free(test, NULL); // segfaults, res == NULL above

But thinking on it more, someone could register a resource w/ data == NULL.
I.e. a named resource which just acts as a flag via presence/absence.
kunit_kfree(test, NULL) would the most recent such resource though.

Should we do the trick/hack where we check the free function first in
kunit_kfree() to avoid such confusion?
