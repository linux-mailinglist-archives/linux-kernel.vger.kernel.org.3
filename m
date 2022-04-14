Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD1C501C24
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345902AbiDNTqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345896AbiDNTqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:46:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F3DED9C3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:43:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z16so5731317pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HoOTe7YE1Mi7xuJrmm/HVDsML2ycAntXdv9+Mjx+eA8=;
        b=5t0ZJQfdz5maXzWjYugPMQc/fDTCQUV5q+XBgBy/6l1iKUPV2lNe7VuF/nxT3pCtT1
         1I6TITDBexQeA7vrARtqzq6TzeNVUG9N8s2fS9HhtrfMrvqWjSUHaDH197eS155kUqOM
         uKp21Hvk91zXDWkOWdBZvWARGkna8Fhxi+G8yQXkYsTGoXK3f95b2rC7YeCCEuNj8WZy
         z1rdAOwboXWEKI1xRxJ54UoO4aP2A53BGS+fLT7f8EvDqfubPAdx8g/cABvSEJb7OBsa
         idJMJNbfK2bkpn692xb9BBXHFGuueBhl18Td0o6QoVO1+WhCg7VDRNy6JsP0orim6HPw
         oeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HoOTe7YE1Mi7xuJrmm/HVDsML2ycAntXdv9+Mjx+eA8=;
        b=OVhanEsLE1IN2tLObwicc28Bu/ZgJ94FeTMfjMwatnjEPwKBVWRtuO6/i5QJ2xioT5
         /V0HYe++fEFEkZetpc/9IPIi5iEM0l8z7DaWiGvX8AD/Bu9kDNB19nH++afxsO0A4xvc
         Q/pTC0IYq8P2OFIXsGgNGkgow9sesSXYZqTqjysQzL5fhgbBkaywnCeNL0NlHYTSlEG9
         pR0fcgl48RwaSMXnQHyJcg/SkJ7iVkd3NDnDdQ98yrDQrZywhbVHTdm7aTP8NnHliwx6
         +6I2+LFoDPB4CFWtYVlJMnvpdNFifcps6i+IuOajXFSnVooYmWVV0raJl6TV0yPQmxFj
         UE0A==
X-Gm-Message-State: AOAM533qelyq0v8g5F2wKtndcvv+gOXFiiEcxD579xm6sSlsyRe5qius
        ccuNoiQd7I/Yy73RxvKjl3oUww==
X-Google-Smtp-Source: ABdhPJzlnAEM0ZydIi4iBdfWU4lsspLSPyZZdr0qS3LhVt5qVMjZWphp5KG6zcuzjev8SP5KpT0/ug==
X-Received: by 2002:a63:e146:0:b0:39d:1b00:e475 with SMTP id h6-20020a63e146000000b0039d1b00e475mr3517147pgk.537.1649965434831;
        Thu, 14 Apr 2022 12:43:54 -0700 (PDT)
Received: from x1 ([2601:1c2:1001:7090:5b60:6a76:138d:2646])
        by smtp.gmail.com with ESMTPSA id x7-20020aa784c7000000b005058d220b37sm629861pfn.64.2022.04.14.12.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:43:54 -0700 (PDT)
Date:   Thu, 14 Apr 2022 12:44:40 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: wkup-m3-ipc: Add ti,set-io-isolation
 property
Message-ID: <Ylh5qPs57uruokUh@x1>
References: <20220414192722.2978837-1-dfustini@baylibre.com>
 <20220414192722.2978837-2-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414192722.2978837-2-dfustini@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 12:27:23PM -0700, Drew Fustini wrote:
> Add documentation for the ti,set-io-isolation DT property on the wkup_m3_ipc
> node which tells the wkup_m3_ipc driver to use the wkup_m3 to enable
> IO Isolation during low power mode transitions on am43xx platforms.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> [dfustini: convert to YAML, make DTS example that passes check]
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
> Changes from v2:
> - correct indentation of the 'allOf:' block
> 
> Changes from v1:
> - correct typo of 'ti,set-io-isolation' property in subject
> - make 'ti,set-io-isolation' only valid for 'ti,am4372-wkup-m3-ipc'
> 
>  .../bindings/soc/ti/wkup-m3-ipc.yaml          | 78 +++++++++++++++++--
>  1 file changed, 73 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> index 7f4a75c5fcaa..f0ae86250fe4 100644
> --- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> @@ -24,14 +24,22 @@ description: |+
>    A wkup_m3_ipc device node is used to represent the IPC registers within an
>    SoC.
>  
> -  Support for VTT Toggle
> -  ==================================
> +  Support for VTT Toggle with GPIO pin
> +  ====================================
>    On some boards like the AM335x EVM-SK and the AM437x GP EVM, a GPIO pin is
>    connected to the enable pin on the DDR VTT regulator. This allows the
>    regulator to be disabled upon suspend and enabled upon resume. Please note
>    that the GPIO pin must be part of the GPIO0 module as only this GPIO module
>    is in the wakeup power domain.
>  
> +  Support for IO Isolation
> +  ========================
> +  On AM437x SoCs, certain pins can be forced into an alternate state when IO
> +  isolation is activated. Those pins have pad control registers prefixed by
> +  'CTRL_CONF_' that contain DS0 (e.g. deep sleep) configuration bits that can
> +  override the pin's existing bias (pull-up/pull-down) and value (high/low) when
> +  IO isolation is active.
> +
>  properties:
>    compatible:
>      enum:
> @@ -63,6 +71,24 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: GPIO pin connected to enable pin on VTT regulator
>  
> +  ti,set-io-isolation:
> +    type: boolean
> +    description:
> +      If this property is present, then the wkup_m3_ipc driver will instruct
> +      the CM3 firmware to activate IO isolation when suspending to deep sleep.
> +      This can be leveraged by a board design to put other devices on the board
> +      into a low power state.
> +allOf:

Rob - sorry for the churn.  I realize now that there should have been a
blank line before 'allOf:'.  Should I send a v4 or (if there are not
other issues) could that just added when applying?

Thank you,
Drew
