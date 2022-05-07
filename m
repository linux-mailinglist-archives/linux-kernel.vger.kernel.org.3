Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D74E51E935
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391445AbiEGS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiEGS2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:28:13 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AADA2ED4B;
        Sat,  7 May 2022 11:24:24 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 247IO9iw016056;
        Sun, 8 May 2022 03:24:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 247IO9iw016056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651947850;
        bh=FgFRLqLdXmAZ2tSGrmOiHUMK4HAjJDfS1aPhPW9riYY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XlpjzxAbJLOnkSQh/tb0HOtQOPqtdUtV2YDYO/tUcyz2STeGVfG5nojpk6VN7J2eT
         fD1Yt46NEz5myD5TfnQkXI95VR8jc6nWlbd0FhfMCuSWPfod+Oc/jZO16GPgOvrGhT
         QQ06Vd7HYiH86/xDly88317QS4jz9XLDn8LtT49bocZwn4QkuiamBwF4ciCanVy6gt
         oBBsoFPZjDdyS1veUL1z6DowaObGYfFkuK6PI1KpIVOY0fH5XWG9oaz8kwVOrY0P7O
         0ZmuPURd6hFar5iDI7bRVKY7j8nLRNMp9vPA0TRvkImDqTEFARNelmF49xgH0EmeYV
         7tVpkySWBhXqA==
X-Nifty-SrcIP: [209.85.216.54]
Received: by mail-pj1-f54.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so13603710pju.2;
        Sat, 07 May 2022 11:24:10 -0700 (PDT)
X-Gm-Message-State: AOAM531VJRcJNCOwsnAgMTwiNR/TUHsMC5xvzoSFNkNcSQxRcePXqk1q
        aHAIAwb96CLCmPqBSPnWLdqbNd8M3rAUDnvVY+g=
X-Google-Smtp-Source: ABdhPJzr1Ju2XywINvVYIHvo5aTElU5pR5XHYCWjGcwWneDFCojBCAxoXjaxsHfVPQgmUPjYEIvdGcqBjqlJ6kwaFKA=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr9224506plh.99.1651947849326; Sat, 07 May
 2022 11:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220504212714.152837-1-arbab@linux.ibm.com>
In-Reply-To: <20220504212714.152837-1-arbab@linux.ibm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 8 May 2022 03:23:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNATOSOy=FgmTqH-ymt34T7+iE93Uu4DTzHjH6m90E83Vng@mail.gmail.com>
Message-ID: <CAK7LNATOSOy=FgmTqH-ymt34T7+iE93Uu4DTzHjH6m90E83Vng@mail.gmail.com>
Subject: Re: [PATCH] scripts/prune-kernel: Use kernel-install if available
To:     Reza Arbab <arbab@linux.ibm.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 6:27 AM Reza Arbab <arbab@linux.ibm.com> wrote:
>
> If the new-kernel-pkg utility isn't present, try using kernel-install.
> This is what the %preun scriptlet in scripts/package/mkspec does too.
>
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> ---
> Hope I've sent this to the right people. get_maintainer.pl came up
> blank, but kbuild seems like the nearest match in MAINTAINERS.
>

Applied to linux-kbuild. Thanks.


>  scripts/prune-kernel | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/prune-kernel b/scripts/prune-kernel
> index e8aa940bc0a9..dadfd0e47f89 100755
> --- a/scripts/prune-kernel
> +++ b/scripts/prune-kernel
> @@ -16,6 +16,10 @@ do
>                  rm -f "/boot/initramfs-$f.img" "/boot/System.map-$f"
>                  rm -f "/boot/vmlinuz-$f"   "/boot/config-$f"
>                  rm -rf "/lib/modules/$f"
> -                new-kernel-pkg --remove $f
> +                if [ -x "$(command -v new-kernel-pkg)" ]; then
> +                        new-kernel-pkg --remove $f
> +                elif [ -x "$(command -v kernel-install)" ]; then
> +                        kernel-install remove $f
> +                fi
>          fi
>  done
> --
> 2.27.0
>


-- 
Best Regards
Masahiro Yamada
