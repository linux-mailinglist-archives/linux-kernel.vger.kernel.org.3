Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517224F864D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiDGRgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244595AbiDGRgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:36:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68238152830
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:34:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p10so10824624lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTS6JoVH0FZyCW8Yz5J0aJH1QFk/MAO8eWoamKneeUI=;
        b=M3AA7BjRuxkuqzx49jk/NFaKYoTsCoSAWMVVUDjaTI4T8fd3Wy95ngt1pt0dLu6oS1
         e+5OVOyD/J0SEvSMrLOcvQ5BgTaWRMNPlGBm0z6dB51fCtAsXALVbMv6wXHdac3np803
         pCISNBcet+jtM2oSeGW+IuxGxybalvArdtuNMHizxV6fpU9GmQI/hHbh7+HIJaaHinX3
         UMzsCzWRStPg8Y7JlXBsI0By84oyCvllllYm9J2/GErrERQQWisKLIkGaeuNnZoQyEV8
         7VkOdmoYWocpzBqVSFvaLCz5MRZet9iPTczlHywz7p133HfQYJ7KC4VG6gsOX6WsVXtf
         FgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTS6JoVH0FZyCW8Yz5J0aJH1QFk/MAO8eWoamKneeUI=;
        b=VUmUwy5Lk2SffcTHb0uoWi7J7yHXjeWAFlunLfwFQ73kX3FpckHpxzEoar47T+fVJY
         AV7jUtNgAleMrzwrJ4Kbtfwupmi9ElC2PQgwmWoSkyTtiWcYFOyj9gglKmtKKS/CWdMJ
         6kHcgALlUP4e2tHlXLyl3ud7H6v96/+1osoFKe9gBNyIqy8ZlEsrpnOUDZDTI/YU4iBm
         JXB4Vk2IpL1hl/7qvU75Ur/B4/WK6bskyS1xRRaZaBkbUZGSrlwTYmE2kjChwuF+DXHz
         A9+3JRYNdR1TXWBTr/PCxGTpC1DAvW+O8eh2QsSewiNLy8AV8qNk3huL2Erk9ziJgSpz
         agSg==
X-Gm-Message-State: AOAM532XeztcrtwppXO7TLkuk1Nhj03vTi5qClqyvIsUzPFJrZ0WWnpA
        bnHng4vdq5nCjh1u8KIw7bfwu/392lMbxu+7ivkMsA==
X-Google-Smtp-Source: ABdhPJzswKfjK36kyyP5jTdYD4iVcctmx2qTBsZ56uCoqUldKnYlfpajfq/zzMPxndyjmIwgZzZTYDIazgOd8NR7d6M=
X-Received: by 2002:a05:6512:108b:b0:44a:6dc2:ffeb with SMTP id
 j11-20020a056512108b00b0044a6dc2ffebmr10335124lfg.184.1649352868337; Thu, 07
 Apr 2022 10:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220406153023.500847-1-masahiroy@kernel.org> <20220406153023.500847-3-masahiroy@kernel.org>
In-Reply-To: <20220406153023.500847-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Apr 2022 10:34:16 -0700
Message-ID: <CAKwvOdnqxh2=QrtWmTMuzF4ob0+TBODM4S88J299G2xHz4zfAw@mail.gmail.com>
Subject: Re: [PATCH 2/7] kbuild: make multi_depend work with targets in subdirectory
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 8:31 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Precisely speaking, when you get the stem of the path, you should use
> $(patsubst $(obj)/%,%,...) instead of $(notdir ...).
>
> I do not see this usecase, but if you create a composite object in a
> subdirectory, the Makefile should look like this:
>
>    obj-$(CONFIG_FOO) += dir/foo.o
>    dir/foo-objs      := dir/foo1.o dir/foo2.o
>
> The member objects should be assigned to dir/foo-objs instead of
> foo-objs.
>
> This syntax is more consistent with commit 54b8ae66ae1a ("kbuild:
> change *FLAGS_<basetarget>.o to take the path relative to $(obj)").
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/Makefile.lib | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index d56cda3c1e8a..0453a1904646 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -236,9 +236,9 @@ endif
>  # Usage:
>  #   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
>  define multi_depend
> -$(foreach m, $(notdir $1), \
> -       $(eval $(obj)/$m: \
> -       $(addprefix $(obj)/, $(call suffix-search, $m, $2, $3))))
> +$(foreach m, $1, \
> +       $(eval $m: \
> +       $(addprefix $(obj)/, $(call suffix-search, $(patsubst $(obj)/%,%,$m), $2, $3))))
>  endef
>
>  # Copy a file
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
