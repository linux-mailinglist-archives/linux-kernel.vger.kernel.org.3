Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75089465A87
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbhLBATW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbhLBATU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:19:20 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72594C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 16:15:58 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id n66so52059926oia.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 16:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5fIQ6AXcM0gNdq6MfBOpt1z0X7Fsc0u8cUt+/4xh4Do=;
        b=sSiMH+E9z8brVBxLHOPGy5WD8p0Snw2niO7+cuV7qs7ojEKGxazj7fQcZpDz0V92Bs
         G1PXKiAh/nFJ/W/3kb7PTTGq94E7cnCY2NvskLbm9fpBzONbCLIn7SKkBiR0DsnY3g1+
         yodRXFe0IM3nL4sqmqq6cb+MfkcHVRoT39Lxz14JnQdXfoafMKf89rolpJUIyYLckSmQ
         mTBxKuId4dd5zW5D9XLoEi/uSHo7E4yeyA5rPFX8QJ95yGP/Dgd1bROJMlLJkii7L+UY
         mfZAdmFLJk1D+Yi17YMmUMDddWPWZ8LdzYJEOzaVXKZ/Wm+qpDM4dBcajEpOZkC8/OBQ
         ueow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5fIQ6AXcM0gNdq6MfBOpt1z0X7Fsc0u8cUt+/4xh4Do=;
        b=PJcETDJDx3EhzyNkP0UV701fJDkgsHfuYxb+2/Xd2hnownVhL7vdedLHYY12WgLvBp
         kIerS3ui2dslzkGjomZTBQkjV47GYIZEcbzGRgYa79dWiwl2A8Fg6WflOUv6fL4qXXQH
         75v8NFB/iOsgGgQK6/m+QsXgOWEwnV55luic6hC79nXQS6vTLobvY2CK6fqPYJtLJTfY
         JMwx7kl4LthSGZDBE4WdVwIDWKuCk1WY4IqZcK3in8clDh+cqh7jytkFX5ZdXmKE+4v2
         9mb7mPdVlRXE36sk4lBKFNeZ9UQXiNL/g/SxjBCYMZu+wPfwVuIEDHd9dDhmGR8Q8eYL
         lcMQ==
X-Gm-Message-State: AOAM533VRLFDb/Vd2LcPBAx9LNTj2Bh1CRTJa8nAykUlppp8MqL1LWAs
        GOTx8ITgdbEq5EeN18E7w6tl/g==
X-Google-Smtp-Source: ABdhPJxYuan9p3VRQ508Kk7Zuc6kskhGwIgXWbLNIhlATTfZRw0mtehJw8BtJQ+RbFJs2vJokHYEyA==
X-Received: by 2002:aca:accd:: with SMTP id v196mr1716493oie.108.1638404157797;
        Wed, 01 Dec 2021 16:15:57 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g2sm553464oic.35.2021.12.01.16.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 16:15:57 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:17:29 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/16] arm64: dts: qcom: sm8350: Specify clock-frequency
 for arch timer
Message-ID: <YagQmQzk7GorCUVv@ripper>
References: <20211114012755.112226-1-konrad.dybcio@somainline.org>
 <20211114012755.112226-4-konrad.dybcio@somainline.org>
 <20211130020536.52D0FC53FC7@smtp.kernel.org>
 <dee30442-8a78-07f3-1fa1-e5922a510182@somainline.org>
 <20211201204543.1286DC53FAD@smtp.kernel.org>
 <0b171f2e-4bbc-a54a-7615-87fd4559fee9@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b171f2e-4bbc-a54a-7615-87fd4559fee9@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01 Dec 16:00 PST 2021, Konrad Dybcio wrote:

> 
> On 01.12.2021 21:45, Stephen Boyd wrote:
> > Quoting Konrad Dybcio (2021-11-30 11:59:03)
> >> On 30/11/2021 03:05, Stephen Boyd wrote:
> >>> Quoting Konrad Dybcio (2021-11-13 17:27:43)
> >>>> Arch timer runs at 19.2 MHz. Specify the rate in the timer node.
> >>>>
> >>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> >>>> ---
> >>>>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 +
> >>>>   1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> >>>> index a30ba3193d84..60866a20a55c 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> >>>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> >>>> @@ -2484,5 +2484,6 @@ timer {
> >>>>                               <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> >>>>                               <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> >>>>                               <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> >>>> +               clock-frequency = <19200000>;
> >>> Does the firmware not set the frequency properly?
> >> It does on my device on the current firmware version (it wouldn't really 
> >> boot if it didn't, no?),
> >>
> >> but who knows if it always will, or if it always has been..
> >>
> >>
> >> It's present in downstream too, so I reckon it does not hurt to have it 
> >> here too, even
> >>
> >> for completeness-of-describing-the-machine-properly sake.
> >>
> > No. We don't want dts files to have this. The property is only there to
> > workaround bad firmware that doesn't set the frequency. Please drop this
> > patch.
> 
> After looking at it again, I see I was indeed wrong, and so was this patch.
> 
> Sorry, and green light for dropping..
> 

Can you please send me a patch that reverts the change as I merged it
into my -next branch already? Both to simplify for me and to document
why it shouldn't be here for others to refer to in the future.

Thanks,
Bjorn
