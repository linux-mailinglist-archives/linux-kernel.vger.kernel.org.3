Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995C157F504
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiGXM0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiGXMZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCFA21A2;
        Sun, 24 Jul 2022 05:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78C5A61045;
        Sun, 24 Jul 2022 12:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED10C3411E;
        Sun, 24 Jul 2022 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658665553;
        bh=CYylZgBgEWXe/AK9bUnLJ70ppNnmLn//vvrYUoL+UXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVZvlP9Ejw4lMPQy9eEKtpevIxYHCUuAJHNWVftrUiiPbLA6CEvWstyMqgThL2VIM
         jCzHwe/wyo3ChC2lq5GMdeHceQd+egrOOCvIiN3TKMsUI/9kxpJCm2QpCYg0Se499E
         xeacO7N5aY+CSiOuS8ppYoGGJQydpb9LFXBi9C6D03umN5R4042EqEOP3haWtDakKt
         Vqx6jvXQGrfbC34mSfu3db79meraV8ESab4BJ7IJvXW1LdwqLDLc+9Lj4NhiNSSj59
         jFRq+5yoSzp/FTvGcMAarEZ0sav8r2nOKGM08aglcJuNdF6tjrbQfQneIQB09W8240
         oMDxTQN27i6CQ==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, mingo@redhat.com,
        philipp.tomsich@vrull.eu, cmuellner@linux.com,
        linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM
Cc:     linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V8 04/10] asm-generic: spinlock: Add queued spinlock support in common header
Date:   Sun, 24 Jul 2022 08:25:11 -0400
Message-Id: <20220724122517.1019187-5-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220724122517.1019187-1-guoren@kernel.org>
References: <20220724122517.1019187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Select queued spinlock or ticket lock by CONFIG_QUEUED_SPINLOCKS in
the common header file.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 include/asm-generic/spinlock.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index 970590baf61b..f1c29db9c8b5 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -3,7 +3,11 @@
 #ifndef __ASM_GENERIC_SPINLOCK_H
 #define __ASM_GENERIC_SPINLOCK_H
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm-generic/qspinlock.h>
+#else
 #include <asm-generic/ticket_spinlock.h>
+#endif
 #include <asm/qrwlock.h>
 
 #endif /* __ASM_GENERIC_SPINLOCK_H */
-- 
2.36.1

