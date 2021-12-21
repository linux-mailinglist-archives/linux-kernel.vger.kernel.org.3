Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C6D47BCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbhLUJb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbhLUJb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:31:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF1AC061574;
        Tue, 21 Dec 2021 01:31:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900E26149F;
        Tue, 21 Dec 2021 09:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727F5C36AE2;
        Tue, 21 Dec 2021 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640079085;
        bh=yvxQ4XoLsMIX+Y8XPJ7+rWyqlktIq865SJFV9MrUjMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0AESIwz7hKmjvdcscuowBfcbmlkCyOmIh8p/yvzZhhxcCb+qE23Y5FHXiIbRsqc7t
         u5Q84KA0u48A/KK2dJo1ELvYhriAwI7ZfnGmvT0ZNLjtLIlT+wr7b5sxqs1jlRGupf
         7oMl8kHKhTksuXTrlCVSfOXYocmwcZFhrBJTZ4Sc=
Date:   Tue, 21 Dec 2021 10:31:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/6] cacheinfo: CPU affinity and Devicetree 'id' support
Message-ID: <YcGe6prlqTknbYj6@kroah.com>
References: <20211216233125.1130793-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216233125.1130793-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:31:19PM -0600, Rob Herring wrote:
> For upcoming Arm MPAM support in resctrl, it is necessary to have the
> cacheinfo 'id' for MPAM enabled caches. The 'id' is part of the resctrl
> ABI. While this support already exists for ACPI based systems, it is
> missing for DT. This series adds the support.
> 
> The 'id' value used is the smallest CPU h/w id value associated with a
> cache. This requires walking the cache hierarchy from every CPU node to
> get all CPUs associated with a cache. As MPAM also needs to know this,
> the CPU affinity is also saved to avoid reimplementing and walking the
> firmware tables again.
> 
> Patches 1 and 2 are v2 from the prior series[1]. The rest are new.
> 
> Tested on arm64 with DT. ACPI changes are untested. I don't have a
> system with an appropriate PPTT nor do I know how to modify ACPI tables.
> 
> Rob
> 
> [1] https://lore.kernel.org/all/20211006164332.1981454-1-robh@kernel.org/
> 
> Rob Herring (6):
>   cacheinfo: Allow for >32-bit cache 'id'
>   cacheinfo: Set cache 'id' based on DT data
>   cacheinfo: Add cpu_affinity_map to store affinity for all CPUs
>   ACPI / PPTT: Populate the cacheinfo.cpu_affinity_map
>   cacheinfo: Use cpu_affinity_map for populating shared_cpu_map
>   cacheinfo: Add cacheinfo_get_cache_affinity() function
> 
>  drivers/acpi/pptt.c       | 29 +++++++++++++++--
>  drivers/base/cacheinfo.c  | 65 ++++++++++++++++++++++++++-------------
>  include/linux/cacheinfo.h | 29 +++++++++++++++--
>  3 files changed, 97 insertions(+), 26 deletions(-)
> 
> -- 
> 2.32.0
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
