Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8D954BEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiFOAPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiFOAPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:15:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71C165B7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03832B81A43
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0260C3411B;
        Wed, 15 Jun 2022 00:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655252105;
        bh=LfCiE7qgiZADY1Mde+IjGpeUSu96x0YdUumS3KY1hQw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C34/RFCJRcF4KQ9bOmfnYRxEqyUNjHmEHbL3ravUCL8NBWnpXHtSvH/XpWPLfoiCJ
         E9ScC2nS9Q9DRN0+/Il7BZa7pbvlseRpcl7FVVBqsTtiqh9P+F36/I8FbOe7IqWr0q
         S8t4IUx+IGrh8kdGVcZmuMzI4FzkhHesA/ROQnJDR4jt4F7u1qxlSxxku9P7SOCeat
         Fl9Mj2SFS8xDrxeY22/7clBg4sPJRbUndFyuHgtMT4yjOgS2GJbl09jTNMIsGSISr5
         nQp6mBZMxl7MpY+IIVFyrApjG9mL1lHqzuAAUseNgPYY+obvqsrHaoqy8ctPtH6Rg9
         JkNeM2+XnqFSw==
Date:   Wed, 15 Jun 2022 09:15:01 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     l3b2w1@gmail.com
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kprobes: drop the unnecessary unlikely()
Message-Id: <20220615091501.0323c2c7cc89b2d337cb0322@kernel.org>
In-Reply-To: <20220613042536.20329-1-l3b2w1@gmail.com>
References: <20220613042536.20329-1-l3b2w1@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 12:25:36 +0800
l3b2w1@gmail.com wrote:

> From: "binglei.wang" <l3b2w1@gmail.com>
> 
> !ap is likely when checking re-registering existing kprobe.
> 	register_kprobe -> warn_kprobe_rereg -> __get_valid_kprobe
> 
> !ap is unlikely when checking whether the kprobe is valid
> on enable/disable ocassion.
> 	__disable_kprobe/enable_kprobe -> __get_valid_kprobe
> 
> Considering these two cases, choose to drop the unlikely() here.
> 
> Signed-off-by: binglei.wang <l3b2w1@gmail.com>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/kprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f214f8c08..f4a829d98 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1504,7 +1504,7 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
>  	lockdep_assert_held(&kprobe_mutex);
>  
>  	ap = get_kprobe(p->addr);
> -	if (unlikely(!ap))
> +	if (!ap)
>  		return NULL;
>  
>  	if (p != ap) {
> -- 
> 2.27.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
