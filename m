Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C054F51CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1847303AbiDFCRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344894AbiDEUVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:21:50 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8730B6D1BB;
        Tue,  5 Apr 2022 13:01:22 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.95]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLAAs-1nKqR22ZFa-00IBZv; Tue, 05 Apr 2022 22:00:46 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id AB29A3C088; Tue,  5 Apr 2022 22:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1649188842; bh=Jp5v0unMM8TX1zb3fmwvi3+6Bc6OHGfiq1HG+GUHVyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCnghiuB+Wzr1v0Xj7rtxiS0alkX0ofzpVxIAQD6kCNeeJKrRBdzWsEoYLV4WdhGW
         cK8WpcDjJixQEKeB9CidDTnKmCqBqfYq9K7JWqmuDdZOl3byBsD6cAH/2nOkdkLUED
         CfyTrc2leT65LiIFaSS13YAg+nRUACsIHfjO8BR8=
Date:   Tue, 5 Apr 2022 22:00:39 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 01/10] kbuild: factor out genksyms command from
 cmd_gensymtypes_{c,S}
Message-ID: <Ykyf51yQ78g71veR@fjasle.eu>
References: <20220405113359.2880241-1-masahiroy@kernel.org>
 <20220405113359.2880241-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405113359.2880241-2-masahiroy@kernel.org>
X-Provags-ID: V03:K1:oSARpcPyymoleg6RyJVu0DeVUrsJvspIYHiB+agK3g3YJzi5n23
 863JDClt1QRA49iVriE0QcZMU2v6b2K7KfzkkuLmqLyAIpGbVwpjHjseVGhwynDWQrbQYC4
 I2OVQYgcg/LNYPEPv+xs66YzmYkcsrmOiR+7fJxqGB0+W81LWCfk8CGxLJHYumkD35jqqA8
 aeaGGVTrYnv7TOF/G7Fvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N/nJZWxHmG4=:MQI6zQKrjr6jugH0+jpOEF
 wzao4WqD3FuYGxHoo/ydg8lwOgcOEQ6JkPuJyfgyweswbZnCO9LIRW0L4pPTYjI19WEcRrpsD
 ivMrK1eDaO5zabhjp8FvzcZrJ59SmEvp730GNA5kfCKbBBwK6UV0lqW29w7Cf+BfeS7rvC3ek
 8oj9iMH/Vk32LfhsDOxY5NG4jR8sUv6YJF7Rd964q9pm1YPYEEdhgLfN4z1KXflWtl4h0jhQ8
 uS0ThIRnvDkkyqUWpare0mu446VGCw5SGpxXnQv0AC+diuKT55QQMSER4sVTbjLe/vMx3XISZ
 QKppKbLZeCyN22CoZRhmoa9PUXCI392eEfn4yMj754Cd2o/tlklwvVCEbK2UtdSvIlV/0nthb
 Zi66yxUV4TvymjT+kBVhRDn58REIHUAuvv9EPH8ro7GJ29dkRMHfNjasqGaMCQGO7k41zaAuT
 l3UOMnoJ8zTqBERxEYDgjH+e3xqyQXX9wNLrMB+LL1HvtNCXLUkJ68UF7dX6s5lnC62OPi0d0
 5JqKTNZqfPp7yreDWBx8j7o7IqP6O1Uu9m7r9r7xJYkj6DNcqpHW2EfGbVqCL5MZV8ia5WneA
 TbidzkC/Eg2rK6qiVBYz8hl5H687jYGCdL0QOGMBhDp3JATWZ5hP9s4LxYiMc20Pq8JGl1JnQ
 6UoThxkOHeOo8y3i3cJe6sGGWH1QLn6GL0O9mvoIHYBlatqByOkRRkC5AIRUUnw1NZe0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 08:33:49PM +0900 Masahiro Yamada wrote:
> The genksyms command part in cmd_gensymtypes_{c,S} is duplicated.
> Factor it out into the 'genksyms' macro.
> 
> For the readability, I slightly refactor the arguments to genksyms.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> 
> Changes in v2:
>   - Fix the location of the closing parenthesis
> 
>  scripts/Makefile.build | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 9717e6f6fb31..31e0e33dfe5d 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -125,13 +125,14 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
>  $(obj)/%.i: $(src)/%.c FORCE
>  	$(call if_changed_dep,cpp_i_c)
>  
> +genksyms = scripts/genksyms/genksyms		\
> +	$(if $(1), -T $(2))			\
> +	$(if $(CONFIG_MODULE_REL_CRCS), -R)	\
> +	$(if $(KBUILD_PRESERVE), -p)		\
> +	-r $(or $(wildcard $(2:.symtypes=.symref)), /dev/null)
> +
>  # These mirror gensymtypes_S and co below, keep them in synch.
> -cmd_gensymtypes_c =                                                         \
> -    $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
> -    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
> -     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
> -     $(if $(KBUILD_PRESERVE),-p)                                            \
> -     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
> +cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
>  
>  quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
>  cmd_cc_symtypes_c =                                                         \
> @@ -344,11 +345,7 @@ cmd_gensymtypes_S =                                                         \
>      $(CPP) $(a_flags) $< |                                                  \
>       grep "\<___EXPORT_SYMBOL\>" |                                          \
>       sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
> -    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
> -    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
> -     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
> -     $(if $(KBUILD_PRESERVE),-p)                                            \
> -     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
> +    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
>  
>  quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
>  cmd_cc_symtypes_S =                                                         \
> -- 
> 2.32.0
> 
> 

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
