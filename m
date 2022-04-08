Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56174F8F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiDHHR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiDHHRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:17:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA2E21749D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:15:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 97DFF1F861;
        Fri,  8 Apr 2022 07:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649402115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rx92wkjSz2UMxpAC/s3Qf3G07LKMpAhWUOPb7IxbfxE=;
        b=sgoo/tkmEGtjdOw29m3gYXRlFaRWSv2KheW+5rlQ9DicrG4IGLawTFFuv6ajTINSF1SXt6
        jJDZrLOT5zQ8YXf0gGzeHihOkzfRQbpj3HAWWQZdA0tiIi50U190Sem3b47dMtUPE6/SU3
        zKjw4VaJKSq4UJleQ+PUY154Co+d4ck=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 362F6A3B82;
        Fri,  8 Apr 2022 07:15:15 +0000 (UTC)
Date:   Fri, 8 Apr 2022 09:15:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunlei.wang@mediatek.com, john.ogness@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, kernel-team@android.com
Subject: Re: [PATCH v2] printk: ringbuffer: Improve prb_next_seq() performance
Message-ID: <Yk/hAubbZeV43ejA@alley>
References: <YXlddJxLh77DKfIO@alley>
 <20220408004821.4010969-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408004821.4010969-1-saravanak@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-04-07 17:48:21, Saravana Kannan wrote:
> 
> > Petr Mladek <pmladek@suse.com> wrote:
> > 
> > prb_next_seq() always iterates from the first known sequence number.
> > In the worst case, it might loop 8k times for 256kB buffer,
> > 15k times for 512kB buffer, and 64k times for 2MB buffer.
> > 
> > It was reported that pooling and reading using syslog interface
> > might occupy 50% of CPU.
> > 
> > Speedup the search by storing @id of the last finalized descriptor.
> > 
> > The loop is still needed because the @id is stored and read in the best
> > effort way. An atomic variable is used to keep the @id consistent.
> > But the stores and reads are not serialized against each other.
> > The descriptor could get reused in the meantime. The related sequence
> > number will be used only when it is still valid.
> > 
> > An invalid value should be read _only_ when there is a flood of messages
> > and the ringbuffer is rapidly reused. The performance is the least
> > problem in this case.
> > 
> > --- a/kernel/printk/printk_ringbuffer.h
> > +++ b/kernel/printk/printk_ringbuffer.h
> > @@ -75,6 +75,7 @@ struct prb_desc_ring {
> >  	struct printk_info	*infos;
> >  	atomic_long_t		head_id;
> >  	atomic_long_t		tail_id;
> > +	atomic_long_t		last_finalized_id;
> >  };
> 
> 
> I really know nothing about this code, but while looking around
> kernel/printk/ I noticed kernel/printk/printk.c has these lines in
> log_buf_vmcoreinfo_setup().
> 
> 	VMCOREINFO_STRUCT_SIZE(prb_desc_ring);
> 	VMCOREINFO_OFFSET(prb_desc_ring, count_bits);
> 	VMCOREINFO_OFFSET(prb_desc_ring, descs);
> 	VMCOREINFO_OFFSET(prb_desc_ring, infos);
> 	VMCOREINFO_OFFSET(prb_desc_ring, head_id);
> 	VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
> 
> Would this header file change also require a change to that location?
> Something like
> 
> 	VMCOREINFO_OFFSET(prb_desc_ring, head_id);
> 	VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
> +	VMCOREINFO_OFFSET(prb_desc_ring, last_finalized_id);

It is actually not needed. VMCOREINFO_*() macros define some data
that are used by the "crash" tool when reading crashdumps. The field
"last_finalized_id" is used only at runtime. It is not needed
for reading the log in the crashdump.

Anyway, thanks for the question. It is great to know that there are
more people checking our changes.

Best Regards,
Petr
