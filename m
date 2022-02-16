Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173EF4B9315
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 22:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiBPVVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 16:21:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiBPVVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 16:21:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 742F1244D91
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 13:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645046467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzmlA9wGPTOGQ6ABHOLo+JGoedgg2opfplTiy2DMtgE=;
        b=QVswVlbMohKEi+mIYjV8/NwrgPMZ84rsDP3jtrlnf0pJ7CvKM3SASPMEhwGJ+KotPaMzVr
        cW2h9SLS9STMdmLKnonUBYLSGuZMGxmNjXfzO/ujDkarqRq/dqqe83Yn5csS9nkyrfl3qj
        apvwNDrl9ipblql2ry/CHm/EuMkl/K4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-gxKz_9w3PZSnUWgzo8tjRw-1; Wed, 16 Feb 2022 16:21:04 -0500
X-MC-Unique: gxKz_9w3PZSnUWgzo8tjRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBA631091DA2;
        Wed, 16 Feb 2022 21:21:02 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50BE36ABA2;
        Wed, 16 Feb 2022 21:20:43 +0000 (UTC)
Date:   Wed, 16 Feb 2022 16:20:41 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     frederic@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        mingo@redhat.com, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <Yg1qqbBlHwkInC8O@lorien.usersys.redhat.com>
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <YfxVpEO+UJTC+a9e@lorien.usersys.redhat.com>
 <20220216143412.dwxjlkq4w2zeweld@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216143412.dwxjlkq4w2zeweld@ava.usersys.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 02:34:12PM +0000 Aaron Tomlin wrote:
> On Thu 2022-02-03 17:22 -0500, Phil Auld wrote:
> > As I said earlier, I don't think you want to call quiet_vmstat()
> > unconditionally. And I don't think this will catch the cases you are
> > trying to fix. Once the tick is stopped tick_nohz_stop_tick should not be
> > getting called again until it's been restarted.
> 
> Phil,
> 
> Sorry about the delay. If I understand correctly, I see a scenario by which
> tick_nohz_stop_tick() can be called on transition/or exit from idle (e.g.
> default_idle_call()):

No worries. It's possible that I am misunderstanding the issue still... :)

> 
> 	1.	The idle/or scheduling-clock was previously
> 		stopped
> 
> 	2.	It is considered safe for the scheduling-clock
> 	        tick to remain "stopped"/or omitted; no need to
> 		reprogram and enable a periodic tick
> 		(e.g. no queued/or expired pending timer)
> 
> 	  ...
>             do_idle
> 	      cpuidle_idle_call
> 	      {
> 
> 		...
> 
> 	.--     default_idle_call
> 	|         arch_cpu_idle
> 	|         goto exit_idle
>         |
>         |       exit_idle:
> 	|         __current_set_polling()
>         |
> 	|     }
>         |     tick_nohz_idle_exit()
>         |     {
>         |
>         |       tick_stopped = ts->tick_stopped
>         |
>         |       if (tick_stopped)
>         |         tick_nohz_idle_update_tick(ts, now)
>         |           if (tick_nohz_full_cpu(smp_processor_id()))
>         |             __tick_nohz_full_update_tick(ts, now)
>         |             {
>         |               int cpu = smp_processor_id()
>         |
>         |               if (can_stop_full_tick(cpu, ts))
>         |                 tick_nohz_stop_sched_tick(ts, cpu)
>         |                   if (tick_nohz_next_event(ts, cpu))
>         '--                   tick_nohz_stop_tick(ts, cpu)
>                       }
>               }
> 
> If I understand correctly, __tick_nohz_full_update_tick() can return with
> no changes to the current tick (e.g. expire time == KTIME_MAX), no?
>

Yeah, I missed that path, so tick_nohz_stop_tick() can get called with the tick
already stopped.  My concern was about calling quiet_vmstat() if the tick was not
stopped as per the comment on that function. But looking more closely at
tick_nohz_stop_tick() it won't be doing that with your patch.

If this is fixing the issue you are seeing (I don't remember if you had a
reproducible case or not) then I think this could be a good way to do it.

It does seem to rely on a few things lining up right to get to the call to
tick_nohz_stop_tick(). 


Cheers,
Phil


> 
> Kind regards,
> 
> -- 
> Aaron Tomlin
> 

-- 

