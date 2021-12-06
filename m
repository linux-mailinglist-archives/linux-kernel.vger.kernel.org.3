Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BCB468E41
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 01:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbhLFAZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 19:25:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35396 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLFAZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 19:25:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 541D461122
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 00:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A551BC00446;
        Mon,  6 Dec 2021 00:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638750128;
        bh=u6QvygQbDqsAWPW8I4rZic6C3XxTDgQWyFXspcApdRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cfellLSiZ2Mqn7qbFmDHNnYnZQCZ1phPSaQMTF+S7Uc4KPAhqhgzyg+1I9JPicBPN
         BYBBTVvllzaPGOSbh9m05esAtnZJqCIf9g6zNz8uVSFjHwa8jL10uZDHPibvd4Vbdf
         EKnjq+MvGBL+/cGvKbWk4MCLIMR0dXe6tTUTy0+FbPgPlEkT4Iyjy8WuDigMTbi5Px
         6h5IRFZWIRqsrxy/PY/nmZp+hYPDzOarebDOn09Qk5E10yR6kxgFrnk0snPx9D9TZH
         TVmVSSjY4ukw7tlpWfqK909+Hc1QmOURifqkqsoGWfdA527JKa/Y3AfgpF5LQaGZuc
         mk9hPktLxiQdQ==
Date:   Mon, 6 Dec 2021 09:22:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     zhangyue <zhangyue1@kylinos.cn>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: fix out-of-bounds in register_kretprobe
Message-Id: <20211206092204.71fc11568168bf848a8e78b1@kernel.org>
In-Reply-To: <202112051255.NQeIOpp8-lkp@intel.com>
References: <20211201054855.5449-1-zhangyue1@kylinos.cn>
        <202112051255.NQeIOpp8-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Can you revert this patch, because as kernel-test bot says that
this does not change anything. (rp::data_size is unsigned.)

At least it should check the result of
"sizeof(struct kretprobe_instance) + rp->data_size". Moreover,
as I sent before as "kprobes: Limit max data_size of the kretprobe instances"
the data_size must be limited to avoid overflow.

Thank you,

On Sun, 5 Dec 2021 12:26:26 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi zhangyue,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on rostedt-trace/for-next]
> [also build test WARNING on v5.16-rc3 next-20211203]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/zhangyue/kprobes-fix-out-of-bounds-in-register_kretprobe/20211201-135046
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
> config: i386-randconfig-m021-20211203 (https://download.01.org/0day-ci/archive/20211205/202112051255.NQeIOpp8-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> kernel/kprobes.c:2107 register_kretprobe() warn: always true condition '(rp->data_size >= 0) => (0-u32max >= 0)'
> 
> vim +2107 kernel/kprobes.c
> 
>   2062	
>   2063	int register_kretprobe(struct kretprobe *rp)
>   2064	{
>   2065		int ret;
>   2066		struct kretprobe_instance *inst = NULL;
>   2067		int i;
>   2068		void *addr;
>   2069	
>   2070		ret = kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset);
>   2071		if (ret)
>   2072			return ret;
>   2073	
>   2074		/* If only 'rp->kp.addr' is specified, check reregistering kprobes */
>   2075		if (rp->kp.addr && warn_kprobe_rereg(&rp->kp))
>   2076			return -EINVAL;
>   2077	
>   2078		if (kretprobe_blacklist_size) {
>   2079			addr = kprobe_addr(&rp->kp);
>   2080			if (IS_ERR(addr))
>   2081				return PTR_ERR(addr);
>   2082	
>   2083			for (i = 0; kretprobe_blacklist[i].name != NULL; i++) {
>   2084				if (kretprobe_blacklist[i].addr == addr)
>   2085					return -EINVAL;
>   2086			}
>   2087		}
>   2088	
>   2089		rp->kp.pre_handler = pre_handler_kretprobe;
>   2090		rp->kp.post_handler = NULL;
>   2091	
>   2092		/* Pre-allocate memory for max kretprobe instances */
>   2093		if (rp->maxactive <= 0) {
>   2094	#ifdef CONFIG_PREEMPTION
>   2095			rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());
>   2096	#else
>   2097			rp->maxactive = num_possible_cpus();
>   2098	#endif
>   2099		}
>   2100		rp->freelist.head = NULL;
>   2101		rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
>   2102		if (!rp->rph)
>   2103			return -ENOMEM;
>   2104	
>   2105		rp->rph->rp = rp;
>   2106		for (i = 0; i < rp->maxactive; i++) {
> > 2107			if (rp->data_size >= 0)
>   2108				inst = kzalloc(sizeof(struct kretprobe_instance) +
>   2109				       rp->data_size, GFP_KERNEL);
>   2110			if (inst == NULL) {
>   2111				refcount_set(&rp->rph->ref, i);
>   2112				free_rp_inst(rp);
>   2113				return -ENOMEM;
>   2114			}
>   2115			inst->rph = rp->rph;
>   2116			freelist_add(&inst->freelist, &rp->freelist);
>   2117		}
>   2118		refcount_set(&rp->rph->ref, i);
>   2119	
>   2120		rp->nmissed = 0;
>   2121		/* Establish function entry probe point */
>   2122		ret = register_kprobe(&rp->kp);
>   2123		if (ret != 0)
>   2124			free_rp_inst(rp);
>   2125		return ret;
>   2126	}
>   2127	EXPORT_SYMBOL_GPL(register_kretprobe);
>   2128	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


-- 
Masami Hiramatsu <mhiramat@kernel.org>
