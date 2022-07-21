Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7638757C9C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiGULaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiGULad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AFC2CE24
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52F1361AAC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB09C3411E;
        Thu, 21 Jul 2022 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658403031;
        bh=gIU05DjFlkodFloAR0LapBs8EY/oYW4Iwpe7LC1pqac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZLO9qZOzZQ2f8axx0+Wh0wpg9T8anGP6Mym+njmlF2fBkHNS8f8V/rdQtsxtzcRa
         MtPqMFL8z22wwfxOCdjj+dwwSuhhg8ogObkzHbhS5RoOhe7pMUYdh2yOMYJWY1ZQZI
         aOGuA4IRA6O8SDAAnSqxGOSHgeNtQia9A9CcqKjmGvZ1LFoFrRSXyINTjicUiAAzS1
         Kaw1Bb43dB05oOsNcbiRlZuIsWLzdKXBNP6sJ6ywyjUXW5Y7fsdmEZQ+3F2kU8PcAf
         OE9YoWviYYqcnhK4mbiWHf6wguhvr+/A20/zoiiDbhg0Le0G6RK3UgSvxHGCDIbs3Q
         lm74OjMMtUeBw==
Date:   Thu, 21 Jul 2022 12:30:18 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] amba: Remove deferred device addition
Message-ID: <Ytk4yqbW+P3ZUQgb@google.com>
References: <20220719182010.637337-1-saravanak@google.com>
 <20220720131221.azqfidkry3cwiarw@bogus>
 <YtkTK3QS0PQ2LRpM@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtkTK3QS0PQ2LRpM@shell.armlinux.org.uk>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022, Russell King (Oracle) wrote:

> On Wed, Jul 20, 2022 at 02:12:21PM +0100, Sudeep Holla wrote:
> > On Tue, Jul 19, 2022 at 11:20:10AM -0700, Saravana Kannan wrote:
> > > The uevents generated for an amba device need PID and CID information
> > > that's available only when the amba device is powered on, clocked and
> > > out of reset. So, if those resources aren't available, the information
> > > can't be read to generate the uevents. To workaround this requirement,
> > > if the resources weren't available, the device addition was deferred and
> > > retried periodically.
> > > 
> > > However, this deferred addition retry isn't based on resources becoming
> > > available. Instead, it's retried every 5 seconds and causes arbitrary
> > > probe delays for amba devices and their consumers.
> > > 
> > > Also, maintaining a separate deferred-probe like mechanism is
> > > maintenance headache.
> > > 
> > > With this commit, instead of deferring the device addition, we simply
> > > defer the generation of uevents for the device and probing of the device
> > > (because drivers needs PID and CID to match) until the PID and CID
> > > information can be read. This allows us to delete all the amba specific
> > > deferring code and also avoid the arbitrary probing delays.
> > > 
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Saravana Kannan <saravanak@google.com>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > on Juno with linux-next(which had the reported issue [1]) + this patch(which
> > fixes the issue)
> 
> Ok, but this patch needs to end up in the patch system for me to apply
> it. Can someone please add "KernelVersion: 5.19-rc7" or whatever version
> the patch was generated against (just the tagged version is sufficient)
> somewhere in the email, and send it to patches@armlinu.org.uk.

If this is a part of the submission process for the subsystems/files
you maintain, do you think it would be worth while adding this address
to MAINTAINERS to make it easier for future contributors?
