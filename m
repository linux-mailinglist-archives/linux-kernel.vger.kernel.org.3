Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3147426C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhLNMZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:25:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48596 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbhLNMZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:25:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30CDAB818CB;
        Tue, 14 Dec 2021 12:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647AEC34601;
        Tue, 14 Dec 2021 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639484713;
        bh=LkfGUfvFD+wuUSnndYTIRV0genugsEqlsotLmVgUpFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1JPppxRaFBP/q4CNAFpyT224TMXutjmOxmPTPtpBSyniTE//7qko6c9meT8C96bK
         lQoBTbDsJhfVDDDWZBdp2Vy5H3q2QY8S5KBwLSxWKvd1Ee8ipMwSfFSBOPMNAASTGR
         VDJ2xWXMcoYSF25puyufFJsDyVp1wekhWsQLea9BgkGZdZeJ0NY/Yl1ZOtxLNCusye
         sYzew8KKiZMerHiT3P/aAt9TZ9VQ+ghjNFPD+oKnJPyYCOKLFHZ7pDedgW1m+FcciH
         6UeG2RE9ZKd1Y7JIG+nuLPgCGlJRFxs4AbW98HIKFFPRL143ctSTEKr0TrZHT9GJnS
         yEhZD3NJq0Hjg==
Date:   Tue, 14 Dec 2021 12:25:08 +0000
From:   Will Deacon <will@kernel.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, bbudiredla@marvell.com,
        sgoutham@marvell.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] perf/marvell: cn10k DDR perf event core ownership
Message-ID: <20211214122507.GC14247@willie-the-truck>
References: <20211029115643.32351-1-bbhushan2@marvell.com>
 <20211029115643.32351-5-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029115643.32351-5-bbhushan2@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 05:26:43PM +0530, Bharat Bhushan wrote:
> As DDR perf event counters are not per core, so they should be accessed
> only by one core at a time. Select new core when previously owning core
> is going offline.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v1->v6
>  - No Change
> 
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 50 ++++++++++++++++++++++++++--
>  include/linux/cpuhotplug.h           |  1 +
>  2 files changed, 49 insertions(+), 2 deletions(-)

I don't think the driver is much use without this patch, so please can you
move the Kconfig stuff to a patch at the end so that the driver can't be
enabled in a broken state half way through the series?

Will
