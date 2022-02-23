Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78104C12A2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiBWMU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240428AbiBWMUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:20:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D149A0BC5;
        Wed, 23 Feb 2022 04:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fqgNmCJGAnLLR2T8oxuKTHMh8BihLhtu1dTlBCJGRFw=; b=kc3WON16yegUloGPpmxxpsbSQp
        zanqdjyZv+ZDKVqvzid84Hje9cOIfI9o99pA8psPBVGsdYP3JHgJaul4E1yk0OG2VIHuMEOdCkYxm
        THHr8w69Xs09udKBmL2h2GbxpOcm99H2wrSwrNNABg/RmRr0hlKG3p82ch6dhTFQE99US7xQf9fj0
        ZfWAAQeOTW4DZSMVx3WDVC6Q0G/6BiM+hrc1F78qyJ78kWmvsyERsaI6rQZMAbnNJo2uATCvmPDOP
        7fTuX7G+hc0J9OYEhM7KSgG1wxuZkTdf5uzswW3TyGp9iCMwrlOipGUc6ZdzVHo6Tydh4gsAR6A72
        7RgVcPFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMqcy-00E8CZ-7K; Wed, 23 Feb 2022 12:20:16 +0000
Date:   Wed, 23 Feb 2022 04:20:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_lpss: Switch to pcim_iomap() instead
 of pci_ioremap_bar()
Message-ID: <YhYmgEMRhGu1PsYg@infradead.org>
References: <20220215134359.78169-1-andriy.shevchenko@linux.intel.com>
 <20220215134359.78169-2-andriy.shevchenko@linux.intel.com>
 <Ygy7dNqFLZF9XYiH@infradead.org>
 <d8336f83-9f31-e168-1ed7-29e97189e233@kernel.org>
 <YhUJAl5JpCoXik7X@infradead.org>
 <YhYVl9YaoPDwAXO4@smile.fi.intel.com>
 <YhYWw/yEaYJFR1/y@kroah.com>
 <YhYcbrsDD2iagUL7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhYcbrsDD2iagUL7@smile.fi.intel.com>
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

On Wed, Feb 23, 2022 at 01:37:18PM +0200, Andy Shevchenko wrote:
> Okay, so if I read this thread correctly Christoph suggests to introduce
> pcim_ioremap_bar() and then use it. Am I right?

Yes.

> 
> Christoph, since we are on the topic about pcim_*() APIs, can you chime in
> the discussion [1] about IRQ vectors allocation?
> 
> [1]: https://lore.kernel.org/all/20210607153916.1021016-1-zhengdejin5@gmail.com/

Did you intend to link to a 8 month old series or is there something
else this should point to?
