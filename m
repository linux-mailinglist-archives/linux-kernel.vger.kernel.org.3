Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9FD4DB371
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350119AbiCPOkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbiCPOkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:40:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8EE26EC;
        Wed, 16 Mar 2022 07:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CAC00CE1FE0;
        Wed, 16 Mar 2022 14:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B930C340EC;
        Wed, 16 Mar 2022 14:38:55 +0000 (UTC)
Date:   Wed, 16 Mar 2022 14:38:51 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     guoren@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, Guo Ren <guoren@linux.alibaba.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Will Deacon <will@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2] arch: patch_text: Fixup last cpu should be master
Message-ID: <YjH2e4bfTl+0/+yc@arm.com>
References: <20220313012221.1755483-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313012221.1755483-1-guoren@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 09:22:21AM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> These patch_text implementations are using stop_machine_cpuslocked
> infrastructure with atomic cpu_count. The original idea: When the
> master CPU patch_text, the others should wait for it.

I couldn't find the original intent in the commit logs (at least not in
the arm64 logs). Maybe the intention was for the CPUs to wait for the
text patching to complete rather than the master CPU to wait for the
others to enter the cpu_relax() loop before patching.

I think your patch makes sense anyway, the master CPU would wait for all
the others to enter the cpu_relax() loop before patching and releasing
them with another increment. You probably wouldn't see any issues in
practice unless you insert probes in the multi_stop_cpu() function (or
we could mark this function as __kprobes and get rid of the extra loops
entirely).

> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -117,8 +117,8 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>  	int i, ret = 0;
>  	struct aarch64_insn_patch *pp = arg;
>  
> -	/* The first CPU becomes master */
> -	if (atomic_inc_return(&pp->cpu_count) == 1) {
> +	/* The last CPU becomes master */
> +	if (atomic_inc_return(&pp->cpu_count) == num_online_cpus()) {
>  		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
>  			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
>  							     pp->new_insns[i]);

For arm64:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
