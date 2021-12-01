Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03DC4648E6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347706AbhLAHiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347643AbhLAHiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:38:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091D0C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 23:34:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3A16B81BBE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A731AC53FAD;
        Wed,  1 Dec 2021 07:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638344081;
        bh=Gi1ryJPlruKkzmqv9Lpvb04zMwMOMhA8gauwZ1U0qco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3jmGlQkw3cuMDCtnSx2NRJ+5s2o3+wSwJG1pBoHQNwxWEkEmFnLWbymFsMxqssrf
         OTwKGZTgTVsMrR87tMXCK+FaiDulMgV3bN1uW0MM/NQGC6i7bmBdRlds8L+iQvi+0N
         LF0416nr9VP8GdK9aqJWzmTw1yyWRSt6fK+cTYa0=
Date:   Wed, 1 Dec 2021 08:34:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, riel@redhat.com,
        mchehab+huawei@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, corbet@lwn.net, ionela.voinescu@arm.com,
        pcc@google.com, bilbao@vt.edu, matorola@gmail.com,
        rafael@kernel.org
Subject: Re: [PATCH] docs: document the sysfs ABI for "nohz_full" and
 "isolated"
Message-ID: <YacljAVpgcjkayCg@kroah.com>
References: <20211201071852.3568489-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201071852.3568489-1-tarumizu.kohei@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 04:18:52PM +0900, Kohei Tarumizu wrote:
> Add missing documentation of sysfs ABI for "nohz_full" and "isolated".
> "nohz_full" was added by commit 6570a9a1ce3a("show nohz_full cpus in
> sysfs") and "isolated" was added by commit 59f30abe94bf("show isolated
> cpus in sysfs"). However, there is no documentation for these
> interface.
> 
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 69c65da16dff..a9d5d87b6a41 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -666,3 +666,16 @@ Description:	Preferred MTE tag checking mode
>  		================  ==============================================
>  
>  		See also: Documentation/arm64/memory-tagging-extension.rst
> +
> +What:		/sys/devices/system/cpu/nohz_full
> +		/sys/devices/system/cpu/isolated
> +Date:		Apr 2015
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	information about CPU isolation.
> +
> +		nohz_full: (RO) the list of CPUs that are in nohz_full mode.
> +			   These CPUs are set by boot parameter "nohz_full=".
> +
> +		isolated: (RO) the list of CPUs that are isolated and don't
> +			  participate in load balancing. These CPUs are set by
> +			  boot parameter "isolcpus=".

These should be two different entries, not one please.

thanks,

greg k-h
