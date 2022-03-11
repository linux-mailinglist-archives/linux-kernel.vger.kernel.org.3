Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92D4D5C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347152AbiCKHZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242146AbiCKHZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:25:19 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E487B1B60A5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:24:15 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id l2so15561858ybe.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcSIpjSWLhRrlsmQ73YhW910e9trxsztOOdRdWeu+CM=;
        b=DFLmC0sR8O0uNQmc+1zmAeHAvecET0WlDEJnBSKoVFCvkv3cBpuO5WuhVbfB4PxBD1
         ehKR5Dr5xJd4bFYYxUH7U7XMBKmU8rVNjA5dP8bxPIvt+9Xn023rIdzys+Tf1zkgMNIM
         u8Nizo4CdA3QOXfRVdWADCNsO6NDLaFrOBozkSRB6k1RZ7CZxbAh72CPyFUjp5XG+hhW
         43d/dB7B9OSQxh//G4dqCoQj3nbbJBNDPlhXXadcNob9/KocXGMBubjd8bXDQdSSMSV4
         OX41CNxCWNU75dqRaRgbTVS4Jr2kXpcRd5bihFDevGfrlDMr0hjl67lFU23W5cGbSsw3
         RwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcSIpjSWLhRrlsmQ73YhW910e9trxsztOOdRdWeu+CM=;
        b=oSGXY/abR+KtjY9zX6aXFFplKC1OsTaHQ2yQ4MxIefWxD7VLSNS7bb13pgicBhL62K
         CWb7XULNs7FihdGpPiXPk/veZQmmTJmqeE/a44O/0CybFFxx7XghOz9g7eX7sB5+e+m0
         PRLRBJi8+CcKLEjZqhEPjnabAmHNvcUy0/FgcyBstgSTYkn7H/9UOaPV3LhZNAuDmXsb
         rhZu5TVt2/Ecx4e5wGtrN23g+7nF04FwgjMaTZWFzvIVyKwoRb5y1mPMB4ctLb7W9kOc
         WMZCRH+BBIX4awryNGoFCOy4pXsgSb24cLx+1ZUdZqITUSy9pKE2SVM+KSwsGxyH7tmT
         RRcg==
X-Gm-Message-State: AOAM5336bLxm5m/Hh8sXCNdsopvC4b5ExRBTYvw/IueBkW6XPvP0WP66
        NkYiRXMOXOFLWUmILqGs3yDDtxJIKSIL2y2whVLAYA==
X-Google-Smtp-Source: ABdhPJxtqLKdhvvwiS5rMHsZrRQUvSdu4UvCC24UiLt2rPUxgxcqOAsceLK3Em3mxZXVMmXs5iN0M+fF7P3DwGHZ+yY=
X-Received: by 2002:a25:d188:0:b0:628:ba86:ee68 with SMTP id
 i130-20020a25d188000000b00628ba86ee68mr6854831ybg.427.1646983455057; Thu, 10
 Mar 2022 23:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20220307130708.58771-1-songmuchun@bytedance.com>
 <20220307130708.58771-2-songmuchun@bytedance.com> <YiY0QkE+efo1hyda@bombadil.infradead.org>
 <CAMZfGtWHZgvFSE0P1LNprcjt0YAvC5XFAz=aUZw9vJFPGzUTbw@mail.gmail.com> <YipuORuIdxq89Lqg@bombadil.infradead.org>
In-Reply-To: <YipuORuIdxq89Lqg@bombadil.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Mar 2022 15:22:29 +0800
Message-ID: <CAMZfGtUybuDSnwQKos7A9zB=WQc_avrFK0eZo3bgeD7tnWzf3Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm: hugetlb: disable freeing vmemmap pages when
 struct page crosses page boundaries
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 5:31 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Mar 08, 2022 at 01:03:08AM +0800, Muchun Song wrote:
> > On Tue, Mar 8, 2022 at 12:35 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Mon, Mar 07, 2022 at 09:07:05PM +0800, Muchun Song wrote:
> > > > If the size of "struct page" is not the power of two and this
> > > > feature is enabled, then the vmemmap pages of HugeTLB will be
> > > > corrupted after remapping (panic is about to happen in theory).
> > >
> > > Huh what? If a panic is possible best we prevent this in kconfig
> > > all together. I'd instead just put some work into this instead of
> > > adding all this run time hacks.
> >
> > If the size of `struct page` is not power of 2, then those lines added
> > by this patch will be optimized away by the compiler, therefore there
> > is going to be no extra overhead to detect this.
> >
> > >
> > > Can you try to add kconfig magic to detect if a PAGE_SIZE is PO2?
> > >
> >
> > I agree with you that it is better if we can move this check
> > into Kconfig. I tried this a few months ago. It is not easy to
> > do this. How to check if a `struct page size` is PO2 in
> > Kconfig? If you have any thoughts please let me know.
>
> Can you query this with a script?
>
> config HAS_PAGE_SIZE_PO2
>         bool
>         default $(shell, scripts/check_po2_page_size.sh arguments_are_allowed)
>

Excellent. I'll try this approach.

Thanks very much.
