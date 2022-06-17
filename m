Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522EA54FA47
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382876AbiFQP2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382373AbiFQP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:28:23 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B4F3585D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:28:23 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-317803b61e5so20375397b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a48xYoaImngZlwAokNKt+6RLtl7rqDoLCq/X4qxbRH0=;
        b=bNNK+PbIKT8CKkpoxpziC+W02MjORV2Gv4DmjRzlDqzgiPXk1/ZBmWCGxt0sRDxz/g
         eNeEjmAFCfTmLWtCMsWks8/f4/n74eaSxs9jIEFA4A1ul66IyswOiziFir+wIgaT/DuG
         JmV3WKlNMujJrkNJxbZ5OquOMCa20BeaGLCKmfm3hGTBN0+WSAJWQfEJPXgU0MJKhn1z
         jD3P8unNV5OdR1zKJFsUhZia2BjyUSaH2zhaY8bHL9lC6zXwV8iv7l2kGB4t3KLStMiI
         csK87t1Bh9Zj5GkiK+HKGIGR6RwD2eSgIL1smm6iDY8kH+pLKjG6rHgmluud78SLEk6e
         FF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a48xYoaImngZlwAokNKt+6RLtl7rqDoLCq/X4qxbRH0=;
        b=gESVxLWtb/O2sPi/iEsraMg7uTOgQkNvzPNB10mguBJ3Gtbd8FMxpWLGVzIkLjFdF0
         OAtroq1yHS8prxc/yeuAm4v9HtGxFiVklzsP3CYxvm7/BdCsaYt3PfWfRMRcjTW0uprY
         zuDWImnpvIB2uLuV4hGHC2LaRNZj+IzMtP3Xl/CmkWG8nqPtQeVq3qCkLIpCvnWVzNM9
         zg8YMStseSZ9YH7SuldfXWigJJSYi6XJ2DupuqQmn0g/5aG8DnZYk44tbk0ubUdOdFmV
         CtI411yQ7ng5GxmM2dhNDK5Tf6uRZh4gbKJpL1Yom/68WIUNF0lNZ+rbco35C/Jbd8iB
         rOBw==
X-Gm-Message-State: AJIora+dPe2vDJPj5U1JS1fHYrlP+R5/Kf/1bUUKAH/uH7aFA3pew3PS
        2hzAvl3AsxJotpU/tGEIIKuvYG9HXWBAfBd4Mx4RfA==
X-Google-Smtp-Source: AGRyM1vm0LaLx48BzcMc4o0Q/G6JwLSkBtWx44Q5XnkRQNuj3EzjAK+wsdbcMm3Y4UXskMFFeS48BcHiyRAHYBz7MRc=
X-Received: by 2002:a0d:dbd7:0:b0:30f:a269:6da5 with SMTP id
 d206-20020a0ddbd7000000b0030fa2696da5mr11876279ywe.344.1655479702282; Fri, 17
 Jun 2022 08:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com> <20220610143527.22974-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220610143527.22974-4-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 17 Jun 2022 17:27:46 +0200
Message-ID: <CAG_fn=Whre1PdfxoT=isho9auAQeBaH4ghU+orcJfgdeD30g3w@mail.gmail.com>
Subject: Re: [PATCHv3 3/8] mm: Pass down mm_struct to untagged_addr()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 10, 2022 at 4:35 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Intel Linear Address Masking (LAM) brings per-mm untagging rules. Pass
> down mm_struct to the untagging helper. It will help to apply untagging
> policy correctly.
>
> In most cases, current->mm is the one to use, but there are some
> exceptions, such as get_user_page_remote().

Wouldn't it be easier to keep using current->mm in untagged_addr(addr)
by default, and introduce a separate macro for the exceptions?

>
> +/*
> + * Architectures that support memory tagging (assigning tags to memory r=
egions,
> + * embedding these tags into addresses that point to these memory region=
s, and
> + * checking that the memory and the pointer tags match on memory accesse=
s)
> + * redefine this macro to strip tags from pointers.
> + * It's defined as noop for architectures that don't support memory tagg=
ing.
> + */
> +#ifndef untagged_addr
> +#define untagged_addr(mm, addr) (addr)
> +#endif
The comment above should probably be extended to explain the effect of `mm`=
.




--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
