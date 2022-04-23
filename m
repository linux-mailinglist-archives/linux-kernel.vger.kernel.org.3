Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3750450CB6A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiDWOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDWOsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:48:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06DEE80
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:45:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q3so17164598plg.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5FxqibB6lrBSfM5RHY6cGUOYEFPWbPTw3YyYjEAfbQ=;
        b=xJuYvvFIBtH1IeO79+DHJTgR1fwDmXMJ41EyXP3EY6AKpSoHPPHtsbZQUmhfTSBTlj
         e1+ZHJX7cE8KjIRNvLfX7w+ZUPtgepCCONWQBQ8MPXz9XW+5lASpekk8JW3/IOA+SlpS
         QH2GYdwGRceYdLmx7bUwqv8uJyLSr9y6EMwcm2KQLJusjyAd4mljavIGft4JXw7u6FHP
         391iP934qJ0sgBrPXFNqJHdDDp0MiIZECD+28BY6f7N0eVzfYY/teI+Z096jf/rDdL6e
         hSY2bB/gRYRGEP+bXDZfftaljJOzrazc5Oo6aXRLLloomhxUP/w1GqmB6whe5k1T8Jpm
         Zirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5FxqibB6lrBSfM5RHY6cGUOYEFPWbPTw3YyYjEAfbQ=;
        b=mi4NOM5MuBwm4fLDNIhmjDZTZQNcdlfIGsoYotAxdhchv+6A9d1EIIUYWMXAj/bXrw
         Jh3XbtnSV2Qs/qhfeovKzodr2zrdWt2/DqkLcPW3rmjBqM5iUl6be/x/2N2T8cuUT3uq
         TjKX1UXZPwtNmWmT8Q92nkdqlawKzhz6bOK9J2u7YxUVxXFmG/xdFQzQfIGdKWaqJdcn
         CknwwsccT/0I5WEYHd72Ei/4I4hk5DyNqM3VH+OmipLovtcrCPpbKHHulndhEgDaAXbm
         9mu6gWt8blVrfnAupWdmhOTXk0QdHJmZN2fpjD+Wul1gfUIKQo5N/Uj+Xwe84NoL0kiT
         2TIg==
X-Gm-Message-State: AOAM530YNHOxWf6Hngl12fllvcA4RGQJO+RL7/9FR2ToBXcFWt5nHN2z
        RhSP/Vmdy9mbLhlNhmIOalKP
X-Google-Smtp-Source: ABdhPJzkITaG3M4Hac9FG/Ta+tKPeSf3Xn02HSElnQKPpvX4qD4a7NHj5NfpTV52Ictebf4+9pwF9Q==
X-Received: by 2002:a17:903:31d1:b0:159:804:e852 with SMTP id v17-20020a17090331d100b001590804e852mr9419855ple.19.1650725111227;
        Sat, 23 Apr 2022 07:45:11 -0700 (PDT)
Received: from thinkpad ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id x36-20020a634a24000000b0039cc6fff510sm5089396pga.58.2022.04.23.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 07:45:10 -0700 (PDT)
Date:   Sat, 23 Apr 2022 20:15:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/25] dmaengine: dw-edma: Skip cleanup procedure if no
 private data found
Message-ID: <20220423144502.GS374560@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-25-Sergey.Semin@baikalelectronics.ru>
 <20220325181503.GB12218@thinkpad>
 <20220418134833.awogzzfq745mc5dm@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418134833.awogzzfq745mc5dm@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 04:48:33PM +0300, Serge Semin wrote:
> On Fri, Mar 25, 2022 at 11:45:03PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Mar 24, 2022 at 04:48:35AM +0300, Serge Semin wrote:
> > > DW eDMA driver private data is preserved in the passed DW eDMA chip info
> > > structure. If either probe procedure failed or for some reason the passed
> > > info object doesn't have private data pointer initialized we need to halt
> > > the DMA device cleanup procedure in order to prevent possible system
> > > crashes.
> > > 
> > 
> 
> > How come remove() could happen when probe() failed? If you hit this issue then
> > something else is utterly going wrong.
> 
> It fully depends on the DW eDMA client driver implementation, which
> can't and in general shouldn't be guessed. But what must be done in
> the DW eDMA driver is a protection against the invalid data being
> passed to the exported API methods. That wrong situation must be
> detected and handled in the API user code. It's much easier to do by
> having an error code returned from the dw_edma_remove() method than
> catching random system crashes.
> 

Even though I don't see any practical issue, I'm fine with this.

Thanks,
Mani

> -Sergey
> 
> > 
> > Thanks,
> > Mani
> > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index ca5cd7c99571..b932682a8ba8 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -1030,6 +1030,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> > >  	struct dw_edma *dw = chip->dw;
> > >  	int i;
> > >  
> > > +	/* Skip removal if no private data found */
> > > +	if (!dw)
> > > +		return -ENODEV;
> > > +
> > >  	/* Disable eDMA */
> > >  	dw_edma_v0_core_off(dw);
> > >  
> > > -- 
> > > 2.35.1
> > > 
