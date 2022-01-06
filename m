Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3AE486DE6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245659AbiAFXnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:43:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245583AbiAFXnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zrSEVqbuwB224LNTaEpLTrbe7fqxzrVcpAcECOOMUH4=;
        b=BSsWNKHGLrm31y0sKWux/LXo5ydi6G2y+2B3xkKfboc0xC8HJZme+WrBMR6LGMdPUzD34F
        5Gv/rQpfwzAjF5UbF6Eo82qj25zyV2JQAM8Mj9nfSkYq0ZoQkxid+TKjWhxtqgwWuscKfE
        B9CA7dPje4PVXZL74CfsbJgco8ZNpf8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-db_Vai3-NVuQYNBM-ms8eQ-1; Thu, 06 Jan 2022 18:43:21 -0500
X-MC-Unique: db_Vai3-NVuQYNBM-ms8eQ-1
Received: by mail-wm1-f69.google.com with SMTP id r65-20020a1c4444000000b003478a458f01so282064wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zrSEVqbuwB224LNTaEpLTrbe7fqxzrVcpAcECOOMUH4=;
        b=L8Ig81LPGI8pR75LMOYIY3Hg5lr8ke0tYbgqjG64RxNazpHF4EE//xcHIhsAL1JaoP
         Gk8e7bZFgMObXDeUdigVnVkIlTS3SC048SV8VGPjvcF0TqZQysonrQEayqIxCDYWMugy
         Sl07yAwcvGpyAApWD6IqbDD4yif8O9g2PsbBieL8h21Y9PdtszBJ0fxtm90tVwSxAcq2
         VrKWDwDWia1uC4BwstDF+HaOk0bFReiw7nQU5YZtB5WQj0jamgRAkP7T6P2NLedFvxm7
         jYBqBN2WLiURr1uvwkcrgrKd2kWuN6UwRN/Z7MCOfmY/lKYki+j9jerhbwl9wWfvc38E
         UsCA==
X-Gm-Message-State: AOAM533DtYRChWZAt4t0CIJqVo3AMgs/8+x7sSwmwFlBjqQ2weyf/haq
        PQX21E68i0s3OpJT53o/UvY1DBKwU/yB2cbsyfTebVhbt2MbP/Q3wW5y+JcrO53Tuj4TlOStvya
        CrBWWtMX1gWNaKpReIEliFnw=
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr50303323wrj.688.1641512600857;
        Thu, 06 Jan 2022 15:43:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRdGC6HSiAXHCJ3PH755CZuns/3bohmjBLq2aJpvQsD9hmLkI21O6AqLwtdy1S4MB2Ky1TIA==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr50303313wrj.688.1641512600706;
        Thu, 06 Jan 2022 15:43:20 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l2sm3389354wrz.8.2022.01.06.15.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:20 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 00/13] module: core code clean up
Date:   Thu,  6 Jan 2022 23:43:06 +0000
Message-Id: <20220106234319.2067842-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

As per your suggestion [1], this is an attempt to refactor and split
optional code out of core module support code into separate components.
Unfortunately, nothing has been thoroughly tested yet. Please let me know
your thoughts.

Changes since v1 [2]:

  - Moved module version support code into a new file

[1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
[2]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/

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

 include/linux/module.h                        |   76 +-
 kernel/Makefile                               |    4 +-
 kernel/debug/kdb/kdb_main.c                   |    5 +
 kernel/module-internal.h                      |   31 -
 kernel/module/Makefile                        |   17 +
 kernel/module/arch_strict_rwx.c               |   44 +
 kernel/module/debug_kmemleak.c                |   30 +
 kernel/module/internal.h                      |  169 ++
 kernel/module/kallsyms.c                      |  506 +++++
 kernel/module/livepatch.c                     |   75 +
 kernel/{module.c => module/main.c}            | 1872 +----------------
 kernel/module/procfs.c                        |  111 +
 .../signature.c}                              |    0
 kernel/module/signing.c                       |  120 ++
 kernel/module/strict_rwx.c                    |   83 +
 kernel/module/sysfs.c                         |  426 ++++
 kernel/module/tree_lookup.c                   |  108 +
 kernel/module/version.c                       |  113 +
 kernel/module_signing.c                       |   45 -
 19 files changed, 1968 insertions(+), 1867 deletions(-)
 delete mode 100644 kernel/module-internal.h
 create mode 100644 kernel/module/Makefile
 create mode 100644 kernel/module/arch_strict_rwx.c
 create mode 100644 kernel/module/debug_kmemleak.c
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

-- 
2.31.1

