Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B6055D9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbiF1A5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiF1A5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C96B61D309
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656377815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Le9rasWFftvBUIXdCkHOfomOzNQQm9TeUsAxHwjuOAw=;
        b=F7hi+/4lYy3BA7h7un18gCZGAj0nKtLjGo7wlZh4iZhxQh2hiKcacqsiXo5Kmigjea7t9T
        UmQTAyso++QiR5Li5ssXYsHFTeaOFUxba9l2nNmPrb857xfAQEjL6dMoJhiLqdOkO6JTgt
        jVQwBeQev2FEef0LQIBDHzZQIjqAEvg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-INFJW7ACNp62JTNzf8KNmQ-1; Mon, 27 Jun 2022 20:56:54 -0400
X-MC-Unique: INFJW7ACNp62JTNzf8KNmQ-1
Received: by mail-qk1-f200.google.com with SMTP id l189-20020a37bbc6000000b006af2596c5e8so4959310qkf.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Le9rasWFftvBUIXdCkHOfomOzNQQm9TeUsAxHwjuOAw=;
        b=z5UrRx0h6L9vHxhSSmveR/4auxMz5D6b2ofkvMhI6VQO5rx44UziTEdl3l2l3sfb99
         bp0QUhPBzSYWyflG91fFxW2scVkFq0UB1DPSPpy+CCj382SsoKi5WnXyAEk5mcE/d6GB
         kyYbjAYJgW0xGbA0Jj1askkVE0IRhKJ+v0zsKhLm0ENdRl6h4P9UBhGHnD/2lHD4HWCx
         dId4eALXxKgam9vA16mhNivfx2Z0cLnTd9cNkO886DPB+JOsTTM6iolbxwfdJpzpREHQ
         q8S1J8Xv4sIsb6jRGAYQ9jpkeIu+RzCq2aSvZPI7KDyDaJ8ThMpIh5arqbHh9f8aJ3c7
         nzRw==
X-Gm-Message-State: AJIora/TdSA0o1TAc09a1xV8WEEDViG+QavtpG6C5PSl7eJVvn1GHGP4
        MdL12l5fdEmPh+U72ulJpHApFej5ZdCcFCEefLLloq5CNwgOj5Y2lQVK89TfooA9Gvj8RJ+HdWD
        UopUpTFB5o66kfkGiXEPv5A7SLMl0SC7UUccWayaD
X-Received: by 2002:a05:622a:1306:b0:31a:f73e:3d6d with SMTP id v6-20020a05622a130600b0031af73e3d6dmr4502026qtk.339.1656377814094;
        Mon, 27 Jun 2022 17:56:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sFL8MzmxZyh2qnSdqly13+uMFK0IBDjQrSTquxB94TtYvbMTQHQ5Agm2zgV9VXjYMWhLtxVo1TwdIgig7APGY=
X-Received: by 2002:a05:622a:1306:b0:31a:f73e:3d6d with SMTP id
 v6-20020a05622a130600b0031af73e3d6dmr4502021qtk.339.1656377813876; Mon, 27
 Jun 2022 17:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
 <20220627184232.tjfuzeir57l3h5ll@mail>
In-Reply-To: <20220627184232.tjfuzeir57l3h5ll@mail>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 27 Jun 2022 20:56:42 -0400
Message-ID: <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
Subject: Re: sparse warnings related to kref_put_lock() and refcount_dec_and_lock()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        jacob.e.keller@intel.com, akpm@linux-foundation.org,
        thunder.leizhen@huawei.com
Cc:     linux-sparse@vger.kernel.org,
        cluster-devel <cluster-devel@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc and others,

On Mon, Jun 27, 2022 at 2:42 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Mon, Jun 27, 2022 at 11:15:17AM -0400, Alexander Aring wrote:
> > Hi,
> >
> > I recently converted to use kref_put_lock() in fs/dlm subsystem and
> > now I get the following warning in sparse:
> >
> > warning: context imbalance in 'put_rsb' - unexpected unlock
> >
> > It seems sparse is not able to detect that there is a conditional
> > requirement that the lock passed to kref_put_lock() (or also
> > refcount_dec_and_lock()) is locked or not. I evaluate the return value
> > to check if kref_put_lock() helds the lock and unlock it then. The
> > idea is that the lock needs only to be held when the refcount is going
> > to be zero.
> >
> > It seems other users unlock the lock at the release callback of
> > kref_put_lock() and annotate the callback with "__releases()" which
> > seems to work to avoid the sparse warning. However this works if you
> > don't have additional stack pointers which you need to pass to the
> > release callback.
> >
> > My question would be is this a known problem and a recommended way to
> > avoid this sparse warning (maybe just for now)?
>
> Hi,
>
> I suppose that your case here can be simplified into something like:
>
>         if (some_condition)
>                 take(some_lock);
>
>         do_stuff();
>
>         if (some_condition)
>                 release(some_lock);
>
> Sparse issues the 'context imbalance' warning because, a priori,
> it can't exclude that some execution will takes the lock and not
> releases it (or the opposite). In some case, when do_stuff() is
> very simple, sparse can see that everything is OK, but generally
> it won't (some whole kernel analysis but the general case is
> undecidable anyway).
>
> The recommended way would be to write things rather like this:
>
>         if (some_condition) {
>                 take(some_lock);
>                 do_stuff();
>                 release(some_lock);
>         } else {
>                 do_stuff();
>         }
>

This is not an alternative for me because the lock needs to hold
during the "some_condition". (More background is that we dealing with
data structures here and cannot allow a get() from this data
structures during "some_condition", the lock is preventing this)
It is the refcount code which causes trouble here [0] and I think the
refcount code should never call the unlock() procedure in any
condition and leave it to the caller to call unlock() in any case.

I to'ed (hope to get more attention to this) more people related to
lib/refcount.c implementation (provided by get_maintainers.pl -f).

>
> The __acquires() and __releases() annotations are needed for sparse
> to know that the annotated function always take or always release
> some lock but won't handle conditional locks.
>

If we change the refcount code to _never_ calling unlock() for the
specific lock, then all those foo_and_lock_bar() functions can be
annotated with "__acquires()". This should also end in the same code?
For me it looks like the current implementation of refcount.c is fine
except sparse cannot figure out what's going on and maybe a reason to
change the specific handling to the mentioned one.

> I hope that this is helpful to you.
>

I hope we will find some solution, because I don't like sparse warnings.

- Alex

[0] https://elixir.bootlin.com/linux/v5.19-rc4/source/lib/refcount.c#L144

