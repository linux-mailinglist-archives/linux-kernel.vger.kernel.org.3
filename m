Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BD750C376
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiDVWfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiDVWfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:35:08 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8A62CB479
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:27:31 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id x9so9635194ybe.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4i3AmNv4FLK6btws/jh0kCSYBAa4f3ciHtxOpc3dZs=;
        b=JRDatOGFzKK/uf+U50BmSx+6g4Pa7D170MDb5ReJoxJCi2YJ+O1LWcsk3ZR+cCBvOv
         GbI3hNcEt8op7qRcvRwQ1rF5AX0KZrXSyqZ64VdMU5KrD7qR1RorXlZ7BdfS/vwlCh/u
         mu0Nbnoz3MxCqG5idEmXqe7YNX3p+7DVU7y0VRUEwRAjMCgtMxMuM8yFYoIs7OpITDVV
         NFr9xZzrgfbvZDJjyHfftICMW18Gae8pnfjA0n5Tq4hFDIEo2naboitBPARNTgAuA9wV
         NLIyepcfEUNoedq5wC333803/JJ4N5AOBz2KgH3OzXG8wBAGvmI5B9QYV9q2Is2Q60Rq
         2Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4i3AmNv4FLK6btws/jh0kCSYBAa4f3ciHtxOpc3dZs=;
        b=HqORQPoMae0K6tRgUz2GHEPxsfIZrBneyGLuMwXGY87ZNpF7IkXx7eHbVDoMDoDiHL
         7Bw22CHpCfEctJDtXsij0iV+/ZUpTw9fo4Ee3QcS85OKcZ3Utyxcb3skFz4QHJk8iQkJ
         HTk8JIEgfsUa7XJ/9nSJCIFLRrXzNprMJPMraPyPlzcpCQ3AwJBkkOnH3C8LZmeomzgF
         5RuHFY8oiLjLYGtFDjnqoKkKXk2B7P6c8GzDhO5NUANHfLVGpndKhQMXKORvHhVExTPw
         Caofpley/E7XtpjJWpkeJni8u5uMUYnJqXiNXEsEkQA8ZrQvarfMFEZ4WyNmwtchwy3W
         pMqg==
X-Gm-Message-State: AOAM531MEnHFtGKd7xYxXTDraFtLu8C3X8nDcsDhz+ymyMn94XCRQ4QK
        1WJPasnSvDSoZq6sRjwXZd/g6uWXJQfmsytLStjCnA==
X-Google-Smtp-Source: ABdhPJy5uOpR6QqOApr8JTXnRyyqvChXNpcmelnBXNb6YY6fm53l19ExMBperiDNdyr16+uDrBTu9QvaUkCjxxjaNPc=
X-Received: by 2002:a5b:8c8:0:b0:641:e8de:a6f4 with SMTP id
 w8-20020a5b08c8000000b00641e8dea6f4mr6385815ybq.533.1650662851086; Fri, 22
 Apr 2022 14:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <1650285427-19752-1-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1650285427-19752-1-git-send-email-quic_srivasam@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Apr 2022 23:27:20 +0200
Message-ID: <CACRpkdYuojrAdz1G_ePeuaEX1Q4hQah=nQuOuW=v0Ty_FOk0Ag@mail.gmail.com>
Subject: Re: [PATCH v13 0/7] Add pin control support for lpass sc7280
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 2:37 PM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
>
> This patch series is to split lpass variant common pin control
> functions and SoC specific functions and to add lpass sc7280 pincontrol support.
> It also Adds dt-bindings for lpass sc7280 lpass lpi pincontrol.
>
> Changes Since V12:

Bjorn says he's happy so I applied this v13 version for v5.19.
Any remaining nits can certainly be fixed in-tree.

Thanks for you tireless work on making this work the right way!

Yours,
Linus Walleij
