Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2497F4C2BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiBXMbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiBXMbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:31:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37CC3264987
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645705837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AqOiTimbhwMR6JdlyxUT8Se6t3oyzrlLLdGUoWlPRkk=;
        b=XEjV0eMLw9BRwrlhnYjKrHKMOeEGTlUNEPHN9O91WpebEY4/KXJk0HjytO9yUTd7oMCVFk
        IijxeH976fJuTB1w21xWW9m8Snt0pIi3hKbgoyH8VxU5hrNF9Cl1BTOYRrNVlRUqm4LSI6
        22h+5oUh9C2Lv998SN1mIMHvN8G9vLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-Px0M8utHMYCc6ouXz-mjKA-1; Thu, 24 Feb 2022 07:30:36 -0500
X-MC-Unique: Px0M8utHMYCc6ouXz-mjKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC89C1854E27;
        Thu, 24 Feb 2022 12:30:34 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66F5B7BB6C;
        Thu, 24 Feb 2022 12:30:34 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 80720416D862; Thu, 24 Feb 2022 09:30:11 -0300 (-03)
Date:   Thu, 24 Feb 2022 09:30:11 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <Yhd6UxWH3FQHg+eF@fuller.cnet>
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <20220217124729.GA743618@lothringen>
 <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
 <20220217163205.GA748087@lothringen>
 <20220218125454.utlgmuhijklzr3if@ava.usersys.com>
 <20220219154616.pwsvh445x3vn7ltf@ava.usersys.com>
 <Yhd5olg9CjXSAf2s@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhd5olg9CjXSAf2s@fuller.cnet>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:27:14AM -0300, Marcelo Tosatti wrote:
> On Sat, Feb 19, 2022 at 03:46:16PM +0000, Aaron Tomlin wrote:
> > On Fri 2022-02-18 12:54 +0000, Aaron Tomlin wrote:
> > > On Thu 2022-02-17 17:32 +0100, Frederic Weisbecker wrote:
> > > > > If I understand correctly, in the context of nohz_full, since such work is
> > > > > deferred, it will only be handled in a scenario when the periodic/or
> > > > > scheduling-clock tick is enabled i.e. the timer was reprogrammed on exit
> > > > > from idle.
> > > > 
> > > > Oh I see, it's a deferrable delayed work...
> > > > Then I can see two other issues:
> > > > 
> > > > 1) Can an interrupt in idle modify the vmstat and thus trigger the need to
> > > >    flush it? 
> 
> Yes. Page allocation and page freeing for example.
> 
>    6   3730  ../mm/page_alloc.c <<rmqueue>>
>              __mod_zone_freepage_state(zone, -(1 << order),
>    4   1096  ../mm/page_alloc.c <<__free_one_page>>
>              __mod_zone_freepage_state(zone, -(1 << order),
> 
> > > >    I believe it's the case and then the problem goes beyond nohz_full
> > > >    because if the idle interrupt fired while the tick is stopped and didn't set
> > > >    TIF_RESCHED, we go back to sleep without calling quiet_vmstat().
> > > 
> > > Yes: e.g. a nohz_full CPU, in idle code, could indeed receive a reschedule
> > > IPI; re-enable local IRQs and generic idle code sees the TIF_NEED_RESCHED
> > > flag against the idle task. Additionally, the selected task could
> > > indirectly released a few pages [to satisfy a low-memory condition] and
> > > modify CPU-specific vmstat data i.e. vm_stat_diff[NR_FREE_PAGES].
> > > 
> > > 
> > > > 2) What if we are running task A in kernel mode while the tick is stopped
> > > >    (nohz_full). Task A modifies the vmstat and goes to userspace for a long
> > > >    while.
> > > > Your patch fixes case 1) but not case 2). The problem is that TIMER_DEFERRABLE
> > > > should really be about dynticks-idle only and not dynticks-full. I've always
> > > > been afraid about enforcing that rule though because that would break old
> > > > noise-free setups. But perhaps I should...

Can't grasp the sentence above "The problem is that ...".
What rule?

