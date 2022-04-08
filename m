Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4AD4F946B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiDHLuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiDHLuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:50:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B4F1FC9EB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:48:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C06601F861;
        Fri,  8 Apr 2022 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649418488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2SZ8j5j+3AavMdIU/yqKPiFoepIpF6VCwykEOw+4+nQ=;
        b=RBRPeS3cWbL+xFHVsXE5sU7LHDrARfsL+coftNzC9oBkMrn/V67vnunaeCMNpitirY/teJ
        7TE6utpsexEA+yVjml4pW+cZqmrva6WhyHh73AjZI4hJVqKMdwN6V6LEL0nYdeN2KwC2Tn
        bOlEOsviOFQMHKCwVqKJ7r2+j7uG7qo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 53339A3B87;
        Fri,  8 Apr 2022 11:48:08 +0000 (UTC)
Date:   Fri, 8 Apr 2022 13:48:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Message-ID: <YlAg+Pu7hIw6W+cc@dhcp22.suse.cz>
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <87tub4j7hg.ffs@tglx>
 <ddf1755e-fe69-b60e-ee07-e78d663b11b2@redhat.com>
 <YlACJMp7AFaVa/Gt@dhcp22.suse.cz>
 <676fb197-d045-c537-c1f7-e18320a6d15f@redhat.com>
 <YlAHfU7VEI0wYAb/@dhcp22.suse.cz>
 <2293c547-3878-435a-ec1c-854c3181ad14@redhat.com>
 <YlATveUBFmWFY+SI@dhcp22.suse.cz>
 <465ab95b-3e71-5901-c184-812dc595af2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465ab95b-3e71-5901-c184-812dc595af2f@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-04-22 07:26:07, Nico Pache wrote:
[...]
> Ok so if i understand that correctly, delaying can have some ugly effects and
> kinda breaks the initial purpose of the OOM reaper?

No, not really. The primary objective of the oom_reaper is to _guaratee_
a forward progress. It is not really meant to be an optimization to
respond to the oom killer faster. The reason the oom_reaper is kicked
off right away is because that was the simplest implementation.

> I personally don't like the delay approach. Especially if we have a better one
> we know is working, and that doesnt add regressions.

Well, I would say that handling futex case more gracefully would be
preferable but my understanding is that this is not all that easy. I am
far from being a futex expert so I will leave that up to Thomas and Peter.

On the other hand delaying oom_reaper is rather straightforward and I do
not think there is a big risk of regressions. Any QoS during OOM is
simply out of the window and the main purpose of the reaper will be
preserved with a timeout as well. I also do agree with Thomas that this
would cover 99% of cases.

> If someone can prove to me the private lock case, I'd be more willing to bite.
> 
> Thanks for all the OOM context :)

Welcome. The oom handling is a maze and it is really easy to miss all
the subtlety and conflicting requirements that are applied here.
-- 
Michal Hocko
SUSE Labs
