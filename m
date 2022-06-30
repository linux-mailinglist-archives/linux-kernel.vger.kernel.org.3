Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1495A561E17
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbiF3Ogb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbiF3Of7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:35:59 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1923FDAD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:26:22 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1048b8a38bbso25967022fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wsN5IUSis3Z9MkPYvhHUE1vLfPsFtgly3iXAQhTJWNs=;
        b=K87adrRImCtI+NFBDR3YsxzkNDDTMpvENdbkPaLP+nxxuS72mCCtGz/XQCfE+A78sH
         9JQbOp6wGbR1VYqR206soj2MfK2ZhIyEliPCHJhP76JTM1PrmW/9n2myfUJmpk6b8gCZ
         GFymIXtYfm1ZUHYDTZho75chrqwc1rFc/+C/XUUuq9cpqCkGxQSwJOr2bJZOUGHdGd0l
         hPAvA3P2/ZgjNt9bb1PoWoBuFRaBBbyO2MSOXpoVlCAZj+Ui+zsyoIDtpzY99S94hyCp
         Bi7BAW5nQIpY+cgrB5YQriVP6UQGfqYjO83iW9GRXJtlXVoUNfdE38p7z41NenMPDg4z
         QROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wsN5IUSis3Z9MkPYvhHUE1vLfPsFtgly3iXAQhTJWNs=;
        b=ZeCbhQYBNkzZkN1hfdzh16SV5UGBBrubVRsrlFTqEjMag1EmeaGCdgUR+ApvQEHPR4
         u1gckq4hrBf2l5fmQMnUx74Ewxn5JEljlgODUZ1Sfvr8JPxxstL03l/Fv4cy2kXkMD2U
         wPAfchmVNIooFbgwux9tV510V/NKxiueDPAQjCKuG6iMjwm8BF7IgIBjqncbNnBwZdfd
         hGOMZ+VCEHNOCfpuKaF1pTfsGaWe/bZeTXP+80PeG/B/AkXZyl2N/nDib7BnMAyWG5ds
         U6ds9hGHIpvxmHQyqnVNonpVwGUAz/PJMD1fYur5gkIZmPgqZB7LyqikkDLSSW8MNdh/
         Ct5w==
X-Gm-Message-State: AJIora+y4GMrUi0yvdmN5GrBjfw06HysecZrMGGbu58IjYdrAsdGewt2
        Qt3szYtgZTTrgca6P2XXFR+E+w==
X-Google-Smtp-Source: AGRyM1v2y5Xuo0LcBAt3msFqvHWw/E5JzfujPBz3bluqhmVvGK2L29ZVowaTFD6z/Y4p2A4LrnNO2A==
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id w1-20020a056870b38100b000fe2004b3b5mr5824807oap.63.1656599181559;
        Thu, 30 Jun 2022 07:26:21 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e12-20020a056870d10c00b0010490c6b552sm13054066oac.35.2022.06.30.07.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 07:26:20 -0700 (PDT)
Date:   Thu, 30 Jun 2022 09:26:19 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: interconnect:
 qcom,msm8998-cpu-bwmon: add BWMON device
Message-ID: <Yr2yi+Zl6m+JD69j@builder.lan>
References: <20220629075250.17610-1-krzysztof.kozlowski@linaro.org>
 <20220629075250.17610-2-krzysztof.kozlowski@linaro.org>
 <7d1fe567-6dd7-a6e0-08bf-225e8d515931@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1fe567-6dd7-a6e0-08bf-225e8d515931@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Jun 06:21 CDT 2022, Rajendra Nayak wrote:

> 
> > This BWMON device sits between
> > CPU and Last Level Cache Controller.
> 
> []...
> 
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - qcom,sdm845-cpu-bwmon
> 
> should this be qcom,sdm845-llcc-bwmon instead since it actually
> tells us the llcc bw values?
> That way perhaps the other one between llcc and DDR can be
> qcom,sdm845-ddr-bwmon.
> 

My understanding is that this bwmon instance measures the data
throughput on the CPU subsystem-ports and that the bwmon5 instance
measures the traffic from the memnoc towards LLCC and DDR.

Which matches the downstream naming of bwmon4 == cpu, bwmon5 == llcc.

Regards,
Bjorn
