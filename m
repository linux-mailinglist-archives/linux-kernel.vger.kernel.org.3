Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9820540BB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 20:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351653AbiFGSaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 14:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351394AbiFGSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 14:02:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9C12E33D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654623863; x=1686159863;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dcjI6c1qBy+95NmJsucYe4f7ZIyMQ6H0lcQn32Io+mw=;
  b=kcdLAD9lfNKgPYw7HIbTpdHjUeLd+YnwyjK/iEqixt0qzlog8YKBNGxr
   /ew6zD2AJZxEWNIfcK7VrCwbBgPjVNdnDdMnhT3HjCI8bv5KYiWFEK8uW
   Zlz3uhY92Am2MXuYTQd1lS2TgtzZIo2HCmhs+qSDCDw/IEVW6wqjK4X9t
   kUCC6Ceq40ourys/Rop5gv+RqhQSy6P4HlVCWLjqJ6jOyB+dua9uOzxIr
   w+BEX7NwYdIxXXzZsDfxUKQg5v6aUYYZ2bF9nlSi7rGjfQ0XCz2i3jO/V
   HfO8Q8s+YDyO5zxM5Mc3z4iva2bPPZm4tkCVUKJJbrEsrZSkbReAoPxTd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="274267366"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="274267366"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 10:44:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="609291334"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.8.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 10:44:22 -0700
Message-ID: <35202f2acb9367b926b2066af3f7f4731a9c5f47.camel@linux.intel.com>
Subject: Re: [PATCH] x86: topology_update_package_map function doesn't use
 the return value
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Li kunyu <kunyu@nfschina.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, rafael.j.wysocki@intel.com, tony.luck@intel.com,
        tim.gardner@canonical.com, boris.ostrovsky@oracle.com
Cc:     peterz@infradead.org, ray.huang@amd.com, paulmck@kernel.org,
        ionela.voinescu@arm.com, linux-kernel@vger.kernel.org
Date:   Tue, 07 Jun 2022 10:44:22 -0700
In-Reply-To: <20220606122316.291022-1-kunyu@nfschina.com>
References: <20220606122316.291022-1-kunyu@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 20:23 +0800, Li kunyu wrote:
> topology_update_package_map function could remove the return value, and
> it could remove the BUG_ON check.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

As far as I can tell, topology_update_package_map() should always succeed and return 0.
Either there is an existing mapping of the physical package to a logical
package id and we don't have to do anything, or we assign a new logical package id to this
physical package id that doesn't have a mapping.

So I agree that checking for the failure and non-zero return of topology_update_package_map()
is useless.

Likewise, I think topology_update_die_map() should always succeed and we can remove
checking of its return value.  

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>


> ---
>  arch/x86/include/asm/topology.h | 6 +++---
>  arch/x86/kernel/cpu/common.c    | 2 +-
>  arch/x86/kernel/smpboot.c       | 3 +--
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 458c891a8273..eabfb44b63ed 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -136,7 +136,7 @@ static inline int topology_max_smt_threads(void)
>  	return __max_smt_threads;
>  }
>  
> -int topology_update_package_map(unsigned int apicid, unsigned int cpu);
> +void topology_update_package_map(unsigned int apicid, unsigned int cpu);
>  int topology_update_die_map(unsigned int dieid, unsigned int cpu);
>  int topology_phys_to_logical_pkg(unsigned int pkg);
>  int topology_phys_to_logical_die(unsigned int die, unsigned int cpu);
> @@ -144,8 +144,8 @@ bool topology_is_primary_thread(unsigned int cpu);
>  bool topology_smt_supported(void);
>  #else
>  #define topology_max_packages()			(1)
> -static inline int
> -topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
> +static inline void
> +topology_update_package_map(unsigned int apicid, unsigned int cpu) { }
>  static inline int
>  topology_update_die_map(unsigned int dieid, unsigned int cpu) { return 0; }
>  static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index c296cb1c0113..22d19a1feafd 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1673,7 +1673,7 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
>  		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
>  		       cpu, apicid, c->initial_apicid);
>  	}
> -	BUG_ON(topology_update_package_map(c->phys_proc_id, cpu));
> +	topology_update_package_map(c->phys_proc_id, cpu);
>  	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
>  #else
>  	c->logical_proc_id = 0;
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 5e7f9532a10d..20c67cca245b 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -327,7 +327,7 @@ EXPORT_SYMBOL(topology_phys_to_logical_die);
>   * @pkg:	The physical package id as retrieved via CPUID
>   * @cpu:	The cpu for which this is updated
>   */
> -int topology_update_package_map(unsigned int pkg, unsigned int cpu)
> +void topology_update_package_map(unsigned int pkg, unsigned int cpu)
>  {
>  	int new;
>  
> @@ -343,7 +343,6 @@ int topology_update_package_map(unsigned int pkg, unsigned int cpu)
>  	}
>  found:
>  	cpu_data(cpu).logical_proc_id = new;
> -	return 0;
>  }
>  /**
>   * topology_update_die_map - Update the physical to logical die map

