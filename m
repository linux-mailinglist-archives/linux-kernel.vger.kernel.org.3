Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D94148787A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347672AbiAGNqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:46:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:13846 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347663AbiAGNqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641563212; x=1673099212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KCiDypFg8y6g7XyfkGAqAkQVPUTDcN/kjZr2GQhWusE=;
  b=jGa+nt8JvCymIw74HNYrKRVijOAh5N5GGUzqpGyiJFRbxbLWJYQbR6Sp
   UJJAa4MzX6t7p9sEYktiqOPH4C7PckB+RdcFOhoo28GpTSy+Mi5We8zA1
   SG6PCaBGKgwLAWyff17A+HMoE4RVzPYxVyt2pxZiHSe0OKAhKB06rmAx/
   usXiblYZ4eV49ppbt4Lg3lyL6S2auHdrNeX65iaBaFh8vSTMsJb5np2h4
   pB3IbyvWNWMev6XWVg2a/OZ13VRs/kC9rNEEpWf7ZHt2VB4yrqS2dbLY6
   rFWo78pYgX/Z5ce5ZxYpVvZfIJs+oTUfvG5JsYPne2K7/3/a9OFlQ6XLg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="241683237"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="241683237"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 05:46:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="527373071"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 05:46:48 -0800
Date:   Fri, 7 Jan 2022 21:46:17 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ACPI: pfr_telemetry: Fix info leak in pfrt_log_ioctl()
Message-ID: <20220107134617.GA895400@chenyu-desktop>
References: <20220107073407.GG22086@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107073407.GG22086@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:34:07AM +0300, Dan Carpenter wrote:
> The "data_info" struct is copied to the user.  It has a 4 byte struct
> hole after the last struct member so we need to memset that to avoid
> copying uninitialized stack data to the user.
> 
> Fixes: b0013e037a8b ("ACPI: Introduce Platform Firmware Runtime Telemetry driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> When you're adding a new driver to the kernel then please use the new
> driver's prefix instead of just the subsystem prefix.
> 
>  Bad: ACPI: Introduce Platform Firmware Runtime Telemetry driver
> Good: ACPI / pfr_telemetry: Introduce Platform Firmware Runtime Telemetry driver
> 
Thanks for pointing this out.
> Otherwise it's just up to me to guess what prefix you wanted.
> 
>  drivers/acpi/pfr_telemetry.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
> index da50dd80192c..9abf350bd7a5 100644
> --- a/drivers/acpi/pfr_telemetry.c
> +++ b/drivers/acpi/pfr_telemetry.c
> @@ -83,6 +83,7 @@ static int get_pfrt_log_data_info(struct pfrt_log_data_info *data_info,
>  	union acpi_object *out_obj, in_obj, in_buf;
>  	int ret = -EBUSY;
>  
> +	memset(data_info, 0, sizeof(*data_info));
Just one minor question, how about moving above before:
data_info->status = out_obj->package.elements[LOG_STATUS_IDX].integer.value;
after the sanity check of the _DSM result?

thanks,
Chenyu 
>  	memset(&in_obj, 0, sizeof(in_obj));
>  	memset(&in_buf, 0, sizeof(in_buf));
>  	in_obj.type = ACPI_TYPE_PACKAGE;
