Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6C4B3D1A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 20:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiBMTZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 14:25:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiBMTZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 14:25:32 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE92318
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 11:25:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h6so23619701wrb.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 11:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OvEjorEIx0jCUuaXWTFX/cePSI9jzuIRof4/xyfP0s4=;
        b=EAPuqH8zQJrbxv+QFwFiLJg7vwh30Wc1GeXsNdV0ScW62r1OiWnGeVAUa57xwm9Jbd
         AXWR0euOSH42sLuN7SIyhYokQ2JfxvCB5mgj3ifpjdn6YLnqDk4wFELlfjyqb1FddfNV
         TrwLUxrEx2BTN+37vzMgVHm6s7lHxLPxt43ujWRXZn7Q0rvsKGL3Rp5UhUsAwS/2maja
         qghmEJHEA6hBaCgPOFfoY/ScWgRlQ0gEsYEB5F/p5EjsLwj2kYWV9rkWJVrtetGBXuGv
         goQfhjNw4KlzAkhEa7gpwYt46GStexItJLvfCwXF+gm9MVqpI/TtoBsFEgBFDJ0AHAsG
         VJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OvEjorEIx0jCUuaXWTFX/cePSI9jzuIRof4/xyfP0s4=;
        b=MbVsOmwGNrBEP3AwkmqLNZMAeaAL+I7ji+n+XVhUUp1MSa9CjupJ4nngNJnOzcx3AY
         9J3EhAa7Ij9VmcRIp9p0/fpBJgIBq6n306vkUxuGhK5rmCcU2kypHk2cusA3Il1Jy5Vw
         6a3m6Siwzk9jTaOwBEG3XLl+1YuScZHeZ+CxwvYwSccxvIFYNxraimfZV58NMRueu6+F
         eQ5n6Iv7eqqEiRysocfH1jOrenl4RFi6rBhB8uT0JtNDSEBc/rxwIls1HTmIByUbXp9b
         GKzMCnoWsCAtIhY22GZiwX9kv2PevKBnIuYYLA+djGxjJVxTsb05kqW5Lpv35kZEQ8Uj
         DhTQ==
X-Gm-Message-State: AOAM533KZ7Dz7hg4+LABjX0anb72IZ/NS8B3/25QXKTubLHB1WkmYeg+
        MFfMIuTn8OpjUABnV10YtXcoUMBxXw==
X-Google-Smtp-Source: ABdhPJzHnhgxvQWlSWYjeRtuwkDUSbPdSuHPILs2eVRl70hTck56iRIa5rjNuXGz9eMyY6WPVhX0tQ==
X-Received: by 2002:adf:cd08:: with SMTP id w8mr8461534wrm.426.1644780323055;
        Sun, 13 Feb 2022 11:25:23 -0800 (PST)
Received: from localhost.localdomain ([46.53.250.146])
        by smtp.gmail.com with ESMTPSA id 20sm8038513wmk.26.2022.02.13.11.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 11:25:22 -0800 (PST)
Date:   Sun, 13 Feb 2022 22:25:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt: move more stuff undef CONFIG_COREDUMP
Message-ID: <YglbIFyN+OtwVyjW@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct linux_binfmt::core_dump and struct min_coredump::min_coredump
are used under CONFIG_COREDUMP only. Shrink those embedded configs
a bit.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c         |    2 ++
 fs/binfmt_elf_fdpic.c   |    2 +-
 fs/binfmt_flat.c        |    2 ++
 include/linux/binfmts.h |    2 ++
 4 files changed, 7 insertions(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -101,8 +101,10 @@ static struct linux_binfmt elf_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_elf_binary,
 	.load_shlib	= load_elf_library,
+#ifdef CONFIG_COREDUMP
 	.core_dump	= elf_core_dump,
 	.min_coredump	= ELF_EXEC_PAGESIZE,
+#endif
 };
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -83,8 +83,8 @@ static struct linux_binfmt elf_fdpic_format = {
 	.load_binary	= load_elf_fdpic_binary,
 #ifdef CONFIG_ELF_CORE
 	.core_dump	= elf_fdpic_core_dump,
-#endif
 	.min_coredump	= ELF_EXEC_PAGESIZE,
+#endif
 };
 
 static int __init init_elf_fdpic_binfmt(void)
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -102,8 +102,10 @@ static int flat_core_dump(struct coredump_params *cprm);
 static struct linux_binfmt flat_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_flat_binary,
+#ifdef CONFIG_COREDUMP
 	.core_dump	= flat_core_dump,
 	.min_coredump	= PAGE_SIZE
+#endif
 };
 
 /****************************************************************************/
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -98,8 +98,10 @@ struct linux_binfmt {
 	struct module *module;
 	int (*load_binary)(struct linux_binprm *);
 	int (*load_shlib)(struct file *);
+#ifdef CONFIG_COREDUMP
 	int (*core_dump)(struct coredump_params *cprm);
 	unsigned long min_coredump;	/* minimal dump size */
+#endif
 } __randomize_layout;
 
 extern void __register_binfmt(struct linux_binfmt *fmt, int insert);
