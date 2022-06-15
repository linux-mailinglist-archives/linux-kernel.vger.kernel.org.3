Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8795C54D09D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358122AbiFOSFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349342AbiFOSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:05:36 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29918377DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:05:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r82so21817348ybc.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wCIq2pEscSFloWLAAVKf+NRJrk/xfcyCBv54BmH8NfA=;
        b=Wz2Kt29jm2EOKKJp4dD6OTULRmnhk2QqQQs7YauX7UC/YXFBpYNyYtxMFyz7YUk/hi
         FwIJHabc3XXyJJdaxlc2z8iTsrHVfbrmx5Zao/gl3TghFf7XWmWo9ggUXpLtdxW95DyF
         4L5XU+9zUFLmw6VZajzaOJCIRyfnTpf4Huny0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wCIq2pEscSFloWLAAVKf+NRJrk/xfcyCBv54BmH8NfA=;
        b=RdahbbYWCA64eng9vXpKwdngKMAjo8FpJBVHebu/CVXlh3s8T6pfdUi+NF3vblalpZ
         5iBhozUzGyxTNbYU6nMROC9DLaLBSWakO/Yu96iq86l2GXFO9R/HBiHcv7IdRnrqvigC
         9qkbudusj3LwZ1tDTXMNz4uYQjNhe+2Leykad/Zm8AmWAKzzOfWr0jgUeUJR1OIe1KYW
         iphGnKRtAK2Ki+VxHbc4uSpyVKB9zStdMqSvfMze/eIY08Z3gHbILg2hYay6OhFmPyB7
         HRU9HnWAEoO0tkQbU896fk2bbAgZvo8wEm+uPfXVBIdlh5KBgu4+UXlkJSuaMcMQCSe0
         11Kw==
X-Gm-Message-State: AJIora/r4sjDjWSYxgwvd78CVY9QQxwNhuy6V307MdK6XG/CjT2Oq04w
        XRFkdnUm4yfh5kMxSNmBb74SFeAAQb7j5NSK21bVXQ==
X-Google-Smtp-Source: AGRyM1saVtovw0G7v6o+EaC89C36m3EEfWY4LF5dLaYUH6oWqmG5EBMjeM2Y2lf1+zFMHrmCzc2gi1APoEqil9rfOlo=
X-Received: by 2002:a25:906:0:b0:65c:b361:80fd with SMTP id
 6-20020a250906000000b0065cb36180fdmr1117997ybj.197.1655316334384; Wed, 15 Jun
 2022 11:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220526220018.3334775-1-dualli@chromium.org> <YpBmmVa+09ZhP9LH@kroah.com>
In-Reply-To: <YpBmmVa+09ZhP9LH@kroah.com>
From:   Li Li <dualli@chromium.org>
Date:   Wed, 15 Jun 2022 11:05:23 -0700
Message-ID: <CANBPYPg_cpaTCcJ=5b3j3L3KHg=D7Xnj14wkHq5YMznu=3en8g@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/1] Binder: add TF_UPDATE_TXN to replace
 outdated txn
To:     Greg KH <gregkh@linuxfoundation.org>, Li Li <dualli@google.com>,
        Todd Kjos <tkjos@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 26, 2022 at 03:00:17PM -0700, Li Li wrote:
> > From: Li Li <dualli@google.com>
> >
> > Resend [Patch v3] with cover letter in case my previous email failed
> > to reach the maillist (no comments for 2 weeks).
> >
> > The previous comments of the old patch can be found at the following link:
> > https://lore.kernel.org/lkml/CANBPYPjkNWsO94nuG1TkR1DgK2W2kBxiJTriyVB7S3czHTZ1Yg@mail.gmail.com/
> >
> > I copy and paste the key information here for your convenience.
> >
> > * Question #1
> >
> > Note, your subject does not say what TF_UPDATE_TXN is, so it's a bit
> > hard to determine what is happening here.  Can you clean that up a bit
> > and sumarize what this new addition does?
> > How was this tested?
> >
> > * Answer #1 ===
> >
> > A more descriptive summary has been added to the new version of patch.
> >
> > *  Question #2
> >
> > How was this tested?
> >
> > * Answer #2
> >
> > Old kernel: without this TF_UPDATE_TXN patch
> > New kernel: with this TF_UPDATE_TXN patch
> > Old apps: without setting TF_UPDATE_TXN
> > New apps: if (flags & TF_ONE_WAY) flags |= TF_UPDATE_TXN;
> >
> > 1. Compatibility: New kernel + Old apps, to verify the original
> > behavior doesn't change;
> >
> > 2. Compatibility: Old kernel + New apps, to verify the original
> > behavior doesn't change;
> >
> > 3. Unit test: New kernel + New apps, to verify the outdated oneway
> > binder transaction is actually superseded by the latest one (by
> > enabling BINDER_DEBUG logs);
> >
> > 4. Stress test: New kernel + New apps sending oneway binder
> > transactions repeatedly, to verify the size of the available async
> > binder buffer over time, and if the transactions fail as before
> > (due to async buffer running out).
> >
> > * Question #3
> >
> > Did checkpatch pass this?  Please always use --strict and fix up all the
> > issues that it reports as this is not a normal kernel coding style.
> >
> > * Answer #3
> >
> > Yes, the latest version has passed "./scripts/checkpatch.pl --strict"
> >
> > * Changelog
> >
> > v3:
> >   - Add this changelog required by "The canonical patch format"
> > v2:
> >   - Fix alignment warnings reported by checkpatch --strict
> >   - Add descriptive summary in patch subject
> >
> > Li Li (1):
> >   Binder: add TF_UPDATE_TXN to replace outdated txn
> >
> >  drivers/android/binder.c            | 85 ++++++++++++++++++++++++++++-
> >  drivers/android/binder_trace.h      |  4 ++
> >  include/uapi/linux/android/binder.h |  1 +
> >  3 files changed, 87 insertions(+), 3 deletions(-)
> >
> > --
> > 2.36.1.124.g0e6072fb45-goog
> >
> > _______________________________________________
> > devel mailing list
> > devel@linuxdriverproject.org
> > http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
>
>
> Hi,
>
> This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
> You have sent him a patch that has triggered this response.
>
> Right now, the development tree you have sent a patch for is "closed"
> due to the timing of the merge window.  Don't worry, the patch(es) you
> have sent are not lost, and will be looked at after the merge window is
> over (after the -rc1 kernel is released by Linus).
>
> So thank you for your patience and your patches will be reviewed at this
> later time, you do not have to do anything further, this is just a short
> note to let you know the patch status and so you don't worry they didn't
> make it through.

Hi Greg and all reviewers,

The rc-1 has been released for some days. Do I need to resend the patch
v3 [1] again to the maillist? Please let me know what I should do next to
have it reviewed. Thanks!

[1]:
[RESEND PATCH v3 0/1] Binder: add TF_UPDATE_TXN to replace outdated txn
https://lore.kernel.org/lkml/20220526220018.3334775-1-dualli@chromium.org/

>
> thanks,
>
> greg k-h's patch email bot
