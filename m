Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28A532D34
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbiEXPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbiEXPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480431AD99
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:21:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D838F61709
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E198C34115;
        Tue, 24 May 2022 15:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653405680;
        bh=wbKQ2m0zStxrwKVrhRcUOORtvQoLUD745FXYrf3v+NU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQaqWjmbvwgE/Olkgr9/EUuu7JXEZRDNPCDc0u6VgAvSy5+DGzFLL2zWWZFPNxDVe
         YIEVZ8jH9ZZBli2pZZJTCLfVsXb5vw+mlCuXHE3PX6qqrzM6A2Phlynuaryr1nS3nO
         t//i9rRGFPNJ1M/XLlDrrVP+2jM9vJqBHI9xVRBN3Vr3Y03x322QQFUvTHxa18TR49
         EPRQsF0s5mI14wedeKtXtSr8pd7DjIgn+Xa7E7+Uvm78lHYBJcfczMaEeP5hbXjnhM
         KJdb38SniAPvPyRoO9pNyHFm6BaqGjkr4sJmETdDNw/mS6KHAJ5A+B/VNHmipFdI/J
         zvpXsHA/jN7Dg==
Date:   Tue, 24 May 2022 23:12:41 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Liao Chang <liaochang1@huawei.com>, Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, naveen.n.rao@linux.vnet.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv/kprobe: reclaim insn_slot on kprobe unregistration
Message-ID: <Yoz16RUZvfyxmywT@xhacker>
References: <20220523015124.98743-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220523015124.98743-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 09:51:24AM +0800, Liao Chang wrote:
> On kprobe registration kernel allocate one insn_slot for new kprobe,
> but it forget to reclaim the insn_slot on unregistration, leading to a
> potential leakage.

+ Guo Ren

Nice catch! I think csky needs the fix as well.

> 
> This bug reported by Chen Guokai <chenguokai17@mails.ucas.ac.cn>.

This needs a "Reported-by: ..." tag

> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/riscv/kernel/probes/kprobes.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index e6e950b7cf32..f12eb1fbb52c 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -110,6 +110,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
>  
>  void __kprobes arch_remove_kprobe(struct kprobe *p)
>  {
> +	if (p->ainsn.api.insn) {
> +		free_insn_slot(p->ainsn.api.insn, 0);
> +		p->ainsn.api.insn = NULL;
> +	}
>  }
>  
>  static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
