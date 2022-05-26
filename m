Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7187F53517F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347966AbiEZPdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346462AbiEZPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45412C1ED8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A04CA61C64
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A44C385A9;
        Thu, 26 May 2022 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653579215;
        bh=FT4RzyNJhGH1Xvs0BNepk6mODPann7y9135LL7cckyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=saerT/+VGvOH8MzSXrAq+VXSokBG5Y3jxqeXe9/5kkx6DjMLknN7mMDFnuOEm/Ww6
         hXStapOVvQIhG2bEqWF51SUy1np+N5e0Lq1NrGB6fXl+0tpmQkAr7vemq6IGDdretc
         4e6+ov0k1fgwdGvWJtR2R3uKwaXjJ5o7xxK+m3DctnTnLcYlgtKeotrKxz3iwFwswd
         G9AZq66oBVufxqZylDP8cB//xx8KA09z0AznzixoVPJG+vsPcqV6aFtRTXuJijHjdd
         twd58GtstuCxSslhtCacTmuiBMf9AjEpfgtcPNFWhggahO1MI/MOsu947pI495kM1d
         H+kDD6z+aWDbw==
Date:   Fri, 27 May 2022 00:33:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>,
        <peterz@infradead.org>, <naveen.n.rao@linux.vnet.ibm.com>,
        <jszhang@kernel.org>, <guoren@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] riscv/kprobe: reclaim insn_slot on kprobe
 unregistration
Message-Id: <20220527003330.68f1fc0f58ecec812a7d037e@kernel.org>
In-Reply-To: <20220525014424.20717-1-liaochang1@huawei.com>
References: <20220525014424.20717-1-liaochang1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 09:44:24 +0800
Liao Chang <liaochang1@huawei.com> wrote:

> On kprobe registration kernel allocate one insn_slot for new kprobe,
> but it forget to reclaim the insn_slot on unregistration, leading to a
> potential leakage.
> 
> Reported-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>

Looks good to me.

Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
Cc: stable@vger.kernel.org
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,


> ---
> v2:
>   Add Reported-by tag
> 
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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
