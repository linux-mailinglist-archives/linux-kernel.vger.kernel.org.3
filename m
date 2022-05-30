Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5556C537973
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiE3Kwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiE3Kwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:52:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BEB63E5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:52:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i1so9999119plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w5gFWEUTN7CvTurw5Y71IzdCPoiI5JyLb8TnHFiO65M=;
        b=RB/I9ZJt9qT+WGHamOng75ciihaHBSnNkNWb9SsVr6ZsdVffqeX85J0RMI6w9eQ6Y7
         Cno4yv3Xw36n7AzBvSY0qiomAX/Hq9Cn34xffsRhlI3pDEMU+jYuvQCN8wdmUU7bz0A1
         iRZb9QBH2DMB2QZOng4W09ddthAtBQxSWVSlL1wR4ul6wOCBWifExdS7Jh8Jg/7Fv9tA
         d5WAktJPbO5FvLf7wa2voJnp5mOgEQ/a0Pl0yqBx6SsBFLqm1F8HhWfsgCwBx8AYKGbA
         aMfVoA74ZP7H5V0XU10kxrA9OHQCza6AtweAO1uNeOA34wGO9wXTwTo+6f5JNeWdzZf4
         V9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w5gFWEUTN7CvTurw5Y71IzdCPoiI5JyLb8TnHFiO65M=;
        b=ewkdZNt2COwj1Z1BegWtXYYgaILLyzOs/7sOwHPNrM2oB1zABqqPrDZV5EAsD82YwX
         pSzTpPLFGZieAPArjkMzstBr/BilxDOMYPdR9X0LiERG/NyBzd7yQATx6vrCjGy6ERP9
         QMQfFgA2uuwwmYAasbfNju7Js/O6D9DBIFMi8RlWxk1PQgCysUy9Zz0xtSmA5HgUgIQg
         UnZwSCDFAsM+Bvc9+GJCIH/2JdUsFsEHNhe1fYy21ORK886bCdoj7n3qP1icg3UDoD4i
         JuVdHZmFbwxY5gRA60d8ZJ4SfopNvnp9fAkerA5u0EMhYale5lsPx/MVf54aVF0536De
         ZKmQ==
X-Gm-Message-State: AOAM530Vaf1LsEMluRKwM/BgjgLNxTZqMohWLNcM2J0x513f/Sp4Rk2Z
        sm7FRdhFLligGPB0xnJwfOiIk354sNpcw7rwLeI=
X-Google-Smtp-Source: ABdhPJwvimXOSym9fwJtWssibynEoIBVc9qaJYoOEUWn8MRWDS91hkQCQndiDo06egA95PE6mn+DTT3MkuXwFZr1MFg=
X-Received: by 2002:a17:902:b581:b0:161:5f37:6688 with SMTP id
 a1-20020a170902b58100b001615f376688mr55489176pls.145.1653907971898; Mon, 30
 May 2022 03:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220527104810.24736-1-matenajakub@gmail.com> <20220527104810.24736-3-matenajakub@gmail.com>
 <20220527234657.nsn6e7jjwttblzyi@box.shutemov.name>
In-Reply-To: <20220527234657.nsn6e7jjwttblzyi@box.shutemov.name>
From:   =?UTF-8?Q?Jakub_Mat=C4=9Bna?= <matenajakub@gmail.com>
Date:   Mon, 30 May 2022 12:53:08 +0200
Message-ID: <CABsDyaKNkiucxW_MDkssfGrTty1YTVH53BBybLaWOye20AGFag@mail.gmail.com>
Subject: Re: [PATCH 2/2] [PATCH 2/2] mm: add merging after mremap resize
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        Liam Howlett <liam.howlett@oracle.com>,
        Hugh Dickins <hughd@google.com>, riel@surriel.com,
        rostedt@goodmis.org, peterz@infradead.org
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

On Sat, May 28, 2022 at 1:45 AM Kirill A. Shutemov <kirill@shutemov.name> w=
rote:
>
> On Fri, May 27, 2022 at 12:48:10PM +0200, Jakub Mat=C4=9Bna wrote:
> > When mremap call results in expansion, it might be possible to merge th=
e
> > VMA with the next VMA which might become adjacent. This patch adds
> > vma_merge call after the expansion is done to try and merge.
> >
> > Signed-off-by: Jakub Mat=C4=9Bna <matenajakub@gmail.com>
> > ---
> >  mm/mremap.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 303d3290b938..c41237e62156 100644
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
> > @@ -1022,8 +1023,11 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, uns=
igned long, old_len,
> >                               }
> >                       }
> >
> > -                     if (vma_adjust(vma, vma->vm_start, addr + new_len=
,
> > -                                    vma->vm_pgoff, NULL)) {
> > +                     vma =3D vma_merge(mm, vma, addr + old_len, addr +=
 new_len,
> > +                                     vma->vm_flags, vma->anon_vma, vma=
->vm_file,
> > +                                     vma->vm_pgoff + (old_len >> PAGE_=
SHIFT), vma_policy(vma),
> > +                                     vma->vm_userfaultfd_ctx, anon_vma=
_name(vma));
>
> The arguement list gets busy. Maybe some variables would help.
> Calculation around vm_pgoff is not obvious and requires some explanation.

Ok, I will add the following comment:

"Function vma_merge() is called on the extension we are adding to the
already existing vma, vma_merge() will merge this extension with the
already existing vma (expand operation itself) and possibly also with
the next vma if it becomes adjacent to the expanded vma and otherwise
compatible."

And I will also introduce three new variables to better explain some
of the arguments:

unsigned long extension_start =3D addr + old_len;
unsigned long extension_end =3D addr + new_len;
pgoff_t extension_pgoff =3D vma->vm_pgoff + (old_len >> PAGE_SHIFT);

>
> > +                     if (!vma) {
> >                               vm_unacct_memory(pages);
> >                               ret =3D -ENOMEM;
> >                               goto out;
> > --
> > 2.35.1
> >
>
> --
>  Kirill A. Shutemov

Jakub Mat=C4=9Bna
