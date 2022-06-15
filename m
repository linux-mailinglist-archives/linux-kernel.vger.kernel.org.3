Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFF54D153
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347983AbiFOTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiFOTF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:05:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A82316A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655319959; x=1686855959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OuM7gkbOg0MzPEJgys5x7ZlalSiOHpnlfvZma3wKoiY=;
  b=elPnCCBN4Nqe9h6k3uthwzZJqqdPQHKy/trzNpZ9kb/VqWjFTYv2O0eE
   on/XDmK+Nk9VU+C9KEsWb+tJMl7F8iQxwRB0Iy4sA0dH6NC8VbDJoNV+1
   xKDhfFg3syL71//tm432QkwEs89as4sX8TawV43/7cB+w9fKxT+dGmty8
   ktv2KINRzb/4W8k1jdaT0UhQgQZv+2qcIvdZiVSdN2jOJD74Pm33QYqO8
   8se0RjQI0ISdVMYvigvEDTlQQmJW7dmDvgLts+GrSqkIpadjRWDAD/SHr
   cncF/GXi0tukMv2TsOVCvbEs4gjeZE+4/VVwYyTOTjbghhGXEMYmlWehp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="276653042"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="276653042"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 12:05:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="762603318"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 12:05:37 -0700
Date:   Wed, 15 Jun 2022 12:05:19 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com
Subject: Re: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
Message-ID: <20220615190519.GA1524500@alison-desk>
References: <20220614210217.1940563-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614210217.1940563-1-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 06:02:17PM -0300, Martin Fernandez wrote:
> Right now the only way to check this is by greping the kernel logs,
> which is inconvinient. This is currently checked for fwupd for
> example.
> 
> I understand that cpuinfo is supposed to report every feature in the
> cpu but since AMD is doing the same for sme/sev I think is good to
> have this for Intel too.

Martin,

Can you tell, or point me to, more info about your use case?

My first reaction is lying about the cpuinfo is not a soln, since
it creates a problem for a users currently relying on cpuinfo to be
the source of truth for TME. Are we to tell them to go look in the
log now, because fwupd folks didn't want to ;)

What were your other options?

Alison

> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index fd5dead8371c..7311172aceaf 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -570,6 +570,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
> 
>  	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
>  		pr_info_once("x86/tme: not enabled by BIOS\n");
> +		if (mktme_status == MKTME_UNINITIALIZED)
> +			clear_cpu_cap(c, X86_FEATURE_TME);
>  		mktme_status = MKTME_DISABLED;
>  		return;
>  	}
> --
> 2.30.2
> 
