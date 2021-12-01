Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E17464E76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349463AbhLANJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbhLANJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:09:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9A2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 05:06:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24980B81ED4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 13:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAA8C53FCD;
        Wed,  1 Dec 2021 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638363975;
        bh=S/SeL2BP7pfPep5JW0KX485zyZmOdZHTLxpgPAxrIMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tUgRuwVVlg3F6ujjVxyYXcOFGbkqXHMkS79DEOhnn0NFYLSEB1FlobnjtX29Ie4Oj
         gofIgRPHjGG/iqcpvXSgElH5rehk7rRnOuOr5dK/5ht/kYV3FaUAn5pmClxELV2UFO
         QG3LGpdpVnXY/aAvpBk8JzW6/nPrpmCg3yziiegpEzQ8kA4NkxFtwhTpJ1nRu1DMwJ
         gLnuF1RWfbm7/V3+/tgWfIi3HHykZUK2MslfH7krqs4FfgGITNVxws4rk6pWkIZS/7
         THXOsg3sHr7jQZYN/mpxs4z+9MUvIcdX2bv2c1UY9LEXhN4rs4PlGOrKO9ZfmMEns7
         ye2d4Y+HeCKQQ==
Date:   Wed, 1 Dec 2021 22:06:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     zhangyue <zhangyue1@kylinos.cn>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: fix out-of-bounds in register_kretprobe
Message-Id: <20211201220611.656ec911478bbf0f342ea7f1@kernel.org>
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

Hmm, rp->data_size is size_t, which is unsigned value.
Of course we still need some kind of maximum limitation
because if we pass enough bigger size, the 
sizeof(struct kretprobe_instance) + rp->data_size
can be negative or smaller than sizeof(struct kretprobe_instance).

Thank you,

> 
> At this time, the pointer 'inst' may be out of
> bound when it is in use.
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
