Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B334E4007
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiCVOFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiCVOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:05:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 028152CC8D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647957830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2lX2XksFQbPwbd5t533Vv9MU46m5xCCcK2EFrqJhDOE=;
        b=VOreK0B5cDb7ryaa8YLG8vJZidBVy8tlq0dpLwdB3QqCObx4xzWhMQk0WpsEgd9Xv0ASYX
        hcgpK5U1Af91VbO4gZ1zlugcMCE2bF65WCvNgBL/zXeFSq3dZ5GMW0uIbut7TrK71v9X0L
        Q7iqICJ/OSpnbj6/pkXXXKJf6g/Jels=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-jaul82-cO_O7iBxoyH-ZYw-1; Tue, 22 Mar 2022 10:03:48 -0400
X-MC-Unique: jaul82-cO_O7iBxoyH-ZYw-1
Received: by mail-wm1-f69.google.com with SMTP id m35-20020a05600c3b2300b0038c90ef2dceso1351053wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2lX2XksFQbPwbd5t533Vv9MU46m5xCCcK2EFrqJhDOE=;
        b=L+BxXxzQ/2Ej1YIrgtpkdrrTBYcMpHdAYaR1z4GkvkEuQqarINd7Ip+FgWH/ir+i75
         LPwr0OH6OaWroe7q9ltrcBev3XVPRN27cCTb1LFe/crtyxpOt8+v64GWgROQ42Ozk4QL
         26Cw4unh5FVaJInB+vb1JhjYCwGRc3GWhpY6bFhCP2bzQBGlsJqbrjA9VmcdTNWAynLi
         nWBDX/xmfrDe8UqrPQu7ylbVhjauc5MdjhQ98NRsQupcZhBbKgFZUAukVyQjrnv77GMg
         wddehSNv5CImgodE9qEkpW9llE/oasVMPLqa6YUEY75vTTgey3WQs8xJCG0YYmTKs538
         +v2g==
X-Gm-Message-State: AOAM532qerVlHE/DC2jgHFzATVfoSBzhGUA+C0iw/mAW5nJqrdopAWcI
        nCBdIkkeMAHJbWQhA8znoxc7vHbrsHK0o0iVzmk7IlRTiWEFWRZoHgF2gGUDGwzdLd5DOlcL2JJ
        wYri2M1+c+oMteeoJWorHC60=
X-Received: by 2002:a05:6000:15c1:b0:204:7e75:1eb1 with SMTP id y1-20020a05600015c100b002047e751eb1mr3213110wry.482.1647957827361;
        Tue, 22 Mar 2022 07:03:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEgCEGCVCWJib18koHon306TiLO4/BKUs+A6w5+AeAWwG5OxCZMDuFGgPB2rhmClPGo/cxiQ==
X-Received: by 2002:a05:6000:15c1:b0:204:7e75:1eb1 with SMTP id y1-20020a05600015c100b002047e751eb1mr3213076wry.482.1647957827016;
        Tue, 22 Mar 2022 07:03:47 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id d15-20020a056000186f00b0020384249361sm18083087wri.104.2022.03.22.07.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:03:45 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v12 00/14] module: core code clean up
Date:   Tue, 22 Mar 2022 14:03:30 +0000
Message-Id: <20220322140344.556474-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

As per your suggestion [1], this is an attempt to refactor and split
optional code out of core module support code into separate components.
This version is based on Linus' commit b47d5a4f6b8d ("Merge tag
'audit-pr-20220321' of
git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit").

No changes in this iteration. Each patch has the same In-Reply-To.

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


base-commit: b47d5a4f6b8d42f8a8fbe891b36215e4fddc53be
-- 
2.34.1

