Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED36F582193
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiG0Hx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiG0Hx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:53:58 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCF7422F7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4FQRdaiEmjW2on5jtXkWdtqctpeHbZ2jbFFYhzy/xGE=; b=DoQlz2/A3iAlE2X5WpW3dTwslw
        sTn4Y4/XG+o0XzQudWorqjNypVPPgtJc0KRB3J/aeqIcKwV5hX7bvwKz6dBTQdDTD6v17jT2inaDP
        F+ZCHE2Petyxe5cyoZis3Aq50z55F5DulGE/rX7HAFgEXz0n5uYjUJjCg3zFlw9xwWAP5sxJqh6Rx
        RnG77UL5sBplRhYiQi9OGtLgpi07aYKUWCo6n9VYfyJGNwGFSJ4sXTtlXohIbzRfNUKvmm5xODUZc
        Z4U7qI7RQUohgglPFC9F2gQ5aHp/Ue2cxGEVRLwNgwyInkiuTeepHfN4dcUtPTgMjHI3VojxVip6q
        4ABh3niw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33592)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oGbrR-00054a-4F; Wed, 27 Jul 2022 08:53:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oGbrL-000271-D8; Wed, 27 Jul 2022 08:53:35 +0100
Date:   Wed, 27 Jul 2022 08:53:35 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
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
Message-ID: <YuDu/w+Z3RfEYxYN@shell.armlinux.org.uk>
References: <20220719182010.637337-1-saravanak@google.com>
 <20220720131221.azqfidkry3cwiarw@bogus>
 <YtkTK3QS0PQ2LRpM@shell.armlinux.org.uk>
 <CAGETcx8mVqX+FRiD9_PahpfQQ1CjG0FxN08pN7jgj+D4x2QjhQ@mail.gmail.com>
 <YuDspJ4+S1BsKLOi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuDspJ4+S1BsKLOi@kroah.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 09:43:32AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 21, 2022 at 02:58:27PM -0700, Saravana Kannan wrote:
> > On Thu, Jul 21, 2022 at 1:50 AM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Jul 20, 2022 at 02:12:21PM +0100, Sudeep Holla wrote:
> > > > On Tue, Jul 19, 2022 at 11:20:10AM -0700, Saravana Kannan wrote:
> > > > > The uevents generated for an amba device need PID and CID information
> > > > > that's available only when the amba device is powered on, clocked and
> > > > > out of reset. So, if those resources aren't available, the information
> > > > > can't be read to generate the uevents. To workaround this requirement,
> > > > > if the resources weren't available, the device addition was deferred and
> > > > > retried periodically.
> > > > >
> > > > > However, this deferred addition retry isn't based on resources becoming
> > > > > available. Instead, it's retried every 5 seconds and causes arbitrary
> > > > > probe delays for amba devices and their consumers.
> > > > >
> > > > > Also, maintaining a separate deferred-probe like mechanism is
> > > > > maintenance headache.
> > > > >
> > > > > With this commit, instead of deferring the device addition, we simply
> > > > > defer the generation of uevents for the device and probing of the device
> > > > > (because drivers needs PID and CID to match) until the PID and CID
> > > > > information can be read. This allows us to delete all the amba specific
> > > > > deferring code and also avoid the arbitrary probing delays.
> > > > >
> > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > >
> > > > Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> > > >
> > > > on Juno with linux-next(which had the reported issue [1]) + this patch(which
> > > > fixes the issue)
> > >
> > > Ok, but this patch needs to end up in the patch system for me to apply
> > > it. Can someone please add "KernelVersion: 5.19-rc7" or whatever version
> > 
> > Where am I supposed to add that? Just somewhere in the email body?
> > 
> > The patch you are replying to was based on your linu-arm/for-next the
> > day I sent it. Do you still need me to rebase it on Linus's tree?
> > 
> > > the patch was generated against (just the tagged version is sufficient)
> > > somewhere in the email, and send it to patches@armlinu.org.uk.
> > 
> > I'll send out the same patch as is to that email. Wait, is there a
> > typo in the domain name? Did you leave out the x by accident or is it
> > really armlinu? I'm also getting a DNS failure for either one of those
> > domains.
> > 
> > I'll wait to hear from you before I send another email.
> 
> Odd, I don't see the requirement for the arm patch-bot for the amba bus
> code anywhere in the documentation, am I missing it?

The requirement for the arm patch-bot is "patches that I apply", and
since I'm listed as maintainer for that code...

Sorry I missed the original reply highlighting the typo. Yes, it's a
typo (my X key was being a bit dodgy last week) and in any case,
"armlinu.org.uk" doesn't exist in the DNS, so sending to it would fail.
Also, every email I've sent over the last decade or more contains a
signature that gives a URL to the patch system, and the email address
is mentioned in its "Help" page (although there's other stuff on the
help page that needs to be updated to current practices.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
