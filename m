Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739484BFE03
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiBVQCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiBVQCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:02:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2FADD448;
        Tue, 22 Feb 2022 08:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9m4cMreK6aPEf6IXzAjTwvFEykLgaWCLX4P1Mp4IYqk=; b=nKiwtEF3AXY1vka0hrIOLTFz5p
        DvofSC2o424bOtldtoP/jTakbkBD+h2sKszDiPVn3J/hxoVrDaxwsipkYOtn+/xksyzA+aAvEj6YY
        bBHkG+ekWSVg1MfyjKRqXM9MZJSbDGXDzpH53n7D4N8/zZe/Eg8BXYOcRSDqxXazUnhxMnFMJusO9
        KBjNgX25794FwS9ajA0oMCCaM9Zry4iLbWwkseIXlBqP+dOiPyRnAREo+06I0FF6RQV0CkZSkgIl9
        XyhndJ1+HNMMEyWHw/UcicGNfvJcma3sWZcu/5GYUtdeDUv5COExcZ8g/Z7F4xWOO6U/S1UEM7dMk
        B1ds/luw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXcA-00AV7O-6n; Tue, 22 Feb 2022 16:02:10 +0000
Date:   Tue, 22 Feb 2022 08:02:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] serial: 8250_lpss: Switch to pcim_iomap() instead
 of pci_ioremap_bar()
Message-ID: <YhUJAl5JpCoXik7X@infradead.org>
References: <20220215134359.78169-1-andriy.shevchenko@linux.intel.com>
 <20220215134359.78169-2-andriy.shevchenko@linux.intel.com>
 <Ygy7dNqFLZF9XYiH@infradead.org>
 <d8336f83-9f31-e168-1ed7-29e97189e233@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8336f83-9f31-e168-1ed7-29e97189e233@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 10:14:16AM +0100, Jiri Slaby wrote:
> On 16. 02. 22, 9:53, Christoph Hellwig wrote:
> > On Tue, Feb 15, 2022 at 03:43:59PM +0200, Andy Shevchenko wrote:
> > > The pci_iounmap() doesn't cover all the cases where resource should
> > > be unmapped. Instead of spreading it more, replace the pci_ioremap_bar()
> > > with pcim_iomap() which uses managed resource approach.
> > 
> > pcim_iomap requires the use of ioreadX/iowriteX and thus runtime
> > overhead.  So in doubt please add a pcim_ioremap_bar instead of forcing
> > the legacy iomap/ioread/iowrite API onto modern drivers tht can't
> > support legacy port I/O.
> 
> Hmm, the driver combines pci_ioremap_bar with pci_iounmap. pci_iounmap does
> the right thing after all, but is that correct? And this driver is not
> alone, this shows more:
> git grep -E 'pci_iounmap|pci_ioremap_bar' `git grep -l pci_iounmap \`git
> grep -l pci_ioremap_bar\``

I think it is wrong.  It is not actively harmful unlike the the
combination of pci_iomap and then later use of accessors from the
ioremap family, but still not exactly a good idea.

In a perfect world we'd have some different annotation from __iomem
for the whole iomap family of functions.
