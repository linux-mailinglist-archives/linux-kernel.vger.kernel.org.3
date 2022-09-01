Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A7B5A9988
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiIAN50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiIAN5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:57:20 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E92AE18
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:57:18 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D1C03F0C3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662040636;
        bh=eatamg8KEOTO7jgHDtGKXWunmQpTPYEKBxdi9CxrfRQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=itGmv9SFZm2qXuKbr7XXoIlJ4E9xCTAtWm+liiA+QDAmuq0x7ocwzb9A3dBIYlXlr
         qsuaUCtgneXQvcd6YFpd7PcNH16hoWCKhpIJFRBuzlbpMk5AHqDZaSnw7hcjNzm916
         iQk2cwl71ymj8d0SRi6h2zZD0P/BzDHYSRthUzACk/clL8tGK7QmL844th2hICnqWm
         y3lM7l9BrCS/MLwARp2BdgZiaiyOJAqL14l/zlkZoEF+yrN6i8/ozJe0N5w4hcA5ch
         NC6aRkBYkde8vzbC4vVbPhecg2PnHoKWB6B/UvMfgOzPetBC6rqcItBl3CS6YBqYvg
         Z3veD64S+SL6w==
Received: by mail-ej1-f70.google.com with SMTP id ho13-20020a1709070e8d00b00730a655e173so6883509ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eatamg8KEOTO7jgHDtGKXWunmQpTPYEKBxdi9CxrfRQ=;
        b=7Gdr5AGc0wQc6OoHEFxlwTRzp1IT05QkH/pvnOjHOUMtSzxvus1bpKyG7jV/J3wN3G
         UW9tpK+EuGT8WEaCQyZllwyS44rMVZBPEYdnZhhYBtbEd1TYjMvYgV32hhAAdS0E0ac7
         01X7pwiXjb2gDzGIIvzsvNvmucWYjAot/vrXoRNFWNjDrhfoKBg09aYhaoyC/HcYXwQU
         HyEXAoy6bKVEzkc+64vv5p7g9UCTkIAlbz2kQFQaP7JW/mUEtvEXkpkI0ZgNbU11bdcT
         CzUj7Pdnt1TA1cWafxmuaxDz6/9lX/VyUTDW4xOFQ8KtTtpvTbxbbB3FJA60kVlGbv/v
         9+SQ==
X-Gm-Message-State: ACgBeo0kA+CFmX8PJvMZ0EWjmV/ssNEwioRjxlgDNaLRMqLqTiwAijbm
        FA88Tvh1PA4RaEF87p4/3i2wtonFS8c+pIr7EDOMMl+J6kbgJThweeDtI+KOpOTaHiPGwQ/j/iD
        4aI1diBaZ0wTy6BWVZ/y3X4hNtBMkEqJiiIx8vLGHxK1fvYxABug91i406Q==
X-Received: by 2002:a50:fe91:0:b0:43d:c97d:1b93 with SMTP id d17-20020a50fe91000000b0043dc97d1b93mr29907573edt.67.1662040633957;
        Thu, 01 Sep 2022 06:57:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4pjZ4PvM9dADBtZDfV/dC1vl9LAgpRNbNaP8opEFR0qd/BGnVwJ1XzicJH6Wlr5JB2yCtqu7vb3pn5KKjrzVI=
X-Received: by 2002:a50:fe91:0:b0:43d:c97d:1b93 with SMTP id
 d17-20020a50fe91000000b0043dc97d1b93mr29907548edt.67.1662040633618; Thu, 01
 Sep 2022 06:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220901021628.1130985-1-koba.ko@canonical.com> <a15ab3e6-249d-af48-b4d5-25840b72a933@amd.com>
In-Reply-To: <a15ab3e6-249d-af48-b4d5-25840b72a933@amd.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Thu, 1 Sep 2022 21:57:02 +0800
Message-ID: <CAJB-X+V-D0Es+5=KJQYdv6DKVK48jYzyU_4y6qvfY=H55y6oHQ@mail.gmail.com>
Subject: Re: [PATCH V2] crypto: ccp - Release dma channels before dmaengine unrgister
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 9:42 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 8/31/22 21:16, Koba Ko wrote:
> > A warning is shown during shutdown,
> >
> > __dma_async_device_channel_unregister called while 2 clients hold a reference
> > WARNING: CPU: 15 PID: 1 at drivers/dma/dmaengine.c:1110 __dma_async_device_channel_unregister+0xb7/0xc0
> >
> > Call dma_release_channel for occupied channles before dma_async_device_unregister.
> >
> > Fixes: 4cbe9bc34ed0 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")
>
> I can't find this Fixes: tag. I did find:
>
> 54cce8ecb925 ("crypto: ccp - ccp_dmaengine_unregister release dma channels")
>
> Not sure if Herbert can take care of that or if you'll need a v3.

Sorry, it should be 54cce8ecb925("crypto: ccp -
ccp_dmaengine_unregister release dma channels")

>
> With the change to the Fixes: tag
>
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > ---
> > V2: Fix the unused warning
> > ---
> >   drivers/crypto/ccp/ccp-dmaengine.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
> > index 7d4b4ad1db1f3..9f753cb4f5f18 100644
> > --- a/drivers/crypto/ccp/ccp-dmaengine.c
> > +++ b/drivers/crypto/ccp/ccp-dmaengine.c
> > @@ -641,6 +641,10 @@ static void ccp_dma_release(struct ccp_device *ccp)
> >       for (i = 0; i < ccp->cmd_q_count; i++) {
> >               chan = ccp->ccp_dma_chan + i;
> >               dma_chan = &chan->dma_chan;
> > +
> > +             if (dma_chan->client_count)
> > +                     dma_release_channel(dma_chan);
> > +
> >               tasklet_kill(&chan->cleanup_tasklet);
> >               list_del_rcu(&dma_chan->device_node);
> >       }
> > @@ -766,8 +770,8 @@ void ccp_dmaengine_unregister(struct ccp_device *ccp)
> >       if (!dmaengine)
> >               return;
> >
> > -     dma_async_device_unregister(dma_dev);
> >       ccp_dma_release(ccp);
> > +     dma_async_device_unregister(dma_dev);
> >
> >       kmem_cache_destroy(ccp->dma_desc_cache);
> >       kmem_cache_destroy(ccp->dma_cmd_cache);
