Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D41D4E9CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbiC1Q4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbiC1Q4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486AD4C41F;
        Mon, 28 Mar 2022 09:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D670F6138B;
        Mon, 28 Mar 2022 16:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDA9C004DD;
        Mon, 28 Mar 2022 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648486476;
        bh=wecLqM+6wj4MYjctE+l0MU6HzWzPoE6xPZCJaeMiP3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fd+1Rpszy2FjIs8nnvc5MeP6yn3XiSkzp93oaGnmP1bFHDXzcyLqrdUFCqSm+mSlI
         NXy5WWoUDcK9brEOVznVNkzMCoHi1XwLZEX81TgbUCWCyHt4pSxCVZiNkavXqRzeBM
         wePrLbbEks2hzJSHnb5+pZ46iByE/M1WGu1ElITYrl7fPF9VCuzqVX4AyMcPI1ZjO3
         I7/8GwAJqKYupPTB9QDt/TMMoed2fqJuZiJke6c7i0twT4KdCNsg4EslqtwQJ16+qj
         sdmMcf+jnaP1EuiSTF120B4jqpZfwTaIgNtrO9Ss00Mo9KQa4ELnPzbeD8kwWiFLua
         wRGmEC/z7W68w==
Date:   Mon, 28 Mar 2022 18:02:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jagath Jog J <jagathjog1996@gmail.com>,
        Dan Robertson <dan@dlrobertson.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] iio: accel: bma400: Add triggered buffer support
Message-ID: <20220328180212.0bac53fe@jic23-huawei>
In-Reply-To: <CAHp75Vdx3ZWFc9Xa7AhLGM=-4AzfamEqTkZxvBeu=Hu4KF7pSg@mail.gmail.com>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
        <20220326194146.15549-4-jagathjog1996@gmail.com>
        <CAHp75Vdx3ZWFc9Xa7AhLGM=-4AzfamEqTkZxvBeu=Hu4KF7pSg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2022 22:45:16 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Mar 26, 2022 at 9:41 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >
> > Added trigger buffer support to read continuous acceleration
> > data from device with data ready interrupt which is mapped
> > to INT1 pin.  
> 
> ...
> 
> > +       struct {  
> 
> > +               __le16 buff[3];  
> 
> In my (mostly review) practice it's rare that sensors operate in LE mode.
> Please, double check that.

Just for giggles, we've had sensors that had most channels little endian
but with one that was big endian...  Thankfully this isn't one of those.

I checked the datasheet and whilst indeed less common, these do appear to
be little endian.
https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bma400-ds000.pdf
page 50
ACC_X_LSB at address 0x04
ACC_X_MSB at address 0x05
> 
> > +               u8 temperature;
> > +               s64 ts __aligned(8);
> > +       } buffer ____cacheline_aligned;  
> 

