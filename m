Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387AF5331CE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbiEXThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiEXThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF14D5EBEE
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653421035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DpubzQBBkhnbnZFsTGP/aVX/4nL+Rlw3c4n1v94PkHU=;
        b=VPN4115UxN/8ZLOM51NplDY4x76qQBOCGRWXFSJM1KVpZqNpC23u+3NRr2OEpigIHyCvke
        mMKM+LQMyKMQcx1qsUUwrn9FNAVckps0Pq/yt7DEatUXEreCDV9IO4Yih9v2BhaSA3HLHF
        7KFTzsbT0iDAYUzDR+uP8BsxPqugUjo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-atUNXk-aPfK1jGGTnfffzg-1; Tue, 24 May 2022 15:37:13 -0400
X-MC-Unique: atUNXk-aPfK1jGGTnfffzg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55CAC85A5BC;
        Tue, 24 May 2022 19:37:13 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A47B2026D64;
        Tue, 24 May 2022 19:37:13 +0000 (UTC)
Date:   Tue, 24 May 2022 15:37:11 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuhp: make target_store() a nop when target == state
Message-ID: <Yo0z56Fqgj3gqYlG@lorien.usersys.redhat.com>
References: <20220523144728.32414-1-pauld@redhat.com>
 <xhsmh35gzj77s.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh35gzj77s.mognet@vschneid.remote.csb>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Tue, May 24, 2022 at 04:11:51PM +0100 Valentin Schneider wrote:
> On 23/05/22 10:47, Phil Auld wrote:
> > writing the current state back into hotplug/target calls cpu_down()
> > which will set cpu dying even when it isn't and then nothing will
> > ever clear it. A stress test that reads values and writes them back
> > for all cpu device files in sysfs will trigger the BUG() in
> > select_fallback_rq once all cpus are marked as dying.
> >
> > kernel/cpu.c::target_store()
> > 	...
> >         if (st->state < target)
> >                 ret = cpu_up(dev->id, target);
> >         else
> >                 ret = cpu_down(dev->id, target);
> >
> > cpu_down() -> cpu_set_state()
> > 	 bool bringup = st->state < target;
> > 	 ...
> > 	 if (cpu_dying(cpu) != !bringup)
> > 		set_cpu_dying(cpu, !bringup);
> >
> > Make this safe by catching the case where target == state
> > and bailing early.
> >
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > ---
> >
> > Yeah, I know... don't do that. But it's still messy.
> >
> > !< != > 
> >
> >  kernel/cpu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index d0a9aa0b42e8..8a71b1149c60 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -2302,6 +2302,9 @@ static ssize_t target_store(struct device *dev, struct device_attribute *attr,
> >  		return -EINVAL;
> >  #endif
> >  
> > +	if (target == st->state)
> > +		return count;
> > +
> 
> The current checks are against static boundaries, this has to compare
> against st->state - AFAICT this could race with another hotplug operation
> to the same CPU, e.g.
> 
>   CPU42.cpuhp_state
>     ->state  == CPUHP_AP_SCHED_STARTING
>     ->target == CPUHP_ONLINE
> 
>   <write CPUHP_ONLINE via sysfs, OK because current state != CPUHP_ONLINE>
> 
>   CPU42.cpuhp_state == CPUHP_ONLINE
>   
>   <issues ensue>
> 
> 
> _cpu_up() has:
> 
> 	/*
> 	 * The caller of cpu_up() might have raced with another
> 	 * caller. Nothing to do.
> 	 */
> 	if (st->state >= target)
> 		goto out;
> 
> Looks like we want an equivalent in _cpu_down(), what do you think?
>

I did it like this (shown below) and from my test it also works for
this case.

I could move it below the lock and goto out;  instead if you think
that is better. It still seems better to me to stop this higher up
because there's work being done in the out path too.  We're not
actually doing any hot(un)plug so doing post unplug cleanup seems
iffy.

_cpu_down()
...
out:
        cpus_write_unlock();
        /*
         * Do post unplug cleanup. This is still protected against
         * concurrent CPU hotplug via cpu_add_remove_lock.
         */
        lockup_detector_cleanup();
        arch_smt_update();
        cpu_up_down_serialize_trainwrecks(tasks_frozen);
	return ret;
}

----------

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8a71b1149c60..e36788742d18 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1130,6 +1130,13 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	if (!cpu_present(cpu))
 		return -EINVAL;
 
+	/*
+	 * The caller of cpu_down() might have raced with another
+	 * caller. Nothing to do.
+	 */
+	if (st->state <= target)
+		return 0;
+
 	cpus_write_lock();
 
 	cpuhp_tasks_frozen = tasks_frozen;




Cheers,
Phil

-- 

