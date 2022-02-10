Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89B54B09B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbiBJJkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:40:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiBJJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:40:11 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA810DF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:40:11 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v47so13693296ybi.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwSyjkWA8Xtx6McE/937H/83En/EAsN4/n12OaGn97U=;
        b=Q9U5MhFM50SJ6zKg3p/BHPAbW/1PqWiV8IwLRh7eYuvqYsefXz7JVtkApiN0D5tJs9
         NjgtZ08Kif7nIin7P9Lj3k6IR7GOTseT9s5laCSNNmTWHD2uCXfrqGfuutVuti7FabYq
         BBBAb4MnvkLH4UJThCTrI8+/mOnZaltJr+bpG6t9FkMSJZxm2G82RI22ShxjcihlxEsi
         Y82w37OnLpB5Xi9WU56u6QA7+3qLoNq0E7XxjqXpD9HrhneWbPs+sNufIntIIK3bmpgw
         cO6+9m8+iutxaFYcQMGptKVxtMwZN8MAWIOLV4hGp2W+29wbPx10LCsVwxL/brPe2+Mu
         8Ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwSyjkWA8Xtx6McE/937H/83En/EAsN4/n12OaGn97U=;
        b=g7PCgFJjXskOZmuTE0U2ws47tRW8BXDYgn2JYgWpCMVUDHY33/f8OQtwJwFTxynV9e
         GpR9bHknvgcw+9Xn0WgcR6kylLPu1lifcVOGyRxc26HlPUgkL3Z53QEs9hGkVREqVb6j
         jcjDXhWzkeUpEAYNk/1GYThC0sJFn3GxfyY6qr5t6omDIDAfX6oQ5R4NAyP8SFXj/bQy
         g8o+5RM/ZFMU2RtP4nqPZS9GPGR4RSCEV7mZ1MUkGD47gwgiQq+0YlMttXw4fIhkRnEf
         H6XMDSgzwXQZL7d17PhXRH3lS3q29S81wDVHGY68G+GcLiQ5BixTobdKZcZkrbVOPuMv
         lcQQ==
X-Gm-Message-State: AOAM533DoRrt8gfwyhbilu/jsmo+uYMCbLpgspi2SWLsyRLsRWUTdJF8
        vpaRh6uXMslU/VEGiqVKhkrIpaeLa9BJFqXZyTGXhv6atbHLUUG5
X-Google-Smtp-Source: ABdhPJyMOovS5IpsBIbmJvgp0LJOskYVPag8axtaKArSDLNMC4EYiKcUxfRUU3qBQ8ccmcQ6MqVRs4tbRTDCogGg4e4=
X-Received: by 2002:a25:4742:: with SMTP id u63mr6032141yba.523.1644486011092;
 Thu, 10 Feb 2022 01:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20220210072828.2930359-1-hch@lst.de> <20220210072828.2930359-4-hch@lst.de>
In-Reply-To: <20220210072828.2930359-4-hch@lst.de>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Feb 2022 17:39:34 +0800
Message-ID: <CAMZfGtWb9a8gN7DjaJngYi4aJLVHL74eKnXmctXC27QyarHsDQ@mail.gmail.com>
Subject: Re: [PATCH 03/27] mm: remove pointless includes from <linux/hmm.h>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, nvdimm@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 3:28 PM Christoph Hellwig <hch@lst.de> wrote:
>
> hmm.h pulls in the world for no good reason at all.  Remove the
> includes and push a few ones into the users instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
