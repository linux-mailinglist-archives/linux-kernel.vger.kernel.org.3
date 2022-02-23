Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F54C0C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbiBWFul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiBWFuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:50:37 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F088843486
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:50:09 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d187so14329843pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v75UoHDMV8Urw5J412ERbhmzgEk+9C7vg5aYyG8DNWU=;
        b=BhmhUsOjiIoWB4qqEZ33JuuDLGq5ar8gcqVcHHXAJufMZCtfgryWlMFaMYU4rdl4pO
         2qKNZxmv0itQMvWcmyvQ0uEeZrxMcRGmSlTB2XBjeS2H0loTJ2VQQynnQw9YyQeaZqrb
         evhNvF4ZXxKsk+Z4YGdR51uzVeqJQIYNImt78PTJPycNlFsMUCCwbYcTF6ihEcM0sIWY
         RvmjHGcq2I0SOPOfvWZoGHa+reskTyS3azZFEMV/O1rJ8zsNBoMS4ojkr84SIcSOlhcV
         fPCaDNni0wJmgmaXXn6EcZM4BUVX4TEDzIM9C+YLJHbJFbP1BV3yWttFLUUN7rAT9jBo
         fUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v75UoHDMV8Urw5J412ERbhmzgEk+9C7vg5aYyG8DNWU=;
        b=JO3LdiFA/817AqsoYYDLpl8gQmZjyUjHHmRknbxsRQBER3FheMHfckBQDPwuXAUadD
         t2cFEslOHv8BQixmo2kUin0t5yy0mxjb6y1Z+lBJ01RzJ0Lx7vrVRP+GpH4D7IWBeRI5
         CiXk/ywwX2SOF7cykHzUJpQooACqVKVYyVE23yY9XuTDmMYW643DDLCi+70DWjQFIsmp
         JFnyKwCwyfFubWZaYeh35NNTOLElne/WUZK41omnwboPM4bDeN3co27mmgcr8QFObf4T
         5Q0w46wV7HJl9vI5Ovq/5+CTYRPIQ5cy2jW9+teIKXhTL3gGdv/irQcrmCSkzxI/M4gI
         UJRA==
X-Gm-Message-State: AOAM532jPctf+eelLhK1B0biqiz1IxBkHcx+oxpz/xEhn7UkxI5miIxm
        DOIUjAL90KIOSq0ZD1Xm5kmSIA==
X-Google-Smtp-Source: ABdhPJzoLX4bZEQZeZGtz4jgW5zJz1eKTbRYv8TUYOR+TdHLNMDzpgbnlYYaD9VxiwDslerAzXtxMg==
X-Received: by 2002:a63:8649:0:b0:34c:3be:ba14 with SMTP id x70-20020a638649000000b0034c03beba14mr22311661pgd.139.1645595409440;
        Tue, 22 Feb 2022 21:50:09 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id z27sm22534821pgk.78.2022.02.22.21.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 21:50:08 -0800 (PST)
Date:   Wed, 23 Feb 2022 11:20:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [[PATCH v2 1/2] dt-bindings: opp: Add 'opp-microwatt' entry in
 the OPP
Message-ID: <20220223055006.zlcwco7oducggxjw@vireshk-i7>
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <20220222140746.12293-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222140746.12293-2-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-22, 14:07, Lukasz Luba wrote:
> Add new entry for the OPP which provides information about power
> expressed in micro-Watts. It is useful for the Energy Model framework.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> index 15a76bcd6d42..3f07a279ed2a 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> @@ -93,6 +93,13 @@ patternProperties:
>          minItems: 1
>          maxItems: 8   # Should be enough regulators
>  
> +      opp-microwatt:
> +        description:
> +          Power for the OPP
> +
> +          A value representing power for the OPP in micro-Watts.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +

I was expecting a much larger change here. Look at how opp-microvolt and
opp-microamp is defined in this file.

Should this value be made per-supply/regulator, just like voltage/current ?

>        opp-level:
>          description:
>            A value representing the performance level of the device.

-- 
viresh
