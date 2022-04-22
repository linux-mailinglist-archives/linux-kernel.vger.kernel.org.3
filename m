Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325F150AF64
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444038AbiDVFMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354690AbiDVFMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:12:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670AE4F442
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:09:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g9so6447939pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IxkWrK2BHkhEkKKlVUNG0OHecJx6kgtTQfmR8oiK8fY=;
        b=lqpCouB++8hljbNrHceC1Qyuwuw+vCI2Fhh8ZFdRfXxhXpRkv6g2BA/tNxAPsxgvkr
         u1w04SPrnfVYkE3mFoG48Ti9k/z8UT5WYiln4iNHoRm7Qifnv87ZE8YThHZXSPIBk33s
         cgEeltKzihF2u7m2Rx9L52X77Ftym+qXjgfxCuWWrIicVaP5Jg2SgwIWdin/gaEyFEzu
         Ext803WlCRXwXzZsLwuqtVS8NVNTVT8D2RbXIjdgnN1qqvJ94LfZ42ZuTXANLZ0OPeeR
         uCoDCo74DxXysCvLAG+sDPte7QHEDlbnJ1EX97I3Lp3cztRaLWZL5JySGaZxqqrOs+bj
         SaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IxkWrK2BHkhEkKKlVUNG0OHecJx6kgtTQfmR8oiK8fY=;
        b=vmnLC4FoJPqr57J0Ym7BosGUUqhykpHXQn7LTyw6YopwEYNIMO983Ic6xHi4b/GORv
         wkEDR1DgjDqoC9PIVir+TOxl6eAltGgM5mcUrmHkWv5mIQIxllddXFearyXoVR+1riDI
         T+rfIA4Xwd7Pk+P4C8hZQCos43Prph0+GxSzInT6UY29GWyUtI/Pnlp5DS85E02/8ODp
         Y8xsnHaWMyOwzbRjGPfaWHR7SDdGCSnAc6TMmniNCjpqNdN6QG5vFXUYlx/J/uR6wwCx
         500XIptMtBklvcMkPVjAbI50ymxeLyRqFKT2MsmkdSwELyWbJwsa15L1mdu93Tr9Rvww
         yE/g==
X-Gm-Message-State: AOAM533DAWR+ghprmHzm7Av2ZbEC8fRbDVxrTtG0EChTxUzio7CK+D23
        4wd2S+iR+oGpF3gq7KvNx9ByTQ==
X-Google-Smtp-Source: ABdhPJzee0DpsxJWDBhWAOgmHW7pXvMAFcHq9PAexcssqN/6IoJ0HKyEyTKjakiAzo82w81k4zugdA==
X-Received: by 2002:a05:6a00:e0b:b0:4fa:a167:5b35 with SMTP id bq11-20020a056a000e0b00b004faa1675b35mr3121349pfb.69.1650604146814;
        Thu, 21 Apr 2022 22:09:06 -0700 (PDT)
Received: from x1 ([2601:1c2:1001:7090:dbb3:3d38:62d2:5de5])
        by smtp.gmail.com with ESMTPSA id e126-20020a621e84000000b0050567191161sm854912pfe.210.2022.04.21.22.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 22:09:06 -0700 (PDT)
Date:   Thu, 21 Apr 2022 22:10:06 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
Message-ID: <YmI4rjkpX9krZAGn@x1>
References: <20220414192722.2978837-1-dfustini@baylibre.com>
 <YmEAA7kc4jNHSkGm@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmEAA7kc4jNHSkGm@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 09:56:03AM +0300, Tony Lindgren wrote:
> Hi,
> 
> * Drew Fustini <dfustini@baylibre.com> [220414 19:24]:
> > TI AM437x SoCs support isolation of the IOs so that control is taken
> > from the peripheral they are connected to and overridden by values
> > present in the control register for that pad. This series documents a
> > new property 'ti,set-io-isolation' and updates the wkup_m3_ipc driver to
> > inform the CM3 firmware when that property is set.
> 
> Care to list what hardware and board revisions you're able to test deep
> sleep with?
> 
> Seems like my am437x-evm is too old for this where the board layout
> does not match the schematics for removing a resistor to enable this.
> 
> Just wondering if I can still enable tests for this somehow :)
> 
> Regards,
> 
> Tony

Do you know what revision of the am437x-gp-evm that you have?

The AM437X_GP_EVM_3K0006_SCHEMATIC_REV1_5B schematic [1] for the
AM437x-GP-EVM shows that the EN pin on the TPS51200 is connected to SoC
ball N25 which is GPIO5_7.

Unfortunately, the only AM437x board that I have is the AM437x IDK [2]
which unfortunately does not have the TSP51200 EN pin connected to the
the SoC. In addition, the am437x-gp-evm is the only board that is
allowed to enable off mode due to am43xx_check_off_mode_enable() in
arch/arm/mach-omap2/pm33xx-core.c

Thank you,
Drew

[1] https://www.ti.com/lit/zip/tidrc79
[2] https://www.ti.com/lit/zip/sprr396
