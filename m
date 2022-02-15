Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1959C4B7911
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbiBOUwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:52:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbiBOUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:51:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6711D13EAA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:51:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00A9F61871
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7019DC340EB;
        Tue, 15 Feb 2022 20:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644958308;
        bh=ZoE56QlMMe/6GAt9NiJ/uuDXXAUUGedCStQmJCH2WH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L5e3ipJCut32WVwDvYHOj85u2VIM/iPDLLfEyVf2aZ+by0q6eYKZK4/cW+DCnAZ4s
         oEZtdgitFMRKO1C1EDFfiO27KkRUT8KS9F7OqvY2OjD9HG6HLmC9SQBGfgcL6bfqzg
         j0J4h2LSWT56Oftvyscj3Rt7sfjwn/vWfKp3nO10=
Date:   Tue, 15 Feb 2022 12:51:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot <syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
Message-Id: <20220215125146.64b5604bd024058c97659fa7@linux-foundation.org>
In-Reply-To: <CAJuCfpE6sFMmfzjeMVDRp35eUro1dbOhHS86gj6Xce7mwuYeEw@mail.gmail.com>
References: <20220215201922.1908156-1-surenb@google.com>
        <20220215123741.8e757b337e1f2d32a1766d42@linux-foundation.org>
        <CAJuCfpHwHRodo00gR=5=p+gvp60T+s04=5XBnCc9xsTOZCSE1Q@mail.gmail.com>
        <CAJuCfpE6sFMmfzjeMVDRp35eUro1dbOhHS86gj6Xce7mwuYeEw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 12:46:57 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> > Fixes: 64591e8605d6 ("mm: protect free_pgtables with mmap_lock write
> > lock in exit_mmap")
> 
> Andrew, do you want me to post another version with Fixes:
> 64591e8605d6 ("mm: protect free_pgtables with mmap_lock write lock in
> exit_mmap") added or you can add it directly?

I added it, thanks.
