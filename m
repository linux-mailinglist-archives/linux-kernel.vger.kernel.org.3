Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40950DD08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiDYJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiDYJqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:46:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36983152C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:43:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650879784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myLhVjaqlxKQe4Fqq9j8cfDa5Oxkv3dnWKQC9Jk/N+c=;
        b=ZTbQ+0NZQud0+yRQ1kS+uSL0eNT9sV2h6iiivxtFbRir1OBpV1GKinn48AMUvB8t2HKu3V
        vKTd82NuzgBaYEHKdMyRoU1CwqBtTsgcEMECEJdgthE3yBJzMkw3636Dw0O8XFzg+1xD7+
        KkhIu3Vt4pu6Z7OmB7s6tuX3FwhD5NYYN+GTZ++C13ViM+0smTT0lRkir/KSWYwvVfftDE
        R+cHAs7pNnv71GCWf3mdn9dkNpCbXPkjJhObJvMKVdK2VllhDQAesaxIlzagfOm+wHxIUf
        F12MWeHyYMF2O0ExvzCohLyVkhgy0SSC4Tf6wR2xW0PElIAnDOG1Lb87Hew7wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650879784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myLhVjaqlxKQe4Fqq9j8cfDa5Oxkv3dnWKQC9Jk/N+c=;
        b=nh/H9H3x+gKOFrRA/rHvqXSR3iXnujeD0+m/9rPrIMi/qkEwgOuBMOG8cBr6TYlmDleXPy
        6fgkY7AC5QGmdfDg==
To:     Pingfan Liu <kernelfans@gmail.com>
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
In-Reply-To: <YmYOAfz3Oh1bYiVi@piliu.users.ipa.redhat.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
 <20220420140521.45361-8-kernelfans@gmail.com> <87y1zys9f7.ffs@tglx>
 <YmYOAfz3Oh1bYiVi@piliu.users.ipa.redhat.com>
Date:   Mon, 25 Apr 2022 11:43:03 +0200
Message-ID: <87czh533dk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2022 at 10:57, Pingfan Liu wrote:
> On Thu, Apr 21, 2022 at 06:11:56PM +0200, Thomas Gleixner wrote:
>> > -	irq_lock_sparse();
>> 
>> Not everything is about RCU here. You really need to look at all moving
>> parts:
>> 
>> irq_migrate_all_off_this_cpu() relies on the allocated_irqs bitmap and
>> the sparse tree to be in consistent state, which is only guaranteed when
>> the sparse lock is held.
>> 
>
> For the irq which transfer from active to inactive(disappearing) after
> fetching, desc->lock can serve the sync purpose. In this case,
> irq_lock_sparse() is not needed. For a emergeing irq, I am not sure
> about it.

No, it's required for the free case. The alloc case is
uninteresting. Care to look into the code?

irq_free_descs()
   lock(sparse);
   free_descs();
   bitmap_clear(allocated_irqs, from, cnt);
   unlock_sparse);
 
As free_descs() sets the sparse tree entry to NULL, up to the point
where bitmap_clear() finishes the state is inconsistent.

Now look at irq_migrate_all_off_this_cpu() and figure out what happens
when stop_machine() hits into the inconsistent state.

This can be fixed, but not by making mysterious claims about RCU and
desc->lock.

Thanks,

        tglx
