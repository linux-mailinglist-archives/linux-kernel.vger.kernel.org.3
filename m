Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D1353A936
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354943AbiFAO3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354945AbiFAO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:28:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266E130542
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:27:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id z17so2142052pff.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1kEmR6X4i/nh+b6VMavBDubG9LMGPY4F+6d16NUM+gg=;
        b=mzH/QSAKngGq4V8ihQYKENupPuzAZLcXExKUCzkD7wVNpc9ZhtZ9SHvU7A/Wtsjk5p
         u8kr0G8Dxjuyhpjuqw3LG5uYEJBVyjeqJdOgUCIYXBdjvv7C4kZJqrt481urixeIGVCQ
         6Bk5quC5jGzL+SmIzDU43ncWqQdAVI/I0jUgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1kEmR6X4i/nh+b6VMavBDubG9LMGPY4F+6d16NUM+gg=;
        b=R8NYK327IenvQpoLUdrDodFBfR/M8TVamTj3Q/sjphJQz61zgfpDLMTRNcFHQvgQAN
         lzvCYSk+wVTy9e9p6BQ03s18XLbvwwWs7oAWdYgdE22/C2HdmqmwiIjOL8fTX4K2R9RV
         HNFBAzbCmIp+yN7WkcM0IGBZMS+RAeOSIrzA6gyo8RS6I6JXhGw5EJHDLOF+wPsoZmnG
         ylozG19X1SGXMxPHcuP9iT+XJAx2rMsxyMhaJigCs0yhmqW9180Upp8HupzRIfvhtIRb
         De9AaN/hEc0rOedIeV+5udUgz1W/cNguxXLC/ziBOM+MY0x89p0TClca367D6oEUVFuK
         xWnw==
X-Gm-Message-State: AOAM531qy6DsbQvZ9rW2D/m0TZtJlcdrBCaiQrO8H8AJoS2euhkfT8Qz
        TZwXZkeBIxWs9BPCW0vSBxm1MQ==
X-Google-Smtp-Source: ABdhPJx1bs4rZIm3ygpokZwXwCX7e324N+HICM85x+DBIaCNTNO14kwZs2t/7lNxNBCdLuDn6WabZQ==
X-Received: by 2002:a05:6a00:a01:b0:51b:51d8:3c2a with SMTP id p1-20020a056a000a0100b0051b51d83c2amr152799pfh.68.1654093656292;
        Wed, 01 Jun 2022 07:27:36 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:ec3a:4b49:34bc:e5b4])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c24200b00162523fdb8fsm1589163plg.252.2022.06.01.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:27:35 -0700 (PDT)
Date:   Wed, 1 Jun 2022 23:27:30 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [Linaro-mm-sig] Re: [PATCH] dma-fence: allow dma fence to have
 their own lock
Message-ID: <Ypd3Us3a93aLonqT@google.com>
References: <20220530142232.2871634-1-senozhatsky@chromium.org>
 <7eee4274-bd69-df8d-9067-771366217804@amd.com>
 <YpWCvniLzJfcp684@google.com>
 <33aba213-b6ad-4a15-9272-c62f5dfb1fb7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33aba213-b6ad-4a15-9272-c62f5dfb1fb7@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/01 14:45), Christian König wrote:
> Am 31.05.22 um 04:51 schrieb Sergey Senozhatsky:
> > On (22/05/30 16:55), Christian König wrote:
> > > Am 30.05.22 um 16:22 schrieb Sergey Senozhatsky:
> > > > [SNIP]
> > > > So the `lock` should have at least same lifespan as the DMA fence
> > > > that borrows it, which is impossible to guarantee in our case.
> > > Nope, that's not correct. The lock should have at least same lifespan as the
> > > context of the DMA fence.
> > How does one know when it's safe to release the context? DMA fence
> > objects are still transparently refcount-ed and "live their own lives",
> > how does one synchronize lifespans?
> 
> Well, you don't.
> 
> If you have a dynamic context structure you need to reference count that as
> well. In other words every time you create a fence in your context you need
> to increment the reference count and every time a fence is release you
> decrement it.

OK then fence release should be able to point back to its "context"
structure. Either a "private" data in dma fence or we need to "embed"
fence into another object (refcounted) that owns the lock and provide
dma fence ops->release callback, which can container_of() to the object
that dma fence is embedded into.

I think you are suggesting the latter. Thanks for clarifications.

The limiting factor of this approach is that now our ops->release() is
under the same "pressure" as dma_fence_put()->dma_fence_release() are.
dma_fence_put() and dma_fence_release() can be called from any context,
as far as I understand, e.g. IRQ, however our normal object ->release
can schedule, we do things like synchronize_rcu() and so on. Nothing is
impossible, just saying that even this approach is not 100% perfect and
may need additional workarounds.

> If you have a static context structure like most drivers have then you must
> make sure that all fences at least signal before you unload your driver. We
> still somewhat have a race when you try to unload a driver and the fence_ops
> structure suddenly disappear, but we currently live with that.

Hmm, indeed... I didn't consider fence_ops case.

> Apart from that you are right, fences can live forever and we need to deal
> with that.

OK. I see.
