Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130B155DC08
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbiF1BHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbiF1BG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3DCC1EAE3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656378416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qd874xtCALLLoZTYnK0UQbFRAzSITPNiJ0IyPu+wf6I=;
        b=Zmdh4gfLwFk+x3l1UkzLhHyBxcAJRC+6OJyVP0H05dNLA0TK6Yo0MBtJ9/ZhriZbpm8W6z
        J4q4BpSk51XIWmdWUR4aSYUGhHwqxeH9g00Jyn8LsWo9FctKbeqC7jWqZKXbmSKNVWPQlf
        F/qvnHIpd0I8uKGSa9xBD54k0xzXXqA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-HDrfUG3TPg6rGphR57uumw-1; Mon, 27 Jun 2022 21:06:55 -0400
X-MC-Unique: HDrfUG3TPg6rGphR57uumw-1
Received: by mail-qv1-f71.google.com with SMTP id w18-20020a0ce112000000b0046e7f2c5a06so10911912qvk.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qd874xtCALLLoZTYnK0UQbFRAzSITPNiJ0IyPu+wf6I=;
        b=s8pFcIRWP+huH2DfGx7q/7OmOHx6JouQf38gcfCc4k0cd1/k5VGWWX2y14PHkqWr5A
         HDNXRLyEiQWBqYrRU2NLJqdMpsbC/X3+ON452UcmvP9kPUofmfmJhL3fi0U/hHYWO/XJ
         3EtPo75lBxFK+QWip1BbKsEEDR4rERkHhw6gLDn/w0hAPhiowmiGdfAjSjO4ggRd1B4x
         ZUer8zWddkIT2GXklZ/JB7QsMsN8K0Hejdi74l5ITknIvjllb2vx31PphxG36MLLCz1B
         j8+77yN6A6SFPUU3A9L2sYSHdcJgyJ2lwTLM2j3aMNc37J2ii2YcXNRA4wS4ySrfh9Bb
         LgGw==
X-Gm-Message-State: AJIora9z70Y4A6c6/0dVJYjwqLrr9fb9tCWs4Iw+jqTxoz2/2kzDShhN
        /eSgvVdfFcuAe9pPdL+LOICfWFp8YUDNsF9N+KfJ3kAnaq/Cxn5hxPDLdGfyNAiXH/HeSXL/ozo
        id3sZ9QhAhV/jp5jBbCNVJhctEESxCjgb5oWkuEvm
X-Received: by 2002:a37:67c9:0:b0:6af:a24:df4b with SMTP id b192-20020a3767c9000000b006af0a24df4bmr10208171qkc.691.1656378415005;
        Mon, 27 Jun 2022 18:06:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sM+DE05HKnqCKiuiPXvpVvEidKjNa59r4LZdriDsOcKKbeLhGbXgYemJcg7o/G2oObtWkqNrJIxr2o+yhihfo=
X-Received: by 2002:a37:67c9:0:b0:6af:a24:df4b with SMTP id
 b192-20020a3767c9000000b006af0a24df4bmr10208157qkc.691.1656378414786; Mon, 27
 Jun 2022 18:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+hd-L54cqOiFNuufS2_VF5XS0R8cjQL7es8921+2u3uwQ@mail.gmail.com>
 <20220627184232.tjfuzeir57l3h5ll@mail> <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
In-Reply-To: <CAK-6q+haOfQD8_N6pEm80BTrUXwaj07ZBcXP-EBHftpTVEc1XQ@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 27 Jun 2022 21:06:43 -0400
Message-ID: <CAK-6q+g795MwPvUGxWXTE+s-TfJnbh2wf=Udb1k7r6ru-4FTMQ@mail.gmail.com>
Subject: Re: sparse warnings related to kref_put_lock() and refcount_dec_and_lock()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        jacob.e.keller@intel.com, akpm@linux-foundation.org,
        thunder.leizhen@huawei.com
Cc:     linux-sparse@vger.kernel.org,
        cluster-devel <cluster-devel@redhat.com>,
        linux-kernel@vger.kernel.org
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

On Mon, Jun 27, 2022 at 8:56 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi Luc and others,
>
> On Mon, Jun 27, 2022 at 2:42 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 11:15:17AM -0400, Alexander Aring wrote:
> > > Hi,
> > >
> > > I recently converted to use kref_put_lock() in fs/dlm subsystem and
> > > now I get the following warning in sparse:
> > >
> > > warning: context imbalance in 'put_rsb' - unexpected unlock
> > >
> > > It seems sparse is not able to detect that there is a conditional
> > > requirement that the lock passed to kref_put_lock() (or also
> > > refcount_dec_and_lock()) is locked or not. I evaluate the return value
> > > to check if kref_put_lock() helds the lock and unlock it then. The
> > > idea is that the lock needs only to be held when the refcount is going
> > > to be zero.
> > >
> > > It seems other users unlock the lock at the release callback of
> > > kref_put_lock() and annotate the callback with "__releases()" which
> > > seems to work to avoid the sparse warning. However this works if you
> > > don't have additional stack pointers which you need to pass to the
> > > release callback.
> > >
> > > My question would be is this a known problem and a recommended way to
> > > avoid this sparse warning (maybe just for now)?
> >
> > Hi,
> >
> > I suppose that your case here can be simplified into something like:
> >
> >         if (some_condition)
> >                 take(some_lock);
> >
> >         do_stuff();
> >
> >         if (some_condition)
> >                 release(some_lock);
> >
> > Sparse issues the 'context imbalance' warning because, a priori,
> > it can't exclude that some execution will takes the lock and not
> > releases it (or the opposite). In some case, when do_stuff() is
> > very simple, sparse can see that everything is OK, but generally
> > it won't (some whole kernel analysis but the general case is
> > undecidable anyway).
> >
> > The recommended way would be to write things rather like this:
> >
> >         if (some_condition) {
> >                 take(some_lock);
> >                 do_stuff();
> >                 release(some_lock);
> >         } else {
> >                 do_stuff();
> >         }
> >
>
> This is not an alternative for me because the lock needs to hold
> during the "some_condition". (More background is that we dealing with
> data structures here and cannot allow a get() from this data
> structures during "some_condition", the lock is preventing this)
> It is the refcount code which causes trouble here [0] and I think the
> refcount code should never call the unlock() procedure in any
> condition and leave it to the caller to call unlock() in any case.
>
> I to'ed (hope to get more attention to this) more people related to
> lib/refcount.c implementation (provided by get_maintainers.pl -f).
>
> >
> > The __acquires() and __releases() annotations are needed for sparse
> > to know that the annotated function always take or always release
> > some lock but won't handle conditional locks.
> >
>
> If we change the refcount code to _never_ calling unlock() for the
> specific lock, then all those foo_and_lock_bar() functions can be
> annotated with "__acquires()". This should also end in the same code?

sorry, this will not work because of the first condition of "if
(refcount_dec_not_one(r))" which will never hold the lock if true...
that's what the optimization is all about. However, maybe somebody has
another idea...

- Alex

