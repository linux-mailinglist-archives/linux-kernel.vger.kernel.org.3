Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC7A579632
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbiGSJUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiGSJUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:20:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806373ED67;
        Tue, 19 Jul 2022 02:19:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ez10so25946460ejc.13;
        Tue, 19 Jul 2022 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3E324xj6tVctDpGwwTG1JeXH2R87SgQsbVypMIQ6VY=;
        b=oo/+4YZ5ZCcp7qsPsbt10HxOYTOHOwdDcFfvzIyeQvS/sMdHauNcAlVd0uqn+TXHXZ
         xtzi34HJeF+JGwXiAjdu+q0gQikOnFCtRrScTo+JxInNBkA+P1wooaNqoU/UAa1iZfBs
         fj8LENyIEm2xOf6C5rGm6Fsf4nEtxFsLkzyQq5CSqnV+dtINbHkAb9vqOk3ABTuBnZf6
         Vq3HZu3qcpu9nv6wlsev06BuPeNJ0/uC5erVzRSN1rIUUlRIlBtRFNcRTuSnQXift1mK
         rVxHQbKx15mNFl0/R93/YFUvXZXwyFYtiWU5KiTZ8ZPTHo7hXxuLiyd5M1N9zGT6urD2
         2HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3E324xj6tVctDpGwwTG1JeXH2R87SgQsbVypMIQ6VY=;
        b=UK4YSdfyv9saocy38OTQW+WfU/ySfAiwN93qwz4fGXxmL401qrvRdZXiBFDj0wTCPA
         RjzN0bYH9jBbuI7GSEonP0JmVhaHCHLHyDiWgINUHhFmo3NKXUQ8tCR3beVBL0iYBjMw
         BpaaBCzorUxry6h93j1fFkLsfdvRhJG6LJqyhXR0FVDSwscJpaT7I69ZiwcEapBoGs+B
         +CK4sQSORNFpK/XfY1jw7gfP7bj3/SPeC4pNfpJWOHm9Xv34dvW/I3o+V0HjDyYZhQdj
         CHVRwBzSQFFrt22N5fGX1ad/5wNseh7VsHBRNqGf375D8I9+oCsLTn45YS67orRfTr89
         z1OQ==
X-Gm-Message-State: AJIora9K/x8+rIblsJT5tuCcOkHZ1F/DwPkINycXKDdzkbjoPpsS2NiU
        rDr4/rqlW9YeDj/J0aVh/XE=
X-Google-Smtp-Source: AGRyM1sSNOwupPwUixvJpv9J5G/DdS6A1ft/LJYX7wx6JZKp/MYaP0H/t0Mo+FUcQsH/bdPOipJAiw==
X-Received: by 2002:a17:906:4598:b0:72e:dda1:d1d5 with SMTP id qs24-20020a170906459800b0072edda1d1d5mr24357657ejc.480.1658222366747;
        Tue, 19 Jul 2022 02:19:26 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709066d4f00b00715705dd23asm6436242ejt.89.2022.07.19.02.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:19:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>, Song Liu <song@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Replace kmap() with kmap_local_page()
Date:   Tue, 19 Jul 2022 11:19:24 +0200
Message-ID: <5303077.Sb9uPGUboI@opensuse>
In-Reply-To: <YtXchtEwetMvKrKY@bombadil.infradead.org>
References: <20220718002645.28817-1-fmdefrancesco@gmail.com> <YtXchtEwetMvKrKY@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 19 luglio 2022 00:19:50 CEST Luis Chamberlain wrote:
> On Mon, Jul 18, 2022 at 02:26:45AM +0200, Fabio M. De Francesco wrote:
> > kmap() is being deprecated in favor of kmap_local_page().
> >=20
> > Two main problems with kmap(): (1) It comes with an overhead as mapping
> > space is restricted and protected by a global lock for synchronization=
=20
and
> > (2) it also requires global TLB invalidation when the kmap=E2=80=99s po=
ol wraps
> > and it might block when the mapping space is fully utilized until a=20
slot
> > becomes available.
>=20
> Neat!
>=20

Thanks!

> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
>=20
> Yes but the mapping can only be accessed from within this thread and the
> thread is bound to the CPU while the mapping is active. So, what if we
> get a preemption during decompression here? What happens?

No problems at all, please read commit f3ba3c710ac5 ("mm/highmem: Provide=20
kmap_local*") from Thomas Gleixner:

"[] Now that the kmap atomic index is stored in task struct provide a
preemptible variant. On context switch the maps of an outgoing task are
removed and the map of the incoming task are restored. That's obviously
slow, but highmem is slow anyway.
  =20
The kmap_local.*() functions can be invoked from both preemptible and
atomic context. kmap local sections disable migration to keep the resulting
virtual mapping address correct, but disable neither pagefaults nor
preemption.".

However, yours is a good question. It made me realize that this specific=20
topic is not discussed properly in highmem.rst (which also embeds kdocs=20
from highmem.h and highmem-internal.h).

Some weeks ago I reworked highmem.rst and, within a couple of days, I'll=20
also send a second round of additions and clean-ups to the documentation of=
=20
kmap_local_page().=20

I'll use this opportunity to explain more clearly what happens to the local=
=20
mappings when a task is preempted and then is restored. It looks like=20
currently this documentation lacks clarity about the fact that tasks which=
=20
use pointers returned by kmap_local_page() _can_ be preempted and that=20
these pointers are still valid when the tasks are rescheduled to run again.

In the meantime, I'll submit a v2 of this patch with a slightly extended=20
commit message which informs about this specific topic.

Again thanks for pointing it out that the commit message of this patch=20
should be more clear about what happens with preemption.

> > It is faster than kmap() in kernels with HIGHMEM enabled. Its use in
> > module_gzip_decompress() and in module_xz_decompress() is safe and
> > should be preferred.
> >=20
> > Therefore, replace kmap() with kmap_local_page().
>=20
> While this churn is going on everywhere I was wondering why not
> go ahead and adopt kmap_local_folio() instead?

I'm sorry but, due to my lack of knowledge and experience, I'm not sure to=
=20
understand how kmap_local_folio() could help here. My fault. I'm going to=20
make some research and ask for help from more experienced developers.=20

>   Luis
>=20
> > Tested on a QEMU/KVM x86_32 VM with 4GB RAM, booting kernels with
> > HIGHMEM64GB enabled. Modules compressed with XZ or GZIP decompress
> > properly.
> >=20
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  kernel/module/decompress.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)

[snip]

Thanks,

=46abio


