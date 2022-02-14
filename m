Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD824B5648
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354818AbiBNQa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:30:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356418AbiBNQal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:41 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087AE60D92
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:30:33 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id f19so4680818qvb.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JskXaZJX9EqtyU9nDYwhDYopK1GYBeF5QAk0Zlst3K8=;
        b=WFoQIvGxJEbg8UOaiV70tS6PGdyf3qjcG0fNJQKbyHSfj48VnWpT1uPRsHkSjKp4oI
         VyXEAHc0fq+QePjMo/XUxaUdqQMw6JpndQdJRAM+wSSoz81Cj3PoON8L3Dmir1bNHNxO
         JLMBAFjfwqf69spTV2mC/gqt6Gw5T35QWKhp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JskXaZJX9EqtyU9nDYwhDYopK1GYBeF5QAk0Zlst3K8=;
        b=ZPC7wGrbG2+p+O9jiM0DNVxXXkP4UARcQlO7AEd8UnkuYYoPVHM5e0mvLtsywkE0+2
         S6/6KIOQifB2h0tvWDYNhtbOnsU+AMNZiPovRfuEiwEwtsfyEOp+EGqQjQQKe/ShxHWa
         VNKlYyotzQimkjcQVp7lFU30e/JSxxLz9kdBc/aXVkkjTlYBuyGr08r0I4sM1tDjJ4AS
         92thoBrDBlv5rXtDg+G3amIjbwQL86ohkYGDF8MqMTffNb/8H9TmuGH5msqA2CFPs49U
         7Ji4I5axL6NxJcXo+/bO1biMNsXOxaEPz4y3eVXEj03cSG6uW3nL8suWiyArBEFlAUuy
         XK1w==
X-Gm-Message-State: AOAM532ww2h7MAemVoMKkHFLGsdS5tUjpPxhcNSQVxADIYRFqYJqd0UF
        DJGk02Um54/RkrC3QyF2j1g6XNpBBvHYlg==
X-Google-Smtp-Source: ABdhPJxxBqY9/7Gi8/6HyuHGxXZowoEIg5v7/Yucc9haz25H27ve1NZxd3krv+h7JF1cvkCUhxoQYw==
X-Received: by 2002:a05:6214:daf:: with SMTP id h15mr335331qvh.46.1644856232955;
        Mon, 14 Feb 2022 08:30:32 -0800 (PST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id g21sm18237059qtb.70.2022.02.14.08.30.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:30:32 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id s1so15862109qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:30:32 -0800 (PST)
X-Received: by 2002:a02:3b67:: with SMTP id i39mr299652jaf.50.1644855749283;
 Mon, 14 Feb 2022 08:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com> <20220214081916.162014-5-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214081916.162014-5-krzysztof.kozlowski@canonical.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Feb 2022 08:22:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wzr=ra=_mt63Uj2p6PSNoEF1F=zN0-0yg5rcWkBFYkZw@mail.gmail.com>
Message-ID: <CAD=FV=Wzr=ra=_mt63Uj2p6PSNoEF1F=zN0-0yg5rcWkBFYkZw@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rk3399: align Google CROS EC PWM node
 name with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, chrome-platform@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 14, 2022 at 12:20 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> dtschema expects PWM node name to be a generic "pwm".  This also matches
> Devicetree specification requirements about generic node names.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
