Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB22C4FE2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353179AbiDLNsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356318AbiDLNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:47:55 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B62B5159C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:45:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ec05db3dfbso80516707b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+95UQNr5ADFBE+AaXdQTrnS8iQt1u7b5lSGLz5HpP4=;
        b=GQNhROvvlsggOBL7u4NxRAPQkyV3Vc+MoXYI9CqyQeqxE03PQ4HX6W0Py1Kd3svdCR
         hZ8eFz5u6ePb0FUDbVnQ4yRiD6/SBTy9+AVCXGuq9EYfCVoK4E+J4JNkS5EyKikpNIxM
         WXXBh9kIndUEkyLcXTC/gxXIgTCwkEMrKnPT3p+L0tVEfnmioNhSR7CPp2UmwGE8Co9F
         pWIrgj//CY2y54KZ3BU8AbhXDdRwhN3p5T9hGRQcTcrBtJq3JQTuThUbnbQ50u8Dy7ef
         Jk4o3L+l3AAkkdBLH3kKdBgGwKqRjdhaCTf+2CdyPiUfDsmNxbByTAHpV/typPNOZO5s
         i/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+95UQNr5ADFBE+AaXdQTrnS8iQt1u7b5lSGLz5HpP4=;
        b=mCfe4+11SnMF60gsfVM74OZZ7676bRCNBCEUcrI4HmSHELb3E1lFGmEIo40Nlufn7G
         E1PokGidzFCLjlylcQ4INe8U3EjxYYy6GSCmrIIr8y+r/NL5X6V4yOSEqrmIEg7cgxKq
         mbcyOKQZ5HjqcZ1/IcBgBsv+U81J7NtwwVOOsryTfh21vCPMtEJ+MK7jyiaPL74WqJwl
         XgLWbX2Nl9b0RmmBGTPqCMn4oMdNGOYZUm3IKf8kMbx3mMmc3t05RhJltQESo/BDiomd
         8kozKV5oxxAV4usAQMzW0Qr4uQXGKD6R0ZoKAEM9HRnMMbSQh2A8ZhAWdETkxxfqHUBd
         /SoQ==
X-Gm-Message-State: AOAM532dHtgDJfxGsy3TgXIkFIQhM0U7MeURngMIzMGwV8OKJL2oc+xq
        0unTCTMoqtAizzKalSYD2Rbbi4aatQ1ihhv1d3fSVg==
X-Google-Smtp-Source: ABdhPJxSIRzsRJxTMaEyrqsvgxiFAvFxfbJoASvinet9u3rz8+YuEtJfwrpRO7FLqYTR826wAVE3fMaUkuEcT7TSfSM=
X-Received: by 2002:a81:6d14:0:b0:2eb:fbdf:639 with SMTP id
 i20-20020a816d14000000b002ebfbdf0639mr12333305ywc.126.1649771133314; Tue, 12
 Apr 2022 06:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220412085126.2532924-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220412085126.2532924-1-lv.ruyi@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Apr 2022 15:45:21 +0200
Message-ID: <CACRpkdY87j7-Gm6fPM_MXBZvLsHWCPVU3gdbv1b=vB+L-Mn5QA@mail.gmail.com>
Subject: Re: [PATCH] ixp4xx_eth: fix error check return value of platform_get_irq()
To:     cgel.zte@gmail.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        arnd@arndb.de, lv.ruyi@zte.com.cn, wanjiabing@vivo.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
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

On Tue, Apr 12, 2022 at 10:51 AM <cgel.zte@gmail.com> wrote:

> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> platform_get_irq() return negative value on failure, so null check of
> return value is incorrect. Fix it by comparing whether it is less than
> zero.
>
> Fixes: 9055a2f59162 ("ixp4xx_eth: make ptp support a platform driver")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
