Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6EA57C6CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiGUIuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGUIuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:50:15 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B26EB4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Rk/aX50MwzZ83ghgQLTLTJVjsWpYCc/vPUglmdR9NS0=; b=m6Lpl+KIQXkLBLKTqSg58v8vgY
        MSMeXu0/hxR0tuu7sADwKP77680vVT08h5BzBXJuTHnxhY3uQaOKnm0M0eoszN0REPG1RLI6z97LZ
        sRBGXCMWHc2GZwPOTTHo5hNA68RGVlhK3bNC8+2G+l6BaP5N7GfqjZF32OfAQ6mIbJ5QtkGh8hoVk
        CMylsKu/m06CAYO/bFqSV1jMysAydhs91wRngY/qYNPxDR1CHxnMnCInbLQk5yEQh2hmadXoO/xJ/
        vlRqGmJD0AonanT5MWuEOpultqCRMeznG0N94jToD3Yw6zhYdnn1Fs3ueKfpiKOcdDlFxTcOT7gaO
        +SsB1kIQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33476)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oERsX-0004zm-Nc; Thu, 21 Jul 2022 09:49:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oERsR-0004ix-Vy; Thu, 21 Jul 2022 09:49:48 +0100
Date:   Thu, 21 Jul 2022 09:49:47 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
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
Message-ID: <YtkTK3QS0PQ2LRpM@shell.armlinux.org.uk>
References: <20220719182010.637337-1-saravanak@google.com>
 <20220720131221.azqfidkry3cwiarw@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720131221.azqfidkry3cwiarw@bogus>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 02:12:21PM +0100, Sudeep Holla wrote:
> On Tue, Jul 19, 2022 at 11:20:10AM -0700, Saravana Kannan wrote:
> > The uevents generated for an amba device need PID and CID information
> > that's available only when the amba device is powered on, clocked and
> > out of reset. So, if those resources aren't available, the information
> > can't be read to generate the uevents. To workaround this requirement,
> > if the resources weren't available, the device addition was deferred and
> > retried periodically.
> > 
> > However, this deferred addition retry isn't based on resources becoming
> > available. Instead, it's retried every 5 seconds and causes arbitrary
> > probe delays for amba devices and their consumers.
> > 
> > Also, maintaining a separate deferred-probe like mechanism is
> > maintenance headache.
> > 
> > With this commit, instead of deferring the device addition, we simply
> > defer the generation of uevents for the device and probing of the device
> > (because drivers needs PID and CID to match) until the PID and CID
> > information can be read. This allows us to delete all the amba specific
> > deferring code and also avoid the arbitrary probing delays.
> > 
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> 
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> on Juno with linux-next(which had the reported issue [1]) + this patch(which
> fixes the issue)

Ok, but this patch needs to end up in the patch system for me to apply
it. Can someone please add "KernelVersion: 5.19-rc7" or whatever version
the patch was generated against (just the tagged version is sufficient)
somewhere in the email, and send it to patches@armlinu.org.uk.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
