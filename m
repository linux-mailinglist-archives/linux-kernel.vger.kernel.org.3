Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EEA4B695A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiBOKcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:32:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiBOKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:32:53 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A788414087;
        Tue, 15 Feb 2022 02:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644921163; x=1676457163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oWO4lXtN9++t7vFX4SLLfFb8pUjKlrHoPemAnDxIuvk=;
  b=KPAQZtvvXM4TUvctBRxtj7wdsP7HH8zdWu/kts7bMpv3cd9dDCLoiFJA
   jXIr8Hc3QVd4FsS3CIjgi6vU4dQmwwlfx3MDVDguQzo2gcWFGR/iNIUar
   fxX9z1ntELzuK4zqSfeRIC0B0SxI8SCnUBbjJ9EPUrlnQrR59V5O4F1MG
   am5dM/+VwuPeuiWB1+77iEFiL29qSuX1M3aOfG5M7TQ7vQ4J/NVzZlDHK
   eKbRzNMRorZe5VXLPh/XnQ517lCZ3Q3IUclSu8yph0wzA5pQQTJbtfNqs
   K5erqF08VzjVbo7FbIBjZotRVj+xQ4RnO3qcNVg4UV+vqV/lQLZtzrINy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="237726775"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="237726775"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 02:32:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="539202881"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 02:32:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJv7Y-004skc-Qg;
        Tue, 15 Feb 2022 12:31:44 +0200
Date:   Tue, 15 Feb 2022 12:31:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qing Wang <wangqing@vivo.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_mid: Balance reference count for PCI
 DMA device
Message-ID: <YguBEJ1cc0TMQLuE@smile.fi.intel.com>
References: <20220215100920.41984-1-andriy.shevchenko@linux.intel.com>
 <db576c63-73e2-b5f8-bc8b-057bdab2264d@kernel.org>
 <YguAncl92hV2vUkm@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YguAncl92hV2vUkm@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 12:29:49PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 15, 2022 at 11:11:41AM +0100, Jiri Slaby wrote:
> > On 15. 02. 22, 11:09, Andy Shevchenko wrote:
> > > The pci_get_slot() increases its reference count, the caller
> > > must decrement the reference count by calling pci_dev_put().
> 
> > And what about the -EINVAL case?
> 
> What about it? The ->probe() calls ->exit() in its error path.
> Or did I miss something?

Or you mean that we call pci_dev_put() on NULL pointer?
This is completely valid case and handled in the callee.

-- 
With Best Regards,
Andy Shevchenko


