Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E424AC10E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391335AbiBGOTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390866AbiBGOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:01:31 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E1C043189
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:01:30 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id o12so10925489qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 06:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+VH5Yzc0FArtBDlyVciKdTaJzlAuXtplA0CDhVkYZVw=;
        b=TUJuhAgjjswNVQ7JzTkg9iKkOgM430mBd5iaZFyVB8juiwGMelroxSVc/tEeoVjS03
         SBBJAs6XyaJLOH0zNh1fMB11MocmBy0vZW3lQVqwc7nmLVkUib5NLDfgXeW1egoLcrUl
         0zJ1M9G8GricJAi2JHxOQgJzIsENPf4oXdSlLGMn1ou/GSiwitfE+Re74s2OC3cGYiXS
         WAB6PyKR8iNz2aNJcgzl/Jv2b00SlxQrNVuEW+ZJ8pyVvgvQpU41dl5hiuO86kWk7vjX
         6XluH9RnX42crAJsdacFsF/M+gN0YxPG9aqIQm6tHe1mZG9Uo38/MZ0gAIlPcqFBC8jG
         7hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+VH5Yzc0FArtBDlyVciKdTaJzlAuXtplA0CDhVkYZVw=;
        b=YxEy1MhtJ+05ktWU+1De4w0cN6/O1cxEsIBhcJIyVBMHsoKUm62FU3/9HM1EdAp4et
         HKpRNSpdX+PuTLMwPJAQJZpG5uMAHy+109PJJHhkuGMJ1XEQ9ZYqHi0goSlCTa0oElx/
         HvC/NCOKkg2pBdX/BKQ4Ynd3w89c3qCx0VXsHoKpCVK5QKqSTS6Mt1DkXaI/Txu/+r00
         awdII6Rp5OweTCVNYLpKWYYRaS68oQQzpFKsF7SnKpgyl/fHc9nxwVrcZsC67hZGKCU6
         auhf9xS7nmu0/QcjmVdh1GYBe2pn5ggNIbSh3ssLROM8l1D3wON2d2t9UvK2U1hOBe0f
         jebQ==
X-Gm-Message-State: AOAM5304hqEG3lMMogxyzNm5UDVUZ1+YHAWrOqnRUemjGrtA1/InbgHb
        q6L+PQOfeaepaQg2NcFLeWuUAA==
X-Google-Smtp-Source: ABdhPJxewUAI8RDxJecgMQqK84dnZDRSuWWALhikOi914YekMnNecZIoiX1AIBCzbrtZ6bBwZBwWpw==
X-Received: by 2002:a37:2c02:: with SMTP id s2mr6217893qkh.76.1644242489492;
        Mon, 07 Feb 2022 06:01:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f4sm5480989qko.72.2022.02.07.06.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 06:01:28 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nH4a7-000CyH-Do; Mon, 07 Feb 2022 10:01:27 -0400
Date:   Mon, 7 Feb 2022 10:01:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH 3/8] mm: remove pointless includes from <linux/hmm.h>
Message-ID: <20220207140127.GA49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-4-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:32:44AM +0100, Christoph Hellwig wrote:
> hmm.h pulls in the world for no good reason at all.  Remove the
> includes and push a few ones into the users instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 1 +
>  drivers/gpu/drm/nouveau/nouveau_dmem.c   | 1 +
>  include/linux/hmm.h                      | 9 ++-------
>  lib/test_hmm.c                           | 2 ++
>  4 files changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
