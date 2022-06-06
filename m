Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03BF53EC32
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbiFFQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbiFFQPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:15:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E21158F1D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:15:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h192so6493211pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yc3d6f09An5Iup7HnFnq+YmtnLxXizu7JY/ZtB+fmYU=;
        b=bgidypdYCXahlWg67Jnr4ubl4uJixk0PWYtjDwcs3u5xJE0nvwIFqj7aCjjwNOiMvz
         9L9/vq/xwoEPAh3c1EVJpaJc3qB5EvVqnHlAqc+E1Pb4BoPVwJFeuuLsB8kL0Y5NYxY5
         +u50F+KOlu6kucbAAaG1q3yMKz27idq5V/1qICzsTjPfWVZ7EgTcgipFTw+mjl3KFKq8
         2b9wF1Fbx/jsinj/hE1XcHEW/SqkDw70ZLHnxeAdO5eDdR0DGd3QG5Fbou9J33AI8mrX
         sDURBwJYta4klrPdDpA4c/LylywEHj9RIBnVv6TKLt4/rgbZq5Qbgx0ciWFgtDIW81D3
         Ykrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yc3d6f09An5Iup7HnFnq+YmtnLxXizu7JY/ZtB+fmYU=;
        b=doJr2DKCc51ESG0H6na7aTr+0D+Bf2jTUPtZSa42kIwW4L1YbqGnoAz+AHq++kwCiA
         /lCEZgHvQgMT1YNiQqCIhEC8LcGWYmSqXooTOXc6q4nc3UHAcBQgVUDdi9ZqH1tXYUAz
         RWkBGuMl/cT0scCJKbn3d2BxdrRUcFLMO/tP/PrvjGy9W2S6053eJ/DSsCFGkO4o3h2f
         Crtj9p2/Hq1VxC6pPo8IGTmJCLtVVjtsP0Z60K6WH5zMwMxD21EkA3RFeflXtXYwFLtm
         3Bz4KWxzTVcMj2PbPGFsnYTaMBBa5HVBR7D6wB2yeHFYlbu5kdTTHkNNdwaGUql+dxOY
         H0IA==
X-Gm-Message-State: AOAM531keouHtPmNZcXeC5ncHKwMxuTagDwlfGL5EvUjMa7LsoYbPY+b
        nmv7I5ndE6XaZPPiTsyUpbBksg==
X-Google-Smtp-Source: ABdhPJymBlKeJCj3tvmSxgMQ8W96PwRXnOWJMPIgOzJN40d5L4tl9aO20Ei3Hqzfn1EToQYphbdpOg==
X-Received: by 2002:a63:e905:0:b0:3fa:ec8c:9013 with SMTP id i5-20020a63e905000000b003faec8c9013mr21525731pgh.599.1654532121881;
        Mon, 06 Jun 2022 09:15:21 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s4-20020aa78d44000000b0051c179895a0sm2547571pfe.212.2022.06.06.09.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 09:15:20 -0700 (PDT)
Date:   Mon, 6 Jun 2022 10:15:18 -0600
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
Message-ID: <20220606161518.GB809345@p14s>
References: <20220603121520.13730-1-p-mohan@ti.com>
 <20220606155612.GA809345@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606155612.GA809345@p14s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:56:12AM -0600, Mathieu Poirier wrote:
> I have started to review this set, comments will come over the next few days.  I
> will clearly inform you when I am done reviewing.

This patch is giving me several checkpatch warnings that should have been caught
before sending the patches out to the mailing list.  As such I will not review
this work and seriously considering adding your next revision at the very bottom
of my queue.

> 
> Thanks,
> Mathieu
> 
> On Fri, Jun 03, 2022 at 05:45:14PM +0530, Puranjay Mohan wrote:
> > This is the v4 of the patch series [1]. The v3 had some comments
> > on the DT patch that have been addressed here. The 6th patch in this
> > series was missed in the previous versions, so, it has been added now.
> > 
> > I have posted two more patch series that depend on this series, one to
> > the soc tree and another to the networking tree. I had sent all the 3
> > series, including this one as RFC [2] to get comments and to explain the
> > dependencies.
> > 
> > The Programmable Real-Time Unit and Industrial Communication Subsystem
> > (PRU-ICSS or simply PRUSS) on various TI SoCs consists of dual 32-bit
> > RISC cores (Programmable Real-Time Units, or PRUs) for program execution.
> > 
> > There are 3 foundation components for PRUSS subsystem: the PRUSS platform
> > driver, the PRUSS INTC driver and the PRUSS remoteproc driver. All were
> > already merged and can be found under:
> > 1) drivers/soc/ti/pruss.c
> >    Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> > 2) drivers/irqchip/irq-pruss-intc.c
> >    Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
> > 3) drivers/remoteproc/pru_rproc.c
> >    Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> > 
> > The programmable nature of the PRUs provide flexibility to implement custom
> > peripheral interfaces, fast real-time responses, or specialized data handling.
> > Example of a PRU consumer drivers will be:
> >   - Software UART over PRUSS
> >   - PRU-ICSS Ethernet EMAC
> > 
> > In order to make usage of common PRU resources and allow the consumer drivers to
> > configure the PRU hardware for specific usage the PRU API is introduced.
> > 
> > [1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220418104118.12878-1-p-mohan@ti.com/
> > [2] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/
> > 
> > Thanks and Regards,
> > Puranjay Mohan
> > 
> > Roger Quadros (1):
> >   remoteproc: pru: Add pru_rproc_set_ctable() function
> > 
> > Suman Anna (2):
> >   dt-bindings: remoteproc: Add PRU consumer bindings
> >   remoteproc: pru: Make sysfs entries read-only for PRU client driven
> >     boots
> > 
> > Tero Kristo (3):
> >   remoteproc: pru: Add APIs to get and put the PRU cores
> >   remoteproc: pru: Configure firmware based on client setup
> >   remoteproc: pru: add support for configuring GPMUX based on client
> >     setup
> > 
> >  .../bindings/remoteproc/ti,pru-consumer.yaml  |  69 +++++
> >  drivers/remoteproc/pru_rproc.c                | 254 +++++++++++++++++-
> >  include/linux/pruss.h                         |  78 ++++++
> >  3 files changed, 396 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> >  create mode 100644 include/linux/pruss.h
> > 
> > -- 
> > 2.17.1
> > 
