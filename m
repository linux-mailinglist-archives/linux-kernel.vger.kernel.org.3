Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66F522F27
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiEKJS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbiEKJSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:18:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F259BAC7;
        Wed, 11 May 2022 02:18:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ba17so1784550edb.5;
        Wed, 11 May 2022 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXS0yW+0IcDdjRjEe31czGkw0Rugc3CtPkAGtXZ/h6g=;
        b=LU7MyaWJehUmZPza+nAsaCsl9u26dN3RvR3uVdlxck2gt6nXab6l8upNIFrWPKJyZP
         VhLLyF4wngqY+bcK6NxToHLdrdsSgMBPhMoTQ+Di9uaVTXkLaM3smW99KS+hDlrNMRuX
         U3Qy+2hQWABEOhLearPTRiI5lnJsEUVbaFC9MHm/4h2IzH7QlepQjQjE57OOf2PJ/X4C
         BZSax/i3CvSP7+NDK9YJpGtL6H+3z196y5V4uNKkU4VPRbROAWbSP16zyEYX6thlP2Wd
         UNUPhC79bd/PAuS048Va2Kb/7SWjb9HgxbK8zFIdjP6X9YPXElSRFV3B1OHhXlPRDoU8
         yEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXS0yW+0IcDdjRjEe31czGkw0Rugc3CtPkAGtXZ/h6g=;
        b=pyG6LiaEXCKAPCQYH2CCgk/P1U+Qj7Mknz+KkYHEvOCzuTrxaZLfSbAMQDLKq/XLqC
         h9NFLFyz96gDhUScHk20c6c2hNmDmcVSuycHx2694EFuCOG3Up9buyG0MBb137w4z8ok
         Igf0lVmZej/ArpmWGdZbPLJR1f+TAlh/WoO6di8Qznt7F8W2nW/m+LNLkZeBcnGpx5+0
         9dwexCiubpAyQc2Pw/KiPzBrvA2n/n3ve4TmzT/q8AA7778btefnJQxDjydBVBy8cVR8
         ahYYAqX9x1DSb2LaMeeInOIZ9v4TEQi5aBFJqgoYR4pzTTJyARGJkitmI3cGwpa/1Edw
         ETiA==
X-Gm-Message-State: AOAM5327ozxb1vJOUYB4indsIdvq1DXGQWjgpNl+QQ3cCsgqX3rccNK7
        CKZg9nrH9gRrz8ZRrKT45fnfME/F1uGoyhf7Kgo=
X-Google-Smtp-Source: ABdhPJyl/VOXNYLums4ReuHqmBuwnb6C5RopKopIqITvRa12z6BjZTB1VGi7oQ+cUO2/oD36q46W83YIl1Km36m1LsQ=
X-Received: by 2002:a05:6402:d51:b0:425:d5e1:e9f0 with SMTP id
 ec17-20020a0564020d5100b00425d5e1e9f0mr27625201edb.125.1652260700381; Wed, 11
 May 2022 02:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vc+G1JNkxBcpyXge9qsGpT0m4erBV1aEi4bMHDYfE-JOw@mail.gmail.com>
 <20220511021522.1488373-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220511021522.1488373-1-chi.minghao@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 May 2022 11:17:43 +0200
Message-ID: <CAHp75Vcna-XZVxBn900CfOCC0V2To3OTpT6_aKYQVEToNGQKVA@mail.gmail.com>
Subject: Re: [PATCH V2] samsung-laptop: use kobj_to_dev()
To:     cgel.zte@gmail.com
Cc:     Minghao Chi <chi.minghao@zte.com.cn>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 4:15 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Use kobj_to_dev() instead of open-coding it.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
> v1->v2:
>         remove Reported-by: Zeal Robot <zealci@zte.com.cn>

I believe you want to give credit to the bot in the future patches
like this. You may use commit message to add something like "The
suggestion has been given by Zeal Robot."

>  drivers/platform/x86/samsung-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
> index 19f6b456234f..c187dcdf82f0 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -1208,7 +1208,7 @@ static int __init samsung_backlight_init(struct samsung_laptop *samsung)
>  static umode_t samsung_sysfs_is_visible(struct kobject *kobj,
>                                         struct attribute *attr, int idx)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct samsung_laptop *samsung = dev_get_drvdata(dev);
>         bool ok = true;
>
> --
> 2.25.1
>
>


-- 
With Best Regards,
Andy Shevchenko
