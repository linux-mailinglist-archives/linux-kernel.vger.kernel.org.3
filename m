Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2317B46C7A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbhLGWrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:47:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:4185 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237728AbhLGWre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:47:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="217726744"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="217726744"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 14:44:03 -0800
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="462510396"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 14:44:03 -0800
Date:   Tue, 7 Dec 2021 22:43:50 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: remove redundant assignment to variable
 chunks
Message-ID: <Ya/jpoUWCy5shYI6@otcwcpicx3.sc.intel.com>
References: <20211207223735.35173-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207223735.35173-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:37:35PM +0000, Colin Ian King wrote:
> The variable chunks is being shifted right and re-assinged the shifted
> value which is then returned. Since chunks is not being read afterwards
> the assignment is redundant and the >>= operator can be replaced with a
> shift >> operator instead.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c9f0f3d63f75..eaf25a234ff5 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -282,7 +282,7 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>  	u64 shift = 64 - width, chunks;
>  
>  	chunks = (cur_msr << shift) - (prev_msr << shift);
> -	return chunks >>= shift;
> +	return chunks >> shift;
>  }
>  
>  static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
