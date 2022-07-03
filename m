Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F97E56480A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiGCO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiGCO23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:28:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DC56322;
        Sun,  3 Jul 2022 07:28:26 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e69so5903773ybh.2;
        Sun, 03 Jul 2022 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jdpozfV1qmOZRGsJtmMSQ4ytOWKV2O6MRnturbNT4M=;
        b=pB+tq0qVBJaTwwb2RFXnZahTMnmUBiaDu99OcfpEf+PiOi5lYzI1BUOtmWQl7/AiIt
         HNKxyMsG+o2szTbyEfF3uCLnOqsr6g18DNAxquj9SPdxRK8RHXb+GXnj+4o5RvO+ri27
         CzoL4o7pOkuzQa6ksUivvINPg+n5r0hlipSwbQhGhDndksamSU5TIbZUtypyrgPKDCWc
         POv/h6VVdo9oyXhNgc4cUrrndSK+GslLtBGrHfyW6pBaiVXu/zVdR1qmH5iKzgeUkp0T
         oNftLkgrAnuD7IH32/qucHLMOxjn5KnjdeLKFYwcFGV2K+s/oZAZt0t9L7z9XeY3QV6a
         jjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jdpozfV1qmOZRGsJtmMSQ4ytOWKV2O6MRnturbNT4M=;
        b=1AO1dpLiPjfzmxoOGiEG6YQP7V6d2cp+RtYuoTcTErqPdcPpiGw3TbgGIC6+AJS7nG
         t3y7ckgffc7e+HpwYqgRIktyZSiWF1t+cXrBBgbMkjRP+yW5RoSmJNVr04e/PF/5krby
         wtdzU7XCnAGocBhcipFSkhFw4fS9e2PryYh/x5Ba6SY3Gut2Dv8erBjI4KKwi98SYIxO
         2qN7813DYCL5HW3gHjjuWy5Veax4kFhtz5lI4vEX0jipZZo9h7sqol8c0uC2AQsPVHGp
         4os7s8xbymRTp30fPaljwzPXpb0yz4Wd0iFt632FXRhsBbfXkDG9sPz4m9SwVyEX6IkU
         BZWg==
X-Gm-Message-State: AJIora9V9UFDKnhIrbFbOJHSYzDyuWXPGSJJriTLT1o6S+kvb5y/6VFq
        jocp1glHjlfCyUMkrVkp/p+8+h36gELHrtk5MMFySamQzhWzC9jW
X-Google-Smtp-Source: AGRyM1tqnJgQOfi3UrRgfvuocrSY+MaCsGlCRyLUJ9PHx0o9Hb28zY4qErIVqyb8vnII+Jb2Di1DDTknMSmm9ymGbUU=
X-Received: by 2002:a05:6902:1142:b0:66d:999a:81a7 with SMTP id
 p2-20020a056902114200b0066d999a81a7mr22460227ybu.460.1656858505971; Sun, 03
 Jul 2022 07:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220703112101.24493-1-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220703112101.24493-1-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jul 2022 16:27:49 +0200
Message-ID: <CAHp75VdjPVzOQ15S93GDnYz3cUFkHF-sF97f5GhoDEHdM+iFDQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] regmap-irq cleanups and refactoring
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 3, 2022 at 1:20 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> This series is an attempt at cleaning up the regmap-irq API in order
> to simplify things and consolidate existing features, while at the
> same time generalizing it to support a wider range of hardware.
>
> There is a new system for IRQ type configuration, some tweaks to
> unmask registers so they're more intuitive and useful, and a new
> callback for calculating register addresses. There's also a few
> minor code cleanups in here.
>
> Several existing features have been marked deprecated. Warnings will
> be issued for any drivers that use deprecated features, but they'll
> otherwise continue to function normally.
>
> One important caveat: not all of these changes are tested beyond
> compile testing, since I don't have hardware to exercise all of
> the features.

Obviously you haven't rebased it on top of
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/log/?h=for-5.20
so it may not be applied.

-- 
With Best Regards,
Andy Shevchenko
