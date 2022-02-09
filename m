Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3705E4AF79D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiBIREK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiBIREC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:04:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDAF7C05CB89
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644426244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8JGu9tc4Y2KyT1eiWiXzcd095Zw/Tpe85KWddWWs1mw=;
        b=IJhdXt8cU1+1+ALGa38IzlxzNLeK7cEd0vKCtsPgQxDvJf8SJP7ZGia02mJ8O4TApToU/Q
        HrFRnDOyE/lF7Db/wgvWnsem1om37i4N69HqVjElllyrYlLHh+XZiFPsp9KN9AEgdeH+1a
        1oJXjJ4t5vFJgfp1Ssja61gNjDqly8U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-YWSvhB1NMwufo_GJ2s0OLw-1; Wed, 09 Feb 2022 12:04:00 -0500
X-MC-Unique: YWSvhB1NMwufo_GJ2s0OLw-1
Received: by mail-wr1-f72.google.com with SMTP id y10-20020adfc7ca000000b001e30ed3a496so1337175wrg.15
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 09:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8JGu9tc4Y2KyT1eiWiXzcd095Zw/Tpe85KWddWWs1mw=;
        b=0p0xQcIXOlfWlerix6fkXGRCKfcxqpV/Bo2dXZStw/RUgx+do94t8sC1kD3Nc/j0FF
         EdchqBiAoGGo9ceMYZyLmDxOaibTnVYL7NjSqh8rJfDV8mlg2PmKQlKnQpX3MhD1GTxB
         2SByb9avl5imTU4dqYUi77XtXyTPQurjv0HIEd7pJnqMEnJ1w1N0wisYwsXh9xJ8AHCZ
         2B2BhYwWLHRje06uM8m29vnTWVyceSfKnsvH5i4Oq7Q1VQhx5x9dr/WVzsKjVGnJ+CXs
         mBwoNFNQGbySc+rpuUwanIO/ZyExhgVlahLxXcdtsKc4ASo9ERyt8gDCtaL7pIKoNUBV
         wwrw==
X-Gm-Message-State: AOAM530C9RVlRhj6lPtCrsUb0gIpu0yILUflvvN9Ay7cEv+mcJfoLNtw
        S34b0asX9/u1tJVSnoPpYH0Y47AJibhgqHak4fmFzbKyXMXbFyKeAGhfj45g0+gnQeDquG7lYXB
        Ygu/VAK/GG5f7WJKVxU0WVEc=
X-Received: by 2002:a1c:4c08:: with SMTP id z8mr3325111wmf.153.1644426239702;
        Wed, 09 Feb 2022 09:03:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRWErCzDJevBPge+wE4fG0SvqM8QFw7E/+3ejyBWy/H5JrEyjmJO/RMkyZAElXVcLz66DNUw==
X-Received: by 2002:a1c:4c08:: with SMTP id z8mr3325089wmf.153.1644426239507;
        Wed, 09 Feb 2022 09:03:59 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r2sm23436081wrz.99.2022.02.09.09.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:03:58 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com, christophe.leroy@csgroup.eu, msuchanek@suse.de,
        oleksandr@natalenko.name
Subject: [PATCH v5 00/13] module: core code clean up
Date:   Wed,  9 Feb 2022 17:03:45 +0000
Message-Id: <20220209170358.3266629-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

As per your suggestion [1], this is an attempt to refactor and split
optional code out of core module support code into separate components.
This version is based on Linus' commit e6251ab4551f ("Merge tag
'nfs-for-5.17-2' of git://git.linux-nfs.org/projects/anna/linux-nfs").
Please let me know your thoughts. So far, no feedback from 0-day; albeit,
if I see something, I'll let you know.

Changes since v1 [2]:

  - Moved module version support code into a new file

Changes since v2 [3]:

 - Moved module decompress support to a separate file
 - Made check_modinfo_livepatch() generic (Petr Mladek)
 - Removed filename from each newly created file (Luis Chamberlain)
 - Addressed some (i.e. --ignore=ASSIGN_IN_IF,AVOID_BUG was used)
   minor scripts/checkpatch.pl concerns e.g., use strscpy over
   strlcpy and missing a blank line after declarations (Allen)

Changes since v3 [4]:

 - Refactored both is_livepatch_module() and set_livepatch_module(),
   respectively, to use IS_ENABLED(CONFIG_LIVEPATCH) (Joe Perches)
 - Addressed various compiler warnings e.g., no previous prototype (0-day)

Changes since v4 [5]:

 - Dropped RFC (Luis Chamberlain)
 - Moved is_livepatch_module() and set_livepatch_module() to
   kernel/module/livepatch.c; set_livepatch_module() will
   remain for internal use only
 - Addressed minor compiler warning concerning
   kernel/module/internal.h (0-day)
 - Resolved style violations reported by scripts/checkpatch.pl
 - Dropped patch 5 [6] so external patch [7] can be applied at
   a later date post merge into module-next (Christophe Leroy)

[1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
[2]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/
[3]: https://lore.kernel.org/lkml/20220106234319.2067842-1-atomlin@redhat.com/
[4]: https://lore.kernel.org/lkml/20220128203934.600247-1-atomlin@redhat.com/
[5]: https://lore.kernel.org/lkml/20220130213214.1042497-1-atomlin@redhat.com/
[6]: https://lore.kernel.org/lkml/20220130213214.1042497-6-atomlin@redhat.com/
[7]: https://lore.kernel.org/lkml/203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu/


Aaron Tomlin (13):
  module: Move all into module/
  module: Simple refactor in preparation for split
  module: Make internal.h more compliant
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
 include/linux/module.h                        |   10 +-
 kernel/Makefile                               |    5 +-
 kernel/debug/kdb/kdb_main.c                   |    5 +
 kernel/module-internal.h                      |   50 -
 kernel/module/Makefile                        |   19 +
 kernel/module/debug_kmemleak.c                |   30 +
 .../decompress.c}                             |    2 +-
 kernel/module/internal.h                      |  283 +++
 kernel/module/kallsyms.c                      |  502 +++++
 kernel/module/livepatch.c                     |   80 +
 kernel/{module.c => module/main.c}            | 1862 +----------------
 kernel/module/procfs.c                        |  142 ++
 .../signature.c}                              |    0
 kernel/module/signing.c                       |  120 ++
 kernel/module/strict_rwx.c                    |   84 +
 kernel/module/sysfs.c                         |  425 ++++
 kernel/module/tree_lookup.c                   |  109 +
 kernel/module/version.c                       |  110 +
 kernel/module_signing.c                       |   45 -
 20 files changed, 2009 insertions(+), 1876 deletions(-)
 delete mode 100644 kernel/module-internal.h
 create mode 100644 kernel/module/Makefile
 create mode 100644 kernel/module/debug_kmemleak.c
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 create mode 100644 kernel/module/internal.h
 create mode 100644 kernel/module/kallsyms.c
 create mode 100644 kernel/module/livepatch.c
 rename kernel/{module.c => module/main.c} (64%)
 create mode 100644 kernel/module/procfs.c
 rename kernel/{module_signature.c => module/signature.c} (100%)
 create mode 100644 kernel/module/signing.c
 create mode 100644 kernel/module/strict_rwx.c
 create mode 100644 kernel/module/sysfs.c
 create mode 100644 kernel/module/tree_lookup.c
 create mode 100644 kernel/module/version.c
 delete mode 100644 kernel/module_signing.c


base-commit: e6251ab4551f51fa4cee03523e08051898c3ce82
-- 
2.34.1

