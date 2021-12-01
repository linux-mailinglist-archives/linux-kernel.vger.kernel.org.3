Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D84D46594A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353670AbhLAWfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:35:17 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42977 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353601AbhLAWfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:35:04 -0500
Received: by mail-ot1-f42.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so37311371otv.9;
        Wed, 01 Dec 2021 14:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T5dDFTbqoVtVfAAIqapjKcFefz1Su1Y3Jb3TmXDSfLM=;
        b=e6VKxm8ii0bpywP7FhVKOpVA+d/4HNzpb/ZRgmo54rxf9mwvuEYPz+7EcKN8bqgIzn
         Mz2wqIGuQoui8iTLfpLvpIn16VA2YxfycdLxc8gymU+W/gtcYYr8Pi8XOi9xoz3d7wU7
         Ejj1kn3bTjP1vu4cBdzg0Anf4fwq64rXzjuqNDKopaUCn4c3Q8vlElqEGPgIZQ2TR78T
         VV0GPVLI4nFBRUPNsLVGIAIA2lw5CQIl/RrtjDnBNz6D2hfRdWbJ1kBSHSS/eBkDPNMT
         3wjv5D9puJxdIJUPD8R/dBS+uCyQpzt+CzzTpD6FLky52/oha8Jjc2yAJuGuv4UJx7gV
         8/0A==
X-Gm-Message-State: AOAM530uJlHltI+1e7nk97kUhUo6HwsPfgwUhjVgZyzc3VVUPEvjaBdV
        tJ+zWam0/l+Z3uPbFPzkc9E2ccVNeA==
X-Google-Smtp-Source: ABdhPJy8bnGR48W/xJpn01QnF07dEzkJUHFVw79LlhkqiRr6++P/Ysr9/PjH2SDv8XKQNdKBo6V6lg==
X-Received: by 2002:a05:6830:2aa7:: with SMTP id s39mr8424157otu.151.1638397901599;
        Wed, 01 Dec 2021 14:31:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bi20sm592910oib.29.2021.12.01.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:31:40 -0800 (PST)
Received: (nullmailer pid 2899335 invoked by uid 1000);
        Wed, 01 Dec 2021 22:31:39 -0000
Date:   Wed, 1 Dec 2021 16:31:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        arnaud.pouliquen@foss.st.com, amelie.delaunay@foss.st.com,
        alain.volmat@foss.st.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: stm32: i2s: allow additional
 properties.
Message-ID: <Yaf3yy3tiTOaNBDY@robh.at.kernel.org>
References: <20211125144053.774-1-olivier.moysan@foss.st.com>
 <20211125144053.774-3-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125144053.774-3-olivier.moysan@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 03:40:51PM +0100, Olivier Moysan wrote:
> The STM32 SPI peripheral supports both SPI and I2S protocols.
> In the SoC device tree the node describes the peripheral as an
> SPI peripheral by default. This default configuration can be
> overwritten in board device tree to use the IP as an I2S peripheral.
> In this case the address-cells and size-cells properties from
> SoC DT SPI node should not be checked against STM32 I2S bindings.
> Set additionalProperties to "true" to allow these extra properties.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> index 64b70ac539f8..33ba15363c0f 100644
> --- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> @@ -73,7 +73,7 @@ required:
>    - dmas
>    - dma-names
>  
> -additionalProperties: false
> +additionalProperties: true

This is only allowed for schemas that are incomplete collections of 
properties such as common bindings.

Rob
