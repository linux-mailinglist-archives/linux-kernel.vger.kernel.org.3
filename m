Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F584FC5F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiDKUns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiDKUni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:43:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67FA1F631;
        Mon, 11 Apr 2022 13:41:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z17so4228322lfj.11;
        Mon, 11 Apr 2022 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1gQ3z+BhhKGcjrgp8oYTkSEsVVH9e6uCruEWyVWuLDk=;
        b=KGvGoxkAai3YdPCf6J8ylwmmzoKN/4KJ0fd660wNO1E8YuqnJ5u7ixpuchkmZ9jXpo
         TuOHV5KPjGWbTryqHKpIyTW3Ywrra62lhriWDbnye6Y8ot6qn9SQEQ1LtRu5Hnavs5Wc
         EPTFfMhFQvdKd0fVQSHP6xeXSbyaDFBKuM0zrdSWucNd+njL/p1/lx03ms/O2CS48owj
         whtUjO9IVjn65pWFs7Ngrifik3/26Aby1kk/4d3hMtZsV93jH08xvj5talaTy8X7ZVJm
         0w56oJLN0ei9JeLTHkW02Ee+oo/cSikX9Xcq6jLk56DUVpmuFkAnP3dR1CkOLLpChF4/
         mPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1gQ3z+BhhKGcjrgp8oYTkSEsVVH9e6uCruEWyVWuLDk=;
        b=Kazcp0Ts7XAzliGaIiOUnOkXlOqu1yo0rOBPr8JpkfvGhQ9umUtLp5g7qX85gYTf5t
         wh1GjlaHKLlmppxwFoYGlBKPjcc9yWx+3NTOVCQ1q1oENI6T2L093PgU5FYHs7fXk8+f
         Wj4o6jyIOm43vID5a++BQEKMa6YSMCIQFJi+oS6JupCHx+75Z7BfJpsJIW7EUky7ArgA
         wWEy98lMpgJHAa0Hrl6h1VMZbm6w/bbU7jRcXPQy55Oqt8/2YPpGSxwRQuELyXfPg07U
         2eJ/Mo2q7T9EAvL4JeFWGwwp6Gv6FyyPkzi7TumTauDpaJWyZBW3AtnzpDvYPzlcxg4o
         4MrA==
X-Gm-Message-State: AOAM532azmMo5Iij7VZfPpsJlPZ4ChHgAu3v2Sjr1wPbYrc6ki5g0pCO
        DpIrMmHG2qhUMjfWFBg4MpY=
X-Google-Smtp-Source: ABdhPJxCT4oSwEFg2z3xchisbOKP8+rLAA/Ix8AGceakbsSbPn+SZIqRgPafN2c5Ev4CIN7AoCn80A==
X-Received: by 2002:a05:6512:1192:b0:45d:9701:ad1 with SMTP id g18-20020a056512119200b0045d97010ad1mr22964342lfr.391.1649709680960;
        Mon, 11 Apr 2022 13:41:20 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id y14-20020a056512044e00b0046bb2c987d4sm148654lfk.98.2022.04.11.13.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:41:20 -0700 (PDT)
Date:   Mon, 11 Apr 2022 23:41:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 17/21] ata: ahci: Add DWC AHCI SATA controller support
Message-ID: <20220411204118.tfagojpcugz4gksj@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-18-Sergey.Semin@baikalelectronics.ru>
 <2f873143-eb45-e652-063d-615d63055401@opensource.wdc.com>
 <20220411124126.wnfykivcvtllyua6@mobilestation>
 <382133db-7a90-6092-d3cc-3c4f5d851838@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382133db-7a90-6092-d3cc-3c4f5d851838@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:03:27PM +0900, Damien Le Moal wrote:
> On 4/11/22 21:41, Serge Semin wrote:
> > I beg your pardon what convention? Is it defined in someplace of the
> > subsystem docs? If it's not then how should I know about that? These
> > are the device-specific macro. The static methods below are also
> > platform-specific and the standard kernel coding style doesn't specify
> > any rule about that. Moreover the most of the AHCI glue drivers (LLDD
> > like ahci_mtk.c, ahci_ceva.c, ahci_brcm.c, ahci_st.c, ahci_tegra.c,
> > ahci_xgene.c, etc) use the same prefixing style as I do here. Finally
> > the prefix reflects the actual device name "DWC AHCI". So if there is
> > no subsystem-specific restrictions I normally define the prefix in
> > that order for the sake of the clarity.
> 

> Look at how other ahci drivers have named things. That's the "convention"
> I am talking about. Most of them name things ahci_xxx_... Same for macros.

Looked. Way not the most of them. Here are the other drivers with the
naming like I used in this patch:
ahci_mtk.c, ahci_ceva.c, ahci_brcm.c, ahci_st.c, ahci_tegra.c,
ahci_xgene.c, ahci_imx.c, etc.
That's almost half of all the AHCI drivers. Really how could I have
possibly figure out that there is a convention if so many drivers
don't have it followed?..

> 
> > 
> > Note I don't mind to convert the code to being the way you ask, but if
> > it's really the AHCI-specific codying style convention then it would be
> > very useful to have it described/advertised in some place in the
> > kernel so to know about that beforehead for the developers reference.
> > So do you insist on switching the words order in the names prefix here?
> 

> It is nice to have code consistency in the naming. That always facilitate
> grepping the code.

I am with both my hands for it, but that naming consistency must be
thoroughly documented in some place of the kernel or at least the
"convention" must be logically derivable from the existing code. It
would spare my, the other developers and actually the maintainers
time. Do you suggest to thoroughly scan each AHCI driver in the
subsystem to figure it out? Even if I did that the only way to come up
with an idea that there is a naming convention would be only if I
expected that there is one, but seeing it's a first time I've met such
LLDD requirement (really, no kernel subsystem has such naming
convention applied for the glue-drivers) and almost half of the AHCI
drivers not following the convention while the other half following it
just partly. Judging by that, neither me nor many other developer had
a chance to create an acceptable code from scratch.

-Sergey

> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
