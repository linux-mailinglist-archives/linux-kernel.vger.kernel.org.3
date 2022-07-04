Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB40956589C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiGDO2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiGDO2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:28:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40CE6367
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BNvWRWw003hywMuVmvZBynD2U4e1aMJSqur83vbYrqE=; b=D6tcueKTPe7HB/QbakEkCppG8L
        vs2OnJ1O+5QUp18jCp33mtP/Cy7QnfiziCwALkBdd/b6swQ7jZT8iyCmWKaZOXHpQGhSgTasOHNSS
        KgHAl0WZLVAneVqLhWZBmkp0GX8deWFe7ozlhc8PgXogAwWIghR25lB3WywVvJAtxqQKqpoj2NbeY
        ed0RzRCfVuPIPNbHqSKChSRxO4o9lHdiaXcKCPcXFFThahGN1JP6k15DZZYMsLShWGqoCGT+qASin
        bOuOcMCEYoynMy0LO/UmxBNImQL+laL/n6Q6reZkb1A4w211JwYGluvtZ3075/sqJeqQT14lexJHr
        wihARMTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8N3X-00HMPh-BQ; Mon, 04 Jul 2022 14:28:07 +0000
Date:   Mon, 4 Jul 2022 15:28:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/14] arm: Rename PMD_ORDER to PMD_BITS
Message-ID: <YsL492bvHEo4a73M@casper.infradead.org>
References: <20220703141203.147893-1-rppt@kernel.org>
 <20220703211441.3981873-1-willy@infradead.org>
 <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
 <YsIQKdYiswzq5kTG@casper.infradead.org>
 <YsJtYYsB/SinnNzI@shell.armlinux.org.uk>
 <YsLFh4naDbzGpDWB@casper.infradead.org>
 <YsLPxDLRT6fVLaOM@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsLPxDLRT6fVLaOM@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 12:32:20PM +0100, Russell King (Oracle) wrote:
> On Mon, Jul 04, 2022 at 11:48:39AM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 04, 2022 at 05:32:33AM +0100, Russell King (Oracle) wrote:
> > > On Sun, Jul 03, 2022 at 10:54:49PM +0100, Matthew Wilcox wrote:
> > > > On Sun, Jul 03, 2022 at 10:16:45PM +0100, Russell King (Oracle) wrote:
> > > > > On Sun, Jul 03, 2022 at 10:14:41PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > > > This is the number of bits used by a PMD entry, not the order of a PMD.
> > > > > 
> > > > > No, it's not the number of bits. A PMD entry doesn't fit in 2 or 3 bits.
> > > > > This is even more confusing.
> > > > 
> > > > Well, what is it then?  The order of something is PAGE_SIZE << n, and
> > > > that doesn't seem to be what this is.
> > > 
> > > Where is it defined that "order" means "PAGE_SIZE << n" ?
> > 
> > include/asm-generic/getorder.h: * get_order - Determine the allocation order of a memory size
> 
> I really don't care - "order" is something that is a standard term,

The word "order" has many different uses, just in mathematics alone (to
say nothing of its uses in biology, business, the military, religion,
or signal processing).

https://en.wikipedia.org/wiki/Order_(mathematics)

> and is entirely appropriate in its use in this case. The fact is,
> this use conforms to the standard term usage, not some made up
> Linux whim.

At the point where you're talking about PMD order, you're in the realm
of memory management, and using terms to mean something different from
their normal meaning within mm is only going to lead to confusion.
