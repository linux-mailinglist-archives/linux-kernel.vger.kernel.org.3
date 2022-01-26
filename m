Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBCF49C9F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbiAZMqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiAZMqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:46:47 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95752C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:46:46 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a8so38671391ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpKbbi8If8FEZ41RpRjGsQUgi5Ly7DPWQgM8YNkUuFM=;
        b=GYV8COX4chqvZKYYDsg1d65DhuqAftl7wfKlqfjE5qaHDkRbOTvD4+3PHXkbcp91h4
         SZVPGemrx/PCrpTY9k2zjkBXxe32gIRJRAPANZB23wK0GYgcqAA9Kt5ZnXECCDIyOgsk
         P/yNaZKYQ/PS9Wu06w2TzSlw6lzPF3hr2y28FQf6a/VTrxtX98H8qZZFwXkG1TVNQpP/
         X2pM5oOcs9UY+z9L9DlMbx9/zgHxFczb97qvuTJXX7zr44QZhvInje1oo3juCyNViJTF
         1Qwlfuflr1gwQN2uVHEx78ue6dKAT+PP6bUCBHWi8PI1SCjOXFMOYHYm7kE2qX47Qnrb
         mCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpKbbi8If8FEZ41RpRjGsQUgi5Ly7DPWQgM8YNkUuFM=;
        b=MPKgu3NG6btL5o6E+NdDkuUisi9fay4H/RSFGYDb8/eY7LGV1tIQ/IBkQxRMM6pGqD
         aseW7L3Kf0b2HZsi/w7iKCOhJd6Fol/2LaaRN+cP1O9lhpOxlLJsa2s0XzpS3NYGKiRX
         z+D0V6tWNstNRYc8uE91LIk2Wm8LnFW3GLUgikVMci1eAFtSJce7lyI5xyJS+PPqzhma
         HlJ3jHolBUqT+aXUys/1ZJ9bz+Scay5nJszzzTi8HRZe8X9ZKyfSI9H/17tbvm0K7ZuH
         +nKpeRfYmdEd6FNuNydMw29mtpWmY+0+9LSemgbjqFm6+1dwZCmkDBsbixd4FjTcvXm+
         Qwwg==
X-Gm-Message-State: AOAM531aBQEmP7qQeGn+0o0CfD768FxNgZkJPdXQbf3vY4z1snKLtNXH
        zbbH+4VIdcO//M0kcGL/UHcKB7lN57agCOfefNWAuQ==
X-Google-Smtp-Source: ABdhPJy0M7qt9u7TnsdhZKRCYYlBSMNAKBXctrLxWBHR1/+AzFPRfNgCRJxyqJfogiWpzIufvsN4yCr7JV23yhJ1jxA=
X-Received: by 2002:a17:907:7d8c:: with SMTP id oz12mr897545ejc.320.1643201205147;
 Wed, 26 Jan 2022 04:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20220126060514.1574935-1-pasha.tatashin@soleen.com>
 <20220126060514.1574935-5-pasha.tatashin@soleen.com> <61833f93-31b5-206f-b8c7-a2e55091ac@google.com>
In-Reply-To: <61833f93-31b5-206f-b8c7-a2e55091ac@google.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 26 Jan 2022 07:46:09 -0500
Message-ID: <CA+CK2bCd6OXW+PEB6NYvAN61xaaPzT5dWr=REidWX1=e1jrNCg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm/page_table_check: check entries at pmd levels
To:     David Rientjes <rientjes@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Turner <pjt@google.com>, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Fusion Future <qydwhotmail@gmail.com>,
        Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 1:45 AM David Rientjes <rientjes@google.com> wrote:
>
> On Wed, 26 Jan 2022, Pasha Tatashin wrote:
>
> > syzbot detected a case where the page table counters were not properly
> > updated.
> >
>
> Is there a Reported-by tag that syzbot wants us to use to track this?

Google internal syzbot found it, so I did not add Reported-by as there
is no  public e-mail to reference. However, I added all the necessary
steps to repro this problem to the cover letter.

>
>
> This looks right, I'm wondering if we want to add a
> mmap_assert_write_locked(mm) to collapse_and_free_pmd().

Good idea, I will add it in the next revision.

Thanks,
Pasha
