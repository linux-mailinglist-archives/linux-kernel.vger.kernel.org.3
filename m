Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D28513A04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350190AbiD1Qmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350180AbiD1Qmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:42:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9927EB1A9E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:39:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z16so4716939pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OishM2Ohmr+kYlQe5SkAz9BtPZkoomlu7LPNGSJ2ClE=;
        b=u7nZKZDVays2QDNH2VtzL6JzqCxQtKmVJ05vA0Qh15RfF/RKoywYKbo7R1AwwL5O2r
         RtK4G5Gu/OGthZt5qS1XjTsc/lYACRzGRicoMEFJx/lg2/KHeeZC2MTFXx7hczWqMDLq
         htvFsJ71K8lh9Y8lyOxUTkqxEsxf//IUxZpjV/kCwm+STjttxOrBNRjIw5NOQ2qJo9N5
         sMQF4Fu9bovWCEKv1aUlrpcVL9RHEi6gvJWH772VhND6FcKXn90NLh3KdpttZqLK2/l4
         99k0nEE7+toZmQ31nY7l/D2x+Rh7YcWAEnRecD6urFxMriP/tDi0y3nEq+kh21zTgR0o
         IWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OishM2Ohmr+kYlQe5SkAz9BtPZkoomlu7LPNGSJ2ClE=;
        b=OnCdY6oAw8HQd5locoFdS/1oVV7czLYRYK53NLAPUZf9IQcl7CBJE8IrPru7gmOq5L
         /JMqNNrxUx8SSt9g1NNY9dR4rzhc5EyFMi9Uw9fFdUbm7efGT208EpZCeFt4qDnRVSsI
         b3+pYBKRCCRUj3OmqAnk/rHwyGwygq/yTaPPeRO75MVqQE3RMVpoFdt9V1sBUHQKcuLq
         w+MUfigKZInrbvTR9KU7R3bd9f7l1R9hDXH8hGCUt9tuwH8/mCh00f3qR+yOq5SHTqg/
         0qLCip6ykDsjZiLzd4WN7HvK+Xsxu2Uk10wkd3UUHvh7/J+8JkND2AldFyijINcGiYPe
         3HPA==
X-Gm-Message-State: AOAM533xp4lw6zgevwMqiN++zbcbsF3s6OgqbouyGYqnNwDlVGAJIymz
        VCLhGGd1gNfGuyNAoAW6HbkcFw==
X-Google-Smtp-Source: ABdhPJxv7MgFSCKX0HWae5LBmuz7wGHf99NMnYXbPhBmDm04njRi6iJzRU1xUs9aliBZiu+ID7N7ag==
X-Received: by 2002:a05:6a00:e0e:b0:50a:cb86:883c with SMTP id bq14-20020a056a000e0e00b0050acb86883cmr35844844pfb.11.1651163970098;
        Thu, 28 Apr 2022 09:39:30 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p64-20020a622943000000b004fdd5c07d0bsm330301pfp.63.2022.04.28.09.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:39:29 -0700 (PDT)
Date:   Thu, 28 Apr 2022 10:39:26 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Puranjay Mohan <p-mohan@ti.com>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, rogerq@kernel.org,
        grygorii.strashko@ti.com, vigneshr@ti.com, kishon@ti.com
Subject: Re: [PATCH v3 0/5] Introduce PRU remoteproc consumer API
Message-ID: <20220428163926.GA2265266@p14s>
References: <20220418104118.12878-1-p-mohan@ti.com>
 <ee1c1601-6db9-70d7-401a-8f67ec406ffc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee1c1601-6db9-70d7-401a-8f67ec406ffc@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 04:53:22PM +0530, Puranjay Mohan wrote:
> Hi Bjorn,
> Hi Mathieu,
> 
> I am writing to follow up on this patch series.
> This has been on the list for the last 10 days and I have not received
> any comments on it. So, does this look good to everyone?
>

10 days - Euh!

Just to put things in perspective, I am currently reviewing patches that have
been sent around March 16th.

> I had solved the minor checkpatch issues from v2 so I guess this series
> should be good now?
> 
> Looking forward to your comments.
> 
> Thanks
> Puranjay Mohan
> 
> On 18/04/22 16:11, Puranjay Mohan wrote:
> > This is the v3 of the patch series [1]. The v2 had some minor comments
> > which have been addressed here.
> > 
> > I will be posting two more patch series which depend on this series, one to
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
> > [1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20201216165239.2744-1-grzegorz.jaszczyk@linaro.org/
> > [2] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/
> > 
> > Thanks,
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
> > Tero Kristo (2):
> >   remoteproc: pru: Add APIs to get and put the PRU cores
> >   remoteproc: pru: Configure firmware based on client setup
> > 
> >  .../bindings/remoteproc/ti,pru-consumer.yaml  |  70 ++++++
> >  drivers/remoteproc/pru_rproc.c                | 234 +++++++++++++++++-
> >  include/linux/pruss.h                         |  78 ++++++
> >  3 files changed, 377 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> >  create mode 100644 include/linux/pruss.h
> > 
