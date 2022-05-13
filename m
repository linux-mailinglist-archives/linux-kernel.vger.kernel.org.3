Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C057526954
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383337AbiEMSco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383325AbiEMScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:32:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F6656FB3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:32:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x23so8382527pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sBXZggPIeFE45mSIaAs+XlJPZfqUA8g7V5EbUv19a6I=;
        b=FdhQLbGMzrtet6rWLr2yhwnCCjSRNSg5RMFKzUlTuFfb8/Np7/z4up0ZjA/Boedi52
         yvxkZg0zhjByGMBOnHaWzzR9E1/8BFeABbvirCBxBgGckZPrRxHmmIzcWGDr2+NJgJkP
         Igx4JbIaMg+BozYmahifc+SHD5KcAMUk6xTrgBI87GSm6GntLYSX9T1+nwAHvsFzhpmb
         0Mm226kOima3Vi4F/8KR8EsKa8X3VFQLBMsl6zQtB3kSraxBespdP38872r2AAKQbrmR
         XHp+e4yNgaiuxou99+vwqUvrxqEVKyhJJwAhgkpxpVdzT0kCjrLgcZw/UmK1v4YeKKRu
         YEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sBXZggPIeFE45mSIaAs+XlJPZfqUA8g7V5EbUv19a6I=;
        b=E6uX3vi7V/C/EciJFzyH4YIdxIzDiQyAAGdrk4fIbV0QfA2W6uCBYhTkrjffepwQMN
         HiZC4KgpKOHExWaOl/wWqR6AltAJX3pwyEOH2K/K6Zw0bB0oVFNr1Wt4eSYG15BMmkHR
         8qtMfYlfqVPip0O4lhZ/F8t8YX2LteWM6MYJW5Y8h72zWVrhb5GPLIAOB2CwMGoHmr2a
         sE2ECJkXiaF8/vnjlWpE9b3EtLV+MwcJYJMeLDaV+mghdn+Y9t2F4iTP5IrfMVHkO1c+
         Fra/0Dn4vl4u7BXXmCMr0dSqLpxktQc3upNaJvqIO5xR1AGcpOanzFKfc86sSAx7bTjE
         xJxA==
X-Gm-Message-State: AOAM531aS7oZhbIdUPhGt/aODhT/pO73mXQZ1YIGKbZHs4aM1icKqEzz
        3QEUMqgQWDPpFmbke/UZAfKt
X-Google-Smtp-Source: ABdhPJwuq0zcK3Hc4T5h8rbQb6irOcrHsm+erFrKDBWCHPXymaYagQzO43xLcSJJmwEN+bWirywLSA==
X-Received: by 2002:a65:4188:0:b0:39d:2197:13b5 with SMTP id a8-20020a654188000000b0039d219713b5mr5083946pgq.368.1652466751033;
        Fri, 13 May 2022 11:32:31 -0700 (PDT)
Received: from thinkpad ([117.202.184.246])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090322c900b0015e8d4eb2c6sm2144582plg.272.2022.05.13.11.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 11:32:30 -0700 (PDT)
Date:   Sat, 14 May 2022 00:02:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/7] dt-bindings: ufs: common: add OPP table
Message-ID: <20220513183220.GE1922@thinkpad>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
 <20220513061347.46480-4-krzysztof.kozlowski@linaro.org>
 <20220513174010.GC1922@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513174010.GC1922@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 11:10:20PM +0530, Manivannan Sadhasivam wrote:
> On Fri, May 13, 2022 at 08:13:43AM +0200, Krzysztof Kozlowski wrote:
> > Except scaling UFS and bus clocks, it's necessary to scale also the
> > voltages of regulators or power domain performance state levels.  Adding
> > Operating Performance Points table allows to adjust power domain
> > performance state, depending on the UFS clock speed.
> > 
> > OPPv2 deprecates previous property limited to clock scaling:
> > freq-table-hz.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > ---
> > 
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/ufs/ufs-common.yaml   | 34 +++++++++++++++++--
> >  1 file changed, 31 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> > index 47a4e9e1a775..d7d2c8a136bb 100644
> > --- a/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> > +++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> > @@ -20,11 +20,24 @@ properties:
> >        items:
> >          - description: Minimum frequency for given clock in Hz
> >          - description: Maximum frequency for given clock in Hz
> > +    deprecated: true
> >      description: |
> > +      Preferred is operating-points-v2.
> > +
> >        Array of <min max> operating frequencies in Hz stored in the same order
> > -      as the clocks property. If this property is not defined or a value in the
> > -      array is "0" then it is assumed that the frequency is set by the parent
> > -      clock or a fixed rate clock source.
> > +      as the clocks property. If either this property or operating-points-v2 is
> > +      not defined or a value in the array is "0" then it is assumed that the
> > +      frequency is set by the parent clock or a fixed rate clock source.
> > +
> > +  operating-points-v2:
> > +    description:
> > +      Preferred over freq-table-hz.
> > +      If present, each OPP must contain array of frequencies stored in the same
> > +      order for each clock.  If clock frequency in the array is "0" then it is
> > +      assumed that the frequency is set by the parent clock or a fixed rate
> > +      clock source.
> 
> This description mentions only the clocks and not voltages. But in theory, the
> OPP table can contain other parameters like current, bandwidth, etc,... So to
> avoid confusion, I'd suggest to get rid of the description.
> 
> > +
> > +  opp-table: true
> >  
> >    interrupts:
> >      maxItems: 1
> > @@ -75,8 +88,23 @@ properties:
> >  
> >  dependencies:
> >    freq-table-hz: [ 'clocks' ]
> > +  operating-points-v2: [ 'clocks', 'clock-names' ]
> 
> What about voltage regulators if relevant opp property is present?
> 

Current UFS driver model won't allow us to change both voltage supplies and clks
using OPP implementation. So please ignore my above comment.

Thanks,
Mani

> Thanks,
> Mani
> 
> >  
> >  required:
> >    - interrupts
> >  
> > +allOf:
> > +  - if:
> > +      required:
> > +        - freq-table-hz
> > +    then:
> > +      properties:
> > +        operating-points-v2: false
> > +  - if:
> > +      required:
> > +        - operating-points-v2
> > +    then:
> > +      properties:
> > +        freq-table-hz: false
> > +
> >  additionalProperties: true
> > -- 
> > 2.32.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
