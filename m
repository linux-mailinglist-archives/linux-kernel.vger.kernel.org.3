Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAA3571952
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiGLL74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiGLL71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:59:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E2587F68;
        Tue, 12 Jul 2022 04:59:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bu42so13607750lfb.0;
        Tue, 12 Jul 2022 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KZ3KYMTVveHo2jJXRt9lg02K2HAgxM3VDqKDTiz5L5I=;
        b=f4WI/5p+hFmynH5Occ846McURQkcxkHB4J3bqBpiJfC465TR9kctYpctRlCNmUXucc
         0JcBPKmqgTTFHJ2KGH4H4l+jEUUpHQZDOI90HDkVOVzV3R6F+1gzKEx5m/JnHLbIloPs
         GeSj5k37Ep6g7cwDCW5L6aM6AFFUvY7XMr7c5SB1Tt6sBYmUiOrJJUrYvelxAoR5ERc3
         h2K7VjWYttoB96xFjr9dW9txnDbuRY4JBLNxYrjXqpewHPd5ljBrAFVE7xP6xa7RebWY
         qcDk+RmwoJjGmwL9LJAYqbPEgsYkicRgj1p8tdiHFzhjiIbvstm+JixNlLwl7dzwfrLu
         Sx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KZ3KYMTVveHo2jJXRt9lg02K2HAgxM3VDqKDTiz5L5I=;
        b=B6JKlZWv3DRdUMZhaiESwPIr4Ae9fevztkZqjXVH6t+FtLTevhcPojfF0BxSZl0yvK
         R0LGMgCx1A7Ou32U5nm4YjfILfCVFAVID0PHWWgOkMaZ63rBgTNZZh+VMvOfSH9L2Aty
         g030OMngv9MbBaFeBi/Ak5CHBTe9Ims+19TvwnTtdx3xI3t9JkzXpEHvbVFjGVBsyXZi
         +OQpvsuNs/AZju4wBt/eZM6tqDexyHdP37FWQjarTUwyzBTGAOWfyjWF03pZ0joE2FBY
         48QRwqFCJvNco1ahI6AgNmHf9xnYoOdmZj7BSYvlv3CelC/uo8CYwRPjDH1U02udCbvj
         Xksw==
X-Gm-Message-State: AJIora8yKTNjO03mKZ/WL0BFDn98auyn6cmznm9YQ6Nt9zHih1IiMIAl
        wI2N+UwrlRGEe+YHG3LBewE=
X-Google-Smtp-Source: AGRyM1uxGzrwOXK7F+VLwKbnuNSNO/dZWDvqwZ4Xyy1lLukXMCfbiEcxHbkrYomd6t3kf8k1QNJ65Q==
X-Received: by 2002:a05:6512:2823:b0:485:6312:2a07 with SMTP id cf35-20020a056512282300b0048563122a07mr14636413lfb.525.1657627153506;
        Tue, 12 Jul 2022 04:59:13 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id f2-20020ac24982000000b00489c5e840d4sm2137853lfl.227.2022.07.12.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:59:13 -0700 (PDT)
Date:   Tue, 12 Jul 2022 14:59:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/7] clk: baikal-t1: Move reset-controls code into a
 dedicated module
Message-ID: <20220712115911.jbmkikaugpvtdt65@mobilestation>
References: <20220711154433.15415-1-Sergey.Semin@baikalelectronics.ru>
 <20220711154433.15415-6-Sergey.Semin@baikalelectronics.ru>
 <af5f882f-e7f8-ca49-020d-0dab3f2cc145@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5f882f-e7f8-ca49-020d-0dab3f2cc145@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 02:39:51PM -0700, Randy Dunlap wrote:
> 
> 
> On 7/11/22 08:44, Serge Semin wrote:
> > diff --git a/drivers/clk/baikal-t1/Kconfig b/drivers/clk/baikal-t1/Kconfig
> > index 03102f1094bc..56a4ff1d8bf0 100644
> > --- a/drivers/clk/baikal-t1/Kconfig
> > +++ b/drivers/clk/baikal-t1/Kconfig
> > @@ -29,7 +29,6 @@ config CLK_BT1_CCU_PLL
> >  
> >  config CLK_BT1_CCU_DIV
> >  	bool "Baikal-T1 CCU Dividers support"
> > -	select RESET_CONTROLLER
> >  	select MFD_SYSCON
> >  	default MIPS_BAIKAL_T1
> >  	help
> > @@ -39,4 +38,15 @@ config CLK_BT1_CCU_DIV
> >  	  either gateable or ungateable. Some of the CCU dividers can be as well
> >  	  used to reset the domains they're supplying clock to.
> >  
> > +config CLK_BT1_CCU_RST
> > +	bool "Baikal-T1 CCU Resets support"
> > +	select RESET_CONTROLLER
> > +	select MFD_SYSCON
> > +	default MIPS_BAIKAL_T1
> > +	help
> > +	  Enable this to support the CCU reset blocks responsible for the
> > +	  AXI-bus and some subsystems reset. These are mainly the
> > +	  sef-deasserted reset controls but there are several lines which
> 

> 	  self-deasserted
> ?

Right. Thanks.

-Serge(y)

> 
> > +	  can be directly asserted/de-asserted (PCIe and DDR sub-domains).
> 
> -- 
> ~Randy
