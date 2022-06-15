Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83C54C619
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346106AbiFOK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347582AbiFOK20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:28:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CEE13F49
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:28:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id fu17so7815005qtb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRRIXOfBq1yQuH5EfBFqRJA+XF3LzpkQlfmJRxNlHxM=;
        b=eTPtLP4NDpa8P0aI9dKapfMCGv9h90H8cChydbnDbXwDM3c9dFce+zWip7UvMIpzAj
         MwWt4NSMWMqrTbGPwJOf7l27KNudx15eMZzj6SyR4Zlj5OpOoagmM2K/3bI+5LT3Niyi
         h1vN0EW/aD3emP+jNz1Zcr7cozm+JkmhQecbNLlW+mU39R/LAtqcL2ahfL9sPHZJmXtA
         n+McjAPLlSceH+/folG8esKMX+j5OcZkgls4MZ7OITX1SzUtIIuFxa5K+LPw/fz8Cv5V
         vwmBMQsLsRdxHoNvxi45kD3Ty/9jaUWcXcCG6j3dwqXXCZ+czmFsSDp+cv482KfCuh2i
         qjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRRIXOfBq1yQuH5EfBFqRJA+XF3LzpkQlfmJRxNlHxM=;
        b=VaBRIEenyXpZkd2yJIy8SNrUdbZaKgZPosNwD2ErhlCjEb/cfPHwUu24nZVUv6QWwW
         zgpYXTw3MojeqvKE5i4gWhk9w4m+HBt+ON3w7MKgobso5/Suv1jjHN6CAsCpGA5G+5St
         bE4gTvih3cGy3/VH6Mk5XIiU37/z0uVhebiN+qhPgV0zDmub4sfio7sHxGU8gqiI8D3W
         nOGt5Hay9efq49f3z+in2PAVPrghl5s0/s8GJW4tLs6dWMPFulbltFWfnD4vU9PdWFAi
         CdIeB3RIawxmy2iRGLY1hKNPE8Ar//yYIWbdSpeKl47zu+UU0PU+4SCTWOcAemumyE1B
         pRMw==
X-Gm-Message-State: AOAM533qIWFl5T/oQ8Ouq+ug0xVoKSyrqxrLk+YoQnb3f+dtocMtlri4
        2oZbVCB5r9NoGSptTSFS3vbq/hai1SfCQ2N2oP47LQ==
X-Google-Smtp-Source: ABdhPJzgorGZ/k2s8/OSl6pg37NaKBcKW1yennvKVAegxKpGmun7X2J8lIgtj5Inxl+I5AXypY0S3fE/EQB34TCAN80=
X-Received: by 2002:a05:622a:1351:b0:305:2e58:939 with SMTP id
 w17-20020a05622a135100b003052e580939mr7765424qtk.295.1655288902992; Wed, 15
 Jun 2022 03:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220614230136.3726047-1-emma@anholt.net> <20220614230136.3726047-2-emma@anholt.net>
In-Reply-To: <20220614230136.3726047-2-emma@anholt.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Jun 2022 13:28:12 +0300
Message-ID: <CAA8EJpo=vLmsBRo16_xfbSdfFGvR1ocyuXm=2mqRR-9wyUESvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: Enable per-process page tables.
To:     Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 at 02:01, Emma Anholt <emma@anholt.net> wrote:
>
> This is an SMMU for the adreno gpu, and adding this compatible lets
> the driver use per-fd page tables, which are required for security
> between GPU clients.
>
> Signed-off-by: Emma Anholt <emma@anholt.net>
> ---
>
> Tested with a full deqp-vk run on RB5, which did involve some iommu faults.
>
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index a92230bec1dd..483c0e0f1d1a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2513,7 +2513,7 @@ gpucc: clock-controller@3d90000 {
>                 };
>
>                 adreno_smmu: iommu@3da0000 {
> -                       compatible = "qcom,sm8250-smmu-500", "arm,mmu-500";
> +                       compatible = "qcom,sm8250-smmu-500", "arm,mmu-500", "qcom,adreno-smmu";

I see that other dtsi files use a bit different order for the
compatibility strings. They put "qcom,adreno-smmu" before
"arm,mmu-500". Can we please follow them?

With that fixed:
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>                         reg = <0 0x03da0000 0 0x10000>;
>                         #iommu-cells = <2>;
>                         #global-interrupts = <2>;
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
