Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6FE597DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiHREw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiHREw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:52:26 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA4458A1FF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 21:52:25 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 54C70213B620; Wed, 17 Aug 2022 21:52:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54C70213B620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660798345;
        bh=19gsCUzsN5HOJUS1vhGJZKzrpOTtBM64G0vkIVanNwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7hGhdbCGwb3+Ao6l2vPGpUN3m7NEnIYTweIZnqRCnOUFpLAI8NcM56nZRDBGq1eh
         I9HnEaUju08Ccwa3Yxh1e2RytwycZxpkxIy74Vf388WfLvNymN3tZu8HCuEXciXQ3z
         N3vNqJUnFrRpTFEUY7xusrxY+Eo2a4GWkorwjfNU=
Date:   Wed, 17 Aug 2022 21:52:25 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     ssengar@microsoft.com, mikelley@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org, tim.c.chen@linux.intel.com,
        will@kernel.org, song.bao.hua@hisilicon.com,
        suravee.suthikulpanit@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cacheinfo: Don't use cpu_llc_shared_map for
 !CONFIG_SMP
Message-ID: <20220818045225.GA9054@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1660148115-302-1-git-send-email-ssengar@linux.microsoft.com>
 <Yv1ELaWHbRfvdt/p@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv1ELaWHbRfvdt/p@zn.tnic>
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

Thanks for review, please find my comments inline.

On Wed, Aug 17, 2022 at 09:40:29PM +0200, Borislav Petkov wrote:
> On Wed, Aug 10, 2022 at 09:15:15AM -0700, Saurabh Sengar wrote:
> > cpu_llc_shared_map is always declared and defined, but populated in
> > arch/x86/kernel/smpboot.c which only builds for CONFIG_SMP=y. For
> > UniProcessor builds this mask is never populated and hence invalid.
> > Current code doesn't handle the case of AMD UniProcessor correctly,
> 
> What is "AMD UniProcessor"?
Shall I mention here "Non-SMP AMD processor" instead ?

> 
> > which results "shared_cpu_map" and "shared_cpu_list" files missing from
> > sysfs entries for l3 cache. This patch fixes this issue.
> 
> What issue exactly?
> 
> What is the real life use case for this?

We observed that lscpu version 2.34 was causing segfault with latest kernel,
which motivate us to debug this issue. Root cause being shared_cpu_map file
missing. There could be more usecases where this file is getting queried for
L3 cache information but at the moment I am aware of only lscpu.
Do we need to add this info in commit.

> 
> > This code used to work because of a another bug in 'cpumask_next',
> > where in the CONFIG_SMP=n case the cpumask_next() ignores empty mask
> > that results as if CPU 0 was set. This bug in 'cpumask_next' was fixed by
> > following commit, which exposes the cpu_llc_shared_map bug.
> > 
> > b81dce77ced ("cpumask: Fix invalid uniprocessor mask assumption")
> > 
> > Fixes: 2b83809a5e ("x86/cpu/amd: Derive L3 shared_cpu_map from cpu_llc_shared_mask")
> 
> Add
> 
> ---
> [core]
>         abbrev = 12
> 
> [alias]
>         one = show -s --pretty='format:%h (\"%s\")'
> ---
> 
> to your git .config so that when you do
> 
> $ git one <commit id>
> 
> you can get the proper formatting and abbreviated sha1 for commits.
Thanks for suggestion, will fix this in V2.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
