Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E050976A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384779AbiDUGVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351437AbiDUGVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:21:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D73913DEA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3504CB82144
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5D8C385A8;
        Thu, 21 Apr 2022 06:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650521940;
        bh=A35b6aKRsL1WwiGliC0xhlYgiek83WbVQ2sMW6EUJFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwQSKgz9wmmf3NTHwQ7BL7vY4Kq7wavgmKcqaRF5TrXK7jaUHnRNToOOspvdy6hlo
         6to0dKDvh2nbK8PmOE6osbSae/us5OnLriUJdcuZTLw2J5ErH//2rN7Zmkg2gQw1p2
         4wM1kL4ld6nl+N3yFcLFSsrrpekQ+2h/M3FwRU2I=
Date:   Thu, 21 Apr 2022 08:18:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, reinette.chatre@intel.com
Subject: Re: [PATCH v3 1/9] drivers: base: Add hardware prefetch control core
 driver
Message-ID: <YmD3UX6aTvUXlYF5@kroah.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
 <20220420030223.689259-2-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420030223.689259-2-tarumizu.kohei@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 12:02:15PM +0900, Kohei Tarumizu wrote:
> This driver adds the register/unregister function to create the
> "prefetch_control" directory and some attribute files. Attributes are
> only present if the particular cache implements the relevant
> prefetcher controls
> 
> If the architecture has control of the CPU's hardware prefetcher
> behavior, use this function to create sysfs. When registering, it is
> necessary to provide what type of hardware prefetcher is supported
> and how to read/write to the register.
> 
> Following patches add support for A64FX and x86.
> 
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> ---
>  drivers/base/pfctl.c  | 458 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pfctl.h |  49 +++++
>  2 files changed, 507 insertions(+)
>  create mode 100644 drivers/base/pfctl.c
>  create mode 100644 include/linux/pfctl.h

Thanks to Thomas for pointing this change out to me.

Why did you not use get_maintainer.pl on your patch?  You are adding
files here that you want _me_ to maintain for the next 25+ years, yet
not asking for my review?  That's not nice, and for that reason alone I
would not accept this change.

Also, this is very hardware-specific, which is not a good thing for code
in drivers/base/  See the mess we have in the topology driver core code
for examples of that mess :(

greg k-h
