Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B304D2FB5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiCINLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiCINLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:11:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54689102154
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:10:03 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C8C2D1F381;
        Wed,  9 Mar 2022 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646831401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AF5nHoVPx+QVoqlhpPP/leSCgEv59byPDm5kXVlHWhQ=;
        b=mz4exN5KalKA/E49edzKguWynqFlnY2k74hzjQHSy7MY2N8okqHEgXg4oP2hud2Sdi90Ln
        6+ytQQDJDQos6pchUbd0tGqRMkFH/kiwmazj3QkMgdr37E6c0WYxotsgqsMghBuL5XxuUz
        p9VoX/mPiip+j5tlpYGQRfR/XtnN32Q=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5C904A3B81;
        Wed,  9 Mar 2022 13:09:56 +0000 (UTC)
Date:   Wed, 9 Mar 2022 14:09:59 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com, peterz@infradead.org,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH v4] mm/oom_kill.c: futex: Don't OOM reap a process with a
 futex robust list
Message-ID: <YiinJ3A6WoTJLN8d@dhcp22.suse.cz>
References: <20220309002550.103786-1-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309002550.103786-1-npache@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-03-22 17:25:50, Nico Pache wrote:
> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
> be targeted by the oom reaper. This mapping is also used to store the futex
> robust list; the kernel does not keep a copy of the robust list and instead
> references a userspace address to maintain the robustness during a process
> death. A race can occur between exit_mm and the oom reaper that allows
> the oom reaper to clear the memory of the futex robust list before the
> exit path has handled the futex death.

The above is missing the important part of the problem description. So
the oom_reaper frees the memory which is backing the robust list. It
would be useful to link that to the lockup on the futex.

> Prevent the OOM reaper from concurrently reaping the mappings if the dying
> process contains a robust_list. If the dying task_struct does not contain
> a pointer in tsk->robust_list, we can assume there was either never one
> setup for this task struct, or futex_cleanup has properly handled the
> futex death and we can safely reap this memory.

I do agree with Waiman that this should go into a helper function. This
would be a quick workaround but I believe that it would be much better
to either do the futex cleanup in the oom_reaper context if that could
be done without blocking. If that is really not feasible for some reason
then we could skip over vmas which are backing the robust list. Have you
considered any of those solutions?
-- 
Michal Hocko
SUSE Labs
