Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F7946779B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380910AbhLCMvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:51:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:30636 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352128AbhLCMvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:51:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="236779116"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="236779116"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 04:48:12 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="678087688"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 04:48:09 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 03 Dec 2021 14:48:07 +0200
Date:   Fri, 3 Dec 2021 14:48:07 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-kernel@vger.kernel.org, Dan Scally <djrscally@gmail.com>,
        Kate Hsuan <hpa@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] mfd: intel-lpss: Fix I2C4 not being available on the
 Microsoft Surface Go & Go 2
Message-ID: <YaoSB7wrqs1pw1Fy@lahna>
References: <20211203115108.89661-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203115108.89661-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 12:51:08PM +0100, Hans de Goede wrote:
> Many DSDTs for Kaby Lake and Kaby Lake Refresh models contain a
> _SB.PCI0.GEXP ACPI Device node describing an I2C attached PCA953x
> GPIO expander.
> 
> This seems to be something which is copy and pasted from the DSDT
> from some reference design since this ACPI Device is present even on
> models where no such GPIO expander is used at all, such as on the
> Microsoft Surface Go & Go 2.
> 
> This ACPI Device is a problem because it contains a SystemMemory
> OperationRegion which covers the MMIO for the I2C4 I2C controller. This
> causes the MFD cell for the I2C4 controller to not be instantiated due
> to a resource conflict, requiring the use of acpi_enforce_resources=lax
> to work around this.
> 
> I have done an extensive analysis of all the ACPI tables on the
> Microsoft Surface Go and the _SB.PCI0.GEXP ACPI Device's methods are
> not used by any code in the ACPI tables, neither are any of them
> directly called by any Linux kernel code. This is unsurprising since
> running i2cdetect on the I2C4 bus shows that there is no GPIO
> expander chip present on these devices at all.
> 
> This commit adds a PCI subsystem vendor:device table listing PCI devices
> where it is known to be safe to ignore resource conflicts with ACPI
> declared SystemMemory regions.
> 
> This makes the I2C4 bus work out of the box on the Microsoft Surface
> Go & Go 2, which is necessary for the cameras on these devices to work.
> 
> Cc: Dan Scally <djrscally@gmail.com>
> Cc: Kate Hsuan <hpa@redhat.com>
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
