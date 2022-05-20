Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A332952EE72
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350455AbiETOsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350459AbiETOsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:48:21 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BB21737F1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:48:00 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id 90so3076134uam.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TdE6K5mZnMzfi0LF9qaS0eQuKIQMNnhmY0eqSGQAtho=;
        b=mUUGhPjn5fYL8N//HRUtYG1NSgB+aEK0JW6CWta7a81zxnc8/Qrf1FvIF8u+x3rvTL
         iuaLSaiAd/xVdL8qYJexNCJJpEhs38roYttyPZG418V8yFOkzV3i69Ft/onbcISB7P8l
         K75gO8RRcDmEyIxncusiC4YAa7blx1oPbF323/t7XC4HgcW9v+tYE4Kxw2Faa4wVKPUN
         VfktW63jbnJrFdkIrXHIT6fcSlQ2EbT7aL8n1epYNy1RzCeJDps/qnmIsF4DDT70ipaN
         I4YpVwsIkmDo+3Rj8aQi5hiBiym5zHTz8boJrA1e+iwmi7ITT6R6mQMfal+wcJVBeeWf
         FeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TdE6K5mZnMzfi0LF9qaS0eQuKIQMNnhmY0eqSGQAtho=;
        b=dddb0yJR6od7xzQxP2fc5SIgIvrKcb/+bWGRsAmR34gPZu1eEnlqm/EUGf7CNmmjfe
         Wfl47lSlXmdBNDJSgnE58rjXqT/SHz+ayIUCVnoJnnLxC0x0hnp7cDfoPvNSjP15nccW
         j5YGGx1hziaP0Z9Qs1/bM4litZGXkLj9Rs7D5H3+nEl4SrpeYkrHpQfNKA+xAkMOEoqr
         4slJWAvGB1onFhi9LMX6/J+PW9/k6RbTVMqn3s1EHCdV4gKnSzX5ety+nzFFZDREGPHw
         u5keGcx+N0KJQlRAR4V5WOJ/3cVCsk6Ic5Nlu5acQIqsGmsJnd+avYVeYvKIvgNJ0q6P
         ibZQ==
X-Gm-Message-State: AOAM530htrXxeogepV/55rPACUrQ5PDZU7CH0LIzGjLx9BtqsY1GiYsi
        Vq9l9NNOEGL2HKgei2xuI94PEWDaMUjPr2RORk0=
X-Google-Smtp-Source: ABdhPJywXx59CylkCISwiul4iQPc9BAVpifpqYl1j0iUV215cgLjUETS/cTOj+NSAoh7PLPB4Xk6375lsxP+vKjYdm8=
X-Received: by 2002:ab0:614a:0:b0:368:bf32:5b37 with SMTP id
 w10-20020ab0614a000000b00368bf325b37mr4158060uan.30.1653058079775; Fri, 20
 May 2022 07:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220516125405.1675-1-matenajakub@gmail.com> <20220516125405.1675-3-matenajakub@gmail.com>
 <20220520134124.6glbfzhrgzutfor6@box.shutemov.name>
In-Reply-To: <20220520134124.6glbfzhrgzutfor6@box.shutemov.name>
From:   =?UTF-8?Q?Jakub_Mat=C4=9Bna?= <matenajakub@gmail.com>
Date:   Fri, 20 May 2022 16:48:08 +0200
Message-ID: <CABsDyaJojLh0Hf2X4u44UpD_7P+eghjq9+Ogf=7f4HjAMq9KWg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/6] [PATCH 2/6] mm: add merging after mremap resize
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, Liam Howlett <liam.howlett@oracle.com>,
        Hugh Dickins <hughd@google.com>, riel@surriel.com,
        rostedt@goodmis.org, peterz@infradead.org, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 3:39 PM Kirill A. Shutemov <kirill@shutemov.name> w=
rote:
>
> On Mon, May 16, 2022 at 02:54:01PM +0200, Jakub Mat=C4=9Bna wrote:
> > When mremap call results in expansion, it might be possible to merge th=
e
> > VMA with the next VMA which might become adjacent. This patch adds
> > vma_merge call after the expansion is done to try and merge.
> >
> > Signed-off-by: Jakub Mat=C4=9Bna <matenajakub@gmail.com>
> > ---
> >  mm/mremap.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 303d3290b938..75cda854ec58 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -9,6 +9,7 @@
> >   */
> >
> >  #include <linux/mm.h>
> > +#include <linux/mm_inline.h>
> >  #include <linux/hugetlb.h>
> >  #include <linux/shm.h>
> >  #include <linux/ksm.h>
> > @@ -1022,8 +1023,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, uns=
igned long, old_len,
> >                               }
> >                       }
> >
> > -                     if (vma_adjust(vma, vma->vm_start, addr + new_len=
,
> > -                                    vma->vm_pgoff, NULL)) {
> > +                     if (!vma_merge(mm, vma, addr + old_len, addr + ne=
w_len,
> > +                                     vma->vm_flags, vma->anon_vma, vma=
->vm_file,
> > +                                     vma->vm_pgoff + (old_len >> PAGE_=
SHIFT), vma_policy(vma),
> > +                                     vma->vm_userfaultfd_ctx, anon_vma=
_name(vma))) {
>
> Hm. Don't you need to update 'vma' with result of vma_merge()?
>
> 'vma' is used below the point and IIUC it can be use-after-free.
>

Actually, this merge call is always either case 1 or 2 as they are
defined in the vma_merge(). So, either way the 'vma' can absorb its
neighbors but never gets absorbed itself.
But you are right and I will add the update, because otherwise it
would depend on the vma_merge() implementation, which could possibly
change in the future and cause a bug.

> --
>  Kirill A. Shutemov
