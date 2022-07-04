Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5B565A67
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiGDPxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiGDPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:53:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB6FF9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:53:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w24so9749785pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zy9LvdAwYM6pI8b/Z68M03xTnBNAZuNODV/bDDMn0vo=;
        b=lN/DVKKzJP43Ofps0rEiry9BzZRJuwiipwO7x+o8HW2bURXO5vqIsN1vmv4FjpztiM
         b6S61atBIVw3H6JCWIa8sj/mjBxJZWZtCCTBTjvqlJFbg0xBE0Uf48yxOA+Nzo/KU/rP
         UeKLqBxP9pc5yz6sKag97lg1s7LH1U3PlpnpeCj5n50zAcAg4W+4OxapDSDE2FAq2bFR
         X91+sWlifQjkxkcD5O4VubxhY1Gg7qtmNpvdezNMqhr9FKPbLdM02a5eu8JgTmJ2bF7C
         NQvJa2uayNbqLmUz7po1iaI+m78lPfQeJgbCYU3XyAKs9PF9SpPWWtXjkaFVqFhELtUH
         eaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zy9LvdAwYM6pI8b/Z68M03xTnBNAZuNODV/bDDMn0vo=;
        b=s+U87H4dnzmr+TAMgbRImacS6B/WHyJIHY2pL7r7GCvrktklkPlSroMOQSyT1EPZmY
         m/qXaX2sH0VWeKqfYcjYOcYeirVMJVlHfTNe63Y5pFEvp2lGz56xJqCunEmZdeWgWKda
         hzwX7kmnYSH5Po5ofk58GzkWa8TQHmYpJ9gdQnOgzi6boiUSVXrp04tTyEmTOkutSAc5
         nD//teUdlIn+A8p4+U+eO1wzyXMDULD/X9Nh5D/NJTpqnx3HX9uZQhDGwE9HdPzlwvfq
         Fs4yfv85lcmRDovhR6swjf3h5CXpp5AvZlYQAJPVPWaTO9PytP+YUCrnSBSeoSQjdjth
         twhQ==
X-Gm-Message-State: AJIora99yw1YCGbVoqrpLAyzWAmeeGq8paVjtrOMIFSGM6tdGvJW+6JD
        unG+PotCkGySSas34V+PJ7QEow==
X-Google-Smtp-Source: AGRyM1v4odPFoHtXvD2jFfNdl4Wr3ljEKWa0krWChFSsKVWnlMd3cVuRFrACXGH3dz1QfZBOj+8+pg==
X-Received: by 2002:a17:90a:ca8b:b0:1ec:9afb:1a2d with SMTP id y11-20020a17090aca8b00b001ec9afb1a2dmr36485448pjt.225.1656950026314;
        Mon, 04 Jul 2022 08:53:46 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902e74a00b0016bdb688097sm3627509plf.142.2022.07.04.08.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:53:43 -0700 (PDT)
Date:   Mon, 4 Jul 2022 09:53:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ren Zhijie <renzhijie2@huawei.com>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, mark-pk.tsai@mediatek.com,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dma-mapping: Fix build error unused-value
Message-ID: <20220704155337.GA2375750@p14s>
References: <20220630123528.251181-1-renzhijie2@huawei.com>
 <20220630143116.GA6198@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630143116.GA6198@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 04:31:16PM +0200, Christoph Hellwig wrote:
> Thanks, this looks good with a minor nit below:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Mathieu, can you pick this up through your tree as that is where the
> offending commit was merged through?
> 
> > Fixes: e61c451476e6("dma-mapping: Add dma_release_coherent_memory to DMA API")
>

I fixed the missing space and applied this patch.

Thanks,
Mathieu

> missing space before the opening brace here.
