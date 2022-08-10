Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476FA58F509
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiHJX66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiHJX64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:58:56 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1406DFB0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:58:54 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10edfa2d57dso19838982fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=/P3kJinfVvS+uCT0mJmVMCdzDCMKM16/QE6DvPfAa/E=;
        b=gyWiONg5w1X7XKCvmNGdYO0ecV90JpsqlJRoRdTqcaCTCUzmhXhfWRfKvsdcp6OZw/
         r7baIfPH/5hWpo6r0Tx9UrYvk+NFmm2nheqqBwpVOz/cXpO17q4S9BiGOQzltc4teHVh
         pnSzQab5Zn2LruyH+ZRqz4oesZquxkc3iLb9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=/P3kJinfVvS+uCT0mJmVMCdzDCMKM16/QE6DvPfAa/E=;
        b=tZg3Lg6l5vPBrbXtHhk4c2T+oZfEWQqc9XObd+0TdqHiCJCFnH3UIg0xIrYUyxkxLz
         N791TCvojTUNY5yXBGvmO/geNscOaENUR4kM+jlPd4atAyWrlda4M1rqfow8N93QU85t
         nMzf9dUqhaScXkWk/3+eALWSUkcfqk6KLYPYRsEfSmGTZn5YqPIwVCStdLODRyM5Tcof
         Q8YJaBbutEi1ZrURIZ9OlNtRhcNQs7g5d48HYdguD9dpltMM5tGhMPeMeZaZJeGvVMnq
         9bk7IOFG/iXvZaT1UgMQqrvgBKRwRD7pk6B9/POzWYcBjotuN10RFhjJlqdiof+Jib1i
         v1jA==
X-Gm-Message-State: ACgBeo32svnFLE79I/0jaMYF/Q/zJJ3YPnmo+1k2PuLcEe+yMRPXZHpK
        qWfpeF4fivlTF51va7I99byGkYaK02vzRY6vnKy8iTzpUl4=
X-Google-Smtp-Source: AA6agR7p6fp1VlGisvNw8pxhRQbVKWvtduI7AzR6dYoMe5LlN5q7jwMt3+AmK4kpvj7/XNjJByWam7bwVHt/imVwBLE=
X-Received: by 2002:a05:6870:41c3:b0:10c:529c:3844 with SMTP id
 z3-20020a05687041c300b0010c529c3844mr2449682oac.0.1660175934044; Wed, 10 Aug
 2022 16:58:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Aug 2022 18:58:53 -0500
MIME-Version: 1.0
In-Reply-To: <CAODwPW-LaaD+ptch=R-S4GWoBDjTgWzfvwjyQeBRETZnnosR7g@mail.gmail.com>
References: <YuuBrUmiRYoaSmPw@google.com> <20220804142856.306032-1-jrosenth@chromium.org>
 <CAE-0n51UcauP1ojoskV9_2+CFPoJrs08jGHVPCZdSA_oXX1zUw@mail.gmail.com>
 <CAODwPW_mYQ1gcd2Xw5s+7dL2kLcYn-VTxKHUH1iM1V4mn7pT_w@mail.gmail.com>
 <CAE-0n504q_NeB9e2BYF8P9Scp7TPqsp9KEWu2DO=ZzbYdJfyew@mail.gmail.com> <CAODwPW-LaaD+ptch=R-S4GWoBDjTgWzfvwjyQeBRETZnnosR7g@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 10 Aug 2022 18:58:53 -0500
Message-ID: <CAE-0n50cVxFhOU7ULfs8KWkhji8-P57ffzC8sAUGFoYzdhnV5w@mail.gmail.com>
Subject: Re: [PATCH v7] firmware: google: Implement cbmem in sysfs driver
To:     Julius Werner <jwerner@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        chrome-platform@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julius Werner (2022-08-10 15:26:30)
> > > We really only care about one of these right now and many of them will
> > > never be relevant to the kernel, but I still thought that while we're
> > > doing this we might as well provide a generic interface to all of them
> > > because others may become useful in the future (and then you don't
> > > have to update the kernel every time you get a new use case for some
> > > userspace tool wanting to interact with some resident data structure
> > > from coreboot).
> >
> > Exposing more than is necessary in the kernel ABI could get into
> > problems with backwards compatibility. It also means we have to review
> > the ABI with the consideration that something may change in the future
> > and cbmem would be exposing something we don't want exposed, or maybe it
> > is writeable when it shouldn't be?
>
> I think we have a bit of a different concept of what this is supposed
> to be. Forget about the vbnv and vboot workbuffer parts for the
> moment, those are where our overall motivation for doing this comes
> from but those should not be concerns for the kernel itself. From the
> kernel's point of view, all we have here is a firmware information
> structure it already knows about (the coreboot tables) pointing to a
> list of opaque, firmware-specific memory buffers labeled with an ID,
> and we want it to expose read and write access to those buffers to
> userspace to make it easier for firmware-specific userspace helper
> tools to work with them. Note that we already have userspace tools
> doing that today anyway, e.g. the `cbmem` utility uses /dev/mem to
> search for and parse the whole coreboot table itself before then using
> it to access individual CBMEM buffers. But implementing all the logic
> to do that in each tool that wants to support anything
> coreboot-specific separately is cumbersome, so we thought that since
> the kernel already has this coreboot table parsing support anyway, we
> might as well export the info to userspace to make this job easier. So
> really all the kernel does here is expose the address, size and ID
> values from the coreboot table itself, it doesn't (and isn't supposed
> to) have any understanding about the pointed to buffer. (We could also
> leave out the `mem` node from this driver and just let our userspace
> utilities read the `address` and `size` nodes and then use that info
> to go through /dev/mem. Giving them a direct `mem` node for the buffer
> just makes that process a bit easier and cleaner.)

Got it. Thanks for the background. Is it possible to create new entries
in the table? Or to resize existing entries? Or to delete entries
entirely?

>
> So backwards compatibility should not be a concern (unless we're
> talking about changes in the coreboot table itself, which we strongly
> try to avoid and which would be an issue for existing kernel drivers
> already anyway). Understanding of these buffers' contents is
> explicitly supposed to be the responsibility of the userspace tool
> that has an easier time keeping up with frequent firmware data format
> changes and maintaining long lists of back-translating routines for
> older structure formats for the specific kind of buffer it looks for
> if necessary (something I specifically wouldn't want to clutter the
> kernel with).

Maybe this answers the question above.

>
> In regards to write access, I don't really see a point restricting
> this since all these buffers are already accessible through /dev/mem
> anyway. But that should only be needed for very few of these buffers
> anyway, so if people think it's a concern I think we could also keep a
> small explicit allowlist for the IDs that can be writable (shouldn't
> need to be updated frequently) and disallow it for everything else.
> Also, of course there's still the normal file system access
> permissions that makes these only writable for root and users
> specifically granted access by root. (Actually, Jack, that reminds
> me... having the `mem` nodes world-readable is maybe not a good idea,
> there's usually not anything specifically secret in there, but since
> /dev/mem also isn't world-readable I think this one probably shouldn't
> either. I'd suggest changing the initial umask to 0660 or 0600.)

The /dev/mem interface has been restricted over the years. At this point
we're trying to steer users away from /dev/mem to anything else. I
suspect it happens to work right now because coreboot tells the kernel
that there isn't actually memory in this address range so that devmem
can map it. I don't know but I wonder if the memory is being mapped
uncached on ARM systems, leading to slower access times? Usually when
memory addresses aren't marked as normal memory that's reserved it
doesn't get mapped until the memremap() time, and that would be mapped
with whatever attributes are used in the call. /dev/mem doesn't optimize
this from what I recall.

>
> > Furthermore, if the ABI that the kernel can expose already exists then
> > we're better off because there may already be userspace programs written
> > for that ABI with lessons learned and bugs ironed out. In this case, I
> > was hoping that it was an nvmem, in which case we could tie it into the
> > nvmem framework and piggyback on the nvmem APIs. It also helps to expose
> > a more generic ABI to userspace instead of developing a bespoke solution
> > requiring boutique software. Of course sometimes things can't be so
> > generic so code has to be written.
>
> Yeah but this isn't anything that can be genericized, this is
> specifically meant for boutique software to maintain its internal data
> structures. vbnv and the vb2_shared_data structure in the workbuffer
> are supposed to be completely internal to vboot and not interpreted by
> any code other than vboot itself -- even coreboot never accesses them
> directly (only by linking in vboot functions and calling those). We
> explicitly don't want to deal with having to sync data structure
> format changes to anywhere outside the vboot repository. The problem
> is just that unlike most software, vboot is a framework that contains
> both firmware and userspace components, so the latter necessarily need
> some help from the kernel (as an oblivious forwarder of opaque data)
> to be able to access the internal data structures passed on from the
> former.

Fair enough. How similar is this to efivars? I don't know, and you may
not either, but at a high level it looks similar. The sysfs interface to
efivars was deprecated and I saw recently that there's an effort to
remove it entirely. The new way of interacting with those firmware
variables is through a filesystem that's mounted at
/sys/firmware/efi/efivars. The documentation[1] states that the sysfs
interface didn't work when the variables got large. Hopefully that won't
be a similar scenario here?

[1] https://www.kernel.org/doc/html/latest/filesystems/efivarfs.html`
