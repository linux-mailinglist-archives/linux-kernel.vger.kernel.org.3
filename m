Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329A4508B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354459AbiDTOvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354442AbiDTOvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 717F763CE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650466108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UvQ+ujOD64o3fA7j/+EhfRaQUiew201ThgumvAAsSZc=;
        b=hMadYexUDOIpC1QrMj+681Qa8WwkxLOptbtbkLpHZ3ys7hb0cKY5n7MLTcWbDNvlvGRY5G
        frK9HnifP7gdgOYd1aC5BhKwrimZQ2BCMoiTNhmNZW6lcWq4wwfhq70WTbiMPFsKOdNsiM
        8G2Ul7D8e9t20+LrdMM54KH9/ZW3TP0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-n5Y2aPIBPUC0dXE8DBfY1w-1; Wed, 20 Apr 2022 10:48:27 -0400
X-MC-Unique: n5Y2aPIBPUC0dXE8DBfY1w-1
Received: by mail-io1-f69.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so1364715iov.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UvQ+ujOD64o3fA7j/+EhfRaQUiew201ThgumvAAsSZc=;
        b=1XxwlhCD+6Sykle5gCgHWOFq9WDezNWHCAdq12SltVhpTDLZefL4PdxJS+w7US4QwM
         Qbjk5D3naHWlh4KKKVA1cdkRLPvDT5Nc00gQXfYd3OqpJobXp1mT86JvFHKmoitt5LFT
         +kbXFCPO0ndU2GZDvwA1iQOGA9RjW1ZIarb7MSfCziMDrRi6j6Gx2jVrQZlnCb8R6peg
         mC4sI6LrVEmUF7e/Hk1lDSEeFaEaJIEWs+08UXB4lOTAvZlUjSA90ZK+cVJAzOujmWd3
         cUGu9fZfiHmlrmaB8inkzlvxcbR3GxJwYYNDG/izr1hPn8uLWr/pY32eWBeA2eFySt+i
         dURw==
X-Gm-Message-State: AOAM532Qk8GtgTiCMpkk9NJjqcgMoJ1entBCIw09lcaLwFthMyh146Pm
        xB/zGFzn/JdLOCpWsQ2ILqsAZHu2J5sA7xmKSBQS+2PO6vJTP9WENQDnLyjjOTfesI+GvOpOe/m
        lGedA4+VntJjh20kc8p5Fr/7rOV3ZZBoD2ud5jfVC15trnea4FqD9uQWT+hbP1nIpylW+s7Jtgw
        ==
X-Received: by 2002:a92:d212:0:b0:2cb:7635:9940 with SMTP id y18-20020a92d212000000b002cb76359940mr8695285ily.132.1650466106765;
        Wed, 20 Apr 2022 07:48:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9j2+Hln2x2AYB7+/I4WrIZvyf7PX0+qPLIv0pD0jCSCKrDa/Ss/xapAxD8Cx/If6Puo2s1w==
X-Received: by 2002:a92:d212:0:b0:2cb:7635:9940 with SMTP id y18-20020a92d212000000b002cb76359940mr8695263ily.132.1650466106474;
        Wed, 20 Apr 2022 07:48:26 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id c15-20020a5d8b4f000000b00648f75d0289sm11447866iot.6.2022.04.20.07.48.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Apr 2022 07:48:26 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH] mm/uffd: Move USERFAULTFD configs into mm/
Date:   Wed, 20 Apr 2022 10:48:23 -0400
Message-Id: <20220420144823.35277-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to have USERFAULTFD configs stored in init/.  It makes sense as a
start because that's the default place for storing syscall related configs.

However userfaultfd evolved a bit in the past few years and some more
config options were added.  They're no longer related to syscalls and start
to be not suitable to be kept in the init/ directory anymore, because
they're pure mm concepts.

But it's not ideal either to keep the userfaultfd configs separate from
each other.  Hence this patch moves the userfaultfd configs under init/ to
be under mm/ so that we'll start to group all userfaultfd configs
together.

We do have quite a few examples of syscall related configs that are not put
under init/Kconfig: FTRACE_SYSCALLS, SWAP, FILE_LOCKING, MEMFD_CREATE..
They all reside in the dir where they're more suitable for the concept. So
it seems there's no restriction to keep the role of having syscall related
CONFIG_* under init/ only.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

NOTE: there's a light dependency to patch "mm/uffd: Hide PTE_MARKER option".
---
 init/Kconfig | 17 -----------------
 mm/Kconfig   | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 6a32b466dad1..0a358fc858cd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1685,16 +1685,6 @@ config ADVISE_SYSCALLS
 	  applications use these syscalls, you can disable this option to save
 	  space.
 
-config HAVE_ARCH_USERFAULTFD_WP
-	bool
-	help
-	  Arch has userfaultfd write protection support
-
-config HAVE_ARCH_USERFAULTFD_MINOR
-	bool
-	help
-	  Arch has userfaultfd minor fault support
-
 config MEMBARRIER
 	bool "Enable membarrier() system call" if EXPERT
 	default y
@@ -1759,13 +1749,6 @@ config KALLSYMS_BASE_RELATIVE
 
 # syscall, maps, verifier
 
-config USERFAULTFD
-	bool "Enable userfaultfd() system call"
-	depends on MMU
-	help
-	  Enable the userfaultfd() system call that allows to intercept and
-	  handle page faults in userland.
-
 config ARCH_HAS_MEMBARRIER_CALLBACKS
 	bool
 
diff --git a/mm/Kconfig b/mm/Kconfig
index d740e1ff3b2f..f268ba545e02 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -909,6 +909,23 @@ config ANON_VMA_NAME
 	  area from being merged with adjacent virtual memory areas due to the
 	  difference in their name.
 
+config USERFAULTFD
+	bool "Enable userfaultfd() system call"
+	depends on MMU
+	help
+	  Enable the userfaultfd() system call that allows to intercept and
+	  handle page faults in userland.
+
+config HAVE_ARCH_USERFAULTFD_WP
+	bool
+	help
+	  Arch has userfaultfd write protection support
+
+config HAVE_ARCH_USERFAULTFD_MINOR
+	bool
+	help
+	  Arch has userfaultfd minor fault support
+
 config PTE_MARKER
 	bool
 
-- 
2.32.0

