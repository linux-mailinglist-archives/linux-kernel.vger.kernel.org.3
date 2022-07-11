Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A62570887
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiGKQrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiGKQrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:47:53 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8907C3CBFB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:47:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w12so6264226edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgkIi7fMPRr2AoUFqLpQX7xH/fNuy4VUkp8cy7sE2D4=;
        b=V3/+Rch1ns/j5gS9Z+XimMOBxyslbkPIkGNRpBpOz0bsiaJNcIunGHgZ3wYeuNJ5KB
         iiojbeFMZBZKTs54MZfAuQo8noiaVjkbPCw+VGJd7zq3ffX2k/PYiJbk2Lf2ec74x8vX
         oOjelTn9RDQbi834Br05L23PNacDs9h+toRZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgkIi7fMPRr2AoUFqLpQX7xH/fNuy4VUkp8cy7sE2D4=;
        b=0V9VOYYTdS7sTH02l22TGXcUQpygsg3rDETk6NmO1K6Bp8BJnahaJ9+zvJZGEeotrL
         dLBrr5vW1lwLM15m8ioFob5c7UXYJxgbZPPLiXEfxMobCQj0Nc7OYhJzlwYUvWzAFoL/
         DXzX2az/3X2W6CNm1S4FrIFzoXKcEpkQmjPpP/9gD7BKeJpYm66fN1dSbdCZUryFKgNf
         mHW8y3zcEVcl7IIJEI6BHqjI4RN6mnNkG3+o2Np6ovZnNhRCqajovep9XMJWCFR4ahi0
         SnmhZ6w7RLiak4NHemsEW3IUPpWlAwBYdnScl5FPYR469wIihLwIOjfvGLre7PW9UgOU
         VPHg==
X-Gm-Message-State: AJIora+YWAfDLYlXzenK/5wmYKGpy82mX+NsPO7OIvAjRh2SBFCj67BH
        ykPTqPa6Ah2T4jZVAI4wwWGxkCPBDa72Utc0h9g=
X-Google-Smtp-Source: AGRyM1ukZCLhKqzamQ6Nz+1zLiWaOHf5PJptcIGkUICDhGzN0k/iz5a5dNW/OomS7rKKi+U9ppPOqg==
X-Received: by 2002:a05:6402:50d4:b0:43a:d2a9:29ad with SMTP id h20-20020a05640250d400b0043ad2a929admr9491698edb.336.1657558070237;
        Mon, 11 Jul 2022 09:47:50 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0072b51fb36f7sm1451807eja.196.2022.07.11.09.47.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:47:50 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id p4so3383315wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:47:49 -0700 (PDT)
X-Received: by 2002:a05:600c:3d95:b0:3a2:e97b:f3ae with SMTP id
 bi21-20020a05600c3d9500b003a2e97bf3aemr3975351wmb.188.1657558069021; Mon, 11
 Jul 2022 09:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <1657556603-15024-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1657556603-15024-1-git-send-email-quic_khsieh@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 09:47:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X0Fh_p4TnA3c=SadVKCDVFaWnT9Cj1zydQWqZdYL8eSQ@mail.gmail.com>
Message-ID: <CAD=FV=X0Fh_p4TnA3c=SadVKCDVFaWnT9Cj1zydQWqZdYL8eSQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dta: qcom: sc7280: delete vdda-1p2 and vdda-0p9
 from both dp and edp
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 9:23 AM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Both vdda-1p2-supply and vdda-0p9-supply regulators are controlled
> by dp combo phy. Therefore remove them from dp controller.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 2 --
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi     | 3 ---
>  2 files changed, 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
