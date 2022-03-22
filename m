Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885F4E3A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiCVI2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiCVI2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:28:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E67E29CA0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:26:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 36C9D1F385;
        Tue, 22 Mar 2022 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647937613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hnywj9CfLzgrCfLN6HUiL0MSzOUyCXY5DawdGkBu/Ko=;
        b=RrPr5pIqwbWx5Oswh6AE6IGKP9DCOpxWnRLxLcd96mxdzohUNSlvpMdr5OPZNjLBHGkl1o
        J/CZK95W9jlnxuTkJCoGU2x55sUWHKmEQ0xlWdVqDW6oTFnR3moZzW6MIyQ92bc7b0vgWH
        QFAsT55DJaMQ09nbSZMkjSR1doNXplc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E5830A3B81;
        Tue, 22 Mar 2022 08:26:52 +0000 (UTC)
Date:   Tue, 22 Mar 2022 09:26:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit
 and the oom_reaper
Message-ID: <YjmITBkkwsa2O4bg@dhcp22.suse.cz>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
 <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
 <20220322025724.j3japdo5qocwgchz@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322025724.j3japdo5qocwgchz@offworld>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-03-22 19:57:24, Davidlohr Bueso wrote:
> On Mon, 21 Mar 2022, Nico Pache wrote:
> 
> > We could proceed with the V3 approach; however if we are able to find a complete
> > solution that keeps both functionalities (Concurrent OOM Reaping & Robust Futex)
> > working, I dont see why we wouldnt go for it.
> 
> Because semantically killing the process is, imo, the wrong thing to do.

I am not sure I follow. The task has been killed by the oom killer. All
we are discussing here is how to preserve the robust list metadata
stored in the memory which is normally unmapped by the oom_reaper to
guarantee a further progress. 

I can see we have 4 potential solutions:
1) do not oom_reap oom victims with robust futex metadata in anonymous
   memory. Easy enough but it could lead to excessive oom killing in
   case the victim gets stuck in the kernel and cannot terminate.
2) clean up robust list from the oom_reaper context. Seems tricky due to
   #PF handling from the oom_reaper context which would need to be
   non-blocking
3) filter vmas which contain robust list. Simple check for the vma range
4) internally mark vmas which have to preserve the state during
   oom_reaping. Futex code would somehow have to mark those mappings.
   While more generic solution. I am not sure this is a practical
   approach. 
-- 
Michal Hocko
SUSE Labs
