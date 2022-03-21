Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4F44E1F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 05:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbiCUEmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 00:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiCUEmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:42:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A49047AD9;
        Sun, 20 Mar 2022 21:40:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 6so9487780pgg.0;
        Sun, 20 Mar 2022 21:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mWy+Nn/dpF8v1E/uejsR9Vh11q+4/9Uqdl66Nz5vyjM=;
        b=T6QmrrzUypB3nXB94VGx+6PFzeBtPJi9+Q6KjR8JWcs8hjNtBDlpZbqvP63Oewepgl
         a9BzoWwrliGpjm8La0JmiC7xFXCq4TnUzMG0svQR2h69pZKtjGUrUCq5s4y+qR5u1vuZ
         iFu/QNJxGoqS5tZgoIk8RKg7KO0ggzvYL460wdssIEAlCXRyEKEIt8dvqbn12CW64Gkx
         lj22h9pCnc7LjZT+Naq8V+x9kvWd5I9Iw44rDRiqCAxul98iAwCWged2UwuwuPZio1Qb
         2IHN/03G8CKcl/5gLEm7I6Q/l97+Dd2sGTd33njFZSA5tZCYdm3GxB4aPhVPfs40+Zst
         Oe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mWy+Nn/dpF8v1E/uejsR9Vh11q+4/9Uqdl66Nz5vyjM=;
        b=x+XS4jlJvwlSwHkXWuNkiu6FgokEa+D3orOS5HE/IIzYVtp0mXf8J61ff8oUmdOclb
         x6D4XkJJsuVoUGBK01I/FmJ3p/CrKAtb27zj8R+SB2KdVVeQ0135pPQZ2tWD8f5Xjscq
         uOykwqx1uEBvaYSL5Re8BxdXiB+J2quAXressu8xcGII8vLabLnN9xwxGuqBCwI+dtHi
         h60vvsDsF4KknCJ6Yx11oie/Zi1LXEcBxt85Mx2kWEfa7tmSNTLKeNL6X6jMoO5Hf1To
         353r5Q56XM1gTHvUaUnrwW4wUojiWd9HZiHi8agbt8dl2L1eGoYDwFr/M8iIc7FgSKXn
         0Mqw==
X-Gm-Message-State: AOAM533x790NfJ7KI4UQAeLZUdumLmEGJdEmV9TjQXFbYWl6sLvmEmAZ
        hlPiZONHsBCrY4pmg5/vbDCMWmFnvPk=
X-Google-Smtp-Source: ABdhPJwi4DFefw3qAwd2mQw/fFT7L6PGR5jCrgPeG1K0RvLr8xTACPpIYhFnxP0vdDPBYsp3uXv2Ew==
X-Received: by 2002:a63:2d07:0:b0:381:e49:ae0c with SMTP id t7-20020a632d07000000b003810e49ae0cmr16531805pgt.261.1647837647338;
        Sun, 20 Mar 2022 21:40:47 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:31f6:c8f1:6f10:b2ec])
        by smtp.gmail.com with ESMTPSA id y3-20020a056a00190300b004fa2411bb92sm17663825pfi.93.2022.03.20.21.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 21:40:46 -0700 (PDT)
Date:   Sun, 20 Mar 2022 21:40:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED] input: ads7846: touchscreen broken on Nokia 770
Message-ID: <YjgBzDzHuZMlI05j@google.com>
References: <20220227185038.GA3016@darkstar.musicnaut.iki.fi>
 <20220319151346.GE1986@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319151346.GE1986@darkstar.musicnaut.iki.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaro,

On Sat, Mar 19, 2022 at 05:13:46PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Sun, Feb 27, 2022 at 08:50:39PM +0200, Aaro Koskinen wrote:
> > I noticed touchscreen does not work anymore on Nokia 770:
> > 
> > [    2.131011] ads7846 spi2.0: touchscreen, irq 175
> > [    2.200622] input: ADS7846 Touchscreen as /devices/platform/omap_uwire/spi_master/spi2/spi2.0/input/input0
> > 
> > (then touching the screen:)
> > 
> > [   52.316894] ads7846 spi2.0: spi_sync --> -22
> > [   52.336944] ads7846 spi2.0: spi_sync --> -22
> > 
> > bisected this to:
> > 
> > commit 9c9509717b53e701469493a8d87ed42c7d782502
> > Author: Oleksij Rempel <o.rempel@pengutronix.de>
> > Date:   Wed Nov 11 16:39:05 2020 -0800
> > 
> >     Input: ads7846 - convert to full duplex
> > 
> > It seems it's failing on SPI_CONTROLLER_HALF_DUPLEX check in
> > __spi_validate(). The controller used on this board (spi-omap-uwire)
> > sets that flag. How ads7846 is now supposed to work in that case after
> > this conversion?
> 
> Any comments?
> 
> The touchscreen works after reverting the following patches:
> 
> 6965eece2a89 ("Input: ads7846 - convert to one message")
> 9c9509717b53 ("Input: ads7846 - convert to full duplex")

I do not believe we should simply revert the patches as that would
penalize systems with nicer hardware, so my preference would be to see
if we could support half duplex controllers within the new driver
structure.

Thanks.

-- 
Dmitry
