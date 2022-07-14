Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FDF574A71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiGNKTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbiGNKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:19:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6D32127A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:19:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id e28so2037245lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yCWYh1ov1yBnCO3b57XJ5k3SmQZIpeuqoA5yH1t1vvM=;
        b=RRVFQ2o5FU5DQxiRgMR0YoN26/nkDsjNHwUHXB/YsUCEfU2h1ssYUiyvqP7JXe/mh0
         7zxjBEqAGKgoQiU5uKWvxNvWAhTHakJuvi6h8PWN/qVVJCDiobyUo9mgOKsd4NvrVVdA
         XUZqzbqzUo7M/TWpBTJHmi8x6q+Iap8ccTx+sZ5Q6D6Ft/zqp0h0rONcOv1kUVKdCGBr
         jcO8TZpZFx6x4961z13YKqYBXr+nZxQa4YUMt/c9m7j4FFJGBluMIUHR0UOfFfnCWDmW
         wNgKuDANCcVtYPONcqy5bs8EpJG7RWKJfgsqoOhJ7Xgwp4zroPBRGm5YJ9ISurOD2YCh
         HaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yCWYh1ov1yBnCO3b57XJ5k3SmQZIpeuqoA5yH1t1vvM=;
        b=uXxmZV2VyHBuSVcquRa0ZgPJ6OISTYIniH0IV63I0RFbef7PzAbULS62tjyKoiW+sy
         xT986sZFhnqENw4lroh1TQjeNPbZu6TGt5Mcawb2FqxCA3piOXViEAje+clST5RzSl0p
         YVKtd7F7ir1JzBzdwI2N4zT4Nle7csuJUB93oxIeiP9Hp7Rlf1c3Xl+qeto+BQOUTDeG
         EPc5rduuAwz2FL7CKvpSwUNBzEHmOtvbLizpbJnO700DZElXL/6oaq4atS7GhWmDjSZ6
         OnmvqwAhjnTGjXobG3T7VuVxDseSY9qXfali+v/4PZED8p2UxITLijFUQ4IQft8Tywt7
         g/dw==
X-Gm-Message-State: AJIora97R6gZsgWDWcSNZHq4hCgTJPqwhW1mvFafntuwUh2YRqZKNex9
        F8MJZhu3gyihomSHYZ0fD1qopg==
X-Google-Smtp-Source: AGRyM1uIY8mwk4DVrrhHyzydrC7wSPAvKj2YVPnaHr050XXhPo97i3D2sSmWKaProUzJykLj6SHgXA==
X-Received: by 2002:a05:6512:128e:b0:489:e63d:3042 with SMTP id u14-20020a056512128e00b00489e63d3042mr4641535lfs.302.1657793954081;
        Thu, 14 Jul 2022 03:19:14 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o17-20020ac25e31000000b004891b4a4acfsm281568lfg.185.2022.07.14.03.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 03:19:13 -0700 (PDT)
Message-ID: <192c5f16-8415-dfa1-39d2-8b404553ecd7@linaro.org>
Date:   Thu, 14 Jul 2022 13:19:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 00/11] drm/msm/dsi_phy: Replace parent names with
 clk_hw pointers
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20220629225331.357308-1-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220629225331.357308-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 01:53, Marijn Suijten wrote:
> parent_hw pointers are easier to manage and cheaper to use than
> repeatedly formatting the parent name and subsequently leaving the clk
> framework to perform lookups based on that name.
> 
> This series starts out by adding extra constructors for divider, mux and
> fixed-factor clocks that have parent_hw(s) pointer argument(s) instead
> of some DT index or name.  Followed by individual patches performing the
> conversion, one DSI PHY at a time.
> 
> dsi_phy_28nm_8960 includes an extra fixup to replace "eternal"
> devm_kzalloc allocations (for the lifetime of the device) with
> stack-local char arrays, like all the other DSI PHY drivers.
> 
> (Questions from v1 cover letter regarding the future of these drivers
>   is omitted for brevity.)
> 
> And with enough future improvements out of the way, let's round out this
> patch-series by stating that it has been successfully tested on:
> 
> - Sony Nile Discovery (Xperia XA2 Ultra): 14nm;
> - Sony Seine PDX201 (Xperia 10II): 14nm;
> - Sony Loire Suzu (Xperia X): 28nm.
> 
> And no diff is observed in debugfs's clk_summary.
> 
> Unfortunately all other devices in my collection with a 7/10nm DSI PHY
> have a DSC panel which we have yet to get working.
> 
> Changes since v2:
> - in fixed-factor:
>    - Reorder if - else if change to consume less diff;
>    - Go over 80-char column lint when adding new arguments to function
>      calls, instead of reflowing all arguments to adhere to this limit;
>      also consuming less diff.
> 
> v2: https://lore.kernel.org/linux-arm-msm/20220601220747.1145095-1-marijn.suijten@somainline.org/
> 
> Changes since v1:
> 
> - Moved indentation changes to separate patch (Dmitry);
> - dsi_phy_28nm_8960: move clock name allocation removal prior to
>    parent_hw refactor;
> - Remove vco_name stack-local char array in favour of reusing clk_name
>    (Dmitry);
> - Inserted additional patch to replace hardcoded char-array length
>    constant 32 with sizeof(clk_name).
> 
> v1: https://lore.kernel.org/linux-arm-msm/20220523213837.1016542-1-marijn.suijten@somainline.org/T/#u
> 
> Marijn Suijten (11):
>    clk: divider: Introduce devm_clk_hw_register_divider_parent_hw()
>    clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
>    clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()

Stephen, do we stand a chance of landing patches 1-3 into 5.20? We would 
like to merge the series into 5.21 through the msm-next. Landing clk 
patches in 5.20 would save us from using immutable branches, etc.

>    drm/msm/dsi/phy: Reindent and reflow multiline function calls
>    drm/msm/dsi_phy_28nm_8960: Use stack memory for temporary clock names
>    drm/msm/dsi/phy: Replace hardcoded char-array length with sizeof()
>    drm/msm/dsi_phy_28nm_8960: Replace parent names with clk_hw pointers
>    drm/msm/dsi_phy_28nm: Replace parent names with clk_hw pointers
>    drm/msm/dsi_phy_14nm: Replace parent names with clk_hw pointers
>    drm/msm/dsi_phy_10nm: Replace parent names with clk_hw pointers
>    drm/msm/dsi_phy_7nm: Replace parent names with clk_hw pointers
> 
>   drivers/clk/clk-fixed-factor.c                |  45 ++++-
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c    | 165 +++++++++---------
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c    |  55 +++---
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c    | 117 ++++++-------
>   .../gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c   |  90 +++++-----
>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     | 156 ++++++++---------
>   include/linux/clk-provider.h                  |  34 ++++
>   7 files changed, 351 insertions(+), 311 deletions(-)
> 


-- 
With best wishes
Dmitry
