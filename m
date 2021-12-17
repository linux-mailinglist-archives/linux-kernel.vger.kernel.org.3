Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762F4479668
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhLQVly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhLQVlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:41:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB5DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:41:53 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639777312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5y3J7Tby5HG9Z/kf8KBxRk8HRJWB6fZTjqhP8qW1XRc=;
        b=qv1nFbWtD3wcXz+WwZGFMPNho0WMT3HErVwGIboa6lk7LppqUa3RsyJQH/zlsRWNOED/8S
        hvleQmWFpguB1TR06qzIMNVoFXRUTEhjX9N7sCZOm3aU5wsT3Sja0OI4+0HPLNae53Jjpy
        VDvnG0MqGzq/m7XNRPZnu7tI0yE/6/bTz+K6/eMBVVFRLlO15tu1KWTOi/oVUG3RmueXqb
        t3cOTFb00IMtU8LJ0PRo/hz2FcwBdQ8CUQC8VYW5k0gTkj4/j/vaB+i10oVOEWjk0CPuF9
        a3VsnVNbLUjRHRa2uUHGgsGSm6H9+XM72VgTDgehdm/f1qXeS9MLEASgpRI2BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639777312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5y3J7Tby5HG9Z/kf8KBxRk8HRJWB6fZTjqhP8qW1XRc=;
        b=UqGecZYbSLHe8HspSp1IPCaMoNzOKTzpHWnIrpauB695GQkePETm41Gfja/IzPAwrkQUx9
        XIwIE3YcssXTR/CA==
To:     Waiman Long <longman@redhat.com>, Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kasan-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] locking/mutex: Mark racy reads of owner->on_cpu
In-Reply-To: <2f67a2d9-98d6-eabd-fb5e-4c89574ce52c@redhat.com>
References: <20211202101238.33546-1-elver@google.com>
 <CANpmjNMvPepakONMjTO=FzzeEtvq_CLjPN6=zF35j10rVrJ9Fg@mail.gmail.com>
 <2f67a2d9-98d6-eabd-fb5e-4c89574ce52c@redhat.com>
Date:   Fri, 17 Dec 2021 22:41:51 +0100
Message-ID: <87ee6ac3j4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02 2021 at 10:46, Waiman Long wrote:
> On 12/2/21 06:53, Marco Elver wrote:
> I would like to see owner_on_cpu() extracted out from 
> kernel/locking/rwsem.c into include/linux/sched.h right after 
> vcpu_is_preempted(), for instance, and with READ_ONCE() added. Then it 
> can be used in mutex.c as well. This problem is common to both mutex and 
> rwsem.

And rtmutex.c
