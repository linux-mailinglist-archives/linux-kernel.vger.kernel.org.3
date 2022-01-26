Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E0349CB46
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbiAZNri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241568AbiAZNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:47:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D6FC06173B;
        Wed, 26 Jan 2022 05:47:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B62CB81E10;
        Wed, 26 Jan 2022 13:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8163EC340E3;
        Wed, 26 Jan 2022 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643204849;
        bh=J59HSbb1CYUQf2jadvuiVJSAI50FKAJ/JDdZfSRUuYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=09AwusFHeokv+yKQNoSyPCUsa7T2m1PUFUtbdUDQmzfxUU3qWx1Hcwnw3eczazLse
         x87m78Eoy1SiFlZ/HPRvOjBryNfg8cWGjh8pBhhpGfArFmEwUJO8HZnBQyaryU1HqG
         4rBtkfvNLaC0xXZo3j/EYWMnNdBKa0rlQPvtR3ls=
Date:   Wed, 26 Jan 2022 14:47:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     hammer hsieh <hammerh0314@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        wells.lu@sunplus.com, "hammer.hsieh" <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH v6 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Message-ID: <YfFQ7v4dXPMV7ypw@kroah.com>
References: <1641979444-11661-1-git-send-email-hammerh0314@gmail.com>
 <1641979444-11661-3-git-send-email-hammerh0314@gmail.com>
 <fcd43c65-6201-9e44-061c-f04e39cef726@kernel.org>
 <CAOX-t54oA9V94d3901w2xKSagSzmXc9r=TDTtbgaSLfL1DxNbw@mail.gmail.com>
 <d6d3aa07-7bf1-2b6d-356f-ae13c7b9d6cd@kernel.org>
 <CAOX-t57KZb0hNDuhPsabkmkf_qOOLqyH3yuvkHP6UNwhLodWDg@mail.gmail.com>
 <2cde3ff0-5180-7c1e-82fd-7b58e41d462a@kernel.org>
 <CAOX-t573QkixRC7xa1KUOYXfL12Q+Ltxph9rX7V8tm2BMoqxgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOX-t573QkixRC7xa1KUOYXfL12Q+Ltxph9rX7V8tm2BMoqxgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 10:22:56AM +0800, hammer hsieh wrote:
> Jiri Slaby <jirislaby@kernel.org> 於 2022年1月13日 週四 下午7:12寫道：
> >
> > On 13. 01. 22, 11:56, hammer hsieh wrote:
> > >> Could you explain me what posted write is and how does it not matter in
> > >> this case?
> > >>
> > >
> > > Each UART ISC register contains
> >
> > No, you still don't follow what I write. Use your favorite web search
> > for "posted write" and/or consult with your HW team.
> >
> 
> Maybe this time, we are on the same page.
> Our SP7021 chipset is designed on ARM Cortex-A7 Quad core.
> Register Access through AMBA(AXI bus), and it is non-cached.
> 
> Did you mean
> case1 have concern about "posted write", and you want to know why it not matter?
> case2 will be safer?
> 
> Case1 :
> spin_lock_irq_save()
> writel(0, target register)
> spin_unlock_irqrestore()

A lock does not mean that your write made it to the device.  Please talk
to the hardware designers to properly determine how to correctly write
to the hardware and "know" that the write succeeded or not.  This driver
does not seem to take that into consideration at all.

thanks,

greg k-h
