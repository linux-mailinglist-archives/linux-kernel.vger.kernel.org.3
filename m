Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078D048642E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiAFMQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbiAFMQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:16:10 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5290CC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 04:16:10 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so8277266pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 04:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ezhOL9IQmLkdhn7bT2hYUZscONiXzj3Zulc4AqaqV74=;
        b=VWuYcofoSfJWAV4N8jaIG1D93UCOzzLF4pnjMZckQdHuwfgaz+x204qWdN4QF4YoRD
         jjXdv6nQCa0cdQvhgmsH706TQG5JQqC2UipfolVHtapLb6VJ6mjx3mvAMAvJ9Ooi5nB6
         CRsCNuUmRVJtehrSnmYuebPoAmJSgHGuYmCNi47cAYBd27WmmUPIrHfBja4EQVUVAYvE
         xHEMWdoc093Hihp5ksbATTC/pSlSafiFyvDCnDXh1YrfV/2OCzLMdP60JaQ0C2aNaVkj
         tim9w33+IK49XDuWb+ftGMo9xZMAsOF+xNjlHqYS+VRwvF0me3YYKY1Vt79vdnY/4VeR
         RXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezhOL9IQmLkdhn7bT2hYUZscONiXzj3Zulc4AqaqV74=;
        b=Culg7lFyMKDcs8HuFmsqvCSAlrFMKxrfPrWzWgKwmM+rv6F1KlAzESfzhEncBrV6Dk
         PQ4bPiciWc8pdxyyOZeYJ44KXHpaL5b8DFyRXg5eBlHEF75MhbOucu374w/MKbWybmiv
         9XCzvoy4Aho5p0O/SPTyR6Xk0PG28EXNzmqAAlrJh+21LUu73wZ+lDgrizG7slep0ipe
         6FXzhQmkT9Jcw7zjnjQOcnkExlC9VfY5JpVo9rcPwbDdr5zsoN5L+O68XmtIectWfvwh
         QaIlOCUqd61wkM9dWmIFtxGZTs5huqZkRkBpwwF81ud0dTrjP2syOoz3WiRJ82K5ZknE
         GacA==
X-Gm-Message-State: AOAM531JHOyjCDm9+5oWr/Hrx4863R4WAZr1u1WN2A5jUZYJUGJI2PU5
        QuwE+AhK0m08oTcvyLSOz6s=
X-Google-Smtp-Source: ABdhPJzV2qd7Kyc2ZIOHuzuuD3AFWMO67x7jgDMNj2Z9+hCizMBZuXOekzZfGXgf9RDEl+VUGs7ztA==
X-Received: by 2002:a17:90b:4f4a:: with SMTP id pj10mr9731709pjb.112.1641471369839;
        Thu, 06 Jan 2022 04:16:09 -0800 (PST)
Received: from 8345e2a12d0c ([159.226.95.43])
        by smtp.gmail.com with ESMTPSA id b5sm2401828pfm.155.2022.01.06.04.16.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jan 2022 04:16:09 -0800 (PST)
Date:   Thu, 6 Jan 2022 12:16:05 +0000
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-phy@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] phy: mediatek: Fix missing check in mtk_mipi_tx_probe
Message-ID: <20220106121524.GA25165@8345e2a12d0c>
References: <20211224082103.7658-1-linmq006@gmail.com>
 <CAAOTY_-7-BrnkPk_5V5y20F6fX3X8Vm0tcYAA=1DNCnxjvNF8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAOTY_-7-BrnkPk_5V5y20F6fX3X8Vm0tcYAA=1DNCnxjvNF8A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chun-Kuang:

On Fri, Dec 31, 2021 at 12:31:33AM +0800, Chun-Kuang Hu wrote:
> > diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> > index 28ad9403c441..67b005d5b9e3 100644
> > --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> > +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> > @@ -146,6 +146,8 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
> >                 return -ENOMEM;
> >
> >         mipi_tx->driver_data = of_device_get_match_data(dev);
> > +       if (!mipi_tx->driver_data)
> 
> I'm confused. mtk_mipi_tx_probe() is called because this device node's
> compatible match one in mtk_mipi_tx_match[]. So I think the return
> value of of_device_get_match_data(dev) would not be NULL. If this is
> true, this checking is redundant.
>
I think your are right, this checking is redundant. Thanks for your
reply.

Regards,
Miaoqian.
