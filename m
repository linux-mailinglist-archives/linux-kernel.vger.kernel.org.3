Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE5557492
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiFWHzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiFWHza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:55:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9A47061
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFA6C61B01
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96720C3411B;
        Thu, 23 Jun 2022 07:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655970928;
        bh=+mCsuKkg6J4843YgoICH76eZkbbsWWPv4bN1r397BFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryn/wFyICQZLHrQUR7HdI9ruJoyDQO4rvJTV6kIaJItCZA7TrYXFQmtn+C1MFr4t0
         Uggw5RZjt97WHgadbomOND0G6IEZVUow7NnL/t9Pb4N8pJp2ZkGR/ii4JnaToVqnUD
         yXqGhU1qM/T3Hhvo+I9ObGBIA9i2oO6j4COS/yg9GliuywGOj4iAqFrizLnQ86AcKw
         sHvytYP4CY/UskGrquWz8o+i05nr3LIv4ffQh3raROCD5oYgeBxE+NKBwzaT95QJZR
         P+FmP3Aaf445fPgIO674cr+tUwXte0DfPKpMNrv00V7FTaqE6FB7hi0e/c1hoXLGe7
         ZYlLam1dG7i+g==
Date:   Thu, 23 Jun 2022 13:25:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: bus_type: fix remove and shutdown support
Message-ID: <YrQca7YH8v6XCl02@matsya>
References: <20220610015105.25987-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610015105.25987-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-06-22, 09:51, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The bus sdw_drv_remove() and sdw_drv_shutdown() helpers are used
> conditionally, if the driver provides these routines.
> 
> These helpers already test if the driver provides a .remove or
> .shutdown callback, so there's no harm in invoking the
> sdw_drv_remove() and sdw_drv_shutdown() unconditionally.

Okay sounds good

> In addition, the current code is imbalanced with
> dev_pm_domain_attach() called from sdw_drv_probe(), but
> dev_pm_domain_detach() called from sdw_drv_remove() only if the driver
> provides a .remove callback.

Am not sure I follow what is imbalance, pm_domain_attach/detach?

> Fixes: 9251345dca24b ("soundwire: Add SoundWire bus type")

How is this a fix is still unclear to me. At best I think this is code
optimization and removing checks which maybe redundant.

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/bus_type.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 893296f3fe39..b81e04dd3a9f 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -193,12 +193,8 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
>  
>  	drv->driver.owner = owner;
>  	drv->driver.probe = sdw_drv_probe;
> -
> -	if (drv->remove)
> -		drv->driver.remove = sdw_drv_remove;
> -
> -	if (drv->shutdown)
> -		drv->driver.shutdown = sdw_drv_shutdown;
> +	drv->driver.remove = sdw_drv_remove;
> +	drv->driver.shutdown = sdw_drv_shutdown;
>  
>  	return driver_register(&drv->driver);
>  }
> -- 
> 2.17.1

-- 
~Vinod
