Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CEE51C8F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385000AbiEETal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiEETaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:30:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B90734652;
        Thu,  5 May 2022 12:26:46 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.182]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MiIhU-1oH5uO3YH8-00fPtT; Thu, 05 May 2022 21:25:22 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 38E543C088; Thu,  5 May 2022 21:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1651778720; bh=Cwl4zkdeQcVXSxZ/RPcnVgB7zM8oGINbzVc8Y2VMFBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PwCfqkixa12sjKmUlkGN0KNMba5H+CtsWqxRGlVdXRptb7TBIoy0BO7Sc1zRukI0i
         EvUm1lkuiTNGLNT1bpJs98zozgIt6sLhIAOebglqQmNOD+itcraoJUvz+J1M7FySUT
         6hRW+SHN7GBvySLN/CpZb48xBVsXn+jeS7J2nWak=
Date:   Thu, 5 May 2022 21:25:20 +0200
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
Subject: Re: [PATCH v3 01/15] modpost: mitigate false-negatives for static
 EXPORT_SYMBOL checks
Message-ID: <YnQkoFahOeUVpZhj@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220505072244.1155033-2-masahiroy@kernel.org>
X-Provags-ID: V03:K1:453ge2nHJXg6JLo5cZeMgSEFhVvVa0swhzjR0uQKtW94gAuyPQc
 MTjdF1f5pbFygWaA0SosWLKNmyUdXwFK1CUqAPSkq2SKzmSgl51MwQo6xoMn3Z2qWshs+mq
 zUww0m+Vg1VGGeeohNre8BVjxjh7qSjrYTbvLGMl0VUFNN4UdaEPPhevVoj5lG7DWNaJkaT
 +cWvR/fsod9psxrnhT2vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E/c3KfkTYqI=:WfyzXN1Ql6zaAT4DiqwkTJ
 g6eBKNFCR1ckva7OwYLJxj89Ptoc7lU/QO4lc4dF5H5MR2oC9dEcNMIvgldHzZ1mwtZO3jDSa
 kxXT3P45Oly90jDN6piciVbpmS5PiIN98iFiMY3xWoFqxSTsPukcGbRFtCCtqCpdJFGsxrvUv
 50PptUYBB9qVbLMaGXWWcKdHnFpYHU85kTiui3ORX1eGuyp6gSGp64oE2KjBNxWkD+Pg3AsPO
 cjxqaI7hrDswa87uvVmP/XszaYYmgeCjDOs7Jr9YdeSMDqnDsm+FxJTDEg1WvBF7kSY0KAPpl
 4ne04Q3EQdkaXgf1PIurv/NyYByPMvji1xwcjkPIOqTx+r5ywtC2RPfAAmqI+tOzChPjNmanI
 ui6sUW2f6hOzXSmEtMWJPjbFXh9she7QBrCgtg46CgWI/MwDRl4mRYh7jgZWv40k5DuML+pIw
 eFQ4OVTUOUdwWqOUnH9p4Ot93BBAaDOYcSpkgUtcWqF5BY1O3QqdVRYTO1i5ttyQq5K1f+MmL
 UtUNOAZJCqH/RQkfD4FMcz57oBp90XzENlKNb1c8Zo+iAeQ/Wcgvk2VXpQY3suOnZP1qS4k5D
 e6+MqTSwhVcXqK3nrnpHGT6bvgoYPw+15z7ABCJjY0qInVfWDyYmeKpkhgCzomsPr51wgB5Xo
 WYfEQXww31bqGHvnVdV0RE0g76zSdQvhaaCCPbDEjn2MlbFHgAeTjpB1gInHE8B0sXfg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:22:30PM +0900 Masahiro Yamada wrote:
> The 'static' specifier and EXPORT_SYMBOL() are an odd combination.
> 
> Since commit 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL*
> functions"), modpost tries to detect it, but there are false negatives.
> 
> Here is the sample code.
> 
> [Sample 1]
> 
>   Makefile:
> 
>     obj-m += mymod1.o mymod2.o
> 
>   mymod1.c:
> 
>     #include <linux/export.h>
>     #include <linux/module.h>
>     static void foo(void) {}
>     EXPORT_SYMBOL(foo);
>     MODULE_LICENSE("GPL");
> 
>   mymod2.c:
> 
>     #include <linux/module.h>
>     void foo(void) {}
>     MODULE_LICENSE("GPL");
> 
> mymod1 exports the static symbol 'foo', but modpost cannot catch it
> because it is fooled by the same name symbol in another module, mymod2.
> (Without mymod2, modpost can detect the error in mymod1)
> 
> find_symbol() returns the first symbol found in the hash table with the
> given name. This hash table is global, so it may return a symbol from
> an unrelated module. So, a global symbol in a module may unset the
> 'is_static' flag of another module.
> 
> To mitigate this issue, add sym_find_with_module(), which receives the
> module pointer as the second argument. If non-NULL pointer is passed, it
> returns the symbol in the specified module. If NULL is passed, it is
> equivalent to find_module().
> 
> Please note there are still false positives in the composite module,
> like below (or when both are built-in). I have no idea how to do this
> correctly.
> 
> [Sample 2]  (not fixed by this commit)
> 
>   Makefile:
>     obj-m += mymod.o
>     mymod-objs := mymod1.o mymod2.o
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

I like the detailed commit description!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> 
> (no changes since v2)
> 
> Changes in v2:
>   - Rename the new func to sym_find_with_module()
> 
>  scripts/mod/modpost.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index b605f4a58759..a55fa2b88a9a 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -272,7 +272,7 @@ static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
>  	list_add_tail(&sym->list, &mod->unresolved_symbols);
>  }
>  
> -static struct symbol *find_symbol(const char *name)
> +static struct symbol *sym_find_with_module(const char *name, struct module *mod)
>  {
>  	struct symbol *s;
>  
> @@ -281,12 +281,17 @@ static struct symbol *find_symbol(const char *name)
>  		name++;
>  
>  	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s = s->next) {
> -		if (strcmp(s->name, name) == 0)
> +		if (strcmp(s->name, name) == 0 && (!mod || s->module == mod))
>  			return s;
>  	}
>  	return NULL;
>  }
>  
> +static struct symbol *find_symbol(const char *name)
> +{
> +	return sym_find_with_module(name, NULL);
> +}
> +
>  struct namespace_list {
>  	struct list_head list;
>  	char namespace[];
> @@ -2063,8 +2068,9 @@ static void read_symbols(const char *modname)
>  
>  		if (bind == STB_GLOBAL || bind == STB_WEAK) {
>  			struct symbol *s =
> -				find_symbol(remove_dot(info.strtab +
> -						       sym->st_name));
> +				sym_find_with_module(remove_dot(info.strtab +
> +								sym->st_name),
> +						     mod);
>  
>  			if (s)
>  				s->is_static = false;
> -- 
> 2.32.0

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
