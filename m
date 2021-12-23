Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279C547E14A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347675AbhLWKTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:19:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:16214 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347698AbhLWKTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640254778; x=1671790778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nv7xPFaZ6HRYosw5sp5zKlPzEvyg5zTh0M+tiD0roxw=;
  b=DAPIRTlHmDTqC0ogwMqAnoF9F1HmbgEwncpUqYrJ/jHQ09qVOCCguyoM
   BpIaCOXkyq9h9t1w+MSy2zVLHAtvmMGLPw0tFLoQbWtxbpr9LN/l3BylP
   snn36Hgu5v5cj34nfsZjw+QgNmmmAPznKQEVdIDBT/D51oxNk95ENNTrk
   +T8zcEADlFUZz1gEMHFu49QOWoOFzgfLI1WxOyHatiAZhLWbCgizmEeh2
   QKyb6Z1hUAMdWyLeTu1wai7aWMNCK/oLx20Q1D1PrC2NBr0PU0PJAC5dF
   Z6wJfzctUeExTEMu7Cowck8Q/aFgg721LzF+kocs0fiZw8q8gL1UJ1jgR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227644985"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="227644985"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 02:19:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="466956255"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 02:19:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n0LAq-001BCm-AK;
        Thu, 23 Dec 2021 12:18:12 +0200
Date:   Thu, 23 Dec 2021 12:18:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_exar: derive nr_ports from ID for
 Acces I/O cards
Message-ID: <YcRM5NN/rEsU7PEa@smile.fi.intel.com>
References: <20211222194413.75069-1-andriy.shevchenko@linux.intel.com>
 <6c60d8c1-ff64-8e93-79f1-1a3dd352d7a2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c60d8c1-ff64-8e93-79f1-1a3dd352d7a2@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 12:05:11PM +0200, Ilpo Järvinen wrote:
> On Wed, 22 Dec 2021, Andy Shevchenko wrote:

...

> > -	nr_ports = board->num_ports ? board->num_ports : pcidev->device & 0x0f;
> > +	if (pcidev->vendor == PCI_VENDOR_ID_ACCESSIO)
> > +		nr = BIT(((pcidev->device & 0x38) >> 3) - 1);
> 
> Shouldn't this be nr_ports = ...

Yeah, sorry for that. By some reason I have no such config option enabled and
my builds haven't failed.

-- 
With Best Regards,
Andy Shevchenko


