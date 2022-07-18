Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88015788BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiGRRsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiGRRsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:48:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375142C651
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:48:21 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id n74so22194631yba.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=caFOqr1U4vrdWB17XNCka0fWyoHQsm0XjApla3yJuwA=;
        b=Yb8Yj7VjlgSVPJEAAdy4IaVbW2J6e7WVqpwdRT9IKSFT8M1CLxtNlD0pMViZ4Xf+BT
         0LPfYOPqDA6Tmpx09ngaxfwGleK/m3cvBcGKiApkEiD6iKhfU64w1iCuxMzsXr70xQ7w
         +elXPAy5KF3ZFyJ7ncERl5K8pQO1D6RFYD9+n5geoUKAnp+lMLbrL1NM+iHkMmtOsgVN
         VjW3WV88vNlMh1L5KYse/TZKHVY+v+X/2avyzqx0R/lFeH4M3RlVthYtu6USgdG3bItr
         M0ua1tIVDSHRorijPGNi9Hz/Y0aQVOltKVbr9uy95TUhCCXlkCJf2LSnd7ZwiU7dvzaD
         +HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=caFOqr1U4vrdWB17XNCka0fWyoHQsm0XjApla3yJuwA=;
        b=lUTpqb5NhOcT27DEMjUYf8RbRAdYH0KBANM0hC7qh1gNNvsXWP2tO0tMonRGtlBHBH
         6qDBqAY1s8Qwdd4eKUIn2UGCtahgpbNC4OIX4EdKPaSELjfXXN027/vhQcztzE/5TU6s
         oDooV5Sr2cek12crgM5DEVKZWK38BUT+yyyerWS+lVGHbqS3g31/n0rVPkqHrpifEyez
         W0CLiYfybM3e/Dos4xnV1IkUKd6SgbKs++/jfWFcd8e91hBeQOPEdR+1Tzi6CXtlePH1
         +NhW5HZXy9wZiB9NKS3A3uR7UqhGIcQx2/FMO4F1zRtvI8ch/vAVnUMITHYdJ/1e7XkA
         pQqg==
X-Gm-Message-State: AJIora+xu6QRp+s7mVD3uKyTNhwbkQ3RJI9tCR3CxL+mWQ2Cqg8WYt0F
        bRxswHBXtncYXyfsKZrP8aXvumlOQ+8DU4tbDNjXug==
X-Google-Smtp-Source: AGRyM1t1LJfusrpACSngJeznuQh2iagg/Sj+RaajoHLn1mxcjxHabvK36GbLRvLZ5t+9UH1n4ggUjrphnPZz1hMXBdk=
X-Received: by 2002:a25:6847:0:b0:66e:b676:834c with SMTP id
 d68-20020a256847000000b0066eb676834cmr28383606ybc.5.1658166500300; Mon, 18
 Jul 2022 10:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com> <20220712231328.5294-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220712231328.5294-7-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 18 Jul 2022 19:47:44 +0200
Message-ID: <CAG_fn=W-pTCxJ6vEa6aSuAiQDxj0n0_8VgpUhp+TxYDrF8AReg@mail.gmail.com>
Subject: Re: [PATCHv5 06/13] x86/mm: Provide ARCH_GET_UNTAG_MASK and ARCH_ENABLE_TAGGED_ADDR
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:13 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Add a couple of arch_prctl() handles:
>
>  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
>    of tag bits. It is rounded up to the nearest LAM mode that can
>    provide it. For now only LAM_U57 is supported, with 6 tag bits.
>
>  - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
>    bits located in the address.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/uapi/asm/prctl.h |  3 ++
>  arch/x86/kernel/process_64.c      | 60 ++++++++++++++++++++++++++++++-
>  2 files changed, 62 insertions(+), 1 deletion(-)


> +
> +static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long =
nr_bits)
> +{
> +       int ret =3D 0;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_LAM))
> +               return -ENODEV;

Hm, I used to think ENODEV is specific to devices, and -EINVAL is more
appropriate here.
On the other hand, e.g. prctl(PR_SET_SPECULATION_CTRL) can also return ENOD=
EV...


>  long do_arch_prctl_64(struct task_struct *task, int option, unsigned lon=
g arg2)
>  {
>         int ret =3D 0;
> @@ -829,7 +883,11 @@ long do_arch_prctl_64(struct task_struct *task, int =
option, unsigned long arg2)
>         case ARCH_MAP_VDSO_64:
>                 return prctl_map_vdso(&vdso_image_64, arg2);
>  #endif
> -
> +       case ARCH_GET_UNTAG_MASK:
> +               return put_user(task->mm->context.untag_mask,
> +                               (unsigned long __user *)arg2);

Can we have ARCH_GET_UNTAG_MASK return the same error value (ENODEV or
EINVAL) as ARCH_ENABLE_TAGGED_ADDR in the case the host doesn't
support LAM?
After all, the mask does not make much sense in this case.

> +       case ARCH_ENABLE_TAGGED_ADDR:
> +               return prctl_enable_tagged_addr(task->mm, arg2);
>         default:
>                 ret =3D -EINVAL;
>                 break;
> --
> 2.35.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
