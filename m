Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230B95A0A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiHYHfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbiHYHfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507214D170
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661412914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/KHHMrmA8HFk2ILFS/S3jVPvSPT7uexAlYEbMs4sA0E=;
        b=Q3K/ktaL5djNo+d21CTG4/pXOhIM2T3IO+teGDrAo/LQKNI7uQr+8EaAofeoupR5mEq5Wi
        NEifuG0AkNrBb8I7bOBZ5l8g9eBErhdsVFaxCTcpXAJZlHC9pe3ZYbnIEL7SCBUyqq5k41
        vQ5RhxLWmOM12KwCHAKqb47mtMnw8c4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-ZtJcIqVGOgGj1CQMWQiYuw-1; Thu, 25 Aug 2022 03:35:11 -0400
X-MC-Unique: ZtJcIqVGOgGj1CQMWQiYuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DCB53C10682;
        Thu, 25 Aug 2022 07:35:10 +0000 (UTC)
Received: from localhost (ovpn-13-108.pek2.redhat.com [10.72.13.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 905CB2166B26;
        Thu, 25 Aug 2022 07:35:09 +0000 (UTC)
Date:   Thu, 25 Aug 2022 15:35:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 0/5] arm64/mm: remap crash kernel with base pages even if
 rodata_full disabled
Message-ID: <YwcmKAink5XvoaTe@MiWiFi-R3L-srv>
References: <20220819041156.873873-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819041156.873873-1-rppt@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kexec list in CC

On 08/19/22 at 07:11am, Mike Rapoport wrote:
> From: Mike Rapoport <mike.rapoport@gmail.com>
> 
> Hi,
> 
> There were several rounds of discussion how to remap with base pages only
> the crash kernel area, the latest one here:
> 
> https://lore.kernel.org/all/1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com
> 
> and this is my attempt to allow having both large pages in the linear map
> and protection for the crash kernel memory.
> 
> For server systems it is important to protect crash kernel memory for
> post-mortem analysis, and for that protection to work the crash kernel
> memory should be mapped with base pages in the linear map. 
> 
> On the systems with ZONE_DMA/DMA32 enabled, crash kernel reservation
> happens after the linear map is created and the current code forces using
> base pages for the entire linear map, which results in performance
> degradation.
> 
> These patches enable remapping of the crash kernel area with base pages
> while keeping large pages in the rest of the linear map.
> 
> The idea is to align crash kernel reservation to PUD boundaries, remap that
> PUD and then free the extra memory.

Hi Mike,

Thanks for the effort to work on this issue. While I have to say this
isnt's good because it can only be made relying on a prerequisite that
there's big enough memory. If on a system, say 2G memory, it's not easy
to succeed on getting one 1G memory. While we only require far smaller
region than 1G, e.g about 200M which should be easy to get. So the way
taken in this patchset is too quirky and will cause regression on
systemswith small memory. This kind of sytems with small memory exists
widely on virt guest instance.

The crashkernel reservation happens after linear map because the
reservation needs to know the dma zone boundary, arm64_dma_phys_limit.
If we can deduce that before bootmem_init(), the reservation can be
done before linear map. I will make an attempt on that. If still can't
be accepted, we would like to take off the crashkernel region protection
on arm64 for now.

Thanks
Baoquan

