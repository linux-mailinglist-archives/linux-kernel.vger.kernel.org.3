Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9D5A9E20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiIARgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiIARfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:35:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697F940576
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dbfb6d2a3so234898617b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=SI5DHC7dpiRJVHhhWYV+lwBh2iwV9A0Ou3FEYYZKTIo=;
        b=ouDtFH7Jsoj5d0amZ6w++vn1JIcEBsAg0+Jc3jSu1CI/YwtCjIjWCXa3h1daFKHXKc
         cShsEzXCG6pl7Qo8JUwfzrGY3LljVOQU7WP+kQRk9jvRvgn5CYGLdVxDx9mvrs6u6z8K
         /gtKC5pqelI7Ja6YPAH2266yNgoWGngIuBTy9e4Ky4U5csa2GQgfjUrkug/tPpsGFles
         yx5i2EqiywQtBnfaWAJzlm/RHBLABr6GNuXXMOHeNq811kfvPtT71YKWoN7/bLzrrmPy
         z0tKwDEKWW16qZuqOrYHGA9KvA/VUBzIFMBe0AdL5oZh7HL1RXGViqdJIuZcrmP9S3mv
         xPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=SI5DHC7dpiRJVHhhWYV+lwBh2iwV9A0Ou3FEYYZKTIo=;
        b=izz93TC7dDxWGJ3CMaq8kNnoOXFPeiNiSBD0PHo1RJesZlZTJMBxRlRVE2AT+fjCgZ
         aSyBlNDEc9KWiVnEhV5AqxM6Pxfpelk07nBHdO15FT+E7HjVcyovc0tVIJuBxY81+WVj
         v9Kx86BgQP3rML2DtfLD3QuK20Mxez0Y0TgB3dNVpfTJHBJ9LO7qFjydeKuVDK5vd3J2
         erGQhPezLQN4UWy3h2v6PxOIegZ+k/5+W6TLyWRv8H2lzw5h/98QJGaTOwmn2xUExXgo
         yub93trrSM6TW/+rbGxjctEB1btAi1fcgzQkWrl5ppli13tK0wuYIlOwCjWtxjdPoR2m
         4CcQ==
X-Gm-Message-State: ACgBeo0vO2r7CRD/LDSCqnq79BCiDh6PekVAuux7CBPs1DVkabbK+Ejj
        2DdIyNwWoB62loU26flSOODIUBHd3h8=
X-Google-Smtp-Source: AA6agR4TWv71WCFs9L88lUEt8sy6dDZVYBPPgP4/10a2Bx/Ool+t8WQWT1a/Z5ySDpeCnHjOLWwcwNW6snI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:8e8f:0:b0:691:9579:d3c5 with SMTP id
 q15-20020a258e8f000000b006919579d3c5mr19748036ybl.249.1662053723940; Thu, 01
 Sep 2022 10:35:23 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:34:49 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-2-surenb@google.com>
Subject: [RFC PATCH RESEND 01/28] mm: introduce CONFIG_PER_VMA_LOCK
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration variable will be used to build the support for VMA
locking during page fault handling.

This is enabled by default on supported architectures with SMP and MMU
set.

The architecture support is needed since the page fault handler is called
from the architecture's page faulting code which needs modifications to
handle faults under VMA lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 0331f1461f81..58c20fad9cf9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1124,6 +1124,19 @@ config PTE_MARKER_UFFD_WP
 	  purposes.  It is required to enable userfaultfd write protection on
 	  file-backed memory types like shmem and hugetlbfs.
 
+config ARCH_SUPPORTS_PER_VMA_LOCK
+       def_bool n
+
+config PER_VMA_LOCK
+	bool "Per-vma locking support"
+	default y
+	depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP
+	help
+	  Allow per-vma locking during page fault handling.
+
+	  This feature allows locking each virtual memory area separately when
+	  handling page faults instead of taking mmap_lock.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.37.2.789.g6183377224-goog

