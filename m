Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F864B78CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244119AbiBOUhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:37:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbiBOUhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:37:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BEED7637
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:37:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BC2F618A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03576C340EB;
        Tue, 15 Feb 2022 20:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1644957462;
        bh=PW63ggN6zZoYkUXMB9yKj4HZtdIRxwjpfcM3zjcQADs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yIWYCQxihBsi5edoT5/UGqqLr7yFyJYtA2Yu4twjHH7klP/Ep1cEb77qC1XfINfw1
         LlG3/n96rqiAUYGZ59ERiHO7aE1u7xeVdjpBXisZ9L9SJ8X4EgAtCxWAtcn4TEoaOy
         ssMTuTVsok5ltbid0sqZmY8yCx3tKSH1kW/RAjPg=
Date:   Tue, 15 Feb 2022 12:37:41 -0800
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
        syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
Message-Id: <20220215123741.8e757b337e1f2d32a1766d42@linux-foundation.org>
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

https://lore.kernel.org/all/00000000000072ef2c05d7f81950@google.com/

It would be nice to have a Fixes: for this.

Is it specific to process_mrelease(), or should we backport further?
