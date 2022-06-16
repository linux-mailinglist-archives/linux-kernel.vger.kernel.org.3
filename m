Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB154DA13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358719AbiFPF7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFPF7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC51C923
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A02A56194A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94654C34114;
        Thu, 16 Jun 2022 05:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655359144;
        bh=b4A4VNl/LgWLcUdooFZJNKQj5iG2ufoQCYarK6CXRxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OSYb4mpA3ySlb9kAHuiJveswpF1U4e2Cp0NN/B0HqDN/COwm7gz/Yw2n+79mFpek1
         fqkR6Mi++WnL2+lurNAljNz+xB+YVDrTAucvxDaVXcqi3Eqy92+7TkR4Fq5+yzFh68
         uH2dIFEnsuwG1ue9LyJA8KavhsJ9KkQTimcCGl+A=
Date:   Thu, 16 Jun 2022 07:58:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Li <dualli@chromium.org>
Cc:     Li Li <dualli@google.com>, Todd Kjos <tkjos@google.com>,
        Christian Brauner <christian@brauner.io>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [RESEND PATCH v3 0/1] Binder: add TF_UPDATE_TXN to replace
 outdated txn
Message-ID: <YqrGopRiQOsezMPY@kroah.com>
References: <20220526220018.3334775-1-dualli@chromium.org>
 <YpBmmVa+09ZhP9LH@kroah.com>
 <CANBPYPg_cpaTCcJ=5b3j3L3KHg=D7Xnj14wkHq5YMznu=3en8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANBPYPg_cpaTCcJ=5b3j3L3KHg=D7Xnj14wkHq5YMznu=3en8g@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:05:23AM -0700, Li Li wrote:
> On Thu, May 26, 2022 at 10:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, May 26, 2022 at 03:00:17PM -0700, Li Li wrote:
> > > From: Li Li <dualli@google.com>
> > >
> > > Resend [Patch v3] with cover letter in case my previous email failed
> > > to reach the maillist (no comments for 2 weeks).
> > >
> > > The previous comments of the old patch can be found at the following link:
> > > https://lore.kernel.org/lkml/CANBPYPjkNWsO94nuG1TkR1DgK2W2kBxiJTriyVB7S3czHTZ1Yg@mail.gmail.com/
> > >
> > > I copy and paste the key information here for your convenience.
> > >
> > > * Question #1
> > >
> > > Note, your subject does not say what TF_UPDATE_TXN is, so it's a bit
> > > hard to determine what is happening here.  Can you clean that up a bit
> > > and sumarize what this new addition does?
> > > How was this tested?
> > >
> > > * Answer #1 ===
> > >
> > > A more descriptive summary has been added to the new version of patch.
> > >
> > > *  Question #2
> > >
> > > How was this tested?
> > >
> > > * Answer #2
> > >
> > > Old kernel: without this TF_UPDATE_TXN patch
> > > New kernel: with this TF_UPDATE_TXN patch
> > > Old apps: without setting TF_UPDATE_TXN
> > > New apps: if (flags & TF_ONE_WAY) flags |= TF_UPDATE_TXN;
> > >
> > > 1. Compatibility: New kernel + Old apps, to verify the original
> > > behavior doesn't change;
> > >
> > > 2. Compatibility: Old kernel + New apps, to verify the original
> > > behavior doesn't change;
> > >
> > > 3. Unit test: New kernel + New apps, to verify the outdated oneway
> > > binder transaction is actually superseded by the latest one (by
> > > enabling BINDER_DEBUG logs);
> > >
> > > 4. Stress test: New kernel + New apps sending oneway binder
> > > transactions repeatedly, to verify the size of the available async
> > > binder buffer over time, and if the transactions fail as before
> > > (due to async buffer running out).
> > >
> > > * Question #3
> > >
> > > Did checkpatch pass this?  Please always use --strict and fix up all the
> > > issues that it reports as this is not a normal kernel coding style.
> > >
> > > * Answer #3
> > >
> > > Yes, the latest version has passed "./scripts/checkpatch.pl --strict"
> > >
> > > * Changelog
> > >
> > > v3:
> > >   - Add this changelog required by "The canonical patch format"
> > > v2:
> > >   - Fix alignment warnings reported by checkpatch --strict
> > >   - Add descriptive summary in patch subject
> > >
> > > Li Li (1):
> > >   Binder: add TF_UPDATE_TXN to replace outdated txn
> > >
> > >  drivers/android/binder.c            | 85 ++++++++++++++++++++++++++++-
> > >  drivers/android/binder_trace.h      |  4 ++
> > >  include/uapi/linux/android/binder.h |  1 +
> > >  3 files changed, 87 insertions(+), 3 deletions(-)
> > >
> > > --
> > > 2.36.1.124.g0e6072fb45-goog
> > >
> > > _______________________________________________
> > > devel mailing list
> > > devel@linuxdriverproject.org
> > > http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
> >
> >
> > Hi,
> >
> > This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
> > You have sent him a patch that has triggered this response.
> >
> > Right now, the development tree you have sent a patch for is "closed"
> > due to the timing of the merge window.  Don't worry, the patch(es) you
> > have sent are not lost, and will be looked at after the merge window is
> > over (after the -rc1 kernel is released by Linus).
> >
> > So thank you for your patience and your patches will be reviewed at this
> > later time, you do not have to do anything further, this is just a short
> > note to let you know the patch status and so you don't worry they didn't
> > make it through.
> 
> Hi Greg and all reviewers,
> 
> The rc-1 has been released for some days. Do I need to resend the patch
> v3 [1] again to the maillist? Please let me know what I should do next to
> have it reviewed. Thanks!

If it still applies, no need to resend.

I'm waiting for the other binder maintainers to review it before doing
anything with it.

thanks

greg k-h
