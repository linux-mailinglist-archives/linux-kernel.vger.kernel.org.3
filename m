Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1C51CA00
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385635AbiEEULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385618AbiEEULd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:11:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A45F250;
        Thu,  5 May 2022 13:07:47 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.182]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MXY2T-1nJrvv1Lbz-00Z2wJ; Thu, 05 May 2022 22:06:36 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 425153C088; Thu,  5 May 2022 22:06:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1651781194; bh=K+3GtvwU80wXGfbYcivZwj9JhSu/IiFPm3BUeZlhLDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bo+hY/Tp13vWQCNyzsi9dI53zGbZr7U752LiBoH55tOMh7GwIJ6Iq6yylIcBD9PFa
         cQj7jcATBdczn3bhcBB19hxaRBeMgfVBy6L9mxM+NHRwg/dsCoOnuE5XqLImzV0ITn
         msyT1zaToMV87DxOkkFcptVyO46QtIbN5ysKTUqQ=
Date:   Thu, 5 May 2022 22:06:34 +0200
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
Subject: Re: [PATCH v3 04/15] modpost: move *.mod.c generation to
 write_mod_c_files()
Message-ID: <YnQuSlb9EbjWJ1WI@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-5-masahiroy@kernel.org>
X-Provags-ID: V03:K1:NVcW/uOG7hJwXpmRx2e2BH5Puvh6Ojdt+6/38GHTT0l9qn00sPK
 mb5A6qRDZFFaWqyV2YBB5R5vXVSCBzBqaqiBXLPtn8TGLZ5JEk/obIbJukr8o0LAhXsSAys
 SPaOeLdLW+s4Ubq9f9ZRC15OMxQpuokc7fcfA5iDxjOiFo++IbqdeRwMYDmCrZeoD2AADHK
 vfoE47G3EbzUcPD4PXjaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hvm6SQfU/54=:B27ppraTEoTCHG1w+Qyylw
 PHb84M6nkcAZHwE/9vNdYCQ44KfhXAClv7rjHZLCYLo2FihK7+7f1+sgd30txIwmbCzz7ruxp
 riLZd4jgQmkdgqfWFrJGNJHKswbq9P4ZY2KSbaBxkr3GQCJVF5ycX1Wed7f/95MrkzRQPFkRe
 h9CQrfBbxrZ8ydK7icLwv1zvEQdtZnbMwJmGq1KIWJ9vM0yplpjhmQITwyOM6YnjQP5IoGGSK
 koxqlVUBIF6SJt6YLMpx9fwiGt3CgyGfk5YvnPnCu3q5KXuSZblbs5RRYe4S0WToNu0xvtVac
 YvxU9Ux0qIj03Cq4J7pUvCTwO+HpYSco0ZROCqxA5ilanHQpGs6h74MHn3wscePESHbcOxCk/
 vFF+1G2h8o4QrPu/0MsdM8pcbznUfEo+c4QzB6IW5LdHafFuWJevNqVc/SrxiXDCyPSTVYT5o
 cR2CWEYwdFwKkK2Xt6WTGUKKY2+U6kFqS9YlGQ0QsiaslpQVkZGamDuRJ5GzNeM8fPGkLVK/N
 jeHk/5gTA0rivYcoLIdRvXsfnub9xxXFgxQpIoQhDsOV0bORXAj4NtZhjB/GmXJvaauYhR/7x
 YD4Q7gAaHtMs1yEgpqhDtAKzkwwg3IY17mhlnNFH2v6YMYwVudBwsHQErj8mLiXzpQkMwCT1x
 ROH58xDrLs7FtMfqCRJgDgKi3UoBI4B8ELGxjg4XuSIca7dEIwsY7ZKpCGQFfUeboK04=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:22:33PM +0900 Masahiro Yamada wrote:
> A later commit will add more code to this list_for_each_entry loop.
> 
> Before that, move the loop body into a separate helper function.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v3:
>   - New patch
> 
>  scripts/mod/modpost.c | 56 ++++++++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index ae8e4a4dcfd2..78a7107fcc40 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2347,6 +2347,34 @@ static void write_if_changed(struct buffer *b, const char *fname)
>  	write_buf(b, fname);
>  }
>  
> +/* do sanity checks, and generate *.mod.c file */
> +static void write_mod_c_file(struct module *mod)
> +{
> +	struct buffer buf = { };
> +	char fname[PATH_MAX];
> +	int ret;
> +
> +	check_modname_len(mod);
> +	check_exports(mod);
> +
> +	add_header(&buf, mod);
> +	add_versions(&buf, mod);
> +	add_depends(&buf, mod);
> +	add_moddevtable(&buf, mod);
> +	add_srcversion(&buf, mod);
> +
> +	ret = snprintf(fname, sizeof(fname), "%s.mod.c", mod->name);
> +	if (ret >= sizeof(fname)) {
> +		error("%s: too long path was truncated\n", fname);
> +		goto free;
> +	}
> +
> +	write_if_changed(&buf, fname);
> +
> +free:
> +	free(buf.p);
> +}
> +
>  /* parse Module.symvers file. line format:
>   * 0x12345678<tab>symbol<tab>module<tab>export<tab>namespace
>   **/
> @@ -2462,7 +2490,6 @@ struct dump_list {
>  int main(int argc, char **argv)
>  {
>  	struct module *mod;
> -	struct buffer buf = { };
>  	char *missing_namespace_deps = NULL;
>  	char *dump_write = NULL, *files_source = NULL;
>  	int opt;
> @@ -2524,30 +2551,11 @@ int main(int argc, char **argv)
>  		read_symbols_from_files(files_source);
>  
>  	list_for_each_entry(mod, &modules, list) {
> -		char fname[PATH_MAX];
> -		int ret;
> -
> -		if (mod->is_vmlinux || mod->from_dump)
> -			continue;
> -
> -		buf.pos = 0;
> -
> -		check_modname_len(mod);
> -		check_exports(mod);
> -
> -		add_header(&buf, mod);
> -		add_versions(&buf, mod);
> -		add_depends(&buf, mod);
> -		add_moddevtable(&buf, mod);
> -		add_srcversion(&buf, mod);
> -
> -		ret = snprintf(fname, sizeof(fname), "%s.mod.c", mod->name);
> -		if (ret >= sizeof(fname)) {
> -			error("%s: too long path was truncated\n", fname);
> +		if (mod->from_dump)
>  			continue;
> -		}
>  
> -		write_if_changed(&buf, fname);
> +		if (!mod->is_vmlinux)
> +			write_mod_c_file(mod);
>  	}
>  
>  	if (missing_namespace_deps)
> @@ -2563,7 +2571,5 @@ int main(int argc, char **argv)
>  		warn("suppressed %u unresolved symbol warnings because there were too many)\n",
>  		     nr_unresolved - MAX_UNRESOLVED_REPORTS);
>  
> -	free(buf.p);
> -
>  	return error_occurred ? 1 : 0;
>  }
> -- 
> 2.32.0

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
