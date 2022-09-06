Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307CE5AF773
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiIFVyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiIFVyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:54:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFC02496A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:54:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z8so16958305edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AOS1RPD3u8TwBcbN7lQkUbqEyQ5lUlBIgtzl/5BvCt8=;
        b=ENgVronGcCwSedNCwVslHZ8WLV0fwSNVko2wg/BW5swdnQna7TzxSRjoo7j0ZLuA/K
         nJvV/gEJUHakeQVDqgQM5QGftcslhxhx5LF8q0jc6kVMCBBjj1sFV4ATUgaePi9TImlB
         jgMA+liOyGEuXf5EHPq+x7dKhULnvo9mGQwK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AOS1RPD3u8TwBcbN7lQkUbqEyQ5lUlBIgtzl/5BvCt8=;
        b=Jh7ERpcxG1iUSDDiXP2kPdneTYCer2+dKZM4TZpzZ00XMd+di34I9XyBBEYDpGZ+5+
         JEiQYTTjkAZPvdTLTLyaYvu0WzAnehje1FAcnPWUQGiMjmMVlXFyzN6Xl+IaCVHTuZu3
         UNqx1lnMSFmiJspfMZ6xiRRQyYFANajo7lJFxgt5RHw3t85LV7LcHqWpSDC8Jd+jscx6
         MOQkZ6zz5I2Y/9fCGxBBP+k22seW3pk37HQDKVo50RJeRVfmOb4+Iu7dgsJKvy4fVmfI
         nih+MFr+rnYicIQZ2lqej5PwmN3mwRlWf1V/k90JC66UhbQDdNR1J+pIAMXv3G7GGMW3
         lSJQ==
X-Gm-Message-State: ACgBeo2vA9xtnIoTrs77V2XZX//cgHjDW2gF4EXmF/MzCHF2+GHtCTPt
        82+lqulCObRN+vE0bLx4h3HQe7tWmUdB4Sx2
X-Google-Smtp-Source: AA6agR7O8W/EpBzEkth6R0w7EQ2Vp1WISzb6mo514TUMWsEJtaF0nb337totrh7FXacTOnIUCSCPZg==
X-Received: by 2002:a05:6402:b85:b0:44e:dad7:3e24 with SMTP id cf5-20020a0564020b8500b0044edad73e24mr570429edb.264.1662501280319;
        Tue, 06 Sep 2022 14:54:40 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id r14-20020aa7c14e000000b0044e7adbe0c5sm5104986edp.87.2022.09.06.14.54.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 14:54:38 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id bp20so16945939wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 14:54:37 -0700 (PDT)
X-Received: by 2002:a5d:4d0c:0:b0:228:cd9f:5a4c with SMTP id
 z12-20020a5d4d0c000000b00228cd9f5a4cmr278070wrt.138.1662501277455; Tue, 06
 Sep 2022 14:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220906201959.69920-1-ahalaney@redhat.com>
In-Reply-To: <20220906201959.69920-1-ahalaney@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Sep 2022 14:54:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1VS=JyG=B2bp6w5XutUxcpzi6Bo7PADJ1GyzQkhM=Ug@mail.gmail.com>
Message-ID: <CAD=FV=V1VS=JyG=B2bp6w5XutUxcpzi6Bo7PADJ1GyzQkhM=Ug@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 6, 2022 at 1:20 PM Andrew Halaney <ahalaney@redhat.com> wrote:
>
> For RPMH regulators it doesn't make sense to indicate
> regulator-allow-set-load without saying what modes you can switch to,
> so be sure to indicate a dependency on regulator-allowed-modes.
>
> With this in place devicetree validation can catch issues like this:
>
>     /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
>             From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>
> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>
> v1: https://lore.kernel.org/linux-arm-msm/20220902185148.635292-1-ahalaney@redhat.com/
> Changes since v1:
>   - Dropped first two patches in the series as they were user error
>     (thanks Krzysztof for highlighting this!)
>   - No change in the remaining patch
>
> Krzysztof also asked if this patch in particular should apply to other
> regulators, which I think it should for those regulator's who implement
> set_mode(). Unfortunately I don't know of a good way to get that
> information in order to apply it at a broader scope for devicetree
> regulator validation. At least with this in place RPMH users can get
> better coverage... if someone has suggestions for how to broaden the
> scope I'm all ears!
>
> Thanks,
> Andrew
>
>  .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
