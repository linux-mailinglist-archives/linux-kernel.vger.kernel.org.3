Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957044B6950
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiBOKbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:31:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiBOKa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:30:58 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E8E2B183;
        Tue, 15 Feb 2022 02:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644921049; x=1676457049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hycz1JHpGd+maWGRJUVGGhZhNqZXR2hLzsZ7wCYH+Ts=;
  b=QxTHHqXtj5VDwYdn+QcosecnR4wg2jwDICdDfiG4IoZs08SZN2RrWrds
   jJXhuHvDV7QqoGzY7cJhXMu+ye6+PGyoseYlzMvoKMg9NaA7PUu9WCIfw
   dOAfE7tKmD1O8wMHDFoOWNIjIaFC8LellexBOsMh11EATriQ/yojzo9PQ
   vdH7IfoQmpxoqk7Y6k+HyQGj9lIsYkGdNRBK8hIoQLHhUljHd+6xzO75g
   rdur3enuNINqIJ0625MHAWh/3LIrfpO/7d1M9dUEr51s+uCTim2YQKsUR
   E5L5/NzYmM6+lopvdyUwNoV4mgQH7+3olTVdNexcPHVf+IEwHp+5xdw/o
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313598044"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="313598044"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 02:30:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="570757499"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 02:30:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJv5h-004si9-Md;
        Tue, 15 Feb 2022 12:29:49 +0200
Date:   Tue, 15 Feb 2022 12:29:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qing Wang <wangqing@vivo.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_mid: Balance reference count for PCI
 DMA device
Message-ID: <YguAncl92hV2vUkm@smile.fi.intel.com>
References: <20220215100920.41984-1-andriy.shevchenko@linux.intel.com>
 <db576c63-73e2-b5f8-bc8b-057bdab2264d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db576c63-73e2-b5f8-bc8b-057bdab2264d@kernel.org>
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

On Tue, Feb 15, 2022 at 11:11:41AM +0100, Jiri Slaby wrote:
> On 15. 02. 22, 11:09, Andy Shevchenko wrote:
> > The pci_get_slot() increases its reference count, the caller
> > must decrement the reference count by calling pci_dev_put().

> And what about the -EINVAL case?

What about it? The ->probe() calls ->exit() in its error path.
Or did I miss something?

-- 
With Best Regards,
Andy Shevchenko


