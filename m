Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9639948AFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243077AbiAKOzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbiAKOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:55:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45ABC06173F;
        Tue, 11 Jan 2022 06:55:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k18so33394908wrg.11;
        Tue, 11 Jan 2022 06:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNhQnlMhvZFeqKFtcbirLwBnaDxp0A+t+c6ov/Vom3A=;
        b=fSCTF3uiZoV4YA+UwoGanep4ibgNA2mv96cP5pAzRjHEgkGWF/gzsLU3fiI4miQ/Ou
         lWXeg74DV7NzWkoMKfYeYaynZrNusr74RU0VXBH7StWbUX+FGRtoNMti8sWtGaOkxV/V
         YnqWNKNZKBZJKqDbIbRf38l5LddkIAt+sgt4brkyNtCP4wBh2gVDO1uyNGVNQXnWzPe/
         QfpU+VmKvPlarRBM28wBMhwrhWSBVAZH71VRc/uE0GqjhnezdsXocEBX6YM5SoIH7d9B
         qdmQndSskqBHrSpp+yPGAa+uEghpE8DhUKYLD2av43IYctL/zEke9JR1Kw+PHLy5NEtb
         BqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNhQnlMhvZFeqKFtcbirLwBnaDxp0A+t+c6ov/Vom3A=;
        b=t2icfFAlfeymkJc4omoSNFEmbuALLcWy8uZ5kb5BsA43GZf3WambndjCfI6AwBHxLb
         oAdLGpLyJA/ohadTZvPahGcrbKHpwiWn53JeltE9o9C2F5EycpP4YggfBbYl6+ZOs7Xy
         hkW29ZCFwgl/KPYmCxhfSD6QPCsen4mOliPoT3arQx8dyAH9SuHdlKmxtYNbVqbvuUUS
         wo2A0ImlXDR8XhHsOZsWen3q3MFNY4qcHe2D2wqpDhe+zqQxgtQ3pV0FsLA6C/JKSnl2
         GOGmC/Vo2/U/m0VFOYQUd3ePclSxwXT2VtN3t2o4+wTcR6DscktwpQq0nOkMvSGsiHmm
         vezw==
X-Gm-Message-State: AOAM533xqPynfIQm1LwQM7BzKXrvqsi733JUU2BIdeUVbSYES8FlyJTX
        7O+dxTDbFi2H4OHjAX6A9osT/YJ2K1NjYZMqARw=
X-Google-Smtp-Source: ABdhPJxFhUKU/9e21CJy5hEz2i64VYpcj95VqbQEe3B0CR2NmtVcjFJzceaXCQvyJwUzGk9DSPnbKu+1IWxD/n38ucY=
X-Received: by 2002:a5d:4488:: with SMTP id j8mr4069349wrq.515.1641912944329;
 Tue, 11 Jan 2022 06:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20220106234319.2067842-1-atomlin@redhat.com>
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 11 Jan 2022 06:55:33 -0800
Message-ID: <CAOMdWSJHm9bRAcrB6U+FsRiK6Fg2bbtbUH82w54VD7kbFmnVsA@mail.gmail.com>
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

  My apologies for not replying earlier.

  Thank you so much for doing this. I had a very similar approach, to
move code out based on the
  flags. I will am in the process of reviewing and testing the changes
you have posted.

Thanks.

On Thu, Jan 6, 2022 at 3:43 PM Aaron Tomlin <atomlin@redhat.com> wrote:
>
> Hi Luis,
>
> As per your suggestion [1], this is an attempt to refactor and split
> optional code out of core module support code into separate components.
> Unfortunately, nothing has been thoroughly tested yet. Please let me know
> your thoughts.
>
> Changes since v1 [2]:
>
>   - Moved module version support code into a new file
>
> [1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
> [2]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/
>
> Aaron Tomlin (13):
>   module: Move all into module/
>   module: Simple refactor in preparation for split
>   module: Move livepatch support to a separate file
>   module: Move latched RB-tree support to a separate file
>   module: Move arch strict rwx support to a separate file
>   module: Move strict rwx support to a separate file
>   module: Move extra signature support out of core code
>   module: Move kmemleak support to a separate file
>   module: Move kallsyms support into a separate file
>   module: Move procfs support into a separate file
>   module: Move sysfs support into a separate file
>   module: Move kdb_modules list out of core code
>   module: Move version support into a separate file
>
>  include/linux/module.h                        |   76 +-
>  kernel/Makefile                               |    4 +-
>  kernel/debug/kdb/kdb_main.c                   |    5 +
>  kernel/module-internal.h                      |   31 -
>  kernel/module/Makefile                        |   17 +
>  kernel/module/arch_strict_rwx.c               |   44 +
>  kernel/module/debug_kmemleak.c                |   30 +
>  kernel/module/internal.h                      |  169 ++
>  kernel/module/kallsyms.c                      |  506 +++++
>  kernel/module/livepatch.c                     |   75 +
>  kernel/{module.c => module/main.c}            | 1872 +----------------
>  kernel/module/procfs.c                        |  111 +
>  .../signature.c}                              |    0
>  kernel/module/signing.c                       |  120 ++
>  kernel/module/strict_rwx.c                    |   83 +
>  kernel/module/sysfs.c                         |  426 ++++
>  kernel/module/tree_lookup.c                   |  108 +
>  kernel/module/version.c                       |  113 +
>  kernel/module_signing.c                       |   45 -
>  19 files changed, 1968 insertions(+), 1867 deletions(-)
>  delete mode 100644 kernel/module-internal.h
>  create mode 100644 kernel/module/Makefile
>  create mode 100644 kernel/module/arch_strict_rwx.c
>  create mode 100644 kernel/module/debug_kmemleak.c
>  create mode 100644 kernel/module/internal.h
>  create mode 100644 kernel/module/kallsyms.c
>  create mode 100644 kernel/module/livepatch.c
>  rename kernel/{module.c => module/main.c} (63%)
>  create mode 100644 kernel/module/procfs.c
>  rename kernel/{module_signature.c => module/signature.c} (100%)
>  create mode 100644 kernel/module/signing.c
>  create mode 100644 kernel/module/strict_rwx.c
>  create mode 100644 kernel/module/sysfs.c
>  create mode 100644 kernel/module/tree_lookup.c
>  create mode 100644 kernel/module/version.c
>  delete mode 100644 kernel/module_signing.c
>
> --
> 2.31.1
>


-- 
       - Allen
