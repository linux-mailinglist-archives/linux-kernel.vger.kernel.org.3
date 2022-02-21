Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E384BE142
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347365AbiBUJHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:07:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347108AbiBUJAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:00:51 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96239275CB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:55:52 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2d310db3812so129921277b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khIa/7OGm0LBxAJ/g0p2l7rc9Ll0z+rpERju9Mdr/S4=;
        b=ca2BM6g6LjvLLbKFUaFNbcxOJzaMrT0V6SJJCTBCBelX7xJIL5aVFAVfafsnrB3Uq/
         G14U5Kvp5Z7JqyB2qclJnQ2wKgZ0e+VvGMHPVFwFQaqsr0fCTgp2ij3BWcy7U/EQPJ/m
         R//+940xfIumpRpHZoRvIrnl/9MI05lGMLy2Y2ZzLZA/J0HvMTe/rU1zqmtaSzqKmEQ/
         ByMBxQzcWrgNhl+imYfsZbw6nQrvwSokjl9Zv8DPVrgROB4Exdd5DgqpWQoP8/K0E0yL
         YvC08J1UT+HlcMPUd+vztOCP6nbHrYVToC567lbI/ZhiC9QWikS1nUGDlmTR5+262AIu
         WbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khIa/7OGm0LBxAJ/g0p2l7rc9Ll0z+rpERju9Mdr/S4=;
        b=5UEHF2PkqNtEB7ZJgUsSe8KuO4bqHr0YV8/i/WQCGYPZ7N7Q6BUqLZEGxYYOrBbqjC
         PfIPxWISSRnAU5nedb7ccjFupElWQNn+ivEcHef2AGV9xqHpDp8usF2npLCsjUWnX9U/
         GFa4EH14WEY//ffm+huwPl9OsH1VMGEbiNf9buWkr5eH0iSUK27a1XfMWsYvl3TLpM2+
         ZAdnWi0XtH/I2/AuzR9qXVQYC30h13gETLsZoRvpLcr+UnpGWha0WpnF+ZialmlKV822
         KPiMmArtePlUXUnwk1I7a9J//4cbAdHxB8FSdbqknfXjf4URLfJaOk7AlXGzPBLMn8Ut
         wDXw==
X-Gm-Message-State: AOAM530xcmvrxtkTU98gKsg8pH4eavIEipG9ZoVkYITf7HqWWyLE2QWs
        sL9BwEqpg5SKsRsPkmIvxZdefJspyWZAoHS4v7VYsg==
X-Google-Smtp-Source: ABdhPJw9c9S+zMttcF9flf1AI2AusXvvBVIzNebse+X2qiShV6S1yQl32GoDHM+Qkg9WedqGi1guJUqnlyT4oJVWL94=
X-Received: by 2002:a0d:fb07:0:b0:2ca:287c:6c97 with SMTP id
 l7-20020a0dfb07000000b002ca287c6c97mr18233281ywf.316.1645433741222; Mon, 21
 Feb 2022 00:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20220221065421.20689-1-tangmeng@uniontech.com>
In-Reply-To: <20220221065421.20689-1-tangmeng@uniontech.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 21 Feb 2022 09:55:29 +0100
Message-ID: <CANpmjNMyb5RyfQG4S=TEBJEY4RDsG8u+D3X=Ate3avL18XLonA@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan: remove unnecessary CONFIG_KASAN option
To:     tangmeng <tangmeng@uniontech.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
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

On Mon, 21 Feb 2022 at 07:54, tangmeng <tangmeng@uniontech.com> wrote:
>
> In mm/Makefile has:
> obj-$(CONFIG_KASAN)     += kasan/
>
> So that we don't need 'obj-$(CONFIG_KASAN) :=' in mm/kasan/Makefile,
> delete it from mm/kasan/Makefile.
>
> Signed-off-by: tangmeng <tangmeng@uniontech.com>

Looks reasonable, thanks.

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index adcd9acaef61..1f84df9c302e 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -35,7 +35,7 @@ CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>
> -obj-$(CONFIG_KASAN) := common.o report.o
> +obj-y := common.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
>  obj-$(CONFIG_KASAN_HW_TAGS) += hw_tags.o report_hw_tags.o tags.o report_tags.o
>  obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o tags.o report_tags.o
> --
> 2.20.1
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220221065421.20689-1-tangmeng%40uniontech.com.
