Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F7E4A020A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbiA1Ujm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:39:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238416AbiA1Ujj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643402378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a75/LdXswV/+SBDNHc6horr9j5NsKsO2YOlm8qw0OGg=;
        b=MJVpBCIDIyQ3xn/KAembAIZGFd1qBlUg8EZxXqX/o7YZISwUxf3gx7PMZ25jufXmLTMGEX
        0Vqn+Ls8jyZ28XdtPSxE/Li68vbr0Hyj6EYWbuIGWi2JGjcsTVjvf2lhtz7rIPUtHjqHQz
        plebSgYISrKrm/xZnyYjtC2xpXy+rN4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-BOwLkLaYNWeYYq6ZBeQ_yQ-1; Fri, 28 Jan 2022 15:39:37 -0500
X-MC-Unique: BOwLkLaYNWeYYq6ZBeQ_yQ-1
Received: by mail-wm1-f71.google.com with SMTP id m3-20020a7bcb83000000b0034f75d92f27so3469599wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a75/LdXswV/+SBDNHc6horr9j5NsKsO2YOlm8qw0OGg=;
        b=7/d6X0gNdYQzDBpuFw9TUfOW4tL74nWeGTd9PsYppJglmtejB9HLUMGo1rSDsbAKTL
         4kZCDIoWFkj4hDxpCp0btdy6ZaQ/8kbl9k5dAN46IFY2/YrZsDsyno+alP8stQagk0Bz
         fkl9RriCg6N/3oXBA054DyXPP3i035EaN84y7LGUtQNKlBYVMlBSLluKMbHOQPg3dNQt
         gni685YRxGN2VsFVhXnQ2mKobjyGqRjtqmAMoXLAgKjhfgFnhZc/Wg60547q+Fr44HG/
         o9ouULsW41//ghQVzTlhHw8RD2pqgK8p/3kkdG2uUZDSc8fqsMMo+6vO5MFRVFFmMQ32
         k1sA==
X-Gm-Message-State: AOAM531zYE4Vjc9LPAFR9PfMh0A+IlQEcnw2+ujubKxgXFjBBiNxBhlT
        1c/1fA0DXtnHbzK20pKsm26SMbH+8Zo+6wZZMdHhngbd5xXYj9nHjzOuMmln0JygR9qcG/wE1Mr
        MPrOSYZVxNIFPMKDAu2O1SKA=
X-Received: by 2002:a1c:a7c1:: with SMTP id q184mr17778094wme.158.1643402376170;
        Fri, 28 Jan 2022 12:39:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4wMzh4dOyDNZb1aj4V/G4TXfHZ+vtAm7rLuB5KfvNW6U9trUBjsWW0vbTmOpTLrQTAdGHog==
X-Received: by 2002:a1c:a7c1:: with SMTP id q184mr17778071wme.158.1643402375941;
        Fri, 28 Jan 2022 12:39:35 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id c13sm5608087wrv.24.2022.01.28.12.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:39:35 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v3 00/13] module: core code clean up
Date:   Fri, 28 Jan 2022 20:39:21 +0000
Message-Id: <20220128203934.600247-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

[Note: Cc'd live-patching for feedback on livepatch specific changes]

Firstly, apologies for the delay.

As per your suggestion [1], this is an attempt to refactor and split
optional code out of core module support code into separate components.
This version is based on branch mcgrof/modules-next since a97ac8cb24a3/or
modules-5.17-rc1. Please let me know your thoughts.

Changes since v1 [2]:

  - Moved module version support code into a new file

Changes since v2 [3]:

 - Move module decompress support to a separate file
 - Make check_modinfo_livepatch() generic (Petr Mladek)
 - Remove filename from each newly created file (Luis Chamberlain)
 - Addressed some (i.e. --ignore=ASSIGN_IN_IF,AVOID_BUG was used)
   minor scripts/checkpatch.pl concerns e.g., use strscpy over
   strlcpy and missing a blank line after declarations (Allen)

[1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
[2]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/
[3]: https://lore.kernel.org/lkml/20220106234319.2067842-1-atomlin@redhat.com/


Aaron Tomlin (13):
  module: Move all into module/
  module: Simple refactor in preparation for split
  module: Move livepatch support to a separate file
  module: Move latched RB-tree support to a separate file
  module: Move arch strict rwx support to a separate file
  module: Move strict rwx support to a separate file
  module: Move extra signature support out of core code
  module: Move kmemleak support to a separate file
  module: Move kallsyms support into a separate file
  module: Move procfs support into a separate file
  module: Move sysfs support into a separate file
  module: Move kdb_modules list out of core code
  module: Move version support into a separate file

 MAINTAINERS                                   |    2 +-
 include/linux/module.h                        |   92 +-
 kernel/Makefile                               |    5 +-
 kernel/debug/kdb/kdb_main.c                   |    5 +
 kernel/module-internal.h                      |   50 -
 kernel/module/Makefile                        |   18 +
 kernel/module/arch_strict_rwx.c               |   44 +
 kernel/module/debug_kmemleak.c                |   30 +
 .../decompress.c}                             |    2 +-
 kernel/module/internal.h                      |  202 ++
 kernel/module/kallsyms.c                      |  502 +++++
 kernel/module/livepatch.c                     |   74 +
 kernel/{module.c => module/main.c}            | 1879 +----------------
 kernel/module/procfs.c                        |  142 ++
 .../signature.c}                              |    0
 kernel/module/signing.c                       |  120 ++
 kernel/module/strict_rwx.c                    |   83 +
 kernel/module/sysfs.c                         |  425 ++++
 kernel/module/tree_lookup.c                   |  108 +
 kernel/module/version.c                       |  110 +
 kernel/module_signing.c                       |   45 -
 21 files changed, 2032 insertions(+), 1906 deletions(-)
 delete mode 100644 kernel/module-internal.h
 create mode 100644 kernel/module/Makefile
 create mode 100644 kernel/module/arch_strict_rwx.c
 create mode 100644 kernel/module/debug_kmemleak.c
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 create mode 100644 kernel/module/internal.h
 create mode 100644 kernel/module/kallsyms.c
 create mode 100644 kernel/module/livepatch.c
 rename kernel/{module.c => module/main.c} (63%)
 create mode 100644 kernel/module/procfs.c
 rename kernel/{module_signature.c => module/signature.c} (100%)
 create mode 100644 kernel/module/signing.c
 create mode 100644 kernel/module/strict_rwx.c
 create mode 100644 kernel/module/sysfs.c
 create mode 100644 kernel/module/tree_lookup.c
 create mode 100644 kernel/module/version.c
 delete mode 100644 kernel/module_signing.c


base-commit: a97ac8cb24a3c3ad74794adb83717ef1605d1b47
-- 
2.34.1

