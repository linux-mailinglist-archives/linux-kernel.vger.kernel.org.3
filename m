Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE34D3DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbiCJAQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiCJAQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:16:11 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465752BEC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:15:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a8so8600090ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 16:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8fee9v7BiSON1oc+MzdWwD0g3F0XotKEAPqrnbe0Ac=;
        b=e1M4QVr1W7YbVzbWzm0T3Wq6Klu5l4/VGifbMnJ0ccc/xIImegzdLT28nV2OCw8XKz
         AUQzn9/wrTvwgO7DYiFqQ5VBDg4+Wf60TnJSU+HJFjoK2nbcb5lhn9ilwIOe6HlP9c8O
         GqzBTS1gzJ9X3VY+qIv3lNljaPRKaNIJAGRmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8fee9v7BiSON1oc+MzdWwD0g3F0XotKEAPqrnbe0Ac=;
        b=nbOk3IngkwUH4G38svTNm/q2FG/cbBi7MGLT2/pbh+Y1pjC/Q1Kn/brpwP4cyrv5k0
         35IsGu0/MjdFyHZ1Ky0cBWpHs8aKSw6ysN8k71Ez9LyA4Ubhd57qv1uL1merIjoBv59F
         DvS7JKtZJwY4XFJX9hqPz2OH0S6wApRjTFbNNwGQ+GLmx2x1gDFQ5DPHRq3fq6g0r8xe
         YLzeP84RCRYilahY8XnGaidBPeTBx0AgtujiqNG5DR4qxicKyPcp+a33GCTSKdhFaVsG
         CUiH/omMfNYkkooaF+VmuYP5ZVLJ6ZpURvq8GMYivl/iJPniqExVV49lGDY637qsJ0Xr
         ommQ==
X-Gm-Message-State: AOAM530+AXU7+U9bSf5okER9Pz9OE64rloZ0IvvRYJzsUaw5wnaMjLrs
        3l/PQTuV7cLamBWtqpODcbSM0WLfPRmS3szi
X-Google-Smtp-Source: ABdhPJyjYFBdCy4oNocLmgC9dgfvi7shhyz1LNNT6+0XSfKRoAFd23qupANRqz21bNxvssdoOriU4A==
X-Received: by 2002:a17:906:1be1:b0:6ce:b0a8:17d with SMTP id t1-20020a1709061be100b006ceb0a8017dmr1931767ejg.413.1646871309453;
        Wed, 09 Mar 2022 16:15:09 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906748d00b006db570e6390sm1283763ejl.13.2022.03.09.16.15.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 16:15:08 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id j17so5534070wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 16:15:08 -0800 (PST)
X-Received: by 2002:adf:e983:0:b0:1f1:f52b:8328 with SMTP id
 h3-20020adfe983000000b001f1f52b8328mr1490215wrm.513.1646871307846; Wed, 09
 Mar 2022 16:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20220308033255.22118-1-rdunlap@infradead.org>
In-Reply-To: <20220308033255.22118-1-rdunlap@infradead.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Mar 2022 16:14:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VSAWNnM2-HgS4RxvXz3QgD72gx+Ti7Vpf9k=SLVHzocw@mail.gmail.com>
Message-ID: <CAD=FV=VSAWNnM2-HgS4RxvXz3QgD72gx+Ti7Vpf9k=SLVHzocw@mail.gmail.com>
Subject: Re: [PATCH] kgdbts: fix return value of __setup handler
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 7, 2022 at 7:33 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> __setup() handlers should return 1 to indicate that the boot option
> has been handled. A return of 0 causes the boot option/value to be
> listed as an Unknown kernel parameter and added to init's (limited)
> environment strings. So return 1 from kgdbts_option_setup().
>
> Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc7
>   kgdboc=kbd kgdbts=", will be passed to user space.
>
>  Run /sbin/init as init process
>    with arguments:
>      /sbin/init
>    with environment:
>      HOME=/
>      TERM=linux
>      BOOT_IMAGE=/boot/bzImage-517rc7
>      kgdboc=kbd
>      kgdbts=
>
> Fixes: e8d31c204e36 ("kgdb: add kgdb internal test suite")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> Cc: kgdb-bugreport@lists.sourceforge.net
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/misc/kgdbts.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
