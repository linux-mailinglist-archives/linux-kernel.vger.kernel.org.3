Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A4D4D4470
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbiCJKZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiCJKZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:25:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 408A412E778
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646907858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/xW+7XmAPsKwZArA/cmb9u4qW7jlPRXbCxSdn6mFhmk=;
        b=U8P+jyw/Tq4Cv5AbdnQJCkM6lLG/vg/G933WHUrf3ajpjvIK2u9HiWe5PdWsdONaam3U9c
        PZ+DtJhORiznx7RN9cFsJ2i6HiYlo1n4WESP2LZatmBnj/M0X4nNONZJAL3+iZH2KQFly0
        QJmFcqH0MjpoN8fbY4a5XSbRj0z0Kzg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-JYw3NkviOxS2h7-zRKzJvQ-1; Thu, 10 Mar 2022 05:24:17 -0500
X-MC-Unique: JYw3NkviOxS2h7-zRKzJvQ-1
Received: by mail-wm1-f70.google.com with SMTP id 20-20020a05600c231400b00389886f6b23so2103463wmo.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xW+7XmAPsKwZArA/cmb9u4qW7jlPRXbCxSdn6mFhmk=;
        b=NqVtkp7YkQYzHoLMzch0QS+uDxFg7If9emQmGX+MgwhPSVhoPgNoXf1jmjPvsILgbM
         +Ktslt7r01sdB3ioyZkIrd3DMyU/iEU5o8qUhL6cuGtom/+L63quUw63Bk5+/zUPl2re
         c9VPE9X5mH89H/ElthUm6FAznI3CVcLy9zaYmYaqEyqO4QfsG/PELZjOqB+utI3dzlI0
         UqdjH2SxG5tfMC/D2zQwbfgmkNdqEFTUlv36HtG1j+2ypPkiGyZCqgYQQZErf5zxvYzb
         R470k3jmbVk4atxLGcOqKotNJI38ZhbENB26iTnx2wFdksFhhXnpGdqs8TZ19cR9qfqZ
         N1zw==
X-Gm-Message-State: AOAM53159ftC1EaLvVGUNj/adylvpb9HvM75gdfDWJ5db6LZjT8SjZMU
        Ybhu4Ju1ysPzS74+qrCJrcSVW+y62bLcuGmvlc2msLullNoNz/K1ZGWKBQmjg5HDVOwZ2iCPqfa
        XLSwl7pfKc7rHJpowlicN/vs=
X-Received: by 2002:a05:6000:128f:b0:1f1:e586:87af with SMTP id f15-20020a056000128f00b001f1e58687afmr3033632wrx.222.1646907855747;
        Thu, 10 Mar 2022 02:24:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRSmlxhZ2Af1mPhEQniS/f6ZBXJ13xrcREX1Cpe+uNYtBn4ekZOA5F+np7ljX3fLG3NFbx0A==
X-Received: by 2002:a05:6000:128f:b0:1f1:e586:87af with SMTP id f15-20020a056000128f00b001f1e58687afmr3033622wrx.222.1646907855523;
        Thu, 10 Mar 2022 02:24:15 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm7245545wmc.22.2022.03.10.02.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 02:24:14 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v11 00/14] module: core code clean up
Date:   Thu, 10 Mar 2022 10:23:59 +0000
Message-Id: <20220310102413.3438665-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

As per your suggestion [1], this is an attempt to refactor and split
optional code out of core module support code into separate components.
This version is based on Linus' commit 7993e65fdd0f ("Merge tag
'mtd/fixes-for-5.17-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux").

Changes since v10 [2]
 - Removed kdb_modules as it is now redundant
   (Christophe Leroy)
 - Removed the include of linux/module.h from any source file
   under kernel/debug/kdb
 - Addressed minor style notice i.e. missing a blank line after
   declarations

Changes since v9 [3]
 - Updated MAINTAINERS to include kernel/module/livepatch.c
   and kernel/module/kdb.c, respectively
 - Moved kdb module related code i.e. support for the 'lsmod',
   out of core/or main kdb code into its own file under
   kernel/module
 - Ensured is_module_sig_enforced(), as a stub, is available
   when Kconfig CONFIG_MODULE_SIG is not enabled/or selected
   (Christophe Leroy)

Changes since v8 [4]

 - Resolved the reported lockdep warnings in kernel/module/kallsyms.c
   (Petr Mladek)

Changes since v7 [5]

 - Removed redundant ifdef CONFIG_MODULES and endif pairing from
   kernel/module/Makefile

Changes since v6 [6]

 - Moved KCOV_INSTRUMENT_module.o out of kernel/Makefile into
   kernel/module/Makefile (Christophe Leroy)
 - Moved kernel/module/signature.c back into kernel/
   (Christophe Leroy)
 - Fixed Oops in add_kallsyms() due to an invalid pointer assignment
   (Christophe Leroy)

Changes since v5 [7]:

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

Changes since v4 [7]:

 - Moved is_livepatch_module() and set_livepatch_module() to
   kernel/module/livepatch.c
 - Addressed minor compiler warning concerning
   kernel/module/internal.h (0-day)
 - Resolved style violations reported by scripts/checkpatch.pl
 - Dropped patch 5 [8] so external patch [9] can be applied at
   a later date post merge into module-next (Christophe Leroy)

Changes since v3 [10]:

 - Refactored both is_livepatch_module() and set_livepatch_module(),
   respectively, to use IS_ENABLED(CONFIG_LIVEPATCH) (Joe Perches)
 - Addressed various compiler warnings e.g., no previous prototype (0-day)

Changes since v2 [11]:

 - Moved module decompress support to a separate file
 - Made check_modinfo_livepatch() generic (Petr Mladek)
 - Removed filename from each newly created file (Luis Chamberlain)
 - Addressed some (i.e. --ignore=ASSIGN_IN_IF,AVOID_BUG was used)
   minor scripts/checkpatch.pl concerns e.g., use strscpy over
   strlcpy and missing a blank line after declarations (Allen)

Changes since v1 [12]:

  - Moved module version support code into a new file

[1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
[2]: https://lore.kernel.org/lkml/20220307174509.2887714-1-atomlin@redhat.com/
[3]: https://lore.kernel.org/lkml/20220228234322.2073104-1-atomlin@redhat.com/
[4]: https://lore.kernel.org/all/20220222141303.1392190-2-atomlin@redhat.com/
[5]: https://lore.kernel.org/lkml/20220222130911.1348513-1-atomlin@redhat.com/
[6]: https://lore.kernel.org/lkml/20220218212511.887059-1-atomlin@redhat.com/
[7]: https://lore.kernel.org/lkml/20220209170358.3266629-1-atomlin@redhat.com/
[8]: https://lore.kernel.org/lkml/20220130213214.1042497-1-atomlin@redhat.com/
[9]: https://lore.kernel.org/lkml/20220130213214.1042497-6-atomlin@redhat.com/
[10]: https://lore.kernel.org/lkml/203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu/
[11]: https://lore.kernel.org/lkml/20220128203934.600247-1-atomlin@redhat.com/
[12]: https://lore.kernel.org/lkml/20220106234319.2067842-1-atomlin@redhat.com/
[13]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/


Aaron Tomlin (14):
  module: Move all into module/
  module: Simple refactor in preparation for split
  module: Make internal.h and decompress.c more compliant
  module: Move livepatch support to a separate file
  module: Move latched RB-tree support to a separate file
  module: Move strict rwx support to a separate file
  module: Move extra signature support out of core code
  module: Move kmemleak support to a separate file
  module: Move kallsyms support into a separate file
  module: kallsyms: Fix suspicious rcu usage
  module: Move procfs support into a separate file
  module: Move sysfs support into a separate file
  module: Move kdb module related code out of main kdb code
  module: Move version support into a separate file

 MAINTAINERS                                   |    4 +-
 include/linux/kdb.h                           |    1 +
 include/linux/module.h                        |   21 +-
 kernel/Makefile                               |    5 +-
 kernel/debug/kdb/kdb_io.c                     |    1 -
 kernel/debug/kdb/kdb_keyboard.c               |    1 -
 kernel/debug/kdb/kdb_main.c                   |   49 -
 kernel/debug/kdb/kdb_private.h                |    4 -
 kernel/debug/kdb/kdb_support.c                |    1 -
 kernel/module-internal.h                      |   50 -
 kernel/module/Makefile                        |   21 +
 kernel/module/debug_kmemleak.c                |   30 +
 .../decompress.c}                             |    5 +-
 kernel/module/internal.h                      |  275 +++
 kernel/module/kallsyms.c                      |  512 +++++
 kernel/module/kdb.c                           |   56 +
 kernel/module/livepatch.c                     |   74 +
 kernel/{module.c => module/main.c}            | 1856 +----------------
 kernel/module/procfs.c                        |  142 ++
 kernel/module/signing.c                       |  122 ++
 kernel/module/strict_rwx.c                    |   85 +
 kernel/module/sysfs.c                         |  436 ++++
 kernel/module/tree_lookup.c                   |  109 +
 kernel/module/version.c                       |  109 +
 kernel/module_signing.c                       |   45 -
 25 files changed, 2075 insertions(+), 1939 deletions(-)
 delete mode 100644 kernel/module-internal.h
 create mode 100644 kernel/module/Makefile
 create mode 100644 kernel/module/debug_kmemleak.c
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 create mode 100644 kernel/module/internal.h
 create mode 100644 kernel/module/kallsyms.c
 create mode 100644 kernel/module/kdb.c
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

