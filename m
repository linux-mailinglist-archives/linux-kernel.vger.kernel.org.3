Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705B24BB3ED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiBRILT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:11:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiBRILO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:11:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180C438182
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:10:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 53E8E210F6;
        Fri, 18 Feb 2022 08:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645171856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/1wewcLt9nI8yFjnz0wjFrOsRJHDTJ8Yv+8E7hf14A=;
        b=odGXEz4xNqnCt1Css2BrJWqduFjaN9L8hcfjS0FasFnCsXfVpsam/kgpDs6zkaVJSLoOoa
        1uoWYV59N602EF3j7y9z+fx65+lPyuUsdH2+x2iKUNe4C44UZgHGvHWfWNmq8oVmsAsHjJ
        BWaxOrpiep2LnmsGE4TQjC0vOJ613uU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D10D5A3B81;
        Fri, 18 Feb 2022 08:10:55 +0000 (UTC)
Date:   Fri, 18 Feb 2022 09:10:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        christian@brauner.io, hch@infradead.org, oleg@redhat.com,
        david@redhat.com, jannh@google.com, shakeelb@google.com,
        luto@kernel.org, christian.brauner@ubuntu.com, fweimer@redhat.com,
        jengelh@inai.de, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
Message-ID: <Yg9UjvEj5fDShG47@dhcp22.suse.cz>
References: <20220215201922.1908156-1-surenb@google.com>
 <YgytzntIfx6Toom2@dhcp22.suse.cz>
 <CAJuCfpFL9AQxNsjKxDHhu7UgMGETs+h9Avi6o1mQkvZ4N7CTRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFL9AQxNsjKxDHhu7UgMGETs+h9Avi6o1mQkvZ4N7CTRw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-02-22 11:51:13, Suren Baghdasaryan wrote:
> On Tue, Feb 15, 2022 at 11:54 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > I really have to say that I hate how complex this has grown in the name
> > of optimizations. This has backfired several times already resulting in
> > 2 security issues. I really hope to get read any note of the oom reaper
> > from exit_mmap.
> 
> Agree. I want to take another stab at removing __oom_reap_task_mm from
> exit_mmap. Now that Hugh made changes to mlock mechanisms and
> __oom_reap_task_mm does not skip locked vmas I think that should be
> possible. Planning to look into that sometimes next week.

Thanks!
-- 
Michal Hocko
SUSE Labs
