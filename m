Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5816D53634A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351697AbiE0NWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiE0NWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C6E43B54D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653657765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XQbqWL32WgNp+vr6+IdXD3tIFXkuGIZQKgAX0wF6o5I=;
        b=gcvQQEvCBfc2kCXZjD6QzbN9Z+P5PK7yGBePhAEZkGPkIq6uoqG8O8RuLwyp3FQl1uvE72
        t8kYAGp82JdcTIEMOxJ/vDfleeY1F9SfKesa7RB/Ys6A80vaR6DA8LEpN/bhzoR26sr7bn
        dZcbhVkW2nsz3NTRTeGT1FkW5Nuagsk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-DwDo9MTHMZKK_lUYFY3QQg-1; Fri, 27 May 2022 09:22:40 -0400
X-MC-Unique: DwDo9MTHMZKK_lUYFY3QQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5A343C14103;
        Fri, 27 May 2022 13:22:39 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 93DC31121315;
        Fri, 27 May 2022 13:22:39 +0000 (UTC)
Date:   Fri, 27 May 2022 09:22:38 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] cpuhp: make target_store() a nop when target ==
 state
Message-ID: <20220527132156.GB26124@pauld.bos.csb>
References: <20220526160615.7976-1-pauld@redhat.com>
 <20220526160615.7976-2-pauld@redhat.com>
 <xhsmhy1ynl3hr.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhy1ynl3hr.mognet@vschneid.remote.csb>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 10:38:24AM +0100 Valentin Schneider wrote:
> On 26/05/22 12:06, Phil Auld wrote:
> > writing the current state back in hotplug/target calls cpu_down()
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
> > Fix this by letting state==target fall through in the target_store()
> > conditional.
> >
> 
> To go back on my data race paranoia: writes to both cpu$x/online and
> cpu$x/hotplug/target are serialized by device_hotplug_lock, and so are the
> exported kernel hotplug functions ({add, remove}_cpu()).
> 
> That's not cpu_add_remove_lock as I was looking for, but that's still all
> under one lock, so I think we're good. Sorry for that!
> 

Right. This catches it up higher so that we don't get into the code that
starts actually changing things.  I wonder now in the state == target case
if we should make sure st->target == target.  With the second patch it's 
less likely to be needed. Thoughts?

Maybe I'll include that if/when I have code to keep cpux/online in sync
with st->state and cpu_online_mask.

> > Signed-off-by: Phil Auld <pauld@redhat.com>
> 
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Thanks!


Cheers,
Phil


> 
> > ---
> >  kernel/cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index d0a9aa0b42e8..cdb6ac10ad94 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -2315,7 +2315,7 @@ static ssize_t target_store(struct device *dev, struct device_attribute *attr,
> >  
> >  	if (st->state < target)
> >  		ret = cpu_up(dev->id, target);
> > -	else
> > +	else if (st->state > target)
> >  		ret = cpu_down(dev->id, target);
> >  out:
> >  	unlock_device_hotplug();
> > -- 
> > 2.18.0
> 

-- 

