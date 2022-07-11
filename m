Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77F4570803
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiGKQJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGKQJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:09:33 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B25FAFD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:09:32 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y2so5328307ior.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQxLMmAEvX+K2A/q42hfIktD7BaiK+JMPvH65uBEZaA=;
        b=QY1RwoI+28PRf0qShn2T0MkMXofeHvPnOhJ8/2X1gNCd5AQ/yjecfyvqYaW+88dHTt
         BPrvH/k4b+A2tN/qWs77K8wtyqYxXtfbgYcdbfIC+oho3Nkrk9GXm+s0rERVMtGjjEJL
         TC83NdQkXbdvmUcIl5GW1ko060ufJM6cedpS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQxLMmAEvX+K2A/q42hfIktD7BaiK+JMPvH65uBEZaA=;
        b=p8RKfqfNeL3SNhNmpDR32dCcLSHauOccKWxV/S0U/3rTXF0x6xvroPY2yuzkg1j2Ta
         KriYI/qudluqEeEsHrfxbHEWdhN7C9D3PF4w4CPbaUtDlXpVhwFmHDqi5uB7wXbqTm8f
         Xu2/tHagbJQ1B3UPftl3rVrpH9LXd2Tx0m24PdZXcg590nJUSSJJrQkDpJ/sqDSMKsEt
         /0nOydHw8eWFd3pkuGLyv3mlozt66h3Ds3ijBQqKQ248YatgKpT4BwBptuiapBXXjT5A
         rLOtE+C+hJ1My8mv/M/4VumbKcsoA7WVH7fXEA+E4luW/UD9uWj+0TIug7SF0bFlnU/m
         DIpg==
X-Gm-Message-State: AJIora/wbyL/Bl9R68IqEOsrbvWIZ1OjoozCK2tIk+2eBcZ03gGaiKIZ
        bJ5fgeTQDQ390Yq/AiIDToZdXkQTmSWJG74jX4I=
X-Google-Smtp-Source: AGRyM1s9qX4VPd/ipi/xOsgJDYvAk8xarX3ljbe6XSUYa80Z0MmbFwg0ZakU2PMGvE3OL7DE0/1UmQ==
X-Received: by 2002:a02:c9c4:0:b0:33f:4f44:11bd with SMTP id c4-20020a02c9c4000000b0033f4f4411bdmr4369838jap.240.1657555771946;
        Mon, 11 Jul 2022 09:09:31 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id a18-20020a027a12000000b0033f4e58cfadsm1982484jac.133.2022.07.11.09.09.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:09:31 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id m20so2914513ili.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:09:31 -0700 (PDT)
X-Received: by 2002:a05:6602:3988:b0:67b:9a59:d390 with SMTP id
 bw8-20020a056602398800b0067b9a59d390mr1412375iob.56.1657555349351; Mon, 11
 Jul 2022 09:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <1657555122-18605-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1657555122-18605-1-git-send-email-quic_khsieh@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 09:02:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WC0XQqOyONddX37=ad8M4N2NHB5UTmDVZU5SEggLvFEA@mail.gmail.com>
Message-ID: <CAD=FV=WC0XQqOyONddX37=ad8M4N2NHB5UTmDVZU5SEggLvFEA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dta: qcom: sc7280: delete vdda-1p2 and vdda-0p9
 from mdss_edp
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        quic_mkrishn@quicinc.com, quic_kalyant@quicinc.coml,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 8:58 AM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Both vdda-1p2-supply and vdda-0p9-supply regulators are controlled
> by dp combo phy. Therefore remove them from dp controller.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 3 ---
>  1 file changed, 3 deletions(-)

You also need to remove it from
`arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi`.

-Doug
