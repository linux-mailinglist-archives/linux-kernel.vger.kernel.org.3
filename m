Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578A753A5E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351186AbiFANWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353201AbiFANWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:22:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F8850000
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:22:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p10so2326553wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=grujjgVk78/kTeNAsYLCQutjse2S4qIjwux8s5I8vnE=;
        b=lbp9nbUHl8ofN+dxS0sdOLugDeZaytx+OeJ/NUuXNjLXcor8DTOBLfkafd9Ko2hYX8
         495GS2cLePb2F5knyThcbWf3wiId5H9lTMY9NZabHJK5EZ3R9hCa++G7oLq2EYPVKmNI
         +UytFWz/nCngyWhhtdQW0HcQWOK9ikTgTBhTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=grujjgVk78/kTeNAsYLCQutjse2S4qIjwux8s5I8vnE=;
        b=4Xfy+bKo4v85XSAKTFJmPi/RFQqPrIke48NRlXS8BUW7MYJtW/Ka6+FriZCEE7RrGT
         B7msNaCYFuKlQnMX9sPzw5xGv+0drXaEZZUj4FjhdXek9oA+A1lJ+GedRxZadtr+1bgj
         OZOm0DOFUzQmxNx3QwbqaJscjnRtNQYwUW40WGkOFMjXng6Ab83g6pjP4CNrNHnc5zWX
         LZBywYRtcMioftYpqrTItXCP1Qac6r/UhJEG72AXSvlwg/aCp63hzkS1nDa1VtkaZUWq
         fUIjegAkuchMPzv4HtYZzMf3hogt9igStKPOXyPdKAYjnDX+yYs3W8Y690MYuukTI9oz
         HhlQ==
X-Gm-Message-State: AOAM533FeHcttY+qliwkYL0P6Ve/LMpuFYl23XBFMdQI8r/wz2aRahv9
        LlQjAZvWOlg2u+/X6F1Jm3PILg==
X-Google-Smtp-Source: ABdhPJwoJDsjkQSbDgWTJ7sUm3syg4hR/7CZJ/cx7MS5hpu1nj4Bt5HyEIhy7EmDZ7ZNnjRnexBFog==
X-Received: by 2002:a5d:4646:0:b0:210:3e3c:86dc with SMTP id j6-20020a5d4646000000b002103e3c86dcmr2982159wrs.277.1654089751161;
        Wed, 01 Jun 2022 06:22:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d13-20020adfef8d000000b0020fc40d006bsm1609106wro.17.2022.06.01.06.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 06:22:30 -0700 (PDT)
Date:   Wed, 1 Jun 2022 15:22:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
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
Message-ID: <YpdoEzLmlBfJks3q@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@infradead.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20220530142232.2871634-1-senozhatsky@chromium.org>
 <7eee4274-bd69-df8d-9067-771366217804@amd.com>
 <YpWCvniLzJfcp684@google.com>
 <33aba213-b6ad-4a15-9272-c62f5dfb1fb7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33aba213-b6ad-4a15-9272-c62f5dfb1fb7@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:45:42PM +0200, Christian König wrote:
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
> 
> If you have a static context structure like most drivers have then you must
> make sure that all fences at least signal before you unload your driver. We
> still somewhat have a race when you try to unload a driver and the fence_ops
> structure suddenly disappear, but we currently live with that.
> 
> Apart from that you are right, fences can live forever and we need to deal
> with that.

Yeah this entire thing is a bit an "oops we might have screwed up" moment.
I think the cleanest way is to essentially do what the drm/sched codes
does, which is split the gpu job into the public dma_fence (which can live
forever) and the internal job fence (which has to deal with all the
resource refcounting issues). And then make sure that only ever the public
fence escapes to places where the fence can live forever (dma_resv,
drm_syncobj, sync_file as our uapi container objects are the prominent
cases really).

It sucks a bit.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
