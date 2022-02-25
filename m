Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDC04C3D03
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbiBYETh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbiBYETe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:19:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D29275797
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:19:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BFA2B82B07
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B7CC340E7;
        Fri, 25 Feb 2022 04:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645762741;
        bh=hzQG2QIF47CHmg+UgPl9geBa5xc95GKwwMRDXpJTRUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GH/0Q5c1WEvwOQfXb55HDbDlUkrSc/I163Nnq0aFQTQJfBdXicD6kqNr9J79iSbLJ
         IgekHROK/Jje0DdSdZo8rNge06yDWNXEpwZwnWyZjxHVJRlqKyFBRWSIgmXjh1AS7C
         CdIWgGRahwNaBpZwI7wPDst4qNIXY2xccdiAjYR0=
Date:   Thu, 24 Feb 2022 20:18:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mhocko@kernel.org, mhocko@suse.com, shy828301@gmail.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        christian@brauner.io, hch@infradead.org, oleg@redhat.com,
        david@redhat.com, jannh@google.com, shakeelb@google.com,
        luto@kernel.org, christian.brauner@ubuntu.com, fweimer@redhat.com,
        jengelh@inai.de, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com,
        Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
Message-Id: <20220224201859.a38299b6c9d52cb51e6738ea@linux-foundation.org>
In-Reply-To: <20220215201922.1908156-1-surenb@google.com>
References: <20220215201922.1908156-1-surenb@google.com>
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

On Tue, 15 Feb 2022 12:19:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
> otherwise it points to a vma that was freed and when reused leads to
> a use-after-free bug.
> 
> ...
>
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
>  		vma = remove_vma(vma);
>  		cond_resched();
>  	}
> +	mm->mmap = NULL;
>  	mmap_write_unlock(mm);
>  	vm_unacct_memory(nr_accounted);
>  }

After the Maple tree patches, mm_struct.mmap doesn't exist.  So I'll
revert this fix as part of merging the maple-tree parts of linux-next.
I'll be sending this fix to Linus this week.

All of which means that the thusly-resolved Maple tree patches might
reintroduce this use-after-free bug.

