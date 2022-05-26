Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355E753516A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347465AbiEZPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEZPaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA13A88A8;
        Thu, 26 May 2022 08:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8660D61C60;
        Thu, 26 May 2022 15:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B831C385A9;
        Thu, 26 May 2022 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653579011;
        bh=tBqMjxQfiqyy++8lkfm5frnJ0t6bX2bWy4cnjC3WRKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lpzi0lR+TZcBjYGzFG2bLZAxTYjJPsJgKkXGMzictbTGhDgDZneeWcQzVbHENp4TH
         EZuOYaPHFnR9qVXrBfxHZg3CvJV6EmmWTt2KqOO4KZd/pJGAjtk6XNg3LAdmAJR+Dz
         iWGhOfv5iEIqS3+JFrSZKdkxkubUlYdIVRc1zwfhoYELU5r2czTM9dIQ5iWC8WISE5
         mS8GP8y3FWrVD7XLxIKF15ispI2+NFAMIKypYJFGCBbc5JkgWZUKWOVCTZ9iQOI4cs
         1UMRoc5CXCzl8vaFwp1N7W/LMLaIU5VDoC9d0SrXY0c6QQldBg2Byi/uzDiIHYFzvZ
         FwAJWURevjang==
Date:   Fri, 27 May 2022 00:30:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Guo Ren <guoren@kernel.org>, Liao Chang <liaochang1@huawei.com>
Cc:     <guoren@kernel.org>, <rostedt@goodmis.org>, <peterz@infradead.org>,
        <lkp@intel.com>, <naveen.n.rao@linux.vnet.ibm.com>,
        <jszhang@kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] csky/kprobe: reclaim insn_slot on kprobe unregistration
Message-Id: <20220527003006.76a52390841f7fba9680d636@kernel.org>
In-Reply-To: <20220525080241.117084-1-liaochang1@huawei.com>
References: <20220525080241.117084-1-liaochang1@huawei.com>
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

On Wed, 25 May 2022 16:02:41 +0800
Liao Chang <liaochang1@huawei.com> wrote:

> On kprobe registration kernel allocate one insn_slot for new kprobe,
> but it forget to reclaim the insn_slot on unregistration, leading to a
> potential leakage.
> 
> Reported-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>

This looks good to me too. I think this should go through csky tree.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,


> ---
>  arch/csky/kernel/probes/kprobes.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
> index 42920f25e73c..661da54b418f 100644
> --- a/arch/csky/kernel/probes/kprobes.c
> +++ b/arch/csky/kernel/probes/kprobes.c
> @@ -124,6 +124,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
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
