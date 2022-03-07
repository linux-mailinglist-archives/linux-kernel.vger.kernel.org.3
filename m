Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D534D050A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiCGROq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiCGROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:14:44 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C55888DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:13:49 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id h126so32386807ybc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X79+cMNSS1ZIdonvLOYEw31mZ4UOgIRIrMSuxiLNwqs=;
        b=Nd1UyuTvcWJZhAMUVe66Y3LBQ7krURoXNjJyL9N1qvXxDiuG1apnvlZVaERKYOeZCz
         S9BN14kz7JlilZvwPNsWQnbA+LJfF5CBuSx/lDCI8WaFL53mGzaKOhzw43I3p9HDdSor
         rZx1eKHHxcDsNyNS4+CiXfZNDH66pu3jrXPxA6j0vzr7ygp1CavI6Mn9hRe/R+SufDKn
         p+FMRo6UIuWO+HJ9ZysHVqhNZj8rUrshMFd11UjRHuIJ4+kGto/faPFLutotUvNU4pqV
         TxSIshPyAX6kurMeLjuUv8siLleryoFXojmKuS7fmXDqwgWzCvphiFzaR3GPJN8YxwIC
         3DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X79+cMNSS1ZIdonvLOYEw31mZ4UOgIRIrMSuxiLNwqs=;
        b=4AysCgz5JKxWOnE5fFzVuPSki/xvzZlTZtmvk1L/G7Tu6OQ94lG8VvU+FqRIrLUuy/
         j0D8BJkoLqGH2FbYbqwAUNDan1hT/sRJ/gO8L2P6OGtZ+y1ZXLJCsexpun1iDS3aqp61
         Xzh6+wZDU9z1G2gkwax4kEwaozuzo4YDySQKfHWwaVCpNecPUW+THT8nzJRq9S0WuQEE
         ryfKO98XeNfLZ/hagNqJRrhGWb1E5g5DmZvtILO/NxT+ZMEeUDL61LuhLLwhBNXPMujW
         O2ys4HtsMnQ40WyDDrtzax2LG5Rd9gT0b4ECl/9fVOQL9A/WK63faDVhn8jNzziVK7Sl
         RN/A==
X-Gm-Message-State: AOAM5318dqhZ2wviAcQ7+piZ4phcyDulzEmd4LUjh0VM9ovMhgnMJyO2
        Rm/eALQeer/vrHdclaXThyU825IZU2teNmfOH3azNA==
X-Google-Smtp-Source: ABdhPJwWjHGDU3vKlcY2eVkECJJt/KQSRMof+n3QMrZTHYiiNY/DfKR3JuCdSzZZFz34oLIQv+Fsf2cV4EqROGV7FA0=
X-Received: by 2002:a25:d188:0:b0:628:ba86:ee68 with SMTP id
 i130-20020a25d188000000b00628ba86ee68mr8622549ybg.427.1646673229137; Mon, 07
 Mar 2022 09:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20220307130708.58771-1-songmuchun@bytedance.com>
 <20220307130708.58771-2-songmuchun@bytedance.com> <YiY0QkE+efo1hyda@bombadil.infradead.org>
 <CAMZfGtWHZgvFSE0P1LNprcjt0YAvC5XFAz=aUZw9vJFPGzUTbw@mail.gmail.com>
In-Reply-To: <CAMZfGtWHZgvFSE0P1LNprcjt0YAvC5XFAz=aUZw9vJFPGzUTbw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 8 Mar 2022 01:12:08 +0800
Message-ID: <CAMZfGtWUMLhYtYLNYq8WD5K1YSOegk05vtW4xwLWQcDD7pUJQA@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 1:03 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Tue, Mar 8, 2022 at 12:35 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Mon, Mar 07, 2022 at 09:07:05PM +0800, Muchun Song wrote:
> > > If the size of "struct page" is not the power of two and this
> > > feature is enabled, then the vmemmap pages of HugeTLB will be
> > > corrupted after remapping (panic is about to happen in theory).
> >
> > Huh what? If a panic is possible best we prevent this in kconfig
> > all together. I'd instead just put some work into this instead of
> > adding all this run time hacks.
>
> If the size of `struct page` is not power of 2, then those lines added
> by this patch will be optimized away by the compiler, therefore there
> is going to be no extra overhead to detect this.
>
> >
> > Can you try to add kconfig magic to detect if a PAGE_SIZE is PO2?
> >
>
> I agree with you that it is better if we can move this check
> into Kconfig. I tried this a few months ago. It is not easy to
> do this. How to check if a `struct page size` is PO2 in
> Kconfig? If you have any thoughts please let me know.
>
> Thanks.

Here is a discussion [1] from a few months ago.

[1] https://lore.kernel.org/all/CAMZfGtWfz8DcwKBLdf3j0x9Dt6ZvOd+MvjX6yXrAoKDeXxW95w@mail.gmail.com/
