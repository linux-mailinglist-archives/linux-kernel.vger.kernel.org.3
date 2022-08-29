Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24955A4DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiH2NYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiH2NXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:23:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7179E2AE3E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:20:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a36so6299821edf.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mQUHTuYnqcoAeXul3EMTaZkjzPrI/1mvOnzVF5OZRzI=;
        b=L41nImzv8K5JsEIJizxYFWSpOBw1i7vOEH4Q8rIVvEIm75QDMYbrg2QawScMLgtk2O
         7nnMXD7LseTKALkAxn81FcBtgf7klmlkj9rG7lq4kF/pr52w95TT6g3Tj2hGhr8EgrT0
         NBxIkJV7J6YDkp+LUZv3jhvnJYo/Ec5oJ8Z0cShElsTG8lDSM55MQZevTC7DmeoGAqsg
         erS+2jH+/Xyc8Cvv6ajVsKzSskEwVzXDOflfiGqK8RXS+p8kuBnj5Suoer4f8b0Lhla/
         +F5HDCkDPMq7+5QtBypwjffEa/XaX/hK6XIKrBVpsun8kvHQD/Qf01oTehKiPseryJtz
         1q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mQUHTuYnqcoAeXul3EMTaZkjzPrI/1mvOnzVF5OZRzI=;
        b=Kkymaf/9zfwQQ6ihmIsWq2s1tlQst1qydYFc2Dw2wIYBzJdXG2LUDeeyZ/lyxxlAbO
         djmGEnfUXCxrKD6m3MSk1AfpC1IBLCDhZlZ6awLxl9QCKcf7mpnZ+gE+iOWIQM9ytmIu
         iaiV6v1HWH6MyvigdkQUMmkd0lhq/7mB6+7qs/vumrAqaCWkHlapDGTj6geUmrZ1SGjb
         UVT6dTiM2lumk1I5xX/OMAMOqAvNGv5aKBj9zU9GpTh85jrPPrq+my1cPmOAjvBDmguM
         H6qPH8aLj76nSW7Z4K0CsVYeV6kPYvn3HXo0jaQPIL0m/jIyRmbKRsTeoTtY8j8NSKt4
         3t8w==
X-Gm-Message-State: ACgBeo3nREXJvz5x8MFNHX4QuMpSTwVZ24Wex3fwLXp0Nn2XeKXgAOu0
        R3nhENnQjk2sSGepkJEHEdKN3ryJcrs7v3kGhs/BJ7xMiaU=
X-Google-Smtp-Source: AA6agR40wYNFW+LmW9zrbbUsooJU1a0lKwiC6U1QfIvaROBxj+jTCcLg3W0p/vtSj4Nc00eMEFjGsDlCUA5IOL4z+r8=
X-Received: by 2002:a05:6402:1286:b0:447:e8ca:207b with SMTP id
 w6-20020a056402128600b00447e8ca207bmr12452322edv.95.1661779165341; Mon, 29
 Aug 2022 06:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220826095615.74328-1-jinpu.wang@ionos.com> <20220826095615.74328-3-jinpu.wang@ionos.com>
 <YwtM+/nB1F6p1Ey3@unreal> <CAMGffEmffkW0fHrjx84gQ6FnWuwriRUg=HSdwzU4W_sZLdiT7g@mail.gmail.com>
 <Ywyr0+b350SZrznw@unreal>
In-Reply-To: <Ywyr0+b350SZrznw@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 29 Aug 2022 15:19:14 +0200
Message-ID: <CAMGffE=m_Na9n-oHkxm6C2C1sC3U9LkN_7k8Xx9g9SG2ifDjrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] RDMA: dma-mapping: Return an unsigned int from ib_dma_map_sg{,_attrs}
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 2:06 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Aug 29, 2022 at 11:40:40AM +0200, Jinpu Wang wrote:
> > On Sun, Aug 28, 2022 at 1:09 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Aug 26, 2022 at 11:56:15AM +0200, Jack Wang wrote:
> > > > Following 2a047e0662ae ("dma-mapping: return an unsigned int from dma_map_sg{,_attrs}")
> > > > change the return value of ib_dma_map_sg{,attrs} to unsigned int.
> > > >
> > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: Leon Romanovsky <leon@kernel.org>
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: linux-rdma@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > >
> > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > ---
> > > >  drivers/infiniband/core/device.c | 2 +-
> > > >  include/rdma/ib_verbs.h          | 6 +++---
> > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > You forgot to change ib_dma_map_sgtable_attrs() and various
> > > ib_dma_map_sg*() callers.
> > No, they are different.
> > ib_dma_map_sgtable_attrs and dma_map_sgtable return negative on errors.
>
> It is not the point. You changed ib_dma_virt_map_sg() to be unsigned,
> so now the following lines are not correct:
>
>   4138         int nents;
>   4139
>   4140         if (ib_uses_virt_dma(dev)) {
>   4141                 nents = ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
>
> "int nents" should be changed to "unsigned int".
>
> Thanks
ok, I can do it.
just to check if we are on the same page:
For all the callers of ib_dma_map_sg,  would it be better to fix it
one patch per driver or do it in a single bigger patch.
I feel it's better to do it per driver, and there are drivers from
different subsystems e.g. nvme/rds/etc.

Thx!


>
> > >
> > > Thanks
> > Thanks!
