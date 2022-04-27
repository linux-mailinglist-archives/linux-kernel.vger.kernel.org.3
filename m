Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E16511990
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiD0Ong (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbiD0Ond (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:43:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE533E8F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:40:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651070420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Bh8KuA/AAWOlDEUP/mUP1gM/q09Kmr3g1RCvu7cQIA=;
        b=F2bDEcJwCXciAlGCONIdOp8h76Zke4rhFmOCALvDr61Pje9+iX+kSae0g/0KZZEyWE4Lhw
        uu2YbfZ736RWAxpDMHT4rDXjhoymF68y70ALtVFpXDnDIj8LcQvHyIsjuVV6DFBV2D7Nd/
        9SZoe7dRZUVqo00THOHkboeJ/l0GDegoXpsIyxoJBo7EuGxyUngHXeVQSIn0XJCdyJb4n5
        w+e2896jnBEf5Q3xE6sPCQM8c8iIDH35AQqZ3MhBmG9kNecefUnM53Tk4fWZsFYBtVuEGx
        /ZzrKuznkpH7cPQuu23Nm4RtOLEs33aWA8QMQvn3MAlIiLyxkUA46/kxQWYZYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651070420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Bh8KuA/AAWOlDEUP/mUP1gM/q09Kmr3g1RCvu7cQIA=;
        b=OjMdNYOWGBflZsRQ25IzRNzYQtvuvcM5Q5QldqV9k/keM+3YEoPJ0ButUG4+nckzt3+Nfx
        vz4ZqhEaLaHTp7Cw==
To:     Aaron Tomlin <atomlin@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@gentwo.de>, frederic@kernel.org,
        mingo@kernel.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
In-Reply-To: <20220427115020.kyaxc5j67lq5zrfq@ava.usersys.com>
References: <20220422193647.3808657-1-atomlin@redhat.com>
 <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de>
 <20220425113909.u3smtztp66svlw4o@ava.usersys.com>
 <alpine.DEB.2.22.394.2204251406370.13839@gentwo.de>
 <20220425132700.GK2731@worktop.programming.kicks-ass.net>
 <20220425141717.vw2jfnn3zp6c5ib2@ava.usersys.com>
 <Ymb018EaVlOUfx87@fuller.cnet>
 <20220427115020.kyaxc5j67lq5zrfq@ava.usersys.com>
Date:   Wed, 27 Apr 2022 16:40:19 +0200
Message-ID: <875ymuy4h8.ffs@tglx>
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

On Wed, Apr 27 2022 at 12:50, Aaron Tomlin wrote:
> On Mon 2022-04-25 16:21 -0300, Marcelo Tosatti wrote:
>> Is there anything that prevents a nohz full CPU from running an
>> application with short and frequent idling?
>
> I'm not sure I understand the question; albeit, if I understand correctly,
> yes: the scheduling-clock tick, if it was stopped.
> Yet I believe this behaviour is correct. Consider the following example:
>
>   When a CFS task is moved/or migrated to a nohz_full CPU that was
>   previously idle and had its tick stopped, if its the only task on the
>   run-queue then it is possible that the idle task may not restart the
>   tick (see __tick_nohz_full_update_tick()).  Thus once the CFS task exits
>   manual intervention i.e. a reschedule IPI to wake the idle task, would be
>   required to run again, on the same CPU.

When the task exits and the tick was stopped, why should idle restart
the tick? There is nothing to do, so what?

Thanks,

        tglx

