Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5356538B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiGDLcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiGDLce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:32:34 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FCCE087
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UkJAPR0iz3R+zsN8qIgeMhUYXuszPO75LpkuxQQlKeE=; b=KDtPdw18wM/ZnXc9HKuV7sKRL1
        EltrcH9UfmeBkRlqI8J0utMV5Z/wX+lKoyE1bWbSXs8WmdMnjQjDixRvh7ZSiKcd7INAZVHOieCcp
        Y2UjdlZ5IBc/CLaI4zF+l5D2kYq2Sj2dg8wLfGEMZgOtKRUISGAvp1YYa5ob4movq4Kk1gqaPcPaw
        hGMRGytQ6SRH8c8STMgO9eUEAkO/A/NI8BmAI5rtxaFhAPgChHrsLSYA7QhuHrtboeVaDRxCjaxKe
        s8T/fac6tkf81Zt7SZU44HWEFSdY6NVwSPekOaN+sxm5MGCDOxRX0cY3cOB3iWj3PK8tVKuI6UQog
        1rRgRBMg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33162)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o8KJS-0008Nl-TO; Mon, 04 Jul 2022 12:32:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o8KJQ-0002Js-Po; Mon, 04 Jul 2022 12:32:20 +0100
Date:   Mon, 4 Jul 2022 12:32:20 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/14] arm: Rename PMD_ORDER to PMD_BITS
Message-ID: <YsLPxDLRT6fVLaOM@shell.armlinux.org.uk>
References: <20220703141203.147893-1-rppt@kernel.org>
 <20220703211441.3981873-1-willy@infradead.org>
 <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
 <YsIQKdYiswzq5kTG@casper.infradead.org>
 <YsJtYYsB/SinnNzI@shell.armlinux.org.uk>
 <YsLFh4naDbzGpDWB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsLFh4naDbzGpDWB@casper.infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 11:48:39AM +0100, Matthew Wilcox wrote:
> On Mon, Jul 04, 2022 at 05:32:33AM +0100, Russell King (Oracle) wrote:
> > On Sun, Jul 03, 2022 at 10:54:49PM +0100, Matthew Wilcox wrote:
> > > On Sun, Jul 03, 2022 at 10:16:45PM +0100, Russell King (Oracle) wrote:
> > > > On Sun, Jul 03, 2022 at 10:14:41PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > > This is the number of bits used by a PMD entry, not the order of a PMD.
> > > > 
> > > > No, it's not the number of bits. A PMD entry doesn't fit in 2 or 3 bits.
> > > > This is even more confusing.
> > > 
> > > Well, what is it then?  The order of something is PAGE_SIZE << n, and
> > > that doesn't seem to be what this is.
> > 
> > Where is it defined that "order" means "PAGE_SIZE << n" ?
> 
> include/asm-generic/getorder.h: * get_order - Determine the allocation order of a memory size

I really don't care - "order" is something that is a standard term,
and is entirely appropriate in its use in this case. The fact is,
this use conforms to the standard term usage, not some made up
Linux whim.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
