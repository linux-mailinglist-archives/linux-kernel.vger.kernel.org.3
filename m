Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC904AE708
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344680AbiBICl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbiBIBU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:20:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C141C061576;
        Tue,  8 Feb 2022 17:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644369657; x=1675905657;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KEaPwJmUGWbZRDEqJhcubq0qBwr8UxG9hzcFEba0iRM=;
  b=I4EEqEQAMCT0BzvvnFi4eBuwwwt/w124h4gOHp8i0IG8jhxDUFmJtlwk
   AXwEuAP+2u4l6jNmTtlOiyGVCvsgIp4YQBvYS0RlgLds09Rdq6gChLvjX
   st0KY8wIoyzDfvyn7m0L7Bqm7WlstgcH7ynvFHVcLCSXOF3irdI7WQxkj
   SN4ot0mcuMoOb5iYIK0pqjlxvNVGT+Kt7ZNtNBw1wn1NTTa5fJCQzLI79
   LfKjzeLy7qIY5RtTwSs5ZnvaQPd+EJJv8brV4yZNf/5KWcdpn4vF7BKHF
   EhyPieAicglCUKVTAwead86Nvx4r+0jCYnlKSz5GNAk0q7htrnwIoPLOg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236500715"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="236500715"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 17:20:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="585390233"
Received: from rmkeeler-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.125.131])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 17:20:56 -0800
Message-ID: <2f8915fd15862a70ed5c4b92632bbe6035b8ea57.camel@linux.intel.com>
Subject: Re: [PATCH -next] thermal: intel: INTEL_HFI_THERMAL depends on NET
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 08 Feb 2022 17:20:55 -0800
In-Reply-To: <20220209001546.18189-1-rdunlap@infradead.org>
References: <20220209001546.18189-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 16:15 -0800, Randy Dunlap wrote:
> THERMAL_NETLINK depends on NET and since 'select' does not follow
> any dependency chain, INTEL_HFI_THERMAL also should depend on NET.
> 
> Fix one Kconfig warning and 48 subsequent build errors:
> 
> WARNING: unmet direct dependencies detected for THERMAL_NETLINK
>   Depends on [n]: THERMAL [=y] && NET [=n]
>   Selected by [y]:
>   - INTEL_HFI_THERMAL [=y] && THERMAL [=y] && (X86 [=y] ||
> X86_INTEL_QUARK [=n] || COMPILE_TEST [=y]) && CPU_SUP_INTEL [=y] &&
> X86_THERMAL_VECTOR [=y]
> 
Thanks for the fix.

> Fixes: bd30cdfd9bd7 ("thermal: intel: hfi: Notify user space for HFI
> events")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> Found in mmotm, linux-next.patch.
> 
>  drivers/thermal/intel/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- mmotm-2022-0208-1531.orig/drivers/thermal/intel/Kconfig
> +++ mmotm-2022-0208-1531/drivers/thermal/intel/Kconfig
> @@ -102,6 +102,7 @@ config INTEL_MENLOW
>  
>  config INTEL_HFI_THERMAL
>         bool "Intel Hardware Feedback Interface"
> +       depends on NET
>         depends on CPU_SUP_INTEL
>         depends on X86_THERMAL_VECTOR
>         select THERMAL_NETLINK

