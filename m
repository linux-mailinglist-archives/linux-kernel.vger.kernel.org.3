Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08274B82A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiBPIHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:07:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiBPIHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:07:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD23C1275E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:06:56 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3B155212C0;
        Wed, 16 Feb 2022 08:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644998815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LD5BS4A6+M+I9xz43duRZ/i6514hL165l4i7vbTm0NI=;
        b=rnq/YE8WVL2IK1JinkHALTcCu3+5mlX/1Xj+ZQSEuBJYA/jqDmlfUVPaxpksCs7ZZrJLab
        CV45gZPy99wr53AulS4EjPq+x4fxz+8OcQu15f/dkSeOETVHUSEzh3YXKszrUv96Q3c+RW
        B7B+JLefC6Ls7EoQfiePkAOYIT+eBU4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1D46CA3B8A;
        Wed, 16 Feb 2022 08:06:53 +0000 (UTC)
Date:   Wed, 16 Feb 2022 09:06:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>, legion@kernel.org,
        ran.xiaokai@zte.com.cn, sashal@kernel.org,
        Chris Hyser <chris.hyser@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Collingbourne <pcc@google.com>, caoxiaofeng@yulong.com,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
Message-ID: <YgywnF8l4Zu0aLtF@dhcp22.suse.cz>
References: <20220211013032.623763-1-surenb@google.com>
 <YgvONKdZ2T0PB2/0@dhcp22.suse.cz>
 <YgwDa6rMHRdRTnzB@dhcp22.suse.cz>
 <YgwHhTN4P5yyZqBz@dhcp22.suse.cz>
 <CAJuCfpGG9zwbvfH5UZkt6cG=woeO0RGE7QxjEpXn=gFhiaDdmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGG9zwbvfH5UZkt6cG=woeO0RGE7QxjEpXn=gFhiaDdmQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-02-22 15:02:54, Suren Baghdasaryan wrote:
> On Tue, Feb 15, 2022 at 12:05 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > One thing I was considering is to check agains ref counte overflo (a
> > deep process chain with many vmas could grow really high. ref_count
> > interface doesn't provide any easy way to check for overflows as far as
> > I could see from a quick glance so I gave up there but the logic would
> > be really straightforward. We just create a new anon_vma_name with the same
> > content and use it when duplicating if the usage grow really
> > (arbitrarily) high.
> 
> I went over proposed changes. I see a couple small required fixes
> (resetting the name to NULL seems to be missing and I think
> dup_vma_anon_name needs some tweaking) but overall quite
> straight-forward.

OK, great that this makes sense to you. As I've said I didn't really go
into details, not even dared to boot that to test. So it will very
likely need some more work but I do not expect this to grow much.

> I'll post a separate patch to do this refactoring.
> The original patch is fixing the UAF issue, so I don't want to mix it
> with refactoring. Please let me know if you see an issue with
> separating it that way.

Well, I am not sure TBH. Look at diffstats. Your fix
2 files changed, 63 insertions(+), 17 deletions(-)
the refactoring which should fix this and potentially others that might
be still lurking there (because mixing shared pointers and their internal
objects just begs for problems) is
7 files changed, 63 insertions(+), 86 deletions(-)

more files touched for sure but the net result is much more clear and a
much more code removed.
The overflow logic would make it bigger but I guess the existing scheme
needs it as well.

I would also claim that both approaches are really painful to review
because the existing model spreads into several areas and it is not
really clear you caught them all just by staring into the diff so both
will be rather painful to backport to older kernels. Fortunately this
would be only 5.17.
-- 
Michal Hocko
SUSE Labs
