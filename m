Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0634755DAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242367AbiF0WB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbiF0Vzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:55:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F9713F6D;
        Mon, 27 Jun 2022 14:55:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w20so18893392lfa.11;
        Mon, 27 Jun 2022 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F2rE4WiiB56ceX/DgU00bSkUe75l3cXsNOMmf38a5Zs=;
        b=FEQZCSvyunp3uzDnTXHU3J/w472GKsWStwPmmqVUW3M4BP99nff9fjklYCAHVRzl+l
         7PdPnItOj7cM3MRIkTh9SYZeCgI860HuNoo0QIqzoGF7nPyBNo87fn1boR9Pp1JAzIJ/
         q+JiDvehmhxeWN2Gd/gusxeyvN+rP1/yIu3lX0trXcrL4GgpR6enBsApW/oo3wMQY7q9
         Fwb0vnJ60iHDy91jMTXIicoxCKhW+TwmfcozTcVnc5LaahfYFH6N1f5Qk0Uzdc1nm25J
         uoTGc0lXxv1te35Psxvd38IaQ3ajm5XnaZKZJ43VPquSrUEPOgTbqT8XLbioBY3VSeSU
         a1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F2rE4WiiB56ceX/DgU00bSkUe75l3cXsNOMmf38a5Zs=;
        b=SIOGZ70tBkDxm0NdY6Fc1enom4aplr7T1fM0v3tya7Tnb+PISpgb7mptGgUkQX6K5F
         GJdu0Ib40hF4PsWRi5Brp5MHcFqq2iBqvV/idiAphmcANRSRUkXzf1TCkpdlV3lYTYOh
         ezSVM0Kqf8YuRk7jhnJ80HRb+ZNb7yNID9X/jDMlo4aZ474Hc8OXT1LqPqMNKfs9Xk+C
         Nw/pnqtZLzpRMZOZsuouNHycFab/FiokYyR0wOUTeQC3FXL2ZCKbh1nR0HA4xyGA4/h6
         +kYlIENqRwjSL/yt9ASHpiTFVNepyO2+N/STJqdW18u6GNGb+FiS9XmleNu2roYyC6x3
         Vm+A==
X-Gm-Message-State: AJIora9vLBXs7lcYBGYB1vBWP+jq+n12UkNYLPYjkd4ASyYh5JupfIIs
        aK2An+To5tqBRAcuj6TBIhQ=
X-Google-Smtp-Source: AGRyM1uL2KKsGpEUiiGMb12gLYw6jj+9Trew1WchHkWhPJ/Yvh3dZrjyPSRGRIj4HHPU4BOHiEr71Q==
X-Received: by 2002:a05:6512:2356:b0:47f:8756:737b with SMTP id p22-20020a056512235600b0047f8756737bmr9981225lfu.212.1656366905748;
        Mon, 27 Jun 2022 14:55:05 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id g1-20020a0565123b8100b0047f9d9a4186sm1944482lfv.165.2022.06.27.14.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:55:05 -0700 (PDT)
Date:   Tue, 28 Jun 2022 00:55:02 +0300
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
Message-ID: <20220627215502.4caxt2ebsdi4ue7l@mobilestation>
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141622.7149-5-Sergey.Semin@baikalelectronics.ru>
 <59d8a34a-a211-d00a-2243-6ad51cfa4204@linaro.org>
 <20220624204524.nveittak6ruksuvq@mobilestation>
 <8b384f4e-7114-7afb-98d6-af71709525d6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b384f4e-7114-7afb-98d6-af71709525d6@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 12:42:48PM +0200, Krzysztof Kozlowski wrote:
> On 24/06/2022 22:45, Serge Semin wrote:
> > On Fri, Jun 24, 2022 at 07:18:57PM +0200, Krzysztof Kozlowski wrote:
> >> On 24/06/2022 16:16, Serge Semin wrote:
> >>> In accordance with the DWC USB3 bindings the corresponding node
> >>> name is suppose to comply with the Generic USB HCD DT schema, which
> >>> requires the USB nodes to have the name acceptable by the regexp:
> >>> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> >>> named.
> >>>
> >>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>> Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
> >>> ---
> >>>  arch/arm/boot/dts/stih407-family.dtsi | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> >>> index 1713f7878117..7ba528315dbe 100644
> >>> --- a/arch/arm/boot/dts/stih407-family.dtsi
> >>> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> >>> @@ -725,7 +725,7 @@ st_dwc3: dwc3@8f94000 {
> >>>  
> >>>  			status = "disabled";
> >>>  
> >>> -			dwc3: dwc3@9900000 {
> >>> +			dwc3: usb@9900000 {
> >>
> > 
> >> This does not apply. What tree is it based on?
> > 
> > That's weird. The series has been rebased onto the mainline kernel v5.19-rc3.
> > Do you have the stih407 dtsi fixed on your local repo?
> 

> It conflicts with my change:
> https://lore.kernel.org/all/20220526203632.831039-1-krzysztof.kozlowski@linaro.org/
> 
> I'll apply with local fixups.

Ok. Thanks.

-Sergey

> 
> 
> Best regards,
> Krzysztof
