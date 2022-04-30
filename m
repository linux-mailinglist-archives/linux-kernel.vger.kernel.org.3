Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7015515E22
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382826AbiD3OXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiD3OXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:23:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D481491;
        Sat, 30 Apr 2022 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651328393; x=1682864393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nphz5HzJhcSyn4vVnpceC7wDEJOUc5GaLm+hmcbtNCA=;
  b=YCHIB76VNvkee+6C8VtZW8ei5v1B2tJ60AnsZHKxDpUy9fEH4YQuQFBC
   /uJ9i9khh+Rpu+gmM75WNDOiOcA8nfrFW752dllFwPkoYuxeLu7rN9RuO
   Rfm/9mKvzZzwghTEFJfeQAYzyzzZWQvkefMMxshSv+GOlT+GndMKGkfGK
   662WGF3v2U8OsO00v/LshrSSR8rqfLcubI6QAnVpPvP23yNm1qT6vfH90
   /o8pIoRXyd/UrgoSwmt8qtnhsy6d5cMZEX4EIfqkvuW9ij3FWl4ITJzbW
   TxBR1+p1aJ70GSQoPkYukYhGdAirMcdolZXnUYKWE9OERYvluqhyWVRPz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="246800719"
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="246800719"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 07:19:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="582780640"
Received: from shaohuil-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.171.220])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 07:19:51 -0700
Date:   Sat, 30 Apr 2022 22:19:47 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/power turbostat: close file after use
Message-ID: <20220430141947.GA5101@chenyu5-mobl1>
References: <20220430141557.1065405-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430141557.1065405-1-trix@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 10:15:57AM -0400, Tom Rix wrote:
> The cppcheck reports this issue
> turbostat.c:2039]: (error) Resource leak: fp
> 
> When the fscanf fails an error is returned without closing fp.
> Move the fclose so even if the fscanf fails, the file will be closed.
> 
> Fixes: eae97e053fe3 ("tools/power turbostat: Support thermal throttle count print")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index ede31a4287a0..2e9a751af260 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -2035,9 +2035,9 @@ int get_core_throt_cnt(int cpu, unsigned long long *cnt)
>  	if (!fp)
>  		return -1;
>  	ret = fscanf(fp, "%lld", &tmp);
> +	fclose(fp);
>  	if (ret != 1)
>  		return -1;
> -	fclose(fp);
>  	*cnt = tmp;
>  
>  	return 0;
> --
Thank you Tom, and Colin has proposed a fix here:
https://lore.kernel.org/lkml/20220426131607.1520483-1-colin.i.king@gmail.com/

thanks,
Chenyu
