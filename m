Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43D489CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiAJPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbiAJPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:50:33 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB9FC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:50:33 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c15so14377472qtc.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=taJK4990Hf5ggLF7x5d/tJzG7fwO4y08TUkbCKMXkXM=;
        b=SU3mKDe+NFt3ELa2q1426sexnDWTv18yKIPDP2du70kd2dvXb52pbMprOX3r4vXwnT
         RbL/u0D3fPqnhE75Zta7ky5PgQl+H7WlhwgI11Y9Dz1SlLlNyp1vZelvZQfiKOIBLikl
         9VdKprbwittxaamxOVCN3EL4GuHf/srjHctuYUzkQ2alUkCvKBgXraQVXsc11RTekBnu
         iacR1txVlA/jNx6GNjsFWSQwvPhSc/uJHfJ/mKUmnB7DVKYliIoB4dEZciKewszMijkI
         vO1LhdxWqyO0YGpmagOxmsqhoVMgkRSsEN7ww+ni+rjYhOHFPPU2YpgW1eD0xXLut+sY
         VFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=taJK4990Hf5ggLF7x5d/tJzG7fwO4y08TUkbCKMXkXM=;
        b=x2nyI3G0QTMqSJAF2epWYngWrGKRxIiANeBplk5kokEazzV859X0QDa6PkQwJJ21lW
         ZKu6FoYwJMCpeVAl0ShEsvR6FGZ6qXYa//qqfO7zJkTR2dvH7jRxzuXI6E5uvvPmuuH6
         AMpj/N1kgzMsaRuGlc75MJxUb+HIyQw9N6CyxMNm4VZPEq2tSfaZDjA4Geqjd9uKjuwu
         A5sQ4qMSOZaK9i65taJ1OenxfUhSGt2CIXUqwUZnYYNoU8ettVcPGKAj89u5WT/L/XOk
         UB3YiAe2xHp2jFKdjZrC9dCLvlXfruU2C49rd56y3cA9E+dirH4zqYHN6MAwSkvu7A6p
         VhMQ==
X-Gm-Message-State: AOAM532rHt1BN7WP8oxi2fJloX+gvpLhTLzgcpiQcHtfodJkkzBeB9ua
        HYT111WkoZDfZrLAC7YwZ2k7e9AqiMefew==
X-Google-Smtp-Source: ABdhPJxBj0ZyPgNVhc4jPK7tenIAOTO7n8CuI533poIMXs6L4y67rXu3AheljFk+wuxJDExcGtdWCQ==
X-Received: by 2002:ac8:74c6:: with SMTP id j6mr229936qtr.557.1641829832895;
        Mon, 10 Jan 2022 07:50:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id r4sm900398qta.51.2022.01.10.07.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 07:50:32 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n6wwJ-00DpQ8-Ir; Mon, 10 Jan 2022 11:50:31 -0400
Date:   Mon, 10 Jan 2022 11:50:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/mthca: Remove useless DMA-32 fallback configuration
Message-ID: <20220110155031.GI6467@ziepe.ca>
References: <4aeb3dcf39490334acf583e723a08ea7262b0912.1641716983.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aeb3dcf39490334acf583e723a08ea7262b0912.1641716983.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 09:30:09AM +0100, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398

Can you use lore links please?

Jason
