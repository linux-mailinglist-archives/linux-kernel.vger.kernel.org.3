Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CD15110D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357968AbiD0GFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357964AbiD0GFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:05:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E51A4968F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:02:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a11so751899pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aXW2xhYPAvf1o0MLOP8hSxUxRqA0uZfff+kPH1xQuyk=;
        b=A9LnDAyKD6fVClrbsOpT+UhD6x0zNiOrPNfIyF+1WxKBC/+8bt3HtOdIM90ev/eL7H
         W7HWZlLtJfOEC8v+rAOYi4DTzrJ1OWmyE7/E4BKxbjktdxEAoEaGGfkvBBGsWIqDCzXS
         /HMKDxjfn7LKgwe+9xzwXPway6GD81+oaQuNwQDCCHZFTXrZGRaALTFmC1mX2F++YLBm
         abFERD1OsvujKTIldw2jdKqXPnPeMUeEJL6PNA+IDqAzvMr5q53GPvwzcOoLOO72GNLz
         vKp4jg4Djt9N9bDMLtv3cvoMeNfhwtRGKYIQwT9Cm2IWvz7quH+MzD9ygvMx00Ttgocz
         esUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aXW2xhYPAvf1o0MLOP8hSxUxRqA0uZfff+kPH1xQuyk=;
        b=S3po7uktub8IgNae3QHprBA2BB+Q8h1lKJ//cVmUQsb+fH3UJLlojej4AqWjNu/4tx
         AapyxDgh1vvwPGaeLYcs+OXjFaSm3IvdbX5xbTD+xEGHl4UabQ3SULM1canOkahJmi88
         iqm79v9E40fer3nLOjqP0z1bCURmymPoDByuQuHXdKWdhx3d6tfHNaVN4StQv1DmQ+er
         5TcyUw9YATi8Ql4+Kzvm/F2YlK2eXoKJrIthkT6fa0pI9haAYcZqC0+wgm1b1hTBztu2
         TmeqcmsE3kiiCfh93zDsCqnivOLcULCOb08JLV/tuIHQRtrJ3kBWtivRCjoScaS+oicc
         xr8g==
X-Gm-Message-State: AOAM532uFQzYPMlOgAGwzkdcMPLhKdCT+fH9CXIciLfPjR8TjV+TTn+K
        skEiFHGYwp0H59Hb8wTUjA==
X-Google-Smtp-Source: ABdhPJwRwqi+iqg0koL37oIguMoYA0cj6j+O8nZ7LpQfGexZ50vuGAFjX8HcRgIue0wo8jTsXtHvLQ==
X-Received: by 2002:a63:e245:0:b0:3a7:dce1:64b1 with SMTP id y5-20020a63e245000000b003a7dce164b1mr22781817pgj.67.1651039322602;
        Tue, 26 Apr 2022 23:02:02 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p2-20020a634202000000b003a0c6ec24d2sm14915417pga.89.2022.04.26.23.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:02:02 -0700 (PDT)
Date:   Wed, 27 Apr 2022 14:01:55 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Baokun Li <libaokun1@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 7/9] irq: remove needless lock in takedown_cpu()
Message-ID: <YmjcUxvct7aw82DH@piliu.users.ipa.redhat.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
 <20220420140521.45361-8-kernelfans@gmail.com>
 <87y1zys9f7.ffs@tglx>
 <YmYOAfz3Oh1bYiVi@piliu.users.ipa.redhat.com>
 <87czh533dk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czh533dk.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:43:03AM +0200, Thomas Gleixner wrote:
> On Mon, Apr 25 2022 at 10:57, Pingfan Liu wrote:
> > On Thu, Apr 21, 2022 at 06:11:56PM +0200, Thomas Gleixner wrote:
> >> > -	irq_lock_sparse();
> >> 
> >> Not everything is about RCU here. You really need to look at all moving
> >> parts:
> >> 
> >> irq_migrate_all_off_this_cpu() relies on the allocated_irqs bitmap and
> >> the sparse tree to be in consistent state, which is only guaranteed when
> >> the sparse lock is held.
> >> 
> >
> > For the irq which transfer from active to inactive(disappearing) after
> > fetching, desc->lock can serve the sync purpose. In this case,
> > irq_lock_sparse() is not needed. For a emergeing irq, I am not sure
> > about it.
> 
> No, it's required for the free case. The alloc case is
> uninteresting. Care to look into the code?
> 

Yes, it is a good exercise. Thanks for the enlightenment.

> irq_free_descs()
>    lock(sparse);
>    free_descs();
>    bitmap_clear(allocated_irqs, from, cnt);
>    unlock_sparse);
>  
> As free_descs() sets the sparse tree entry to NULL, up to the point
> where bitmap_clear() finishes the state is inconsistent.
> 
> Now look at irq_migrate_all_off_this_cpu() and figure out what happens
> when stop_machine() hits into the inconsistent state.
> 

So the following code should fix the inconsistence between bitmap and
sparse tree.
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b1739363..cd0d180f082d 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -161,6 +161,8 @@ void irq_migrate_all_off_this_cpu(void)
                bool affinity_broken;

                desc = irq_to_desc(irq);
+               if (!desc)
+                       continue;
                raw_spin_lock(&desc->lock);
                affinity_broken = migrate_one_irq(desc);
                raw_spin_unlock(&desc->lock);

> This can be fixed, but not by making mysterious claims about RCU and
> desc->lock.
> 

But I still think that desc->lock is critical to the consistence of the
irq _affinity_ if removing sparse lock in takedown_cpu().

For the free case, after applying the above patch, it should work.
void irq_migrate_all_off_this_cpu(void)
{
	for_each_active_irq(irq) {

		desc = irq_to_desc(irq);
		if (!desc)
			continue;
			                               ---> if breaking
						       in by free, then
						       migrate_one_irq()
						       will skip it
						       since the irq is
						       not activated any
						       long
		raw_spin_lock(&desc->lock);
		affinity_broken = migrate_one_irq(desc);
		raw_spin_unlock(&desc->lock);
		...
	}
}

But for the alloc case, it could be a problem.
void irq_migrate_all_off_this_cpu(void)
{
	for_each_active_irq(irq) {

		desc = irq_to_desc(irq);
		if (!desc)
			continue;
		raw_spin_lock(&desc->lock);
		affinity_broken = migrate_one_irq(desc);
		raw_spin_unlock(&desc->lock);
		...
                                                   ---> any new irq will
						   not be detected. But alloc_descs(start, cnt, node, affinity)
						   still associate the
						   irq with this cpu.
						   There is _no_
						   opportunity to clear
						   out this cpu from
						   desc->irq_common_data.affinity.

						   This is the affinity
						   inconsistent problem.
}


Thanks,

	Pingfan
