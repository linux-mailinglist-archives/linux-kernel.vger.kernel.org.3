Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80034AE17F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385546AbiBHSv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385421AbiBHSvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:51:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99714C0612C0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644346306; x=1675882306;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Q2mh3eOg4xNTxgD0+mwb382wcBgYuaMQIdn7dMUxwAc=;
  b=N2mUM+YA8RLgG3n6m6+8KV/8/ABAiXnrReeKZ7y/EtZnCsRxD9EdlftZ
   OcsAHeoX7MF83YpEVO6sL9S70cHaSi/OGQ96XxJczryAKIUKQ9c/nLMmG
   WOJkRZMr4cGjPMZAG+qBsRw1b/7CemrKWbfMIX6eBZ08p3a1WIp8urkld
   5DYvDTa78RhJG/vr0UKuYn7ryI3DhQPQGzY4XVO0EQIm3uxxOVAaj0lgc
   +IyIYJfjSjXMEShvNsDpp1o09nmOynVvn+IGWIcWj1YE1xmKaSd9frO6w
   Lg+eTMjGJUwNWjLW2BoVTZ6UXE8p9nYCfhM+/z5L8deB3RhPWFFcy/XR5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236431611"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="236431611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 10:51:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="540736470"
Received: from ijbeckin-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.19.63])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 10:51:41 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 05/12] drm/i915: Protect lockdep functions with #ifdef
In-Reply-To: <20220208184208.79303-6-namhyung@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220208184208.79303-1-namhyung@kernel.org>
 <20220208184208.79303-6-namhyung@kernel.org>
Date:   Tue, 08 Feb 2022 20:51:38 +0200
Message-ID: <87y22lp4xx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Feb 2022, Namhyung Kim <namhyung@kernel.org> wrote:
> With upcoming lock tracepoints config, it'd define some of lockdep
> functions without enabling CONFIG_LOCKDEP actually.  The existing code
> assumes those functions will be removed by the preprocessor but it's
> not the case anymore.  Let's protect the code with #ifdef's explicitly.

I don't understand why you can't keep the no-op stubs for
CONFIG_LOCKDEP=n.

BR,
Jani.

>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  drivers/gpu/drm/i915/intel_wakeref.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/intel_wakeref.c b/drivers/gpu/drm/i915/intel_wakeref.c
> index dfd87d082218..6e4b8d036283 100644
> --- a/drivers/gpu/drm/i915/intel_wakeref.c
> +++ b/drivers/gpu/drm/i915/intel_wakeref.c
> @@ -106,8 +106,11 @@ void __intel_wakeref_init(struct intel_wakeref *wf,
>  	wf->wakeref = 0;
>  
>  	INIT_DELAYED_WORK(&wf->work, __intel_wakeref_put_work);
> +
> +#ifdef CONFIG_LOCKDEP
>  	lockdep_init_map(&wf->work.work.lockdep_map,
>  			 "wakeref.work", &key->work, 0);
> +#endif
>  }
>  
>  int intel_wakeref_wait_for_idle(struct intel_wakeref *wf)

-- 
Jani Nikula, Intel Open Source Graphics Center
