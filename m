Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FDB4ED165
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 03:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352346AbiCaBr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 21:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351137AbiCaBrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ACF483AD;
        Wed, 30 Mar 2022 18:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43FDC6192E;
        Thu, 31 Mar 2022 01:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE09C340EC;
        Thu, 31 Mar 2022 01:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648691136;
        bh=Jimtgh3p6x6lop7aLuuAmOqnI7ccoKcZs8IHWD2GpGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qNC+DM/cW/6WVIsIxQtRAC3fhgtL3MuaGT/uJg7dje1cwn9dAYJfJ9BduTQlqjc+R
         x0cHOdSyhnBtxOJiI3RKoPDdKjvDg/Mg1QHfkcSagCDzoSt2oRVgMPPUWS0lsQEKXJ
         uenpSQuyZlFPmW0MOrG7b8Bfv845s8vzFSqNIh0I9vnS6tcAAQsq4G42ooiHajlJxR
         6tUjp1E3UrtdHBX4VDqAY95nlJmm4CpsliW+17gmxB3Y5DgGEbmbC7pTIAru6vEgU/
         6G/S+8dnDUioKP9PJcdpVH7K+Hq93j9wXJ0jznGsfd3GTHpASuTgmd/0o+nLESGRuD
         b+cISJGyX/1gQ==
Date:   Thu, 31 Mar 2022 10:45:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] bootconfig: Support embedding a bootconfig in
 kernel for non initrd boot
Message-Id: <20220331104531.81d0edf9a85a4f69020a9f13@kernel.org>
In-Reply-To: <CAKwvOdmAYQZtzGudBjmiRZNjT+VixTdNbJmYmxc7-gQNCsHfrA@mail.gmail.com>
References: <164847778869.3060675.8115416881394543419.stgit@devnote2>
        <CAKwvOdmAYQZtzGudBjmiRZNjT+VixTdNbJmYmxc7-gQNCsHfrA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Wed, 30 Mar 2022 11:04:50 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Mon, Mar 28, 2022 at 7:29 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > KNOWN ISSUE:
> >
> > According to the report from Padmanabha[3] and my analysis [4], the embedded
> > bootconfig data may not be updated if you do incremental build the kernel
> > with CONFIG_LTO_CLANG_THIN.
> >
> > [3] https://lore.kernel.org/all/20220321183500.GA4065@pswork/T/#u
> > [4] https://lore.kernel.org/all/20220327115526.cc4b0ff55fc53c97683c3e4d@kernel.org/
> >
> > This seems like clang's LTO Thin mode issue. It may not detect the inline
> > asm depends on external files.
> >
> > I think the possible workaround is to split the inline asm which includes
> > '.incbin' directive into an asm file. But this should be done in another
> > seires because there are other features which uses '.incbin'. (e.g.
> > /proc/config.gz)
> 
> Hi Masami,
> I saw Padmanabha's report (thanks for the report); sorry for not
> responding sooner, I've been traveling recently for a funeral.

Oh, sorry about that. I think this is not so hurry. 

> 
> Any chance we can use
> 
> CFLAGS_REMOVE_<file>.o := $(CC_FLAGS_LTO)
> 
> a la
> commit d2dcd3e37475 ("x86, cpu: disable LTO for cpu.c")

Hm, this looks good to me. Let me confirm that works.
(Does this mean the bootconfig.o will be compiled to elf binary?)

> 
> with a comment linking to
> https://github.com/ClangBuiltLinux/linux/issues/1618

Thanks for reporting!

> 
> for the Translation Units using .incbin, until we have had more time
> to triage+fix?

Yes. For this series, I can update with above one, but it doesn't cover the
other parts. And since this issue is independent from the bootconfig, 
I think we need a wider patch series to mitigate this issue on config.gz
(and other .incbin users) too.

Thank you,

> 
> -- 
> Thanks,
> ~Nick Desaulniers


-- 
Masami Hiramatsu <mhiramat@kernel.org>
