Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B422D4B6844
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiBOJ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:56:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiBOJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:55:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82ED10DA46;
        Tue, 15 Feb 2022 01:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644918946; x=1676454946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LBjk0RGRItnnfUS2rGh0O1oLABxwlG/YheagFyaRlhk=;
  b=VD6QoH7/mtUFCYbEcayDLNLHSEK/YekLWGzfvhTI4sAOl+ZOi4j9GX7T
   3xytuR3KGXfYYPumIP/XwuP0jxxZ8EhG6mcLyKgyfkogH/Oxg2iRzYWPj
   U0PBqoxKAtw8w4EF8U9W0lzjRxRpx1qYzC/Sr14yEb8UWamLgyI8KRJsd
   QQ8mbkiSfTzTradBZi8CUg4BTJQEFNQWpHiIH+H+KCmQg4SLRZTle8n6C
   4UUwDQP9zMg1J+2ZIuINEAuvAY7kmEtL3K03BtOrevv3FO3xGVTewGo1C
   HDRen+nPmdxjSlQWhEwPbuEqtHjeQrNMKiwgVkBeDxAPA08rwq4TrHOxM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249147387"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="249147387"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 01:55:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="544222329"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 01:55:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJuXp-004s9E-Rz;
        Tue, 15 Feb 2022 11:54:49 +0200
Date:   Tue, 15 Feb 2022 11:54:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Qing Wang <wangqing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: 8250: add missing pci_dev_put() before
 return
Message-ID: <Ygt4aUMVKM8ZcW/5@smile.fi.intel.com>
References: <1644890454-65258-1-git-send-email-wangqing@vivo.com>
 <67ace5d3-02b3-034d-969f-9a05bbdd8e30@kernel.org>
 <621e2079-567c-6954-9744-c51748dd48dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <621e2079-567c-6954-9744-c51748dd48dd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 07:02:57AM +0100, Jiri Slaby wrote:
> On 15. 02. 22, 6:55, Jiri Slaby wrote:
> > On 15. 02. 22, 3:00, Qing Wang wrote:
> > > From: Wang Qing <wangqing@vivo.com>
> > > 
> > > pci_get_slot() increases its reference count, the caller must
> > > decrement the reference count by calling pci_dev_put()

Wang, thank you for the report!

...

> > What about the "return -ENODEV" few lines above?
> 
> On the top of that, the code stores the pointer to the dev:
> param->dma_dev = &dma_dev->dev;
> 
> So we should likely put the device in ->exit(), not ->setup().

I think I may fix all these and send a new version.

-- 
With Best Regards,
Andy Shevchenko


