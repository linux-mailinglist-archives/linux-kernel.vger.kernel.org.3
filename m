Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8ECD496720
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiAUVJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiAUVJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:09:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10F2C06173B;
        Fri, 21 Jan 2022 13:09:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6010961827;
        Fri, 21 Jan 2022 21:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D19CC340E1;
        Fri, 21 Jan 2022 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642799347;
        bh=R9IH1HO9BhkurxhbfZ/tA3xkofYRaHlskaeE4j+DY68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebzQK3QhDgT/T2L/u8OlnNiGo3KbbTl6h5ztLuRo1EU0Nh4K9UOFn3pXR7raSTmaG
         zE3L4EdP2ms0NyP6lev85hl9EIsezgehE/pUfqaLG0gXcC3+/2A+SjmPIbGa2sP1pk
         bKGXZgtEWFaXVNC7112ut1J7kKrMo+Himt6b7mB9SFooC4k09b7wEelxbAQZ5aEyqE
         JWLhRSyRXJUhUT8f3B/Ze08E0f7ZogB7WGNplgY5cWZndUY8Li3DPefIfG7mpRHxRj
         KIP+WqjvZelxRCAkMN0e4ih4MMKnYbIwrlgRxeOztyM+sQ8S9ENjbX7yPWI81WI/RV
         rafEKwoAeV3lA==
Date:   Fri, 21 Jan 2022 13:09:05 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        m.heingbecker@googlemail.com,
        linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
Message-ID: <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 08:00:49PM +0100, Rafael J. Wysocki wrote:
> Hi Keith,
> 
> It is reported that the following commit
> 
> commit e5ad96f388b765fe6b52f64f37e910c0ba4f3de7
> Author: Keith Busch <kbusch@kernel.org>
> Date:   Tue Jul 27 09:40:44 2021 -0700
> 
>    nvme-pci: disable hmb on idle suspend
> 
>    An idle suspend may or may not disable host memory access from devices
>    placed in low power mode. Either way, it should always be safe to
>    disable the host memory buffer prior to entering the low power mode, and
>    this should also always be faster than a full device shutdown.
> 
>    Signed-off-by: Keith Busch <kbusch@kernel.org>
>    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>    Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> is the source of a serious power regression occurring since 5.15
> (please see https://bugzilla.kernel.org/show_bug.cgi?id=215467).
> 
> After this commit, the SoC on the affected system cannot enter
> C-states deeper than PC2 while suspended to idle which basically
> defeats the purpose of suspending.
> 
> What may be happening is that nvme_disable_prepare_reset() that is not
> called any more in the ndev->nr_host_mem_descs case somehow causes the
> LTR of the device to change to "no requirement" which allows deeper
> C-states to be entered.
> 
> Can you have a look at this, please?

I thought platforms that wanted full device shutdown  behaviour would
always set acpi_storage_d3. Is that not happening here?
