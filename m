Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB035AD217
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbiIEMIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiIEMI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846945E317
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662379707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2nwyShCFZbZOZb3RqUUSZIoZqzOmpN20eUJtd5XLm+U=;
        b=IwxRvA+oogGeE0U8nWzS656xNbGRCClfT5uyCkKTC8tzTFycf32ypUp/rW/RtgR7HMTTyF
        SNTL3LtMEoU3IzIUnVHzM0mVYflcrw1iBS98WJCWd9SA6o35sRMEHx+yIjc4FciyN5d8Hj
        dBVuFs9ohrWhhvZ6b3PCIhuWca3uxww=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-VPX3JYRiOW28KDwXPsBZ3g-1; Mon, 05 Sep 2022 08:08:22 -0400
X-MC-Unique: VPX3JYRiOW28KDwXPsBZ3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 869F880418F;
        Mon,  5 Sep 2022 12:08:21 +0000 (UTC)
Received: from localhost (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7B971121314;
        Mon,  5 Sep 2022 12:08:20 +0000 (UTC)
Date:   Mon, 5 Sep 2022 20:08:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, ardb@kernel.org,
        guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
        will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <YxXmsKYGTd1+/U12@MiWiFi-R3L-srv>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
 <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org>
 <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
 <YxXPannyTqBZInAt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxXPannyTqBZInAt@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/22 at 01:28pm, Mike Rapoport wrote:
> On Thu, Sep 01, 2022 at 08:25:54PM +0800, Baoquan He wrote:
> > On 09/01/22 at 10:24am, Mike Rapoport wrote:
> > 
> > max_zone_phys() only handles cases when CONFIG_ZONE_DMA/DMA32 enabled,
> > the disabledCONFIG_ZONE_DMA/DMA32 case is not included. I can change
> > it like:
> > 
> > static phys_addr_t __init crash_addr_low_max(void)
> > {
> >         phys_addr_t low_mem_mask = U32_MAX;
> >         phys_addr_t phys_start = memblock_start_of_DRAM();
> > 
> >         if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
> >              (phys_start > U32_MAX))
> >                 low_mem_mask = PHYS_ADDR_MAX;
> > 
> >         return low_mem_mast + 1;
> > }
> > 
> > or add the disabled CONFIG_ZONE_DMA/DMA32 case into crash_addr_low_max()
> > as you suggested. Which one do you like better?
> > 
> > static phys_addr_t __init crash_addr_low_max(void)
> > {
> >         if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
> > 		return PHYS_ADDR_MAX + 1;
> > 
> >         return max_zone_phys(32);
> > }
>  
> I like the second variant better.

Sure, will change to use the 2nd one . Thanks.

