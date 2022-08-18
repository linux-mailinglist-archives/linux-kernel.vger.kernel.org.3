Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDDB597DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243458AbiHREld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243449AbiHREla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:41:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BA33204B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 21:41:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s206so410146pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 21:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=vBRqm9P3PucMWPQft7rdPQr1jzE78rWkm5My0QOmYqo=;
        b=UCQPCkZxgSVgVfRvBD0lBiCJunMG+AZUrfKK6u3u6vnAu8eN28E04dT7SORQZDT/VM
         geGH1MvNA8tLwbmpRVGFoYKnjvPZwZC5qqcwyGIc9K4Qur/gDNaayEpYMhGFdnxYfWxF
         eQ/VY6GbHcM2BV3Zl1TwZFSNOAWDstV+t2e3HMxeSbbtAQYAAIC6gWlk8t7RX+H8MKWq
         AjuvHOKJO/KH9jqWv1uwDRKFw6yCvW/qsEjgb3Kcri68s4VYK664rvNBFtgAubzsUut+
         QoD4UyyjK+RFDsMPOokQ2YSz4OnQ9a7r/9/G7bAil8/StmX0pYp8aLW5CnHvmbOSTxZN
         t+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vBRqm9P3PucMWPQft7rdPQr1jzE78rWkm5My0QOmYqo=;
        b=E5FgGwWEL3hWSjWHiScmuFf2VqxjqPLanqu7QxOk9m3waMqiIcaEdvK24bC3/QtAyf
         NmGY+VUnBcFTjxMeu91Uytr5koT2SaGUzZTsQYnzVQm44XfHlU9hl8G1JabLBAjC/m5W
         54Vx4h4ij26cWGllMcOZU2j4SK6cKK6jN+gue4CqbIbzi+QyVE/HOGdZhyrOMnd04rX3
         5oHuGojdIe/J5H9bMP1hlnPDgcntEzDpivgLu25eGU/cR8LCF0CBoO9OxLlYNiA306dP
         YkyJElPeZruZczjLxa6YgOiyW8GoiSZlrUcAd8JW8OHlS3d6xDKC9b2jibAH53oAcdu9
         QBsw==
X-Gm-Message-State: ACgBeo385dSVbkER+WC7y2p2IjY4u0AjY6w1koo7Z0fax8LNJi04xTP0
        7s+RqfhY1SZ8hZ4HMNfjXzM=
X-Google-Smtp-Source: AA6agR7ueq3jiFzDIJuD4hrbZTfz4hqe2+zWTcQBHHHcnXdOG0+5px+2XucU7nxCfUvB3L77RDBKfQ==
X-Received: by 2002:a63:6b81:0:b0:41c:3a8c:b4fe with SMTP id g123-20020a636b81000000b0041c3a8cb4femr1186114pgc.84.1660797689286;
        Wed, 17 Aug 2022 21:41:29 -0700 (PDT)
Received: from localhost ([2406:7400:63:e947:599c:6cd1:507f:801e])
        by smtp.gmail.com with ESMTPSA id r12-20020aa7962c000000b0052e988c1630sm411044pfg.138.2022.08.17.21.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 21:41:28 -0700 (PDT)
Date:   Thu, 18 Aug 2022 10:11:23 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] Make place for common balloon code
Message-ID: <20220818044123.q5yzdaszcxl7mcl6@riteshh-domain>
References: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
 <20220816094117.3144881-2-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816094117.3144881-2-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/16 12:41PM, Alexander Atanasov wrote:
> File already contains code that is common along balloon
> drivers so rename it to reflect its contents.
> mm/balloon_compaction.c -> mm/balloon_common.c
>
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  MAINTAINERS                                              | 4 ++--
>  arch/powerpc/platforms/pseries/cmm.c                     | 2 +-
>  drivers/misc/vmw_balloon.c                               | 2 +-
>  drivers/virtio/virtio_balloon.c                          | 2 +-
>  include/linux/{balloon_compaction.h => balloon_common.h} | 2 +-
>  mm/Makefile                                              | 2 +-
>  mm/{balloon_compaction.c => balloon_common.c}            | 4 ++--

>  mm/migrate.c                                             | 2 +-
>  mm/vmscan.c                                              | 2 +-
I think we don't need balloon headers in above two files at all.
I don't see any references of balloon functions in them.

I guess this commit removed it -

commit b1123ea6d3b3da25af5c8a9d843bd07ab63213f4
Author: Minchan Kim <minchan@kernel.org>
Date:   Tue Jul 26 15:23:09 2016 -0700

    mm: balloon: use general non-lru movable page feature

    Now, VM has a feature to migrate non-lru movable pages so balloon
    doesn't need custom migration hooks in migrate.c and compaction.c.

    Instead, this patch implements the page->mapping->a_ops->
    {isolate|migrate|putback} functions.

    With that, we could remove hooks for ballooning in general migration
    functions and make balloon compaction simple.

Since I don't often look into this side of code, it's better to confirm :)

-ritesh
