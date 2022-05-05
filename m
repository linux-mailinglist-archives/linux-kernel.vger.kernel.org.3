Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9983F51CABE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385934AbiEEUmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382839AbiEEUmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:42:10 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E458E5FF13;
        Thu,  5 May 2022 13:38:25 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.182]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MzQTm-1o06Fv05JY-00vQbk; Thu, 05 May 2022 22:31:31 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 146A93C0A0; Thu,  5 May 2022 22:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1651782689; bh=9wlFO3MLyBOpHZvAd84sW/pY49tJqU65GeK3vStuX2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zqmv8cX5aeN75BpS8wlPq/mhxNbMeyV64uEMViipkFTMdKvtNiGWbceJ+6Bh+JWwv
         D/4yHrbTFXWvkyqseXRLrnqsE2YvCZeKLiZHpYNAAZY931HxmxHvb1eVrhZqtPEcHZ
         N+olq3LtWu+5k3HoEQ7JcVJEIpPj6kokDR5VBw80=
Date:   Thu, 5 May 2022 22:31:28 +0200
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
Subject: Re: [PATCH v3 15/15] kbuild: make *.mod rule robust against too long
 argument error
Message-ID: <YnQ0IHNnQTIsxOxq@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-16-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-16-masahiroy@kernel.org>
X-Provags-ID: V03:K1:ATjjPZxZrxSYHnT3weErv12Bh2cwK2wHc1xFqX4u3bAi/heFx7b
 6P8k3j2vwjJcl03Stj1aUwkOTwe+JjMDsmGjUfomIoBMI9IRoUX5GVrziiH2c+621UgNyjj
 7HP/rVyptQpb5aIpXw+GYaWos4XrsiPnY5/fS3Irm+rP1103LXqYJA/yTGnAqsrsNPONEwQ
 NeGAeBdHijOVBbfFKB66A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ht9znOFhGJs=:XBYPSP6S3dmiJ91SUrJ0BG
 IKN4p3eyUbMaMqfG9RvXmNFoOdbExkZoL4r6iU5wmAZD6Fw9jGZAzKwZOMt4wfcOlweHzEeal
 vvroAo/8kygn3Zf03HfcvsWHPWs+5g6K61yPI1jJrojrbhI2UCmKB4QlZawAEAc5Um48kE8xZ
 iMAMdV3AL4uXLGD6JdTXsRJ9VlR0ZtV1GAVu5WT2vit5nuemkEVW+ydNyGRQAGi8jLMo3ZKag
 PvnileNSkjFhZL52a1T5U8yOB9ifKV9MHPcSyy3McehLXnLEQmZPpvZeU3qI1B0U3OrI6v8z4
 LeGmUh1hp0RZVZL/3FbFjggaZOSo+fn5LhCHknTAWISJ6tDmJtRUIJWfm6cuQ05BbRQbRBBql
 JVD088s7COrgOKLbz1FiOxPNG0KvY9lXf9wOd4V5+ju4uPENjKJnmTq6TC65XWTou1SQQIxrR
 k9KIVxie3ertxDDagmEcof8KGi4aPuyAvsQYAI2bzpqJy4KqOLl1gUViHKY41MjpoiOgtwr3h
 ETgQowUaEzCX00hR8MqC1AcBmMx4tiYMJn6yUhcJPb7hXbD9KAqGP7HnoYP18TErG6tRdJamR
 CD2DGhYnY2+ekjPbY+C4CM1GmKUvixEWCbq0mvEtSDqPbnljHWyvI+J7cMelDnQWTvUX3HNsU
 uTQnbBXBK1a8KW0AgLiwXUZzKU+xVvv48Oc+wU6QSQiW0VwYvbBxac62YnwzTJySEneg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:22:44PM +0900 Masahiro Yamada wrote:
> Like built-in.a, the command length of the *.mod rule scales with
> the depth of the directory times the number of objects in the Makefile.
> 
> Add $(obj)/ by the shell command (awk) instead of by Make's builtin
> function.
> 
> In-tree modules still have some room to the limit (ARG_MAX=2097152),
> but this is more future-proof for big modules in a deep directory.
> 
> For example, you can build i915 as a module (CONFIG_DRM_I915=m) and
> compare drivers/gpu/drm/i915/.i915.mod.cmd with/without this commit.
> 
> The issue is more critical for external modules because the M= path
> can be very long as Jeff Johnson reported before [1].
> 
> [1] https://lore.kernel.org/linux-kbuild/4c02050c4e95e4cb8cc04282695f8404@codeaurora.org/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>   - New patch
> 
>  scripts/Makefile.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index cea48762299c..e7b3f329d443 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -266,8 +266,8 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
>  	$(call if_changed_rule,cc_o_c)
>  	$(call cmd,force_checksrc)
>  
> -cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) | \
> -	$(AWK) -v RS='( |\n)' '!x[$$0]++' > $@
> +cmd_mod = echo $(call real-search, $*.o, .o, -objs -y -m) | \
> +	$(AWK) -v RS='( |\n)' '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
>  
>  $(obj)/%.mod: FORCE
>  	$(call if_changed,mod)
> -- 
> 2.32.0

Thanks!  At work, some colleagues of mine stumbled over that problem, too.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
