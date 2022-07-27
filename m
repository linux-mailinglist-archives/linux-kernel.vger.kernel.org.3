Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D8458215C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiG0Hnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiG0Hnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:43:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1045D3719A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98937B81EB9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5A3C433C1;
        Wed, 27 Jul 2022 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658907815;
        bh=0IZtoatpXCh/iT1PMIYHTOqCiq0Jo3hX13tZ90/Ib8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYmIframm6vtblHv2amc5pNgIDeiDXQlFUvZUQFihJqvbRv0VIqEq1bcPqSGZN0UI
         H7jF1//MLsuHEVL6gJHgZK//lucIKqfI/0FmMJrE/BfHVLyTHFg4KdOxfOrcf+GBqS
         P5ndcKtv2vcK06tRTQoB+DgaYxwbZoNUr/gEgoZo=
Date:   Wed, 27 Jul 2022 09:43:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] amba: Remove deferred device addition
Message-ID: <YuDspJ4+S1BsKLOi@kroah.com>
References: <20220719182010.637337-1-saravanak@google.com>
 <20220720131221.azqfidkry3cwiarw@bogus>
 <YtkTK3QS0PQ2LRpM@shell.armlinux.org.uk>
 <CAGETcx8mVqX+FRiD9_PahpfQQ1CjG0FxN08pN7jgj+D4x2QjhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8mVqX+FRiD9_PahpfQQ1CjG0FxN08pN7jgj+D4x2QjhQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 02:58:27PM -0700, Saravana Kannan wrote:
> On Thu, Jul 21, 2022 at 1:50 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Jul 20, 2022 at 02:12:21PM +0100, Sudeep Holla wrote:
> > > On Tue, Jul 19, 2022 at 11:20:10AM -0700, Saravana Kannan wrote:
> > > > The uevents generated for an amba device need PID and CID information
> > > > that's available only when the amba device is powered on, clocked and
> > > > out of reset. So, if those resources aren't available, the information
> > > > can't be read to generate the uevents. To workaround this requirement,
> > > > if the resources weren't available, the device addition was deferred and
> > > > retried periodically.
> > > >
> > > > However, this deferred addition retry isn't based on resources becoming
> > > > available. Instead, it's retried every 5 seconds and causes arbitrary
> > > > probe delays for amba devices and their consumers.
> > > >
> > > > Also, maintaining a separate deferred-probe like mechanism is
> > > > maintenance headache.
> > > >
> > > > With this commit, instead of deferring the device addition, we simply
> > > > defer the generation of uevents for the device and probing of the device
> > > > (because drivers needs PID and CID to match) until the PID and CID
> > > > information can be read. This allows us to delete all the amba specific
> > > > deferring code and also avoid the arbitrary probing delays.
> > > >
> > > > Cc: Rob Herring <robh@kernel.org>
> > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > >
> > > Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> > >
> > > on Juno with linux-next(which had the reported issue [1]) + this patch(which
> > > fixes the issue)
> >
> > Ok, but this patch needs to end up in the patch system for me to apply
> > it. Can someone please add "KernelVersion: 5.19-rc7" or whatever version
> 
> Where am I supposed to add that? Just somewhere in the email body?
> 
> The patch you are replying to was based on your linu-arm/for-next the
> day I sent it. Do you still need me to rebase it on Linus's tree?
> 
> > the patch was generated against (just the tagged version is sufficient)
> > somewhere in the email, and send it to patches@armlinu.org.uk.
> 
> I'll send out the same patch as is to that email. Wait, is there a
> typo in the domain name? Did you leave out the x by accident or is it
> really armlinu? I'm also getting a DNS failure for either one of those
> domains.
> 
> I'll wait to hear from you before I send another email.

Odd, I don't see the requirement for the arm patch-bot for the amba bus
code anywhere in the documentation, am I missing it?

Anyway, I can take this now if no one objects, through my driver-core
tree so that it can get into 5.20-rc1.

thanks,

greg k-h
