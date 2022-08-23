Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB159EA03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiHWRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiHWRmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:42:35 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBEA9C8EE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:37:17 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id m21-20020a9d6ad5000000b00638df677850so10032678otq.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=v31+jjDAe8b8bSeB3m7vjA69108ZFOl1IwaE1C9+p6g=;
        b=ehS+dPduFec0TYms+eKA7qJx5obDw3y+LyCRyq+Ru6CDFRO9kkTL+5xanQd7oqRdiG
         rfEPeHr4mHdBWzi7mplNImhxtTIhIoMKT4DZLWbu04u5YQ+HwsNb3VwbdbeceUIyK4SP
         HwIxxp0MbVCJSlzH3nF5cNt8u5+NZ7V5aNiaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=v31+jjDAe8b8bSeB3m7vjA69108ZFOl1IwaE1C9+p6g=;
        b=JP4C4h/7FN3WrEFzsXcVHJUp3HvZQ6iY8mRgkq79HQblwV6V8qc02gtjYSuh7nuHTi
         6f7m6tFRfVSgpcJ4oJbcmTRa27C82Dy8Vq/IwK2s+2HQupWrcaCU0MXtohFDKktQaRjY
         cvWye+QcHJxD4qMRdCOgbmgDY0vKN+DewxUj0Dwcq3nHhdeZ+E2Sgr5fJkMQ2Jp9v5Mw
         qF09J7DuKJX2jI32FlEY5r/qERU9FOJeIYUSSTL8XSri6cEqpzIBftMnKkHsAdNvd1dH
         QTsMwAHGZbYspUM/Ok3HNJzDLa0sKqm8WJpPnZiFlcvQRTKPUfD/uYgGg3cSaZd4LJxz
         LUIA==
X-Gm-Message-State: ACgBeo0nbQAqd8hR1mfApDUUoQMrwXO1djzQ2mE1/LHW8nAnLmWLpFWM
        FQyY/aGrQ5Buy3DAXND/ft+zeLdkJdJxlUkE5eXWqw==
X-Google-Smtp-Source: AA6agR7oXCZFuTC7Lzxlb4CwuONinxB3CRhuL08aLXINitOJmy/axmk0nwSsMf7iBwFXey4c13CPaDhDmRFCPlSAl6I=
X-Received: by 2002:a9d:738c:0:b0:638:9962:8cb6 with SMTP id
 j12-20020a9d738c000000b0063899628cb6mr9407094otk.73.1661269036462; Tue, 23
 Aug 2022 08:37:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Aug 2022 10:37:15 -0500
MIME-Version: 1.0
In-Reply-To: <1661245527-5596-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1661245527-5596-1-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 23 Aug 2022 10:37:15 -0500
Message-ID: <CAE-0n50g9UUH9Jyy1_CGKLbXd096waP_Y4kPJiFmfqBaKMhG5w@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: lpass: Fix the invalid index errors seen at bootup
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-08-23 02:05:27)
> After support for resets is added, qcom_cc_really_probe()
> would be called twice for the same cc which causes
> invalid index errors in qcom_clk_hw_get().
>
> qcom_cc_clk_hw_get: invalid index 5
> qcom_cc_clk_hw_get: invalid index 6
> qcom_cc_clk_hw_get: invalid index 7
>
> Fixes: a9dd26639d05 ("clk: qcom: lpass: Add support for LPASS clock controller for SC7280")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> This patch depends on [1]
> [1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=667984

Why not resend the series and squash this patch into it?
