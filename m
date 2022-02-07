Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283514AC99D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiBGTbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiBGT1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:27:33 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68865C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:27:32 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id y8so12833474qtn.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BoyrZhI/SFo2F7HoszDIan4CMWU1RWbm6+Gl19zQGEA=;
        b=Ch8C10PSNgUgzrJSYUwNmUYPnK3KqD5nVzs8U25K8dQe5Nz0RHnqD34dfcVzOfHQn0
         Z7A2NrwTV3T8U5qAOPkdl18fdhCkDtt27sDhMF9az9KwL3bhZc1wWsNakacs8mHp4+2i
         ATHSdkH9LZE8z74Q7FsDuavDIliXPR3QE65Wv381+/ZcyQuEMN7ZFrlis4MW0UWFA66p
         hAq2I0gQh10LCJLc1hBJhl0b+SX/rRCFuGSDgkT7h5GKbOua68a4YV58mo6/qZ9LpsXw
         xHl/NBuQ1Pg3+hWr0zmMYM2z5/HBKY5RxkuejNX/FdePkUnSlgZKK24pt/x4bYmxOQsS
         FISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BoyrZhI/SFo2F7HoszDIan4CMWU1RWbm6+Gl19zQGEA=;
        b=FOduVdFoxQ4kWlAEYnZvnWy8KvrB5L+jraxuFt8UnPqM9Lys6gxtwnxRcT2XMBkerj
         7cQkm+H+m++7sokBWRfPhBcqYWmBMttNWqliO0QN5bUVafb0N5OLkfcZLxkqtB4tmZVZ
         5IT2sUdfXja4wALf95XBborP1WhegwRi1f3rzEyUHlzqiJJUhT0mSYgZ3R1sMazrBQYY
         1EDvdPlHdxxHDWRgu4Sf2fNQKY8nwZKnSXTXbU7gtBmOrjxNNqQZqOqUQlLJ1q2dzU80
         15p41JmXKciY32g0sokJguGFysIavl4iodMg5Z89LJJzgByKbSiYJzkM4/bDPQ96c/ol
         D9Cg==
X-Gm-Message-State: AOAM531NGst26nx58BPPRooRdHKBixqNVW9GH/t50MMp7oRACCqnKGXc
        xHxKdTFiqymxlNseGxq4Z/9xHw==
X-Google-Smtp-Source: ABdhPJxE/dHX+9xmPplXl1VvJP7kBTi3tiLgJTGk2+Y/ZJni8J0n6I1+6ACqdKe2xRydNCRf+KVUww==
X-Received: by 2002:ac8:7ca4:: with SMTP id z4mr750427qtv.526.1644262051598;
        Mon, 07 Feb 2022 11:27:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id de15sm5546110qkb.107.2022.02.07.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 11:27:31 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nH9fe-000HwP-GM; Mon, 07 Feb 2022 15:27:30 -0400
Date:   Mon, 7 Feb 2022 15:27:30 -0400
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
Subject: Re: [PATCH 4/8] mm: move free_devmap_managed_page to memremap.c
Message-ID: <20220207192730.GE49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-5-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:32:45AM +0100, Christoph Hellwig wrote:
> free_devmap_managed_page has nothing to do with the code in swap.c,
> move it to live with the rest of the code for devmap handling.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mm.h |  1 -
>  mm/memremap.c      | 21 +++++++++++++++++++++
>  mm/swap.c          | 23 -----------------------
>  3 files changed, 21 insertions(+), 24 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
