Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB2E4C155E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbiBWOZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiBWOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:25:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1ABB1A98;
        Wed, 23 Feb 2022 06:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645626274; x=1677162274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IV+wRjFZ0KIXQehwCsMDvsyLOE60ai+2jVh9pnpXlHw=;
  b=hwGB37uAAbJMo7lqmR1cNDNigoiICmbnIubWQ/wBTB1D3oV9AqGoc0Vt
   /MkQCHq8oT3FFm4jZE+hL6y98BzpAMshpedv2Kp/7wyd1vwuK5CEnkGEB
   BO4dTcyrLLugu5cgVxloULR/cyOoSyoxYPbXqVvJBlIhb0a3V7WTHIj8U
   gGPf0/ihmVOiT0oWI5asD0mce+uZ302BfAXbmQ8f+szDxrC5ZyzNs8g3Z
   +LupkrpZlfnOF4QVi+tOy6R9YuH3gamNYjcYoZ/1CgIf5E/V4tXll2k7Y
   6aidZxFW9D9kvgWMtzn+0FNLlvkVV3sYZk5aClVT03phTLFtYdottTH4Z
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232594619"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="232594619"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 06:24:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="508452930"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 06:24:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nMsYP-007SIC-D9;
        Wed, 23 Feb 2022 16:23:41 +0200
Date:   Wed, 23 Feb 2022 16:23:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_lpss: Switch to pcim_iomap() instead
 of pci_ioremap_bar()
Message-ID: <YhZDbNyJd0LjAbaB@smile.fi.intel.com>
References: <20220215134359.78169-1-andriy.shevchenko@linux.intel.com>
 <20220215134359.78169-2-andriy.shevchenko@linux.intel.com>
 <Ygy7dNqFLZF9XYiH@infradead.org>
 <d8336f83-9f31-e168-1ed7-29e97189e233@kernel.org>
 <YhUJAl5JpCoXik7X@infradead.org>
 <YhYVl9YaoPDwAXO4@smile.fi.intel.com>
 <YhYWw/yEaYJFR1/y@kroah.com>
 <YhYcbrsDD2iagUL7@smile.fi.intel.com>
 <YhYmgEMRhGu1PsYg@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhYmgEMRhGu1PsYg@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 04:20:16AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 23, 2022 at 01:37:18PM +0200, Andy Shevchenko wrote:
> > Okay, so if I read this thread correctly Christoph suggests to introduce
> > pcim_ioremap_bar() and then use it. Am I right?
> 
> Yes.

Thanks for clarification!

> > Christoph, since we are on the topic about pcim_*() APIs, can you chime in
> > the discussion [1] about IRQ vectors allocation?
> > 
> > [1]: https://lore.kernel.org/all/20210607153916.1021016-1-zhengdejin5@gmail.com/
> 
> Did you intend to link to a 8 month old series or is there something
> else this should point to?

Yes, because it seems stalled.

-- 
With Best Regards,
Andy Shevchenko


