Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184F94D1AE5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242655AbiCHOpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiCHOpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:45:49 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCB145AEB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:44:53 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BFE353F79A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646750691;
        bh=XPWngrH4yB2m8hPYi3WQlp0y7ozLbZ9SOUzkcBuiDSo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FyzW7jZm5/SzB5CY5YUENMumCuwL4VYV7UnNsim3G9wIStF3mJg4avt+E5czVDotp
         9J9NFk5wLTxmrf2LTJoSjbWUOg0Pz0b9MJgfkr7JcZqM6K9oa7SecN70DfwJe9iLh9
         Jir55eVgWUMneZ1DhI8G1Z4CCET2YrjCRpgid9zZfzEjO1W/vNCZMWpx7u4hN1rbXt
         gKBqE7WU0gOlY78r4FLZ4jTMhfisw8BJiRNWvXt2F4zDrWOm1vcXB9Iybh6xyXIivr
         wj2lvuav+ecE1Ai7SIZAmV0H/PUe6qsAWJi6LF53/aPC8DlC9exS/goeCqrYtL3051
         iu//6O0wZmoxA==
Received: by mail-ed1-f71.google.com with SMTP id i17-20020aa7c711000000b00415ecaefd07so8359222edq.21
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 06:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XPWngrH4yB2m8hPYi3WQlp0y7ozLbZ9SOUzkcBuiDSo=;
        b=nDdq8eFBirKFUL8WUd/nXdWwlYlQmADOmsmKReVa12ElLR2/Y8apzt72eIr2Rj67Vy
         f+1hIcpQ1kIMAR8xQhRFTEQBSc87jqBKJfpp5WnnY+FnApWKKNyVCMESwR4x0lXJdOfU
         GmJUVWNm29CA4IYEsezV+Tmlc9L18ZiccYM6PbY6oUvQ+PNxLM2EkV60zMF39hcSPmam
         j2uPt+p8sdmC9j4nwKebBUM5xc7bXAmL9w7DBPIM+iXNuIYshIevEuQATC8hEoO8sSvN
         cQ5lNgV4Kec/gfnD6pEY5ivjPjYQe2TDAEHfDCRpNnx5N5IYJqOwQ02SHMcbrkhz2TWI
         exxQ==
X-Gm-Message-State: AOAM532/kAV1eL3zd1a1TY8JV1h7mzrb2c4rqikvCem9M9z/Tg8ntu7k
        TFR5ZtawwX6o5Xo6naTLdOk3k7bGau1+Wl7Eomzse8+JI0SVjkUlseRU5geRejIGqB/v1zzAskM
        cK2+GxAAjKM8I0yIyOJmYfwEdFe+lZdSshBkZAZNbGg==
X-Received: by 2002:a17:907:d93:b0:6da:bb7a:4da with SMTP id go19-20020a1709070d9300b006dabb7a04damr13412639ejc.183.1646750690447;
        Tue, 08 Mar 2022 06:44:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTaOdqLNPXSX1Gu97Fy6UulewAGsgiEfqKcZeLZUk+nIltFuvBtpMRoLBaIjZbNZtX/RFdnw==
X-Received: by 2002:a17:907:d93:b0:6da:bb7a:4da with SMTP id go19-20020a1709070d9300b006dabb7a04damr13412630ejc.183.1646750690213;
        Tue, 08 Mar 2022 06:44:50 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906144b00b006cf61dfb03esm6023364ejc.62.2022.03.08.06.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:44:49 -0800 (PST)
Message-ID: <26f42531-8f55-9fda-9465-bd78a2224f2c@canonical.com>
Date:   Tue, 8 Mar 2022 15:44:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/4] dt-bindings: timer: exynos4210-mct: Support using
 only local timer
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, robh+dt@kernel.org
References: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
 <20220308142410.3193729-3-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220308142410.3193729-3-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 15:24, Vincent Whitchurch wrote:
> The ARTPEC-8 SoC has a quad-core Cortex-A53 and a single-core Cortex-A5
> which share one MCT with one global and eight local timers.  The
> Cortex-A53 and Cortex-A5 do not have cache-coherency between them, and
> therefore run two separate kernels.
> 
> The Cortex-A53 boots first and starts the global FRC and also registers
> a clock events device using the global timer.  (This global timer clock
> events is usually replaced by arch timer clock events for each of the
> cores.)
> 
> When the A5 boots, we should not use the global timer interrupts or
> write to the global timer registers.  This is because even if there are
> four global comparators, the control bits for all four are in the same
> registers, and we would need to synchronize between the cpus.  Instead,
> the global timer FRC (already started by the A53) should be used as the
> clock source, and one of the local timers which are not used by the A53
> can be used for clock events on the A5.
> 
> To support this usecase, add a property to the binding to specify the
> first local timer index to be used. If this parameter is non-zero, the
> global timer interrupts will also not be used.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v2: New.
> 
>  .../bindings/timer/samsung,exynos4210-mct.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> index dce42f1f7574..46f466081836 100644
> --- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> +++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> @@ -47,6 +47,15 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  local-timer-index:

You need vendor prefix. Also this should describe the actual hardware,
not driver behavior, so rather:
"samsung,local-timers"
with a uint32-array type and list of timers to use.

You also need separate property to skip FRC, so something like:
"samsung,frc-shared"
of type boolean.

In the bindings please describe the hardware, not the result you want to
achieve from driver model point of view.

Also disallow this for all other compatibles:
allOf:
 - if:
     not:
       properties:
       ...
   then:
     properties:
       samsung,local-timers: false
       samsung,frc-shared: false

The property simply should not be used outside of Artpec8. It's not
valid in other configurations.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    maximum: 15     # Last local timer index
> +    description: |
> +      If present, sets the first local timer index to use.  If this value is
> +      set to a non-default value, the global timer will not be used for
> +      interrupts.

Do not describe the driver, but the hardware. Instead explain which
local timers are allowed to be used.

> +
>    interrupts:
>      description: |
>        Interrupts should be put in specific order. This is, the local timer


Best regards,
Krzysztof
