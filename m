Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3499F4714C0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 17:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhLKQcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 11:32:05 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:46908 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbhLKQcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 11:32:04 -0500
Received: by mail-qt1-f177.google.com with SMTP id m25so11262573qtq.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 08:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XEP0DHcvWb7FTwpOkIM/6NPyGUG4yd9oStGTxV/oR7Q=;
        b=8HwDk1l2i5Gb9CKt/G9doCAWeUzAsNNy1eSMIMjLlwZz0nvg7pN08KG8nHHCGD80c5
         9jKd5SFi6e9HrhoHj2+6KYq6djIX4pFyTepbFhiI4MWihSorUBtPBUhAkMPEKT1EknNz
         qZkfmffDTko/coKsKTC9/IQwi4+ypIRxWwRmyMnjYk87uWJm4nLVYc4t05VQ1kUfMWih
         XTT7YQpkm/8HbR/S4QXwE8G7L7LMowFq2R8LSN6C6BgYSEwmpnT/FCgeI4lNNt1sYe5M
         GNk1W2v64RbDboONZEo7+k4wtiZAbQZlWiltCnMXJ00BfH43D24LgLkg9HGtAp0fGfYj
         KT2A==
X-Gm-Message-State: AOAM533RaverJ5m/PN+EDUnxdF+aVuaKXQqLDny451dPKzUCuhKW+vsN
        n2Yhmwg/AgI1H8RUliJVFpTO9iW9Tus=
X-Google-Smtp-Source: ABdhPJwn+63x9YrJunRV4J5b3Uzf76UUlJvfL6T3UbgWx1sVUd9z3WqAuMaKIaZ6SCHPL7tWVoSe7w==
X-Received: by 2002:ac8:5c45:: with SMTP id j5mr35511882qtj.58.1639240323649;
        Sat, 11 Dec 2021 08:32:03 -0800 (PST)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id bk39sm3196965qkb.35.2021.12.11.08.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 08:32:03 -0800 (PST)
Date:   Sat, 11 Dec 2021 11:32:01 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu fixes for v5.16-rc5
Message-ID: <YbTSgYx7qZ5XO6Yo@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This contains a fix for SMP && !MMU archs for percpu which has been
tested by arm and sh. It seems in the past they have gotten away due to
mapping of vm functions to km functions, but this fell apart a few
releases ago and was just reported recently. The other is just a minor
dependency clean up.

I think queued up right now by Andrew is a fix in percpu that papers of
what seems to be a bug in hotplug for a special situation with
memoryless nodes. Michal Hocko is digging into it further.

[1] https://lore.kernel.org/linux-mm/908909e0-4815-b580-7ff5-d824d36a141c@redhat.com/T/

Thanks,
Dennis

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.16-fixes

for you to fetch changes up to a4f1192cb53758a7210ed5a9ee695aeba22f75fb:

  percpu_ref: Replace kernel.h with the necessary inclusions (2021-12-09 15:41:09 -0500)

----------------------------------------------------------------
Andy Shevchenko (1):
      percpu_ref: Replace kernel.h with the necessary inclusions

Vladimir Murzin (1):
      percpu: km: ensure it is used with NOMMU (either UP or SMP)

 include/linux/percpu-refcount.h | 2 +-
 mm/Kconfig                      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index b31d3f3312ce..d73a1c08c3e3 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -51,9 +51,9 @@
 #define _LINUX_PERCPU_REFCOUNT_H
 
 #include <linux/atomic.h>
-#include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/rcupdate.h>
+#include <linux/types.h>
 #include <linux/gfp.h>
 
 struct percpu_ref;
diff --git a/mm/Kconfig b/mm/Kconfig
index 28edafc820ad..356f4f2c779e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -428,7 +428,7 @@ config THP_SWAP
 # UP and nommu archs use km based percpu allocator
 #
 config NEED_PER_CPU_KM
-	depends on !SMP
+	depends on !SMP || !MMU
 	bool
 	default y
 
