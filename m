Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DF953AA7A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355858AbiFAPtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355859AbiFAPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 301C1A5013
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654098583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7F+sRYtqzAK7Qkdkt1STsL6rqDcnBDbLPwNMgaDX6KA=;
        b=KqvNcoUnTWi/JrgOvk0EWw14d3T/S5TVjsY7rVtTcF07CEWaR60BzE1EqlZ39h1BVR7Oud
        O38qHsEQye1S/IqKNXZktPyvHbs7a++jluoqCHQsUSi8VagAvH3z/A0dIN/JVX7b09t4ap
        bwS25xK+yQR21QI5m3zSorXWmepb2HQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-W91-SlZbPDiEhWenD0nv2w-1; Wed, 01 Jun 2022 11:49:39 -0400
X-MC-Unique: W91-SlZbPDiEhWenD0nv2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 963EF2A59546;
        Wed,  1 Jun 2022 15:49:39 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.19.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4145A40885A2;
        Wed,  1 Jun 2022 15:49:39 +0000 (UTC)
Date:   Wed, 1 Jun 2022 11:49:37 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] cpuhp: make target_store() a nop when target ==
 state
Message-ID: <YpeKkVVp+/JWuxUi@lorien.usersys.redhat.com>
References: <20220526160615.7976-1-pauld@redhat.com>
 <20220526160615.7976-2-pauld@redhat.com>
 <xhsmhy1ynl3hr.mognet@vschneid.remote.csb>
 <20220527132156.GB26124@pauld.bos.csb>
 <xhsmho7zf8auj.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmho7zf8auj.mognet@vschneid.remote.csb>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 01:27:00PM +0100 Valentin Schneider wrote:
> On 27/05/22 09:22, Phil Auld wrote:
> > On Fri, May 27, 2022 at 10:38:24AM +0100 Valentin Schneider wrote:
> >> On 26/05/22 12:06, Phil Auld wrote:
> >> > writing the current state back in hotplug/target calls cpu_down()
> >> > which will set cpu dying even when it isn't and then nothing will
> >> > ever clear it. A stress test that reads values and writes them back
> >> > for all cpu device files in sysfs will trigger the BUG() in
> >> > select_fallback_rq once all cpus are marked as dying.
> >> >
> >> > kernel/cpu.c::target_store()
> >> >    ...
> >> >         if (st->state < target)
> >> >                 ret = cpu_up(dev->id, target);
> >> >         else
> >> >                 ret = cpu_down(dev->id, target);
> >> >
> >> > cpu_down() -> cpu_set_state()
> >> >     bool bringup = st->state < target;
> >> >     ...
> >> >     if (cpu_dying(cpu) != !bringup)
> >> >            set_cpu_dying(cpu, !bringup);
> >> >
> >> > Fix this by letting state==target fall through in the target_store()
> >> > conditional.
> >> >
> >>
> >> To go back on my data race paranoia: writes to both cpu$x/online and
> >> cpu$x/hotplug/target are serialized by device_hotplug_lock, and so are the
> >> exported kernel hotplug functions ({add, remove}_cpu()).
> >>
> >> That's not cpu_add_remove_lock as I was looking for, but that's still all
> >> under one lock, so I think we're good. Sorry for that!
> >>
> >
> > Right. This catches it up higher so that we don't get into the code that
> > starts actually changing things.  I wonder now in the state == target case
> > if we should make sure st->target == target.  With the second patch it's
> > less likely to be needed. Thoughts?
> >
> 
> Yeah, you could append a simple:
> 
>         else
>                 WARN_ON(st->state != target);

I was thinking more like:

      	 else 
                   if (st->target != target) st->target = target;

Since this is a write to the target field and we are not
doing one of the operations that will set target because 
state == target we should make sure target == target. Although
that could have its own issues, I suppose. But as I said
fixing the boot cpu should make it much less likely that
st->target != st->state once we have the hotplug lock. 
 
I don't see how that WARN would ever fire. We're under the lock
and nothing is re-reading the value of st->state anyway. Looks more
like a compiler sanity check :)


Cheers,
Phil


> > Maybe I'll include that if/when I have code to keep cpux/online in sync
> > with st->state and cpu_online_mask.
> 

-- 

