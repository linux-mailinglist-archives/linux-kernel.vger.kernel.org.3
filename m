Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407FB4705B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243475AbhLJQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:32:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:57296 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240513AbhLJQcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:32:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="262486162"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="262486162"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:29:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="612974184"
Received: from lclopezf-mobl.amr.corp.intel.com (HELO [10.209.164.172]) ([10.209.164.172])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:29:15 -0800
Subject: Re: [PATCH 2/2] ASoC: convert Everest ES8156 binding to yaml
To:     Shumin Chen <chenshumin86@sina.com>, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20211210151041.108751-1-chenshumin86@sina.com>
 <20211210151041.108751-3-chenshumin86@sina.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4c665ce2-1df3-5fc3-018a-e8eff49794a2@linux.intel.com>
Date:   Fri, 10 Dec 2021 10:29:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210151041.108751-3-chenshumin86@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/21 9:10 AM, Shumin Chen wrote:
> This patch converts Everest Semiconductor ES8156 low power audio
> CODEC binding to DT schema.

this doesn't really convert anything but *adds* properties for ES8156.

You're probably missing the device tree folks, added Rob + device tree
mailing list in CC:

> 
> Signed-off-by: Shumin Chen <chenshumin86@sina.com>
> ---
>  .../bindings/sound/everest,es8156.yaml        | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/everest,es8156.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/everest,es8156.yaml b/Documentation/devicetree/bindings/sound/everest,es8156.yaml
> new file mode 100644
> index 000000000000..695d542013c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/everest,es8156.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/everest,es8156.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Everest ES8156 audio CODEC
> +
> +maintainers:
> +  - Shumin Chen <chenshumin86@sina.com>
> +
> +properties:
> +  compatible:
> +    const: everest,es8156
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock for master clock (MCLK)
> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#sound-dai-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      es8156: codec@8 {
> +        compatible = "everest,es8156";
> +        reg = <0x11>;
> +        clocks = <&clks 10>;
> +        clock-names = "mclk";
> +        #sound-dai-cells = <0>;
> +      };
> +    };
> 
