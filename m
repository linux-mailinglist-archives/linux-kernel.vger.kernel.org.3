Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50551AF1A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378025AbiEDUeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378062AbiEDUeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:34:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB7E2B;
        Wed,  4 May 2022 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=meJPT/FhJ0t/HxCnUl9CRH+QfNVPReDG9ZhriBQxFCY=; b=pLYhjoEj6qFf8XaRBebMuhPHUH
        suyXEPq2mEYfo56Vk96bJ/+ovqCcO21nwCbGFaSzYhaFiJtoPHRD3mQZK3YgS8YlPAo3bhORPthpB
        FvRjH6bshBTryeJk8eooSm/zrjhE+0pf5ZF95NHeIrkwN5dTnnBEY/pUXgDbXzcQyYbbRT9JyDj86
        4uTLavN0VRsiT0XyxYtWOH9f9k+9n+5JC0bZ3ot1twjcM8FWsVKwdaeePEkFtWUnOX62mK+W1VkM1
        MWEFn6KtA1UkQFUuPVgGreAu+DZzj8+Z02af/ycm0Q/OKc7JeX1GJdEUdQHFSTigVUHpnKrLhRL8E
        kbkth4lg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmLdY-00CZDY-Vg; Wed, 04 May 2022 20:30:17 +0000
Date:   Wed, 4 May 2022 13:30:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Frank van der Linden <fllinden@amazon.com>
Subject: Re: [PATCH v2] module: fix [e_shstrndx].sh_size=0 OOB access
Message-ID: <YnLiWHx24nTmhIM5@bombadil.infradead.org>
References: <YnFC93NVRqOterbV@localhost.localdomain>
 <YnGNSNcUbkwLNWNd@bombadil.infradead.org>
 <YnJNTIJeB2NHK9Jh@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnJNTIJeB2NHK9Jh@localhost.localdomain>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 12:54:20PM +0300, Alexey Dobriyan wrote:
> It is trivial to craft a module to trigger OOB access in this line:
> 
> 	if (info->secstrings[strhdr->sh_size - 1] != '\0') {
> 
> BUG: unable to handle page fault for address: ffffc90000aa0fff
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 100000067 P4D 100000067 PUD 100066067 PMD 10436f067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 7 PID: 1215 Comm: insmod Not tainted 5.18.0-rc5-00007-g9bf578647087-dirty #10
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
> RIP: 0010:load_module+0x19b/0x2391
> 
> Fixes: ec2a29593c83 ("module: harden ELF info handling")
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Thanks! I rebased your patch onto modules-next [0] and applied onto
modules-testing and pushed out there. If that doesn't break I'll then
push to modules-next as well.

  Luis
