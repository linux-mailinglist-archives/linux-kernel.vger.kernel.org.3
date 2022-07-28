Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A274E5840DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiG1OQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG1OQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:16:25 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A90E51A07
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+Bagx5Td94tyBVdOfsjdg+CeGo4NiKd1nGpwyiveCpY=; b=eOPgqSk/7XZXojYlhG59aAdKh+
        VUboJp+xrPJqPo8Wk3XYWtnF5p4uVO3kh13hCRkRBkVoChgcUdmck/wJlwGm32TSGLHikgS1Ztm6c
        AZyT4tDwNw0KAbenRcndf4ld6i7K9JGnOx9e7/iTMXfN/poqTgn4MX+pWdo7f9XXqL4qo7fE13uyk
        LejU8nwj0Dw1IDMBLAmDGxsGDsgbAoOhGeHEp7CY1T+oa+AQO/fFix4ADZwf9zlaPB0x4jT57eTGs
        ACJpGJN9wsU4LIKRuoNp0ksi/VLP2P1f6KdzAcuAYy1avZfOhwBHCfLsyWtxNLQzMHpjiWhVzFSRT
        XznyP/ZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33606)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oH4J6-0006MY-FF; Thu, 28 Jul 2022 15:16:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oH4J1-0003HR-N4; Thu, 28 Jul 2022 15:16:03 +0100
Date:   Thu, 28 Jul 2022 15:16:03 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] amba: Remove deferred device addition
Message-ID: <YuKaI5jJOZ8WQQPU@shell.armlinux.org.uk>
References: <20220727181936.3250466-1-saravanak@google.com>
 <YuG5KCksLWzThSmF@shell.armlinux.org.uk>
 <CAGETcx9HFQa=58XUQ07FVQ_Qqem2La4YcR8_qDbg4uqCT8w3CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9HFQa=58XUQ07FVQ_Qqem2La4YcR8_qDbg4uqCT8w3CQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 05:10:57PM -0700, Saravana Kannan wrote:
> On Wed, Jul 27, 2022 at 3:16 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Jul 27, 2022 at 11:19:35AM -0700, Saravana Kannan wrote:
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
> >
> > Oh, this is absolutely horrible. I can apply it cleanly to my "misc"
> > branch, but it then conflicts when I re-merge my tree for the for-next
> > thing (which is only supposed to be for sfr - the hint is in the name!)
> > for-next is basically my "fixes" plus "misc" branch and anything else I
> > want sfr to pick up for the -next tree.
> 
> Btw, this is the repo I was using because I couldn't find any amba repo.
> git://git.armlinux.org.uk/~rmk/linux-arm.git

I don't maintain a separate repo for amba stuff.

> Is the misc branch visible somewhere because I don't see it in that
> repo? Or is that just a local branch? Also, what does sfr stand for
> (s* for next)?
> 
> In case this helps, all the conflicts are due to this commit:
> 8030aa3ce12e ARM: 9207/1: amba: fix refcount underflow if
> amba_device_add() fails
> 
> It's fixing bugs in code I'm deleting. So if you revert that, I can
> give you a patch that'll apply across 5.18 and 5.19.
> 
> Let me know if you want me to do that.

I dug into what had happened - the patch you mentioned patch 9207/1,
and this also applies to 9208/1 as well although that isn't relevant
for your patch. These two were merged as fixes in v5.19-rc7 via my
fixes branch.

They also appeared for some reason in the misc branch as entirely
separate commits. Because 9207/1 appears in both, your patch applies
cleanly on misc, but when fixes is then merged, it touches the same
code and causes a conflict.

Reverting the commit you mention won't actually fix anything - it'll
only make things much worse, with a conflict then appearing between
my tree and Linus'.

The only sensible thing would be to delete those two duplicated
commits from the misc branch, rebase misc on v5.19-rc7 (thus picking
up those two commits that are already in mainline) and then putting
your patch on top of misc.

This is doable, because there's five commits there, most of them are
trivially small changes, so its not a great loss in terms of the
testing that's already been done.

That appears to work fine - I've just pushed that out with your commit
included, so should be in the final linux-next prior to the merge
window opening this Sunday.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
