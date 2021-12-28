Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9005E480D65
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbhL1Vaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:30:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236380AbhL1Vap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmPHzOmiJGVn1hY9fDWt3sR60NPPlr53zTWB5QI+n2c=;
        b=Y3Q2r4p6ZzFSkaqfBcYHQdlDLU3Q+mBIyvnbsJUrj2+S6tQ0GKh1/qaNF+mmnDr09u0/zw
        dcDgP1A3pv6P4JyD+LU346QZXtO1GRs4vBapVbdThHi9CDzEjxy424rFMvpkxoiWNfP/eC
        yaP4179bPEqfcG/yo1hOuVjxCjgYBW4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-75lisT4lPN6RmfKcEVXKcA-1; Tue, 28 Dec 2021 16:30:43 -0500
X-MC-Unique: 75lisT4lPN6RmfKcEVXKcA-1
Received: by mail-wr1-f72.google.com with SMTP id k4-20020adfc704000000b001a32d86a772so808908wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmPHzOmiJGVn1hY9fDWt3sR60NPPlr53zTWB5QI+n2c=;
        b=v3C1lVb+OPisjEqbSXsx91va3WvhkkokrS1yuVnjNlA3XqgJ/ozN7HFn2VyyXJHXDY
         XRTPtHH3w3EWfc7SleNBknoL7QyrZj/kqiT4DHbczcL42NDPs/YTcGc3iK+mMK1MMuNp
         NnR8bzBXDP/1HmQ61jg2zDCtfGkuSh46AVtUB0fCKD1RcHzMbPGhllyS/hjrKURzI7l7
         OUr4vPrup7pSVPRwAJbXbKmEGNh39t5omKT0yp8lWs/vC8k/uj+m0BSxE/QUNLL7+FUF
         lwAs2VGCVbkI1QdFZNDTeCINxERS5kI6YrsqvBowboaLCvAmtS1M9vlPyXBtGlXx6DZt
         CVNw==
X-Gm-Message-State: AOAM533J5B3BUcd1qU6seXWp5qP7iOHwCq4dnoy2D9ksozADFuwNiysj
        q01unx/ftxet9DkBiIKFvtXOCCTzS+DhxB6niDp81NhDvI2wIZORrdFO8N6DcTZgxq+vWmU3KYp
        vFwPCylICBc47IiG8Qk0bliE=
X-Received: by 2002:a05:600c:1c9f:: with SMTP id k31mr18947011wms.159.1640727042284;
        Tue, 28 Dec 2021 13:30:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/sBfzQCmEJF1DFkeaNfOzI/ZDHKguyW+zTfeINumJYsB9/PKw21OUwgIAYdhdX64aJ8zwuA==
X-Received: by 2002:a05:600c:1c9f:: with SMTP id k31mr18947000wms.159.1640727042133;
        Tue, 28 Dec 2021 13:30:42 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id az15sm18319172wmb.47.2021.12.28.13.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:41 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 00/12] module: core code clean up
Date:   Tue, 28 Dec 2021 21:30:29 +0000
Message-Id: <20211228213041.1356334-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YbKUUJUtjBk/n913@bombadil.infradead.org>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis, Allen,

I had some free time so decided to make a quick start.
There is more outstanding; albeit, I wanted to share what
was accomplished thus far. Unfortunately, nothing has been
thoroughly tested yet. Please let me know your thoughts.


Aaron Tomlin (12):
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

 include/linux/module.h                        |   76 +-
 kernel/Makefile                               |    4 +-
 kernel/debug/kdb/kdb_main.c                   |    5 +
 kernel/module-internal.h                      |   31 -
 kernel/module/Makefile                        |   16 +
 kernel/module/arch_strict_rwx.c               |   44 +
 kernel/module/debug_kmemleak.c                |   30 +
 kernel/module/internal.h                      |  121 ++
 kernel/module/kallsyms.c                      |  506 ++++++
 kernel/module/livepatch.c                     |   75 +
 kernel/{module.c => module/main.c}            | 1616 +----------------
 kernel/module/procfs.c                        |  111 ++
 .../signature.c}                              |    0
 kernel/module/signing.c                       |  120 ++
 kernel/module/strict_rwx.c                    |   83 +
 kernel/module/sysfs.c                         |  426 +++++
 kernel/module/tree_lookup.c                   |  108 ++
 kernel/module_signing.c                       |   45 -
 18 files changed, 1751 insertions(+), 1666 deletions(-)
 delete mode 100644 kernel/module-internal.h
 create mode 100644 kernel/module/Makefile
 create mode 100644 kernel/module/arch_strict_rwx.c
 create mode 100644 kernel/module/debug_kmemleak.c
 create mode 100644 kernel/module/internal.h
 create mode 100644 kernel/module/kallsyms.c
 create mode 100644 kernel/module/livepatch.c
 rename kernel/{module.c => module/main.c} (66%)
 create mode 100644 kernel/module/procfs.c
 rename kernel/{module_signature.c => module/signature.c} (100%)
 create mode 100644 kernel/module/signing.c
 create mode 100644 kernel/module/strict_rwx.c
 create mode 100644 kernel/module/sysfs.c
 create mode 100644 kernel/module/tree_lookup.c
 delete mode 100644 kernel/module_signing.c

-- 
2.31.1

