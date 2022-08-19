Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A659A3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350285AbiHSSBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350188AbiHSSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:00:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B517C105F00
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:46:59 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 352B92304141; Fri, 19 Aug 2022 10:46:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 352B92304141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660931219;
        bh=CXjLZTzWLgHm11JMQkD6Kgs5OR1kO/Wx2RQqlqJYj5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qs/3Hsue/QdOEIhR6OrSSHNFMYBVXoIzO0wNwCTvRjqT6l4taop7Gx+ypITa11sU9
         xqXuelwYgK5SWo1XfZHW+aVE1o2pRpQWhudFmP+DdEJ2VjoUFyCQLiRn7DB4k9sb7J
         Wov2N7HpYzVfF+Q1JYVAwl8gykCsdYhlZf/ctUgM=
Date:   Fri, 19 Aug 2022 10:46:59 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     ssengar@microsoft.com, mikelley@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org, tim.c.chen@linux.intel.com,
        will@kernel.org, song.bao.hua@hisilicon.com,
        suravee.suthikulpanit@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cacheinfo: Don't use cpu_llc_shared_map for
 !CONFIG_SMP
Message-ID: <20220819174659.GA16818@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1660148115-302-1-git-send-email-ssengar@linux.microsoft.com>
 <Yv1ELaWHbRfvdt/p@zn.tnic>
 <20220818045225.GA9054@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Yv4pOz01nAkafiwd@zn.tnic>
 <20220818122925.GA8507@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Yv/FXcOkB0BpUkVn@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv/FXcOkB0BpUkVn@zn.tnic>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 07:16:13PM +0200, Borislav Petkov wrote:
> On Thu, Aug 18, 2022 at 05:29:25AM -0700, Saurabh Singh Sengar wrote:
> > Boot latest linux kernel on AMD CPU, having CONGIG_SMP=n. Once booted
> > execute lscpu (just lscpu without any argument ), this will cause
> > segfault. Please make a note issue is observed with 2.34 version
> > (default lscpu version with Ubuntu 20.04.4) of lscpu.
> 
> Does that fix it?

Yes, this patch fixes this segfault.

- Saurabh

> 
> ---
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 81a0211a372d..a73bced40e24 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -21,16 +21,6 @@ DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
>  DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
>  DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
>  
> -static inline struct cpumask *cpu_llc_shared_mask(int cpu)
> -{
> -	return per_cpu(cpu_llc_shared_map, cpu);
> -}
> -
> -static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
> -{
> -	return per_cpu(cpu_l2c_shared_map, cpu);
> -}
> -
>  DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
>  DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
>  DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid);
> @@ -172,6 +162,16 @@ extern int safe_smp_processor_id(void);
>  # define safe_smp_processor_id()	smp_processor_id()
>  #endif
>  
> +static inline struct cpumask *cpu_llc_shared_mask(int cpu)
> +{
> +	return per_cpu(cpu_llc_shared_map, cpu);
> +}
> +
> +static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
> +{
> +	return per_cpu(cpu_l2c_shared_map, cpu);
> +}
> +
>  #else /* !CONFIG_SMP */
>  #define wbinvd_on_cpu(cpu)     wbinvd()
>  static inline int wbinvd_on_all_cpus(void)
> @@ -179,6 +179,11 @@ static inline int wbinvd_on_all_cpus(void)
>  	wbinvd();
>  	return 0;
>  }
> +
> +static inline struct cpumask *cpu_llc_shared_mask(int cpu)
> +{
> +	return (struct cpumask *)cpumask_of(0);
> +}
>  #endif /* CONFIG_SMP */
>  
>  extern unsigned disabled_cpus;
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
