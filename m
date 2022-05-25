Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9559D534008
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245033AbiEYPMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbiEYPMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E0DCB225B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653491520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oibYPAPXB3rxchD26NN1if0CqTbEEBbCmYMLu9cS348=;
        b=ii2M3SMSGsupnBRCYku1bw/wjL2Hg9Ab/UZoqj5tesYI3dvlvPeQ3bE+s+L1wMktYC5j6J
        0e9TxrYWWggW/SL0yufuPY/5ZQkHevLu61QH3HJedGj/V4+xZR6i9T8qtCflf8WSUc3v/Z
        94mAWRQktWbwJhBqxSlDM1lhTq3oD/M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-3WVS63MGNry6uCXFElI4tQ-1; Wed, 25 May 2022 11:11:58 -0400
X-MC-Unique: 3WVS63MGNry6uCXFElI4tQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88DED811E81;
        Wed, 25 May 2022 15:11:58 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.192.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C943F112131B;
        Wed, 25 May 2022 15:11:56 +0000 (UTC)
Date:   Wed, 25 May 2022 11:11:52 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuhp: make target_store() a nop when target == state
Message-ID: <Yo5HOC0yoEBvvgdL@lorien.usersys.redhat.com>
References: <20220523144728.32414-1-pauld@redhat.com>
 <xhsmh35gzj77s.mognet@vschneid.remote.csb>
 <Yo0KRVpfhUb8Ta4N@lorien.usersys.redhat.com>
 <xhsmhy1yqhrio.mognet@vschneid.remote.csb>
 <20220525133133.GA5500@pauld.bos.csb>
 <xhsmhtu9dir86.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhtu9dir86.mognet@vschneid.remote.csb>
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

On Wed, May 25, 2022 at 04:09:29PM +0100 Valentin Schneider wrote:
> On 25/05/22 09:31, Phil Auld wrote:
> > On Wed, May 25, 2022 at 10:48:31AM +0100 Valentin Schneider wrote:
> >>
> >> Yeah it would be neater to not even enter cpu_{up, down}(), but my paranoia
> >> makes me think we need the comparison to happen with at least the
> >> cpu_add_remove_lock held to make sure st->state isn't moving under our
> >> feet, otherwise we may still end up with target == state in _cpu_down() and
> >> hit the bug you're describing.
> >>
> >
> > This is what I was originally doing before I tried to "optimize" it:
> >
> >          if (st->state < target)
> >                  ret = cpu_up(dev->id, target);
> >          else if (st->state > target)
> >                  ret = cpu_down(dev->id, target);
> >
> > This does the check under the lock and just falls through if state==target.
> > I think I'll go back to that version.
> >
> > I also noticed while testing that the boot cpu does not get its target set.
> > It's got state 233 but target 0.  So reading that out and writing it back
> > on offlines cpu0.   I'll try to find where that is not getting set.
> >
> 
> If I had to guess I'd say it's because the boot CPU doesn't go through the
> regular hotplug machinery and sets its state straight to CPUHP_ONLINE
>

Yes, that was my thought.


> /me digs
> 
> Maybe around this?
> 
> void __init boot_cpu_hotplug_init(void)
> {
>         this_cpu_write(cpuhp_state.booted_once, true);
>         this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
> }
> 

Right, just found that too. Probably should set the target there as well.


Cheers,
Phil

-- 

