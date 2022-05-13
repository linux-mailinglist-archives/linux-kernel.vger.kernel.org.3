Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB6525F61
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379145AbiEMJtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379143AbiEMJsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:48:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9C42268EB5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:48:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C7DE143D;
        Fri, 13 May 2022 02:48:50 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 891E83F73D;
        Fri, 13 May 2022 02:48:49 -0700 (PDT)
Message-ID: <39be28ea-1645-30c3-316e-87a43b8738a8@arm.com>
Date:   Fri, 13 May 2022 11:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] topology: Remove unused cpu_cluster_mask()
Content-Language: en-US
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220513093433.425163-1-dietmar.eggemann@arm.com>
In-Reply-To: <20220513093433.425163-1-dietmar.eggemann@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Barry Song <song.bao.hua@hisilicon.com> bounced
+ Barry Song <21cnbao@gmail.com>

On 13/05/2022 11:34, Dietmar Eggemann wrote:
> default_topology[] uses cpu_clustergroup_mask() for the CLS level
> (guarded by CONFIG_SCHED_CLUSTER) which is currently provided by x86
> (arch/x86/kernel/smpboot.c) and arm64 (drivers/base/arch_topology.c).
> 
> Fixes: 778c558f49a2c ("sched: Add cluster scheduler level in core and
> related Kconfig for ARM64")
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  include/linux/topology.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index f19bc3626297..4564faafd0e1 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -240,13 +240,6 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
>  }
>  #endif
>  
> -#if defined(CONFIG_SCHED_CLUSTER) && !defined(cpu_cluster_mask)
> -static inline const struct cpumask *cpu_cluster_mask(int cpu)
> -{
> -	return topology_cluster_cpumask(cpu);
> -}
> -#endif
> -
>  static inline const struct cpumask *cpu_cpu_mask(int cpu)
>  {
>  	return cpumask_of_node(cpu_to_node(cpu));

