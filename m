Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088E04E5A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiCWVIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiCWVIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:08:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1152571EC9;
        Wed, 23 Mar 2022 14:07:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z92so3324735ede.13;
        Wed, 23 Mar 2022 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=LMob1D1i/R5KcK87hci+jzzEC4MjJYbt0t47d5hUovY=;
        b=cQ5Rn8RP7D8ngoNZu2dFD/oZPt4P7BynwfQeptMD2aRY5pL1OoGxdVWqza1pXJtVQ4
         rY/X/C14pA/drwoh1QDrx/CT8b/5cafJ7Xepvj/zxd1mph2n4LW2eBLaleDfcT07+cy+
         WjBcHZSvjd6rCnIzelsXdJd6BG87LFEJ9/bv9rPsDZ3uwcXV0wbwKGpoyXFtVgAMRhzs
         MNcXty9r8FntZHvteS696YBi0bbDGiKW95SQBxAixwojNbsdGksOjMkgIGeWcdxnJ73m
         Trv9IZxSWgFTbTCb1jtj1BV+HHyKtR8DfyFAmdT7y6NfL+aAi524rl347gpDwVptb+7F
         Yzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=LMob1D1i/R5KcK87hci+jzzEC4MjJYbt0t47d5hUovY=;
        b=b3act5+uIXOyocE5IQsdqsoiv6WCEt3ualTUoMeU+m1/s08HPfo0BPcs0Nbt87pbJs
         GB00avaaw03Mv6rMi6p5HPC4B1hRdUuWBieA+ynJbb/KikfSmnGjpWvOCCROpOnV1/mR
         9+5C7Uq8ReGYSxYGfn/Teow3hUett9yurO4cFicJTf7+RV+CWgXRvREOadTXShCX8LVs
         1zVpsC0kHEx9RqA/0fsjo1cX1oFJeCyxHy1fedwANJmwc1R67Hvd9DGMgu+kCoE0s275
         kcjYKqwo/+7t+QR+nBSPgwy3lPtMStpRWeJBkdVK2P8UWNeCpZDsLccVC8rVnQs4zPxs
         2+mw==
X-Gm-Message-State: AOAM533dTwcisRp7ua4oQHNTr3HZC8pAbIjCvS/w3yqC6y4wpqwp3Za3
        Z0C+b8gguMNox4PTkt70wRTCsXNBNMxyvA==
X-Google-Smtp-Source: ABdhPJwwpGcC22tUk/vFU08UDFRGXnFfeqL0QOtqdwUlIomdkvOYkwsmmgqV3qAkjGeSZLeGH7bKOA==
X-Received: by 2002:a05:6402:1e92:b0:419:76:21a6 with SMTP id f18-20020a0564021e9200b00419007621a6mr2644728edf.128.1648069620537;
        Wed, 23 Mar 2022 14:07:00 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id b15-20020a50cccf000000b0040f74c6abedsm442301edj.77.2022.03.23.14.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 14:07:00 -0700 (PDT)
Date:   Wed, 23 Mar 2022 22:06:57 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] arm64: dts: qcom: msm8994: Fix sleep clock name
Message-ID: <YjuL8UKROE5pnUj1@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20220319174645.340379-1-konrad.dybcio@somainline.org>
 <20220319174645.340379-2-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319174645.340379-2-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad, all,

> The sleep clock name expected by GCC is actually "sleep" and not
> "sleep_clk". Fix the clock-names value for it to make sure it is
> provided.

> Fixes: 9204da57cd65 ("arm64: dts: qcom: msm8994: Provide missing "xo_board" and "sleep_clk" to GCC")
Thanks for fixing it, now I see it in
Documentation/devicetree/bindings/clock/qcom,gcc-msm8994.yaml

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

I also tested it with "clk: qcom: gcc-msm8994: Fix gpll4 width" [1]
and "[PATCH v5 1/1] arm64: dts: qcom: msm8994-huawei-angler: Add sdhc1 definition" [2]
and it works as expected.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr

[1] https://lore.kernel.org/linux-arm-msm/20220319174940.341137-1-konrad.dybcio@somainline.org/
[2] https://lore.kernel.org/linux-arm-msm/20220323204840.22832-1-petr.vorel@gmail.com/
