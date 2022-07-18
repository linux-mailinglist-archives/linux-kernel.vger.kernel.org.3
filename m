Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93708578667
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbiGRP3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbiGRP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:29:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E17BA9;
        Mon, 18 Jul 2022 08:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658158155; x=1689694155;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yH2iAt7Nak/S2cxw66iqqC0mytMna35OO1GjNSnHyFo=;
  b=Iq0O5rreNmIynoPU/qpnN2x9ipQ1aOY7v+5yFu3a2so0hpMXU4KzAN4X
   iCfMBOo1/V+XESlU6XHZ2Ji6pnQgfbllir5sbL89m7dlRgFlfMunko8kT
   JU7v1ME++muFOw0lIsKEaPX2A2bwozkExYcOIrokrA8NV01Vrvv+zJxOW
   25IWSNTsnn8BHPADDVFzCraLIbGf359c+hLc7tnZtivvA87OZpj0m0mvr
   aaQBw59TSkcWAKeXCnuukiJD39czSD20mU7HjJdXicauGKIItWFD32hM6
   7hvDe+dQMv/S4tt49UCs4RLJz0zrrsAYlWPLyeU2GTmLWStbgjX4lUDcL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="347938874"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="347938874"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 08:29:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="572449344"
Received: from jwconnol-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.102.92])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 08:29:13 -0700
Message-ID: <4d30ed8d43d0db93c5f550bb69931f288285aa2b.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: Fix off by one check
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Mon, 18 Jul 2022 08:29:13 -0700
In-Reply-To: <YtVdXen0K8KH0kwu@kili>
References: <YtVdXen0K8KH0kwu@kili>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-18 at 16:17 +0300, Dan Carpenter wrote:
> Change > MAX_DIE_PER_PACKAGE to >= MAX_DIE_PER_PACKAGE to prevent
> accessing one element beyond the end of the array.
> 
> Fixes: 7fd786dfbd2c ("tools/power/x86/intel-speed-select: OOB daemon
> mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Thanks. I will add to PULL request.


> ---
>  tools/power/x86/intel-speed-select/isst-daemon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst-daemon.c
> b/tools/power/x86/intel-speed-select/isst-daemon.c
> index dd372924bc82..d0400c6684ba 100644
> --- a/tools/power/x86/intel-speed-select/isst-daemon.c
> +++ b/tools/power/x86/intel-speed-select/isst-daemon.c
> @@ -41,7 +41,7 @@ void process_level_change(int cpu)
>         time_t tm;
>         int ret;
>  
> -       if (pkg_id >= MAX_PACKAGE_COUNT || die_id >
> MAX_DIE_PER_PACKAGE) {
> +       if (pkg_id >= MAX_PACKAGE_COUNT || die_id >=
> MAX_DIE_PER_PACKAGE) {
>                 debug_printf("Invalid package/die info for cpu:%d\n",
> cpu);
>                 return;
>         }

