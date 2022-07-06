Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4255681C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiGFIio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiGFIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:38:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE34C240B3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:38:40 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l14so17277586qtx.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZeWRbdm0aBOlWn7qVDcIEht0ORnbpskXapDRiYU5KI=;
        b=sF9zkTyHKlIwaf0tUZ8m6fmbf7MRLsWb3B83eSFiM1OC1xWlMY86LPQ4f0S3UBvcav
         Om4abZFgJPV52U7m0RP8umwDeO3QRpJ1Zl8rO8JCrbfKBBTCAq0ZXQf3jUpw+SW25TDl
         gcoF++uBthZ2802zF8MoOuP1172HYClBYLCajSFR53TILLK+wchCqtbn3tIFvSXykKDJ
         lQdoq4Xq7ClIifV8c6B4bcPkzGvBDMKkr26QMB6QUefow75yqzVLrrZahIV5D591okEI
         BoIIdzzSr2W8wIhwy7LapRRojihCCoukM79C7ihGQwHdh+MBLe9sPQQLkVvNSVAwfN4J
         OXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZeWRbdm0aBOlWn7qVDcIEht0ORnbpskXapDRiYU5KI=;
        b=KHrMj9Dlc7XhgXxlPmj9FkQLgwSzsICDq+fUuLVo3fWnCUJlZZ53bjidq80fUpbUkL
         W/lYAOYSIjP/SpK/omwq+ZARdstF4uQBfXrCS6pfuYVPygyfOusrYHzeEL/Cab9R9Guw
         1j1zqyJzhwUxKdJuTDbnLlcFSZkWXKUDpPhBZ5pYX2Y7et42GbayZBCsJrXSFCBRzU0q
         AgyQA5rgVJsu+rzkr4fl8ZFgsnbZ12bXGMRjVsNzZ20VFHdRi11ARgyTwjF2kQzgY9py
         +uLfRKnQS0hH0J+bLqo7enWAgWgE78+c2G0xylPjhUvQrUIENGZAXjcw6AjXjH/T0YTy
         gSCA==
X-Gm-Message-State: AJIora9OBgnRfCeF/PbXAm6pawCk+ZULCdtdjgG1JPV2tTS8c+WCL29B
        AUcTh1/mwq++2rurXQqa0amjUmLXctS3p9OPIqndOfgezbk=
X-Google-Smtp-Source: AGRyM1vKYydaCock1NFLZ/7/PKkuQyy6x2aKKCvVpvDXdjr6st9YjndlqGt79e2nEpR2XHqbEhAA8YUPKoArXq2RLxM=
X-Received: by 2002:ac8:5956:0:b0:31d:28dc:17c with SMTP id
 22-20020ac85956000000b0031d28dc017cmr29824698qtz.295.1657096719864; Wed, 06
 Jul 2022 01:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220705191327.1684277-1-robimarko@gmail.com>
In-Reply-To: <20220705191327.1684277-1-robimarko@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Jul 2022 11:38:29 +0300
Message-ID: <CAA8EJprNqeXPPMPZYDEcutjVraHCe=boFO0HTs_26ti_txQ8TA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock
 controller support
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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

On Tue, 5 Jul 2022 at 22:13, Robert Marko <robimarko@gmail.com> wrote:
>
> IPQ8074 has the APSS clock controller utilizing the same register space as
> the APCS, so provide access to the APSS utilizing a child device like
> IPQ6018 does as well, but just by utilizing the IPQ8074 specific APSS
> clock driver.
>
> Also, APCS register space in IPQ8074 is 0x6000 so max_register needs to be
> updated to 0x5ffc.

As you can see, this was changed to support SDX55. Please either make
this configurable, or leave it as it is.

>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v5:
> * Use lower case hex for max_register
> * Update the APSS clock name to match the new one without commas
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>

-- 
With best wishes
Dmitry
