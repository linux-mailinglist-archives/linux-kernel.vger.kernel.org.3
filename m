Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9A2543F69
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiFHWq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiFHWqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:46:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C03253329;
        Wed,  8 Jun 2022 15:46:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gl15so30303533ejb.4;
        Wed, 08 Jun 2022 15:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGyEQx4XWPendUVIT5iH3jx+IKfbaeExu0R992MzqQc=;
        b=SEfIfZdBf+iUPWQ84Xx/UK3Jih3tLOBZ34JtUVzGUBT4CjLrNly6+yNX1/1WpYx87C
         KEgViwFPHgwDF8NoBf6vNRXlPqDaH+QGJvkPMBJw09vAkse9uLwioPVNGEtkZODqo4n+
         QTdv0rcegiaB4K+bNml3+fDmNnk+vvKHKlKEbtHlMF8Hlctn2gP1MkeMjOR+Mx7uetqc
         T9tKETI/Y/jWheQYaPkYJGY9L+YlFUyuWpCBbTdMNIIqL6SYnTb7nhhfwrH9Kogcnshe
         nwnoSAfOau4l//65+Yvi46YnfaRbeZz7MoJmtYKj58ZUk5f0LxNAtdaaSOaaeonfifrm
         nvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGyEQx4XWPendUVIT5iH3jx+IKfbaeExu0R992MzqQc=;
        b=xlDy2lXLa2buFpBQ4Tb2mXbTjWOOnbIK4vgXnJRpDsXyEWG0QybdGG+Zl5nOPFk6nL
         6XAfb7HBZfW4aVOPYcFQX0IpvMo2lIiNgJ6+mwODJXbQAhhn8n9o72ttC12bx+ODr0Jw
         6F5z544NUrFf89YXH0jPVm8nFQUUIp+zZTvdbYg+EJZFs6v8DA08lzNwhAD0d3AWZSHF
         Z1tj65cQ576mTq6q459iKDcNzzJxPRcBNvJm0XmPLHxVzfB6dWl9QaixGMNOwRqGfzzF
         2gJtsRBFUBF2mLl65qn8iiibbM8b6e+3NdgpVLP7GivxTM5scTxpSgvcw3fJLwn1tzJ5
         Uj2Q==
X-Gm-Message-State: AOAM532qceiaGS+LxnjvRNv6vBniBsxUFqx5BEt4imAM3oXhHstN9sdw
        cOC+GLjIgROd5lwpFAIzo2zydTRzkNmnwdRC4oM=
X-Google-Smtp-Source: ABdhPJycCulqR/dNreJvVX5htaggHlxzrVNrJd1i+/13R78yiSZFXhgCbhoCFawHBoYXeJSOMPhKQmin+waHYgUqL/k=
X-Received: by 2002:a17:907:a0c8:b0:711:d82a:1caa with SMTP id
 hw8-20020a170907a0c800b00711d82a1caamr14138368ejc.702.1654728362854; Wed, 08
 Jun 2022 15:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com> <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
 <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com>
 <20220607102135.GA32448@willie-the-truck> <CAGsJ_4zGEdHDv0ObZ-5y8sFKLO7Y6ZjTsZFs0KvdLwA_-iGJ5A@mail.gmail.com>
 <20220607104358.GA32583@willie-the-truck> <CAOUHufZh46A2hh_fn-8vVBDi_621rgbZq64_afDt8VxrzqJz1g@mail.gmail.com>
 <CAGsJ_4yvsXCj8snemAyX3jPJgWJR+tFCtUhV-3QJ75RNi=q_KA@mail.gmail.com> <CAHk-=wirMfOpzNavjWao5GA65ve=9LQN-6=YCUtJGRpu=ujdoA@mail.gmail.com>
In-Reply-To: <CAHk-=wirMfOpzNavjWao5GA65ve=9LQN-6=YCUtJGRpu=ujdoA@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 9 Jun 2022 10:45:51 +1200
Message-ID: <CAGsJ_4yLCsJJvK5QkFOk_7UW72DRO7gWnd6wdn2TWzBrTmRjSg@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, huzhanyuan@oppo.com
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

On Thu, Jun 9, 2022 at 3:52 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jun 7, 2022 at 5:43 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > Given we used to have a flush for clear pte young in LRU, right now we are
> > moving to nop in almost all cases for the flush unless the address becomes
> > young exactly after look_around and before ptep_clear_flush_young_notify.
> > It means we are actually dropping flush. So the question is,  were we
> > overcautious? we actually don't need the flush at all even without mglru?
>
> We stopped flushing the TLB on A bit clears on x86 back in 2014.
>
> See commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case
> clear the accessed bit instead of flushing the TLB").

This is true for x86, RISC-V, powerpc and S390. but it is not true for
most platforms.

There was an attempt to do the same thing in arm64:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793830.html
but arm64 still sent a nosync tlbi and depent on a deferred to dsb :
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1794484.html

Plus, generic code will also send a tlb flush:
int ptep_clear_flush_young(struct vm_area_struct *vma,
                           unsigned long address, pte_t *ptep)
{
        int young;
        young = ptep_test_and_clear_young(vma, address, ptep);
        if (young)
                flush_tlb_page(vma, address);
        return young;
}

We used to use ptep_test_and_clear_young() only in rmap.c for page_referenced()
in 2.6.0:
https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/tree/mm/rmap.c?h=v2.6.0
int page_referenced(struct page * page)
{
      ...
      if (ptep_test_and_clear_young(p))
      ...
}

but in 2.6.12, it has been already ptep_clear_flush_young() in
page_referenced_one()
https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/tree/mm/rmap.c?h=v2.6.12

I failed to find the history to figure out the motivation for 2.6.12
to use ptep_clear_flush_young()
in LRU, but I am still curious how using flush or not will affect LRU
on those platforms whose
ptep_clear_flush_young() and  ptep_test_and_clear_young() are different.

>
>                Linus

Thanks
Barry
