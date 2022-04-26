Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F4F50FF41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349694AbiDZNmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiDZNml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:42:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A2A66AE6;
        Tue, 26 Apr 2022 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650980374; x=1682516374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7fuoHjFYh58bCMLDeH91TfTPQ3w0G2M79t/dH46cWVM=;
  b=kk55sE6m9ngH5zhZlN111jJef38ZLzfv5FlpLa3wXk/eaTmdeWxfHChL
   xQUTRX38IL78SDBiIZ9xIZ3QXUhSV6LL7I9IkNWmqPdt1J0wGRaKCrPaY
   Uh9aBFJEIpotgaWJcKgG0bRBd55X2qcPpX8ijPagbESMlI/uXpF3B7huC
   dpExB89eB1unPmgwo0xbk4vZYlCad05KFFgACmT6PJoHcExEVN/IUmiF/
   xGei0lYlG/hP2fxwmZquqiS9JqtTBmDxAc3jQLT/Y/U1PLJNIdX61PyBA
   XrCZfxxP5tEc1jkYH23m9hjGJnyCYiZyt0bGbnySP0IcME9mDXYriRThK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252955802"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="252955802"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 06:39:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579898754"
Received: from dongyiyu-mobl1.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.173.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 06:39:30 -0700
Date:   Tue, 26 Apr 2022 21:39:26 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/power turbostat: Fix file pointer leak
Message-ID: <20220426133926.GA33188@chenyu5-mobl1>
References: <20220426131607.1520483-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426131607.1520483-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 02:16:07PM +0100, Colin Ian King wrote:
> Currently if a fscanf fails then an early return leaks an open
> file pointer. Fix this by fclosing the file before the return.
> Detected using static analysis with cppcheck:
> 
> tools/power/x86/turbostat/turbostat.c:2039:3: error: Resource leak: fp [resourceLeak]
> 
> Fixes: eae97e053fe3 ("tools/power turbostat: Support thermal throttle count print")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index e6779f599a8e..db431b31c4df 100644
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
Acked-by: Chen Yu <yu.c.chen@intel.com>

Thanks for fixing it.


Chenyu
