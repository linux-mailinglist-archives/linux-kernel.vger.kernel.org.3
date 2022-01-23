Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A917497253
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiAWPER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiAWPEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:04:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB643C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 07:04:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88B9960E71
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 15:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8E1C340E4;
        Sun, 23 Jan 2022 15:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642950255;
        bh=2luaiXNj/vIwgpz+K8P96DsIwlW1tUEbqFgUKh/gxtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c39V1BVgal9NMn9vX3BZadTfqvHiFFz76Z+OpSXa+WWAs+hKFQ/CMSfx0CaObtUkm
         V8bw8x7EyxOMo3LjxfdwnMFEQ9PD3Sjm4d/WtUI9nQQPFY6t7nedQwOL4dRVd6rU5k
         qBh8lS0DITw7hnpxFs7+cyQpYPs4JfItPrrfM1d8=
Date:   Sun, 23 Jan 2022 16:04:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] habanalabs: Remove unused enum member DMA_SRAM_TO_SRAM
Message-ID: <Ye1ua3ixuSfdhiRc@kroah.com>
References: <20220111114724.7987-1-cai.huoqing@linux.dev>
 <CAFCwf10GWN_hdsvUf+7dFFK=CwjuGxXPZZt8c2dkVOb24VZxcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10GWN_hdsvUf+7dFFK=CwjuGxXPZZt8c2dkVOb24VZxcQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 04:43:15PM +0200, Oded Gabbay wrote:
> On Tue, Jan 11, 2022 at 1:47 PM Cai Huoqing <cai.huoqing@linux.dev> wrote:
> >
> > The driver don't support the SRAM-to-SRAM translation of DMA,
> > so remove 'DMA_SRAM_TO_SRAM'.
> >
> > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > ---
> >  drivers/misc/habanalabs/include/goya/goya_packets.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/misc/habanalabs/include/goya/goya_packets.h b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > index ef54bad20509..25fbebdc6143 100644
> > --- a/drivers/misc/habanalabs/include/goya/goya_packets.h
> > +++ b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > @@ -36,7 +36,6 @@ enum goya_dma_direction {
> >         DMA_SRAM_TO_HOST,
> >         DMA_DRAM_TO_HOST,
> >         DMA_DRAM_TO_DRAM,
> > -       DMA_SRAM_TO_SRAM,
> >         DMA_ENUM_MAX
> >  };
> >
> > --
> > 2.25.1
> >
> 
> This is a general spec file in our s/w stack, and therefore a change
> in it in the driver will cause our driver to be out of sync with our
> user-space stack. i.e. the value of DMA_ENUM_MAX will be different in
> the driver and in the user-space stack. I don't know if there will be
> any consequences but I prefer not to risk it.

If this is synced to userspace, shouldn't it be in a uapi file with a
specific value associated with it?

thanks,

greg k-h
