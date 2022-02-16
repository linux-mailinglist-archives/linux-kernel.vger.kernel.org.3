Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1EA4B8073
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiBPGRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:17:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiBPGRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:17:04 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD363C9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:16:51 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 124so2912201ybn.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fj0gD7ulTBZq25O5ipO8sbzaZnByNFYzTOaIrem2GJI=;
        b=v/JgsETLxe0/hm/AA5GsACF8WbkW5lYlBICmSCPBJRwkdphqlFcGSU4zn7Uia3n8l8
         ChzEAUcPZ8tPWX133x+zQZ8B+u5NtXXDbp7FYSXcEv7HM5SI2nn3hfgt3lVy6mXrYbwB
         8RvU1KZw+re5hvp27VM8b4Sp8KuYugX2l3Eqg9B3Oc5fd8+SjF7zzRi51zscms/4Ap+O
         crduJSOlnNUMP1ARucXq1AXRo3bF1P4ntDGqJW6JqO11TK/+ldRM31w5a5NLQQDcVyTE
         LhLIHUUFBR/J/s7Uk7MF3Bf1nGumQ+tDNUD7qv/oMVJ/PP/uz0quLcmV9DRfKouQxVhq
         /XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fj0gD7ulTBZq25O5ipO8sbzaZnByNFYzTOaIrem2GJI=;
        b=nQ32f3Trmd7wPPLJEvHVCt2rL9PDbOXrPapNI/lj9Qun7drJUbUUWyjBZGfUofrerR
         vJnl5l+M2AMDVQgBVYVxbT2p6MzRPp5a8ngDb/rDkEO2i64XPW/lDpIpE0PcPFpS+r6I
         pz1BL/x1jYxqFWyzB3hMVWSNmuiMYhzDDpRTrr1mFXuMT7tVKiNTUr36x3qi6Pt0wyDN
         HAyUjSDv1MSIkThFzkZvRD2OqnQFFlloKj0kkWfeyQVfZ5BZqyvB9nQ7y/s46al73nbI
         pIkzNvkD7KsqYnicrt4y2etKXYPaK55R2ZLHWl8y+j4SllTz2gwKkwoVBl0qvwpOgSd/
         5VCg==
X-Gm-Message-State: AOAM530RVpYTVsKRxz8O+ISkWDOgr2PG7ACP2Hxamn6xi/1xt779OU9r
        Dmr5bZvFES/7u3Imp/2opp+HmQcr3wLQUeAWDa5Jpw==
X-Google-Smtp-Source: ABdhPJzX2bajWAwxTro869+zweYxCrKF4uoJ8QpyUAt4H2OSUROm/o52wbTCM4bT6j0jOd2XreydTzdDFgOhQz8gl1w=
X-Received: by 2002:a25:d145:0:b0:611:c6ef:7c0d with SMTP id
 i66-20020a25d145000000b00611c6ef7c0dmr830341ybg.703.1644992210451; Tue, 15
 Feb 2022 22:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20220210123058.79206-1-songmuchun@bytedance.com>
 <20220210123058.79206-6-songmuchun@bytedance.com> <39ab53c4-cb2f-82f4-1097-65d000284b23@oracle.com>
In-Reply-To: <39ab53c4-cb2f-82f4-1097-65d000284b23@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Feb 2022 14:16:13 +0800
Message-ID: <CAMZfGtVQYvqNcNLggUdnbL9oDuYgPhA40caTV2afwmtSgzJCRg@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] mm: shmem: fix missing cache flush in shmem_mfill_atomic_pte()
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, zi.yan@cs.rutgers.edu,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Lars Persson <lars.persson@axis.com>, Zi Yan <ziy@nvidia.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 3:12 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/10/22 04:30, Muchun Song wrote:
> > The userfaultfd calls shmem_mfill_atomic_pte() which does not do any
> > cache flushing for the target page.  Then the target page will be mapped
> > to the user space with a different address (user address), which might
> > have an alias issue with the kernel address used to copy the data from the
> > user to.  Insert flush_dcache_page() in non-zero-page case.  And replace
> > clear_highpage() with clear_user_highpage() which already considers
> > the cache maintenance.
> >
> > Fixes: 8d1039634206 ("userfaultfd: shmem: add shmem_mfill_zeropage_pte for userfaultfd support")
> > Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/shmem.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Thanks,
>
> It might have been better to combine this and the next patch.  When looking
> at this, I noted the 'fallback to copy_from_user outside mmap_lock' case needs
> to be addressed as well.  It is in the next patch.  No need to change.

I separate those changes into 2 patches since the fixed patch
is different. This patch is fixing linux 4.13 and later, while next
patch is fixing linux 4.2 and later. Maybe it is hard to backport
if combining those two patches.

>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks Mike.
