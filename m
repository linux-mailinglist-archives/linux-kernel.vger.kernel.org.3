Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFB4DD1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiCRAOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiCRAOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:14:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8535015DAB1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:13:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bi12so14041299ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivABL/zW17W3xsGsFU4NNFD2vIhj9kJM89ziwsXeP4A=;
        b=I6jh5qUUAfPbuFRo6X1vzR4jyxk+Jwj+tM+hcWGcNJ80NKQdHD3dt4WyBUnPLaQ43u
         fY4hRGaRDpfdxsttq4ka6QQ3hsN/FLOiF/BWyTy1eAv5/n1k20hVkDNHY/wy2ucHyIUT
         LyPuzoXHOq8/3MYayGZMQIPpAv4JbHhGQwbek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivABL/zW17W3xsGsFU4NNFD2vIhj9kJM89ziwsXeP4A=;
        b=q2wU45/Ac3ugLA9LXqRFYxUmNytfc3LJ0e1CJofx99DPP2oNIo6pGPQR4H3S2tRYY3
         XdVofIMjABhJlaI7BeduRVQt6ZxBxUxLzhsVqqJDEnx0ZYK9YIBTkM6aT10tgdcI1vtC
         ywNuWUmSkWzbTQV4jbNOS5IoRNHGxhFguRbANyCLj79cD6fdcwPCISmPhepzxLyKRKu0
         VCTjE5z+D1u7GY8xLLY2w3lTEUDO6Tkq9gPNj3x+s7JUQSylPBnTrzlPtGhl2KB24c6C
         v6o4JFC/keNkTsxqLZ6aySx2RAHeKhe/nKd7o814QkTCLEPjhwJr3GUh7L14pRR9Ib+8
         qfog==
X-Gm-Message-State: AOAM532ic0Z3S8WF9EAaOU9GT2dlW67/gl6BLlGSxDi+ltydla5hoIeV
        mjG1df0/ZmMo+dZoD+oT9Wnx4avw2ARzfWRFkE8=
X-Google-Smtp-Source: ABdhPJwG+yjHqLyJsGfK7QMzKzS/+7jaRtHGm7nzHxKbowGtGqabjwOKPrbUpWV9qfj8dqwkoSTZnQ==
X-Received: by 2002:a17:907:9495:b0:6da:9602:3ec6 with SMTP id dm21-20020a170907949500b006da96023ec6mr6697981ejc.589.1647562380791;
        Thu, 17 Mar 2022 17:13:00 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm2984109ejz.57.2022.03.17.17.12.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 17:13:00 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id n35so2423245wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:12:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3c8a:b0:389:cf43:eaf6 with SMTP id
 bg10-20020a05600c3c8a00b00389cf43eaf6mr5932331wmb.199.1647562379575; Thu, 17
 Mar 2022 17:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <1647269217-14064-1-git-send-email-quic_vpolimer@quicinc.com> <1647269217-14064-5-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1647269217-14064-5-git-send-email-quic_vpolimer@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Mar 2022 17:12:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VQV-2LTmVEPuJJYUhTpBT15A1fKAsRbZgpni8rGNNFsw@mail.gmail.com>
Message-ID: <CAD=FV=VQV-2LTmVEPuJJYUhTpBT15A1fKAsRbZgpni8rGNNFsw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] arm64: dts: qcom: sdm845: remove
 assigned-clock-rate property for mdp clk
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_kalyant <quic_kalyant@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 14, 2022 at 7:47 AM Vinod Polimera
<quic_vpolimer@quicinc.com> wrote:
>
> Drop the assigned clock rate property and vote on the mdp clock as per
> calculated value during the usecase.
>
> This patch is dependent on below patch
> https://patchwork.kernel.org/patch/12774067/
>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Similar comments to patch #2 about the commit message, but otherwise:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
