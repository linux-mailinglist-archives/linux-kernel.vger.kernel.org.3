Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8786A4E4A66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbiCWBSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiCWBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:17:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDCE5DE40;
        Tue, 22 Mar 2022 18:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 389A561359;
        Wed, 23 Mar 2022 01:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50787C340EC;
        Wed, 23 Mar 2022 01:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647998188;
        bh=mFKEtWHuxkNWJc8vLNfiNEHzB7uUaB2obyZl0VhLYU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NBBmuEhONx1+zNHHqhu8AUFqH0G32b4X5LKrDbAplue+3frWC1yzLqL4m1lvGt2g9
         cXXlL/gSMzrT9lT+B5FC2qkmFIxLLPwpCecwH+4FG7zGC4B0rUWJw4mawqoUTtTD4V
         7gv4JaZJBytFedX3HqyRF5/7Z1zIotrbCZc7ZGUyWWZPZbkMJ6PuOVNIM7SM2SLNdW
         xlce72TxzWWBHNKDJ4PpKBnGvjxRW6XUo+GmL1m+udW1gJgW/GuoHZfWZd3nWgzdOS
         Sujj9i/hW6fM8gsLZMHjh2nilq6BZkWTcwJhw8EF9phwiOsoPBvdj/+tqBNUhC5jxm
         x3A7uX0Yi6fBA==
Date:   Wed, 23 Mar 2022 10:16:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     guoren@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, Guo Ren <guoren@linux.alibaba.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2] arch: patch_text: Fixup last cpu should be master
Message-Id: <20220323101624.60a5d74d45b3215be343e04d@kernel.org>
In-Reply-To: <20220313012221.1755483-1-guoren@kernel.org>
References: <20220313012221.1755483-1-guoren@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022 09:22:21 +0800
guoren@kernel.org wrote:

> From: Guo Ren <guoren@linux.alibaba.com>
> 
> These patch_text implementations are using stop_machine_cpuslocked
> infrastructure with atomic cpu_count. The original idea: When the
> master CPU patch_text, the others should wait for it. But current
> implementation is using the first CPU as master, which couldn't
> guarantee the remaining CPUs are waiting. This patch changes the
> last CPU as the master to solve the potential risk.
> 

This looks good to me. And maybe we'd better backport to stable branch
this since this can cause self-modification in wrong timing.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Peter Zijlstra <peterz@infradead.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> 
> ---
> Changes in V2:
>  - Fixup last cpu should be num_online_cpus() by Max Filippov
>  - Fixup typos found by Max Filippov
> ---
>  arch/arm64/kernel/patching.c      | 4 ++--
>  arch/csky/kernel/probes/kprobes.c | 2 +-
>  arch/riscv/kernel/patch.c         | 2 +-
>  arch/xtensa/kernel/jump_label.c   | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index 771f543464e0..33e0fabc0b79 100644
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
> diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
> index 42920f25e73c..34ba684d5962 100644
> --- a/arch/csky/kernel/probes/kprobes.c
> +++ b/arch/csky/kernel/probes/kprobes.c
> @@ -30,7 +30,7 @@ static int __kprobes patch_text_cb(void *priv)
>  	struct csky_insn_patch *param = priv;
>  	unsigned int addr = (unsigned int)param->addr;
>  
> -	if (atomic_inc_return(&param->cpu_count) == 1) {
> +	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
>  		*(u16 *) addr = cpu_to_le16(param->opcode);
>  		dcache_wb_range(addr, addr + 2);
>  		atomic_inc(&param->cpu_count);
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 0b552873a577..765004b60513 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -104,7 +104,7 @@ static int patch_text_cb(void *data)
>  	struct patch_insn *patch = data;
>  	int ret = 0;
>  
> -	if (atomic_inc_return(&patch->cpu_count) == 1) {
> +	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
>  		ret =
>  		    patch_text_nosync(patch->addr, &patch->insn,
>  					    GET_INSN_LENGTH(patch->insn));
> diff --git a/arch/xtensa/kernel/jump_label.c b/arch/xtensa/kernel/jump_label.c
> index 61cf6497a646..b67efcd7e32c 100644
> --- a/arch/xtensa/kernel/jump_label.c
> +++ b/arch/xtensa/kernel/jump_label.c
> @@ -40,7 +40,7 @@ static int patch_text_stop_machine(void *data)
>  {
>  	struct patch *patch = data;
>  
> -	if (atomic_inc_return(&patch->cpu_count) == 1) {
> +	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
>  		local_patch_text(patch->addr, patch->data, patch->sz);
>  		atomic_inc(&patch->cpu_count);
>  	} else {
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
