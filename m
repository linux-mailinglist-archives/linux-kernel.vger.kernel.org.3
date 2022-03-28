Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15B04E8BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiC1BjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiC1BjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:39:11 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2774F9E2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:37:31 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2e592e700acso133361877b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdyfkkOtVcY9wMmcQ9hL8yLIG6KQpQUvBHwAp6nqkPs=;
        b=Rfi7hxBhwncJcA6UrsQIGEghkipmREBwWT98w90zq3S+ccieDw4MAGLwBjXxOVeKCT
         553yC0w6J0Jf0t61aWYg8zg9mXKcga5oC/L7X5Mj9i0PR/bl+p3VyVnSNZwa8+b2Rvzx
         uO6W/pYbEg9FNTK/dB7hiDqblVbBWjgVfo1l/3nS4i0Jh5oK7BI3JoDMV1YQdERYXWlp
         JKwjCTbD1sZ7In5mHKAluWV1Wo3VLtMdgKmOd/DWhLerVTgUA2+uXQJmcP/7KowMt3gZ
         FtSp/qHu5aDq/0OIPIwrWA04SEXCL5rO8oduIAR/udmgv/E+fmGkFuqPRX3LHt5CKmK7
         0Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdyfkkOtVcY9wMmcQ9hL8yLIG6KQpQUvBHwAp6nqkPs=;
        b=vdBce7yC1iu26ZqvP/3hzKd9gh6Oq3cojY9B4ct5A8QG69PehYw7OdOjeFhmWbJEMc
         nCo87MEbozZ012BLh+F/5T3Sk6oSE82C9MWoz0xD5gtMpyh/4AGXjJsD0WoeC14JkHNc
         OQzMsyvUgG4kLJn04tLScincgJ+Jf6d0JbaOU1cQsoZVpdW8n+T3Vm4LNdCOkHEfs2AY
         wRi2hiO0cXtLEkg0Lh/RCUU65GnKE9et+b02TmHoCalYswLFlEg4GtOf6UqLe5fQCaBu
         7uyIDmsE4FBlJ3TiejYuRwmHXs5Ikqxw+Xyqe2vbf/EYElmHcEYozjSYH4HXoCaIoQcT
         Z24Q==
X-Gm-Message-State: AOAM532+V4EfzhWvHSsUD9/o1Ipgr2kYnhqs1KuxSgjtgkoo85WfZLDH
        kp2QXK0TZnHLQSTZb2pPgPtzDOluOO35VczIAYs5zA==
X-Google-Smtp-Source: ABdhPJy9+BoSaiENb1bphoFlDEWLJCsHmooE2AvZ2h/Awh7on9o4cO/L7l+jsKSOG4PmHwsule42OZw35AzFcgduwlY=
X-Received: by 2002:a0d:f685:0:b0:2e2:22e6:52d7 with SMTP id
 g127-20020a0df685000000b002e222e652d7mr22805715ywf.418.1648431450769; Sun, 27
 Mar 2022 18:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220327051853.57647-1-songmuchun@bytedance.com> <CAHk-=wh-mVrp3auBiK2GSMpuqS10Bbq_7fRa6+=zt-0LiF7O2A@mail.gmail.com>
In-Reply-To: <CAHk-=wh-mVrp3auBiK2GSMpuqS10Bbq_7fRa6+=zt-0LiF7O2A@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 28 Mar 2022 09:36:52 +0800
Message-ID: <CAMZfGtWV4cOvD1DxOXxaX2-FB+_sfquBFS+7s5DBp59k8cL-RQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: kfence: fix missing objcg housekeeping for SLAB
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 5:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Mar 26, 2022 at 10:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The objcg is not cleared and put for kfence object when it is freed, which
> > could lead to memory leak for struct obj_cgroup and wrong statistics of
> > NR_SLAB_RECLAIMABLE_B or NR_SLAB_UNRECLAIMABLE_B.  Since the last freed
> > object's objcg is not cleared, mem_cgroup_from_obj() could return the wrong
> > memcg when this kfence object, which is not charged to any objcgs, is
> > reallocated to other users.  A real word issue [1] is caused by this bug.
>
> Good that this looks sorted out.
>
> Patch 2/2 seems to still be up in the air. The patch not only causes
> build errors, but it looks really very odd to me.
>
> In particular, you do that loop with
>
>                 __SetPageSlab(&pages[i]);
>
> in kfence_init_pool(), but that is *not* where you set the
> MEMCG_DATA_OBJCGS, and instead do that virt_to_slab(addr) dance later.
>
> That looks very odd to me. I think the two should go hand-in-hand,
> since that __SetPageSlab() really is what makes it a slab thing, and I
> think it should go together with setting the slab state correctly.

Right. It is a little odd. I'll improve it in the next version.

>
> Finally, is there a syzbot report for that second problem?

No. The second bug does not trigger any oops, so it is hard to be seen.
It is just my code review.

>
> Anyway, should I apply this PATCH 1/2 now directly as the solution for
> the dentry issue, or should I wait for that second patch? They seem to
> be related only indirectly, in that the problems were both introduced
> by the same commit.
>

I think you could apply PATCH 1/2 now.  PATCH 2/2 is another issue not
related to dentry issue.

Thanks.
