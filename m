Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0D589F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiHDQNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiHDQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:13:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D004E3334D;
        Thu,  4 Aug 2022 09:13:40 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.43]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2OIy-1oI06b118Y-003tc5; Thu, 04 Aug 2022 18:12:55 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id B0A483C0ED; Thu,  4 Aug 2022 18:12:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1659629571; bh=F6zcAi3GnAmA1c7S2vD3kZIcL5Z0tXsBHo/rLW0nbmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DHlXJMg/zdHbJ43F4TLRvx8icimtJsu5P2MFylAZxVu6+sn0ybUhuG56kjyxyZUpO
         Y5AZtRxHeQY2BPqZGUVqnRMCG5tmQgA+2KZl5eAo8Z4Q7u5IMLpNI2znPvxtfPYmNj
         ySbAD9Amsh4LTXdKH111OrHsgalu/1+gyJ48Ri5A=
Date:   Thu, 4 Aug 2022 18:12:50 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        David Laight <David.Laight@aculab.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: set EXIT trap before creating temporary directory
Message-ID: <YuvwAkqHRk2pbh4f@fjasle.eu>
References: <20220728031433.1077354-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220728031433.1077354-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:jmKz5ldisbRGcZkI9xiMXZ17FfWcH83IvGNnk3WEXMtGx4CnvS7
 CMwDFPURRF7yLecABRbMDMBJg6zeDycvK2Xh9nt2arD6Fb10fxIXPfzeQqADGmWE9JY7aho
 SUjoYGTMU29hLlJq+ABCjnvXIw5OItxPo/2tA4H6X6nRzfyWO+6+rgTGtUMeKwPHOlEnAbS
 OGHwXHGTPZj8GUuIysANw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pmYRc3oEKLM=:Lskx7ZNXzE73dmTlCCKqJH
 NfYEeP2Sm0uD1kJFk+pkqny+/yqYI4/5I0kK4MRxYBYfpk22IQKdLtXuUVHfYbWYbeDvDRTq8
 gb9R3vVOaBod85SgED8EvyyilgMfkuB17HRhcIa4Wp4hHb0Pm+JyKbdKorq2NeVj/mLQ/kutF
 x0vn+GGEACBd4bKuMJSd9r+eQr4yu6XRZUs8HVf+LxNOOT/GdKi2eE2uR412s6jDFrtp63wsC
 TzL+fkQekI2SAPiwblZSLoWPQnyzPPBtmB9dKeHugQl7y6eaGKcemXuhELRljO/GzBkAjRE9i
 OM/nnHvpBgB8WBErnfzGAZTS8+7+T/ZxTzVc85hUCLhc6GNmlYUPxP0kTA3aKFjU2adWt9I7F
 bENSmaNs8eRyacQ+q7vAqBkeHnGiszcqcmti40nIjPsxZjBEm8YSU3p3Moyez9uj3702A7pm/
 RfRBsrZTlj6OrPikAV2nzAhw+iGZAOZb0YOmYqpeYE0KByh1S1PuvHUJsnvBdptWpMHuMcNbe
 ejezn/pEn7QP39C6YgeLzKbkBLngXIU3huAqoK5qqS9fCzfEQbD9F4vzc1u8YLu7pvGF/qD19
 5fprbQs1HhfQWXLestSFDWiJ/NQSnVI8zkPbdxVvcG3AsCtMQnkRjBJG/dg5T3gCDV9Nf6eXI
 /ZIGW4+CO/T/W7WcyLRqMPsJuQck3xisG1FBNYkT2yqXhbhREUGjdG+e6LYI+nkWeUHtEHPE2
 T4P5eZC4IsdR8BmhKaOw18ZABQh40qKTfRWZMQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 12:14:33PM +0900, Masahiro Yamada wrote:
> Swap the order of 'mkdir' and 'trap' just in case the subshell is
> interrupted between 'mkdir' and 'trap' although the effect might be
> subtle.
> 
> Please not this is not a perfect solution to avoid the left-over tmp

not -> note?

> directory. There are more cases that miss to remove the tmp directory,
> for example:
> 
>  - When interrupted, dash does not invoke the EXIT trap (bash does)
> 
>  - 'rm' command might be interrupted before removing the directory
> 
> I am not addressing all the cases since the tmp directory is harmless
> after all.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Kconfig.include   | 2 +-
>  scripts/Makefile.compiler | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Do you want to add the same for filechk macro in scripts/Kbuild.include?

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

Kind regards,
Nicolas

> 
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index c1f4222d223d..a0ccceb22cf8 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -25,7 +25,7 @@ failure = $(if-success,$(1),n,y)
>  
>  # $(cc-option,<flag>)
>  # Return y if the compiler supports <flag>, n otherwise
> -cc-option = $(success,mkdir .tmp_$$; trap "rm -rf .tmp_$$" EXIT; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
> +cc-option = $(success,trap "rm -rf .tmp_$$" EXIT; mkdir .tmp_$$; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
>  
>  # $(ld-option,<flag>)
>  # Return y if the linker supports <flag>, n otherwise
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 86ecd2ac874c..94d0d40cddb3 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -21,8 +21,8 @@ TMPOUT = $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$$
>  # automatically cleaned up.
>  try-run = $(shell set -e;		\
>  	TMP=$(TMPOUT)/tmp;		\
> -	mkdir -p $(TMPOUT);		\
>  	trap "rm -rf $(TMPOUT)" EXIT;	\
> +	mkdir -p $(TMPOUT);		\
>  	if ($(1)) >/dev/null 2>&1;	\
>  	then echo "$(2)";		\
>  	else echo "$(3)";		\
> -- 
> 2.34.1

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
