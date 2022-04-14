Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC13500CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiDNMSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiDNMSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:18:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30835549C;
        Thu, 14 Apr 2022 05:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B4A461F1B;
        Thu, 14 Apr 2022 12:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A300C385A1;
        Thu, 14 Apr 2022 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649938577;
        bh=FhgNB6nGbaSWR1zWFLwWKZoR5zU6ItbocIB/M0guKZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7cS44DIt07c6L3jcxE/iVa6IXQhSan6yRWtDkGh1YmxN4Gdrx0eJ1QAreNHEOyOY
         DgJthEblm6HoCZddYZgv2uG8bOgkKQJ1awacUOuvnalwf07bmnxIP6OrA8h7X0Ccge
         unClZKOikWRFVCSX/sljCl09QBdiGXQlohTPvtywJtOyyP/e+tQuehr4CbO5iVq1PN
         t9pXbreKhwsNRIyNCwF+0ZPYaFgQtbWKWV8KkW6fulHsmgHSwSjbcW30l632jXHcDN
         ut9CcnFPyYuwf/IQ1eDo02idh7baPZt9aY1fGQn71S/gJBjxWyW3CYdhcPsvweD1ur
         I7kKPV0LsyWfw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 621BB40407; Thu, 14 Apr 2022 09:16:15 -0300 (-03)
Date:   Thu, 14 Apr 2022 09:16:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     jolsa@kernel.org, disgoel@linux.vnet.ibm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, linux-kernel@vger.kernel.org,
        srikar@linux.vnet.ibm.com, irogers@google.com
Subject: Re: [PATCH V3 0/2] Fix perf bench numa to work with machines having
 #CPUs > 1K
Message-ID: <YlgQj40R3so8xz50@kernel.org>
References: <20220412164059.42654-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412164059.42654-1-atrajeev@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 12, 2022 at 10:10:57PM +0530, Athira Rajeev escreveu:
> The perf benchmark for collections: numa hits failure in system
> configuration with CPU's more than 1024. These benchmarks uses
> "sched_getaffinity" and "sched_setaffinity" in the code to
> work with affinity.

Thanks, applied.

- Arnaldo

 
> Example snippet from numa benchmark:
> <<>>
> perf: bench/numa.c:302: bind_to_node: Assertion `!(ret)' failed.
> Aborted (core dumped)
> <<>>
> 
> bind_to_node function uses "sched_getaffinity" to save the cpumask.
> This fails with EINVAL because the default mask size in glibc is 1024
> 
> To overcome this 1024 CPUs mask size limitation of cpu_set_t,
> change the mask size using the CPU_*_S macros ie, use CPU_ALLOC to
> allocate cpumask, CPU_ALLOC_SIZE for size, CPU_SET_S to set mask bit.
> 
> Fix all the relevant places in the code to use mask size which is large
> enough to represent number of possible CPU's in the system.
> 
> This patchset also address a fix for parse_setup_cpu_list function in
> numa bench to check if input CPU is online before binding task to
> that CPU. This is to fix failures where, though CPU number is within
> max CPU, it could happen that CPU is offline. Here, sched_setaffinity
> will result in failure when using cpumask having that cpu bit set
> in the mask.
> 
> Patch 1 address fix for parse_setup_cpu_list to check if CPU used to bind
> task is online. Patch 2 has fix for bench numa to work with machines
> having #CPUs > 1K
> 
> Athira Rajeev (2):
>   tools/perf: Fix perf bench numa testcase to check if CPU used to bind
>     task is online
>   perf bench: Fix numa bench to fix usage of affinity for machines with
>     #CPUs > 1K
> 
> Changelog:
> v2 -> v3
> Link to the v2 version :
> https://lore.kernel.org/all/20220406175113.87881-1-atrajeev@linux.vnet.ibm.com/
>  - From the v2 version, patch 1 and patch 2 are now part of upstream.
>  - This v3 version separates patch 3 and patch 4 to address review
>    comments from arnaldo which includes using sysfs__read_str for reading
>    sysfs file and fixing the compilation issues observed in debian
> 
>  tools/perf/bench/numa.c  | 136 +++++++++++++++++++++++++++++----------
>  tools/perf/util/header.c |  51 +++++++++++++++
>  tools/perf/util/header.h |   1 +
>  3 files changed, 153 insertions(+), 35 deletions(-)
> 
> -- 
> 2.35.1

-- 

- Arnaldo
