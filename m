Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A44E4337
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiCVPnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiCVPnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:43:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1BC8BE3F;
        Tue, 22 Mar 2022 08:41:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 700E11F388;
        Tue, 22 Mar 2022 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647963701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mfmika1iV2aAvCfMUhFBPtl1sq+JgagrgKPtK9yM2As=;
        b=wzGNFp9SrZgPiLRRdz/5cogvunqvIWO31hA4ZtVLQuFKBsHSiCGH5T0PWQpqcLHwT9ri5B
        WwXN9HM+lyzkPhu83K4oRWfg1KgZ1LWVMe2Wf935qcq/QKdwy1IFgRx1nNHx2DKwV5hafJ
        mhia749yXsr7KkWwTELsFWn79MioT7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647963701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mfmika1iV2aAvCfMUhFBPtl1sq+JgagrgKPtK9yM2As=;
        b=J4/DDMFERwCjZNeEt3OPY0LwtLGzLkHo2/RQmSy+5o++/3lysxhaPHyT5hPCt1oopC8Qot
        PP3N6mZcZswrdgCw==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 99A38A3B92;
        Tue, 22 Mar 2022 15:41:40 +0000 (UTC)
Date:   Tue, 22 Mar 2022 16:41:39 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: Re: [PATCH v12 00/14] module: core code clean up
Message-ID: <20220322154139.GS163591@kunlun.suse.cz>
References: <20220322140344.556474-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220322140344.556474-1-atomlin@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 22, 2022 at 02:03:30PM +0000, Aaron Tomlin wrote:
> Hi Luis,
> 
> As per your suggestion [1], this is an attempt to refactor and split
> optional code out of core module support code into separate components.
> This version is based on Linus' commit b47d5a4f6b8d ("Merge tag
> 'audit-pr-20220321' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit").

git complains when applying this series:
Applying: module: Move sysfs support into a separate file
.git/rebase-apply/patch:44: space before tab in indent.
                                  const struct load_info *info,
.git/rebase-apply/patch:45: space before tab in indent.
                                  struct kernel_param *kparam,
.git/rebase-apply/patch:46: space before tab in indent.
                                  unsigned int num_params)
warning: 3 lines add whitespace errors.

Maybe this could be addressed when applying the series.

Thanks

Michal

> 
> No changes in this iteration. Each patch has the same In-Reply-To.
> 
> Changes since v10 [2]
>  - Removed kdb_modules as it is now redundant
>    (Christophe Leroy)
>  - Removed the include of linux/module.h from any source file
>    under kernel/debug/kdb
>  - Addressed minor style notice i.e. missing a blank line after
>    declarations
> 
> Changes since v9 [3]
>  - Updated MAINTAINERS to include kernel/module/livepatch.c
>    and kernel/module/kdb.c, respectively
>  - Moved kdb module related code i.e. support for the 'lsmod',
>    out of core/or main kdb code into its own file under
>    kernel/module
>  - Ensured is_module_sig_enforced(), as a stub, is available
>    when Kconfig CONFIG_MODULE_SIG is not enabled/or selected
>    (Christophe Leroy)
> 
> Changes since v8 [4]
> 
>  - Resolved the reported lockdep warnings in kernel/module/kallsyms.c
>    (Petr Mladek)
> 
> Changes since v7 [5]
> 
>  - Removed redundant ifdef CONFIG_MODULES and endif pairing from
>    kernel/module/Makefile
> 
> Changes since v6 [6]
> 
>  - Moved KCOV_INSTRUMENT_module.o out of kernel/Makefile into
>    kernel/module/Makefile (Christophe Leroy)
>  - Moved kernel/module/signature.c back into kernel/
>    (Christophe Leroy)
>  - Fixed Oops in add_kallsyms() due to an invalid pointer assignment
>    (Christophe Leroy)
> 
> Changes since v5 [7]:
> 
>  - Updated MAINTAINERS to include the entire kernel/module/ directory
>    (Christophe Leroy)
>  - Reintroduce commit a97ac8cb24a3 ("module: fix signature check failures
>    when using in-kernel decompression") (Michal Suchánek)
>  - Refactored code to address some (i.e.
>    --ignore=MULTIPLE_ASSIGNMENTS,ASSIGN_IN_IF was used) style violations
>    e.g. "Alignment should match open parenthesis", reported by
>    scripts/checkpatch.pl --strict (Christophe Leroy)
>  - Used PAGE_ALIGN() and PAGE_ALIGNED() instead (Christophe Leroy)
>  - Removed sig_enforce from include/linux/module.h as it is only
>    used in kernel/module/signing.c (Christophe Leroy)
>  - Added static keyword for anything not used outside a source file
>    (Christophe Leroy)
>  - Moved mod_sysfs_teardown() to kernel/module/sysfs.c (Christophe Leroy)
>  - Removed kdb_modules from kernel/debug/kdb/kdb_private.h
>    (Christophe Leroy)
> 
> Changes since v4 [7]:
> 
>  - Moved is_livepatch_module() and set_livepatch_module() to
>    kernel/module/livepatch.c
>  - Addressed minor compiler warning concerning
>    kernel/module/internal.h (0-day)
>  - Resolved style violations reported by scripts/checkpatch.pl
>  - Dropped patch 5 [8] so external patch [9] can be applied at
>    a later date post merge into module-next (Christophe Leroy)
> 
> Changes since v3 [10]:
> 
>  - Refactored both is_livepatch_module() and set_livepatch_module(),
>    respectively, to use IS_ENABLED(CONFIG_LIVEPATCH) (Joe Perches)
>  - Addressed various compiler warnings e.g., no previous prototype (0-day)
> 
> Changes since v2 [11]:
> 
>  - Moved module decompress support to a separate file
>  - Made check_modinfo_livepatch() generic (Petr Mladek)
>  - Removed filename from each newly created file (Luis Chamberlain)
>  - Addressed some (i.e. --ignore=ASSIGN_IN_IF,AVOID_BUG was used)
>    minor scripts/checkpatch.pl concerns e.g., use strscpy over
>    strlcpy and missing a blank line after declarations (Allen)
> 
> Changes since v1 [12]:
> 
>   - Moved module version support code into a new file
> 
> [1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
> [2]: https://lore.kernel.org/lkml/20220307174509.2887714-1-atomlin@redhat.com/
> [3]: https://lore.kernel.org/lkml/20220228234322.2073104-1-atomlin@redhat.com/
> [4]: https://lore.kernel.org/all/20220222141303.1392190-2-atomlin@redhat.com/
> [5]: https://lore.kernel.org/lkml/20220222130911.1348513-1-atomlin@redhat.com/
> [6]: https://lore.kernel.org/lkml/20220218212511.887059-1-atomlin@redhat.com/
> [7]: https://lore.kernel.org/lkml/20220209170358.3266629-1-atomlin@redhat.com/
> [8]: https://lore.kernel.org/lkml/20220130213214.1042497-1-atomlin@redhat.com/
> [9]: https://lore.kernel.org/lkml/20220130213214.1042497-6-atomlin@redhat.com/
> [10]: https://lore.kernel.org/lkml/203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu/
> [11]: https://lore.kernel.org/lkml/20220128203934.600247-1-atomlin@redhat.com/
> [12]: https://lore.kernel.org/lkml/20220106234319.2067842-1-atomlin@redhat.com/
> [13]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/
> 
> 
> Aaron Tomlin (14):
>   module: Move all into module/
>   module: Simple refactor in preparation for split
>   module: Make internal.h and decompress.c more compliant
>   module: Move livepatch support to a separate file
>   module: Move latched RB-tree support to a separate file
>   module: Move strict rwx support to a separate file
>   module: Move extra signature support out of core code
>   module: Move kmemleak support to a separate file
>   module: Move kallsyms support into a separate file
>   module: kallsyms: Fix suspicious rcu usage
>   module: Move procfs support into a separate file
>   module: Move sysfs support into a separate file
>   module: Move kdb module related code out of main kdb code
>   module: Move version support into a separate file
> 
>  MAINTAINERS                                   |    4 +-
>  include/linux/kdb.h                           |    1 +
>  include/linux/module.h                        |   21 +-
>  kernel/Makefile                               |    5 +-
>  kernel/debug/kdb/kdb_io.c                     |    1 -
>  kernel/debug/kdb/kdb_keyboard.c               |    1 -
>  kernel/debug/kdb/kdb_main.c                   |   49 -
>  kernel/debug/kdb/kdb_private.h                |    4 -
>  kernel/debug/kdb/kdb_support.c                |    1 -
>  kernel/module-internal.h                      |   50 -
>  kernel/module/Makefile                        |   21 +
>  kernel/module/debug_kmemleak.c                |   30 +
>  .../decompress.c}                             |    5 +-
>  kernel/module/internal.h                      |  275 +++
>  kernel/module/kallsyms.c                      |  512 +++++
>  kernel/module/kdb.c                           |   56 +
>  kernel/module/livepatch.c                     |   74 +
>  kernel/{module.c => module/main.c}            | 1856 +----------------
>  kernel/module/procfs.c                        |  142 ++
>  kernel/module/signing.c                       |  122 ++
>  kernel/module/strict_rwx.c                    |   85 +
>  kernel/module/sysfs.c                         |  436 ++++
>  kernel/module/tree_lookup.c                   |  109 +
>  kernel/module/version.c                       |  109 +
>  kernel/module_signing.c                       |   45 -
>  25 files changed, 2075 insertions(+), 1939 deletions(-)
>  delete mode 100644 kernel/module-internal.h
>  create mode 100644 kernel/module/Makefile
>  create mode 100644 kernel/module/debug_kmemleak.c
>  rename kernel/{module_decompress.c => module/decompress.c} (99%)
>  create mode 100644 kernel/module/internal.h
>  create mode 100644 kernel/module/kallsyms.c
>  create mode 100644 kernel/module/kdb.c
>  create mode 100644 kernel/module/livepatch.c
>  rename kernel/{module.c => module/main.c} (64%)
>  create mode 100644 kernel/module/procfs.c
>  create mode 100644 kernel/module/signing.c
>  create mode 100644 kernel/module/strict_rwx.c
>  create mode 100644 kernel/module/sysfs.c
>  create mode 100644 kernel/module/tree_lookup.c
>  create mode 100644 kernel/module/version.c
>  delete mode 100644 kernel/module_signing.c
> 
> 
> base-commit: b47d5a4f6b8d42f8a8fbe891b36215e4fddc53be
> -- 
> 2.34.1
> 
