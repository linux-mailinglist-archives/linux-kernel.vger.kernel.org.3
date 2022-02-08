Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388124AD2D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348908AbiBHIJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiBHIJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:09:40 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784A7C0401EF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:09:40 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v186so47709986ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DC5h5QPa2MMSD8jMuUZaOZTMv0rKCEv7tr+WwakctiM=;
        b=UKt/5gqtEQEDR+I4jR//5bWv57hPVaW9KmAr8xHRshFW+V9PDSWkFrBE8Hyb8wlSkA
         QQKQ+stzgyEgp5J4DyVY4bvPNBtHP4wSzJ6uJck+8cplu8GPkuIVWQ+Y8zm1xv27s0Zu
         cR2ljgqob8w9EmBGVw0EdJVkId5N+xNPUHeADg5epuSLdcXTrW9Tqo5OcA22EaRu8U3K
         l3cuLzKBbOc9GbQXk+h497gXyT6KtsqpW966ysKE5jotsGOXr7l3B+dKnggATk5GoyUy
         KJOt1xwxzqYiEqEVIBRmXg0oLWnTj4m1q1+iR+FtOucXjtQu9GfhLJMBe3O/kYgazNfR
         tnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DC5h5QPa2MMSD8jMuUZaOZTMv0rKCEv7tr+WwakctiM=;
        b=OafxFoHz1oOiGrgQDdCEoRA3DqcwOJzSK/dFs/YnOhzM+gyEfjHmv1jeIlDJZfW4Q2
         nt6qXaQCduRieqyHriWXIw+qG/OqrudoYxbi33yY4qKf7odG2lNlO7V+zxNdOL8fKY2K
         h3KYeZk9mnHDW0DyGiDF+9Id4iqqfw6QqInny2vqCq4mHVxFAO0lyJckIs1vcYePUEZz
         MYMb2aioWu/RzfU9lhE4hIpQi2H9ZI8IUWDS/DuF11gil5B6Nzn+pUoVq1/bcL+kGqlQ
         4wUnoZdydDdmUN1DFzMMmvNJI1TEV8gGlRrml2M7KyEcgSx6lh4wIaVhyI3ZYeYoePEU
         k56Q==
X-Gm-Message-State: AOAM530ASzqYYA7W1DmwHpZhpvZfV3z47BFPr5rXfAl1urDsAK16cHTe
        WKv9mDMrujXJlQ8tpqhqiuyUjLKGKsq9v6r1MBx2KA==
X-Google-Smtp-Source: ABdhPJyFSmuR7M4HIJ31YSJoOUpobAKTBK69kzVotLKdLdB2NRipgBTZ2XLKWECEqSNiqnwAnFetqc4Ion8CCMp0OGY=
X-Received: by 2002:a81:ad46:: with SMTP id l6mr3668263ywk.31.1644307779769;
 Tue, 08 Feb 2022 00:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de> <20220207063249.1833066-5-hch@lst.de>
In-Reply-To: <20220207063249.1833066-5-hch@lst.de>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 8 Feb 2022 16:09:03 +0800
Message-ID: <CAMZfGtUqbU9VpCOA-9bdU6d1CoQ7n8D+26v4j79uLcH1uc5Q2w@mail.gmail.com>
Subject: Re: [PATCH 4/8] mm: move free_devmap_managed_page to memremap.c
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
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 2:42 PM Christoph Hellwig <hch@lst.de> wrote:
>
> free_devmap_managed_page has nothing to do with the code in swap.c,
> move it to live with the rest of the code for devmap handling.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
