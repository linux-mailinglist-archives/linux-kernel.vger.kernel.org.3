Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8873851E939
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386870AbiEGSbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiEGSbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:31:41 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77AC237CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 11:27:53 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id e10so10215284vsr.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWu2MywQGG/lQk+6DwIYkOy+InPInu19/JISIJ1ay6c=;
        b=S2LmFPFT3yCVv6uHOM/n6FYz0td4vWDE4alAWZ2hpBNlKJQ3THghV1FVCnlJAf5Qql
         Vz5+/OVzUCtw/sOUOEizQ0d2HUPzbfQ1YaHDrk5bva9ixw9kJ2fEZYthN2zzT5CKuEQJ
         AbVhfWIbv7aFWXAj/1eFRffwpQYJU/+1KEgQhBVvDeTlNWU93PaQO/lMuNjLdCxmAjt8
         G7obweVZ2rOhvydfWP7CRUpGkwwmrsBF9lI3Ok0mlOOEN1b4JMvmOj+F8mLaiDtpjEJJ
         z/93Dw98zyHkD5zLIBDBXzqyNJ6nPsAKWELVFuCbvfIR98GwljRrkFDrJfcxXOZZcKc8
         izvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWu2MywQGG/lQk+6DwIYkOy+InPInu19/JISIJ1ay6c=;
        b=kVtsz4J928KdYOrRpnIJLg1TCCXiRejH9/Rb/au7wJmvWLW6SGsvGUaimxxjFrs2Cd
         bNXVqp2ldVi6yJQBW6DdimB9GuWWsFry1DYRK1eeo2m66gccGiGlM32xl3kc/R4R2oeS
         XH2QxpW9FvLyNbM7n1mI9DvLcpaWzBq8fa4MC7nylaZ0k/cKWqb0df6LlRYuVhmC/3mx
         T8Ot3mdCtTRodn+Wdz0eBPPr/17Ap7SV9O6zPKIyrtAP696lfvBbSuxVNfr1UDk0c6au
         OFc9/KDON05XKS6eJSWV7r/0xkWw6puLUVtdvzIqI3fGLecXSYfgcKMGj2h41xQJAP2o
         nsdg==
X-Gm-Message-State: AOAM532jadGqqeS6bYARjNck6PfuLX//0KPIj/DjFJY90H7K8zr6RACN
        EDI2L/XbJqnANYWvL4F/eAZYc/FHNCUvppyZ2oIAxg==
X-Google-Smtp-Source: ABdhPJxvMr9/79bgxLnx9dOLzXxMnJ0mfL6bTXPoI5A7fOtPqbD0va77JLyV7wheFIEfWMg1VQSOtRVhFgEET3orvmY=
X-Received: by 2002:a67:cb02:0:b0:32c:2690:be39 with SMTP id
 b2-20020a67cb02000000b0032c2690be39mr5129804vsl.81.1651948072013; Sat, 07 May
 2022 11:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <YnWRVd5slCy5H0fC@creeky> <20220507015646.5377-1-hdanton@sina.com>
In-Reply-To: <20220507015646.5377-1-hdanton@sina.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 7 May 2022 11:27:15 -0700
Message-ID: <CAOUHufY=xAvDKSaV8vybgObXPBEsPqqS7R3+T_-6ix7bUvQc6w@mail.gmail.com>
Subject: Re: Alpha: rare random memory corruption/segfault in user space bisected
To:     Michael Cree <mcree@orcon.net.nz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: multipart/mixed; boundary="00000000000005798e05de70220d"
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

--00000000000005798e05de70220d
Content-Type: text/plain; charset="UTF-8"

On Fri, May 6, 2022 at 6:57 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Sat, 7 May 2022 09:21:25 +1200 Michael Cree wrote:
> > Alpha kernel has been exhibiting rare and random memory
> > corruptions/segaults in user space since the 5.9.y kernel.  First seen
> > on the Debian Ports build daemon when running 5.10.y kernel resulting
> > in the occasional (one or two a day) build failures with gcc ICEs either
> > due to self detected corrupt memory structures or segfaults.  Have been
> > running 5.8.y kernel without such problems for over six months.
> >
> > Tried bisecting last year but went off track with incorrect good/bad
> > determinations due to rare nature of bug.  After trying a 5.16.y kernel
> > early this year and seen the bug is still present retried the bisection
> > and have got to:
> >
> > aae466b0052e1888edd1d7f473d4310d64936196 is the first bad commit
> > commit aae466b0052e1888edd1d7f473d4310d64936196
> > Author: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Date:   Tue Aug 11 18:30:50 2020 -0700
> >
> >     mm/swap: implement workingset detection for anonymous LRU

This commit seems innocent to me. While not ruling out anything, i.e.,
this commit, compiler, qemu, userspace itself, etc., my wild guess is
the problem is memory barrier related. Two lock/unlock pairs, which
imply two full barriers, were removed. This is not a small deal on
Alpha, since it imposes no constraints on cache coherency, AFAIK.

Can you please try the attached patch on top of this commit? Thanks!

> > Pretty confident this is the bad commit as the kernel built to the parent
> > commit (3852f6768ede54...) has not failed in four days running. Always have
> > seen the failure within one day of running in past.
>
> See if the fix to the syzbot bisection [1] is not a cure to your issue.
>
> [1] https://lore.kernel.org/lkml/000000000000625fa705dd1802e3@google.com/

--00000000000005798e05de70220d
Content-Type: application/octet-stream; name="test.diff"
Content-Disposition: attachment; filename="test.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l2w76ukb0>
X-Attachment-Id: f_l2w76ukb0

ZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggZGUzMTFmYzc2Mzll
Li5mMWNmMDc0MTZjZjQgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5jCisrKyBiL21tL21lbW9yeS5j
CkBAIC0zMTUwLDYgKzMxNTAsOCBAQCB2bV9mYXVsdF90IGRvX3N3YXBfcGFnZShzdHJ1Y3Qgdm1f
ZmF1bHQgKnZtZikKIAkJCQkJZ290byBvdXRfcGFnZTsKIAkJCQl9CiAKKwkJCQlzbXBfbWIoKTsK
KwogCQkJCXNoYWRvdyA9IGdldF9zaGFkb3dfZnJvbV9zd2FwX2NhY2hlKGVudHJ5KTsKIAkJCQlp
ZiAoc2hhZG93KQogCQkJCQl3b3JraW5nc2V0X3JlZmF1bHQocGFnZSwgc2hhZG93KTsKZGlmZiAt
LWdpdCBhL21tL3N3YXBfc3RhdGUuYyBiL21tL3N3YXBfc3RhdGUuYwppbmRleCBiNzNhYWJkZmQz
NWEuLjMxMGQ0MDQ5Y2RmMyAxMDA2NDQKLS0tIGEvbW0vc3dhcF9zdGF0ZS5jCisrKyBiL21tL3N3
YXBfc3RhdGUuYwpAQCAtNDk5LDYgKzQ5OSw4IEBAIHN0cnVjdCBwYWdlICpfX3JlYWRfc3dhcF9j
YWNoZV9hc3luYyhzd3BfZW50cnlfdCBlbnRyeSwgZ2ZwX3QgZ2ZwX21hc2ssCiAJCWdvdG8gZmFp
bF91bmxvY2s7CiAJfQogCisJc21wX21iKCk7CisKIAlpZiAoc2hhZG93KQogCQl3b3JraW5nc2V0
X3JlZmF1bHQocGFnZSwgc2hhZG93KTsKIAo=
--00000000000005798e05de70220d--
