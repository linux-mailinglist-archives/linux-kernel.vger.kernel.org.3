Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D9648A4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346118AbiAKBKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:10:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:37533 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243225AbiAKBK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641863428; x=1673399428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fJXTMkk0SB+4g52Yu1jDQNURKpRBrX+AALDaL0P+67g=;
  b=aKWKmDbS9/5ppMUiTiBvRyNkwd/k5AT6xihGSJxISIhwwu1Ws311BqlQ
   YY03DDgf6PTlMLzAEvtY0ZU7siciLMAIKqBEtUOtKAssygEEEWMCNWNpI
   Xn3iABcflwZ4viM5MqedMsld16Ca67/1bxhUwUjLwKZ4m78rww9fsYBx8
   cgB/dTjNL8erSgENRGEoQAZrbDkwb4+VvlUBjZ14mP/9JyaDQKsclW5Ns
   euny00PyZtYw7cI/E5nhO7VoaFNDCq43O2SDaUOYrcHkFswCspJqjtTtL
   NYiLGGqU3c/Ejrs5UlFOWpMRWGW7e3L9ZwAiyPwRu0fhg+fgCtsmYP6lC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="230715672"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="230715672"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 17:10:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="690793324"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 17:10:25 -0800
Date:   Tue, 11 Jan 2022 09:09:52 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ACPI: pfr_telemetry: Fix info leak in pfrt_log_ioctl()
Message-ID: <20220111010952.GB987335@chenyu-desktop>
References: <20220107073407.GG22086@kili>
 <20220107134617.GA895400@chenyu-desktop>
 <20220110061713.GA1951@kadam>
 <CAJZ5v0gdB_y9MVasdGhMCUPKZBzNPo1NxxkHh_QeKjh1DwPPfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gdB_y9MVasdGhMCUPKZBzNPo1NxxkHh_QeKjh1DwPPfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:39:30PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 10, 2022 at 7:17 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Fri, Jan 07, 2022 at 09:46:17PM +0800, Chen Yu wrote:
> > > On Fri, Jan 07, 2022 at 10:34:07AM +0300, Dan Carpenter wrote:
> > > > The "data_info" struct is copied to the user.  It has a 4 byte struct
> > > > hole after the last struct member so we need to memset that to avoid
> > > > copying uninitialized stack data to the user.
> > > >
> > > > Fixes: b0013e037a8b ("ACPI: Introduce Platform Firmware Runtime Telemetry driver")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > > When you're adding a new driver to the kernel then please use the new
> > > > driver's prefix instead of just the subsystem prefix.
> > > >
> > > >  Bad: ACPI: Introduce Platform Firmware Runtime Telemetry driver
> > > > Good: ACPI / pfr_telemetry: Introduce Platform Firmware Runtime Telemetry driver
> > > >
> > > Thanks for pointing this out.
> > > > Otherwise it's just up to me to guess what prefix you wanted.
> > > >
> > > >  drivers/acpi/pfr_telemetry.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
> > > > index da50dd80192c..9abf350bd7a5 100644
> > > > --- a/drivers/acpi/pfr_telemetry.c
> > > > +++ b/drivers/acpi/pfr_telemetry.c
> > > > @@ -83,6 +83,7 @@ static int get_pfrt_log_data_info(struct pfrt_log_data_info *data_info,
> > > >     union acpi_object *out_obj, in_obj, in_buf;
> > > >     int ret = -EBUSY;
> > > >
> > > > +   memset(data_info, 0, sizeof(*data_info));
> > > Just one minor question, how about moving above before:
> > > data_info->status = out_obj->package.elements[LOG_STATUS_IDX].integer.value;
> > > after the sanity check of the _DSM result?
> >
> > I guess I wanted to keep all the memsets together.  I feel like if the
> > data is invalid, then it's going to be a slow path and it's not worth
> > optimizing that case.  If the data is invalid then a little slow down is
> > the least of our concerns.
> 
> Patch applied, thanks!
> 
> Yu, this series needs to spend a few days more in linux-next, because
> of the fixes against it sent lately.
Ok, I see.

thanks,
Chenyu
