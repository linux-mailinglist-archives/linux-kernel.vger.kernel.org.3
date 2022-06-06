Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FC53EB85
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbiFFP4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241335AbiFFP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:56:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FEB2390A5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:56:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g205so13020911pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HqBVIaUxLFLt31mKtTfmzpaubYdTK4hqFLvxcHrajGI=;
        b=am390ormAxfQBcDhad1xqfGuaIZhU7gIyzfW/9uyFo3xvj2W19MLPe42Uxbqs6q937
         WLzpSDXD9fxuZqRO2SmIDl3w0Cwe8amaEnwFcOEnLReu0b1+W18AgTvCA3yyiCdFMxk6
         H5tx+lg9wX6uKyHJz1DtdAqa66eSr/6WvFO7lJqSxj//PJqxpBDwR+YevD8yqIlJK/Mx
         ZcqC+/cRvVqub4Ggt/l/3P3QWCr+b4CkTekrLG3K45HTTZrJZt5U6kt8kyraYtRvIsD7
         PJDLyj70pL7QYVclaTA8PuCd/+cfqq/wzBL80/7UiaDyOElSklvX7PxNJIrVlxh41xi0
         QGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HqBVIaUxLFLt31mKtTfmzpaubYdTK4hqFLvxcHrajGI=;
        b=1YtX84ypnZuk1Ohem1/qv5SNl1p9yCovcqXLvIni3k6PZH7EQrYjQe7aVBn6CCwLPu
         p6/zHoLZYbNb3x+uVOM9RaWqK6wRkIGGmhEUPGs+zQmeDMON6G06ycTzKbTS59ajGA5c
         6LckfB6T8rXTxOmQK4Z9c6FeYgLm1yarqQmaZwZSQuxSs04YEoEnpGystpJXWZWYA+0X
         8Q4BrADrayOtEBWzMgzutPTmJ9aYnDBAeZvR3bELGAv6WusbIWEibuTtQQsvOnzzbVVf
         6Sn4c0sqJrBOCJ0zMaQzcX/rJ1SdsgI+tfVBgV4I8+scfOPgmICQCJs3BkL9D9+oLvN+
         5i8g==
X-Gm-Message-State: AOAM532ivTykd7ZosYYTx/7d+f5CL/qHaXbkEZk8HZLgWyUodW3LPyXi
        790FRWDvnECD8FCWFbalBRlBsw==
X-Google-Smtp-Source: ABdhPJze2KfB5rZ725/eBE9Lz2Jfsvti1kHUrazKUB2pLSiIxcf6vV6SLvqVc/BjbYmcF7nR2jTnuA==
X-Received: by 2002:a63:741:0:b0:3fc:6b3c:f9dd with SMTP id 62-20020a630741000000b003fc6b3cf9ddmr21224601pgh.351.1654530975570;
        Mon, 06 Jun 2022 08:56:15 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090ad34600b001cd4989ff41sm10370086pjx.8.2022.06.06.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:56:14 -0700 (PDT)
Date:   Mon, 6 Jun 2022 09:56:12 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Puranjay Mohan <p-mohan@ti.com>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, rogerq@kernel.org,
        grygorii.strashko@ti.com, vigneshr@ti.com, kishon@ti.com,
        robh@kernel.org
Subject: Re: [PATCH v4 0/6] Introduce PRU remoteproc consumer API
Message-ID: <20220606155612.GA809345@p14s>
References: <20220603121520.13730-1-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603121520.13730-1-p-mohan@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have started to review this set, comments will come over the next few days.  I
will clearly inform you when I am done reviewing.

Thanks,
Mathieu

On Fri, Jun 03, 2022 at 05:45:14PM +0530, Puranjay Mohan wrote:
> This is the v4 of the patch series [1]. The v3 had some comments
> on the DT patch that have been addressed here. The 6th patch in this
> series was missed in the previous versions, so, it has been added now.
> 
> I have posted two more patch series that depend on this series, one to
> the soc tree and another to the networking tree. I had sent all the 3
> series, including this one as RFC [2] to get comments and to explain the
> dependencies.
> 
> The Programmable Real-Time Unit and Industrial Communication Subsystem
> (PRU-ICSS or simply PRUSS) on various TI SoCs consists of dual 32-bit
> RISC cores (Programmable Real-Time Units, or PRUs) for program execution.
> 
> There are 3 foundation components for PRUSS subsystem: the PRUSS platform
> driver, the PRUSS INTC driver and the PRUSS remoteproc driver. All were
> already merged and can be found under:
> 1) drivers/soc/ti/pruss.c
>    Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> 2) drivers/irqchip/irq-pruss-intc.c
>    Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
> 3) drivers/remoteproc/pru_rproc.c
>    Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> 
> The programmable nature of the PRUs provide flexibility to implement custom
> peripheral interfaces, fast real-time responses, or specialized data handling.
> Example of a PRU consumer drivers will be:
>   - Software UART over PRUSS
>   - PRU-ICSS Ethernet EMAC
> 
> In order to make usage of common PRU resources and allow the consumer drivers to
> configure the PRU hardware for specific usage the PRU API is introduced.
> 
> [1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220418104118.12878-1-p-mohan@ti.com/
> [2] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/
> 
> Thanks and Regards,
> Puranjay Mohan
> 
> Roger Quadros (1):
>   remoteproc: pru: Add pru_rproc_set_ctable() function
> 
> Suman Anna (2):
>   dt-bindings: remoteproc: Add PRU consumer bindings
>   remoteproc: pru: Make sysfs entries read-only for PRU client driven
>     boots
> 
> Tero Kristo (3):
>   remoteproc: pru: Add APIs to get and put the PRU cores
>   remoteproc: pru: Configure firmware based on client setup
>   remoteproc: pru: add support for configuring GPMUX based on client
>     setup
> 
>  .../bindings/remoteproc/ti,pru-consumer.yaml  |  69 +++++
>  drivers/remoteproc/pru_rproc.c                | 254 +++++++++++++++++-
>  include/linux/pruss.h                         |  78 ++++++
>  3 files changed, 396 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
>  create mode 100644 include/linux/pruss.h
> 
> -- 
> 2.17.1
> 
