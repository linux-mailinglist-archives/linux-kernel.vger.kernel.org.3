Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE734C4182
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbiBYJer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbiBYJep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:34:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5571F7677;
        Fri, 25 Feb 2022 01:34:13 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 122501F44C;
        Fri, 25 Feb 2022 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645781652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=clSsv84RFrFhIi1aIZShVR05rIAJiV9n1vqCC48zZGc=;
        b=ARN+A9Xaf+ztw9dcOCSmHx9gxMDZtJYWf5mQhIp0sqYuFXdUtwEc+tSfuEQVYRU4FSX8df
        o12s+suNZBytoH45jqslpsCA3QwC597sJdo/Z3xUxu2/lJ8r+VsWYVmNa2hdTpcmHfOuhM
        kZZdEFpWSN+/qj13C9srHTX4MLFzcck=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CF203A3B84;
        Fri, 25 Feb 2022 09:34:11 +0000 (UTC)
Date:   Fri, 25 Feb 2022 10:34:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: Re: [PATCH v8 04/13] module: Move livepatch support to a separate
 file
Message-ID: <Yhiik2ledqAfGuN2@alley>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-5-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222141303.1392190-5-atomlin@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-22 14:12:54, Aaron Tomlin wrote:
> No functional change.
> 
> This patch migrates livepatch support (i.e. used during module
> add/or load and remove/or deletion) from core module code into
> kernel/module/livepatch.c. At the moment it contains code to
> persist Elf information about a given livepatch module, only.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>

> diff --git a/kernel/module/livepatch.c b/kernel/module/livepatch.c
> new file mode 100644
> index 000000000000..486d4ff92719
> --- /dev/null
> +++ b/kernel/module/livepatch.c
> @@ -0,0 +1,74 @@
> + * Persist Elf information about a module. Copy the Elf header,
> + * section header table, section string table, and symtab section
> + * index from info to mod->klp_info.
> + */
> +int copy_module_elf(struct module *mod, struct load_info *info)
> +{
> +	unsigned int size, symndx;
> +	int ret;
> +
> +	size = sizeof(*mod->klp_info);
> +	mod->klp_info = kmalloc(size, GFP_KERNEL);
> +	if (!mod->klp_info)
> +		return -ENOMEM;
> +
> +	/* Elf header */
> +	size = sizeof(mod->klp_info->hdr);
> +	memcpy(&mod->klp_info->hdr, info->hdr, size);
> +
> +	/* Elf section header table */
> +	size = sizeof(*info->sechdrs) * info->hdr->e_shnum;
> +	mod->klp_info->sechdrs = kmemdup(info->sechdrs, size, GFP_KERNEL);
> +	if (!mod->klp_info->sechdrs) {
> +		ret = -ENOMEM;
> +		goto free_info;
> +	}
> +
> +	/* Elf section name string table */
> +	size = info->sechdrs[info->hdr->e_shstrndx].sh_size;
> +	mod->klp_info->secstrings = kmemdup(info->secstrings, size, GFP_KERNEL);
> +	if (!mod->klp_info->secstrings) {
> +		ret = -ENOMEM;
> +		goto free_sechdrs;
> +	}
> +
> +	/* Elf symbol section index */
> +	symndx = info->index.sym;
> +	mod->klp_info->symndx = symndx;
> +
> +	/*
> +	 * For livepatch modules, core_kallsyms.symtab is a complete
> +	 * copy of the original symbol table. Adjust sh_addr to point
> +	 * to core_kallsyms.symtab since the copy of the symtab in module
> +	 * init memory is freed at the end of do_init_module().
> +	 */
> +	mod->klp_info->sechdrs[symndx].sh_addr = (unsigned long)mod->core_kallsyms.symtab;
> +
> +	return 0;

This code include several other well hidden changes:

--- del.p	2022-02-24 16:55:26.570054922 +0100
+++ add.p	2022-02-24 16:56:04.766781394 +0100
@@ -3,14 +3,14 @@
  * section header table, section string table, and symtab section
  * index from info to mod->klp_info.
  */
-static int copy_module_elf(struct module *mod, struct load_info *info)
+int copy_module_elf(struct module *mod, struct load_info *info)
 {
 	unsigned int size, symndx;
 	int ret;
 
 	size = sizeof(*mod->klp_info);
 	mod->klp_info = kmalloc(size, GFP_KERNEL);
-	if (mod->klp_info == NULL)
+	if (!mod->klp_info)
 		return -ENOMEM;
 
 	/* Elf header */
@@ -20,7 +20,7 @@ static int copy_module_elf(struct module
 	/* Elf section header table */
 	size = sizeof(*info->sechdrs) * info->hdr->e_shnum;
 	mod->klp_info->sechdrs = kmemdup(info->sechdrs, size, GFP_KERNEL);
-	if (mod->klp_info->sechdrs == NULL) {
+	if (!mod->klp_info->sechdrs) {
 		ret = -ENOMEM;
 		goto free_info;
 	}
@@ -28,7 +28,7 @@ static int copy_module_elf(struct module
 	/* Elf section name string table */
 	size = info->sechdrs[info->hdr->e_shstrndx].sh_size;
 	mod->klp_info->secstrings = kmemdup(info->secstrings, size, GFP_KERNEL);
-	if (mod->klp_info->secstrings == NULL) {
+	if (!mod->klp_info->secstrings) {
 		ret = -ENOMEM;
 		goto free_sechdrs;
 	}
@@ -43,8 +43,7 @@ static int copy_module_elf(struct module
 	 * to core_kallsyms.symtab since the copy of the symtab in module
 	 * init memory is freed at the end of do_init_module().
 	 */
-	mod->klp_info->sechdrs[symndx].sh_addr = \
-		(unsigned long) mod->core_kallsyms.symtab;
+	mod->klp_info->sechdrs[symndx].sh_addr = (unsigned long)mod->core_kallsyms.symtab;
 
 	return 0;


Please do not do these small coding style changes. It complicates the
review and increases the risk of regressions. Different people
have different preferences. Just imagine that every half a year
someone update style of a code by his personal preferences. The
real changes will then get lost in a lot of noise.

Coding style changes might be acceptable only when the code is
reworked or when it significantly improves readability.


That said. I reviewed and tested this patch and did not find any
problem. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Please, take the above as an advice for your future work.

Best Regards,
Petr
