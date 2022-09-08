Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2E65B1568
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiIHHJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiIHHJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:09:01 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D918FD5B;
        Thu,  8 Sep 2022 00:09:00 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28878hgN022035;
        Thu, 8 Sep 2022 16:08:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28878hgN022035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662620924;
        bh=PVKlmhmwpV0pLgSi1ek3+0DUiw2m6Eg7M0VOWvovdBc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u+9uVVlzjc67QvrIeS4fdznX24JcMq6U12l6W0QXg0TGNza7drsjsaNVJ8WERBk3N
         OeEZDB0pnKquBVp2CR+xPPL7sxf02x3PxTANOZj9pt8eochK2H94ol6wNb/9tdn+fu
         Tbb8OjzKg9RjtXS4vrcttPwnfIu9cidT6dUhDTKmuaCM0Me3zv8FHv7oi2YPugeZH4
         RG25KmLY5fHQtQeq7nP8ILsca831gLSjfTGPxkOX6Ad0jdq1qI1KsZyLyxiPjlUd6c
         tGxaMrPjbyI6ZjEzom5A2FIrn/Fzr4zdBAxrUKeAnbrdkBx09doGWvBzRyeTn6XBe0
         drZSVWKLwCS1g==
X-Nifty-SrcIP: [209.85.210.51]
Received: by mail-ot1-f51.google.com with SMTP id z22-20020a056830129600b0063711f456ceso11795904otp.7;
        Thu, 08 Sep 2022 00:08:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo34w2uAOZHM8pC9L0XhrM7QcakaFiMyTV6hq8B3/MQ9Gm4n65FX
        wh7fnYVbXFt/WvRG1a/x8RdUdExQS/1UZnqepdQ=
X-Google-Smtp-Source: AA6agR74fU7kTwBXWyksY2XmkALd8hye53EFmB770dfrBQd9tfEOHH7g+N6eDGv2TAlx/g/i4VqXrHA2Ycq/xFHFxBs=
X-Received: by 2002:a9d:4806:0:b0:637:cdca:f8d3 with SMTP id
 c6-20020a9d4806000000b00637cdcaf8d3mr2968943otf.225.1662620923019; Thu, 08
 Sep 2022 00:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220907230339.271633-1-danielwa@cisco.com>
In-Reply-To: <20220907230339.271633-1-danielwa@cisco.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 8 Sep 2022 16:08:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQSUkWz9hvEmB1wSCMJ0Do209QZOgAxO=oSK6HQa7XgTg@mail.gmail.com>
Message-ID: <CAK7LNAQSUkWz9hvEmB1wSCMJ0Do209QZOgAxO=oSK6HQa7XgTg@mail.gmail.com>
Subject: Re: [RFC-PATCH] Makefile: dts: include directory makefile for DTC_FLAGS
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        xe-linux-external@cisco.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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

On Thu, Sep 8, 2022 at 8:03 AM Daniel Walker <danielwa@cisco.com> wrote:
>
> The current Makefile will drop the DTC_FLAGS depending on how you
> build. For example,
>
> make dtbs
>
> includes correct DTC_FLAGS. However if you run,
>
> make nvidia/tegra210-p2371-2180.dtb
>
> The DTC_FLAGS are dropped. This appears to be caused by the top level
> Makefile not including the Makefile from the directory where the dts lives.
>
> This normally doesn't matter because most dts files have nothing added
> from the Makefile. This changes when you have overlays, and the
> DTC_FLAGS modifier is mandatory for the dtb to work correctly.


I recently fixed another issue of single target builds.
https://patchwork.kernel.org/project/linux-kbuild/patch/20220906061313.1445810-2-masahiroy@kernel.org/


It fixed your issue as well.






>
> This change adds a -f argument which includes the Makefile from the
> directory where the dts file reside. This change is also required for
> dtbo files.
>
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index ac16bd92b156..bc245e2dc8d1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1460,10 +1460,10 @@ endif
>  ifneq ($(dtstree),)
>
>  %.dtb: dtbs_prepare
> -       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +       $(Q)$(MAKE) -f $(srctree)/$(dtstree)/$(dir $@)Makefile $(build)=$(dtstree) $(dtstree)/$@
>
>  %.dtbo: dtbs_prepare
> -       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +       $(Q)$(MAKE) -f $(srctree)/$(dtstree)/$(dir $@)Makefile $(build)=$(dtstree) $(dtstree)/$@
>
>  PHONY += dtbs dtbs_prepare dtbs_install dtbs_check
>  dtbs: dtbs_prepare
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
