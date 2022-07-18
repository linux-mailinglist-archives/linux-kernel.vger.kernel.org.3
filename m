Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5021578DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiGRWsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbiGRWr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:47:59 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED76A3136B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:47:58 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id h62so23464998ybb.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qolLFWuKdiYI62AFKCu974H8q25eVpSfVOUryfjouBM=;
        b=Q7hsm8N9967oVOGqVd8UHRMKAjY9nrR933mY93k9vYBclm4xJN79WDlUUnnrDWiPtL
         SXeBz12JkMmnoustrv+YTsDaeLfNQjh+FNnfHW8CDGZC1xl7Y1S+CoU7OdDem/pBoGfL
         aEgxNNeSI2RVurzLJ0BknTkK16EsnH4AyaSN0n4sW0Cqr3e49SZeg9taiEn1Wp+5ol7V
         h9nCCThs2bSLognyorwJka59JyyCVW4JxaIg2xBqaQdi7AXge4dhONPED75YONCpzBit
         b509mp3LeI8/DQpTmvEs7UelEDbzEc6fE1haOoIzD0mkI30WbwH5u4h10CLmmwSXOeAx
         DlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qolLFWuKdiYI62AFKCu974H8q25eVpSfVOUryfjouBM=;
        b=KAjnRIbKd7zzE0HoSayqNkPGGddcRCiA3ge/DLCKRvGPkQllDkpDDxDrTXuSKfdjPn
         y14BwVXzbD/Mq+gQR5UEGmXaVO9ENOYwCyS0D2YH+10T7RWDKzVgR8/HctAJx5uCUnq3
         EBH7nBnmadruRAyvNLs2t35t+cbYqIYH1lkQbxQlhC7zfAh/MxihfK8q0coCrCWPQhqP
         b7vfdgWBJs10q9DfWvDxk+6i5PlpOZKoWy5eofLbBL5y+SUiHSpk80lam6ttQ8YY5NHY
         pK3xjB5/0768NtreqJ3TalCznJS8lGJ98GJJiRgYf6mKGwdpusPvWaRhQCpAFCQ8xLMR
         N9sw==
X-Gm-Message-State: AJIora81hpaEfq7JEUkzMg9G+NgGM4sfaYM2HxqgGE7XX4y0tf6VvOQ9
        g9q1cPh/LsppX1doEq8ACVuMjYeepWNM5dHjh/bD1mmh/z9vfA==
X-Google-Smtp-Source: AGRyM1tiaRSIdp3sBehsOn+o7ve/l74jiJVV6ahHPRdqNZAxJy5hvMS4ID9Zj3gM7addqOpdzsrohFqzWd05UXSewsw=
X-Received: by 2002:a25:f508:0:b0:66f:3c5f:c39f with SMTP id
 a8-20020a25f508000000b0066f3c5fc39fmr28146462ybe.374.1658184478277; Mon, 18
 Jul 2022 15:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220718220252.16923-1-andriy.shevchenko@linux.intel.com> <20220718220252.16923-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220718220252.16923-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Jul 2022 00:47:46 +0200
Message-ID: <CACRpkdb--xdd0RKZuuups6q7mC7oyEPSrW_F02RYr5UNT-QHWw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpio: 74xx-mmio: use bits.h macros for all masks
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 12:02 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Make use of the GENMASK() (far less error-prone, far more concise).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
