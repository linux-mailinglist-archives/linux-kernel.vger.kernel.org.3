Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F450E96D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244921AbiDYTZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiDYTZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA2151102A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650914556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mqmP98i3xVGOSE8p44wlqw/VP2O+Gc6FyNmdWMrFY9w=;
        b=ajIOu4yGeMt26ybDfoTda7autotNNi4+4FkzSYYAYWSggLg3NuhLhmJGkOATzmlhZzArE6
        OVbXajk2X9nfBnSQxVy965xGx6ck90QVsQlfxhHA8f/JEnTpo6rgsnHRnVKpRt6l0f0KCY
        OfoLKyJ79JmrZ1n2ed2CYOla4XYCevI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-403Nb6SNMAybueqHbg33UA-1; Mon, 25 Apr 2022 15:22:33 -0400
X-MC-Unique: 403Nb6SNMAybueqHbg33UA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B17CB811E84;
        Mon, 25 Apr 2022 19:22:32 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0FBF7AD9;
        Mon, 25 Apr 2022 19:22:26 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 7049A416F574; Mon, 25 Apr 2022 16:21:59 -0300 (-03)
Date:   Mon, 25 Apr 2022 16:21:59 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@gentwo.de>, frederic@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <Ymb018EaVlOUfx87@fuller.cnet>
References: <20220422193647.3808657-1-atomlin@redhat.com>
 <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de>
 <20220425113909.u3smtztp66svlw4o@ava.usersys.com>
 <alpine.DEB.2.22.394.2204251406370.13839@gentwo.de>
 <20220425132700.GK2731@worktop.programming.kicks-ass.net>
 <20220425141717.vw2jfnn3zp6c5ib2@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425141717.vw2jfnn3zp6c5ib2@ava.usersys.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 03:17:17PM +0100, Aaron Tomlin wrote:
> On Mon 2022-04-25 15:27 +0200, Peter Zijlstra wrote:
> > On Mon, Apr 25, 2022 at 02:09:06PM +0200, Christoph Lameter wrote:
> > > On Mon, 25 Apr 2022, Aaron Tomlin wrote:
> > > 
> > > > Yes, in the context of nohz, this patch should ensure it, if required, when
> > > > the idle tick is to be stopped.
> > > 
> > > What I said was that it is generally useful. Even in the non NOHZ case.
> > > 
> > > Folding the vmstat diffs *always* when entering idle prevents unnecessary
> > > wakeups and processing in the future and also provides more accurate
> > > counters for the VM allowing better decision to be made on reclaim.
> > 
> > I'm thinking you're going to find a ton of regressions if you try it
> > though; some workloads go idle *very* shortly, doing all this accounting
> > is going to be counter-productive.
> 
> Hi Peter, Christoph,
> 
> Indeed. Which was why I decided, initially, against the general-purpose
> case/or approach. Personally, I would prefer to keep this somewhat
> restrictive to nohz.

Is there anything that prevents a nohz full CPU from running an
application with short and frequent idling?

Note:

commit a5183862e76fdc25f36b39c2489b816a5c66e2e5
Author: Yunfeng Ye <yeyunfeng@huawei.com>
Date:   Thu May 13 01:29:16 2021 +0200

    tick/nohz: Conditionally restart tick on idle exit
    
    In nohz_full mode, switching from idle to a task will unconditionally
    issue a tick restart. If the task is alone in the runqueue or is the
    highest priority, the tick will fire once then eventually stop. But that
    alone is still undesired noise.
    
    Therefore, only restart the tick on idle exit when it's strictly
    necessary.
    
    Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
    Acked-by: Peter Zijlstra <peterz@infradead.org>
    Link: https://lore.kernel.org/r/20210512232924.150322-3-frederic@kernel.org


