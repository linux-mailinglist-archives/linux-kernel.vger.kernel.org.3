Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98676528957
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbiEPP50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbiEPP5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:57:24 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053232DA8C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:57:23 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id i66so19078630oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vH4NPiCLU7evHB+E7xCfaeXJAYfa3KeY6XJRC/M1pQQ=;
        b=I0Fe0t6KYm7QeHL4cN/jCuSC51Un3vdX70r9iEitsqA1K63t/YgFccUQtt/UroORI8
         gbaZVesEkVpySAvrLr+ZxLjUVe3dukyjul41x8r7yLKFveJhVJxgzFg17L1JH7HETKVb
         cDLQDMsag6+BuTw6eobY8ShmaNGmOTYpnFtwNrxPKF2lvvVWZ5INfF8/MY6caqOEZSL2
         Ye6zQvzqBWRb17tEJnPLeak7Obi9afHqFu79AV4igYmSV8K323dQsA0UpeoAsYHg5tzt
         Kryqsrc9lqQlzy1F63Lns/djLraiPwLQs50Cx9vI4MtbmKGnYkO2IDrwa/0t7UdbendC
         PYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vH4NPiCLU7evHB+E7xCfaeXJAYfa3KeY6XJRC/M1pQQ=;
        b=U6Ddebz4dSTXd962qrR7AC2gpKb3mp4YqvtsyXjswev58XjfoXb0Ukt53fNqDssw1N
         qt3sH2LdLD9ZlfyQpYarOCFY0BAV+EqBSF1SkK8IDDcJL+scQ78MKD/AA4XEwTBI/sSm
         Zv1pjiNdyhCd7TEri2tXx4hD//Ks6VwpECVPwvYtIs71nd449nGqMRBtlaO3JRN6dBmR
         /Ak3h4f/w3dPkbHZjkJ1cihDhk5OThkCDWVvSIDvxuDPgdKN7VAdbFJ0Gm7HekzYgKLC
         diWgCeAohqZaZsEjQM0HEcqWBsDxOs8cbtP4YUbEoBgERnWwqPXxm4Pl/DOCLTQX9lv4
         uhWA==
X-Gm-Message-State: AOAM5313USmn8rvYRTmN8w/sBF4DRsb/rOcL4bo8HQy/rk+LN751S+i5
        NeuGLvN/l/nCUuZkMFwy7AdppA==
X-Google-Smtp-Source: ABdhPJy9xU3r4l65PfMiVkn2LKSmg6ikqMXRhfqQGFiUU7W25GCBD0SlgcmefZoFQVTXGUHG7oRFmQ==
X-Received: by 2002:a05:6808:d52:b0:328:acfc:d274 with SMTP id w18-20020a0568080d5200b00328acfcd274mr8189424oik.174.1652716642349;
        Mon, 16 May 2022 08:57:22 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u23-20020a544397000000b00328b3d8a80fsm3826691oiv.50.2022.05.16.08.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:57:21 -0700 (PDT)
Date:   Mon, 16 May 2022 08:59:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,qmp: Add compatible for
 SC8280XP USB3 UNI phy
Message-ID: <YoJ08Zd/a4g+Ia0r@ripper>
References: <20220513225348.1671639-1-bjorn.andersson@linaro.org>
 <20220513225348.1671639-2-bjorn.andersson@linaro.org>
 <8b47e106-a567-8d8f-ddd9-34b71211002e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b47e106-a567-8d8f-ddd9-34b71211002e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16 May 00:11 PDT 2022, Krzysztof Kozlowski wrote:

> On 14/05/2022 00:53, Bjorn Andersson wrote:
> > The SC8280XP platform has a pair of 5nm USB3 UNI phys, add a compatible
> > for these.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > index 8b850c5ab116..0a9ee5b7600d 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > @@ -33,6 +33,7 @@ properties:
> >        - qcom,sc8180x-qmp-ufs-phy
> >        - qcom,sc8180x-qmp-usb3-phy
> >        - qcom,sc8280xp-qmp-ufs-phy
> > +      - qcom,sc8280xp-qmp-usb3-uni-phy
> 
> What about the clocks/resets/supplies in allOf:if:then?
> 

Of course, seems like I missed that part.

Thanks,
Bjorn
