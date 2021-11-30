Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EAE4628F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhK3ARY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhK3ARW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:17:22 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626F1C061714
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:14:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so16881905pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N4oQ5nsHnuyqNnK3H0H8mAWujsRpP5GrUWo0jZNgTTM=;
        b=l5FCTULeQNbQN2lAn0hLRugpBy22ZFU1i1IqLebP7XVtvQnM0GOQWX1a7OZH33nEP9
         TINO+upQk44QFZzIqeChSROdlccw9HvLq9vPHnbccWuelBkkwheYNj77hf48zW7kZQMk
         tHnZYIJCSVAcqd3MoqKg4ch6MbWjG1OlrkkHtaHfS7zRF7QeZG9wqYLrI1fczk7c4fAM
         644OnpA8WKSb/V7euEDMwdJNp9CRlQAZtSUVpomw/vIt3rXBx8JlQJLxYHDhZYvcw9KS
         WP1jPHqKtiGeI/sHnX4DoXwxB6miZHnnreraWvCpeUSVVFIjZbzFQjbpo7eWdvdh7ouW
         klbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N4oQ5nsHnuyqNnK3H0H8mAWujsRpP5GrUWo0jZNgTTM=;
        b=Pxf2I6cMURr3cYMyBWQa439V4NiGMBlcv4wEKKOheC80ir1Mm1lQSe+0h6Vh+Fnv8B
         k0iviBuE4W4fcyzLPBxNwuPxrWtPPCNnSWWqhmqiKhw9d04psln7Yn7VNtI5QEfJAOP7
         mWjmPKCoDzzFeT5KgS7qvC5nQRhN2010kNpURsNo0APbZSMfp3Oi14YKnsRRSR2/bVND
         Frqbpq4wpHUrA3X6Nj0kICprTl80TEzL/brwehwW2papIKdFLDT+iBrlnNZldVqygiAD
         NRqxAMZOFfgoKNJK9mMXoJmhWMZ/x1/yuRNNEXvQj66PMQzswcoUi/KM5RrKpGnyksl0
         ehRg==
X-Gm-Message-State: AOAM5301rmUX+APE8lzzIWgPEbIdkUiVf8WHaql32GMXRTZ8Wn6NJdZ0
        0nLorbFtPZ/BO/lnimVs18lzPQ==
X-Google-Smtp-Source: ABdhPJwvDdfGiexibonb/HWlMGNitjQuz3LfqR3AijmZovgZpXGFNX6Z29BHZrkdI9lvaO/oyuROFw==
X-Received: by 2002:a17:90a:fd96:: with SMTP id cx22mr1647813pjb.151.1638231243456;
        Mon, 29 Nov 2021 16:14:03 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q89sm438335pjk.50.2021.11.29.16.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:14:02 -0800 (PST)
Date:   Tue, 30 Nov 2021 00:13:59 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 15/15] KVM: x86/mmu: Promote pages in-place when
 disabling dirty logging
Message-ID: <YaVsxzfkbYpr7Ck9@google.com>
References: <20211115234603.2908381-1-bgardon@google.com>
 <20211115234603.2908381-16-bgardon@google.com>
 <YZ8OpQmB/8k3/Maj@xz-m1.local>
 <CANgfPd9pK83S+yoRokLg7wiroE6-OkieATTqgGn3yCCzwNFi4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd9pK83S+yoRokLg7wiroE6-OkieATTqgGn3yCCzwNFi4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021, Ben Gardon wrote:
> On Wed, Nov 24, 2021 at 8:19 PM Peter Xu <peterx@redhat.com> wrote:
> > I've got a few comments below, but before that I've also got one off-topic
> > question too; it'll be great if you can help answer.
> >
> > When I was looking into how the old code recovers the huge pages I found that
> > we'll leave the full-zero pgtable page there until the next page fault, then I
> > _think_ it'll be released only until the __handle_changed_spte() when we're
> > dropping the old spte (handle_removed_tdp_mmu_page).
> 
> That seems likely, though Sean's recent series that heavily refactored
> zapping probably changed that.

Hmm, no, that behavior shouldn't change for this path in my series.  Only the leaf
SPTEs are zapped, the shadow page hangs around until its replaced by a hugepage,
reclaimed due to memory pressure, etc...  FWIW, that's consistent with the
legacy/full MMU.

Zapping the SP is doable in theory, but it would require completely different
iteration behavior and small amount of additional logic to check the entire gfn
range covered by the SP for compability.  If we were starting from scratch, I
would probably advocate zapping the parent SP directly, but since the net work
done is roughly equivalent, the cost of keeping the page around is negligible,
and we have functional code already...
