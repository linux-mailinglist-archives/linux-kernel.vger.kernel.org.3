Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA29148A5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244392AbiAKC2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:28:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36834 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244191AbiAKC2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:28:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id x6so293656oix.3;
        Mon, 10 Jan 2022 18:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXIaIsWWEUQYqFn1KRmQY2r7PRSAKIBrP5Pdb7uhVuo=;
        b=O/E8kzdK5XWhd9RDjVf+pSuYAfoW/KRUlWiXsK+SiuoOZMMdDXZzQRnc+02EKpaQiY
         wBx32SpIjWbZwDWIzxSyeowIozsdP//XyYYAptx38DxvP2Ny1akIVqYKikoVigswb3z2
         RbCFmFu5593ZV5onoUQwA2k6ENcXK53bv18LFkGR93/Bvn/9OThB1bO5E7VQStaSHlt4
         z+/aTJKw9n110BHE5ohXvNI1l2jAA3JwezII8NAPEyMlRGaZf4mosz+ET/pYb/IBveyV
         diFU46m1Xzw1lk50NqTGPY0HxKowmY7k4ir2oy3Qkr0GI9Epy6Dt93SUtTy1WqeBpfdm
         G+PA==
X-Gm-Message-State: AOAM5339NdL9v2jWLpVFgAxXI5j2aKYR0JgKpZoz1hNIFIUwAQxTMUZT
        DE2tGBtc57I/Wxkk2JjFUq7fKsoz7w==
X-Google-Smtp-Source: ABdhPJxkI3oMGK2yHbgQ8hKosNWiPtlRTLOK9JgTyo4rMSbn5AjGqaFK85cFTVC/CO1SluiGNLCV1A==
X-Received: by 2002:a05:6808:1147:: with SMTP id u7mr442549oiu.117.1641868129893;
        Mon, 10 Jan 2022 18:28:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w1sm1672399oop.23.2022.01.10.18.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 18:28:49 -0800 (PST)
Received: (nullmailer pid 2019363 invoked by uid 1000);
        Tue, 11 Jan 2022 02:28:48 -0000
Date:   Mon, 10 Jan 2022 20:28:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, peter.ujfalusi@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
Message-ID: <YdzrYNG85uoiY2P7@robh.at.kernel.org>
References: <20220103074427.4233-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103074427.4233-1-j-choudhary@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2022 13:14:27 +0530, Jayesh Choudhary wrote:
> Convert the bindings for McASP controllers for TI SOCs from txt
> to YAML schema.
> 
> Adds additional properties 'clocks', 'clock-names', 'power-domains',
> '#sound-dai-cells' and 'port' which were missing from the txt file.
> Removes properties 'sram-size-playback' and 'sram-size-capture'
> since they are not used.
> Adds 'dmas' and 'dma-names' in the example which were missing from
> the txt file.
> Changes 'interrupts' and 'interrupt-names' from optional to
> required properties.
> Changes 'op-modes', 'serial-dir' to optional properties as they are
> not needed if the McASP is used only as GPIO.
> Changes 'tdm-slots' to required property only for I2S operation mode.
> 
> Adds the yaml file in the 'MAINTAINERS' under the heading 'TEXAS
> INSTRUMENTS ASoC DRIVERS'
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> Changelog:
> v5:
> - changes the commit message
> - changes description for 'reg', 'op-mode', 'tx-num-evt',
>   'rx-num-evt' and 'interrupts'
> - adds minimum and maximum for 'tdm-slots'
> - removes default from 'serial-dir'
> - removes maxItems from 'tdm-slots', 'tx-num-evt', 'rx-num-evt' and
>   'auxclk-fs-ratio' as they are of type uint32
> - adds 'tdm-slots' as conditionally required property for I2S mode
>   of operation
> 
> v4:
> - changes the commit message
> - adds type and description to relevant properties
> - changes maxItems for 'serial-dir'
> - removes properties 'sram-size-playback' and 'sram-size-capture'
>   as they are not used
> - removes 'function-gpios'
> - removes 'num-serializer'
> - marks 'tdm-slots', 'op-mode' and 'serial-dir' as optional properties
> - adds the yaml file in MAINTAINERS
> 
> v3:
> - remove maxItems from 'clock-names'
> 
> v2:
> - changes the commit message
> - modifies the properties 'clocks', 'clock-names', 'dma-names',
>   'dmas', 'interrupts' and 'interrupt-names' according to the
>   arm SOCs
> - adds 'ports' and 'num-serializer' as node properties
> 
>  .../bindings/sound/davinci-mcasp-audio.txt    |  86 --------
>  .../bindings/sound/davinci-mcasp-audio.yaml   | 201 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 202 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
