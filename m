Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2774BFA83
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiBVONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiBVONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25C47B1511
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645539187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=02ymn/XEvYvBzFbN4yBoqldynqVeEzBnhxvdpCXzyNc=;
        b=YM3FbMgI2704PUih7sej6OJ+3oUOZGIBgjg26dSg+XrE62UihBGId8MbMaWubwrVe6h7aK
        ku6wdY2xHRWi1HoJ3oFCU2x2NcT4HAdIcl8fAs/KjFEDDHz8adNFu3VeN0zUz0mmF3uf+8
        AV1MTUXaXF3JaM6x1QrrtF+OyO7xMH8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-9YgRhuWRM6-jVfCPzqAstw-1; Tue, 22 Feb 2022 09:13:05 -0500
X-MC-Unique: 9YgRhuWRM6-jVfCPzqAstw-1
Received: by mail-wm1-f69.google.com with SMTP id h82-20020a1c2155000000b003552c13626cso910680wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02ymn/XEvYvBzFbN4yBoqldynqVeEzBnhxvdpCXzyNc=;
        b=eKeUVhUndB9Hq08JU5B7gc23gxkyvWawdjMGv3ZfNs9BDrAUGctJw5OwhNr+so5Hto
         ryKvRaOI+7fZXGsFbxpFOkaHpTtrTEnnx/UgcH5petdbQzgl1dDl0377tnGbQKAKsSNj
         7vpH4Oz4RRrxh4iT7AJ20VjqhkAEyXufAPtRm4Y7f3oZhes7h4Y9QdJNa03tR5mxqV0c
         Ft2LG+fLylBhtpo/SmjB0AOXJqIYZRv38ktzhyDK/WblOFPna/vnU9g966FiF7H33WF5
         GHThXgW5U5uBt2wjoDKSYN4FvsIGeZ/oAOFPUOjq2Qhn6mYb8i1zUJVjGM75ix1gBobF
         g5sw==
X-Gm-Message-State: AOAM53192NfYnqfs5sGLD70bQa8JAcou0Wy73ehxqxbjhsTnmEewscgn
        t1Q2d8o4BqojgDmwWjF8aQ/uAOgVLZ5y0Vg3ObN7hHY3IpTgT/3vH+79V5fpyicSMUA8qvZbEKK
        zJvtUf0EqH4e/xUAurs9Pxoc=
X-Received: by 2002:adf:ea01:0:b0:1ea:8200:8ae5 with SMTP id q1-20020adfea01000000b001ea82008ae5mr3441177wrm.607.1645539184536;
        Tue, 22 Feb 2022 06:13:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPITrbu04/IMwADLxvvV/E4qGkQtr4RhbecqJ9WGvxB+gMYUjiFc/jqpBUoGgSNjcw0opXYw==
X-Received: by 2002:adf:ea01:0:b0:1ea:8200:8ae5 with SMTP id q1-20020adfea01000000b001ea82008ae5mr3441153wrm.607.1645539184316;
        Tue, 22 Feb 2022 06:13:04 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id a17-20020a05600c069100b0037ddbe6da71sm2408103wmn.20.2022.02.22.06.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:13:03 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v8 00/13] module: core code clean up
Date:   Tue, 22 Feb 2022 14:12:50 +0000
Message-Id: <20220222141303.1392190-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis, Christophe,

As per your suggestion [1], this is an attempt to refactor and split
optional code out of core module support code into separate components.
This version is based on Linus' commit 7993e65fdd0f ("Merge tag
'mtd/fixes-for-5.17-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux").

Hopefully this iteration is all right. Please let me know your thoughts.

Changes since v7 [2]

 - Removed redundant ifdef CONFIG_MODULES and endif pairing from
   kernel/module/Makefile

Changes since v6 [3]

 - Moved KCOV_INSTRUMENT_module.o out of kernel/Makefile into
   kernel/module/Makefile (Christophe Leroy)
 - Moved kernel/module/signature.c back into kernel/
   (Christophe Leroy)
 - Fixed Oops in add_kallsyms() due to an invalid pointer assignment
   (Christophe Leroy)

Changes since v5 [4]:

 - Updated MAINTAINERS to include the entire kernel/module/ directory
   (Christophe Leroy)
 - Reintroduce commit a97ac8cb24a3 ("module: fix signature check failures
   when using in-kernel decompression") (Michal Suchánek)
 - Refactored code to address some (i.e.
   --ignore=MULTIPLE_ASSIGNMENTS,ASSIGN_IN_IF was used) style violations
   e.g. "Alignment should match open parenthesis", reported by
   scripts/checkpatch.pl --strict (Christophe Leroy)
 - Used PAGE_ALIGN() and PAGE_ALIGNED() instead (Christophe Leroy)
 - Removed sig_enforce from include/linux/module.h as it is only
   used in kernel/module/signing.c (Christophe Leroy)
 - Added static keyword for anything not used outside a source file
   (Christophe Leroy)
 - Moved mod_sysfs_teardown() to kernel/module/sysfs.c (Christophe Leroy)
 - Removed kdb_modules from kernel/debug/kdb/kdb_private.h
   (Christophe Leroy)

Changes since v4 [5]:

 - Moved is_livepatch_module() and set_livepatch_module() to
   kernel/module/livepatch.c
 - Addressed minor compiler warning concerning
   kernel/module/internal.h (0-day)
 - Resolved style violations reported by scripts/checkpatch.pl
 - Dropped patch 5 [6] so external patch [7] can be applied at
   a later date post merge into module-next (Christophe Leroy)

Changes since v3 [8]:

 - Refactored both is_livepatch_module() and set_livepatch_module(),
   respectively, to use IS_ENABLED(CONFIG_LIVEPATCH) (Joe Perches)
 - Addressed various compiler warnings e.g., no previous prototype (0-day)

Changes since v2 [9]:

 - Moved module decompress support to a separate file
 - Made check_modinfo_livepatch() generic (Petr Mladek)
 - Removed filename from each newly created file (Luis Chamberlain)
 - Addressed some (i.e. --ignore=ASSIGN_IN_IF,AVOID_BUG was used)
   minor scripts/checkpatch.pl concerns e.g., use strscpy over
   strlcpy and missing a blank line after declarations (Allen)

Changes since v1 [10]:

  - Moved module version support code into a new file

[1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
[2]: https://lore.kernel.org/lkml/20220222130911.1348513-1-atomlin@redhat.com/
[3]: https://lore.kernel.org/lkml/20220218212511.887059-1-atomlin@redhat.com/
[4]: https://lore.kernel.org/lkml/20220209170358.3266629-1-atomlin@redhat.com/
[5]: https://lore.kernel.org/lkml/20220130213214.1042497-1-atomlin@redhat.com/
[6]: https://lore.kernel.org/lkml/20220130213214.1042497-6-atomlin@redhat.com/
[7]: https://lore.kernel.org/lkml/203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu/
[8]: https://lore.kernel.org/lkml/20220128203934.600247-1-atomlin@redhat.com/
[9]: https://lore.kernel.org/lkml/20220106234319.2067842-1-atomlin@redhat.com/
[10]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/

Aaron Tomlin (13):
  module: Move all into module/
  module: Simple refactor in preparation for split
  module: Make internal.h and decompress.c more compliant
  module: Move livepatch support to a separate file
  module: Move latched RB-tree support to a separate file
  module: Move strict rwx support to a separate file
  module: Move extra signature support out of core code
  module: Move kmemleak support to a separate file
  module: Move kallsyms support into a separate file
  module: Move procfs support into a separate file
  module: Move sysfs support into a separate file
  module: Move kdb_modules list out of core code
  module: Move version support into a separate file

 MAINTAINERS                                   |    2 +-
 include/linux/module.h                        |    9 +-
 kernel/Makefile                               |    5 +-
 kernel/debug/kdb/kdb_main.c                   |    5 +
 kernel/debug/kdb/kdb_private.h                |    4 -
 kernel/module-internal.h                      |   50 -
 kernel/module/Makefile                        |   20 +
 kernel/module/debug_kmemleak.c                |   30 +
 .../decompress.c}                             |    5 +-
 kernel/module/internal.h                      |  275 +++
 kernel/module/kallsyms.c                      |  506 +++++
 kernel/module/livepatch.c                     |   74 +
 kernel/{module.c => module/main.c}            | 1856 +----------------
 kernel/module/procfs.c                        |  142 ++
 kernel/module/signing.c                       |  122 ++
 kernel/module/strict_rwx.c                    |   85 +
 kernel/module/sysfs.c                         |  436 ++++
 kernel/module/tree_lookup.c                   |  109 +
 kernel/module/version.c                       |  109 +
 kernel/module_signing.c                       |   45 -
 20 files changed, 2007 insertions(+), 1882 deletions(-)
 delete mode 100644 kernel/module-internal.h
 create mode 100644 kernel/module/Makefile
 create mode 100644 kernel/module/debug_kmemleak.c
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 create mode 100644 kernel/module/internal.h
 create mode 100644 kernel/module/kallsyms.c
 create mode 100644 kernel/module/livepatch.c
 rename kernel/{module.c => module/main.c} (64%)
 create mode 100644 kernel/module/procfs.c
 create mode 100644 kernel/module/signing.c
 create mode 100644 kernel/module/strict_rwx.c
 create mode 100644 kernel/module/sysfs.c
 create mode 100644 kernel/module/tree_lookup.c
 create mode 100644 kernel/module/version.c
 delete mode 100644 kernel/module_signing.c


base-commit: 7993e65fdd0fe07beb9f36f998f9bbef2c0ee391
-- 
2.34.1

