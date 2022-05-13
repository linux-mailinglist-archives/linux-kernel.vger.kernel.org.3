Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE1352611E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379942AbiEMLkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379933AbiEMLkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:40:49 -0400
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49C813E33;
        Fri, 13 May 2022 04:40:45 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri, 13 May 2022 13:40:42 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id C6DCD81DE2;
        Fri, 13 May 2022 13:40:43 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id C1600182AE3; Fri, 13 May 2022 13:40:43 +0200 (CEST)
Date:   Fri, 13 May 2022 13:40:43 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 12/12] kbuild: rebuild multi-object modules when
 objtool is updated
Message-ID: <Yn5Du6mifUMExntW@buildd.core.avm.de>
References: <20220511164514.2741934-1-masahiroy@kernel.org>
 <20220511164514.2741934-13-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220511164514.2741934-13-masahiroy@kernel.org>
X-purgate-ID: 149429::1652442042-000003AF-5D1AD51C/0/0
X-purgate-type: clean
X-purgate-size: 1858
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 01:45:14AM +0900, Masahiro Yamada wrote:
> When CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT is enabled, objtool for
> multi-object modules is postponed until the objects are linked together.
> 
> Make sure to re-run objtool and re-link multi-object modules when
> objtool is updated.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> 
> (no changes since v4)
> 
> Changes in v4:
>   - New
>     Resent of my previous submission
>     https://lore.kernel.org/linux-kbuild/20210831074004.3195284-11-masahiroy@kernel.org/
> 
>  scripts/Makefile.build | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index f546b5f1f33f..4e6902e099e8 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -404,13 +404,18 @@ $(obj)/modules.order: $(obj-m) FORCE
>  $(obj)/lib.a: $(lib-y) FORCE
>  	$(call if_changed,ar)
>  
> -quiet_cmd_link_multi-m = LD [M]  $@
> -      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@) $(cmd_objtool)
> +quiet_cmd_ld_multi_m = LD [M]  $@
> +      cmd_ld_multi_m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@) $(cmd_objtool)
> +
> +define rule_ld_multi_m
> +	$(call cmd_and_savecmd,ld_multi_m)
> +	$(call cmd,gen_objtooldep)
> +endef
>  
>  $(multi-obj-m): objtool-enabled := $(delay-objtool)
>  $(multi-obj-m): part-of-module := y
>  $(multi-obj-m): %.o: %.mod FORCE
> -	$(call if_changed,link_multi-m)
> +	$(call if_changed_rule,ld_multi_m)
>  $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
>  
>  targets := $(filter-out $(PHONY), $(targets))
> -- 
> 2.32.0
> 

Reviewed-by: Nicolas Schier <n.schier@avm.de>
