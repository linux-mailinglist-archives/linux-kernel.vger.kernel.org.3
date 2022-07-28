Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A485841DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiG1Ohp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiG1Of6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:35:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FC1210
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DB74B82484
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6476C433C1;
        Thu, 28 Jul 2022 14:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659018952;
        bh=hfLZjBE1fb1dDdjy6Z4zAo2KemJIpECIRbic+IghPxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bu3xiGaESF9B69Q+fTKdfYq+HIdetua/aWALWAAjEmBwpKzDsqqqIYzc1qm2+l3c9
         0426SnCa6vzOpzQc9vlGZlJqlzGG66u5TZ1BSvmTFvYvdfjQKXdTrZEn0YXFyRCMTy
         ULk1vY8w1uiaGHzWxGLEubsOmO/nFqhIOm/2kceU=
Date:   Thu, 28 Jul 2022 16:35:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Dipanjan Das <mail.dipanjan.das@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, fmdefrancesco@gmail.com,
        Eric Dumazet <edumazet@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
Subject: Re: KASAN: use-after-free Read in post_one_notification
Message-ID: <YuKexZ7hqaHEsgQe@kroah.com>
References: <CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com>
 <YuIyKjvQ0vOeRWhl@kroah.com>
 <CAKXUXMzp=b7MTZmwzjO=i3P1ftnDLGNV7tvtwDHhF=ZbyySqzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXUXMzp=b7MTZmwzjO=i3P1ftnDLGNV7tvtwDHhF=ZbyySqzw@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 04:10:25PM +0200, Lukas Bulwahn wrote:
> On Thu, Jul 28, 2022 at 8:52 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 27, 2022 at 02:28:45PM -0700, Dipanjan Das wrote:
> > > Hi,
> > >
> > > We would like to report the following bug which has been found by our
> > > modified version of syzkaller.
> > >
> > > ======================================================
> > > description: KASAN: use-after-free Read in post_one_notification
> > > affected file: kernel/watch_queue.c
> > > kernel version: 5.10.131
> > > kernel commit: 8f95261a006489c828f1d909355669875649668b
> > > git tree: upstream
> > > kernel config: https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
> > > crash reproducer: attached
> > > patch: This bug was previously reported by syzkaller for kernel
> > > version 5.17. The same patch works for kernel version 5.10 as well,
> > > i.e., we tested that the repro can no longer triggers the reported
> > > crash with this patch:
> > > https://syzkaller.appspot.com/text?tag=Patch&x=13b8c83c080000
> >
> > I'm sorry, I do not understand.  So this is fixed in Linus's tree?  But
> > not in 5.10.y?  Or it is not fixed everywhere?
> >
> > If it is fixed, what is the git commit id of the patch in Linus's tree
> > that fixes this that should be backported to 5.10.y?
> >
> > confused,
> >
> 
> I will try to help our poor confused kernel maintainers here with some
> quick background information I could quickly find (just out of
> curiosity on what these reports are all about...). Maybe, next time,
> the bug reporters can do that simple and basic investigation before
> reporting, and provide that information in a condensed form and at the
> right point in time, so Greg or Sasha can really act upon that.
> 
> For the syzkaller-found KASAN bug report above, there is a patch in
> discussion (https://lore.kernel.org/lkml/182407602ce.190e58816827.7904364186178466266@siddh.me/)
> to resolve the issue in mainline. As of writing, the author still
> intends to provide a proper working v3 patch, which then might be
> applied by David Howells. So far, this patch has not been in
> linux-next, nor even Linus Torvalds' tree (mainline). The reporters in
> this email suggest that this patch once it reaches mainline can be
> backported to the 5.10 stable branch to resolve an existing
> syzkaller-triggered bug in the v5.10 versions.
> 
> Dipanjan, are you aware of the preferred options to work with stable
> maintainers mentioned in
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html?
> Please read that page if you have not done that yet.
> 
> Dipanjan, could you please follow and influence the development and
> handling of the patch above?
> 
> Either, you can achieve that the patch is already prepared properly,
> so that it is picked up to stable due to the meta-information in the
> patch commit message (Option 1 in the stable-kernel-rules, preferred).
> Or, after the patch has been merged to Linus’ tree, send an email to
> stable@vger.kernel.org containing the subject of the patch, the commit
> ID, why you think it should be applied, and what kernel version you
> wish it to be applied to (Option 2 in stable-kernel-rules, if Option 1
> is not successful).
> 
> I believe that this above is a good way (maybe even the best way) to
> interact with the kernel community and its stable maintainers and get
> the issues resolved that you are reporting.
> 
> 
> I hope this helps,

Wonderful, that was a great write up, thank you for doing that!

It helped me, now to just wait for the commits to land in Linus's
tree...

thanks,

greg k-h
