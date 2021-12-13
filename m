Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E462947326C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbhLMQz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbhLMQzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:55:46 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B7C0613F8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:55:42 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x131so15412252pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Otkd94Ddo+0y+d19P9705aLyzrf8R+OhLjXGWeBBDgI=;
        b=D2pQ/ahpacnzEw4VKDE+IWQG9HUL/EEsWexNqmtOR4aNU5XRNcTMGIcFE4kTfkdg0u
         Urd3qw/wp/ybiCNZNvxY6XJqtkpMjR7QhPecu67jMtnbj8hmJRn7kKShA1+mgYpvL4D9
         oJ+CQnNFirWc+8lo2KnWjDX25k+depiKcixPXsbzZLKTktNrWBdmAfNhMUPhXTPMeaC2
         FaS6wUQ2IcWiOerE3Pyg6w+scfVh9PTa34b3UVdXWWrmV5TO7oDfLZvKZNzeU2MkUqEa
         DLItbA1GxSmg2iPv/Kl/jc/yWytd88vFon1VNR3NZdFRymNAlInFzVkcL5HrNEtJUZ4a
         gcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Otkd94Ddo+0y+d19P9705aLyzrf8R+OhLjXGWeBBDgI=;
        b=cuHvcghLAQ7wNvFxovu65Z5Y6TmFKSxEwM3RMPyAUuR50wKuLMRBRCPSEyGqXdspJI
         R5cFI5ascaG4Tgkpqhjfq/UUKe+gZwl0fNr4IblD1Z+qkQV/bEmZnTXf4iLPNvKx9Ioc
         I1hCQ7HNeOgPkmWlaZ/fejcf7yopacRtxBJ/PTIHCAE7LiJu9l+ELXl5UhWsddEDWB9i
         Y/p8ZUnJn0hoZUR1yLYse9uHkgcPkRcKhsRK19F7EIzSN0uFWpAy+NHPejCV0dOaVcy8
         dOpN1bX4OIBWneCR7YxZxfK08q6jqNTnKV+BSjsCk6+5ZXrbNZhXOuo5Q9WLG9CagwTl
         kF5A==
X-Gm-Message-State: AOAM531jTfOkprGNVvx9KimdwalNG+pP4db01NM6wX/ThxfX9ZixpDWV
        m9TJQ1Xp0oLmToXZiyskf8tSHw==
X-Google-Smtp-Source: ABdhPJxcG+pDaR82nQIpiGgA+GsZ94Xtzp0Mh0VcEJpkpsk7NgrveddXN3qtbe4XWzRsAWtKejnyUw==
X-Received: by 2002:a65:6557:: with SMTP id a23mr12921258pgw.451.1639414541767;
        Mon, 13 Dec 2021 08:55:41 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id r6sm7378794pjz.56.2021.12.13.08.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:55:40 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:55:38 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, matthias.bgg@gmail.com,
        ohad@wizery.com, yj.chiang@mediatek.com
Subject: Re: [PATCH v2] remoteproc: use %pe format string to print return
 error code
Message-ID: <20211213165538.GA1396405@p14s>
References: <20211116162933.GA2318486@p14s>
 <20211213072015.32235-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213072015.32235-1-mark-pk.tsai@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 03:20:15PM +0800, Mark-PK Tsai wrote:
> > Good day,
> > 
> > On Tue, Nov 16, 2021 at 09:57:03PM +0800, Mark-PK Tsai wrote:
> > > > > > > Use %pe format string to print return error code which
> > > > > > > make the error message easier to understand.
> > > > > > >
> > > > > > > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > > > > > > ---
> > > > > > >  drivers/remoteproc/remoteproc_core.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > > > > > index 502b6604b757..2242da320368 100644
> > > > > > > --- a/drivers/remoteproc/remoteproc_core.c
> > > > > > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > > > > > @@ -575,8 +575,8 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
> > > > > > >                                            dma_get_mask(rproc->dev.parent));
> > > > > > >         if (ret) {
> > > > > > >                 dev_warn(dev,
> > > > > > > -                        "Failed to set DMA mask %llx. Trying to continue... %x\n",
> > > > > > > -                        dma_get_mask(rproc->dev.parent), ret);
> > > > > > > +                        "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> > > > > > > +                        dma_get_mask(rproc->dev.parent), ERR_PTR(ret));
> > > > > >
> > > > > > Macro ERR_PTR() is used to convert error codes to pointer type when
> > > > > > returning from a function - I fail to see how doing so in a dev_warn()
> > > > > > context can make the message easier to understand.  Can you provide an
> > > > > > example?
> > > > >
> > > > > Hi,
> > > > >
> > > > > When dma_coerce_mask_and_coherent() fail, the output log will be as following.
> > > > >
> > > > > format          log
> > > > > %x              Trying to continue... fffffffb
> > > > > %d              Trying to continue... -5
> > > > > %pe             Trying to continue... -5        (if CONFIG_SYMBOLIC_ERRNAME is not set)
> > > > > %pe             Trying to continue... -EIO      (if CONFIG_SYMBOLIC_ERRNAME=y)
> > > >
> > > > When failing, functions dma_coerce_mask_and_coherent() returns -EIO.
> > > > Casting that to a (void *) with ERR_PTR() does not change that value.
> > > > Since variable @ret is already declared as "int" the real fix is to
> > > > change "%x" to "%d".
> > > 
> > > There're some other drivers do the same thing in the recent kernel, so I think
> > > it's fine to casting the `ret` to a (void *) for more user friendly.
> > > But I suppose it would depend on the maintainer's opinion.
> > > 
> > > So how about previous patch I sent, which also fix this issue by using %d.
> > > 
> > > https://lore.kernel.org/lkml/20211102120805.27137-1-mark-pk.tsai@mediatek.com/
> > 
> > I had not seen Russell's reply in the link you posted above.  I am not
> > completely sure about his solution but his insight and guidance in kernel
> > programming have precedence over mine.
> > 
> > I will take this patch.
> > 
> > Thanks,
> > Mathieu
> > 
> 
> Hi,
> 
> Sorry to disturb you.
> Is this patch queued?
> Just want to make sure it has not been forgotten.

https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/log/?h=for-next

