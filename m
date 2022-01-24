Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF25B49A5CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2374235AbiAYAQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 19:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385512AbiAXX2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:28:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648D4C01D7F5;
        Mon, 24 Jan 2022 13:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0s5qsJ6CO8DHG5dILS8ndyGrYhqvc3LsWkk+L8HKEI0=; b=gJFxnAsU44AByjE9wITE9i1Tjw
        FJwXhpBr5nd/5sGygmwrjDEglZZaBdUDof9zwV6r2VI3sFRCXlTH+vkU4BLoRJRR9ZFFxsMPt0S0D
        hAfl2O+bJNZp4cNOKTYPYW9CSKYwC5QQt0WMY3wZp6KBbetSaf5z+KgQdoERNWcGBBG3IrcSpHkDx
        kDPVaa7rSpVcSGvnLexZCuqzPQgOcZ4MZ5oUufxETQuZfoMSmHtzdJp4vgN9w3YN5+zujDh7S8GrK
        JF5t9Fp2icGJt/Hx5/uxP/c1yciGxw+uS0A6jRe9ftYdUQ7AFQnclzNQQUcB3CCyE3CUWCvJ109AS
        Plb+5iEA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nC6vy-005Kjw-Dl; Mon, 24 Jan 2022 21:31:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH -next v2] ia64: make IA64_MCA_RECOVERY bool instead of tristate
Date:   Mon, 24 Jan 2022 13:31:29 -0800
Message-Id: <20220124213129.29306-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-next, IA64_MCA_RECOVERY uses the (new) function make_task_dead(),
which is not exported for use by modules. Instead of exporting it for
one user, convert IA64_MCA_RECOVERY to be a bool Kconfig symbol.

In a config file from "kernel test robot <lkp@intel.com>" for a
different problem, this linker error was exposed when
CONFIG_IA64_MCA_RECOVERY=m.

Fixes this build error:

ERROR: modpost: "make_task_dead" [arch/ia64/kernel/mca_recovery.ko] undefined!

Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ia64@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>
Cc: kernel test robot <lkp@intel.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
---
v1 was [PATCH -next] exit: export make_task_dead().
Christoph suggests and prefers that IA64 MCA recovery code just be
forced to be builtin if it is enabled.

 arch/ia64/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220121.orig/arch/ia64/Kconfig
+++ linux-next-20220121/arch/ia64/Kconfig
@@ -318,7 +318,7 @@ config ARCH_PROC_KCORE_TEXT
 	depends on PROC_KCORE
 
 config IA64_MCA_RECOVERY
-	tristate "MCA recovery from errors other than TLB."
+	bool "MCA recovery from errors other than TLB."
 
 config IA64_PALINFO
 	tristate "/proc/pal support"
