Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3032F54D634
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347845AbiFPAkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiFPAkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:40:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8061356436
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:40:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so327846pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcCZJRFbxoGfTo67jDtrqKzufdCi7UaSWExZ0v8GNEk=;
        b=gURvnx+CVl2L0EGZLNhdn/9OuS0m/MN87cPWESlDah6rtJWmVeciSvCkf24xk2R/Yw
         OWI8cx+W+Khdmab8KJYJKfLGw3kB68I50AmT7pUgSuVdERhrOcbOFiDHJPxQKvsdMKpU
         yuM5e6mKguZn/8hFr7yJI9laC+isA4pbE8eN+l2laIVJXOqRqSfaA4giTCnLlCsAT2uf
         BMjKenCuUBfz4+riVR3XeGfbC2r6gzIXUTigxdX2rPOxoI6iSWvU5OYvv2v/jF2qZFFf
         /jE20GO0x66MJtlvKIIm6akFDcnvZR/Dtb5woGJ8pqb99WS1qyojFkiktzL4/78j5RuK
         paeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcCZJRFbxoGfTo67jDtrqKzufdCi7UaSWExZ0v8GNEk=;
        b=v9MllG4dP+Pl0DC286ZgpJOQ7uIMzQRaWnXnpYbnLP//o2burHojisbf/RNmQUTuC1
         VFeI5nVFB0e251S7/D2l6HdGoM7xcC3LyOqAf3Ntl9nqnv79IhRB8nX5DWOJMx7DGwRe
         x4qv5i/rZQxxsAvCZvyICe22rUwV5f4GuhcZDBC+lJ8+Ry6lot8cyTNp2hk1ZBfQk+4S
         lHFKfld+XDiaNiabowcPZVa6iao/9OYHuuDPyaC5vosxgvGcD3JwKZoR2A/ukN5Sd8uS
         529gj4MbILNlB1GSr3DT5/wRRVVK0+NXQRmLMVPvwN4+z1msPDABGT6FX/Drb1tawX0+
         YkHw==
X-Gm-Message-State: AJIora9xZDsDMcgGJOmmOBRQMBUpABb4NKld5qxQVMiq9ICD61paF8tS
        yLBG8LpkqssHZov5Ea8jHbDIAIdktujrBTjkndM=
X-Google-Smtp-Source: AGRyM1siKTF+R6uwKfazYTe8Xg0CPDF5bbBzf4TfDdTqgC6WGqwqg8SFY/Ka4131n5yVpTRaPbDml7n64VDQF6Cj8L8=
X-Received: by 2002:a17:90a:de15:b0:1df:63dd:9cfc with SMTP id
 m21-20020a17090ade1500b001df63dd9cfcmr2227079pjv.200.1655340036096; Wed, 15
 Jun 2022 17:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220611022314.21593-1-linmiaohe@huawei.com> <8b34a515-e5fd-731a-4164-9080c275d4e9@google.com>
 <7c363619-4159-8a21-d55a-535e21b5c8b4@arm.com>
In-Reply-To: <7c363619-4159-8a21-d55a-535e21b5c8b4@arm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Jun 2022 17:40:23 -0700
Message-ID: <CAHbLzkq=M=yMj-w95R5uCy_YqELRJhdKPjZ=qR5Ticacve8b-g@mail.gmail.com>
Subject: Re: [PATCH] mm/shmem.c: use helper transhuge_vma_enabled()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Hugh Dickins <hughd@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:02 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 6/11/22 08:44, Hugh Dickins wrote:
> > On Sat, 11 Jun 2022, Miaohe Lin wrote:
> >
> >> Use helper transhuge_vma_enabled() to check whether transhuge is enable
> >> on vma. Minor readability improvement.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >
> > No thanks, that's a readability regression, forcing reader
> > to go and look up what transhuge_vma_enabled() actually means.
> >
> > What you call a helper, I call an obfuscator - as I implied in
> > b9e2faaf6fa0 ("huge tmpfs: revert shmem's use of transhuge_vma_enabled()")
>
> The same reasoning should also be applicable for other calls sites
> for transhuge_vma_enabled(). Should not they be dropped as well ?

Yes, the only caller was hugepage_vma_check(). It was changed to
open-code and the helper was removed by series:
https://lore.kernel.org/linux-mm/20220615172926.546974-1-shy828301@gmail.com/T/#m7610c2a4e5dda753cbc850986d5486f59a821c1a

>
> >
> > Hugh
> >
> >> ---
> >>  mm/shmem.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/mm/shmem.c b/mm/shmem.c
> >> index 133c67057d41..59cc2e980c95 100644
> >> --- a/mm/shmem.c
> >> +++ b/mm/shmem.c
> >> @@ -480,8 +480,7 @@ bool shmem_is_huge(struct vm_area_struct *vma,
> >>              return false;
> >>      if (shmem_huge == SHMEM_HUGE_DENY)
> >>              return false;
> >> -    if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
> >> -        test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
> >> +    if (vma && !transhuge_vma_enabled(vma, vma->vm_flags))
> >>              return false;
> >>      if (shmem_huge == SHMEM_HUGE_FORCE)
> >>              return true;
> >> --
> >> 2.23.0
> >
>
