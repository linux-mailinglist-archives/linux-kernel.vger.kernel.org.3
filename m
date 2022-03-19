Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C9B4DE5D7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 04:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbiCSEAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 00:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbiCSEAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:00:06 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D578C7EB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 20:58:11 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z8so19065415ybh.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 20:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gA2qXzSRl9qE4e/yYCKLgAXKN8MMVbC49krdg3yp3I=;
        b=t6/7N1sZ0ZkI6hW5qc6ora09i0y+N1UhwsfsFLFL74GSygv+Glm57pstuNI/fDtPTR
         /fzfKTU47bUXAyFve35zGys6ry7fp6P0n3+dEej8JfBkQdDoQAVOkSyEZckc23r1+dyJ
         QUoVnunu1WTQClkMrK66Hmm1eBAJ9zjuNNTYKYEZi2dBucihutg0niDaBEEG7K+Eiuvt
         PFgHrBK0esrxgY3edNfwPqWYoy00o+SVWwFtQpGqvDv5L06QOJ+VwgWAkDqZOMpEKYHE
         lhEiVpiVcZ8O6SQEdGLZjdqUMdL8QlXAIk5aBozC8b5DWbPVHxfc7xuf612ezBUZnwkY
         Ki7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gA2qXzSRl9qE4e/yYCKLgAXKN8MMVbC49krdg3yp3I=;
        b=2nniIT+xMDd9PVEl91h/erfSFekfVMOUSxVFMqtBuGRWbnKFnSbGTY7D3bf09XjG/E
         pF8SKAJhAbT0z4Tsk7t529MLcFurpMssu/gXC45us4yKM5VbNTLJ/IT/DymYCcnH7tBU
         0X/zL2CZalkECbbgREM3Qr6QGiNKRhuWMQ1qh7vOJcNsconHWBeCZBZlQ/P2FIZIMsoW
         ds6cdxP9lOrIRSi5PIkM+1Yly31p2Bw10Fomr/OkSuEX1P7aa3EJxFL4e1MxjNKDZJpz
         kx2ZU6KTjWoAkUiRayXHb9dgeFOvJy+CRWrLExhBRmzOXOhAJJBpo98AdKaVSXmmf/bj
         YRBA==
X-Gm-Message-State: AOAM530KM2v4vBEIwofAFTffRhUVYrzQOa/EVd+Fsh6BejVrG8Xy5Q1b
        aZHYnRqXG46Nm+TbZ6CLPtxqwEqopgSMAc7OwnNHEQ==
X-Google-Smtp-Source: ABdhPJynV8+lYCBUqF2tFn5s5qKnLh+GnL5M2HPtr94nl6OYf+yVbOOsr28Uz1gniP+AOeBXRZQC3YG3haZrbPFqT6w=
X-Received: by 2002:a25:33d7:0:b0:633:134a:6e7c with SMTP id
 z206-20020a2533d7000000b00633134a6e7cmr12855599ybz.89.1647662290616; Fri, 18
 Mar 2022 20:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220318100720.14524-1-songmuchun@bytedance.com>
 <20220318100720.14524-2-songmuchun@bytedance.com> <YjS2BiqKlDrPYslc@bombadil.infradead.org>
In-Reply-To: <YjS2BiqKlDrPYslc@bombadil.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 19 Mar 2022 11:56:18 +0800
Message-ID: <CAMZfGtXPJ=0Xm_rm6AVGdL9hupkXyw7EtykY-B315LCkzdaZNg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm: hugetlb_vmemmap: introduce STRUCT_PAGE_SIZE_IS_POWER_OF_2
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

On Sat, Mar 19, 2022 at 12:40 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Mar 18, 2022 at 06:07:17PM +0800, Muchun Song wrote:
>
> You can add Suggested-by tag here.

Will do. Sorry for forgetting it.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Kbuild                           | 12 ++++++++++++
> >  fs/Kconfig                       |  2 +-
> >  include/linux/mm_types.h         |  2 ++
> >  mm/Kconfig                       |  3 +++
> >  mm/hugetlb_vmemmap.c             |  6 ------
> >  mm/struct_page_size.c            | 19 +++++++++++++++++++
> >  scripts/check_struct_page_po2.sh | 11 +++++++++++
> >  7 files changed, 48 insertions(+), 7 deletions(-)
> >  create mode 100644 mm/struct_page_size.c
> >  create mode 100755 scripts/check_struct_page_po2.sh
> >
> > diff --git a/Kbuild b/Kbuild
> > index fa441b98c9f6..6bb97d348d62 100644
> > --- a/Kbuild
> > +++ b/Kbuild
> > @@ -14,6 +14,18 @@ $(bounds-file): kernel/bounds.s FORCE
> >       $(call filechk,offsets,__LINUX_BOUNDS_H__)
> >
> >  #####
> > +# Generate struct_page_size.h. Must follows bounds.h.
> > +
> > +struct_page_size-file := include/generated/struct_page_size.h
> > +
> > +always-y := $(struct_page_size-file)
> > +targets := mm/struct_page_size.s
> > +
> > +$(struct_page_size-file): mm/struct_page_size.s FORCE
> > +     $(call filechk,offsets,__LINUX_STRUCT_PAGE_SIZE_H__)
> > +     $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
> > +
> > +#####
>
> Shouldn't this go into mm/Makefile instead?
>

We should guarantee that the include/generated/struct_page_size.h
which Kconfig depends on is created before processing Makefile
since processing Kconfig is before Makefile. Right?

> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 034d87953600..9314bd34f49e 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -2,6 +2,9 @@
> >
> >  menu "Memory Management options"
> >
> > +config STRUCT_PAGE_SIZE_IS_POWER_OF_2
> > +     def_bool $(success,test "$(shell, $(srctree)/scripts/check_struct_page_po2.sh)" = 1)
> > +
> >  config SELECT_MEMORY_MODEL
> >       def_bool y
> >       depends on ARCH_SELECT_MEMORY_MODEL
> > new file mode 100755
> > index 000000000000..9547ad3aca05
> > --- /dev/null
> > +++ b/scripts/check_struct_page_po2.sh
> > @@ -0,0 +1,11 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Check if the size of "struct page" is power of 2
> > +
> > +file="include/generated/struct_page_size.h"
> > +if [ ! -f "$file" ]; then
>
> Does this really work if one is workig off of a very clean build
> like make mrproper and then make menuconfig or or mrproper followed
> by a defconfig file ? Have you tried it for both cases po2 and npo2?
>
> Because isn't include/generated/struct_page_size.h generated? At
> which point does it get generated and why would the condition hole
> true that the file exists at a new 'make menuconfig' time?
>

You are right. include/generated/struct_page_size.h does not exist
in this case, CONFIG_STRUCT_PAGE_SIZE_IS_POWER_OF_2
will be default off in .config. Then it will be switched on/off accordingly
when you build the kernel, for instance make bzImage, which is done via
"make syncconfig" which follows the generation of struct_page_size.h.

While testing this case, I found some bugs. The following patch
could fix this.  Thanks.

--- a/Kbuild
+++ b/Kbuild
@@ -21,6 +21,8 @@ struct_page_size-file := include/generated/struct_page_size.h
 always-y := $(struct_page_size-file)
 targets := mm/struct_page_size.s

+mm/struct_page_size.s: $(timeconst-file) $(bounds-file)
+
 $(struct_page_size-file): mm/struct_page_size.s FORCE
        $(call filechk,offsets,__LINUX_STRUCT_PAGE_SIZE_H__)
        $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
diff --git a/scripts/check_struct_page_po2.sh b/scripts/check_struct_page_po2.sh
index 9547ad3aca05..1764ef9a4f1d 100755
--- a/scripts/check_struct_page_po2.sh
+++ b/scripts/check_struct_page_po2.sh
@@ -4,8 +4,6 @@
 # Check if the size of "struct page" is power of 2

 file="include/generated/struct_page_size.h"
-if [ ! -f "$file" ]; then
-       exit 1
+if [ -f "$file" ]; then
+       grep STRUCT_PAGE_SIZE_IS_POWER_OF_2 "$file" | cut -d' ' -f3
 fi
-
-grep STRUCT_PAGE_SIZE_IS_POWER_OF_2 "$file" | cut -d' ' -f3
