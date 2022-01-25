Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0986949B9A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351998AbiAYRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:06:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:59570 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378875AbiAYREP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643130249; x=1674666249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KpDD4g/UZj5CDYk2YeNUV3YRD3WdVoUJ9s2/Tnjqb5g=;
  b=PIGpxCpZhS1Ci2G0zjSMuO8M5WM2ECo9yVq67nU1+0uET5SxuL/jstEs
   AsmhN3z+z5I0fS3rpgtpCi/uEH6EclL3TKmLCSP+wMdaVzfrUxzeMZ4xn
   +NOPf/E0qdoKcmkS65ghNLre9c2yuPSgQmomSk/t670CsBRH4xziEj4M1
   j91px8jFrDl7pvBqF8FFFdDXU7ce81A4JFS/Hrdhm4SPaMibldy3aScu1
   8KXiGO4Ese2c9O++qud6uEosHW5xrs9ROJmVeGqtABOPyEsIg6tMBThxe
   60x5KbdifAqCKkyWEe0Zz9JW5JHP4j79TF9eiaBKB9NiNvSpkfaXdcYZx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246294693"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246294693"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 08:55:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="520451335"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 08:55:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCP5l-00EJr6-F0;
        Tue, 25 Jan 2022 18:54:49 +0200
Date:   Tue, 25 Jan 2022 18:54:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Wander Costa <wcosta@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Message-ID: <YfArWaKJ13+OC/7w@smile.fi.intel.com>
References: <20211029201402.428284-1-wander@redhat.com>
 <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org>
 <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
 <11ec4350-b890-4949-cf8f-bc62d530d64f@nvidia.com>
 <CAAq0SU=9R3Y_SAdM+HaqavzWBRd1Li-b5bnZZLd5Opfgd0vnkQ@mail.gmail.com>
 <fa42a60c-954a-acc0-3962-f00427153f78@nvidia.com>
 <YfArHDfrVHw7ApDx@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfArHDfrVHw7ApDx@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 06:53:48PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 25, 2022 at 12:40:27PM +0000, Jon Hunter wrote:
> > On 25/01/2022 10:29, Wander Costa wrote:

...

> > Andy, does this work for X86?
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> No, it does NOT fix an issue (I see it on a handful x86) with the legacy UART
> (means the 8250_pnp is in use). And I believe the same will be the case on LPSS
> ones (8250_dw / 8250_lpss) and HSU (8250_mid), because the patch influences on
> all of them.

Shall I send a revert and we can continue with a new approach later on?

-- 
With Best Regards,
Andy Shevchenko


