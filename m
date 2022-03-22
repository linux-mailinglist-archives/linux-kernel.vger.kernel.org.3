Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7E4E4010
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiCVOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbiCVOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D5C433E35
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647957857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlcVw0WJ8YWnydchI7778Sj1W6AqsxSBROpPSypOfl0=;
        b=WKfhnebsoZHYFGBS84LfbnyjSehcBu1zvWMi0FovQ8aZICs7Jg0LhRrDUhlvMsKCH3tGpZ
        Aidq6nXja1fZohwyWosPc1iM3Bbf80frOT2MCOYw43Hx4Mm7q0J5IL1EY6JKc99wTpnyjt
        i8o4SODEDtIAH70pwBj9Qu7ohNNPP9o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-4OVBj76CP6aNAGD4JxpB4g-1; Tue, 22 Mar 2022 10:04:16 -0400
X-MC-Unique: 4OVBj76CP6aNAGD4JxpB4g-1
Received: by mail-wm1-f69.google.com with SMTP id r64-20020a1c2b43000000b0038b59eb1940so1246438wmr.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlcVw0WJ8YWnydchI7778Sj1W6AqsxSBROpPSypOfl0=;
        b=iJqZwNfHMEB2ds0l9XeoevyTa475GcBnw4nlRzbPrnbN/uqdVYy2oFRiEEXKpTN65i
         J30LhZgLieDf4l7GF284lKd5wDK/ijLQus7uXguImI0sutnoUTG7qrv4EtvMdvOT/4Du
         itMhstJUjSXD+cP2WbuW8Br+qYv/x66OHhB0I9QlUhsKmFsA5jrxvp5nWz5ZCywvIgii
         pyihUqBK3fGcQM/H8Txid62Vc+8O8uv3uz0R5TdBAmSbpbV1AlTehqZWE1+BO8rgEkiD
         vPKUN7qPDwyV6gBOViY1Dl5PnJZT2OIO8+VRaGKrJn/wKl9QHBtZjUDvowub/YCcThAa
         SsQA==
X-Gm-Message-State: AOAM532VfdfQ4dFwGRc4e6XbzD9YNFusdCJR7CkmFZhLgE04bSKmjdJH
        /WC8U21cJoV2C8CLEvi7rbIoS1xYscil+KMkFRQeI3+qLP+IlsXtUsG+9MGkvBG7HSggQP0/SAz
        4CK/Vj7RXuTtGEbSyS96jZZ8=
X-Received: by 2002:a05:600c:4ec8:b0:38c:90fb:d3bf with SMTP id g8-20020a05600c4ec800b0038c90fbd3bfmr3976933wmq.0.1647957854916;
        Tue, 22 Mar 2022 07:04:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxizalQ9ORSJ8+hcLd+G75AwRm9jc84wzGbMW0EKlqUFuMKH++vTXi3UPoreWCIviGwJH4Xyg==
X-Received: by 2002:a05:600c:4ec8:b0:38c:90fb:d3bf with SMTP id g8-20020a05600c4ec800b0038c90fbd3bfmr3976910wmq.0.1647957854706;
        Tue, 22 Mar 2022 07:04:14 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b3-20020adfd1c3000000b00205820686dasm16295wrd.5.2022.03.22.07.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:04:13 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v12 10/14] module: kallsyms: Fix suspicious rcu usage
Date:   Tue, 22 Mar 2022 14:03:40 +0000
Message-Id: <20220322140344.556474-11-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220322140344.556474-1-atomlin@redhat.com>
References: <20220322140344.556474-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

The purpose of this patch is to address the various Sparse warnings
due to the incorrect dereference/or access of an __rcu pointer.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/kallsyms.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 1b0780e20aab..a3da0686a2a6 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -171,14 +171,17 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
 
 	/* Set up to point into init section. */
-	mod->kallsyms = mod->init_layout.base + info->mod_kallsyms_init_off;
+	mod->kallsyms = (void __rcu *)mod->init_layout.base +
+		info->mod_kallsyms_init_off;
 
+	preempt_disable();
 	/* The following is safe since this pointer cannot change */
-	mod->kallsyms->symtab = (void *)symsec->sh_addr;
-	mod->kallsyms->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
+	rcu_dereference_sched(mod->kallsyms)->symtab = (void *)symsec->sh_addr;
+	rcu_dereference_sched(mod->kallsyms)->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
 	/* Make sure we get permanent strtab: don't use info->strtab. */
-	mod->kallsyms->strtab = (void *)info->sechdrs[info->index.str].sh_addr;
-	mod->kallsyms->typetab = mod->init_layout.base + info->init_typeoffs;
+	rcu_dereference_sched(mod->kallsyms)->strtab =
+		(void *)info->sechdrs[info->index.str].sh_addr;
+	rcu_dereference_sched(mod->kallsyms)->typetab = mod->init_layout.base + info->init_typeoffs;
 
 	/*
 	 * Now populate the cut down core kallsyms for after init
@@ -187,20 +190,22 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->core_kallsyms.symtab = dst = mod->core_layout.base + info->symoffs;
 	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
 	mod->core_kallsyms.typetab = mod->core_layout.base + info->core_typeoffs;
-	src = mod->kallsyms->symtab;
-	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
-		mod->kallsyms->typetab[i] = elf_type(src + i, info);
+	src = rcu_dereference_sched(mod->kallsyms)->symtab;
+	for (ndst = i = 0; i < rcu_dereference_sched(mod->kallsyms)->num_symtab; i++) {
+		rcu_dereference_sched(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
 		if (i == 0 || is_livepatch_module(mod) ||
 		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
 				   info->index.pcpu)) {
 			mod->core_kallsyms.typetab[ndst] =
-			    mod->kallsyms->typetab[i];
+			    rcu_dereference_sched(mod->kallsyms)->typetab[i];
 			dst[ndst] = src[i];
 			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
-			s += strscpy(s, &mod->kallsyms->strtab[src[i].st_name],
+			s += strscpy(s,
+				     &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],
 				     KSYM_NAME_LEN) + 1;
 		}
 	}
+	preempt_enable();
 	mod->core_kallsyms.num_symtab = ndst;
 }
 
@@ -478,11 +483,16 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 
 	mutex_lock(&module_mutex);
 	list_for_each_entry(mod, &modules, list) {
-		/* We hold module_mutex: no need for rcu_dereference_sched */
-		struct mod_kallsyms *kallsyms = mod->kallsyms;
+		struct mod_kallsyms *kallsyms;
 
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
+
+		/* Use rcu_dereference_sched() to remain compliant with the sparse tool */
+		preempt_disable();
+		kallsyms = rcu_dereference_sched(mod->kallsyms);
+		preempt_enable();
+
 		for (i = 0; i < kallsyms->num_symtab; i++) {
 			const Elf_Sym *sym = &kallsyms->symtab[i];
 
-- 
2.34.1

