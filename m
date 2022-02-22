Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E5C4BEFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 04:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiBVDHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 22:07:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiBVDHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:07:44 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26F510CC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:07:19 -0800 (PST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 21M36qlP005566
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:06:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 21M36qlP005566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645499213;
        bh=wBqJ9/GpIlL6rlGbNbSQ6pExSwYHZ7W3D0VCbn4oviM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kn6dzwLZ/ntKgxYh/HYBUG5ymUlx05xLRPut12HUTGEN/F1mtnbkQt6JcGPmfXHNA
         n2lsWhrDzCyRiT937xBt+nEmwR93ClGPuxUJmzRsnXZVC0ODmxM4lQrGvYoyd7jikZ
         1xXBfp6tm9qXDqfMj3yQrBvr+XM2cxToFEfNs+BFebmVTO5h/6ObKMjuSYWtjeOKee
         JaYivsxFX1+y6r24cXKRwZ+b4mrMKhaOtDqayUHnHTIq7xvOll9oaspsBZdtPVkWIQ
         5KuFoo7mFqeUFXq+/kf6N6J5uBvG/+pljsagud9bRiyJ/I6xyClR9hNAEXtbwqwbOu
         FpD11f1TKctSw==
X-Nifty-SrcIP: [209.85.210.180]
Received: by mail-pf1-f180.google.com with SMTP id d17so10617648pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:06:52 -0800 (PST)
X-Gm-Message-State: AOAM5335HorRcyxy6KP7ubHec6mn4UsETM6/L0aaF9hr4pj4UOYXMi05
        zFUFmeH0Sw5Qq/iXGi/xW9sXITnadGsGqBaI7mg=
X-Google-Smtp-Source: ABdhPJy9j4aRlUntGe+kmsSBRajG4zdvcD82SwIlnKTfsLKWbARySdmDZ+TW6Nta/XKeMVnbbdZ3pdMuLGJUUtuP8VA=
X-Received: by 2002:a05:6a00:a01:b0:4cc:61e5:c548 with SMTP id
 p1-20020a056a000a0100b004cc61e5c548mr22917058pfh.68.1645499212090; Mon, 21
 Feb 2022 19:06:52 -0800 (PST)
MIME-Version: 1.0
References: <20220221084614.1682022-1-xujialu@vimux.org>
In-Reply-To: <20220221084614.1682022-1-xujialu@vimux.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 22 Feb 2022 12:06:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=zPm6XxoUK=CQAiX6_0DbGtWY=kLG5nDQCPtfV36rQg@mail.gmail.com>
Message-ID: <CAK7LNAS=zPm6XxoUK=CQAiX6_0DbGtWY=kLG5nDQCPtfV36rQg@mail.gmail.com>
Subject: Re: [PATCH] scripts/tags.sh: parse *.dts.tmp for compiled sources
To:     Jialu Xu <xujialu@vimux.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, rkovhaev@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 5:46 PM Jialu Xu <xujialu@vimux.org> wrote:
>
> There are files listed in *.dts.tmp, parse them as *.cmd for compiled sources.
>
> Signed-off-by: Jialu Xu <xujialu@vimux.org>
> ---

Why?




>  scripts/tags.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index 16d475b3e203..f64c33f4dabf 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -97,8 +97,8 @@ all_compiled_sources()
>  {
>         realpath -es $([ -z "$KBUILD_ABS_SRCTREE" ] && echo --relative-to=.) \
>                 include/generated/autoconf.h $(find $ignore -name "*.cmd" -exec \
> -               grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ |
> -               awk '!a[$0]++') | sort -u
> +               grep -Poh '(?(?=^source_.* \K).*|(?=^  \K\S).*(?= \\))' {} \+ | awk '!a[$0]++') \
> +               $(find -name "*.dts.tmp" -exec grep -Poh '(?(?=^# \d+ "\K).*(?="))' {} \+) | sort -u
>  }
>
>  all_target_sources()
> --
> 2.30.2
>
>


-- 
Best Regards
Masahiro Yamada
