Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AA047A774
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhLTJxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:53:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:38165 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhLTJxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639993983; x=1671529983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cO9crrlC+QfPg9ba/8m5FFVy6MdpSNm+TSKCAjH3juQ=;
  b=Gsn1GM6ihdReikx11O12KCxOHgW9Bo2f2e4tmdb30oc7j4Hmo6wZurDN
   aDeEqJ6ZBTX2T30zFjrKx8eWPXMTIKU+gNeQ6bcxwdk8JoARPNSnO4V8U
   7ivWPDGamVnaMeBCCZ1IWIV6z7ET34hJCrTI46pZb7j0GdtyTrMTYxa0h
   MNjidLjOv6Q1cQJD7daPzcnz/hEEcLXwPRsQIK868opFiS0vtVWxUpBPG
   AFBlAHutYezh7pQ2po8appjui8lLGVNfWeUFKh/gNqxtDhm0Vsottse5w
   bbQmtmMCGAiYM0Y6D7WmeKpdi5SIeFZoUFRWb36g3X73/yz+VQzXf9bV7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="264318481"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="264318481"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 01:53:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="684213078"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 01:53:00 -0800
Date:   Mon, 20 Dec 2021 17:52:40 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Hongyu Ning <hongyu.ning@intel.com>
Subject: Re: [PATCH v12 2/4] drivers/acpi: Introduce Platform Firmware
 Runtime Update device driver
Message-ID: <20211220095240.GA582440@chenyu-desktop>
References: <cover.1639669829.git.yu.c.chen@intel.com>
 <11441d3b36608e0840c46eb45e6d75ffc1c020ec.1639669829.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11441d3b36608e0840c46eb45e6d75ffc1c020ec.1639669829.git.yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:03:02AM +0800, Chen Yu wrote:
> Introduce the pfr_update driver which can be used for Platform Firmware
> Runtime code injection and driver update [1]. The user is expected to
> provide the EFI capsule, and pass it to the driver by writing the capsule
> to a device special file. The capsule is transferred by the driver to the
> platform firmware with the help of an ACPI _DSM method under the special
> ACPI Platform Firmware Runtime Update device (INTC1080), and the actual
> firmware update is carried out by the low-level Management Mode code in
> the platform firmware.
> 
> This patch allows certain pieces of the platform firmware to be
> updated on the fly while the system is running (runtime) without the
> need to restart it, which is key in the cases when the system needs to
> be available 100% of the time and it cannot afford the downtime related
> to restarting it, or when the work carried out by the system is
> particularly important, so it cannot be interrupted, and it is not
> practical to wait until it is complete.
> 
> Link: https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf # [1]
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> +
[cut]
> +static int start_update(int action, struct pfru_device *pfru_dev)
> +{
> +	union acpi_object *out_obj, in_obj, in_buf;
> +	struct pfru_updated_result update_result;
> +	acpi_handle handle;
> +	int ret = -EINVAL;
> +
> +	memset(&in_obj, 0, sizeof(in_obj));
> +	memset(&in_buf, 0, sizeof(in_buf));
> +	in_obj.type = ACPI_TYPE_PACKAGE;
> +	in_obj.package.count = 1;
> +	in_obj.package.elements = &in_buf;
> +	in_buf.type = ACPI_TYPE_INTEGER;
> +	in_buf.integer.value = action;
> +
> +	handle = ACPI_HANDLE(pfru_dev->parent_dev);
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_guid,
> +					  pfru_dev->rev_id, PFRU_FUNC_START,
> +					  &in_obj, ACPI_TYPE_PACKAGE);
> +	if (!out_obj)
> +		return ret;
> +
> +	if (out_obj->package.count < UPDATE_NR_IDX ||
> +	    out_obj->package.elements[UPDATE_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
> +	    out_obj->package.elements[UPDATE_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER ||
> +	    out_obj->package.elements[UPDATE_AUTH_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER ||
> +	    out_obj->package.elements[UPDATE_AUTH_TIME_HI_IDX].type != ACPI_TYPE_INTEGER ||
> +	    out_obj->package.elements[UPDATE_EXEC_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER ||
> +	    out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	update_result.status =
> +		out_obj->package.elements[UPDATE_STATUS_IDX].integer.value;
Thanks for Hongyu's testing, the status should be cascaded to user space.
Will fix it in next version.

Thanks,
Chenyu
