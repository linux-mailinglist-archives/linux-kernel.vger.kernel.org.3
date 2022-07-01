Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3895562B0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiGAFst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiGAFsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:48:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDED6B260;
        Thu, 30 Jun 2022 22:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656654527; x=1688190527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y5ug2lyRKciQTK4LIaK6tpSgjuLHRuKAtCuP90hqIAY=;
  b=Yk2yocUeVh4/v7hL72iZ3LS4sqXqto/M7DNFRPeXeKKoolhRW63KTAfV
   2DVXtIZrFp5mkhODN+E50BejC1pMvPkrOhoHesuGckpvxRNkj3/b9V+1x
   yDKGnJIwtZh5IPrVJxRamHW0s3aMcsaZgIB1J04odwszAzjX+ajYUpzwH
   FAeZOMttIZlIfDI1B1A8BRfPpO/J6ymjqtJ5c155Dz0kvCt+uLGZsh3tK
   L2EGDxabBl9fGoVMGc0foQw9ypqvbHRvm1TDIztwZGVyf/5PpqYsyfdLL
   ySIGbMHYAfICCS05oOuW6YMl89PRY/EuSp+BooPbzk3P2W99X/y8288xl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="282590975"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="282590975"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 22:48:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="733930884"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 22:48:43 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 01 Jul 2022 08:48:40 +0300
Date:   Fri, 1 Jul 2022 08:48:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>,
        perry.yuan@amd.com, CUI Hao <cuihao.leo@gmail.com>,
        maxim.novozhilov@gmail.com, lethe.tree@protonmail.com,
        garystephenwright@gmail.com, galaxyking0419@gmail.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ACPI: CPPC: Only probe for _CPC if CPPC v2 is
 acked
Message-ID: <Yr6KuPlWN6girxnx@lahna>
References: <20220701022529.2134-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701022529.2134-1-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:25:27PM -0500, Mario Limonciello wrote:
> Previously the kernel used to ignore whether the firmware masked CPPC
> or CPPCv2 and would just pretend that it worked.
> 
> When support for the USB4 bit in _OSC was introduced from commit
> 9e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
> the kernel began to look at the return when the query bit was clear.
> 
> This caused regressions that were misdiagnosed and attempted to be solved
> as part of commit 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities
> to the _OSC regardless of the query flag""). This caused a different
> regression where non-Intel systems weren't able to negotiate _OSC
> properly.
> 
> This was reverted in commit 2ca8e6285250 ("Revert "ACPI: Pass the same
> capabilities to the _OSC regardless of the query flag"") and attempted to
> be fixed by commit c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not
> supported by firmware") but the regression still returned.
> 
> These systems with the regression only load support for CPPC from an SSDT
> dynamically when _OSC reports CPPC v2.  Avoid the problem by not letting
> CPPC satisfy the requirement in `acpi_cppc_processor_probe`.
> 
> Reported-by: CUI Hao <cuihao.leo@gmail.com>
> Reported-by: maxim.novozhilov@gmail.com
> Reported-by: lethe.tree@protonmail.com
> Reported-by: garystephenwright@gmail.com
> Reported-by: galaxyking0419@gmail.com
> Fixes: c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not supported by firmware")
> Fixes: 2ca8e6285250 ("Revert "ACPI Pass the same capabilities to the _OSC regardless of the query flag"")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=213023
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2075387
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
