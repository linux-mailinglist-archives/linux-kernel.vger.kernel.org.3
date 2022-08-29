Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9C35A5616
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiH2VZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiH2VZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:25:39 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341E9543FC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:38 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l16-20020a170902f69000b00175138bcd25so362062plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=g4qOnyYThXS8aPbz4q0EiUiPOz/BrsimeRGT1yiKfMQ=;
        b=mWzgq+g1hUcWORjEKpHNvgndKK5fYzq5Kwo71ogdoOHT+8RKeEQm1dWhj+jH+fzB93
         eAtnxNDhkrvgMQV0NbZW6cX2N1R1+vx9KkVCTcRNm2sUroxHvRgBw6l3WRg5Zt3VpzAp
         Gtf7jyf0iomGZE2cusptU53XV2fFMuQkz5kSqUL16OlTWKpS5jWEYB7QcGrOHtGU2amu
         R0EpT4v+6Ubf6b7FtWlOEkEYwXOj5Qkd+op5DjD/MSrHyHjvI8tucin/+y2TJJ3NqFBm
         d0kZdCDqO99cL/X5NSt2crz3dZBhVMVoGOKJ9zBhEnqaTkK0+up1kisxNJ5uiuFsJR5L
         UYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=g4qOnyYThXS8aPbz4q0EiUiPOz/BrsimeRGT1yiKfMQ=;
        b=uwFGmBl2ELAOIhHyVDWacmEGuDMzznR8FFLgLWCh7Hr7mGP57wlksBgWG2pOWjXeQu
         YjF5ocozMTpmD2UrQCwuWhQBrwK1Qu22sLM66lRt10LWLIHwL0HgXuIs/8ibCW1X3eC/
         RaCaybqTqgL4k6nZ/cdtGsUyxrbYybVV5LKrBHxuznnbN0Tw8eG3/snYbq7PL8uNaZSa
         htPZnmMuItOFI4jcQvRCMZEaMc7Rbn1Ruob5ET9SuTFbMpzQnPBcBg1B/b7+5QZeLEaz
         68iRdVjWPlxyOZAs/C2S8aP/qOz+5f2VaUCd56CiaU+cQ4Flzyi0IsJMSR40KL5kr/et
         CGag==
X-Gm-Message-State: ACgBeo08Sr49CYXMs28KR6n/c1NMlOCJJ5F37MmA9ShjhmC4sMkWXtWr
        umgCXxwlR1CGdreSUdBqE1oPsG5Atw8=
X-Google-Smtp-Source: AA6agR70MCvwbcIgBEgSXgn9wLeLPhFpHFOZXigYtzK5DEim0KxhWXMFn5l7ORAicxSiaBREEUpeMlkp2eE=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a62:5ac6:0:b0:537:f0fa:4ae1 with SMTP id
 o189-20020a625ac6000000b00537f0fa4ae1mr12574833pfb.70.1661808337643; Mon, 29
 Aug 2022 14:25:37 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:04 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-2-surenb@google.com>
Subject: [RFC PATCH 01/28] mm: introduce CONFIG_PER_VMA_LOCK
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
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
2.37.2.672.g94769d06f0-goog

