Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA646A2A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbhLFRXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbhLFRXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:23:49 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAD3C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 09:20:20 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e11so22220971ljo.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXeiRDIeMgIJ3QlhrfyzJaMD9KCCg6J0jEvMuAkTCAg=;
        b=n6yX3UhTRXg3b9lGwvVCVX4rn2Y6gvzc/AoDJs9+sgugPe/JXs4OpPp1GudS6nytij
         fLoyqjh76fPUmbGUOkCJMRlTpFfgIDjFqPi7picSW4qdW82cvPggGlXv/KiaJAjlJrUX
         LxhQaNhV5DRaK6se7Fsi0nYb2/PccqcjGSxZCGoJGQse01NiU8HfhB0gpPBgZP8SABIg
         /RIK2uIhy0Dtcy/wP5D01hs0BdQSmlGABjOGQmYW/UbTwdQ5AquO2Ufi8PG9s225e0Gi
         B7GhtOG01IVw6IUNsPcY71WSBOFBZSiYjMJV4L/mjgdLvb0ppAUd7pUhCjdQFe8tceRy
         MUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXeiRDIeMgIJ3QlhrfyzJaMD9KCCg6J0jEvMuAkTCAg=;
        b=XhU7C1ZBbBdHrf3WnwByD2g5naUWaQsGl8jE/TUvbdpUcmZaOw4JqqpYTULbQchamE
         5whJAk1Y8ePTnnX0/s9uQ6B3yWxE8n8gNinrBaQchVoznjImQyEZOogV+Y/gpKFkjlh6
         6r1O5WF/8KVtcV34dRXTvv7pyHRTydK2OyxG9nthSQOO5aPVXwlghVoVdftojyXmD5uH
         r/jQe6MBBj12ZFGpctfSkxT7cuU/eJJnXuYv/uQK6Q0vN8UjlSB7E8RBzXCqApVgGeg6
         gRAGsfmyLApNaOJbebxazOLv221tMGWT5UB7EahZyyWmb/3G9+RomjdxkNhqzrWypEra
         APJQ==
X-Gm-Message-State: AOAM532KZ/+muukYbWY6ryEUVa1yln805wck3NH7ouC48sr09gO0AsRO
        jjpJj4M3085KnhUF1NK/f01mBym+EjdxPG5M1086CQ==
X-Google-Smtp-Source: ABdhPJwr5SZss80JbNUaIvuyOAY6SnFRgmU3B+jxsFytYHzPF9bHy4+u8p0cy9CqbtwHcy6LSwVIIt3HFULJoDOtdPk=
X-Received: by 2002:a2e:8895:: with SMTP id k21mr37790527lji.331.1638811218648;
 Mon, 06 Dec 2021 09:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20211205133039.GD33002@xsang-OptiPlex-9020> <56b9d000-8743-52cb-4f10-4d3fa2b30f29@redhat.com>
In-Reply-To: <56b9d000-8743-52cb-4f10-4d3fa2b30f29@redhat.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 6 Dec 2021 09:19:52 -0800
Message-ID: <CALzav=dn-Oe1v9qTp=ag92Kn96JOb3AX9JJA4P5VcLksV8-vLw@mail.gmail.com>
Subject: Re: [KVM] d3750a0923: WARNING:possible_circular_locking_dependency_detected
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kvm@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Janis Schoetterl-Glausch <scgl@linux.vnet.ibm.com>,
        Junaid Shahid <junaids@google.com>,
        Oliver Upton <oupton@google.com>,
        Harish Barathvajasankar <hbarath@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 5, 2021 at 10:55 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 12/5/21 14:30, kernel test robot wrote:
> >
> > Chain exists of:
> >   fs_reclaim --> mmu_notifier_invalidate_range_start --> &(kvm)->mmu_lock
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&(kvm)->mmu_lock);
> >                                lock(mmu_notifier_invalidate_range_start);
> >                                lock(&(kvm)->mmu_lock);
> >   lock(fs_reclaim);
> >
>
> David, this is yours; basically, kvm_mmu_topup_memory_cache must be
> called outside the mmu_lock.

Ah, I see. kvm_arch_mmu_enable_log_dirty_pt_masked is called with
mmu_lock already held. I'll make sure to address this in v1. In theory
this should just go away when I switch away from using split_caches to
Sean's suggestion of allocating under the mmu_lock with reclaim
disabled.
