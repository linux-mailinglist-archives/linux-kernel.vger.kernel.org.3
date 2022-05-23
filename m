Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892C7530A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiEWHVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiEWHUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:20:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A38838D85
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:12:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h5so18788270wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fAuZ4KWtArpOp/u3Q10ahbTyWqMsYIHTeZ+AhWJCC4s=;
        b=PBjGsAL7D/rHVMJ2GU9NO4tWWynQwJbPfMF50qZ0Db3cPVndJEEOoCr48lA6LecE36
         ASwQHTeB++MaNemZdWuIgkNmpEG2QvIH8U62eocdoEqYvwChgqqr0KUYgX/s4XYMF+hD
         WKP/0kyNYwENTH/gl8YbyV1jMcxJW4ie2V0FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fAuZ4KWtArpOp/u3Q10ahbTyWqMsYIHTeZ+AhWJCC4s=;
        b=FzwrP4pTmSOjcoDI3a9DMZWnD+taLmrsbiKUbnmbnyTjDOZUDQBF0jJMp2g0RZa0p9
         yQknqQiW922uifyABVRA0KwU9cnllrruxuZZbY/Etln/nBYV9PnZ1u/Tsudl5HlE1h72
         VTN6dmaZqAZMmuIKyWnyFhmdLPtLCzkeA0Swk1z7ClOMcmBINEZMOs1cJDGbt2get8wE
         lK69PIEfYbDUHMrg89yq0f+K9+ukHY391zpUMeP1K1RE+ywtcNLZAJtAptgLosJ7fo+u
         m8iaBbotZwnaWqnQbRSsFsinhpOQwT35lRoA1SfuJ+YXDYzMHYS1kR2RvGpReIBYUSoI
         j4cw==
X-Gm-Message-State: AOAM531Hqm6XusEuuw8YHal5rizB1hyh+prarIdL1Uh5ul6sL2VHUMPt
        v9x/+lONbZ+YhjXiTMBxJ5fIP5WAM8/7Yg==
X-Google-Smtp-Source: ABdhPJzibI07tOlMfXLYH6ysXjFHXEiH4tfkSQDT7MMA4tQ1XaDhwxfksJeLIeSCM7aqNhJgSivFpg==
X-Received: by 2002:adf:f102:0:b0:20d:8d:870e with SMTP id r2-20020adff102000000b0020d008d870emr18178986wro.292.1653289076862;
        Sun, 22 May 2022 23:57:56 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-53-154.cust.vodafonedsl.it. [188.217.53.154])
        by smtp.gmail.com with ESMTPSA id g24-20020adfa498000000b0020c5253d90csm9159068wrb.88.2022.05.22.23.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:57:56 -0700 (PDT)
Date:   Mon, 23 May 2022 08:57:54 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     michael@amarulasolutions.com, alberto.bianchi@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: phy: DP83822: enable rgmii mode if
 phy_interface_is_rgmii
Message-ID: <20220523065754.GJ1589864@tom-ThinkPad-T14s-Gen-2i>
References: <20220520235846.1919954-1-tommaso.merciai@amarulasolutions.com>
 <YokxxlyFTJZ8c+5y@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YokxxlyFTJZ8c+5y@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 08:39:02PM +0200, Andrew Lunn wrote:
> On Sat, May 21, 2022 at 01:58:46AM +0200, Tommaso Merciai wrote:
> > RGMII mode can be enable from dp83822 straps, and also writing bit 9
> > of register 0x17 - RMII and Status Register (RCSR).
> > When phy_interface_is_rgmii rgmii mode must be enabled, same for
> > contrary, this prevents malconfigurations of hw straps
> > 
> > References:
> >  - https://www.ti.com/lit/gpn/dp83822i p66
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Suggested-by: Alberto Bianchi <alberto.bianchi@amarulasolutions.com>
> > Tested-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> If you want to, you could go further. If bit 9 is clear, bit 5 defines
> the mode, either RMII or MII. There are interface modes defined for
> these, so you could get bit 5 as well.

Hi Andrew,
Thanks for the review and for your time.
I'll try to go further, like you suggest :)

Regards,
Tommaso

> 
>     Andrew

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
