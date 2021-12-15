Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE625475961
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbhLONIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:08:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:32018 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242723AbhLONIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:08:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="226502542"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226502542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="661915754"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 15 Dec 2021 05:08:28 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 15 Dec 2021 15:08:27 +0200
Date:   Wed, 15 Dec 2021 15:08:27 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] acpi: Store the Physical Location of Device
 (_PLD) information
Message-ID: <Ybnoy9e6VvFsJ4b1@kuha.fi.intel.com>
References: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
 <20211213103243.33657-2-heikki.krogerus@linux.intel.com>
 <CAJZ5v0jq5ve9+V3k5Vi=vJAheSyQbAsNmi6An9=oKxkyVed5bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jq5ve9+V3k5Vi=vJAheSyQbAsNmi6An9=oKxkyVed5bw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Wed, Dec 15, 2021 at 12:43:48PM +0100, Rafael J. Wysocki wrote:
> One overall problem I see here is that it potentially stores a bunch
> of _PLD buffers that will never be used, which is a waste of memory.
> 
> It may be better to make acpi_device_get_location() evaluate _PLD for
> the target device if it cannot be found in the list and either update
> one of the existing entries if the crc matches and return the pld data
> from there, or add a new item to the list and return its pld data.

The primary goal of this series is actually to see the other devices
that share a fixed location with our device. The _PLD buffer cache
would be nice, but not necessary. We don't have to store the _PLD
buffer itself as part of the location structure at all if that's a
problem.

I'll make the change.

thanks,

-- 
heikki
