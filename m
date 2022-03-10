Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A04D456F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbiCJLPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiCJLPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:15:17 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E83B03C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:14:17 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v130so10100883ybe.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3pJ+I2YdNs/yLkLBmuj/ECVh0Vo8H7W59XBvWovNF/w=;
        b=DTm9QGRf4V8etnToR2oxMCKXzh6s4jheFkE16EHIlg1Wj7kIx9Z3rejll7vRqy1YwH
         OBWSgwDFHbs1ECPVu5WczTtpj/WKDikPD4S2PR2VYSM+ftyjq//IF/9K+3o3s+l8MryJ
         NyRU5apXPEzjmPFX0yKW7aQnn+frc+gT5aHnTw7iE2hIJ5lg3x0nL7MwydKWhoBNLNlx
         s8ZB9k+TiVagYqoWq6lV4OJbDf0SKdtZeXNQZjCv9y+hJr778Keh24+J/QfrcGoQLUxN
         a1Ba7/m+dN7Ssy22Q236LVmXi/+3NuqNuNMTzACb7QcyaZnSo7f/jna7gfhaG0YnH7CX
         aTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pJ+I2YdNs/yLkLBmuj/ECVh0Vo8H7W59XBvWovNF/w=;
        b=iWX3i2faaynnDDxAJeISo3pczALj5WF0ejhfyhKdpomRSyDg54gbOpD58D6S1ANYQs
         V14/HuQNbfW3no57KVOiNTZ0S1sshav/x+bov8lVdqIIgxxMd5jtxFe1MmBrNZ3SNqnm
         6iIkVttZ3YSoNbIGmAwLCSG8FxDP8rZmkb7UdLBivwXb17DEvlmaBJwXHqzhJkIQTAth
         jtziLS4mDcN3jEY0aCc4uQ/hhf3Nh7xGrYMhrLFjc1z/QLlg8GNshlYQd7v7VLFXtend
         njvVCZ8T0YAVv8Yo0SzX4wNlOv9tYjaHmN9czBtU252kctcZwd7km0IYX0l0o8N5nlBn
         0YHQ==
X-Gm-Message-State: AOAM533T1C5bsg3g3UjiZDSe+30tDha2D6ZnCLegpGUiqwxl/ndjx52F
        T2GU+U6YqspIAA9G1idXy7UGcGw9ydvbdIq0/FA=
X-Google-Smtp-Source: ABdhPJzHxi5ApO77ILPXu9em9cQSGEgjoC9X8lo0uePx/MJNVIuNglcL9pX84nCqI/+OVJPXub1ClmfVLPlt+kzz27U=
X-Received: by 2002:a25:cfc1:0:b0:629:15c3:e17 with SMTP id
 f184-20020a25cfc1000000b0062915c30e17mr3402014ybg.534.1646910856534; Thu, 10
 Mar 2022 03:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20220308141437.144919-1-david@redhat.com> <CAHk-=wiA0KMVbLacK-Gi5_ZsZhXVi++6ePTtPrJkgf0az7r2ww@mail.gmail.com>
 <d615d51d-8643-190e-9cc2-844a28a349cf@redhat.com>
In-Reply-To: <d615d51d-8643-190e-9cc2-844a28a349cf@redhat.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 10 Mar 2022 13:13:49 +0200
Message-ID: <CAFCwf10NyRmcsDVH+j5B=FDfjquqmDUjYb=Hzn2OUCxOAFE+-w@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] mm: COW fixes part 2: reliable GUP pins of
 anonymous pages
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 10:00 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.03.22 22:22, Linus Torvalds wrote:
> > On Tue, Mar 8, 2022 at 6:14 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> This series fixes memory corruptions when a GUP pin (FOLL_PIN) was taken
> >> on an anonymous page and COW logic fails to detect exclusivity of the page
> >> to then replacing the anonymous page by a copy in the page table [...]
> >
> > From a cursory scan of the patches, this looks sane.
>
> Thanks for skimming over the patches that quickly!
>
> >
> > I'm not sure what the next step should be, but I really would like the
> > people who do a lot of pinning stuff to give it a good shake-down.
> > Including both looking at the patches, but very much actually running
> > it on whatever test-cases etc you people have.
> >
> > Please?

I can take this patch-set and test it in our data-center with all the
DL workloads we are running
on Gaudi.

David,
Any chance you can prepare me a branch with your patch-set based on 5.17-rc7 ?
I prefer to take a stable kernel and not 5.18-rc1 as this is going to
run on hundreds of machines.

Thanks,
Oded

>
> My proposal would be to pull it into -next early after we have
> v5.18-rc1. I expect some minor clashes with folio changes that should go
> in in the next merge window, so I'll have to rebase+resend either way,
> and I'm planning on thoroughly testing at least on s390x as well.
>
> We'd then have plenty of time to further review+test while in -next
> until the v5.19 merge window opens up.
>
> By that time I should also have my selftests cleaned up and ready, and
> part 3 ready to improve the situation for FOLL_GET|FOLL_WRITE until we
> have the full FOLL_GET->FOLL_PIN conversion from John (I'll most
> probably sent out an early RFC of part 3 soonish). So we *might* be able
> to have everything fixed in v5.19.
>
> Last but not least, tools/cgroup/memcg_slabinfo.py as mentioned in patch
> #10 still needs care due to the PG_slab reuse, but I consider that a
> secondary concern (yet, it should be fixed and help from the Authors
> would be appreciated ;) ).
>
> --
> Thanks,
>
> David / dhildenb
>
