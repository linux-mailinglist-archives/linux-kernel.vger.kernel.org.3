Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CEF4B6762
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiBOJUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:20:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiBOJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:20:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68A9E2CCA7;
        Tue, 15 Feb 2022 01:20:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 308731063;
        Tue, 15 Feb 2022 01:20:41 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 586333F66F;
        Tue, 15 Feb 2022 01:20:39 -0800 (PST)
Date:   Tue, 15 Feb 2022 09:20:37 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/8] dt-bindings: firmware: arm,scmi: Add
 atomic-threshold-us optional property
Message-ID: <20220215092023.GA21915@e120937-lin>
References: <20220213195832.27932-1-cristian.marussi@arm.com>
 <20220213195832.27932-5-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213195832.27932-5-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 07:58:28PM +0000, Cristian Marussi wrote:
> SCMI protocols in the platform can optionally signal to the OSPM agent
> the expected execution latency for a specific resource/operation pair.
> 
> Introduce an SCMI system wide optional property to describe a global time
> threshold which can be configured on a per-platform base to determine the
> opportunity, or not, for an SCMI command advertised to have a higher
> latency than the threshold, to be considered for atomic operations:
> high-latency SCMI synchronous commands should be preferably issued in the
> usual non-atomic mode.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 --> v4
> - renamed property to atomic-threshold-us
> v1 --> v2
> - rephrased the property description
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index eae15df36eef..3ffa669b91af 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -81,6 +81,15 @@ properties:
>    '#size-cells':
>      const: 0
>  

Hi Rob,

gentle ping ... any feedback on this SCMI DT addition ?

(beside the brain-dead error of mine down below in the example still
to be fixed...my bad)

> +  atomic-threshold-us:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      An optional time value, expressed in microseconds, representing, on this
> +      platform, the threshold above which any SCMI command, advertised to have
> +      an higher-than-threshold execution latency, should not be considered for
> +      atomic mode of operation, even if requested.
> +      If left unconfigured defaults to zero.
> +
>    arm,smc-id:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> @@ -264,6 +273,8 @@ examples:
>              #address-cells = <1>;
>              #size-cells = <0>;
>  
> +            atomic_threshold = <10000>;
> +

...this example clearly still needs to be renamed to 'atomic-threshold-us'

Thanks,
Cristian
