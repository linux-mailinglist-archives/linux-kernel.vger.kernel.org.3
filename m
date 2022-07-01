Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC4563080
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiGAJoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiGAJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:44:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F305071BE4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656668659; x=1688204659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M8wTHUY0yoeEhvmBXz7drJQ+okeOeA7YaazWFhwMzkw=;
  b=FjFuR4KhWpzw26R2uwVXvlSmpl3qrIlsfkQzp4N1zKPcZnne75j+9WHv
   vzeE24xOTIGem5ZMrisLBfr9caM6F21+gJs1HkridlA6Zc/Tx2E9wr8JF
   ZweYmU7MSCIb6ScaSCdqoh2n5441O2Uu0YC+y+gB3om/QmOtAaNKMKX4Y
   6R6IqtICrqSyQwmpVRLSpjRkc1hOlr6gYUt/KiDADr31H2xrgeE/jykE4
   vVBoJ8gcSmd18l3ZtGD//NfVPFhLUElOKF+cJiRdmhaLcm2X8yTcXnVI4
   al7gOSTAnZHz/b7dqUaXtnpSYkwbbSP8l4iwIfiLK+lGFUIbJ9yyR9iLn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="280160786"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="280160786"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 02:44:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="624130231"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.48.203])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 02:44:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] modules: Fix corruption of /proc/kallsyms
Date:   Fri,  1 Jul 2022 12:44:03 +0300
Message-Id: <20220701094403.3044-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 91fb02f31505 ("module: Move kallsyms support into a separate
file") changed from using strlcpy() to using strscpy() which created a
buffer overflow. That happened because:
 1) an incorrect value was passed as the buffer length
 2) strscpy() (unlike strlcpy()) may copy beyond the length of the
    input string when copying word-by-word.
The assumption was that because it was already known that the strings
being copied would fit in the space available, it was not necessary
to correctly set the buffer length.  strscpy() breaks that assumption
because although it will not touch bytes beyond the given buffer length
it may write bytes beyond the input string length when writing
word-by-word.

The result of the buffer overflow is to corrupt the symbol type
information that follows. e.g.

 $ sudo cat -v /proc/kallsyms | grep '\^' | head
 ffffffffc0615000 ^@ rfcomm_session_get  [rfcomm]
 ffffffffc061c060 ^@ session_list        [rfcomm]
 ffffffffc06150d0 ^@ rfcomm_send_frame   [rfcomm]
 ffffffffc0615130 ^@ rfcomm_make_uih     [rfcomm]
 ffffffffc07ed58d ^@ bnep_exit   [bnep]
 ffffffffc07ec000 ^@ bnep_rx_control     [bnep]
 ffffffffc07ec1a0 ^@ bnep_session        [bnep]
 ffffffffc07e7000 ^@ input_leds_event    [input_leds]
 ffffffffc07e9000 ^@ input_leds_handler  [input_leds]
 ffffffffc07e7010 ^@ input_leds_disconnect       [input_leds]

Notably, the null bytes (represented above by ^@) can confuse tools.

Fix by correcting the buffer length.

Fixes: 91fb02f31505 ("module: Move kallsyms support into a separate file")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/module/kallsyms.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3e11523bc6f6..18c23545b984 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -137,6 +137,7 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	info->symoffs = ALIGN(mod->data_layout.size, symsect->sh_addralign ?: 1);
 	info->stroffs = mod->data_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
 	mod->data_layout.size += strtab_size;
+	/* Note add_kallsyms() computes strtab_size as core_typeoffs - stroffs */
 	info->core_typeoffs = mod->data_layout.size;
 	mod->data_layout.size += ndst * sizeof(char);
 	mod->data_layout.size = strict_align(mod->data_layout.size);
@@ -169,6 +170,7 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	Elf_Sym *dst;
 	char *s;
 	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
+	unsigned long strtab_size;
 
 	/* Set up to point into init section. */
 	mod->kallsyms = (void __rcu *)mod->init_layout.base +
@@ -190,19 +192,26 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->core_kallsyms.symtab = dst = mod->data_layout.base + info->symoffs;
 	mod->core_kallsyms.strtab = s = mod->data_layout.base + info->stroffs;
 	mod->core_kallsyms.typetab = mod->data_layout.base + info->core_typeoffs;
+	strtab_size = info->core_typeoffs - info->stroffs;
 	src = rcu_dereference_sched(mod->kallsyms)->symtab;
 	for (ndst = i = 0; i < rcu_dereference_sched(mod->kallsyms)->num_symtab; i++) {
 		rcu_dereference_sched(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
 		if (i == 0 || is_livepatch_module(mod) ||
 		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
 				   info->index.pcpu)) {
+			ssize_t ret;
+
 			mod->core_kallsyms.typetab[ndst] =
 			    rcu_dereference_sched(mod->kallsyms)->typetab[i];
 			dst[ndst] = src[i];
 			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
-			s += strscpy(s,
-				     &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],
-				     KSYM_NAME_LEN) + 1;
+			ret = strscpy(s,
+				      &rcu_dereference_sched(mod->kallsyms)->strtab[src[i].st_name],
+				      strtab_size);
+			if (ret < 0)
+				break;
+			s += ret + 1;
+			strtab_size -= ret + 1;
 		}
 	}
 	preempt_enable();
-- 
2.25.1

