Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3303A538A51
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbiEaEIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiEaEIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:08:45 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78969562D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 21:08:43 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id d132so5722295vke.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 21:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQayHW7nNYqOEQz5hmBB6KPJg2gTvXgiY+h7JV2fOkA=;
        b=AhkwopzBYexwfn2wdNQMPMJvXNbZpx/ruTfmIJ9yD2VsaE1ZYWfX9bpQJzLLHU5F0c
         YegBb8BGCgPCOeSzLkcePOhvRMLjcQ4iwM86+QsGvjf/QeCOFb7YeXDW6oVuoNxPWmX4
         SuJSUpFZ74ab/Xw/MVYfwX0m/IelcBcAOFrEr32HW51K9Qi+HOdzT+2A6sA79em+2g+B
         0Ra12QVgC16zwJqqaZeJB0R+S2PHg4WyMF71Usm+EjWRTuGMeVgo9+4RlTIw0giMTPe2
         /LLbW0OlcgzsOkfmHQc5GsFGYIJnbAMMcH16tlLTjc782HDRRhklxnUoLIBrpd1oyc1P
         kB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQayHW7nNYqOEQz5hmBB6KPJg2gTvXgiY+h7JV2fOkA=;
        b=OP7QxuAEAUpvKPUB9hDDuDrpxMDoJoeriNzIOK5RvpGqosMXI2VZJvEAw+G+ABLfis
         72w3ZnHMT4pwK5cIF/xdWx/5l4S9ec6HNOz0IjTkKRWvx2bO8PDQeQqYbqgWstJIXhe+
         HtEDAYUAE9E7Ca8Wxa/jsrRR5vf84W2meVRBOES25GAwIjlWy7Su/52iGuiDB1dEqBrA
         umjwwmgrVJ8yE0CbgDRo5je9K/eGpNrGsCYPwBNi2+lY9k4Rgywe69UqEKgDmyx6vJVi
         pqcozXcHaXjvS1e8wU9WKPTQ3Il+GnuEnIy+ZLmH204NoGF1v5nA1iJ0A7rOKlRZztsJ
         h1YQ==
X-Gm-Message-State: AOAM531PJ3IW1Na/Li9fOi6Gvu2mDQCQrqaFP0FJ3TdWpR/LE1qEqUax
        fLrPPmBqUrKmmiifAjdW5ylD83Bz5qTBg8yoTgSjhQ==
X-Google-Smtp-Source: ABdhPJw95u2k3azfz3MpOt9MeKzDgrOacpezxikhMNtQ5znHiZNuct59dPoCLpIWEyjPgIdqi0Y7Z8P/sEm2Xl8Akvc=
X-Received: by 2002:a05:6122:7ca:b0:35c:966b:8729 with SMTP id
 l10-20020a05612207ca00b0035c966b8729mr2534363vkr.27.1653970122433; Mon, 30
 May 2022 21:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
 <Yo/I3oLkd9OU0ice@xz-m1.local> <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
 <0d266c61-605d-ce0c-4274-b0c7e10f845a@redhat.com> <4b0c3e37-b882-681a-36fc-16cee7e1fff0@bytedance.com>
 <YpTngZ5Qr0KIvL0H@xz-m1.local>
In-Reply-To: <YpTngZ5Qr0KIvL0H@xz-m1.local>
From:   Jue Wang <juew@google.com>
Date:   Mon, 30 May 2022 21:08:31 -0700
Message-ID: <CAPcxDJ5UMfpys8KyLQVnkV9BPO1vaubxbhc7f4XC_TdNO7jr7g@mail.gmail.com>
Subject: Re: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
To:     Peter Xu <peterx@redhat.com>, zhenwei pi <pizhenwei@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, jasowang@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, mst@redhat.com,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 8:49 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, May 30, 2022 at 07:33:35PM +0800, zhenwei pi wrote:
> > A VM uses RAM of 2M huge page. Once a MCE(@HVAy in [HVAx,HVAz)) occurs, the
> > 2M([HVAx,HVAz)) of hypervisor becomes unaccessible, but the guest poisons 4K
> > (@GPAy in [GPAx, GPAz)) only, it may hit another 511 MCE ([GPAx, GPAz)
> > except GPAy). This is the worse case, so I want to add
> >  '__le32 corrupted_pages' in struct virtio_balloon_config, it is used in the
> > next step: reporting 512 * 4K 'corrupted_pages' to the guest, the guest has
> > a chance to isolate the other 511 pages ahead of time. And the guest
> > actually loses 2M, fixing 512*4K seems to help significantly.
>
> It sounds hackish to teach a virtio device to assume one page will always
> be poisoned in huge page granule.  That's only a limitation to host kernel
> not virtio itself.
>
> E.g. there're upstream effort ongoing with enabling doublemap on hugetlbfs
> pages so hugetlb pages can be mapped in 4k with it.  It provides potential
> possibility to do page poisoning with huge pages in 4k too.  When that'll
> be ready the assumption can go away, and that does sound like a better
> approach towards this problem.

+1.

A hypervisor should always strive to minimize the guest memory loss.

The HugeTLB double mapping enlightened memory poisoning behavior (only
poison 4K out of a 2MB huge page and 4K in guest) is a much better
solution here. To be completely transparent, it's not _strictly_
required to poison the page (whatever the granularity it is) on the
host side, as long as the following are true:

1. A hypervisor can emulate the _minimized_ (e.g., 4K) the poison to the guest.
2. The host page with the UC error is "isolated" (could be PG_HWPOISON
or in some other way) and prevented from being reused by other
processes.

For #2, PG_HWPOISON and HugeTLB double mapping enlightened memory
poisoning is a good solution.

>
> >
> > >
> > > I assume when talking about "the performance memory drops a lot", you
> > > imply that this patch set can mitigate that performance drop?
> > >
> > > But why do you see a performance drop? Because we might lose some
> > > possible THP candidates (in the host or the guest) and you want to plug
> > > does holes? I assume you'll see a performance drop simply because
> > > poisoning memory is expensive, including migrating pages around on CE.
> > >
> > > If you have some numbers to share, especially before/after this change,
> > > that would be great.
> > >
> >
> > The CE storm leads 2 problems I have even seen:
> > 1, the memory bandwidth slows down to 10%~20%, and the cycles per
> > instruction of CPU increases a lot.
> > 2, the THR (/proc/interrupts) interrupts frequently, the CPU has to use a
> > lot time to handle IRQ.
>
> Totally no good knowledge on CMCI, but if 2) is true then I'm wondering
> whether it's necessary to handle the interrupts that frequently.  When I
> was reading the Intel CMCI vector handler I stumbled over this comment:
>
> /*
>  * The interrupt handler. This is called on every event.
>  * Just call the poller directly to log any events.
>  * This could in theory increase the threshold under high load,
>  * but doesn't for now.
>  */
> static void intel_threshold_interrupt(void)
>
> I think that matches with what I was thinking..  I mean for 2) not sure
> whether it can be seen as a CMCI problem and potentially can be optimized
> by adjust the cmci threshold dynamically.

The CE storm caused performance drop is caused by the extra cycles
spent by the ECC steps in memory controller, not in CMCI handling.
This is observed in the Google fleet as well. A good solution is to
monitor the CE rate closely in user space via /dev/mcelog and migrate
all VMs to another host once the CE rate exceeds some threshold.

CMCI is a _background_ interrupt that is not handled in the process
execution context and its handler is setup to switch to poll (1 / 5
min) mode if there are more than ~ a dozen CEs reported via CMCI per
second.
>
> --
> Peter Xu
>
