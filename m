Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14F65368CF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352722AbiE0WeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiE0WeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:34:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEED66AD5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:34:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so5528281pjf.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rRpKdj7D4Y+lRcGkWZYYAlYoNbloXbMDg0kZp/Zyej0=;
        b=v7VOoOZkpPJGiNcbbmBNhkg0u0vfJwQtzOb+8mPfI/BS2SZrxPg/DAWcLbxllvMI4c
         oGwEfL4SO5jpBlgssIrRCObYlIv0dlREDRpOK6XyVgo4NTjT1nAGrBBJCn1imtu2Nyxo
         N/0cqUJ2+CqrUGGTq+l+V5k8wZiS4Tl9rZlANCrw5Kjlae4CjTpPto4eKnwnocgjW3Bz
         rRXsoWLNvmpnaON+jaCazEZwE/Xyt+4Wi9oSwG1MUEC5riFoeTrkzI7db8wtSleZzkWb
         lPYC2eYSdvAA/s2Swx2HILeshurFKjrem6qLmEMIMaDrg5eW9NA0Af7M+Fm2VLLPLLYz
         RlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rRpKdj7D4Y+lRcGkWZYYAlYoNbloXbMDg0kZp/Zyej0=;
        b=EXOzOW1QIj7XQ/kuTIqkMFuqJMco+Kut3cpu41WKcxUdYu7fi99Srj01zxG8BQy7JQ
         lRRVTjjV2ogcjT0e/KVst5mfhM7dEayW/Gehw6O+xpC7EI/ahLEc5t4UUqo+y/Vlrl83
         OdblaNRw8yZB/6PwGkkYYUWFXb72JA1yPmb0T61voB6sEHyLLKPr7FQ1gnI8SOm12btM
         cn1+cfmhLiqa/6Vp/zhdcjyyCawnYO4xIkEK/gZNmpgRqyO3AAil+i8bVkYzZNIyQFOm
         5Q46+sN/2npmPdDLQaoWwp8P7cdd7fVlRdlG/S+YNsLtczc4ZKp5riEj5kMgA7ZnmwEl
         vQ8Q==
X-Gm-Message-State: AOAM532d3aLo8Mee0FShDIicRZ6+/+wNjVeE3xNWyltiDZwXYyRCCbtO
        a5hjwnM/G+ScJOYusfAA3k9xoQxSlqUVhN3TGWyWpQYnnPQ8Ng==
X-Google-Smtp-Source: ABdhPJy2ieVGG1vDfkbQ8QriUItnQrzEJiCKqHpRNPXOuVPGk2Dbct7BgrSQykHmkgwquQ4m6N+VZylSjsifz8rf5rs=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr45210939pll.132.1653690845634; Fri, 27
 May 2022 15:34:05 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 27 May 2022 15:34:04 -0700
Message-ID: <CAPcyv4gyd=k7qx7nfnLmnmTASFmrJF-nOBAs9cTqM5DSuCZU6Q@mail.gmail.com>
Subject: [GIT PULL] LIBNVDIMM and DAX for 5.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.19

...to receive new support for clearing memory errors when a file is in
DAX mode, alongside with some other fixes and cleanups. Previously it
was only possible to clear these errors using a truncate or hole-punch
operation to trigger the filesystem to reallocate the block, now, any
page aligned write can opportunistically clear errors as well. This
change spans x86/mm, nvdimm, and fs/dax, and has received the
appropriate sign-offs. Thanks to Jane for her work on this. It has
been in -next for several releases with no known remaining issues.

---

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.19

for you to fetch changes up to f42e8e5088b9e791c8f7ac661f68e29a4996a4e3:

  pmem: implement pmem_recovery_write() (2022-05-16 13:38:19 -0700)

----------------------------------------------------------------
libnvdimm for 5.19

- Add support for clearing memory error via pwrite(2) on DAX

- Fix 'security overwrite' support in the presence of media errors

- Miscellaneous cleanups and fixes for nfit_test (nvdimm unit tests)

----------------------------------------------------------------
Dan Williams (1):
      nvdimm: Allow overwrite in the presence of disabled dimms

Jane Chu (7):
      acpi/nfit: rely on mce->misc to determine poison granularity
      x86/mce: relocate set{clear}_mce_nospec() functions
      mce: fix set_mce_nospec to always unmap the whole page
      dax: introduce DAX_RECOVERY_WRITE dax access mode
      dax: add .recovery_write dax_operation
      pmem: refactor pmem_clear_poison()
      pmem: implement pmem_recovery_write()

Michal Suchanek (2):
      testing: nvdimm: iomap: make __nfit_test_ioremap a macro
      testing: nvdimm: asm/mce.h is not needed in nfit.c

ran jianping (1):
      tools/testing/nvdimm: remove unneeded flush_workqueue

 arch/x86/include/asm/set_memory.h |  52 ----------
 arch/x86/kernel/cpu/mce/core.c    |   6 +-
 arch/x86/mm/pat/set_memory.c      |  49 ++++++++-
 drivers/acpi/nfit/mce.c           |   4 +-
 drivers/dax/super.c               |  14 ++-
 drivers/md/dm-linear.c            |  15 ++-
 drivers/md/dm-log-writes.c        |  15 ++-
 drivers/md/dm-stripe.c            |  15 ++-
 drivers/md/dm-target.c            |   4 +-
 drivers/md/dm-writecache.c        |   7 +-
 drivers/md/dm.c                   |  25 ++++-
 drivers/nvdimm/pmem.c             | 203 +++++++++++++++++++++++++++-----------
 drivers/nvdimm/pmem.h             |   5 +-
 drivers/nvdimm/security.c         |   5 -
 drivers/s390/block/dcssblk.c      |   9 +-
 fs/dax.c                          |  22 ++++-
 fs/fuse/dax.c                     |   4 +-
 fs/fuse/virtio_fs.c               |   6 +-
 include/linux/dax.h               |  22 ++++-
 include/linux/device-mapper.h     |  13 ++-
 include/linux/set_memory.h        |  10 +-
 tools/testing/nvdimm/pmem-dax.c   |   4 +-
 tools/testing/nvdimm/test/iomap.c |  18 ++--
 tools/testing/nvdimm/test/nfit.c  |   3 -
 24 files changed, 359 insertions(+), 171 deletions(-)
