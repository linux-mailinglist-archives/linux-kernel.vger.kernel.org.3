Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D09464E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245718AbhLANDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349377AbhLAND3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:03:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28857C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 05:00:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E445BB81EB3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 13:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969DDC53FCC;
        Wed,  1 Dec 2021 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638363606;
        bh=aaw5+wq2RIjEpxL1j8LdgMeD+ZXEduU1dqp2Ltibf6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hfgXxpBi18szCpqCb0Mu2Q07Lzc9kinvWV0UDBIb38ZeFO3pVBT+X0HlAfLrNkhRS
         s38j0yZK4qkODEUyOIVBFeTXtQz+Q0wPdR1MOGtbz0RQEY4DiY+WZu2hloy6F7aIBE
         kxz1EsRFsvXDjNCFw5Mq/zzo1Sr4XQ8E0LBYcJi/vyM98bXbFE7T03ivevQHbS5Wd/
         2C3+bn5L2UVV9nPAE8IjvIFjDlpIahu06Utn1jOJPzOEKP6HdIAlynAFYCH7nycg8x
         u+ihLBWSkOMSrbeUuEDMkOb2ubj6FsCI44MxgMntQ7TwpfFD7bG/c9ZDt/IDAVx4h9
         H0TOZZIIGM2/Q==
Date:   Wed, 1 Dec 2021 22:00:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     zhangyue <zhangyue1@kylinos.cn>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: fix out-of-bounds in register_kretprobe
Message-Id: <20211201220003.9908c995fb6605436de589c5@kernel.org>
In-Reply-To: <20211201054855.5449-1-zhangyue1@kylinos.cn>
References: <20211201054855.5449-1-zhangyue1@kylinos.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Dec 2021 13:48:55 +0800
zhangyue <zhangyue1@kylinos.cn> wrote:

> When the data 'rp->data_size' is negative, the code
> 'sizeof(struct kretprobe_instance)+rp->data_size'
> is less than 'sizeof(struct kretprobe_instance)'
> 
> At this time, the pointer 'inst' may be out of
> bound when it is in use.

Good catch! but in that case register_kretprobe() should return -EINVAL
since there is no reason to allow minus data_size. (Thus, it must be
unsigned int, and limit with some maximum size.)

Let me fix that.

Thank you,

> 
> Signed-off-by: zhangyue <zhangyue1@kylinos.cn>
> ---
>  kernel/kprobes.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 1cf8bca1ea86..71cf6bde299f 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1983,7 +1983,7 @@ int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long o
>  int register_kretprobe(struct kretprobe *rp)
>  {
>  	int ret;
> -	struct kretprobe_instance *inst;
> +	struct kretprobe_instance *inst = NULL;
>  	int i;
>  	void *addr;
>  
> @@ -2024,7 +2024,8 @@ int register_kretprobe(struct kretprobe *rp)
>  
>  	rp->rph->rp = rp;
>  	for (i = 0; i < rp->maxactive; i++) {
> -		inst = kzalloc(sizeof(struct kretprobe_instance) +
> +		if (rp->data_size >= 0)
> +			inst = kzalloc(sizeof(struct kretprobe_instance) +
>  			       rp->data_size, GFP_KERNEL);
>  		if (inst == NULL) {
>  			refcount_set(&rp->rph->ref, i);
> -- 
> 2.30.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
