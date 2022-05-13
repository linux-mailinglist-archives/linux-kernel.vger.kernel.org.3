Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED6352668D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382256AbiEMPv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiEMPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:51:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7200A1D7342
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:51:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso8125512pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sHac6RyxoRhpwtJ0Nv8blO/l0ElL7UnX1I1rlRcy1vQ=;
        b=zTSUXmk1gaktLcL7EoedGUZZ3+JuYei0KGwja5b8AMmZ23bufw5yZApn9Gjfo+Ever
         J/qKEPGT6vntYYa9Ny3H4is70qinItRekWQMLryWRDqePKK6HlMy6kzDC3vDLSAlXSJd
         FG1NUIBoX2H/rnokj2frqlehsfMHpfxnUH/cFp7AEXCXx+5WoGLovHDfxiNEaE0WI4H2
         cyX0tkoE7y4JEbdcD5VAdW9i9jXDewoYFjx5P3Oax3FynTL/caSxlzlSM7dtHQh+Rl4v
         51N3XnmYbV5w0Od00fC5CkIugP7+NT0HQUAufn0+O3hha+SsaopvxyRRCEJRpKEFcKRP
         Ksbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sHac6RyxoRhpwtJ0Nv8blO/l0ElL7UnX1I1rlRcy1vQ=;
        b=TEPrmBGSvITiv47nHzQEoEZsHNpxXlickGVyBGb8zoIW+qdpTE+L7f6KqKATWJ34mG
         0epDm9eWV1EBzThjPxXsh4DYCYKiGNgezVKMmfbnur5hLw1QeNlAHh2cmhmmOXEq+5ZB
         Hu3XMDdr06woTFctYtt6FKib46+h9XgByuJwxlaUeMOx3D4oZ3aWBfEUT8UW/njr63zj
         K/ZD6+NMcKPwWXKDXVS6iNX8DgBUJBBGRJfeArl8NJ8fyIc0VdnVFd0cfl/0BELC3bBz
         ZzW3v1rUSHtPhbL84ECAJHRb7mfEZd/bzNX2f/3vkPKaJUWjnFlWSqLF0YwZ4aVAIlbz
         J2ew==
X-Gm-Message-State: AOAM532/VtSf+mh5/G2hLx2DffwS3pIPj9ezFN+2f7/HqsUC2OyZAsUT
        UdK72dbftUy893yS7tGvkQyr
X-Google-Smtp-Source: ABdhPJyDdQzIGvs4jHC7YF16jpurc8reFvPJpDAA2Dxk5FqB+bw3piPmlVvxXWei4B2olyNnYodHtw==
X-Received: by 2002:a17:902:dac2:b0:15e:90b0:d35b with SMTP id q2-20020a170902dac200b0015e90b0d35bmr5374851plx.169.1652457111494;
        Fri, 13 May 2022 08:51:51 -0700 (PDT)
Received: from thinkpad ([117.202.184.246])
        by smtp.gmail.com with ESMTPSA id q11-20020a056a00150b00b0050dc76281d9sm1314551pfu.179.2022.05.13.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:51:50 -0700 (PDT)
Date:   Fri, 13 May 2022 21:21:41 +0530
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
Subject: Re: [PATCH v3 1/7] dt-bindings: clock: qcom,gcc-sdm845: add parent
 power domain
Message-ID: <20220513155141.GA1922@thinkpad>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org>
 <20220513061347.46480-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513061347.46480-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 08:13:41AM +0200, Krzysztof Kozlowski wrote:
> Allow Qualcomm GCC to register its parent power domain (e.g. RPMHPD) to
> properly pass performance state from children.
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
>  Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
> index d902f137ab17..daf7906ebc40 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
> @@ -43,6 +43,9 @@ properties:
>    '#reset-cells':
>      const: 1
>  
> +  power-domains:
> +    maxItems: 1
> +
>    '#power-domain-cells':
>      const: 1
>  
> -- 
> 2.32.0
> 

-- 
மணிவண்ணன் சதாசிவம்
