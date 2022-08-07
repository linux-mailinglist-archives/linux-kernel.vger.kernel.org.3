Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11CC58BC04
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 19:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiHGR2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 13:28:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB634635A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OQ6HIEzvGhUBHIBVK/MMVvqDNtQvuWyey2ZBasDPQw8=; b=qWiaI30ZKgT7wPXCto/BonchEx
        ImXG1XAqUDBZ/9lA+h2rUk1iTg4dbXp/b5PwQwoHKZiKhLm66BuWm2pbiYi5ToBrxSsmNVLgfKWmd
        KdMY+X7jnjPqVyzAIrFvR+UVDE5+o9LskBdVDdoRwmMXt/TFw9NW4hsEs804QqdYNrCKTaYbhPnyn
        SZuwHVzM6dylK2g/TfOYdOBvQDXZlbrAbh9Hn8ohLn5kReIOL174+qFzZPf1WBXi5MBM4P0nUyrr6
        REYLVqUayELkiW0Kc15JSydrvWFE0Ef1yNu/UsJ/nQMGbBVhBT4Ek3mgK75z84CvczxOMi2Ka30Km
        yIInvvuQ==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKk4y-00DB4C-Gb; Sun, 07 Aug 2022 17:28:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] riscv: compat: make __ARCH_WANT_COMPAT_FADVISE64_64 conditional
Date:   Sun,  7 Aug 2022 10:28:39 -0700
Message-Id: <20220807172839.12359-1-rdunlap@infradead.org>
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

Only set __ARCH_WANT_COMPAT_FADVISE64_64 when CONFIG_ADVISE_SYSCALLS
is set.

Fixes: 59c10c52f573 ("riscv: compat: syscall: Add compat_sys_call_table implementation")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/include/asm/unistd.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -18,8 +18,10 @@
 #define __ARCH_WANT_COMPAT_PWRITE64
 #define __ARCH_WANT_COMPAT_SYNC_FILE_RANGE
 #define __ARCH_WANT_COMPAT_READAHEAD
+#ifdef CONFIG_ADVISE_SYSCALLS
 #define __ARCH_WANT_COMPAT_FADVISE64_64
 #endif
+#endif
 
 #include <uapi/asm/unistd.h>
 
