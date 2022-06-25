Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C72855AD5B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 01:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiFYXGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 19:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiFYXGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:06:46 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8492114096
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:06:43 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3176b6ed923so54621837b3.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+pHW+8BgeYr33HXAIkqALey4HRl25+7F+mqKkIF73lI=;
        b=OyZJ8EhnQ3k/JzGhjvLf/pMPtpcd9SZRT3ncEi3wzhHrGQ1lSMjKRUpTbAiq5AvxLQ
         /VflYEpdayhpXR+MVutbT/z9jK9CmZu1myzj73D85E2WqmdoAYOu3iUxN2Z3XVmoIPWZ
         T7Pe7XhNljqA1UwOGbTo3OgRV9nm1DiGHtbCx95Q4kADDu6RfYLai/Fu/l+/skVEJKoO
         fuUfAWdBukc5hdhFe8pubZC6qTz1reuvHc5YbdbUgVP+dWavsAVSYzKsYOcecJLwx2Ah
         qDApmCg5bJS/05fUq3BDhHDps4j0b7lRoxVl1Q1j77vRGvFe/Qa2wlgurSo+7rJ69+Bn
         EajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pHW+8BgeYr33HXAIkqALey4HRl25+7F+mqKkIF73lI=;
        b=rJJyJ2Tn+IEBmH/AxXobVwPC/NQDyTA16y+bnT1D+NR+ZniI6ETe6Vbe2jrg2t/FxU
         QSzyVxszbmP0l64mV+HQ9LF3kV6lcG8jDv2w5nEeEA82E7csx3HkQw7QnFsNs1zNe3iw
         MLxyhJdHWqjVCyh0VaxAsF7ZMgdOMI1JrmG6CVbnCvsmOgmPcLUY6V7V87G33Gx1xx+L
         hnloM83orMganxVlcDKejKH2y+gmNEzRvOXN6Ii6dBfimjRugv+sL8vWIDek1gmKw30H
         toR07Y/0unXKdM2l06c1uo3+rOC+tiBpCuoN6e3nSvLdFq303QFq/9HAylvsUs+2DalH
         hBNw==
X-Gm-Message-State: AJIora/cWJuVNQ9GhoVqoJ4qDIeL4ZhiXLU/7Y3aozERKQbGFd8ipMPM
        Ee05Rn6hILG6TKxGCZqhE4MdSkqwhg+obnxn5YIjbNfio18=
X-Google-Smtp-Source: AGRyM1sPLO6FrhlQmmjU07VEXOAI6hRlCO21a4yWfilP3YXKpw0ZTG2xPM+drXuU5w/0zlYyo3JtFUnBRs1lEQUzBS8=
X-Received: by 2002:a0d:e20a:0:b0:317:ce36:a3a0 with SMTP id
 l10-20020a0de20a000000b00317ce36a3a0mr6883637ywe.448.1656198402820; Sat, 25
 Jun 2022 16:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220615082940.3960612-1-windhl@126.com>
In-Reply-To: <20220615082940.3960612-1-windhl@126.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Jun 2022 01:06:31 +0200
Message-ID: <CACRpkdaLPcVHUQL1d7e797vN_WRi0kbnLtfTa9Fnp1id3anjfw@mail.gmail.com>
Subject: Re: [PATCH] drivers: clk: Add missing of_node_put() in clk-nomadik.c
To:     heliang <windhl@126.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:30 AM heliang <windhl@126.com> wrote:

> In nomadik_src_init, of_find_matching_node() return a node pointer
> with refcount incremented. We should use of_node_put() in fail path
> or when it is not used anymore.
>
> Signed-off-by: heliang <windhl@126.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
