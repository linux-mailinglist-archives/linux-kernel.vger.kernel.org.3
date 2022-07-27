Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12E3583546
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiG0WSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiG0WRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:17:50 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C72E7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XvXJVy+rBpIQJ76z/DziDFa5OupRHVC9qObedvsCnsA=; b=jZHqO3FR97EkpZ9ambN5N9aUWH
        5FSiv/oTs8VAwGfI6PKG0FTWesEdeHTk97YaL4nFFpXQRHJ3b4NcxVXTS2CzoJWGLwvS1WITpvUBc
        mNhdPQejhhDQcJYDC3Ql6XNAxZTJLL6QewzCj9tqxHvYBcJYqonDGZTJpumY/hLtmSV3kj2NEQFS5
        IWmJjwuRw5HLJk7AYQfEwyrAnzqMF6sU24e6zPwn5/CL7mmGwnA7qQ+8lI7QnMyQmEubhX0rDRLMk
        aZJ/DgNOnUWXtb4ZO0M0MUnBdWkvSsyaoyd5D+VHdLTMpcVa83+qZyD4iXPM6Ri0QnExaKOeYA4Md
        PIULhafQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33598)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oGpKA-0005hS-A0; Wed, 27 Jul 2022 23:16:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oGpK4-0002cD-Vm; Wed, 27 Jul 2022 23:16:08 +0100
Date:   Wed, 27 Jul 2022 23:16:08 +0100
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
Message-ID: <YuG5KCksLWzThSmF@shell.armlinux.org.uk>
References: <20220727181936.3250466-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727181936.3250466-1-saravanak@google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 11:19:35AM -0700, Saravana Kannan wrote:
> The uevents generated for an amba device need PID and CID information
> that's available only when the amba device is powered on, clocked and
> out of reset. So, if those resources aren't available, the information
> can't be read to generate the uevents. To workaround this requirement,
> if the resources weren't available, the device addition was deferred and
> retried periodically.
> 
> However, this deferred addition retry isn't based on resources becoming
> available. Instead, it's retried every 5 seconds and causes arbitrary
> probe delays for amba devices and their consumers.
> 
> Also, maintaining a separate deferred-probe like mechanism is
> maintenance headache.
> 
> With this commit, instead of deferring the device addition, we simply
> defer the generation of uevents for the device and probing of the device
> (because drivers needs PID and CID to match) until the PID and CID
> information can be read. This allows us to delete all the amba specific
> deferring code and also avoid the arbitrary probing delays.

Oh, this is absolutely horrible. I can apply it cleanly to my "misc"
branch, but it then conflicts when I re-merge my tree for the for-next
thing (which is only supposed to be for sfr - the hint is in the name!)
for-next is basically my "fixes" plus "misc" branch and anything else I
want sfr to pick up for the -next tree.

Applying this has to be on top of that merge commit, otherwise the
conflicts are horrid, but that then means I need to send Linus the
for-next merge commit (which I don't normally do.)

Gah, we have too many changes to drivers/bus/amba.c in this cycle,
some of them which have been submitted for 5.19 as fixes (and thus
are not in 5.18-rc1 which the misc branch is based upon for other
patch dependency reasons) and others in the misc branch for the next
cycle - and now your patch wants both, which I can't do without
rebasing the misc branch.

Sadly, getting these changes into GregKH's tree will just create a
conflict between Greg's tree and my tree.

Can we postpone this please?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
