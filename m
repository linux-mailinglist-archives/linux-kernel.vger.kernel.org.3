Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE96D4B0412
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiBJDoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:44:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiBJDoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:44:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF423BF8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:44:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso9280713ybp.23
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 19:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=qWciCl5ZnA9cee9VzBNrbmZE8MiSApc+U+pccH0ywtA=;
        b=PblpbGivAgUrwkOht9582vzXVasv4VMvpMz3lvBIGDiBjYaQgnqS7+IZOblr5OWlFA
         RZD1fNqXxa3Myt8T4AVZWn/J725vs43n11uyMfkQxXSgvQ8Euql15tidstY2FYvI1Nr9
         L0pkNONCYIbptyxWeTfkQF9EPnDmzpZhGbi39EDSjn/65lpjb/U8U4lfaToQ4S8DYgB+
         TQKb5tuZUiEw8rSMF1Xy2rpcImcHUuN7Ea3bOwVx+GSmoJKQrEo66aGtC66ZldMvaAOY
         iMTVOkfZsFas+s2NtzEG04oM5Xml5EbKeZhbPVZbUspFM2HBKDJ3hbAMn3472WuBjpbN
         jylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=qWciCl5ZnA9cee9VzBNrbmZE8MiSApc+U+pccH0ywtA=;
        b=LFORMKAYyncdkrahEgY+IOO9cn1Au5p7yZ8zwBIGC5HJC1Zdwrzg6DzFxlXaZ/zFCx
         a2Gx4WT5nC5g+fri7pVa84zA2cCE0pE65+qk17Lk73ouCt6n0QyN5SoFWXm2S4O5Yjbc
         avMf82YrBT8SnPpIzWyJZP5SJ3O5cHx8teCHE48PlI3rooWGOZhXgmYXdfV3pAvtH9Xc
         9YIG135Blx5OH2P6GrzByaWRaXQ+CW5bXM96Qjt52YiWW0jGS0QFCVQm2/UlmlulkzbN
         RfeBwJKmGVPZkj7UYETBCJWL8NBFFBvGhaDeFrSXIvjzmaHkmDEa4P17XkYhAT3njenr
         R1oQ==
X-Gm-Message-State: AOAM532prKaQkXd/Ggc494N1KWh/1WDKE0N+nD8eQ5dzVNFDK+H1QZyq
        tnS/izbIK4gdMC/PlwzI7bIqtm6B+CNnPw==
X-Google-Smtp-Source: ABdhPJyRin3QH5+g4IN2NFhJb+pUdb70CkVQBrXXRWnw9X9KybCGXHGiOSdS1drI6ORnR2CMcfjFDII3JsZ9UA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:f742:: with SMTP id
 h63mr5655549ywf.410.1644464645575; Wed, 09 Feb 2022 19:44:05 -0800 (PST)
Date:   Thu, 10 Feb 2022 11:43:53 +0800
Message-Id: <20220210034353.1065703-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH] um: Cleanup syscall_handler_t definition/cast, fix warning
From:   David Gow <davidgow@google.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Gow <davidgow@google.com>, x86@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscall_handler_t type for x86_64 was defined as 'long (*)(void)',
but always cast to 'long (*)(long, long, long, long, long, long)' before
use. This now triggers a warning (see below).

Define syscall_handler_t as the latter instead, and remove the cast.
This simplifies the code, and fixes the warning.

Warning:
In file included from ../arch/um/include/asm/processor-generic.h:13
                 from ../arch/x86/um/asm/processor.h:41
                 from ../include/linux/rcupdate.h:30
                 from ../include/linux/rculist.h:11
                 from ../include/linux/pid.h:5
                 from ../include/linux/sched.h:14
                 from ../include/linux/ptrace.h:6
                 from ../arch/um/kernel/skas/syscall.c:7:
../arch/um/kernel/skas/syscall.c: In function =E2=80=98handle_syscall=E2=80=
=99:
../arch/x86/um/shared/sysdep/syscalls_64.h:18:11: warning: cast between inc=
ompatible function types from =E2=80=98long int (*)(void)=E2=80=99 to =E2=
=80=98long int (*)(long int,  long int,  long int,  long int,  long int,  l=
ong int)=E2=80=99 [
-Wcast-function-type]
   18 |         (((long (*)(long, long, long, long, long, long)) \
      |           ^
../arch/x86/um/asm/ptrace.h:36:62: note: in definition of macro =E2=80=98PT=
_REGS_SET_SYSCALL_RETURN=E2=80=99
   36 | #define PT_REGS_SET_SYSCALL_RETURN(r, res) (PT_REGS_AX(r) =3D (res)=
)
      |                                                              ^~~
../arch/um/kernel/skas/syscall.c:46:33: note: in expansion of macro =E2=80=
=98EXECUTE_SYSCALL=E2=80=99
   46 |                                 EXECUTE_SYSCALL(syscall, regs));
      |                                 ^~~~~~~~~~~~~~~

Signed-off-by: David Gow <davidgow@google.com>
---

I couldn't find a reason for the two conflicting function types here,
but it's possible I'm missing one. At the very least, this change didn't
seem to break anything on my system.


 arch/x86/um/shared/sysdep/syscalls_64.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/syscalls_64.h b/arch/x86/um/shared/s=
ysdep/syscalls_64.h
index 48d6cd12f8a5..b6b997225841 100644
--- a/arch/x86/um/shared/sysdep/syscalls_64.h
+++ b/arch/x86/um/shared/sysdep/syscalls_64.h
@@ -10,13 +10,12 @@
 #include <linux/msg.h>
 #include <linux/shm.h>
=20
-typedef long syscall_handler_t(void);
+typedef long syscall_handler_t(long, long, long, long, long, long);
=20
 extern syscall_handler_t *sys_call_table[];
=20
 #define EXECUTE_SYSCALL(syscall, regs) \
-	(((long (*)(long, long, long, long, long, long)) \
-	  (*sys_call_table[syscall]))(UPT_SYSCALL_ARG1(&regs->regs), \
+	(((*sys_call_table[syscall]))(UPT_SYSCALL_ARG1(&regs->regs), \
 		 		      UPT_SYSCALL_ARG2(&regs->regs), \
 				      UPT_SYSCALL_ARG3(&regs->regs), \
 				      UPT_SYSCALL_ARG4(&regs->regs), \
--=20
2.35.0.263.gb82422642f-goog

