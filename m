Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E48F5A8847
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiHaVns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiHaVnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:43:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC3FE58AA
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:43:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u9so31006736ejy.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=noQJgEZTEQcpa/6dOGXVHGaPl3bYXEs4M28ZIq9Z6Tg=;
        b=X9RwiMmsswutT5jvrsy1LnT9cc3lwX5Hjqdp/3cjpmTOF06bbCfyhqtT33dDp2QknO
         yX2MpnUgJDps0WsH1xOM+mz+Uf7PMhF+1U/2zv20/ZokxU1iCMf32nHM5vxCJW3Tp1wi
         0IHx40CuGUVYjFC2suKGVuuDtNBegOgpriSzv4xQ5yOANuieRygnEOufkYHX1bM1OhzW
         ll3fn66XGGoiBhPT5W1XTrUsTUq9AnYD5IAUhA+p/FnWv4XKs5LXODVQzYGns8/klaGz
         BWrRnuypFp2yb+1bxV1FbWpo0Ove5egLYeQB/sH6kzjSIcvK0eQYn9njlTKIKND0wxRB
         Wn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=noQJgEZTEQcpa/6dOGXVHGaPl3bYXEs4M28ZIq9Z6Tg=;
        b=Mf+XEXJDPcvvx2bPO2LnF2pVnZdOksdMRKifoLV0u188Czz2bePWGOn9yg9aG41CHw
         MlZA/4ULOBdcTADNqwtFbyV2ifEYF4EMI5n/swXOW5p/2TeQ32pX9ERr36UqZOsH0b0k
         d38gTtfqL6qdZ/gLvLGw8y+sNVlF4gs6qLnAl9O+2cexSxaRs6vQXU8zYuCdkpp5GvH2
         ZJZZYWh1QsNNuAaMa9ymjtOElnqlg0D3aSyrBhcIghlrTh8sMkyaal7jEdA/RPmbjToK
         nf5AFu0o7K+tA8n/Vug1/0i5KbuBzxEApSM3lbJHb5koE/pn1gGUXmj8kmsyTP8oWQJz
         Qmfw==
X-Gm-Message-State: ACgBeo2dy7J6KH2SyCPFfwcVB3Ve375eOOQjFkKYV2GGa3bCQU7OOnpg
        1RTf/EDHPFjKTVeYj806s5Q06zdCuatWhnYYTefuQA==
X-Google-Smtp-Source: AA6agR5Qs1aB17CjJQHStueFA4+rLUel8x41FRNKwGuvY/5w71WxYFjetmf/3FrqX6O0hVrz+QVjP5ezUBYmz1nvWAU=
X-Received: by 2002:a17:907:7242:b0:741:770b:dfc6 with SMTP id
 ds2-20020a170907724200b00741770bdfc6mr12704648ejc.203.1661982217805; Wed, 31
 Aug 2022 14:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220831212744.56435-1-andriy.shevchenko@linux.intel.com> <20220831212744.56435-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220831212744.56435-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 23:43:26 +0200
Message-ID: <CACRpkdZp9Jcq6Ti3FAavrBPi5xM5SLGyecS2A9T16OKv_h=95w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] regmap: spi-avmm: Use swabXX_array() helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:27 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since we have a few helpers to swab elements of a given size in an array
> use them instead of open coded variants.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

LGTM
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
