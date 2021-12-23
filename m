Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8220747E453
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 15:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbhLWOEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 09:04:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:26893 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLWOEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 09:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640268290; x=1671804290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UlT5KVjrEFTf3CIz79p3BqAn1Gleeii83ekgazwWfcM=;
  b=TDgy7v+3OpTmWQ+Fkqy7Kh87QMsmPEVfp7BJMgwgJvQnFnLDkFpUpoJy
   0PuCSEuLapvIyX6dR89zxrmDy8RztTTPIk4hze2sSPM8zabNTF1bIER7i
   aHDWTgAVUh9y+gtFp4u9oF+mYvO70agKNnYSH8mRyR8mPhEMi0ETqstM1
   4fgVc/sL8C+7Y5P1skhx8KyeQUkpQ3GQAQqr6cPuOPfVFQPkPQ/1QhnBW
   exIXiNHwnx1sR+flWUpXhA1jLywh+fnsot8NgFM2o+5lXisogZdax/Ax7
   EnFLKzgw4Ki5s8Y+HU9EBT1kJfEpely0LmiP8fQBLCTPZJE1pho6Yxdai
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="265038710"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="265038710"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 06:04:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="468547462"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 06:04:46 -0800
Date:   Thu, 23 Dec 2021 22:04:24 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Hongyu Ning <hongyu.ning@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 2/4] drivers/acpi: Introduce Platform Firmware
 Runtime Update device driver
Message-ID: <20211223140424.GA665673@chenyu-desktop>
References: <cover.1640007183.git.yu.c.chen@intel.com>
 <11fcad31b0589b35754f4a33ab16a9c07f417d70.1640007183.git.yu.c.chen@intel.com>
 <CAJZ5v0hT+0qhCBJg08bRiRMKC6U4UUFkU9PFC6UjGT4Hk2WrbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hT+0qhCBJg08bRiRMKC6U4UUFkU9PFC6UjGT4Hk2WrbA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 06:23:56PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 22, 2021 at 5:32 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Introduce the pfr_update driver which can be used for Platform Firmware
> > Runtime code injection and driver update [1]. The user is expected to
> > provide the EFI capsule, and pass it to the driver by writing the capsule
> > to a device special file. The capsule is transferred by the driver to the
> > platform firmware with the help of an ACPI _DSM method under the special
> > ACPI Platform Firmware Runtime Update device (INTC1080), and the actual
> > firmware update is carried out by the low-level Management Mode code in
> > the platform firmware.
> >
> > This patch allows certain pieces of the platform firmware to be
> > updated on the fly while the system is running (runtime) without the
> > need to restart it, which is key in the cases when the system needs to
> > be available 100% of the time and it cannot afford the downtime related
> > to restarting it, or when the work carried out by the system is
> > particularly important, so it cannot be interrupted, and it is not
> > practical to wait until it is complete.
> >
> > Link: https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf # [1]
> > Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Tested-by: Hongyu Ning <hongyu.ning@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> 
> [cut history]
>
[...] 
> > +static bool applicable_image(const void *data, struct pfru_update_cap_info *cap,
> > +                            struct pfru_device *pfru_dev)
> > +{
> > +       struct pfru_payload_hdr *payload_hdr;
> > +       const efi_capsule_header_t *cap_hdr = data;
> > +       const struct efi_manage_capsule_header *m_hdr;
> > +       const struct efi_manage_capsule_image_header *m_img_hdr;
> > +       const struct efi_image_auth *auth;
> > +       int type, size;
> > +
> > +       /*
> > +        * If the code in the capsule is older than the current
> > +        * firmware code, the update will be rejected by the firmware,
> > +        * so check the version of it upfront without engaging the
> > +        * Management Mode update mechanism which may be costly.
> > +        */
> 
> Since we are worrying so much about engaging the Management Mode in
> vain, it is somewhat inconsistent to only check the firmware version
> information and avoid doing some general sanity checks on the capsule
> image (for example, whether or not the image size value in the header
> is consistent with the image size etc.).
> 
> I'm not asking for another version of this patch, but something like a
> follow-up change adding more sanity checks on top of this series.
>
Ok, I'll sync with specification team and then enhance the sanity check in
a follow-up change.

thanks,
Chenyu
