Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEC64C6931
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiB1K7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiB1K7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:59:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C4B74624;
        Mon, 28 Feb 2022 02:56:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E807D1F894;
        Mon, 28 Feb 2022 10:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646045800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOtMt6fswCb5ZWsDNnRLRm7wpeTZh52gBJXWt9L6fr0=;
        b=H9CRUmIpY2VdMp0v56pKBAGoROmwwLNzhmTDuarydjBVLKebrYEYU4ulZHYl3BEnO7Y3KB
        neIUltDSwb0R6oG4tLSM9DN2lBgvhTGn0YnCBQAuLF782/5T5j5glksrFte8ym/MLQVbjD
        3+PiEWmemOdzw5/dCDpKKR+C9fH0UB8=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D147A3B81;
        Mon, 28 Feb 2022 10:56:40 +0000 (UTC)
Date:   Mon, 28 Feb 2022 11:56:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v8 04/13] module: Move livepatch support to a separate
 file
Message-ID: <YhyqaGO+vbGOifpR@alley>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-5-atomlin@redhat.com>
 <Yhiik2ledqAfGuN2@alley>
 <fb1bb248-bd3f-0990-cdfd-d186b7579411@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb1bb248-bd3f-0990-cdfd-d186b7579411@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-02-25 16:49:31, Christophe Leroy wrote:
> 
> 
> Le 25/02/2022 à 10:34, Petr Mladek a écrit :
> > On Tue 2022-02-22 14:12:54, Aaron Tomlin wrote:
> >> No functional change.
> >>
> >> This patch migrates livepatch support (i.e. used during module
> >> add/or load and remove/or deletion) from core module code into
> >> kernel/module/livepatch.c. At the moment it contains code to
> >> persist Elf information about a given livepatch module, only.
> >>
> > --- del.p	2022-02-24 16:55:26.570054922 +0100
> > +++ add.p	2022-02-24 16:56:04.766781394 +0100
> > @@ -3,14 +3,14 @@
> >    * section header table, section string table, and symtab section
> >    * index from info to mod->klp_info.
> >    */
> > -static int copy_module_elf(struct module *mod, struct load_info *info)
> > +int copy_module_elf(struct module *mod, struct load_info *info)
> 
> That's not a hidden change. That's part of the move, that's required.

Sure. I was not talking about this line. I kept it to show the context.

> >   {
> >   	unsigned int size, symndx;
> >   	int ret;
> >   
> >   	size = sizeof(*mod->klp_info);
> >   	mod->klp_info = kmalloc(size, GFP_KERNEL);
> > -	if (mod->klp_info == NULL)
> > +	if (!mod->klp_info)
> >   		return -ENOMEM;
> >   
> >   	/* Elf header */
> > @@ -20,7 +20,7 @@ static int copy_module_elf(struct module
> >   	/* Elf section header table */
> >   	size = sizeof(*info->sechdrs) * info->hdr->e_shnum;
> >   	mod->klp_info->sechdrs = kmemdup(info->sechdrs, size, GFP_KERNEL);
> > -	if (mod->klp_info->sechdrs == NULL) {
> > +	if (!mod->klp_info->sechdrs) {
> >   		ret = -ENOMEM;
> >   		goto free_info;
> >   	}
> > @@ -28,7 +28,7 @@ static int copy_module_elf(struct module
> >   	/* Elf section name string table */
> >   	size = info->sechdrs[info->hdr->e_shstrndx].sh_size;
> >   	mod->klp_info->secstrings = kmemdup(info->secstrings, size, GFP_KERNEL);
> > -	if (mod->klp_info->secstrings == NULL) {
> > +	if (!mod->klp_info->secstrings) {
> >   		ret = -ENOMEM;
> >   		goto free_sechdrs;
> >   	}
> > @@ -43,8 +43,7 @@ static int copy_module_elf(struct module
> >   	 * to core_kallsyms.symtab since the copy of the symtab in module
> >   	 * init memory is freed at the end of do_init_module().
> >   	 */
> > -	mod->klp_info->sechdrs[symndx].sh_addr = \
> > -		(unsigned long) mod->core_kallsyms.symtab;
> > +	mod->klp_info->sechdrs[symndx].sh_addr = (unsigned long)mod->core_kallsyms.symtab;
> >   
> >   	return 0;
> > 
> > 
> > Please do not do these small coding style changes. It complicates the
> > review and increases the risk of regressions. Different people
> > have different preferences. Just imagine that every half a year
> > someone update style of a code by his personal preferences. The
> > real changes will then get lost in a lot of noise.
> 
> I disagree here. We are not talking about people's preference here but 
> compliance with documented Linux kernel Codying Style and handling of 
> official checkpatch.pl script reports.

Really?

1. I restored

	+	if (mod->klp_info->secstrings == NULL) {

   and checkpatch.pl is happy.


2. I do not see anythinkg about if (xxx == NULL) checks in
   Documentation/process/coding-style.rst

3. $> git grep "if (.* == NULL" | wc -l
   15041

4. The result of
	-	mod->klp_info->sechdrs[symndx].sh_addr = \
	-		(unsigned long) mod->core_kallsyms.symtab;
	+	mod->klp_info->sechdrs[symndx].sh_addr = (unsigned long)mod->core_kallsyms.symtab;

   is 90 characeters long and Documentation/process/coding-style.rst says:

	2) Breaking long lines and strings
	----------------------------------

	Coding style is all about readability and maintainability using commonly
	available tools.

	The preferred limit on the length of a single line is 80 columns.

	Statements longer than 80 columns should be broken into sensible chunks,
	unless exceeding 80 columns significantly increases readability and does
	not hide information.

   checkpatch.pl accepts lines up to 100 columns but 80 are still
   preferred.


> You are right that randomly updating the style every half a year would 
> be a nightmare and would kill blamability of changes.
> 
> However when moving big peaces of code like this, blamability is broken 
> anyway and this is a very good opportunity to increase compliance of 
> kernel code to its own codying style. But doing it in several steps 
> increases code churn and has no real added value.

From Documentation/process/submitting-patches.rst:

	One significant exception is when moving code from one file to
	another -- in this case you should not modify the moved code at all in
	the same patch which moves it.  This clearly delineates the act of
	moving the code and your changes.  This greatly aids review of the
	actual differences and allows tools to better track the history of
	the code itself.


> > 
> > Coding style changes might be acceptable only when the code is
> > reworked or when it significantly improves readability.
> 
> When code is moved around it is also a good opportunity.

No!

I would not have complained if it did not complicate my review.
But it did!

Best Regards,
Petr
