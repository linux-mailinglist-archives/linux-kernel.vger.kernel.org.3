Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2B492B96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbiARQxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:53:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52092 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiARQxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:53:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A47A1B816E3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 16:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC88C340E0;
        Tue, 18 Jan 2022 16:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642524808;
        bh=hj6cgF8nqJUDMXfSevCsDKP3HTwnEamooJYkoM7Kvns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cI/3+ELb1BO7XjuTEVngbV/xxNGYbpZJOS87HYLo3jL/W9zr4VIkXF/j+dr1KzeB5
         Y6UJE6RbT6KBGFSFyXF/JJY84pQf8y6RngMXN8PO6Kta7EOw2X0u+K6tkYlObhXBFs
         25A/VWJUZMDedKwIZ8u3svG5O3LJfq/iZzvu0O6LYipOlmnQFchv4wVNM3B/41XCA7
         +oj7aRU332K+PadAKKj6JaKugkbGvhJRGj59KBKNN1URwG5XXGWUz2iP/7lighYZOv
         FzLzYvS+fpKVMoTsQ5EoIp75D5NEm8XvSCkQwXTwvNwOQPndKrCzBKm1zlIlkMmmS7
         IEsRPgff81FBA==
Date:   Tue, 18 Jan 2022 08:53:25 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: nvme: IO_PAGE_FAULT logged with Intel SSDPEKKF512G8
Message-ID: <20220118165325.GA3301052@dhcp-10-100-145-180.wdc.com>
References: <366b1545-fdea-3423-10a7-308ca2bef746@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366b1545-fdea-3423-10a7-308ca2bef746@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 03:32:45PM +0100, Paul Menzel wrote:
> On a Dell OptiPlex 5055 with an Intel SSDPEKKF512G8, Linux 5.10.82 reported
> an IO_PAGE_FAULT error. This is the first and only time this has happened.
> 
>     $ dmesg --level=err
>     [    4.194306] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc080 flags=0x0050]
>     [    4.206970] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc000 flags=0x0050]
>     [    7.327820] kfd kfd: VERDE  not supported in kfd
>     $ lspci -nn -s 01:00.0
>     01:00.0 Non-Volatile memory controller [0108]: Intel Corporation SSD Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03)

I think it's a bug with the iommu implementation. If it causes problems,
you can typically work around it with kernel parameter "iommu=soft".
