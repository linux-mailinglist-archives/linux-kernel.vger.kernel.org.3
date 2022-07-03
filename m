Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1264564746
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiGCMbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCMbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 08:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A349C26D7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656851474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nK4ahcYY0WO5KebMw8df2u7hNaBerN6cj/QjBF2fJk4=;
        b=hBbvjlGD2q4CYPLB5CJyCUU9YKxAfStjwkQykNtDWyhBj42ZVCOcnP5TY9bLv3oBy3bDrE
        BXDK3AOsbY4QKEH85d2BJl4pwAwZC7XJW7pw1V8AxNm4z/Xv3kITmk4q/RA8Wh5QMuIACJ
        gzqWLBI4f303KLVGIR5aPxzAi6YtyKA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-IxPgXsGEMEuEbq9eGr3ktA-1; Sun, 03 Jul 2022 08:31:12 -0400
X-MC-Unique: IxPgXsGEMEuEbq9eGr3ktA-1
Received: by mail-wm1-f70.google.com with SMTP id o7-20020a05600c510700b003a18addaaa9so4093665wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 05:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nK4ahcYY0WO5KebMw8df2u7hNaBerN6cj/QjBF2fJk4=;
        b=V1P7DTmfWfqj76xBe+J9hgIBSZ+slkZtG08d8TbPM3NeMKNBaCPVzPoNAzOMLL/Q0s
         CMQY7QHwNjoVl1lxrahCHIP322ZjmVzD87/lT3Gdbw5nzbtyRwSbht+uMwdjJPsa1Syt
         ERfqmBpYmUfx2KJ4pzzEOFD7tf5hu6ao0zUko6OYswN+riLNQhHAQhdk0JggCsEek0Pz
         4a9Go+it7r3q3Go7e59VR/wztQvyvLaoDJp0VP90IB7qkX9OMNtjgm7POjGBUNytyeBc
         SGaYf2N7eNzuE3+JMFs1VR+8izF9t/RSg3iD3d1+XN3g7NtgfXbXiJ5JZcDEjyrVbsvm
         CPiw==
X-Gm-Message-State: AJIora/x5HGe7TlksCojR85/fXbVNSLcfpc0nuFgzgluW3I/cOgKQ+Ai
        7p3g1PZTzZgibRqibFWdJj/29zgMps/qrh+ZoHAGAeDr7CUIxXWhXTKKrAoqY6U3/U/prljgDvC
        Fnf9v4KFdya/ybFswDVXG6aA=
X-Received: by 2002:a5d:48cf:0:b0:210:1229:2e7 with SMTP id p15-20020a5d48cf000000b00210122902e7mr22092834wrs.567.1656851471636;
        Sun, 03 Jul 2022 05:31:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1swJauhVcRZc5PEe1i4cxgg4inMrv54zzjG82+59GDRFdfcac/oAFteoiFhrNgo5aPGUMZ6nA==
X-Received: by 2002:a5d:48cf:0:b0:210:1229:2e7 with SMTP id p15-20020a5d48cf000000b00210122902e7mr22092817wrs.567.1656851471447;
        Sun, 03 Jul 2022 05:31:11 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c47c500b0039c693a54ecsm19314211wmo.23.2022.07.03.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 05:31:10 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com, daniel.thompson@linaro.org, hch@infradead.org,
        tglx@linutronix.de, linux-rt-users@vger.kernel.org
Subject: [PATCH] module: kallsyms: Ensure preemption in add_kallsyms() with PREEMPT_RT
Date:   Sun,  3 Jul 2022 13:31:09 +0100
Message-Id: <20220703123109.3770204-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at add_kallsyms(), there is absolutely no need to explicitly
disable preemption. Before kallsyms-specific data is prepared/or set-up, we
ensure that the unformed module is known to be unique i.e. does not already
exist (see load_module()). Therefore, we can use the common RCU primitive
as this section of code can be pre-empted. In other words, it is safe to be
re-scheduled, in this context.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 08126db5ff73 ("module: kallsyms: Fix suspicious rcu usage")
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/kallsyms.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3e11523bc6f6..b16ff36b4b71 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -174,14 +174,14 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->kallsyms = (void __rcu *)mod->init_layout.base +
 		info->mod_kallsyms_init_off;
 
-	preempt_disable();
+	rcu_read_lock();
 	/* The following is safe since this pointer cannot change */
-	rcu_dereference_sched(mod->kallsyms)->symtab = (void *)symsec->sh_addr;
-	rcu_dereference_sched(mod->kallsyms)->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
+	rcu_dereference(mod->kallsyms)->symtab = (void *)symsec->sh_addr;
+	rcu_dereference(mod->kallsyms)->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
 	/* Make sure we get permanent strtab: don't use info->strtab. */
-	rcu_dereference_sched(mod->kallsyms)->strtab =
+	rcu_dereference(mod->kallsyms)->strtab =
 		(void *)info->sechdrs[info->index.str].sh_addr;
-	rcu_dereference_sched(mod->kallsyms)->typetab = mod->init_layout.base + info->init_typeoffs;
+	rcu_dereference(mod->kallsyms)->typetab = mod->init_layout.base + info->init_typeoffs;
 
 	/*
 	 * Now populate the cut down core kallsyms for after init
@@ -190,22 +190,22 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->core_kallsyms.symtab = dst = mod->data_layout.base + info->symoffs;
 	mod->core_kallsyms.strtab = s = mod->data_layout.base + info->stroffs;
 	mod->core_kallsyms.typetab = mod->data_layout.base + info->core_typeoffs;
-	src = rcu_dereference_sched(mod->kallsyms)->symtab;
-	for (ndst = i = 0; i < rcu_dereference_sched(mod->kallsyms)->num_symtab; i++) {
-		rcu_dereference_sched(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
+	src = rcu_dereference(mod->kallsyms)->symtab;
+	for (ndst = i = 0; i < rcu_dereference(mod->kallsyms)->num_symtab; i++) {
+		rcu_dereference(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
 		if (i == 0 || is_livepatch_module(mod) ||
 		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
 				   info->index.pcpu)) {
 			mod->core_kallsyms.typetab[ndst] =
-			    rcu_dereference_sched(mod->kallsyms)->typetab[i];
+			    rcu_dereference(mod->kallsyms)->typetab[i];
 			dst[ndst] = src[i];
 			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
 			s += strscpy(s,
-				     &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],
+				     &rcu_dereference(mod->kallsyms)->strtab[src[i].st_name],
 				     KSYM_NAME_LEN) + 1;
 		}
 	}
-	preempt_enable();
+	rcu_read_unlock();
 	mod->core_kallsyms.num_symtab = ndst;
 }
 
-- 
2.34.3

