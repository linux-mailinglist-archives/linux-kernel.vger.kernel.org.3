Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A5A4A63A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiBASUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiBASUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:20:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC9DC061714;
        Tue,  1 Feb 2022 10:20:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 153AB61027;
        Tue,  1 Feb 2022 18:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B913C340EB;
        Tue,  1 Feb 2022 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643739621;
        bh=em+vHnnyjV6c2ZNP0WfuUxJhyuxOcSLdUVobugDTGP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZI1a4lyPGenMadpoxoNGD+avqNAVXi4RhuCOgdJa2PXA52waCNwX4hCPQDt4mQzxK
         rxwi9pfCrBIEr+TR77KVJiyfQUPXNdMd3eU0HiC1lkIv1K00ENJvTIp/t2u3IypAe5
         FTDU81thcWYwx854ZGzxLjOIp4VozCilNS+gO58E=
Date:   Tue, 1 Feb 2022 19:20:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Igor Pylypiv <ipylypiv@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changyuan Lyu <changyuanl@google.com>
Subject: Re: [PATCH] Revert "module, async: async_synchronize_full() on
 module init iff async is used"
Message-ID: <Yfl54vabXIbjpIGe@kroah.com>
References: <20220127233953.2185045-1-ipylypiv@google.com>
 <CAHk-=whM5sHbOboEnPSfBZPQrLB-KCtzE+JXFxFRNgT95i37bw@mail.gmail.com>
 <Yfl4Othg/8VWpd3u@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfl4Othg/8VWpd3u@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 08:13:14AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Jan 28, 2022 at 09:39:12AM +0200, Linus Torvalds wrote:
> > However, we've done this for *so* long that I wonder if there might be
> > situations that have ended up depending on the lack of synchronization
> > for pure performance reasons.
> > 
> > If *this* module loading process started the async work, then we'd
> > wait for it, but what if there's other async work that was started by
> > others? This revert would now make us wait for that async work too,
> > and that might be a big deal slowing things down at boot time.
> > 
> > Looking at it, this is all under the 'module_mutex', so I guess we are
> > already single-threaded at least wrt loading other modules, so the
> > amount of unrelated async work going on is presumably fairly low and
> > that isn't an issue.
> 
> Looks like we're multi-threaded while running the mod inits which launch the
> async jobs and single-threaded while waiting for them to finish. Greg should
> know a lot better than me but according to my hazy memory and cursory code
> reading udev is multi-processed when loading modules, which makes it a lot
> less likely that this will impact boot time in most cases.

I think userspace is multi-processed here, which should help with the
reading of the modules from disk at boot while others are actually being
loaded due to the kernel lock.

> > Anyway, I think this patch is the right thing to do, but just the fact
> > that we've avoided that async wait for so long makes me a bit nervous
> > about fallout from the revert.
> > 
> > Comments? Maybe this is a "just apply it, see if somebody screams" situation?
> 
> So, yeah, I think the risk is pretty low and even in the unlikely case that
> someone is affected, the workaround is pretty straight-forward - not waiting
> for the module loading to finish if appropriate.

I agree with Linus, let's see if anyone notices :)

thanks,

greg k-h
