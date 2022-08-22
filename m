Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5985A59B8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 07:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiHVFQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 01:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiHVFQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:16:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33AA24BED
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:16:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e21so7508859edc.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9XRquiKtczGZrdHPEqA6WSyvm81oF4bOEAQ+13HYerQ=;
        b=SAiIxcHb4kUDUc3VEa2ho1tzuxThoNNZY/1Uy6ob5cxWpDMAgeWid7qhh1JGHzMGbM
         adHSfp3pJPdwumkTe334GAsPu2EKY2zVf0ZgMGTJDuJ3SrI6UEqh91/qCHuGRXQw1snv
         /1e79EhM6MjTf5SwV0uMLfQFrJ1HoFYfZpqvevvweqdEzjyYFlZtmV/EJfgjhfVj3EUi
         0XsC/T4XkSWokdnUY+/CPOVzfVcr8ThORv6pb4680aMO7Op76cXl+fqJrMS3ioeO09hy
         SzOT7E/D2WeM6kDvgcsmWkGn1PHym4wj8/UETx7DyE0Kmsc+CgU2T07R9NxHLpKuhXhA
         8OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9XRquiKtczGZrdHPEqA6WSyvm81oF4bOEAQ+13HYerQ=;
        b=6c7OjJbW7zWgQnD3+POJI1ZBtLl//OYlYPi+bWzZO0uFNxOi9p/+CPb2n7usKu7H/8
         2aDFlT9tWyTEuv2V2I7AXvv4RMSm6ZKu21FwasmZLUqDGrJBK7XgOFdlr1vNdixE2n0u
         enCOnHD8ZWHPnHKtxyXxptZyS9yV0mRibmBZdK2IwH6H6/IWEPwWtYI+IC/4AgnFUIuF
         s54wxoc2r9oKYBNYXbwBshBaK9uyZrxXnCF3YEOaxNVun30yhlcvEqZX6yRUB3OeCI4m
         4aaDdd5n4druDGCY1CrjuWtOR40pgw8HZhkV9H5YGSTWwM1T98lapSMnIMgrUyhY7pqQ
         AIwA==
X-Gm-Message-State: ACgBeo2g9Bt6uu4wezsb3VHA8gYZQINt02QMARWPGoIDrBIq2Se4oQAL
        kiaq1nm+N9WFML7j5DFpmwKmwsWjGktvFhvMz//zgA==
X-Google-Smtp-Source: AA6agR6LybaPwlMMl65wRvlyq8H6WWQJz/BQN9DIdJiuMLxwbfIvJqdASIjHGPhvc2W10vBYnlWtHxkr+SF+OLGyRk4=
X-Received: by 2002:a05:6402:42d3:b0:435:2c49:313d with SMTP id
 i19-20020a05640242d300b004352c49313dmr14569874edc.86.1661145364525; Sun, 21
 Aug 2022 22:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-18-jinpu.wang@ionos.com>
 <CAFBinCCbjF_mkV+EaOtC0g_YbtX9TzBEN5fRJ_MiPaie5hxCwQ@mail.gmail.com>
In-Reply-To: <CAFBinCCbjF_mkV+EaOtC0g_YbtX9TzBEN5fRJ_MiPaie5hxCwQ@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 22 Aug 2022 07:15:53 +0200
Message-ID: <CAMGffEnmGPDyuPPhWN0vyTMOtCHzfOo-Je=dVJ6ed7494ekKgw@mail.gmail.com>
Subject: Re: [PATCH v1 17/19] mmc: meson-mx-sdhc: Fix error check for dma_map_sg
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
On Sat, Aug 20, 2022 at 7:26 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hello Jack,
>
> first of all: thank you for this patch!
welcome.
>
> On Fri, Aug 19, 2022 at 8:08 AM Jack Wang <jinpu.wang@ionos.com> wrote:
> [...]
> > @@ -388,7 +388,7 @@ static int meson_mx_sdhc_map_dma(struct mmc_host *mmc, struct mmc_request *mrq)
> >
> >         dma_len = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
> Does it also make sense to change the type of the dma_len variable
> from (signed) int to "unsigned int" (a few lines above)?
I double checked, it seems a good idea, I will do it in v2.
>
>
> Best regards,
> Martin
Thx!
