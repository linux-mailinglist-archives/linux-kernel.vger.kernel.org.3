Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8451CAB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385915AbiEEUkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiEEUkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:40:33 -0400
X-Greylist: delayed 360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 13:36:46 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884B853B44;
        Thu,  5 May 2022 13:36:46 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.182]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N63JO-1ntTNL2HRw-016TAG; Thu, 05 May 2022 22:29:31 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 71CFD3C088; Thu,  5 May 2022 22:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1651782563; bh=wVmgLLHKta8PUSVIgVtK/1NnMmbzgztoT/WwL6D71Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5gWrt/AhpbEjf/JeLl3pOYQGqIkCIEmpciAUncAWUB0EtaDHQuMAzikXCpLS4Ccp
         +yMBf56zg2EUXDLFMzlvawEbbxLcBVdnOFYlf1kDYa0vYG8cMaPq69u9pGenvvliSJ
         9tHzoS/o4jQSB8XRbFhYuJDj6YbPfuM5SvjoU06Q=
Date:   Thu, 5 May 2022 22:29:23 +0200
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
Subject: Re: [PATCH v3 14/15] kbuild: make built-in.a rule robust against too
 long argument error
Message-ID: <YnQzox0FyZuGmRQ0@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-15-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-15-masahiroy@kernel.org>
X-Provags-ID: V03:K1:g7/GEkNdzZQcHIJUtCmuKgFMiYguYvVDH+d7WyytcfLFvAyhgrE
 5sNn8CrlM3fsZq6LKQytxDubyW6P7Q3FYIzsZp1qwE1V6/OA+NZgqQKbz3DZXaLlagXkvlb
 yapZ1jiodr0qTdSvbPs5M5ciqINjQTHyt5/w5En0gHi9YA8RyUsbitDfT0QwC+goW8RPyW2
 rY+hBNh9hgOUj6XoX40Hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:15c6AGhzBaE=:UyGq/t2rNQuEK3R9UJFY/D
 gJs6fytS1ZuHH48I6M03XJISLFuKAAJEahH0uxR3/vwxh0Q3qXQ+EWhTNK7eNcu8QBEEzmVpl
 EnpjtMASJbtSziPE7CgKr+i69Xb4cEmEuPFhRbku92qn0H0iVMR+MWLHc0bwSXwg4zykFfq5G
 skpgpnOFgj3DCdWLnaXA6RjEiIGpj1FQkk+cjc8H/1FsafWv04L1ABH03/wwvwCyb0fnCaPxj
 /OHIBr+ETHLITdgLo0T3p+mwlI0g2F3zGt3twoYb1xBtwoEpxWTYorr9P7Hq91OuBUoBV6rv8
 rwvmvlNEMyjVdqaAppqvLNhqwmNJkl6bm0WyckKs1iRGvaeADPG3H0qonpmgf+n9akLg0LLnX
 Mvaw23L9w6FhWhNeHDM1iLR9HsXU5XjXl88iuUiCqUEmBMtZ3Cl+3Bp0WCV2KUBbxrppjWyEP
 AoXSxxgx9I69PGJbzKSYfuKkHutQK+Xk+EnVcNWrlK5Lye0KCE2EmfxCe31bKt8YZ62KcHkVK
 n8KLzThrQirOCdvsScBO733ToltidhqSvgGDCKkuyknF1BjPhjkabIo+O+08rmul7/N80SQT6
 r4sAraF3zPB21vkd6rTvfPKmNji6Kc9iC/zb+tCfFFRj1vmCKfHME8F7FggQZR63aK2Pd1hov
 zKlGtbMH8XCjFkEtxRG8S9Znb41PqJ7yUEFQ+HkDG5j/husT/MAQYYSyjLjfgW9lLUj0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:22:43PM +0900 Masahiro Yamada wrote:
> Kbuild runs at the top of objtree instead of changing the working
> directory to subdirectories. I think this design is nice overall but
> some commands have a scapability issue.
> 
> The build command of built-in.a is one of them whose length scales with:
> 
>     O(D * N)
> 
> Here, D is the length of the directory path (i.e. $(obj)/ prefix),
> N is the number of objects in the Makefile, O() is the big O notation.
> 
> The deeper directory the Makefile directory is located, the more easily
> it will hit the too long argument error.
> 
> We can make it better. Trim the $(obj)/ by Make's builtin function, and
> restore it by a shell command (sed).
> 
> With this, the command length scales with:
> 
>     O(D + N)
> 
> In-tree modules still have some room to the limit (ARG_MAX=2097152),
> but this is more future-proof for big modules in a deep directory.
> 
> For example, you can build i915 as builtin (CONFIG_DRM_I915=y) and
> compare drivers/gpu/drm/i915/.built-in.a.cmd with/without this commit.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>   - New patch
> 
>  scripts/Makefile.build | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 0436ff94800e..cea48762299c 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -370,7 +370,10 @@ $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
>  #
>  
>  quiet_cmd_ar_builtin = AR      $@
> -      cmd_ar_builtin = rm -f $@; $(AR) cDPrST $@ $(real-prereqs)
> +      cmd_ar_builtin = rm -f $@; \
> +		echo $(patsubst $(obj)/%,%,$(real-prereqs)) | \
> +		sed -E 's:([^ ]+):$(obj)/\1:g' | \
> +		xargs $(AR) cDPrST $@
>  
>  $(obj)/built-in.a: $(real-obj-y) FORCE
>  	$(call if_changed,ar_builtin)
> -- 
> 2.32.0

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
