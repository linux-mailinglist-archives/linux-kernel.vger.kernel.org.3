Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF2D49C166
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiAZCmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiAZCmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:42:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0709C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:42:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 664FAB81AC2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB08C340E0;
        Wed, 26 Jan 2022 02:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643164962;
        bh=JNu7pKG4HdcWAKhUT1kxGWqtZANPoNwk2C6iqN5mVpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dIXQQ8+9/JDcEcoFsG9vkFCJxkFClsc+tRt/vibd0b4pPmXX2aD42UObBDA7wXNvZ
         bOAIH1Yg0MSSc3vjgXAW8mYVD8phVBzxVAeZvMDryps2TLhGD4tFGhKrVAgVbEh/qx
         wUY30XKonJEtxqF6AjAMgIqfWTCbfKjscpMh3WrA=
Date:   Tue, 25 Jan 2022 18:42:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dongyang Wang <dongyang.wang@windriver.com>
Cc:     <christian.brauner@ubuntu.com>, <ebiederm@xmission.com>,
        <legion@kernel.org>, <varad.gautam@suse.com>,
        <linux-kernel@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] To fix the below failure of handling page fault caused
 by the invalid input from user.
Message-Id: <20220125184239.4d97c00569b3051e714c56d3@linux-foundation.org>
In-Reply-To: <20220118091952.37001-1-dongyang.wang@windriver.com>
References: <20220118091952.37001-1-dongyang.wang@windriver.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 17:19:52 +0800 Dongyang Wang <dongyang.wang@windriver.com> wrote:

> [786058.308965] Unable to handle kernel paging request at virtual address 01000004
> [786058.316286] pgd = 38a99693
> [786058.319080] [01000004] *pgd=07800003, *pmd=00000000
> [786058.324056] Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> [786058.324100] CPU:  PID: Comm:  Tainted: G         C
> [786058.324102] Hardware name:
> [786058.324114] PC is at __copy_to_user_std+0x4c/0x3c4
> [786058.324120] LR is at store_msg+0xc0/0xe8
> [786058.324124] pc : [<c0c0587c>]    lr : [<c0871d04>]    psr: 20010013
> [786058.324126] sp : c3503ec4  ip : 00000000  fp : b4c9a660
> [786058.324129] r10: c4228dc0  r9 : c3502000  r8 : 00000ffc
> [786058.324132] r7 : 01000000  r6 : 546d3f8b  r5 : b4911690  r4 : 00000ffc
> [786058.324134] r3 : 00000000  r2 : 00000f7c  r1 : 01000004  r0 : b4911690
> [786058.324139] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [786058.324142] Control: 30c5387d  Table: 0edc2040  DAC: 55555555
> [786058.324145] Process  (pid: , stack limit = 0x25018bdf)
> [786058.324148] Stack: (0xc3503ec4 to 0xc3504000)
> [786058.324153] 3ec0:          b4911690 546d3f8b 01000000 00000ffc b4911690 00000ffc 00000000
> [786058.324157] 3ee0: 00000ffc c0871d04 546d4f73 c3407801 c3503f28 c3407800 00000000 b49106a8
> [786058.324161] 3f00: c4228dc0 c087abd4 00000002 b49106a8 617b9d03 00000000 00000000 c121d508
> [786058.324165] 3f20: 00000000 bf06a1a8 d1b634cc 16b26e77 c5af5280 00000100 00000200 db806540
> [786058.324170] 3f40: 00000001 c121d508 00000008 0000005c 00000000 00010008 b49106a8 c0601208
> [786058.324173] 3f60: c3502000 00000040 b4c9a660 c087b474 c3503f78 c121d508 617b9d03 00000000
> [786058.324177] 3f80: 2303d6cc 00000115 c0601208 c121d508 b4c9a660 b4c9a660 00000001 b49106a8
> [786058.324181] 3fa0: 00000115 c06011dc b4c9a660 00000001 0000005c b49106a8 00010008 00000000
> [786058.324185] 3fc0: b4c9a660 00000001 b49106a8 00000115 00000000 b4c9b400 00000000 b4c9a660
> [786058.324189] 3fe0: 00000115 b4c9a650 b6b253bd b6b254b6 800d0030 0000005c 00000000 00000000
> [786058.324201] [<c0c0587c>] (__copy_to_user_std) from [<c0871d04>] (store_msg+0xc0/0xe8)
> [786058.324211] [<c0871d04>] (store_msg) from [<c087abd4>] (do_mq_timedreceive+0x29c/0x484)
> [786058.324218] [<c087abd4>] (do_mq_timedreceive) from [<c087b474>] (sys_mq_timedreceive+0x88/0xbc)
> [786058.324226] [<c087b474>] (sys_mq_timedreceive) from [<c06011dc>] (__sys_trace_return+0x0/0x10)
> [786058.324229] Exception stack(0xc3503fa8 to 0xc3503ff0)
> [786058.324233] 3fa0:                   b4c9a660 00000001 0000005c b49106a8 00010008 00000000
> [786058.324236] 3fc0: b4c9a660 00000001 b49106a8 00000115 00000000 b4c9b400 00000000 b4c9a660
> [786058.324239] 3fe0: 00000115 b4c9a650 b6b253bd b6b254b6
> [786058.324247] Code: ba000002 f5d1f03c f5d1f05c f5d1f07c (e8b151f8)
> [786058.601808] ---[ end trace 0000000000000002 ]---
> 
> ...
>

Please describe the circumstances under which this occurs.

Please also describe how your proposed patch fixes this.

> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -1211,6 +1211,12 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>  		goto out_fput;
>  	}
>  
> +	/* checks if buffer is invalid */
> +	if ((unsigned long) u_msg_ptr < PAGE_SIZE) {
> +		ret = -EINVAL;
> +		goto out_fput;
> +	}
> +
>  	/*
>  	 * msg_insert really wants us to have a valid, spare node struct so
>  	 * it doesn't have to kmalloc a GFP_ATOMIC allocation, but it will
> @@ -1262,6 +1268,10 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>  			store_msg(u_msg_ptr, msg_ptr, msg_ptr->m_ts)) {
>  			ret = -EFAULT;
>  		}
> +
> +		if (msg_len < ret)
> +			ret = -EMSGSIZE;
> +
>  		free_msg(msg_ptr);
>  	}
>  out_fput:
> -- 
> 2.26.1
