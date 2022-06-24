Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21C855A300
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiFXUpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiFXUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:45:31 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7844E3A6;
        Fri, 24 Jun 2022 13:45:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j22so4117174ljg.0;
        Fri, 24 Jun 2022 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XsPmCVrvWo3jrtNwMSfS5IhEsF2y+irWuQjpTwNLwbU=;
        b=oL3YFnb6yhUXmkgjjd1lvH+Mnakr/Trrw8Jg/ll0PUnEhMbFLPfG9QsW5HS2vtk3ep
         s5MCgqPrNa6JWLDOWJHS9foJZq9VLOcRvCxl8Qjrhf4tTLhCB/NJ8HW/lVZHDs9/0Yev
         +lnsLbW481s52JVKA+OvkBMb20EARlVz9isBn4lOaVq9+5Rv/h2YGA62mJR1JmcSwUpW
         tbaD/YUz6crNdntJ7OPx4Ixl2Aba0wDUAiErgNloMpKUJqo4sKw8FhZLVTcP6R/zjyaZ
         R2KA51+tf9x+QNpU94JhsHUzJwX+LA1Tygwxy9BXJ8W17QjAbR2Icwrm1BG1Ths3Qb3b
         3xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XsPmCVrvWo3jrtNwMSfS5IhEsF2y+irWuQjpTwNLwbU=;
        b=Zz4A10HCTZ9xj17tDA9Lyj3G+44+lFmkDn8QAxZzbJOoIoFrYyKHAa4NAxiAw2twdI
         BU2gNmngNRRaY/ZG/laPpJN7xHFSzXWh062BVXs0FMEhzdmbrJ3QuNLJUlTDm5yc4ySW
         JlcY/ifsYkZaFbP/Gr5i+7qgFvdoQHKOpXC0DgbAMUJHUY9wQYMXbJJASV0GCh8BQ9W0
         EWqATCMvDjHFvjc7e4/LFdFcyx4Bb3j+xvwMTXj8CHpaXMREFVVsZNMeFUhedDNTrOVX
         kkNEQH7ceKyGdi1vAVb6/MbrjilmHghyUifgRBfwR5GiqwxDd3v0M+qQg+zf5TBWZA/K
         Jg7w==
X-Gm-Message-State: AJIora/FZV7+0vYO6KfFPK1QJ3w41Mn1D1rjxWStiNHDAKBUUpvMwzoB
        OVhqUAsKpUNvHWq2Oc/B4Aw=
X-Google-Smtp-Source: AGRyM1tHN9ziSmwLX3zRGPZmMV7l77sL9fX++ZZooIG5PTJnyB1ooTxjOOXRrC7+xhc190A83B6bxA==
X-Received: by 2002:a05:651c:1994:b0:255:aaa3:d02 with SMTP id bx20-20020a05651c199400b00255aaa30d02mr383340ljb.410.1656103528580;
        Fri, 24 Jun 2022 13:45:28 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id s8-20020a056512202800b0047f750ecd8csm519950lfs.67.2022.06.24.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:45:27 -0700 (PDT)
Date:   Fri, 24 Jun 2022 23:45:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v9 4/5] arm: dts: stih407-family: Harmonize DWC
 USB3 DT nodes name
Message-ID: <20220624204524.nveittak6ruksuvq@mobilestation>
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141622.7149-5-Sergey.Semin@baikalelectronics.ru>
 <59d8a34a-a211-d00a-2243-6ad51cfa4204@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d8a34a-a211-d00a-2243-6ad51cfa4204@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 07:18:57PM +0200, Krzysztof Kozlowski wrote:
> On 24/06/2022 16:16, Serge Semin wrote:
> > In accordance with the DWC USB3 bindings the corresponding node
> > name is suppose to comply with the Generic USB HCD DT schema, which
> > requires the USB nodes to have the name acceptable by the regexp:
> > "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> > named.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
> > ---
> >  arch/arm/boot/dts/stih407-family.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > index 1713f7878117..7ba528315dbe 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -725,7 +725,7 @@ st_dwc3: dwc3@8f94000 {
> >  
> >  			status = "disabled";
> >  
> > -			dwc3: dwc3@9900000 {
> > +			dwc3: usb@9900000 {
> 

> This does not apply. What tree is it based on?

That's weird. The series has been rebased onto the mainline kernel v5.19-rc3.
Do you have the stih407 dtsi fixed on your local repo?

-Sergey

> 
> 
> Best regards,
> Krzysztof
