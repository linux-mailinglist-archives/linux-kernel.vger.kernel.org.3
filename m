Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D149E94E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiA0RxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiA0RxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:53:09 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04F6C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:53:09 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id s1so3155091ilj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irEE7yHILyJWoTqBD2Snz597LhBeTSpmicRdNJceySU=;
        b=WaoWsAgLDsn8+cDXwJGuBSwy822bEXB3Sr5ofxaHfQSg7Gu+gT6bYzIxtbbeA7LcAc
         rhYG211svtnFRxmgpOVlYL0RNEfxluZbJKmoK7IwSwPASU++F88KcAnU9ab9ZuRbs3Gp
         SEKa+Jd+5CHfIDx3N4JFN+KLiJ7wEUqIYq/gtogS9Sa6yh7oBfVQ3va15aJs5s9kUW4v
         rVdjzODrABmhUZPQaTM87Q0iAMdVFm/ur7QCk13JE7p/3MMyCvTVsl2B7Xbx+SfxN4RK
         4KkTUNGkprWu9S8CxGXGwj752zhjT12FxXO2SlU0lZfQiF6hBp2po442vmAKqp+imTiL
         E56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irEE7yHILyJWoTqBD2Snz597LhBeTSpmicRdNJceySU=;
        b=PbIQN02LfSDOcQ6HqIPOAWPO1iRueaOqVZKu4VI53pFQU37VcEhCpIJjaM+NeNZRyK
         C8GswrkUUJ3UVPxLh0cnOJBCUuZq/jtrXicaFRtAQ0HGo1ALlVp9QGyFMxYhBObatAvM
         kvSFw3W4dkAaRyXArMjqsFzLXi/qv4a7UPIB4ppTMDpv0SrExIB1fIHFzy1O/px3zURH
         ZQWGzgF5pmSQcJxKoE5sMbEZmd8db3qse5qoNq7tR9r4dTm2TLtGmFyUqQrjs0DnFp0D
         qBaXG7v/fB0Tt2sO5H8r45KsJkpvjau/CxyOBy9qj2tAaFKcabJG9Hxw9SldWwtgLC0D
         6s0A==
X-Gm-Message-State: AOAM531aYQj9uZh6M0z27mTPXkKkj+5YgTBpVIKN0/eMN7SdPb0Exq49
        f4DUBq9ALXn40tu/3QSuP7cj6orKLGgZM3cmLPK6xw==
X-Google-Smtp-Source: ABdhPJylTVfStujKAvnQnAOslIqzd/2GW4sVblM2ShOJLob04RtjYxUGCRV5LHSHyVj2VeZvQx7cZLbtNdgTd92UD/0=
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr3315954ili.239.1643305988641;
 Thu, 27 Jan 2022 09:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20220113180308.15610-1-mike.kravetz@oracle.com> <b476e461-aba9-e92b-d392-270029ab6b18@redhat.com>
In-Reply-To: <b476e461-aba9-e92b-d392-270029ab6b18@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 27 Jan 2022 09:52:32 -0800
Message-ID: <CAJHvVciKkrumi=WZE=NoQ1PYdYnu-UCV037HSTg_nUDDBe_gow@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add hugetlb MADV_DONTNEED support
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 3:57 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 13.01.22 19:03, Mike Kravetz wrote:
> > Userfaultfd selftests for hugetlb does not perform UFFD_EVENT_REMAP
> > testing.  However, mremap support was recently added in commit
> > 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed
> > vma").  While attempting to enable mremap support in the test, it was
> > discovered that the mremap test indirectly depends on MADV_DONTNEED.
> >
> > hugetlb does not support MADV_DONTNEED.  However, the only thing
> > preventing support is a check in can_madv_lru_vma().  Simply removing
> > the check will enable support.
> >
> > This is sent as a RFC because there is no existing use case calling
> > for hugetlb MADV_DONTNEED support except possibly the userfaultfd test.
> > However, adding support makes sense as it is fairly trivial and brings
> > hugetlb functionality more in line with 'normal' memory.
> >
>
> Just a note:
>
> QEMU doesn't use huge anonymous memory directly (MAP_ANON | MAP_HUGE...)
> but instead always goes either via hugetlbfs or via memfd.
>
> For MAP_PRIVATE hugetlb mappings, fallocate(FALLOC_FL_PUNCH_HOLE) seems
> to get the job done (IOW: also discards private anon pages). See the
> comments in the QEMU code below. I remember that that is somewhat
> inconsistent. For ordinary MAP_PRIVATE mapped files I remember that we
> always need fallocate(FALLOC_FL_PUNCH_HOLE) + madvise(QEMU_MADV_DONTNEED)
> to make sure
>
> a) All file pages are removed
> b) All private anon pages are removed
>
> IIRC hugetlbfs really is different in that regard, but maybe other fs
> behave similarly.
>
> That's why QEMU was able to live for now without MADV_DONTNEED support
> for hugetlbfs and most probably won't ever need it.

Agreed, all of the production use cases I'm aware of use hugetlbfs,
not MAP_HUGE...

But, I would say this is convenient for testing purposes. It's
slightly more convenient to not have to mount hugetlbfs / perform the
associated setup for tests.

Perhaps that's only a small motivation for enabling this, but then
again Mike's patch to do so is likewise very small. :)


>
>
> ...
>        /* The logic here is messy;
>          *    madvise DONTNEED fails for hugepages
>          *    fallocate works on hugepages and shmem
>          *    shared anonymous memory requires madvise REMOVE
>          */
>         need_madvise = (rb->page_size == qemu_host_page_size);
>         need_fallocate = rb->fd != -1;
>         if (need_fallocate) {
>             /* For a file, this causes the area of the file to be zero'd
>              * if read, and for hugetlbfs also causes it to be unmapped
>              * so a userfault will trigger.
>              */
> #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>                             start, length);
>             if (ret) {
>                 ret = -errno;
>                 error_report("ram_block_discard_range: Failed to fallocate "
>                              "%s:%" PRIx64 " +%zx (%d)",
>                              rb->idstr, start, length, ret);
>                 goto err;
>             }
> #else
>             ret = -ENOSYS;
>             error_report("ram_block_discard_range: fallocate not available/file"
>                          "%s:%" PRIx64 " +%zx (%d)",
>                          rb->idstr, start, length, ret);
>             goto err;
> #endif
>         }
>         if (need_madvise) {
>             /* For normal RAM this causes it to be unmapped,
>              * for shared memory it causes the local mapping to disappear
>              * and to fall back on the file contents (which we just
>              * fallocate'd away).
>              */
> #if defined(CONFIG_MADVISE)
>             if (qemu_ram_is_shared(rb) && rb->fd < 0) {
>                 ret = madvise(host_startaddr, length, QEMU_MADV_REMOVE);
>             } else {
>                 ret = madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
>             }
>             if (ret) {
>                 ret = -errno;
>                 error_report("ram_block_discard_range: Failed to discard range "
>                              "%s:%" PRIx64 " +%zx (%d)",
>                              rb->idstr, start, length, ret);
>                 goto err;
>             }
> #else
> ...
>
> --
> Thanks,
>
> David / dhildenb
>
