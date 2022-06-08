Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4111543797
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbiFHPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244439AbiFHPjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:39:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7ED1B7830
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:39:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h19so27673580edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pwvu2vstIFuDbmoLlIWPg/mZg51nUvruTLPNLTKmJS4=;
        b=UE8t6cShY61wMWjfBUo2llFLOvRxnFzadwxYtpIfrsJBoaeB9l44NeHhs3KGGNHo/V
         NWF7NiBYCPVw2/PpbZ8LkvHOEUfJZPmQTy1hgG1LbGzz5brEVJcZHXK1B26P3BFbeGn8
         OUNdwu0Np6qZ68dvFX1cQQT8CmhFPQLtBFJqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pwvu2vstIFuDbmoLlIWPg/mZg51nUvruTLPNLTKmJS4=;
        b=Kukpw9UK4QlbgaXg/KI12vXuXE5gs2GgYw5Plj5knTSlMibaL52Fihf24AMq1dILSa
         7xvkJFZ8UNDfYsoNlaCdn+FzoMmSiEsWWSfhpQHRk3qIrbEkpv1ytTwN8Fh1iMrRMccv
         IFYUH9xWabVh7OXNYjzebnpeypRsNKnIOPQAf83mW39J3/hS4Kl83oUWXz1sX7dLesQA
         yntf+4S7vLPVtHT09rBL0KF2ud6CGdd0TqziZ5swa6TBx/XgGsVwxPj8iI5uMB5gpuFg
         spVmO38NDvadNCeJ93+RH/h+UccsWR5zDKUSrGgCQBoscw/Nw01KOxir6kAQY7oIFLKf
         KFfQ==
X-Gm-Message-State: AOAM532hF19Fy7qr1DWF9PrdecsunKE3WHzuJQaEB9b3Xet/yZ9w4HY6
        8iy71SMWfY5FVPnEAwbLncHkQUgN3cz5+hSCiOE=
X-Google-Smtp-Source: ABdhPJwEMzu0umDMRH9a36ozDhPP+kCpCeyN9BbxpsZ42kXSlpPbkp8Bku8Kqc+z3Xu7aBG7BAyk5g==
X-Received: by 2002:a05:6402:f05:b0:42d:d709:b497 with SMTP id i5-20020a0564020f0500b0042dd709b497mr39708009eda.231.1654702749862;
        Wed, 08 Jun 2022 08:39:09 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id cz20-20020a0564021cb400b0042dd85bd23bsm12542331edb.55.2022.06.08.08.39.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 08:39:08 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id m26so17455811wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:39:08 -0700 (PDT)
X-Received: by 2002:a5d:6483:0:b0:20f:d046:6382 with SMTP id
 o3-20020a5d6483000000b0020fd0466382mr33588969wri.342.1654702748098; Wed, 08
 Jun 2022 08:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <1654627965-1461-1-git-send-email-quic_vnivarth@quicinc.com> <1654627965-1461-2-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1654627965-1461-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jun 2022 08:38:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UD-ruxBK3TarJCSP8zkCQ37kCO5=cbYBJzou5GSqN63Q@mail.gmail.com>
Message-ID: <CAD=FV=UD-ruxBK3TarJCSP8zkCQ37kCO5=cbYBJzou5GSqN63Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: core: Introduce callback for start_rx and do
 stop_rx in suspend only if this callback implementation is present.
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        quic_msavaliy@quicinc.com, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 7, 2022 at 11:53 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> In suspend sequence there is a need to perform stop_rx during suspend
> sequence to prevent any asynchronous data over rx line. However this
> can cause problem to drivers which dont do re-start_rx during set_termios.
>
> Add new callback start_rx and perform stop_rx only when implementation of
> start_rx is present. Also add call to start_rx in resume sequence so that
> drivers who come across this problem can make use of this framework.
>
> Fixes: c9d2325cdb92 ("serial: core: Do stop_rx in suspend path for console if console_suspend is disabled")
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/tty/serial/serial_core.c | 9 ++++++---
>  include/linux/serial_core.h      | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
