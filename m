Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA15C565CDD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiGDRWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGDRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:22:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32272F3A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3ndzGVlVbkVaywI6r7odCA2Kg058VQBtvXU315FbM2s=; b=ecpi2NX5r1TO79NYlEAt0lCoWW
        wKAIx3JXSzYB4OBPNtmnIQH0ZIWi11soXlUsxGJSr6Tcf0BVHmgIHJMEM0zd8oEp/3xGTlhc+20RY
        cedkgFAc2BdYbtLTXaiCKj62je0iGBE31FZ5YYB9GY3hBbJnR9GEIcFwnNrQn2StilGd1qGFureuk
        IkyaDnc3nr7WMIGIOnsOmA9QOyGJIB8eb45Dqe7aBqzvxF78dIvrzCBvBuYCfYU0IRT5Ihr36MfsO
        TRS4Oy4+GPil21Acw4uZ0dbWmNe+zjZzL97Yp5exEutWCle7kxflukJAs+3tW9Zg2Ow5UymAGNV/j
        4OGp9iVg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33170)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o8Pm8-0000LL-TA; Mon, 04 Jul 2022 18:22:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o8Pm6-0002WN-13; Mon, 04 Jul 2022 18:22:18 +0100
Date:   Mon, 4 Jul 2022 18:22:17 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/14] arm: Rename PMD_ORDER to PMD_BITS
Message-ID: <YsMhyUfa2wNNLa+t@shell.armlinux.org.uk>
References: <20220703141203.147893-1-rppt@kernel.org>
 <20220703211441.3981873-1-willy@infradead.org>
 <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
 <YsIQKdYiswzq5kTG@casper.infradead.org>
 <YsJtYYsB/SinnNzI@shell.armlinux.org.uk>
 <YsLFh4naDbzGpDWB@casper.infradead.org>
 <YsLPxDLRT6fVLaOM@shell.armlinux.org.uk>
 <YsL492bvHEo4a73M@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsL492bvHEo4a73M@casper.infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 03:28:07PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 04, 2022 at 12:32:20PM +0100, Russell King (Oracle) wrote:
> > On Mon, Jul 04, 2022 at 11:48:39AM +0100, Matthew Wilcox wrote:
> > > On Mon, Jul 04, 2022 at 05:32:33AM +0100, Russell King (Oracle) wrote:
> > > > On Sun, Jul 03, 2022 at 10:54:49PM +0100, Matthew Wilcox wrote:
> > > > > On Sun, Jul 03, 2022 at 10:16:45PM +0100, Russell King (Oracle) wrote:
> > > > > > On Sun, Jul 03, 2022 at 10:14:41PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > > > > This is the number of bits used by a PMD entry, not the order of a PMD.
> > > > > > 
> > > > > > No, it's not the number of bits. A PMD entry doesn't fit in 2 or 3 bits.
> > > > > > This is even more confusing.
> > > > > 
> > > > > Well, what is it then?  The order of something is PAGE_SIZE << n, and
> > > > > that doesn't seem to be what this is.
> > > > 
> > > > Where is it defined that "order" means "PAGE_SIZE << n" ?
> > > 
> > > include/asm-generic/getorder.h: * get_order - Determine the allocation order of a memory size
> > 
> > I really don't care - "order" is something that is a standard term,
> 
> The word "order" has many different uses, just in mathematics alone (to
> say nothing of its uses in biology, business, the military, religion,
> or signal processing).
> 
> https://en.wikipedia.org/wiki/Order_(mathematics)

Right, and no one of those listed there has a claim to exclusive use of
the term over any of the others. That even lists the meaning that I'm
referring to - "Orders of Magnitude".

https://en.wikipedia.org/wiki/Order_of_magnitude

"Other orders of magnitude may be calculated using bases other than 10."

This usage you don't like is to use ORDER in the kernel to mean "orders
of magnitude in base 2" in it's purest form. The calculation here is
address = index << PMD_ORDER which is the same as address = index *
2^PMD_ORDER.

I have no suggestion for you other than what Mike has put forward, which
retains the use of ORDER. If you still object to the use of ORDER, then
I'm sorry, but I have no further suggestions.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
