Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8D747D6DD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbhLVS3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:29:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:8331 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236569AbhLVS3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640197785; x=1671733785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5mB06axBALQGGpSMy3LM5SGDcRG0aHhmCGXrmMpFCXA=;
  b=FM9ciw1CDHzTLpeO7JXnzuRa8kM71unVQivreYrGwVEIvyZFAn3BiNLu
   RzZECHr72fRrE1m/ARDT+bJtB1kyFhIksVF5mrjt//yEKEiCueQzjh9DM
   VPG+cnyPl+6EPjivmWshny8kRfrODcOf7Z1kNZe/VfsHXLQP6V0zs4uzD
   xUw0+sd2xEtJm+l5gO4y2xxUjQsZDjMsUojTpZ/erxUTu/GYO7S6soO15
   B6H2n47Ee3i89IVuZCk9mfVGw+KSVz8iGQMPIG2GdMKomOKreNRleZiPt
   tV0HH7BHCk/6u1lp4bc8T9DDRxbxc1Ry91tPwlDA9GgmMn5ILP4yAneLX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227984481"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="227984481"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 10:29:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="508579148"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 10:29:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n06LZ-000v0C-K3;
        Wed, 22 Dec 2021 20:28:17 +0200
Date:   Wed, 22 Dec 2021 20:28:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] acpi: Store CRC-32 hash of the _PLD in struct
 acpi_device
Message-ID: <YcNuQYfbMcxlRkSP@smile.fi.intel.com>
References: <20211222143258.82305-1-heikki.krogerus@linux.intel.com>
 <20211222143258.82305-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222143258.82305-3-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 05:32:55PM +0300, Heikki Krogerus wrote:
> Storing CRC-32 hash of the Physical Location of Device
> object (_PLD) with devices that have it. The hash is stored
> to a new struct acpi_device member "pld_crc".
> 
> The hash makes it easier to find devices that share a
> location, as there is no need to evaluate the entire object
> every time. Knowledge about devices that share a location
> can be used in device drivers that need to know the
> connections to other components inside a system. USB3 ports
> will for example always share their location with a USB2
> port.

...

> @@ -739,7 +752,6 @@ static inline void acpi_bus_put_acpi_device(struct acpi_device *adev)
>  
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
>  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> -
>  #endif				/* CONFIG_ACPI */

Looks like a stray change.

-- 
With Best Regards,
Andy Shevchenko


