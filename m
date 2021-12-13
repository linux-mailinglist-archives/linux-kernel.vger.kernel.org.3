Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C7D472B56
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhLML1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:27:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:55980 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234729AbhLML1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:27:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="238937314"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="238937314"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 03:27:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="464593908"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 03:27:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwjTV-005azv-Mv;
        Mon, 13 Dec 2021 13:26:33 +0200
Date:   Mon, 13 Dec 2021 13:26:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <Ybct6XoeJ1/9ai03@smile.fi.intel.com>
References: <YbMwBFf5e7k2o6W5@smile.fi.intel.com>
 <9e6b2e9a-e958-0c14-6570-135607041978@omp.ru>
 <YbM7xkTazM76CVvD@smile.fi.intel.com>
 <6c03ffef-b2e0-16ba-35f3-206af2a611d2@gmail.com>
 <YbOVmGw7ys6U51z3@smile.fi.intel.com>
 <9d688cd8-99e3-0265-06aa-d44597e7686c@omp.ru>
 <YbOpu2whB5NaXbNa@smile.fi.intel.com>
 <a0bf3377-21ed-7244-7c73-ebb50dbc44c4@omp.ru>
 <448ce97b-699d-bdab-b4e9-c9439fd81a85@gmail.com>
 <8ec4a971-29ba-77f7-7c48-ad88decea70f@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec4a971-29ba-77f7-7c48-ad88decea70f@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 01:13:52PM +0300, Sergey Shtylyov wrote:
> On 10.12.2021 22:35, Sergei Shtylyov wrote:

...

>    Also, your commit log is wrong in the description of how to handle the result:
> 
> <<
> Now:
> 	ret = platform_get_irq_optional(...);
> 	if (ret != -ENXIO)
> 		return ret; // respect deferred probe
> 	if (ret > 0)
> 		...we get an IRQ...
> >>
> 
>    The (ret != -ENXIO) check also succeeds on the (positive) IRQ #s, so the
> following code becomes unreachable. :-/

Indeed, thanks!

Should be
	if (ret < 0 && ret != -ENXIO)

-- 
With Best Regards,
Andy Shevchenko


