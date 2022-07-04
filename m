Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39A4565B84
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiGDQTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiGDQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FB0312AF7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656951484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fFo1Gztfi7kgv8mceCsQUHgfH8ojypad3OlaiOUxnPI=;
        b=GoLODNTkNvJ/rb1u9gPVPVGlj9HF54P0/YHZAdihSBEc8gZGxFchIWvkHNdGU2+4WxHIvP
        b7SM74VhGcte6iB1qsKO0aJollOQGpzc40sP4QSa8HRUkeN+wQe51MVq4Mch5DLxdH+a7u
        zqp91GNTZWgsFsgoFHPW4NAJWINABlQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-tZOa08yNOgufD5zMfjNO4A-1; Mon, 04 Jul 2022 12:17:55 -0400
X-MC-Unique: tZOa08yNOgufD5zMfjNO4A-1
Received: by mail-wm1-f72.google.com with SMTP id az35-20020a05600c602300b003a1867d09b5so3322204wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 09:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fFo1Gztfi7kgv8mceCsQUHgfH8ojypad3OlaiOUxnPI=;
        b=2MDcCrEN3b011Q9OerEYqKavVSen8rpipy9LnAgXeggeNAlK+ta91eXJkkMySNqdko
         VDEBLwaFJBhZrUAEyR8Y5HYDWhVkU4OWMKR/Uzv33FUk6F0DYijjiA9lZ7WedZBacE/b
         mWokLwt7x+eegtTIzlqN+cWYywfkBqtE6eL1bSDYs9X6XswXTsSzXbCUfRfEM1tkdvis
         Ne6LaB4MsZm+cepC4h7WJYOjDACZGWikTiNBO/k4+o+BpvZsoc0bWnc63NegnmWccqBk
         3ho/bBF7g3bY1BmPJEWY/aMmVvwFtmVrWoc4YoxG+5O7z3Wy3zGyzCHd2MYBx1BDRxGU
         V4YA==
X-Gm-Message-State: AJIora9Hdk9r5V37oA9oLHQVSNwWqNq4WE0U2FzHeGvHg5WDOE0dXMoF
        AF2i+KE3lLdAGC4RPPExFcQIBEXuuYNM1netvS9r3ARLk8iKJ7UeLlfJTWYOe3b5teEv+7gzYi5
        pvEOW1fBiNVifZz36a700bnY=
X-Received: by 2002:adf:f24c:0:b0:21d:31c5:ecdc with SMTP id b12-20020adff24c000000b0021d31c5ecdcmr24675475wrp.117.1656951474366;
        Mon, 04 Jul 2022 09:17:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tyOteUULtuiy9WslLyjcSRKCS+ZDX9Lyu3zOkbMt/1zDWdYRgY+4fWxBLH6oXO9ryG6ChKLA==
X-Received: by 2002:adf:f24c:0:b0:21d:31c5:ecdc with SMTP id b12-20020adff24c000000b0021d31c5ecdcmr24675458wrp.117.1656951474166;
        Mon, 04 Jul 2022 09:17:54 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b0039c4e2ff7cfsm17019931wmq.43.2022.07.04.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:17:53 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com, daniel.thompson@linaro.org, hch@infradead.org,
        tglx@linutronix.de, linux-rt-users@vger.kernel.org
Subject: [PATCH v2] module: kallsyms: Ensure preemption in add_kallsyms() with PREEMPT_RT
Date:   Mon,  4 Jul 2022 17:17:53 +0100
Message-Id: <20220704161753.4033684-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To disable preemption in the context of add_kallsyms() is incorrect.

Before kallsyms-specific data is prepared/or set-up, we ensure that
the unformed module is known to be unique i.e. does not already exist
(see load_module()). Therefore, we can fix this by using the common RCU
primitive as this section of code can be safely preempted.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 08126db5ff73 ("module: kallsyms: Fix suspicious rcu usage")
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/kallsyms.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3e11523bc6f6..0b6fd82d5898 100644
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
-			s += strscpy(s,
-				     &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],
+			s += strlcpy(s,
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

