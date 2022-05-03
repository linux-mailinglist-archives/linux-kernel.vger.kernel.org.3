Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F101517F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiECHlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiECHlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:41:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9302CCA4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:38:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651563482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sM1sh48qqqqNeZqSw1JKDfgm3vgNzqP52k4toCR21aY=;
        b=kWu1KPiybkLj18Tfkypw8dueA/yObmYYIiP6sePLG/ZnCSqDfSriCHGK0CqDCSeFuBjgwd
        HHIPB/w0qH6mk7SLHQMK9AWev7vCyTQvJp5Zwdor0CRpbXbEH9xcyPiwFNjtyFrgYIzdrU
        CpGVAaGgCUHGkzKqC+0XKRW2snZQA2aEcQediFaUsD19AjhsaBr4PK0ahUdRy+am1XoSGD
        LRXNAx1t9NQbBLGfsY7dyxAn2qMRjO+Vkbf/fML7toCERZ/m6TUrqjQGEA0P2epyMm/63i
        DNByPw2KAnFHVe06j5Zqy6BvGhJCZ0MzC02GrD98vc7KY1MIGt/sXIgiic83og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651563482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sM1sh48qqqqNeZqSw1JKDfgm3vgNzqP52k4toCR21aY=;
        b=VXGZ/V1xK1lI8LFeOqZFwMi+o4aQXfs5FbMnA3mDv34LarcY7zOKtr5GDSBSdGEie7fCp/
        qNhNcA5X6yhv0tCg==
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Pfaff <tpfaff@pcs.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3] irq/core: synchronize irq_thread startup
In-Reply-To: <20220503004209.4670-1-hdanton@sina.com>
References: <552fe7b4-9224-b183-bb87-a8f36d335690@pcs.com>
 <20220502160106.4587-1-hdanton@sina.com>
 <20220503004209.4670-1-hdanton@sina.com>
Date:   Tue, 03 May 2022 09:38:01 +0200
Message-ID: <87pmkvkqw6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf,

On Tue, May 03 2022 at 08:42, Hillf Danton wrote:
> On Mon, 02 May 2022 21:24:45 +0200 Thomas Gleixner  wrote:
>> On Tue, May 03 2022 at 00:01, Hillf Danton wrote:
>> > +	if (!waked)
>> > +		wake_threads_waitq(desc);
>> 
>> That's a guarantee to make desc->threads_active go negative in the case
>> that the thread was never woken by a hard interrupt handler. IOW, you
>> created a new problem which did not exist before.
>
> The count of active threads would not drop below zero with the change,
> given the comment in __irq_wake_thread(). It is incremented before
> wakeup.

There is no guarantee that the wake-up happens via __irq_wake_thread().
kthread_stop() does a wake-up too, but that obviously _cannot_ increment
the active counter because it does not know about it at all.

   create_thread()
      thread_fn()
        woken = false;
        wait_for_wakeup_or_stop()       <- Stop is set, no interrupt happened
                                        <- ergo woken == false   
        if (!woken)
      	  wake_threads_waitq(desc)
            atomic_dec_and_test(..)   <- underflow

>> The problem discussed here is not a problem in irq_thread(), it's a
>> problem of not reaching this function in the first place. See the on
>> point analysis in Thomas Pfaffs patch.
>
> Well why is the count above zero without wakeup? IOW why is there imbalance
> in count if the irq thread never gets a CPU to run?

Look at kthread() and the condition under which threadfn() is invoked.

Thanks,

        tglx
