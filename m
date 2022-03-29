Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A14EA859
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiC2HNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiC2HM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:12:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4B223D750;
        Tue, 29 Mar 2022 00:11:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id p25so13376649qkj.10;
        Tue, 29 Mar 2022 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2Jpv9X1mRqJBbBsT23UY5br7jZqVXCd74N7s1FPvLr4=;
        b=aalhu3Sn2nCA2dfMtZ5bg8U92vZKzbYYf8SrKTbvgcuwConxVqtEYxu+UbeK/CJKxp
         J2XW8EhweBztEFHH7svb39CtM57BYUnEa7U+pYtiJYBB5XUHBvrnsp+cPrefNgiMcLrZ
         62Llq4Z4FsR8ZRjtmDyiamTrk9hpftq7UQzCsIhIrvZfUdHmBtdZGK89rhJOfeP85PpH
         eVGG2mAClPGGFETMVpQWYnprmSsUIpJW+u6MwF45N/uNc6ZpXKMiZ3fb5Ov5AVu7FhxV
         Gv1tT+uDa8zgT/Sr4alxIm2XyNmsemas9yiRD5o83DGQuSVhR5K1LYSgo7DCLFccDPw9
         0LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2Jpv9X1mRqJBbBsT23UY5br7jZqVXCd74N7s1FPvLr4=;
        b=0UkBsFYIwuTTothcSDuQh4bmQlpYerkbq72aiv+CE/8rTfyI5Tgr7cLuGYMdjDODYE
         s+5aBIuLKg6HKsYBZbgRi3s+uYWChfJ76IWi7HEkYYkbN95LMhvaWnnWFCy+0zAeFzJo
         g37sE9nNsND1PBDBei825Os4JAtibmRbgA7gX5ZHEUdaCXUlgPv6vS4Wl3ejE9CtmFmT
         PO7ASQlTx2MtyTyk2NLn6Ldysioa1hDnsD/bPr+R8RhwUhW3y2zmxMzUVZBempDb8vVU
         sWXUYrWcmC7ax/MLdDCkbteamlCuy/vEODTvXan5BwM1T4YmwRIXkvIFSy47srV3qnDP
         M3CA==
X-Gm-Message-State: AOAM533E5MEjxTlfuOffbKTciSEKmAeEPvXfGR2wsHhtlqUba1X9vwSs
        1BsnS1viax6Bqt15qWyqvT4=
X-Google-Smtp-Source: ABdhPJy+jP697xainM6j70Eo1PTqkiP/ca6UtAdVU/oGW4GfmOgL8tApjwuNxpCwyJzVAWUtTBOa6g==
X-Received: by 2002:a37:9a47:0:b0:680:aeaa:d89c with SMTP id c68-20020a379a47000000b00680aeaad89cmr15826074qke.591.1648537872342;
        Tue, 29 Mar 2022 00:11:12 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef00:8400:3d36:58a:667a:1da9? (p200300f6ef0084003d36058a667a1da9.dip0.t-ipconnect.de. [2003:f6:ef00:8400:3d36:58a:667a:1da9])
        by smtp.gmail.com with ESMTPSA id j1-20020a05620a288100b0067b1be3201bsm8843300qkp.112.2022.03.29.00.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:11:11 -0700 (PDT)
Message-ID: <deb2cd86196addbc47908455880000c618b984be.camel@gmail.com>
Subject: Re: [PATCH v2 02/12] iio: buffer-dma: Enable buffer write support
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Date:   Tue, 29 Mar 2022 09:11:48 +0200
In-Reply-To: <96XG9R.3NOIIEN7IS001@crapouillou.net>
References: <20220207125933.81634-1-paul@crapouillou.net>
         <20220207125933.81634-3-paul@crapouillou.net>
         <20220328182409.1e959386@jic23-huawei>
         <96XG9R.3NOIIEN7IS001@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-28 at 19:39 +0100, Paul Cercueil wrote:
> Hi Jonathan,
> 
> Le lun., mars 28 2022 at 18:24:09 +0100, Jonathan Cameron 
> <jic23@kernel.org> a écrit :
> > On Mon,  7 Feb 2022 12:59:23 +0000
> > Paul Cercueil <paul@crapouillou.net> wrote:
> > 
> > >  Adding write support to the buffer-dma code is easy - the
> > > write()
> > >  function basically needs to do the exact same thing as the
> > > read()
> > >  function: dequeue a block, read or write the data, enqueue the
> > > block
> > >  when entirely processed.
> > > 
> > >  Therefore, the iio_buffer_dma_read() and the new 
> > > iio_buffer_dma_write()
> > >  now both call a function iio_buffer_dma_io(), which will perform
> > > this
> > >  task.
> > > 
> > >  The .space_available() callback can return the exact same value
> > > as 
> > > the
> > >  .data_available() callback for input buffers, since in both
> > > cases we
> > >  count the exact same thing (the number of bytes in each
> > > available
> > >  block).
> > > 
> > >  Note that we preemptively reset block->bytes_used to the
> > > buffer's 
> > > size
> > >  in iio_dma_buffer_request_update(), as in the future the
> > >  iio_dma_buffer_enqueue() function won't reset it.
> > > 
> > >  v2: - Fix block->state not being reset in
> > >        iio_dma_buffer_request_update() for output buffers.
> > >      - Only update block->bytes_used once and add a comment about
> > > why we
> > >        update it.
> > >      - Add a comment about why we're setting a different state
> > > for 
> > > output
> > >        buffers in iio_dma_buffer_request_update()
> > >      - Remove useless cast to bool (!!) in iio_dma_buffer_io()
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> > One comment inline.
> > 
> > I'd be tempted to queue this up with that fixed, but do we have
> > any users?  Even though it's trivial I'm not that keen on code
> > upstream well in advance of it being used.
> 
> There's a userspace user in libiio. On the kernel side we do have 
> drivers that use it in ADI's downstream kernel, that we plan to 
> upstream in the long term (but it can take some time, as we need to 
> upstream other things first, like JESD204B support).
> 
> 

You mean, users for DMA output buffers? If so, I have on my queue to
add the dac counterpart of this one:

https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/adi-axi-adc.c

Which is a user of DMA buffers. Though this one does not depend on
JESD204, I suspect it will also be a tricky process mainly because I
think there are major issues on how things are done right now (on the
ADC driver).

But yeah, not a topic here and I do plan to first start the discussion
on the mailing list before starting developing (hopefully in the coming
weeks)...

- Nuno Sá


