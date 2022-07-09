Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC3456C79F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 08:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiGIG71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 02:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGIG7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 02:59:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054A1573A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 23:59:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so3870954pjr.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 23:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v2JtDqU7PzAyB2SSDlLfePiEtPKLL9f+/HdXEE+Jwoo=;
        b=exz45rNdN6OGsIeYw85nm4PUWJ3RzLAhWcJz1lkU2TlSIt2GFs6MvmPle+u80bkDav
         H7JmME98HTU4A9Td8f+mGEBCo9NgOTLbSzjJmppPNixIIx0JCZvOTLQCIZikIWKqrJm5
         tasXrwzVNig2au5F4phDfFlYP8+v1b7YDCF1gf+LEG27Hq92HwlfxHoAxWxzeY9N2Eb3
         K6YPTm+KDvPgbYZucjPLF+Rfu585a9pHkqXnMY6yUmOgzm5k00juWlD2pXJpUFE49Id6
         S9PC+wfkAdxDI2hLWxY1UxTI5eeGOxTBwiy8uLZJYzL8AG35bQA3Ghe2xXOTehSVkzot
         m6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v2JtDqU7PzAyB2SSDlLfePiEtPKLL9f+/HdXEE+Jwoo=;
        b=a9As5Wq2Af4/NLKt509woG60KEW8ECHnqlUTsa/GbarpssAUQX6SSSjQdTJnKvibFr
         hN7eHCp7JyXL9bVBKwlPB/RB+wlKzzLLAX9N5qaKKxCZ9mowDkQYdUq1O3TYh1nUbF/Y
         RmnrSl8bjFOMLL2vMV+/kAl6AC2UWKwPv4Lm7sa/ycc3JbVhtbZd0h8fL83pBZWd2pLX
         oOAB/MHZcF9ncZifr1C9bJqtrXKVXZYOuEDegmMxaCuqvJZ/AHGeZo3p+dIUjdcdqZCy
         oOZOBUzQMWD8xbM0GVOMSjyheX3V2ioZDa8NHqXw5Bh65QnQ9MatpxA4dmvvZ4PGJtjl
         ebTw==
X-Gm-Message-State: AJIora++MbaqftcAcwag0FZNtz5ajRRUk3Ryn4H8Lv5xjj+vo71x38WC
        0VgcFoGijGQEhPZy2pa7Jz0/
X-Google-Smtp-Source: AGRyM1sKrq68wBrf9KtKf3ais8QIG3+D1Tgd3uJYC49Y5GDpBr58MdEbeGU/o3gzIOnNa/Wuo4ioVA==
X-Received: by 2002:a17:902:c992:b0:16b:d8b9:1c5f with SMTP id g18-20020a170902c99200b0016bd8b91c5fmr7440408plc.93.1657349963239;
        Fri, 08 Jul 2022 23:59:23 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id t123-20020a625f81000000b0052842527052sm711612pfb.189.2022.07.08.23.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 23:59:22 -0700 (PDT)
Date:   Sat, 9 Jul 2022 12:29:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add lost ranges for timer
Message-ID: <20220709065915.GG5063@thinkpad>
References: <20220707160858.3178771-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707160858.3178771-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 09:08:58AM -0700, Bjorn Andersson wrote:
> The timer node needs ranges specified to map the 1-cell children to the
> 2-cell address range used in /soc. This addition never made it into the
> patch that was posted and merged, so add it now.
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 2bdb42c88311..37a4cd6f85b6 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1667,6 +1667,7 @@ timer@17c20000 {
>  			reg = <0x0 0x17c20000 0x0 0x1000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +			ranges = <0 0 0 0x20000000>;

Even though this looks correct, I'm wondering why other SoCs are defining the
child addresses in 2 cells. I don't think the timer frames can go beyond 32bit
address space. Should we fix them too?

But for this patch,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

>  
>  			frame@17c21000 {
>  				frame-number = <0>;
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
