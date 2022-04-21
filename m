Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF758509AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386829AbiDUIrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386833AbiDUIr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CAF2E088
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650530676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BjQSABeMSCNqX6QeqXkLKcmoGWtgGGp59tDCHP5J+Ac=;
        b=U9fts13R7ndn+mM5WltAWP9vGtX8uPqwzN4qe28XhLpKToe0z9S2RxHcIYoggIIadZUceo
        sXDFpsohsexiQPZ+C7G1NQEFNa3uNjUzhTSg1N8FH3rVBiUoCb03sK/iy8ku/4hT9Kt9od
        4zAoOAwL2cfmpOjO0mDp42WXCgy/uhw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-0J7M2KjINFGZRo_4p2zHfQ-1; Thu, 21 Apr 2022 04:44:35 -0400
X-MC-Unique: 0J7M2KjINFGZRo_4p2zHfQ-1
Received: by mail-oo1-f72.google.com with SMTP id w3-20020a4a3543000000b003247262c123so2173551oog.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjQSABeMSCNqX6QeqXkLKcmoGWtgGGp59tDCHP5J+Ac=;
        b=wEtVJBGHFg2kJvBsi68WZR8FQDMkU/CgSCvbgm/7+WchR6tkPjM1WQd+CsxAC86nwJ
         PsucUAVEiQjxO+AwNqBU58/P/Z1HfjS0QkUmsCf3/cNbl8TZ39hh8AB9f2LH13mUb2hC
         oc+4ui3Fh1OMvArl4bKH5zDyyM4RGXkTcYKI0LLRCQAk1VKVDZOFtpwkI+ZLQP6gYxvf
         DGig3MIXdv0cd1EWvGpeaBsWrFdpIITas5IPT/1BX8M8LutiMY37fRl6hRTK67a7oD7t
         5gYfJfk5Dv8Tvq2q4FEviAOCWtWa1ZLSYeeidjaJLQXabDnCvkf++M4Jj4GdMrS5axnj
         UU9w==
X-Gm-Message-State: AOAM532a4tlobADCm99xMNvDBfQiNSCUW1PSojPyGa8vb4RqplofUI0P
        N5+B0x/fCup0wbqphBPYLAMiXlTeaShqOHFDg5rz6vpvmk7j8vzN9XnVo7YiiNi8FEG4eS8gZ6t
        d21egQDt+zxzpj3nCpMIOIUAIhjHIgTJveuqxgP0u
X-Received: by 2002:a05:6870:2425:b0:de:2fb0:1caa with SMTP id n37-20020a056870242500b000de2fb01caamr3414757oap.115.1650530674561;
        Thu, 21 Apr 2022 01:44:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdqtMEDqqtdXHubsX3CoXNlFqsCvKkohk+MVa9R3FD88YtrXojSCIPXizce5GQSkfV5YslLb64htiFdppcjRU=
X-Received: by 2002:a05:6870:2425:b0:de:2fb0:1caa with SMTP id
 n37-20020a056870242500b000de2fb01caamr3414749oap.115.1650530674370; Thu, 21
 Apr 2022 01:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220420195425.34911-1-logang@deltatee.com>
In-Reply-To: <20220420195425.34911-1-logang@deltatee.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Thu, 21 Apr 2022 16:45:20 +0800
Message-ID: <CALTww28fwNpm0O_jc7-2Xr0JSX9i6F1kgoUQ8m_k6ZgPa1XxXw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Improve Raid5 Lock Contention
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 3:55 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hi,
>
> This is v2 of this series which addresses Christoph's feedback and
> fixes some bugs. The first posting is at [1]. A git branch is
> available at [2].
>
> --
>
> I've been doing some work trying to improve the bulk write performance
> of raid5 on large systems with fast NVMe drives. The bottleneck appears
> largely to be lock contention on the hash_lock and device_lock. This
> series improves the situation slightly by addressing a couple of low
> hanging fruit ways to take the lock fewer times in the request path.
>
> Patch 9 adjusts how batching works by keeping a reference to the
> previous stripe_head in raid5_make_request(). Under most situtations,
> this removes the need to take the hash_lock in stripe_add_to_batch_list()
> which should reduce the number of times the lock is taken by a factor of
> about 2.
>
> Patch 12 pivots the way raid5_make_request() works. Before the patch, the
> code must find the stripe_head for every 4KB page in the request, so each
> stripe head must be found once for every data disk. The patch changes this
> so that all the data disks can be added to a stripe_head at once and the
> number of times the stripe_head must be found (and thus the number of
> times the hash_lock is taken) should be reduced by a factor roughly equal
> to the number of data disks.
>
> The remaining patches are just cleanup and prep patches for those two
> patches.
>
> Doing apples to apples testing this series on a small VM with 5 ram
> disks, I saw a bandwidth increase of roughly 14% and lock contentions
> on the hash_lock (as reported by lock stat) reduced by more than a factor
> of 5 (though it is still significantly contended).
>
> Testing on larger systems with NVMe drives saw similar small bandwidth
> increases from 3% to 20% depending on the parameters. Oddly small arrays
> had larger gains, likely due to them having lower starting bandwidths; I
> would have expected larger gains with larger arrays (seeing there
> should have been even fewer locks taken in raid5_make_request()).


Hi Logan

Could you share the commands to get the test result (lock contention
and performance)?

Regards
Xiao

