Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21464AC69F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356789AbiBGQ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345050AbiBGQyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:54:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512CCC0401D1;
        Mon,  7 Feb 2022 08:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644252883; x=1675788883;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+pqaVwVJuNphP//KjAHwk2bzB7Rnt6sfqu2yWGa2liU=;
  b=njqZrRQGXCvD3RhPS48K1WNiegmEaV2Elg2xgAX9pP0zRBFKf3MbO6w7
   8nxI0mbyA9HBluVmp7KLdRg0AEnZtQi+b5l0ePajmprGdo7844I09KjDh
   d+pijiqtIRYYmffO/vfxPR2BPlYW5E2gmltpNQa2KPzXRhvQ9R7P9VDwZ
   5R6x+NRKk6WWCQiEgpPNP7Ij5gjKHrCCQj4cyCusIxzRd+4CJnZ4E7zDf
   csP2RCUnDW11tVStMNASpc9oEFqvYp5Stwksg1zUT2IA43sFf9XrASaen
   5D64qdW/UKhGwgBfyi+4u+h+QiS84EWlLVTerigGaFrtraXPyBl8SHE/6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273278949"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="273278949"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 08:54:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="632519138"
Received: from kscionea-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.130.139])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 08:54:42 -0800
Message-ID: <0d11f34a98e720cb5cf0d37e67a3e130d8275e31.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: netlink: Fix parameter type of
 thermal_genl_cpu_capability_event() stub
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon, 07 Feb 2022 08:54:41 -0800
In-Reply-To: <20220207163829.1025904-1-nathan@kernel.org>
References: <20220207163829.1025904-1-nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 09:38 -0700, Nathan Chancellor wrote:
> When building with CONFIG_THERMAL_NETLINK=n, there is a spew of
> warnings
> along the lines of:
> 
>   In file included from drivers/thermal/thermal_core.c:27:
>   In file included from drivers/thermal/thermal_core.h:15:
>   drivers/thermal/thermal_netlink.h:113:71: warning: declaration of
> 'struct cpu_capability' will not be visible outside of this function
> [-Wvisibility]
>   static inline int thermal_genl_cpu_capability_event(int count,
> struct cpu_capability *caps)
>                                                                      
>    ^
>   1 warning generated.
> 
> 'struct cpu_capability' is not forward declared anywhere in the
> header.
> As it turns out, this should really be 'struct
> thermal_genl_cpu_caps',
> which silences the warning and makes the parameter types of the stub
> match the full function.
Thanks for sending the patch. I was about to send this change.
Since this patch target only linux-next, don't we need prefix:
"[PATCH -next]" instead of "[PATCH]"?

> 
> Fixes: e4b1eb24ce5a ("thermal: netlink: Add a new event to notify CPU
> capabilities change")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/thermal/thermal_netlink.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_netlink.h
> b/drivers/thermal/thermal_netlink.h
> index 04d1adbbc012..1052f523188d 100644
> --- a/drivers/thermal/thermal_netlink.h
> +++ b/drivers/thermal/thermal_netlink.h
> @@ -110,7 +110,7 @@ static inline int thermal_genl_sampling_temp(int
> id, int temp)
>         return 0;
>  }
>  
> -static inline int thermal_genl_cpu_capability_event(int count,
> struct cpu_capability *caps)
> +static inline int thermal_genl_cpu_capability_event(int count,
> struct thermal_genl_cpu_caps *caps)
>  {
>         return 0;
>  }
> 
> base-commit: 08615cb8c0e1deeca5489d672213fb205fa53c3b

