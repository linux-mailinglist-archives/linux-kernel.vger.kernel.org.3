Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE475A6A61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiH3R2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiH3R1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:27:43 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60D372695
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:25:03 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y17so985646ilb.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SmSdpqqfvhuzBeG/p+7mNhDOexI5aI2aAxoNsJihLIw=;
        b=MwDNBXN8YnULPfgN5yg8hA/ERoe4PKJ3NdV4H3LBuK3diQMkKr9cIVUpBkhp0GFul7
         xFM3eJ+klfy1CjKvDD1Do+ILnhEFPDprBhHlJ3Xr7sCEauXpNsnplfq6tPGAs3ejXHNH
         8lfx2cndEqpo6Na7ga1peK96Bzlgck8g6Ahbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SmSdpqqfvhuzBeG/p+7mNhDOexI5aI2aAxoNsJihLIw=;
        b=XualzDoardxWbhhRkoBgJjB70B+2tATzfu7eyvi7HB7g6e6cKca73f5btptFBTVFd4
         RNab5/0iUm51XrN/JCdgkuSo1ippY5s0iBS1D9dwZA4V1USozTapv9wt3Ycg0HmQleTI
         08Q62Rmt21BgatZ9O3lYmn3hz2xZHRWvahchFfglZRjbKDWbXLctYTM59kLBde1LopU9
         dkLkfbx5Dggd92992yUXX5o+G+/GHokc3r5flNZ/4m3edG/2QOast5hsTgDZmWQaQecq
         cNbhsyEUoLS/g9y5U+05ty/7nLeX3c+dAx5y/XyXRkXpQKrnIqUgN+jp7J3zDM0WPfpW
         WW7A==
X-Gm-Message-State: ACgBeo1MJlYhzygDgcY3PZIshmUcxwWezQIIbgcaq3h0RK0QNwSeVWSu
        oJyMjazCClDYQSRd0IhWuMM7RF4jYs6gOC7U
X-Google-Smtp-Source: AA6agR7yQq40MWmvDDqMdsRkq3Zb+PaDLbh+zAABeP/N+WCIr4VrKNq1fl6qtMSjFfXlhiZyGTH0xg==
X-Received: by 2002:a92:ca08:0:b0:2eb:626b:dc2a with SMTP id j8-20020a92ca08000000b002eb626bdc2amr1613510ils.127.1661880237005;
        Tue, 30 Aug 2022 10:23:57 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id i25-20020a056e021d1900b002eb2b6323ebsm1984204ila.16.2022.08.30.10.23.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:23:56 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id 10so9825950iou.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:23:56 -0700 (PDT)
X-Received: by 2002:a05:6638:14d0:b0:349:d176:d376 with SMTP id
 l16-20020a05663814d000b00349d176d376mr12105487jak.58.1661880236045; Tue, 30
 Aug 2022 10:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220830053307.3997495-1-sheng-liang.pan@quanta.corp-partner.google.com>
In-Reply-To: <20220830053307.3997495-1-sheng-liang.pan@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Aug 2022 10:23:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXV4x-Hpa9-GUzkwS+cxfvpL93HBCUrn_bvMK8hBAaBA@mail.gmail.com>
Message-ID: <CAD=FV=XXV4x-Hpa9-GUzkwS+cxfvpL93HBCUrn_bvMK8hBAaBA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Add a new board device tree named 'evoker' for
 herobrine variant.
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
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

Hi,

On Mon, Aug 29, 2022 at 10:33 PM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> This patch add the initial dts file for new board 'evoker'.
>
>
>
> Sheng-Liang Pan (1):
>   arm64: dts: qcom: sc7280: Add device tree for herobrine evoker
>
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sc7280-herobrine-evoker-r0.dts   | 333 ++++++++++++++++++
>  2 files changed, 334 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts

Just as a heads up, usually you don't need a cover letter if you're
just sending one patch.

-Doug
