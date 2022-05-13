Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FA352683B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382932AbiEMRXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382930AbiEMRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:23:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC156FA14
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:23:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d17so8613373plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LmlkxE85vc6UhxNoZfZV20UnauAx9uE6Cz/0zHf9/y0=;
        b=tHn0ufT6L+atomup5vtndYLuPbMdYYrBkYgqv6ommywwIMqpqT+wemVju040dVYiUM
         kH2sDLqTKFFja93w7x9kbQpl9GqnJp1u3YyOKs2jmxb5gAIf/KEoY7mvWNSKidlC9PoQ
         /l7ch9/cWgGlO7IMtxkC9iysiHdTobTx7CwOg8CS02y2iEfr5/Ql5D/VFE7owQevuT3f
         Xrv954YQ0D49HAaesYjBUxxiIZ6jShsY1k9DXGXiVGECWWZYEGGNvYVr0LE/pCyRxvHo
         /IQ2La+xI0613nRYpdMCTlA97L8SOInyE0o7FpeSvEWszNbxcperG4TGzjloH1rByJ5w
         XgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LmlkxE85vc6UhxNoZfZV20UnauAx9uE6Cz/0zHf9/y0=;
        b=YLXkRULiO/c7hIOG+vdjIyO3VYU/tdNr3GjJGjT/5AUtMlnohopmhYSyJjHbRKC1z9
         5zWCxR4b6RSlIj8uBCuv6NZybA34yGKf+BArK3zYj5uClk9ueZQAmbJKevW7ejF+hwLF
         aaybN+lfLD+nO7czza8i/G8HWc+JeKQJ61Vl6R4VWrazX+f/TPiMXlRa3jWPjdwQha9e
         zd/g012PGvymn3Qazp4KrF9JR33ASwLNqAbSGmDMyux2dI50spNsukNCNh09TsQoY1/j
         c/66hLtiTSyR7nTElPp8G+cd+uAdxNzeVZ/wSk8cu22DaVQaE6TjTkYO07CQuoitZJbs
         fqNA==
X-Gm-Message-State: AOAM533Jiq0t2aKaKrcSERV9DADpGpO9AaE8Hyr/mDHqcnNvkYUnQpiH
        2OjGutdpPlW3+nVZsA7MxUpz
X-Google-Smtp-Source: ABdhPJyZY6dt5VXk1vcXI7ZjHApuVJAr163atWieL5kinllyl84dovJtGvw031JvaqN7voVZHkCwew==
X-Received: by 2002:a17:90b:4c0a:b0:1dc:e81a:f0c with SMTP id na10-20020a17090b4c0a00b001dce81a0f0cmr6068132pjb.2.1652462580028;
        Fri, 13 May 2022 10:23:00 -0700 (PDT)
Received: from thinkpad ([117.202.184.246])
        by smtp.gmail.com with ESMTPSA id f10-20020a6547ca000000b003c5e836eddasm1886683pgs.94.2022.05.13.10.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:22:59 -0700 (PDT)
Date:   Fri, 13 May 2022 22:52:49 +0530
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
Subject: Re: [PATCH v3 2/7] dt-bindings: opp: accept array of frequencies
Message-ID: <20220513172249.GB1922@thinkpad>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
 <20220513061347.46480-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513061347.46480-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 08:13:42AM +0200, Krzysztof Kozlowski wrote:
> Devices might need to control several clocks when scaling the frequency
> and voltage.  Allow passing array of clock frequencies, similarly to the
> voltages.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> index 76c8acd981b3..66d0ec763f0b 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> @@ -50,6 +50,16 @@ patternProperties:
>            property to uniquely identify the OPP nodes exists. Devices like power
>            domains must have another (implementation dependent) property.
>  
> +          Entries for multiple clocks shall be provided in the same field, as
> +          array of frequencies.  The OPP binding doesn't provide any provisions
> +          to relate the values to their clocks or the order in which the clocks
> +          need to be configured and that is left for the implementation
> +          specific binding.
> +        minItems: 1
> +        maxItems: 16
> +        items:
> +          maxItems: 1
> +
>        opp-microvolt:
>          description: |
>            Voltage for the OPP
> -- 
> 2.32.0
> 

-- 
மணிவண்ணன் சதாசிவம்
