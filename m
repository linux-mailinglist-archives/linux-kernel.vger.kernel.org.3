Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238FD47DF37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346665AbhLWG6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:58:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47686 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLWG6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:58:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D963B81F7F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 06:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD26C36AE9;
        Thu, 23 Dec 2021 06:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640242684;
        bh=EzQ75FlGoi7auE3z70CQ4I37sP8CGTCjYus3IThKn/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WyFNywQhsRhKX4zrOb0FMUOoVf5QlZCAYU21WCoLjDQjraAXHYYiJJCxAVohR6Ls1
         zgldUacvdHGfe3aWUR33MMa80gxKPehT1qpZ6A5jdlxXfzFXiru/mFG8/aXn8COZnt
         p8Kusleb31RMVIq4RTVeiwtRoddnw0rnP4QBUBT7hrmxitZwwh1MecaoCf+E9ISDOo
         zg4NJL4aXEsa3cXnIW2N+rHsJoTI+ij6SCS2QzvCdh8VptVPvJ2QCYoej45zOA1v1O
         IWEF3rlnr2GDE0uWXfuy1QTMhxCX5OmaHHE0/J0YR2TCIaEJOu+Dy/yL8D085ZRadQ
         phxi6arp/e32w==
Date:   Thu, 23 Dec 2021 12:28:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 6/7] soundwire: intel: remove unnecessary init
Message-ID: <YcQd+FTe+C4/Xpt1@matsya>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <20211213054634.30088-7-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211213054634.30088-7-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-21, 13:46, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> cppcheck warning:
> 
> drivers/soundwire/intel.c:1487:10: style: Variable 'ret' is assigned a
> value that is never used. [unreadVariable]
>  int ret = 0;
>          ^
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index e946d1283892..45ea55a7d0c8 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1613,7 +1613,7 @@ static int __maybe_unused intel_pm_prepare(struct device *dev)
>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
>  	struct sdw_bus *bus = &cdns->bus;
>  	u32 clock_stop_quirks;
> -	int ret = 0;
> +	int ret;

Ideally this should not be part of this series!

If Mark wants to pick:

Acked-By: Vinod Koul <vkoul@kernel.org>

>  
>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
>  		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
> -- 
> 2.17.1

-- 
~Vinod
