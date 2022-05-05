Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45D451CA93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385848AbiEEUcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354028AbiEEUcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:32:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8296C2BB37;
        Thu,  5 May 2022 13:28:21 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.182]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MdwRi-1oLUuu0jeY-00b4o2; Thu, 05 May 2022 22:27:10 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id B61AF3C088; Thu,  5 May 2022 22:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1651782424; bh=oGd2e0sWzuw2lfacuEfCkKF+JuznQDoibFgyz7j1FOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FaLJ+2jWftfmPh62O8eA9LWVOpI6bCmG5q2wumrSva1zb8Lt/1da5TlQqhSISYxfV
         3pWN2pxZKshK6qG2ZAlazcmz8TTIL9aTwzrsh4MAmQGR8+JO8wVmXZblUEf84WC++W
         TiErDSzNaNjx6X6fzUMEEHREyY6mRvxkVgjnPEo4=
Date:   Thu, 5 May 2022 22:27:04 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 12/15] modpost: simplify the ->is_static initialization
Message-ID: <YnQzGMfWqnP6CMir@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-13-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-13-masahiroy@kernel.org>
X-Provags-ID: V03:K1:LK2u+J2AhRjCi+eMNFHoFnTinbNPkEFuFiOuKWVtzJ00eRjm6z7
 tNvjulmaQd0h6NqxBCm22IwvsWk8KlKkc6Ii6th88VKmMWg5MlEkkUpaXLqSy7hm061+Hs8
 UD92p80tBHi8TG7LLOvYD2q5nEGx/b88ke8OExKVbAFL5cXXGXR/lOQyJDZrWpGGW8T00jj
 JAPWLP7gyGdYvch2xT3Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OxAiCGOEiWk=:9v6pZlNBsR1l7vFzSHm9UI
 /rD6j6qbY07+oT4+AyXX+8s8GdCCDK9+2h3F1C5GfCE4WbIIm1+MyqDLdz9pQ1kr1drl6HDQL
 mLMC7CawdirGi/+SQAWuOxWNkG06NUrvND+SqkMCsISquldvjozq/TV+y219fr1VGCksL5Tro
 F3em6lKfungyYh6g0OHXZlFaHPlPU5G8jos/UzxAYI2dqTiiu5Zi2YNXJyBVHiyJBDnR4du6f
 oedVr8+AQ86/m7v8tG4KXewdDs+4LunPIEVMcQCZmcQBFkkMPzZAwTYv7b3+5Dkp+eFTafJIL
 DOxPYInPHjDQZ3YpjNA8xpyYu2C/rRM+jb8P02LWzU6paRv/p9pgO/lOQL4oBIFQbqJ1DbtGa
 CRIOFERb8zjO2S7jr1FGl44q4ySvT+X1TJkog7BMk0XG712rdLQ9IxQBh1oaKwTt8kslwrMNc
 QVkL3lXMtoH9dj9fuLZzCnXUT7+sB+8wHMN73LyZWZfQoiCBuM17nLSL0LeRxvP36JCelL7Vl
 5zi8CbPjRaSVVtvh7nK22PIH9epnfrEF3wcpoBeVEThuZ1lEJZOvKSDuZH42mmhK5BCVV6FwG
 wLCpKeZEzfsRzM+O+RKRbUDV03g0i9Qks6wQ4q3MTboCf81M1UyFXm7pDprkdC91RC066O/M4
 nVtIm+BqMUkqLUXR31hp2A+GSF8kq8ZnuaKpMsOLt19fVst3NmNkq7ij/oFYqgxLNoks=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:22:41PM +0900 Masahiro Yamada wrote:
> ->is_static is set to true at allocation, then to false if the symbol
> comes from the dump file.
> 
> It is simpler to use !mod->from_dump as the init value.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>   - New patch
> 
>  scripts/mod/modpost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index e07542a90fc6..4edd5b223f49 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -242,7 +242,7 @@ static struct symbol *alloc_symbol(const char *name)
>  
>  	memset(s, 0, sizeof(*s));
>  	strcpy(s->name, name);
> -	s->is_static = true;
> +
>  	return s;
>  }
>  
> @@ -376,6 +376,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
>  
>  	s = alloc_symbol(name);
>  	s->module = mod;
> +	s->is_static = !mod->from_dump;
>  	s->is_gpl_only = gpl_only;
>  	list_add_tail(&s->list, &mod->exported_symbols);
>  	hash_add_symbol(s);
> @@ -2523,7 +2524,6 @@ static void read_dump(const char *fname)
>  			mod->from_dump = true;
>  		}
>  		s = sym_add_exported(symname, mod, gpl_only);
> -		s->is_static = false;
>  		sym_set_crc(s, crc);
>  		sym_update_namespace(symname, namespace);
>  	}
> -- 
> 2.32.0

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
