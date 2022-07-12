Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478CB571BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiGLOLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiGLOLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:11:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B914C33E3B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:11:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b11so14505701eju.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBU84SRNLc6JB1Nu5oUhv+2JH/yb6vYKX7qMUKcEA/U=;
        b=HVDAKTb8QU6+A5APYQt524idn27AtAFUkPxSl1zqDjminGIQq8VZ28WSHeIeH1cYmp
         Zei6wL2/JJOlPrXH3YXdM3QmDxLvPhupy9vKx8veZjVLJp8/pHA6FccBbfFHGzMPlpWK
         5LoNik9uVHiE432REpBpgVr3ox45JYIthlEMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBU84SRNLc6JB1Nu5oUhv+2JH/yb6vYKX7qMUKcEA/U=;
        b=PhtcS+Ca0D+DZHCE+r0dnIag5kN9B17GyNoIGMQDYIJj3x/qaU7aMbDswIy9bb2TWM
         Z7md46eK6ltfmSLl1T9LByYbBWxIzxNBC/bjiyCPkZeM4dNzDUh8wrDmROtiG35P6ie5
         6HQyBsod3vOWAdexx4L1DLjj/ZBM7FnhVpDX7S4nAvxmucqqMQmeHIGiattzZ593YGht
         L39iBxYYI6aJK3etevRG46HckVls2XSZ3mUY+eRAQkmpnqXRG+wY+IkTeS6hL26WRaiO
         anwIBUHICpDKFtoU92foCDR6LqdC7tQTEaX/Y8KHpqZhEND5XKb9DVFKpa8UdzBMS3Sb
         1emw==
X-Gm-Message-State: AJIora/+V2y3AmS3HY0Q+d9rNzI6C9GLG9y3ALSbkwHk/tsP1pHWw1h4
        TkkMdTXmZyZjPvb51dkYo7qKAo88rzooQJF6MNE=
X-Google-Smtp-Source: AGRyM1tygBybpXygHRzL9/ozoBpdHX8pwpkmXTfbKyiRRCoXqk0YHyRSRvEbUTsY5XbD0sSSVn1PHg==
X-Received: by 2002:a17:907:160f:b0:726:a7a4:c626 with SMTP id hb15-20020a170907160f00b00726a7a4c626mr24323138ejc.449.1657635093134;
        Tue, 12 Jul 2022 07:11:33 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id g18-20020a170906539200b00722fc0779e3sm3833655ejo.85.2022.07.12.07.11.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 07:11:31 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id i128-20020a1c3b86000000b003a2ce31b4f8so6829949wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:11:31 -0700 (PDT)
X-Received: by 2002:a05:600c:285:b0:3a2:e5fd:84eb with SMTP id
 5-20020a05600c028500b003a2e5fd84ebmr4162603wmk.151.1657635090577; Tue, 12 Jul
 2022 07:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <1657629905-24685-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1657629905-24685-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Jul 2022 07:11:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XGivNzu_e5nrgOYkkqpWdXGgyG2MjB9xRbXm_V3JyPsw@mail.gmail.com>
Message-ID: <CAD=FV=XGivNzu_e5nrgOYkkqpWdXGgyG2MjB9xRbXm_V3JyPsw@mail.gmail.com>
Subject: Re: [V5] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 12, 2022 at 5:45 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> In the logic around call to clk_round_rate(), for some corner conditions,
> get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
> exact clock rate was not found lowest clock was being returned.
>
> Search for suitable clock rate in 2 steps
> a) exact match or within 2% tolerance
> b) within 5% tolerance
> This also takes care of corner conditions.
>
> Fixes: c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate")
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v5: corrected format specifiers for logs
> v4: replaced pr_dbg calls with dev_dbg
> v3: simplified algorithm further, fixed robot compile warnings
> v2: removed minor optimisations to make more readable
> v1: intial patch contained slightly complicated logic
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 89 +++++++++++++++++++++--------------
>  1 file changed, 54 insertions(+), 35 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
