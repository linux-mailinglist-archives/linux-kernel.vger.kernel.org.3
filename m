Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C1F4BB3F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiBRIMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:12:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiBRIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:12:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F6D3DA6B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:11:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 260631F3A2;
        Fri, 18 Feb 2022 08:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645171912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qcClNe/lqJjlFt2b+6Tx37Cl/TqOAh3cSDlvkRYML9Y=;
        b=FGd8iy0HMwT+i4soG0zP/BeaFhoFgDcpHN+olZV3niWQTU+lXH35NdDqYdM4peBKUMaJch
        FNNrpHscm3QsCh1Th6lqXWoRWhi4oqTCxMOBRc9w8VgLt9MtkvqDZXNrtP/Fmty2RpAX0u
        0Zk7IjLXBE3m1TC33K5doYCHcWVYFjE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 05DFAA3B85;
        Fri, 18 Feb 2022 08:11:52 +0000 (UTC)
Date:   Fri, 18 Feb 2022 09:11:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, shy828301@gmail.com,
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
Message-ID: <Yg9Ux08ZAK448qjw@dhcp22.suse.cz>
References: <20220215201922.1908156-1-surenb@google.com>
 <YgytzntIfx6Toom2@dhcp22.suse.cz>
 <CAJuCfpFL9AQxNsjKxDHhu7UgMGETs+h9Avi6o1mQkvZ4N7CTRw@mail.gmail.com>
 <20220217125056.df4073b42f2d911c99939e93@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217125056.df4073b42f2d911c99939e93@linux-foundation.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-02-22 12:50:56, Andrew Morton wrote:
> On Thu, 17 Feb 2022 11:51:13 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > This changelog is very detailed and I support switching to it. Andrew,
> > please let me know if I should re-post the patch with this description
> > or you will just amend the one in your tree.
> 
> I have made that change.

LGTM. Thanks!
-- 
Michal Hocko
SUSE Labs
