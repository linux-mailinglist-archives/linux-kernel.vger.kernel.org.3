Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E933D507CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358226AbiDSWkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347010AbiDSWkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:40:09 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43CD344DC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:37:25 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x39so4212960ybd.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHvW+03ED2tYu4Zc1Qx/QXTIQqIJndOUJvkwVF3dUzw=;
        b=KC1Vt+5i5fAy2PedzcgEhblxFonWCsWxZpgTS3ljUOCjn93WSPU4jpdQBgWt3mjRF8
         41qJaRHQ+sEjHpeonxCeuEz7a8/lbqS3c2u9kkrNFPwCuIEcvp0JwKLJ/b5T9/B2E7up
         VSG7LmWs28u/snGIGkbpFnNxqMCX1ah4wXYQSyr/vhGaC9DpweEVspQNWhcgF1x5UKP+
         oLqNKs5v0v9VoV6RdMWBWE/ENlCV634aNlHybelCyX5NiakDK6uLkwnVbIe3SZ/kYArb
         mMGkuaDtTlUY6otE+kIax2JVTDq9ruMVWGWXR50C+wO+uJPr+NtPRbB1Eg7qU7r7OlOJ
         gEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHvW+03ED2tYu4Zc1Qx/QXTIQqIJndOUJvkwVF3dUzw=;
        b=ekt7QJLrRpl6qvtwGbdXOSxDw89Sren/szk2YhXMggul/NkIxtZBG8F0ZWICChmPIF
         CjFwNcWSlxDNYbm6X23huurXN8kecwzi4lqHkqlUdNBHQEhzsM1IZcylGIUBvv4lhv9k
         HAVZ92w9szIyDOIKlwL9qQFQ5yLI4qQNKisMZ9c3zsg8FgaJVAt6slPfKKT65kuSjTvb
         7nDhtZfRKlAC20wI2ZZJ4ssZ6OTvfUXU+r/byF7HRS2yLHxyQQlsID5Wyg2syEWHWrUb
         FFhil16yBq7VlXVja2y2eSSXWCGTAtQPHwGBdYcVE8XSkpZBaz/4q2phNkRR1vGAibmm
         pwWg==
X-Gm-Message-State: AOAM531cYPCF89B03s5dImYjmh7BfJFZxNw3Qj97R2cy3koEFBDNgtI9
        K7IicUyxaJIh5UIgWJ11epyEhKTbw9V5MeNgtmVRTg==
X-Google-Smtp-Source: ABdhPJx4/6P6ZK+hWY3bx2/guKCQWn8dYwnr5RG5P2rZ+wpt/zD6Cml54rdbvZGo6SimeEMhGwlprEEA8+tCwbNRQ/s=
X-Received: by 2002:a25:73cc:0:b0:644:f4a3:6f4f with SMTP id
 o195-20020a2573cc000000b00644f4a36f4fmr12801929ybc.369.1650407841127; Tue, 19
 Apr 2022 15:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220328005005.72492-1-kc@postmarketos.org>
In-Reply-To: <20220328005005.72492-1-kc@postmarketos.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Apr 2022 00:37:09 +0200
Message-ID: <CACRpkdb=V_ZbtRw8_wyTyKLPO1b4VtscfHCa_40Fd0hSABZObA@mail.gmail.com>
Subject: Re: [PATCH 0/4] rockchip: support configuring pins as input
To:     Caleb Connolly <kc@postmarketos.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martijn@brixit.nl, Arnaud Ferraris <arnaud.ferraris@collabora.com>
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

Hi Caleb,

On Mon, Mar 28, 2022 at 2:50 AM Caleb Connolly <kc@postmarketos.org> wrote:

 Caleb Connolly (4):
>   pinctrl/rockchip: support deferring other gpio params
>   pinctrl/rockchip: support setting input-enable param
>   gpio/rockchip: handle deferring input-enable pinconfs

Those three applied to the pinctrl tree.

>   arm64: dts: rockchip: rk3399: add an input enable pinconf

Please submit this through the SoC tree.

Yours,
Linus Walleij
