Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8926353CBF3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245309AbiFCPDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbiFCPDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:03:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6D464D8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B5ABB82345
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D53C385A9;
        Fri,  3 Jun 2022 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654268597;
        bh=KJA7norXveckb626KwhiBUG0LTnBlZk25DMASuaqYgQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fwK53WQoXp8iCJXzGTIv1dXnd+NmM+ofk7tapEFrgysbFrmI3F1601g6iKwkWBOj9
         +iGFHoSauxyf8vx4KHM0kxfT0cH9hyPqJVqm9uZONeBdjbt9zZcq1aUACEIV0g8KQg
         EobxoP4QaRHXzqbxCAZX6hjP7wmenTmKWFsSOmzz0/Wt7cQr3boqLvd9ofkoWyGzCe
         iQJp9UE9lDHSdDuoHDBStSvjnVEUyX0i5f7ZLE7cIOdtvy9rNR1ldahjpKipnuuWKP
         Ic3jRObOVGVAyKB25SUKNdq96vza3FZ7ypyjPKPlrKOyCzAdoByQSoTaAGfUkf/5qm
         zpIZCeutFlAyw==
Date:   Sat, 4 Jun 2022 00:03:12 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Chuang <nashuiliang@gmail.com>
Cc:     Jingren Zhou <zhoujingren@didiglobal.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Rollback kprobe flags on failed arm_kprobe
Message-Id: <20220604000312.69f42c92e932152da256c2bb@kernel.org>
In-Reply-To: <20220602073259.25669-1-nashuiliang@gmail.com>
References: <20220602073259.25669-1-nashuiliang@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuang,

On Thu,  2 Jun 2022 15:32:59 +0800
Chuang <nashuiliang@gmail.com> wrote:

> From: Chuang Wang <nashuiliang@gmail.com>
> 
> In aggrprobe scenes, if arm_kprobe() returns an error(e.g. livepatch and
> kprobe are using the same function X), kprobe flags, while has been
> modified to ~KPROBE_FLAG_DISABLED, is not rollled back.
> 
> Then, __disable_kprobe() will be failed in __unregister_kprobe_top(),
> the kprobe list will be not removed from aggrprobe, memory leaks or
> illegal pointers will be caused.
> 
> WARN disarm_kprobe:
>  Failed to disarm kprobe-ftrace at 00000000c729fdbc (-2)
>  RIP: 0010:disarm_kprobe+0xcc/0x110
>  Call Trace:
>   __disable_kprobe+0x78/0x90
>   __unregister_kprobe_top+0x13/0x1b0
>   ? _cond_resched+0x15/0x30
>   unregister_kprobes+0x32/0x80
>   unregister_kprobe+0x1a/0x20
> 
> Illegal Pointers:
>  BUG: unable to handle kernel paging request at 0000000000656369
>  RIP: 0010:__get_valid_kprobe+0x69/0x90
>  Call Trace:
>   register_kprobe+0x30/0x60
>   __register_trace_kprobe.part.7+0x8b/0xc0
>   create_local_trace_kprobe+0xd2/0x130
>   perf_kprobe_init+0x83/0xd0

Oops, thanks for reporting!
 
> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> Signed-off-by: Jingren Zhou <zhoujingren@didiglobal.com>

This should go to stable, so add below tag. (No need to CC to stable)

Fixes: 12310e343755 ("kprobes: Propagate error from arm_kprobe_ftrace()")
Cc: stable@vger.kernel.org

And could you also update this patch as below?

> ---
>  kernel/kprobes.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f214f8c088ed..96c75e23113c 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2422,8 +2422,10 @@ int enable_kprobe(struct kprobe *kp)
>  	if (!kprobes_all_disarmed && kprobe_disabled(p)) {
>  		p->flags &= ~KPROBE_FLAG_DISABLED;
>  		ret = arm_kprobe(p);
> -		if (ret)
> +		if (ret) {
>  			p->flags |= KPROBE_FLAG_DISABLED;

Here, can you add a check?

	if (p != kp) 

> +			kp->flags |= KPROBE_FLAG_DISABLED;

Thus is is clear that this is corresponding to
---
        if (p != kp)
                kp->flags &= ~KPROBE_FLAG_DISABLED;
---

Thank you,

> +		}
>  	}
>  out:
>  	mutex_unlock(&kprobe_mutex);
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
