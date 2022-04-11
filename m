Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE1C4FB552
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245707AbiDKHwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245652AbiDKHvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:51:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4390624F12;
        Mon, 11 Apr 2022 00:49:37 -0700 (PDT)
Date:   Mon, 11 Apr 2022 07:49:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649663375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkbLgkyOGO+9YIjPERayJl4hdBeG9jNBh752PJ2UjDQ=;
        b=kRBbT22lOdKcFRTjeK6Ug5qQo2nbyA8XATPpyFNqd+fXh6xYBLKlDozNnfPYFpBl8bYSZJ
        KKuDoIxdVyK57UXMUxZQnFStzPfryT1q18Syl/NRJA4pcqFPl/m3IEzXonx+185Eywj3UU
        eyNoeGkBw57V/nKxhCb1h7VtPwP2pVFmlj1SmMYe0LZrGVTF9Nkm80TXhe/fMX9aQMZnp2
        +5tx+7nyVc5hcOtDnjWyD++MxEv9OCqFDh0fwRZnc6M8n4co8Re7W0rbhdXGisngFR6FJD
        sD1+0HezRzD8aZ6CTKqctrg39mByFRIwvIjazyNUVyMGcokZjBUGx6jdo5oWpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649663375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkbLgkyOGO+9YIjPERayJl4hdBeG9jNBh752PJ2UjDQ=;
        b=gcETOm4GIO7wrtLnJv+HE19BHlxHhMqgDNVxH0mdPf/gMigwJl2V+iWgW3mXRWZnANCUfd
        LnXrtc+2nCHsJbCQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/kaslr: Fix build warning in KASLR code in boot stub
Cc:     Borislav Petkov <bp@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220410200025.3stf4jjvwfe5oxew@box.shutemov.name>
References: <20220410200025.3stf4jjvwfe5oxew@box.shutemov.name>
MIME-Version: 1.0
Message-ID: <164966337460.4207.1566995074602468595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     adb5680b8dfdd09756f13450bfc1ed874d895935
Gitweb:        https://git.kernel.org/tip/adb5680b8dfdd09756f13450bfc1ed874d895935
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Sun, 10 Apr 2022 23:00:25 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 11 Apr 2022 09:41:12 +02:00

x86/kaslr: Fix build warning in KASLR code in boot stub

lib/kaslr.c is used by both the main kernel and the boot stub. It
includes asm/io.h which is supposed to be used in the main kernel. It
leads to build warnings like this with clang 13:

  warning: implicit declaration of function 'outl' is invalid in C99 [-Wimplicit-function-declaration]

Replace <asm/io.h> with <asm/shared/io.h> which is suitable for both
cases.

Fixes: 1e8f93e18379 ("x86: Consolidate port I/O helpers")
Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220410200025.3stf4jjvwfe5oxew@box.shutemov.name
---
 arch/x86/lib/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index 2b3eb8c..a58f451 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -11,7 +11,7 @@
 #include <asm/msr.h>
 #include <asm/archrandom.h>
 #include <asm/e820/api.h>
-#include <asm/io.h>
+#include <asm/shared/io.h>
 
 /*
  * When built for the regular kernel, several functions need to be stubbed out
