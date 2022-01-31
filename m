Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B754A3EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 09:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344769AbiAaImi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 03:42:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:48485 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344458AbiAaImh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 03:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643618557; x=1675154557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nSRR41iCdd3beXRbCXNgN9ZSboYXpnyQtwxxNPrpg2s=;
  b=Q4nFdauLJo0TngGzEQ7AJsvBXlwpRPkFotRLs1kk2toJDoJiUdMHZJxg
   l6gJhFvcZVymPYsAlTFDR3sLqX6XzWeoYK9CUOzBFxUEpfNrWhYGAEnry
   G5DBJ3rlwM7gRGLwQXT3Xc0ONiLvC9vb03pal8g/Kq1hV6onW1I0K3fOg
   m1PE9e0rRXDC9wfsqWsmgcumM4j/XKoCBsYE4S/1ptR6GbPwz6l2lwIai
   +1/pj7O2MEU+B1TC/q42nRN2KiNoGeJtGWZ/MQSg4/ff+lpK51/S1OPt5
   ucTYXCe+8BgvJmXE9gprrHy8rmdQYunrjuBmJVfZKp920QY4k6b3z4tL1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="310732878"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="310732878"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 00:42:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="675667925"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Jan 2022 00:42:32 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jan 2022 10:42:31 +0200
Date:   Mon, 31 Jan 2022 10:42:31 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] usb: typec: mux: select not-visible INTEL_SCU_IPC
Message-ID: <Yfeg96P3no1FhWE5@kuha.fi.intel.com>
References: <20220130185032.29298-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130185032.29298-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 10:50:32AM -0800, Randy Dunlap wrote:
> Use "select INTEL_SCU_IPC" instead of depending on it since it is
> not a visible Kconfig symbol and it may not otherwise be set/enabled.
> 
> Fixes: b62851491a55 ("usb: typec: mux: Convert the Intel PMC Mux driver to use new SCU IPC API")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-usb@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: kernel test robot <lkp@intel.com>
> ---
> v2: add dependency on X86_PLATFORM_DEVICES to fix build error that was
>     Reported_by: kernel test robot <lkp@intel.com>
> 
>  drivers/usb/typec/mux/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20220128.orig/drivers/usb/typec/mux/Kconfig
> +++ linux-next-20220128/drivers/usb/typec/mux/Kconfig
> @@ -11,8 +11,8 @@ config TYPEC_MUX_PI3USB30532
>  
>  config TYPEC_MUX_INTEL_PMC
>  	tristate "Intel PMC mux control"
> -	depends on ACPI
> -	depends on INTEL_SCU_IPC
> +	depends on ACPI && X86_PLATFORM_DEVICES
> +	select INTEL_SCU_IPC
>  	select USB_ROLE_SWITCH
>  	help
>  	  Driver for USB muxes controlled by Intel PMC FW. Intel PMC FW can

This will cause the driver to fail at probe time if there are no SCU
device drivers enabled.

The idea is that the SCU device drivers select the SCU IPC library,
not the users of the library like this mux driver.

thanks,

-- 
heikki
