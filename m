Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B325A13CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242220AbiHYOhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiHYOhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:37:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA50B088F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661438208; x=1692974208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/y3fp64Y84mqoHz9wLswfR7VEygz7HcdXW/7bEoALks=;
  b=UOXNGmkJ//dLWnvkUwYTNR/nX6QxSWr+hHWL1api4eqlwxASNCQIGqhW
   FMcOzzlk9pgoLQicAhQ5GIk/ifB72Z8JPJShuTd7aLFaawvoiJbNf2Kg5
   r5cpOxhM5JKRQerqItuOIRWVWSAuQgVw52E9hntFD3oYQ7e8R0oUP6NoI
   7c5pQWjEbMawQhFP1DZdVCKbMpHtxk+0aANOhhN7i+OIYt6SAHjT0bjNJ
   HmzyGypK0xQaP9V9eVStAPOC5jwEv2ufrdOw2WUF22THV3ZFWtpjJ4QZp
   ouMsDbEcwocOzpoVwJpUucsSS1qgl15PnJi9gUPCUePg81KJnCk3xsGH8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="292995211"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="292995211"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 07:36:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="938346393"
Received: from alanjaco-mobl3.gar.corp.intel.com (HELO [10.252.44.53]) ([10.252.44.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 07:36:43 -0700
Message-ID: <718d6503-f284-2cd4-c0a0-b8e90547bee6@linux.intel.com>
Date:   Thu, 25 Aug 2022 14:39:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] soundwire: bus: Don't lose unattach notifications
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, jack.yu@realtek.com
References: <20220825122241.273090-1-rf@opensource.cirrus.com>
 <20220825122241.273090-3-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220825122241.273090-3-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/22 14:22, Richard Fitzgerald wrote:
> Ensure that if sdw_handle_slave_status() sees a peripheral
> has dropped off the bus it reports it to the client driver.
> 
> If there are any devices reporting on address 0 it bails out
> after programming the device IDs. So it never reaches the second
> loop that calls sdw_update_slave_status().
> 
> If the missing device is one that is now showing as unenumerated
> it has been given a device ID so will report as attached next
> time sdw_handle_slave_status() runs.
> 
> With the previous code the client driver would only see another
> ATTACHED notification because the UNATTACHED state was lost when
> sdw_handle_slave_status() bailed out after programming the
> device ID.
> 
> This shows up most when the peripheral has to be reset after
> downloading updated firmware and there are multiple of these
> peripherals on the bus. They will all return to unenumerated state
> after the reset, and then there is a mix of unattached, attached
> and unenumerated PING states from the peripherals, as each is reset
> and they reboot.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/bus.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 704f75c0bae2..bb8ce26c68b3 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1756,6 +1756,11 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
>  			dev_warn(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
>  				 i, slave->status);
>  			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
> +
> +			/* Ensure driver knows that peripheral unattached */
> +			ret = sdw_update_slave_status(slave, status[i]);
> +			if (ret < 0)
> +				dev_warn(&slave->dev, "Update Slave status failed:%d\n", ret);

This is indeed a good fix, this will make sure the driver will
re-initialize the device when it reports as ATTACHED again.

The codec driver needs to keep track on the UNATTACHED change though.

This is the case in all codec drivers except rt715 and rt715-sdca.
Something to change in a follow-up patch (cc: Jack Yu).

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

>  		}
>  	}
>  
