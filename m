Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7E48BC47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347607AbiALBQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiALBQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:16:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD924C06173F;
        Tue, 11 Jan 2022 17:16:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v6so1361103wra.8;
        Tue, 11 Jan 2022 17:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WFaQHwGYemgRuoryNl/kDaYw3Pbbcx3NJK2rTFSTn4=;
        b=UaAfRHVGXaaaZp7ZnoOH8MAWPITqzOg6FEaIlht9bOWQ/hHUT2Ag8V+Cxm0eL6d7+k
         YRcF/celrxW7rTbu89gi8QVA37GV6CWMcYdk7T+bzu6LPzX9lpFDuCqHjrnbqpDvZQ+C
         2jLKygskhuCJgZ1y1+o4Sf0uG33sS1BwNnti5z4Y4sY5K/127mxplSblfNGjhqb7Wk2k
         2Z/1cyJTaXbniGREbFJUTCrW5sn1j9FJ06txRGyjj+f2Oq3xAcZfTuKuF4rd5qRB0eJj
         CrLqF/JVbSCa+1mbBUO9mGC1WQG2kaZR5jaUHDFsux7stnZQYJ9BW8J4fCPh/zILAO5+
         Yc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WFaQHwGYemgRuoryNl/kDaYw3Pbbcx3NJK2rTFSTn4=;
        b=aGXPC0pl2me+xpDHlLax0P5SHCwozNNqcfuRZObAZ4Jeb4RSvkfMDznR6ctRgZNRUb
         8pROY3fq43vLqQWGW+7EZme46nvACmgFK4cc4nDzBlMgQRYN5lcNGoj31m1VMYnS5xHP
         KHVr3A9PeUHfF2YbRlDoERLYDBDl6ucsTntMKjXz55NFCXFJiWhn0LHyWajZaGeHpviE
         4AXTlfavZraL7FwzEyxM4fYjm3uGnzyVO4GRBJ9gnOe7QZ9oqLZ3pPomZYEbdGii1CJB
         gJli/CZ61MH25yP7KzI4Bfwdb93VZq4bIrlY/hoLxTiFtkE16QX9tuVMz0hG+XLdl6Yu
         h3Xg==
X-Gm-Message-State: AOAM531IE3FhIyYsjCoQL9GrmDbtqbi+ySwcMjiBR1gWYjppQ+k72EbJ
        aeDzM2vsdXzEP/3yyUcH4A6hQM9My8qFTvegJNLGKyjzxSo=
X-Google-Smtp-Source: ABdhPJzKaDqrVJKj7598b+iGgM6svfycVAV0gRSaBb6VyM8xzLuCS4Hx8MOXrvPfzF+VVo8Y43tgi5VJah/Zxx+v5PI=
X-Received: by 2002:a5d:5987:: with SMTP id n7mr5855481wri.1.1641950206316;
 Tue, 11 Jan 2022 17:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20220106234319.2067842-1-atomlin@redhat.com> <CAOMdWSJHm9bRAcrB6U+FsRiK6Fg2bbtbUH82w54VD7kbFmnVsA@mail.gmail.com>
In-Reply-To: <CAOMdWSJHm9bRAcrB6U+FsRiK6Fg2bbtbUH82w54VD7kbFmnVsA@mail.gmail.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 11 Jan 2022 17:16:35 -0800
Message-ID: <CAOMdWS+Sn1sZJt8ocig5U7d7qG3N8oJBW-D1ey0qbZ3AXF-JWg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] module: core code clean up
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

  Was the code compile tested?

  Unfortunately, I could not apply the series cleanly on top of the
latest 5.17-rc1.
  I did rebase the patches and fixed minor compile time failures as
well a few small checkpatch errors.
  I have pushed the series to
https://github.com/allenpais/Linux/commits/refactor_module_v3
  [The series now is based on
   84bfcc0b6994 2022-01-11 Merge tag 'integrity-v5.17' of
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity]

  So far I could only manage to compile test the patches. Will test it
on BM(x86/arm) in a day or two.

Thanks,
- Allen


On Tue, Jan 11, 2022 at 6:55 AM Allen <allen.lkml@gmail.com> wrote:
>
> Hi Aaron,
>
>   My apologies for not replying earlier.
>
>   Thank you so much for doing this. I had a very similar approach, to
> move code out based on the
>   flags. I will am in the process of reviewing and testing the changes
> you have posted.
>
> Thanks.
>
> On Thu, Jan 6, 2022 at 3:43 PM Aaron Tomlin <atomlin@redhat.com> wrote:
> >
> > Hi Luis,
> >
> > As per your suggestion [1], this is an attempt to refactor and split
> > optional code out of core module support code into separate components.
> > Unfortunately, nothing has been thoroughly tested yet. Please let me know
> > your thoughts.
> >
> > Changes since v1 [2]:
> >
> >   - Moved module version support code into a new file
> >
> > [1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
> > [2]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/
> >
> > Aaron Tomlin (13):
> >   module: Move all into module/
> >   module: Simple refactor in preparation for split
> >   module: Move livepatch support to a separate file
> >   module: Move latched RB-tree support to a separate file
> >   module: Move arch strict rwx support to a separate file
> >   module: Move strict rwx support to a separate file
> >   module: Move extra signature support out of core code
> >   module: Move kmemleak support to a separate file
> >   module: Move kallsyms support into a separate file
> >   module: Move procfs support into a separate file
> >   module: Move sysfs support into a separate file
> >   module: Move kdb_modules list out of core code
> >   module: Move version support into a separate file
> >
> >  include/linux/module.h                        |   76 +-
> >  kernel/Makefile                               |    4 +-
> >  kernel/debug/kdb/kdb_main.c                   |    5 +
> >  kernel/module-internal.h                      |   31 -
> >  kernel/module/Makefile                        |   17 +
> >  kernel/module/arch_strict_rwx.c               |   44 +
> >  kernel/module/debug_kmemleak.c                |   30 +
> >  kernel/module/internal.h                      |  169 ++
> >  kernel/module/kallsyms.c                      |  506 +++++
> >  kernel/module/livepatch.c                     |   75 +
> >  kernel/{module.c => module/main.c}            | 1872 +----------------
> >  kernel/module/procfs.c                        |  111 +
> >  .../signature.c}                              |    0
> >  kernel/module/signing.c                       |  120 ++
> >  kernel/module/strict_rwx.c                    |   83 +
> >  kernel/module/sysfs.c                         |  426 ++++
> >  kernel/module/tree_lookup.c                   |  108 +
> >  kernel/module/version.c                       |  113 +
> >  kernel/module_signing.c                       |   45 -
> >  19 files changed, 1968 insertions(+), 1867 deletions(-)
> >  delete mode 100644 kernel/module-internal.h
> >  create mode 100644 kernel/module/Makefile
> >  create mode 100644 kernel/module/arch_strict_rwx.c
> >  create mode 100644 kernel/module/debug_kmemleak.c
> >  create mode 100644 kernel/module/internal.h
> >  create mode 100644 kernel/module/kallsyms.c
> >  create mode 100644 kernel/module/livepatch.c
> >  rename kernel/{module.c => module/main.c} (63%)
> >  create mode 100644 kernel/module/procfs.c
> >  rename kernel/{module_signature.c => module/signature.c} (100%)
> >  create mode 100644 kernel/module/signing.c
> >  create mode 100644 kernel/module/strict_rwx.c
> >  create mode 100644 kernel/module/sysfs.c
> >  create mode 100644 kernel/module/tree_lookup.c
> >  create mode 100644 kernel/module/version.c
> >  delete mode 100644 kernel/module_signing.c
> >
> > --
> > 2.31.1
> >
>
>
> --
>        - Allen



-- 
       - Allen
