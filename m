Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07401533DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbiEYNbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbiEYNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAB5B222B6
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653485500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZOpdQlKbPrLJuU2K3iMog3VmU/8jW7EFKc+wzhubG4=;
        b=QLV7BRNX0lF5xIN7MO1Yt2bTlVhpnBDBdy17QSJGEe07KzBv1//78k/OSHOzZrNpaPwOtr
        Z+kF+0EPAhk4juLvjBg4qI3hiT62yeC+L+RhKOb/ajoLNFVQIgzs/5XpXmsK79VQFtmbGy
        d78mJEWDNF4GKcUhVyTli9fOOAd38fU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-5rDqaaUqOkKjz5-TIv8bQA-1; Wed, 25 May 2022 09:31:35 -0400
X-MC-Unique: 5rDqaaUqOkKjz5-TIv8bQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47ADA802814;
        Wed, 25 May 2022 13:31:35 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23BE01121315;
        Wed, 25 May 2022 13:31:35 +0000 (UTC)
Date:   Wed, 25 May 2022 09:31:33 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuhp: make target_store() a nop when target == state
Message-ID: <20220525133133.GA5500@pauld.bos.csb>
References: <20220523144728.32414-1-pauld@redhat.com>
 <xhsmh35gzj77s.mognet@vschneid.remote.csb>
 <Yo0KRVpfhUb8Ta4N@lorien.usersys.redhat.com>
 <xhsmhy1yqhrio.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhy1yqhrio.mognet@vschneid.remote.csb>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 10:48:31AM +0100 Valentin Schneider wrote:
> On 24/05/22 12:39, Phil Auld wrote:

> >
> >> >         if (st->state < target)
> >> >                 ret = cpu_up(dev->id, target);
> >> >         else
> >> >                 ret = cpu_down(dev->id, target);
> >
> > is not correct. If we catch the == case earlier then this makes
> > sense as is.
> >
> > I suppose "if (st->state <= target)" would work too since __cpu_up()
> > already checks. Catching this sooner seems better to me though.
> >
> 
> Yeah it would be neater to not even enter cpu_{up, down}(), but my paranoia
> makes me think we need the comparison to happen with at least the
> cpu_add_remove_lock held to make sure st->state isn't moving under our
> feet, otherwise we may still end up with target == state in _cpu_down() and
> hit the bug you're describing.
> 

This is what I was originally doing before I tried to "optimize" it:

         if (st->state < target)
                 ret = cpu_up(dev->id, target);
         else if (st->state > target)
                 ret = cpu_down(dev->id, target);

This does the check under the lock and just falls through if state==target.
I think I'll go back to that version.

I also noticed while testing that the boot cpu does not get its target set.
It's got state 233 but target 0.  So reading that out and writing it back
on offlines cpu0.   I'll try to find where that is not getting set.  


Thanks,

Phil

> >>
> >> >    ret = lock_device_hotplug_sysfs();
> >> >    if (ret)
> >> >            return ret;
> >> > --
> >> > 2.18.0
> >>
> >
> >
> > Cheers,
> > Phil
> >
> > --
> 

-- 

