Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D348BCD6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348152AbiALCEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:04:07 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:40943 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiALCEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:04:06 -0500
Received: by mail-ot1-f49.google.com with SMTP id t6-20020a9d7746000000b005917e6b96ffso923149otl.7;
        Tue, 11 Jan 2022 18:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=732LfXDboSsjn+njEaotROfdKRLLZkHsbM9vidIAV2s=;
        b=tMqOxhR+BDCnEfD653Ihfl4u3evsC7fvM4+ZXE9UIa3ctDksx/UeLxWSvjIjVUFFUY
         nrXNQQOWtZvvslbbKbt1RWa9oLpiIHs55QYUyCRht7+SDQs80Ael8REhSsAHmLjJB7jU
         UrMPpKPJJJUJ/e9T+dek+uYXo5QvM+JRrxJUtB8tAZ+KhfxTzPo7+jb0vo1WFYHu3tKw
         bclJqmLo9oI/PCSNc+VLo9gDRbNsrPTgrdiSTowjKJzCyJgf0eLfkp1paB2WAJ+XBrCq
         kVhSnfVeaTmZWOfb4Aj473r2xgtSJi3pYYgqkrfVy+o16CgureGFabrgoH/xGA/uSYrM
         POMw==
X-Gm-Message-State: AOAM530LhMl+3+6ng66CpDICwP0vh9i24l8vY5YhVRsyJHfR7ALULsXo
        ciHNznwJVE0t1ijTNz1SUg==
X-Google-Smtp-Source: ABdhPJwY9dDpl1RJ6XKuFyePGvXumDgTUK6UNAgVzBPFfb/mWwiqA6knmsV9VO0FPVh3Jm7bTxlfAw==
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr5231750oth.241.1641953045635;
        Tue, 11 Jan 2022 18:04:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e69sm111160ote.1.2022.01.11.18.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:04:05 -0800 (PST)
Received: (nullmailer pid 3919030 invoked by uid 1000);
        Wed, 12 Jan 2022 02:04:04 -0000
Date:   Tue, 11 Jan 2022 20:04:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: devfreq: rk3399_dmc: Add more
 disable-freq properties
Message-ID: <Yd43FL2JihCdn8Ta@robh.at.kernel.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
 <20220107155215.4.I382d4de737198ea52deb118c9bdc4d93d76e009e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107155215.4.I382d4de737198ea52deb118c9bdc4d93d76e009e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 03:53:14PM -0800, Brian Norris wrote:
> DDR DVFS tuning has found that several power-saving features don't have
> good tradeoffs at higher frequencies -- at higher frequencies, we'll see
> glitches or other errors. Provide tuning controls so these can be
> disabled at higher OPPs, and left active only at the lower ones.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  .../bindings/devfreq/rk3399_dmc.yaml          | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
> index 2c871c57fd97..357d07c5a3df 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
> @@ -271,6 +271,43 @@ properties:
>        When the DRAM type is LPDDR4, this parameter defines the PHY side ODT
>        strength. Default value is 60.
>  
> +  rockchip,pd_idle_dis_freq:

s/_/-/

on all the new properties.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Defines the power-down idle disable frequency in Hz. When the DDR
> +      frequency is greater than pd_idle_dis_freq, power-down idle is disabled.
> +      See also rockchip,pd_idle.
> +
> +  rockchip,sr_idle_dis_freq:

'-hz' suffix. Let's not repeat the same problem.


> +    $ref: /schemas/types.yaml#/definitions/uint32

And then the type can be dropped.

> +    description:
> +      Defines the self-refresh idle disable frequency in Hz. When the DDR
> +      frequency is greater than sr_idle_dis_freq, self-refresh idle is
> +      disabled. See also rockchip,sr_idle.
> +
> +  rockchip,sr_mc_gate_idle_dis_freq:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Defines the self-refresh and memory-controller clock gating disable
> +      frequency in Hz. When the DDR frequency is greater than
> +      sr_mc_gate_idle_dis_freq, the clock will not be gated when idle. See also
> +      rockchip,sr_mc_gate_idle.
> +
> +  rockchip,srpd_lite_idle_dis_freq:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Defines the self-refresh power down idle disable frequency in Hz. When
> +      the DDR frequency is greater than srpd_lite_idle_dis_freq, memory will
> +      not be placed into self-refresh power down mode when idle. See also
> +      rockchip,srpd_lite_idle.
> +
> +  rockchip,standby_idle_dis_freq:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Defines the standby idle disable frequency in Hz. When the DDR frequency
> +      is greater than standby_idle_dis_freq, standby idle is disabled. See also
> +      rockchip,standby_idle.
> +
>  additionalProperties: false
>  
>  examples:
> @@ -294,4 +331,9 @@ examples:
>        rockchip,ddr3_odt_dis_freq = <333000000>;
>        rockchip,lpddr3_odt_dis_freq = <333000000>;
>        rockchip,lpddr4_odt_dis_freq = <333000000>;
> +      rockchip,pd_idle_dis_freq = <1000000000>;
> +      rockchip,sr_idle_dis_freq = <1000000000>;
> +      rockchip,sr_mc_gate_idle_dis_freq = <1000000000>;
> +      rockchip,srpd_lite_idle_dis_freq = <0>;
> +      rockchip,standby_idle_dis_freq = <928000000>;
>      };
> -- 
> 2.34.1.575.g55b058a8bb-goog
> 
> 
