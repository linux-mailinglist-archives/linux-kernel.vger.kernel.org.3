Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1E14C7EA2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiB1XpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiB1Xok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:44:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44AFCF65E2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646091829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlcVw0WJ8YWnydchI7778Sj1W6AqsxSBROpPSypOfl0=;
        b=jMXBTMyBieodkQ8Q4xoeABhYVDgpcxjrEWfYRVnvumd5ZIz4BmzhrBPRb0Nvj0GA5rKggD
        F72R6WVdbVPSQWhZAtzvNNfF31Fbt6x082t5ZBRyIeArOhVid3bv/RfFVZgJPUIVo4e/Si
        E0UdAaWYfNqfsBPG69SS15w72ufrRCs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-MmJJ6Sy3N1e0uo3w4VdYFA-1; Mon, 28 Feb 2022 18:43:47 -0500
X-MC-Unique: MmJJ6Sy3N1e0uo3w4VdYFA-1
Received: by mail-wr1-f71.google.com with SMTP id a11-20020adffb8b000000b001efe754a488so1097415wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlcVw0WJ8YWnydchI7778Sj1W6AqsxSBROpPSypOfl0=;
        b=GZLJD02ASNOXtnzG6w1tUOaNbP8NhmdLXXFO4ZpZHWJrK6i2gENL4kT/o4/HNc/N/F
         Xe5IIc3uRlBsnuS9En4SrQs1dbj1dXrTgd2np/im15mzqcn5m3of8/Sm/pZQEx8h94j3
         40/SSgq1zokbmPcwavMqxGxz5fMVA3WswfyxZAlzmKcD3YaksXOHmjwESKjA69ONdXTP
         ODx2GzamgZJ3+KCG9Rqc+wjg/KekcaqG+pKc8IWAVKEvnD/8bE9py6gIrrq8vfdCdwtT
         ULJMTd+FCzrf5a5/56B8YpjizARQvb8PNbN1dugN5O7RNcHnfXTMyfJMFiq67RsWvvBM
         L00A==
X-Gm-Message-State: AOAM531hQRJ+49E2bFfiENczh5Zl782IpDBST4AYSZIodwWE1w32WHHN
        mB1NEuNactx7NRtXHRlpv3Wxdd5zSRDlvnIh67N2RzgNgt60jDOe41LkuPuzB6r3I/K4aW5tOBn
        EEfvAvJ3IZ7+W6KpmY98kufY=
X-Received: by 2002:adf:e5c1:0:b0:1ed:bf25:b924 with SMTP id a1-20020adfe5c1000000b001edbf25b924mr16853877wrn.136.1646091826497;
        Mon, 28 Feb 2022 15:43:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8G0j/K/4wCVW0BgGU1xWfpER4AoHHKdVwVoErwge2rAdB5beHRqvNp7GEiuUT3guLZKqvPw==
X-Received: by 2002:adf:e5c1:0:b0:1ed:bf25:b924 with SMTP id a1-20020adfe5c1000000b001edbf25b924mr16853862wrn.136.1646091826312;
        Mon, 28 Feb 2022 15:43:46 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c15c500b003810188b6basm708451wmf.28.2022.02.28.15.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:43:45 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org
Subject: [PATCH v9 10/14] module: kallsyms: Fix suspicious rcu usage
Date:   Mon, 28 Feb 2022 23:43:18 +0000
Message-Id: <20220228234322.2073104-11-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228234322.2073104-1-atomlin@redhat.com>
References: <20220228234322.2073104-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

