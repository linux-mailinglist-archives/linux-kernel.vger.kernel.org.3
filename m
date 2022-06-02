Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3ED53BE86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbiFBTPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbiFBTPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:15:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1163F21262;
        Thu,  2 Jun 2022 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f84MadzXwfRXJHsldnaCF2HgU75EE9s1Ri+xqOCswaM=; b=LPBRxN+d8j76+ysX0LiMBnCTM4
        ZvT5XigVClHr8a0FDuFEXXpN3Y7tyJOLK/Tc5KColEF745uhexQDo5w3si2l4WVlR7k41/ES+G4Z7
        MKXVAhzLpXq4EwgcBOxF3JVyJMuam4IqqIF66OESbumg9l9cYdJhbJbET8n/TuJ/zHYbMVuelvv8f
        J6YHJlRulztPl22TjNnHSgchyh6xlJ8b4ihmfyy846hKgnp5crSLi91c0BZHzWtzSQ1oNJ/fVPTxw
        X2yi9qOIMwmMLrsOG9HyWOUWR1dp7yJLkEriNcpla62jRtOFUuD8J4IZUvJ+zQyUqlcAQlQJXihj3
        mjZtooog==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwqHa-0042tZ-2T; Thu, 02 Jun 2022 19:14:58 +0000
Date:   Thu, 2 Jun 2022 12:14:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Saravana Kannan <saravanak@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>, christophe.leroy@csgroup.eu,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        kernel-team@android.com
Subject: Re: [PATCH v12 01/14] module: Move all into module/
Message-ID: <YpkMMg8rskMRXfXS@bombadil.infradead.org>
References: <20220322140344.556474-2-atomlin@redhat.com>
 <20220602034111.4163292-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602034111.4163292-1-saravanak@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 08:41:11PM -0700, Saravana Kannan wrote:
> Aaron Tomlin <atomlin@redhat.com> wrote:
> > No functional changes.
> 
> I could be mistaken, but I think this has a functional change and could
> break module signature enforcement in some cases.
> 
> > 
> > This patch moves all module related code into a separate directory,
> > modifies each file name and creates a new Makefile. Note: this effort
> > is in preparation to refactor core module code.
> > 
> > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > ---
> >  MAINTAINERS                                         |  2 +-
> >  kernel/Makefile                                     |  5 +----
> >  kernel/module/Makefile                              | 12 ++++++++++++
> >  kernel/{module_decompress.c => module/decompress.c} |  2 +-
> >  kernel/{module-internal.h => module/internal.h}     |  0
> >  kernel/{module.c => module/main.c}                  |  2 +-
> >  kernel/{module_signing.c => module/signing.c}       |  2 +-
> 
> I spent at least an hour trying to figure out how the code below in
> module/signing.c (was moved from module/main.c in a later patch in this
> series) managed to have a "module" prefix for "module.sig_enforce" kernel
> cmdline param and for the /sys/module/module/parameters/sig_enforce file.
> 
> static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
> module_param(sig_enforce, bool_enable_only, 0644);
> 
> I thought I was missing something until I realized this was a very recent
> change and might actually be a bug. If I'm not mistaken, the prefix will
> now become "signing". So the kernel cmdline param would get ignore and any
> userspace writes to /sys/module/module/parameters/sig_enforce will start
> failing.
> 
> I don't have a device to boot 5.19-rcX in, but I think I'm right. Can
> someone confirm?
> 
> If my code analysis is right, then the fix seems to be adding this code
> before the module_param() line.
> 
> diff --git a/kernel/module/signing.c b/kernel/module/signing.c
> index 85c8999dfecf..6b0672e4417b 100644
> --- a/kernel/module/signing.c
> +++ b/kernel/module/signing.c
> @@ -16,6 +16,11 @@
>  #include <uapi/linux/module.h>
>  #include "internal.h"
>  
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +#define MODULE_PARAM_PREFIX "module."
> +
>  static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
>  module_param(sig_enforce, bool_enable_only, 0644);

That fix would make sense, can you send a proper patch ?
The form:

#ifdef MODULE_PARAM_PREFIX                                                   
#undef MODULE_PARAM_PREFIX                                                   
#endif                                                                       
#define MODULE_PARAM_PREFIX "whatever."

Is surprisingly actuaclly quite common, later on we should add helper
to make these more well known. Right now this is obscure tribal
knowledge when splitting up files.

  Luis
