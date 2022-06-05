Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4189E53DB06
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiFEJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350940AbiFEJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:31:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F2B4DF66
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:31:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654421458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=riwHFi6EgLDzB/Rso3kTPOF4fPSnjmlCmPmmLWnc2ZU=;
        b=Wu6escuorGZMivYa53c05/tp36uwOwVhLPkeAUKWk6iIhT8Q+MoGedE0XgCq/buhP0c4gk
        fP7gt5gOUD0QR6CPU56dVc6SU5D9vLkxNL4ncPvP5qAAX8CiJmydLprIkmIAeGYNKBMgXz
        12QnWWg5uWI1k3hNS8O7nOVX0hx6WE3H9bg7nBD+4TXo2OquEUUJBpxwl7z/krblo7Kroq
        8dD+66FLaWuKHbLqCVafbbXl03hWXTyNVA9YGQWwHbTrS7b+oHu/o8noiM75R1czorqZ0a
        IYLcKuZQXaUNNnYlL4BGa2si8woQrLsU9NvQjh0qQQDKKdJbGVqUtYWPuWcgfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654421458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=riwHFi6EgLDzB/Rso3kTPOF4fPSnjmlCmPmmLWnc2ZU=;
        b=cKGnnufSVqeFlWr/wsj3+ngW9jc8wuSjVpaviqxjTpYNCOExMBaVts6PXXDYr2kcGYHpyM
        CDdtVBkP+LuRcdBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/boot for v5.19-rc1
References: <165442136963.152751.14259048792272164569.tglx@xen13>
Message-ID: <165442137692.152751.10573871631238612414.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Jun 2022 11:30:58 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/boot branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2022-06=
-05

up to:  8a33d96bd178: x86/setup: Use strscpy() to replace deprecated strlcpy()


Use strlcpy() instead of strscpy() in arch_setup()

Thanks,

	tglx

------------------>
XueBing Chen (1):
      x86/setup: Use strscpy() to replace deprecated strlcpy()


 arch/x86/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 249981bf3d8a..3ebb85327edb 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -903,18 +903,18 @@ void __init setup_arch(char **cmdline_p)
=20
 #ifdef CONFIG_CMDLINE_BOOL
 #ifdef CONFIG_CMDLINE_OVERRIDE
-	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
 	if (builtin_cmdline[0]) {
 		/* append boot loader cmdline to builtin */
 		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
 		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 	}
 #endif
 #endif
=20
-	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p =3D command_line;
=20
 	/*

