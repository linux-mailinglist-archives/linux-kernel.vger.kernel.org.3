Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994074F17D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378351AbiDDPE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiDDPE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:04:27 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB42F394;
        Mon,  4 Apr 2022 08:02:31 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-de3ca1efbaso10949415fac.9;
        Mon, 04 Apr 2022 08:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vtiMNVEoYZXoi1GNMLStyUsaBQPuI1mPKxVFdAdwSEw=;
        b=Pslnr2ImvM3WVLnIlH47MEGJQwwh9NiO3rUvbwwq5gDTSH2LqKY3ju8kzN4fHH0SFU
         fn+hkuuVC0ag9sAJhUKY8/iVcUBeT6B03aNwRUudfILoFUqvCe27TbtoaiI+42YFImtL
         8rnE/26J/Fpj4bq3nvsQjm13kY/o9H+G0W8V86L20/lCS1YOt2X0V8pGKR13B5Z3Bbu0
         1Agil9VVdyL0clKi9Sd2rrCcn0MGviWDFIyp4nftBFnJ7tfjLrSDkwdIw8nSqeIhOuzY
         dLIDNhYkGsMVpROMae82yqpVzC3Bo8K+JLLr/GhWmOn/jSJ/efcZQoEGSlhh8izKkgD2
         hKUg==
X-Gm-Message-State: AOAM532m59xHdWqE29Z3DA9C9qbZYp5pre3YbyH+Aspd+g3Te4dKZsOz
        DsjwOt+w2gdsn0t2FjCh8w==
X-Google-Smtp-Source: ABdhPJxE84xSZeC7rzs41J9r830YaWpOHzkIguHr+Y1O8sOgXGMHMwvgtdOZDcMpMkcvMM7Alx9j8w==
X-Received: by 2002:a05:6870:f109:b0:da:b3f:2b4c with SMTP id k9-20020a056870f10900b000da0b3f2b4cmr11024410oac.235.1649084550501;
        Mon, 04 Apr 2022 08:02:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bm51-20020a0568081ab300b002da5c44e0bdsm4200166oib.28.2022.04.04.08.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 08:02:30 -0700 (PDT)
Received: (nullmailer pid 1321618 invoked by uid 1000);
        Mon, 04 Apr 2022 15:02:29 -0000
Date:   Mon, 4 Apr 2022 10:02:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Message-ID: <YksIhWQIUHsoWEMi@robh.at.kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <5eed58a1-ee56-8aee-e73b-76b162d59873@kernel.org>
 <35f5fdbf-faac-457b-a225-35d7141f6b2e@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f5fdbf-faac-457b-a225-35d7141f6b2e@www.fastmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 03:51:46PM +0200, Sven Peter wrote:
> On Wed, Mar 23, 2022, at 12:19, Krzysztof Kozlowski wrote:
> > On 21/03/2022 17:50, Sven Peter wrote:
> >> Apple SoCs such as the M1 come with multiple embedded co-processors
> >> running proprietary firmware. Communication with those is established
> >> over a simple mailbox using the RTKit IPC protocol.
> >> 
> >> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> >> ---
> >>  drivers/soc/apple/Kconfig          |  13 +
> >>  drivers/soc/apple/Makefile         |   3 +
> >>  drivers/soc/apple/rtkit-crashlog.c | 147 +++++
> >>  drivers/soc/apple/rtkit-internal.h |  76 +++
> >>  drivers/soc/apple/rtkit.c          | 842 +++++++++++++++++++++++++++++
> >>  include/linux/soc/apple/rtkit.h    | 203 +++++++
> >>  6 files changed, 1284 insertions(+)
> >
> > Isn't this some implementation of a mailbox? If so, it should be in
> > drivers/mailbox. Please don't put all stuff in soc/apple, that's not how
> > Linux is organized. To drivers/soc usually we put drivers which do not
> > fit regular subsystems.
> >
> 
> I put this into soc/apple because I don't think it fits within the mailbox
> framework very well.
> (It actually uses the mailbox framework for the actual communication
> with the hardware with a driver that's already upstream.)
> 
> Essentially, the mailbox subsystem provides a common API to send and
> receive messages over indepedent hardware channels and devicetree bindings
> to describe the relationship between those channels and other drivers.
> 
> One of the features that doesn't really fit is that we need to be able
> to start, shutdown and re-start these co-processors. The NVMe driver

remoteproc does that. Did you look at it? Most remoteproc drivers use 
some combination of mailboxes and shared memory.

Rob
