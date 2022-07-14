Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B2C575116
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiGNOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiGNOuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:50:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D94B3B948
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE8ACB826A1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06736C3411C;
        Thu, 14 Jul 2022 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657810250;
        bh=YEeNuwQ1nrLsjZMXbBuC4zod9Ak2GTPFzTlqX52SMDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxuaBhsw8Y74EVYcupDs4Tn3CkHp4Y1ahBMombg/KA81ev5PBhbRrh3ux0O3EzWII
         GwfcPvJiVnAn4cHg5rDQCrvcDhHl5HLzRd0nc8DOoYhURw04zKr4fymn0ibzd9uZ8v
         NrezElzuNMRmtEmromwTpWRHZA65HrWkJFPT+Y9k=
Date:   Thu, 14 Jul 2022 16:50:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] firmware_loader: Replace kmap() with kmap_local_page()
Message-ID: <YtAtQihwVrdymfOX@kroah.com>
References: <20220710101156.26139-1-fmdefrancesco@gmail.com>
 <1891319.taCxCBeP46@opensuse>
 <Ysq+rpkTU1/nquHo@kroah.com>
 <2140056.NgBsaNRSFp@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2140056.NgBsaNRSFp@opensuse>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 08:52:49PM +0200, Fabio M. De Francesco wrote:
> On domenica 10 luglio 2022 13:57:34 CEST Greg Kroah-Hartman wrote:
> > On Sun, Jul 10, 2022 at 01:18:16PM +0200, Fabio M. De Francesco wrote:
> > > On domenica 10 luglio 2022 12:24:41 CEST Greg Kroah-Hartman wrote:
> > > > On Sun, Jul 10, 2022 at 12:11:56PM +0200, Fabio M. De Francesco 
> wrote:
> > > > > The use of kmap() is being deprecated in favor of 
> kmap_local_page().
> > > > > 
> > > > > With kmap_local_page() the mappings are per thread, CPU local, can 
> take
> > > > > page faults, and can be called from any context (including 
> interrupts).
> > > > 
> > > > But that is not the case here for this kmap() instance?
> > > 
> > > I'm not 100% sure to get what you are asking here :-)
> > > Probably you mean that kmap() can work here and you don't see reason 
> for 
> > > converting? Am I understanding correctly?
> > 
> > Yes, that is what I am saying, why is this conversion needed here?  A
> > justification would be nice.
> > 
> > > OK, then...
> > > 
> > > kmap() is being deprecated in favor of kmap_local_page(). Please see 
> > > highmem.rst which I have updated weeks ago (https://docs.kernel.org/vm/
> > > highmem.html).
> > > 
> > > Two main problems with kmap(): (1) It comes with an overhead as mapping 
> > > space is restricted and protected by a global lock for synchronization 
> and 
> > > (2) kmap() also requires global TLB invalidation when the kmap’s pool 
> wraps 
> > > and it might block when the mapping space is fully utilized until a 
> slot 
> > > becomes available.
> > > 
> > > kmap_local_page() should be preferred, where feasible, over all the 
> others.
> > 
> > Ok, that is good to know, thanks for the pointer, you should put this in
> > the changelog text for maintainers who did not know this (like myself)
> > as it makes it easier to review.
> > 
> > > > If this is a
> > > > simple search/replace, why is this not just done once and be done 
> with
> > > > it?
> > > 
> > > No, this job needs code inspection. After more than 25 conversions I 
> can 
> > > say that no more than 30% have been simple search and replace.
> > > 
> > > > > Call kmap_local_page() in firmware_loader wherever kmap() is 
> currently
> > > > > used. In firmware_rw() use the copy_{from,to}_page() helpers 
> instead of
> > > > > open coding the local mappings plus memcpy().
> > > > 
> > > > Isn't that just a different cleanup than the kmap() change?  Or is 
> that
> > > > tied to the fact that the other buffer is now allocated with
> > > > kmap_local_page() instead of kmap()?
> > > 
> > > This kinds of changes have never been considered clean-ups by other 
> > > maintainers (for an example please see commit e88a6a8fece9 ("binder: 
> Use 
> > > memcpy_{to,from}_page() in binder_alloc_do_buffer_copy()"). 
> > > 
> > > Using helpers has always been considered part of the conversions 
> themselves 
> > > and nobody has ever requested further patches for these.
> > > 
> > > > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > ---
> > > > >  drivers/base/firmware_loader/main.c  | 4 ++--
> > > > >  drivers/base/firmware_loader/sysfs.c | 9 ++++-----
> > > > >  2 files changed, 6 insertions(+), 7 deletions(-)
> > > > 
> > > > Did you run this through the firmware test framework?
> > > 
> > > No, sorry. I assumed (wrongly?) that this is one of those cases which 
> don't 
> > > need any tests. However I have nothing against testing. I've done them 
> > > where they were absolutely needed for Btrfs conversions and kexec.
> > 
> > Running the kernel selftests for firmware would be great, please do so
> > for your next version of this patch that fixes the
> > ktest-robot-found-issues.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Greg,
> 
> According to your requests, I extended the changelog text adding those 
> information about why kmap() should be avoided. Then I deleted that unused 
> variable which I had overlooked and finally tested with firmware selftests.
> 
> I see that the outputs of selftests, regardless of running a 5.19.0-rc6  
> kernel with or without my changes, show always the same error:
> 
> "not ok 1 selftests: firmware: fw_run_tests.sh # TIMEOUT 165 seconds".".
> 
> I ran those tests on a QEMU/KVM 32-bits VM, booting a vanilla 5.19.0-rc6 
> kernel with HIGHMEM64GB enabled. 
> 
> As said, outputs don't change with or without my patch. Instead it changes 
> with the latest openSUSE stock kernel (5.18.9-2-pae):
> 
> "ok 1 selftests: firmware: fw_run_tests.sh".
> 
> Unfortunately, I'm not familiar with kernel selftests. Any ideas about what 
> could have made this tests fail? Is it expected? 
> 
> If not, I can try and figure out why these outputs are not what they should 
> be (the second version of my patch can wait the time it takes).

No idea, sorry, Luis might know more.

greg k-h
