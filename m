Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00472507C88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358179AbiDSWcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357945AbiDSWcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:32:14 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553A924BD2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:29:30 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id f38so33707845ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zuM8nG3cO/PIrYntUrSlVCavn8HajJfWR83dwgHZAc=;
        b=AEzZ3A+hYTUIe2NVJP4fLIqhDcK5nrkz96aAW5rPNMWVHOL6auQw/UJzivY1DPSTMG
         5Ye5NIqaoNDEg5Tp+k1mWWsOCubuPU+12Oc+ZvK/P3q5bkRKm0rM2mu9MDpIaBz5uuCf
         ZnlZsin2jE0HZBC5+dMstkMb2ifchEVWfHeenolfT0xlWNO/J4IbIDitzDb8vNCmvRF+
         fWrddoLgPMRm0mKXgiNZKqid006Vyc83gK5BGC21epHcKPOE/ovBNDrhQKIcST1Qorw7
         nxsex7fILKVqmsofxa5jVswd2WmpRiR16BR4M+ILpBg7dnx5rFLkD4IFstgTuXeVUTFf
         8c2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zuM8nG3cO/PIrYntUrSlVCavn8HajJfWR83dwgHZAc=;
        b=RgSyc7v48IaEk10dwDhVpmnC0YVluGXwKSgjz7cXIVPIDodrFzTSMtsr8147lI04zZ
         bCDx//5lRRatvRiJptgYBCA0FbDiH0yc9mdFVdeY5jGjAW/Wzvg2vDGlPIvYQ/ZLmM7c
         EendvOphk365mQZTeSky1R5moY5/dch/8U1T738IgHBA/YrNErOzLKnWvkLyQGW9HeAq
         K4vrAjYv4d3rARXQH7ZNCyu4XDI+9ai4uHFY+Xp0Xq6ZXMFpPbpLz49ZdYJ+ewVxcY+X
         i4htBgQ6vXPuNg2+QTnQSWLl0dU2RVcM8ubX6meh1Z4lKUbMNk9+nPINPry6rEUsTtvw
         7Qtw==
X-Gm-Message-State: AOAM531sOPni327/4fz9esH8zjo6RCuJonlV9OF4SmzyuAKvPMQtDQD3
        Ri156hfmdUPpbM+IbAtmhVDHA7iau5dLPyV8eZJw+jFg2Tk=
X-Google-Smtp-Source: ABdhPJwuKxur01PeTRkyAKAb3csKYu1uHrzCQnsagqH5TZXwlCPlmSMxIVklVK3WVDZu+Blt4aWf1HFMxNUZWH2UJVA=
X-Received: by 2002:a5b:8c8:0:b0:641:e8de:a6f4 with SMTP id
 w8-20020a5b08c8000000b00641e8dea6f4mr17166614ybq.533.1650407369452; Tue, 19
 Apr 2022 15:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220326192848.2944519-1-michael@walle.cc>
In-Reply-To: <20220326192848.2944519-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Apr 2022 00:29:18 +0200
Message-ID: <CACRpkdY26vNvmcv+NCuoyp9QGXWX0Ad_g39J7XZm94tQAt7P7Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pinctrl: ocelot: add pwm output option for LAN966x
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Mar 26, 2022 at 8:29 PM Michael Walle <michael@walle.cc> wrote:

> According to the reference manual, you can mux the PWM output on GPIO27
> and GPIO51. This was missing in the pinmux table. Add it.
>
> Tested on a LAN9668 on GPIO51.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Patch applied!

Yours,
Linus Walleij
