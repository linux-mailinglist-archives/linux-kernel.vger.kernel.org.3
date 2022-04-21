Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9040D50A8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391753AbiDUTJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391758AbiDUTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1D3F4C7A5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650567962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oUgm1roGZlmo/RSKHWbU35ZXLzR9iF1b4LYL8/84k2k=;
        b=iw1l7RlLaAgIdIHnZVvMKskhBJPPrsH35boflvmPyzTwETvRxTmcMDkrKOiD/TkfniuKlR
        uQQveWXbrxjlyFyLBKOytitOJvjRwVcxuprn0mxWcuxZY9NJBe1l+nTanCjgfPXsgTgyUX
        c0VmJvK3v4nmJNtqAEplyxHVXfEcyK4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-5iCbuT0xPWGEZic1BuHduA-1; Thu, 21 Apr 2022 15:05:48 -0400
X-MC-Unique: 5iCbuT0xPWGEZic1BuHduA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94B8D1C05AB7;
        Thu, 21 Apr 2022 19:05:47 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.16.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88C99C27E81;
        Thu, 21 Apr 2022 19:05:44 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC 0/3] Slight improvements for OOM/Futex
Date:   Thu, 21 Apr 2022 15:05:30 -0400
Message-Id: <20220421190533.1601879-1-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following 3 patches were developed while working on the OOM/Futex
fix. 

Patch 1: This is a nonfunctional change. The vma_is_anonymous function
originally led to some confusion about what the oom reaper is checking
for in __oom_reap_task_mm. This patch makes that function name more 
verbose.

Patch 2: Futex cleanup was designed with silent failures. Printing this
failure would have led to more quickly finding the issue. This
introduces a pr_info if the exit path has any issues walking the
userspace list.

Patch 3: During the debug process I noticed that the oom_reap_task_mm
function was always running twice for the same mm_struct; Once in the
exit path and once in the oom_reaper. By checking the MMF_OOM_SKIP we
can prevent these unnecissary double calls. I'd like some input from
David Rientjes here with regards to CVE-2018-1000200, I want to make
sure we are not reintroducing that CVE.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@collabora.com>
Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Ulrich Drepper <drepper@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Nico Pache <npache@redhat.com>

Nico Pache (3):
  mm: change vma_is_anonymous to vma_is_private_anon
  futex: exit: Print a warning when futex_cleanup fails
  exit: Check for MMF_OOM_SKIP in exit_mmap

 arch/powerpc/mm/book3s64/pgtable.c |  2 +-
 fs/userfaultfd.c                   |  2 +-
 include/linux/huge_mm.h            |  2 +-
 include/linux/mm.h                 |  2 +-
 kernel/futex/core.c                | 44 ++++++++++++++++++------------
 mm/gup.c                           |  4 +--
 mm/huge_memory.c                   | 10 +++----
 mm/madvise.c                       |  4 +--
 mm/memory.c                        | 10 +++----
 mm/migrate_device.c                |  6 ++--
 mm/mincore.c                       |  2 +-
 mm/mmap.c                          |  7 +++--
 mm/oom_kill.c                      |  2 +-
 mm/userfaultfd.c                   |  8 +++---
 14 files changed, 57 insertions(+), 48 deletions(-)

-- 
2.35.1

