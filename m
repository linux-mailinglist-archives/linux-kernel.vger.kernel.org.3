Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C958BDDC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 00:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiHGWXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 18:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiHGWXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 18:23:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151FB1FCFF;
        Sun,  7 Aug 2022 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=x4+1SyuBnrsfLH3HBApRgaK+TGzqaCKJHHZnZyL8QS8=; b=nu/cBWDS99rOTqn80qBNQjT8uK
        XOac2xWsTFDD6kBvHa9wYsprv1AqpHPZKL4PmsfGHE5hCfXSv/H8H2/teaAbY+TDBirmg9n1wxjOt
        6PdTk8pOpKx963XwOBtwXdCEF/4LB6zLW4LEWT29np7gUmbCZy5XsE18f0XwWGyFjka9nVaKLAyQf
        lXghFir0KRS6W6jQBOwRu9XqavxA58iXNUINdo/muia/uZRyQ/jEiLzO/wZ7k6yCQaJcLxf4tza4y
        3XHJG3eJKKEptiHDJTINiY8H4vKwk/7gtGxgrVrM8Yrj1kw6eopKjPQ5+wOImhQoVfu8+W6IO3HKs
        uBNZ2e8g==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKoSq-00DL2b-E7; Sun, 07 Aug 2022 22:09:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH v2] kernel/sys_ni: add compat entry for fadvise64_64
Date:   Sun,  7 Aug 2022 15:09:34 -0700
Message-Id: <20220807220934.5689-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_ADVISE_SYSCALLS is not set/enabled and CONFIG_COMPAT is
set/enabled, the riscv compat_syscall_table references
'compat_sys_fadvise64_64', which is not defined:

riscv64-linux-ld: arch/riscv/kernel/compat_syscall_table.o:(.rodata+0x6f8):
undefined reference to `compat_sys_fadvise64_64'

Add 'fadvise64_64' to kernel/sys_ni.c as a conditional COMPAT function
so that when CONFIG_ADVISE_SYSCALLS is not set, there is a fallback
function available.

Fixes: d3ac21cacc24 ("mm: Support compiling out madvise and fadvise")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-api@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
v2: patch kernel/sys_ni.c (for any arch) instead of arch/riscv's
    unistd.h (Arnd)

 kernel/sys_ni.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -277,6 +277,7 @@ COND_SYSCALL(landlock_restrict_self);
 
 /* mm/fadvise.c */
 COND_SYSCALL(fadvise64_64);
+COND_SYSCALL_COMPAT(fadvise64_64);
 
 /* mm/, CONFIG_MMU only */
 COND_SYSCALL(swapon);
