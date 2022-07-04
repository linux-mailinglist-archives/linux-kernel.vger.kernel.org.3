Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2394564CA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 06:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiGDEcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 00:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDEcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 00:32:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1BA55B2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 21:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YYKbXvB/b/OIVTpzpeh7Y3tTbzRBSh+cFFhkPT74VhM=; b=kGJGgWeKv+2p7fAR+7kqPMnGZO
        4kyvqm6bWq+iYc0ZZxH8sVhRcIOXkj5ECpkMpXhj0ZDtpGQ5Ja6Y86MIQOiTvQ62ugNmGHzNAqE+b
        XTUAc7mjs8xdlunUZG4/zhXv8LDJXZ0A+ex/+1KJaiPBSK25Vx+2MrMI1fB+snkKknCSxjIyYyMkU
        M5AP2AECWelxZo8oCYVuMfKBy6ewJxe9/JBTOSLz5a5UulWc+XqspUP9nTru3rSOeCITiHYCeJma2
        924vw+V1F4fTfts1DsaSY1iEMT9/G8tZUKSLFQhEAB8hdJH5jKSX7R9O69hKLSbWod2Hc3XWRRT56
        eHDmZwxw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33156)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o8DlE-0007tN-NS; Mon, 04 Jul 2022 05:32:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o8DlB-0001r8-97; Mon, 04 Jul 2022 05:32:33 +0100
Date:   Mon, 4 Jul 2022 05:32:33 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/14] arm: Rename PMD_ORDER to PMD_BITS
Message-ID: <YsJtYYsB/SinnNzI@shell.armlinux.org.uk>
References: <20220703141203.147893-1-rppt@kernel.org>
 <20220703211441.3981873-1-willy@infradead.org>
 <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
 <YsIQKdYiswzq5kTG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsIQKdYiswzq5kTG@casper.infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 10:54:49PM +0100, Matthew Wilcox wrote:
> On Sun, Jul 03, 2022 at 10:16:45PM +0100, Russell King (Oracle) wrote:
> > On Sun, Jul 03, 2022 at 10:14:41PM +0100, Matthew Wilcox (Oracle) wrote:
> > > This is the number of bits used by a PMD entry, not the order of a PMD.
> > 
> > No, it's not the number of bits. A PMD entry doesn't fit in 2 or 3 bits.
> > This is even more confusing.
> 
> Well, what is it then?  The order of something is PAGE_SIZE << n, and
> that doesn't seem to be what this is.

Where is it defined that "order" means "PAGE_SIZE << n" ?

"order" here is "order of magnitude" and in this case, it is 2^n, just
like order of magnitude in base 10 is 10^n. So strictly, the usage
here is completely correct, but if you describe "order" as "PAGE_SIZE <<
n" that is no longer an order of magnitude, because it doesn't increase
in an order of magnitude (iow, n = 2 isn't PAGE_SIZE * PAGE_SIZE).

Now, if you're trying to tell me that Linux has decided to define
"order" to be something non-standard, I'll accept that, but then we
shouldn't be renaming stuff that is using it in a standard way.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
