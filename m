Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90637585157
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiG2OMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiG2OM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:12:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F642AFE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659103948; x=1690639948;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pYLu+/XtQC5jDjQKiAKoXPu334NKExW5okhxadAJE0c=;
  b=Lab/pdoKzfRwMmUlFfeheNwGSNstIDscMPRQcKNwKG6D37wzLOiv7D5N
   pHyyu7TXayDtV+VXnjOR3g8279u8XJFbTyj+2t7R1+WMcwmwGu0RwOH3U
   FNrdVIu06A09WMLISyEQZ8I8CskcuOScc5w+KdMBB6dRBWfpt1ljfmqKm
   gSLWO2ztzq32cKuA6sACmbm8SGATB5G3QZMR+upHOVX9sjw09klE8pxrw
   8E9/lwyHbB6+mtnkZhRbqdk3gbtWXUpktFhy8bcAGVR54C1ZbygLiVtyk
   yeBkog1G+AaUm4vwsWRPnQucfW/0P8ftnxqeRVb8EN0LAkZdaAd64sImO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="269156960"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="269156960"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:12:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="660249430"
Received: from kaholo-mobl.amr.corp.intel.com (HELO [10.212.97.86]) ([10.212.97.86])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:12:17 -0700
Message-ID: <be630e3a-3b3b-48cf-d61c-840ab04f1140@linux.intel.com>
Date:   Fri, 29 Jul 2022 09:12:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 3/5] soundwire: sysfs: have the driver core handle the
 creation of the device groups
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-3-gregkh@linuxfoundation.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220729135041.2285908-3-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 893296f3fe39..81c77e6ddbad 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -193,6 +193,7 @@ int __sdw_register_driver(struct sdw_driver *drv, struct module *owner)
>  
>  	drv->driver.owner = owner;
>  	drv->driver.probe = sdw_drv_probe;
> +	drv->driver.dev_groups = sdw_attr_groups;
>  
>  	if (drv->remove)
>  		drv->driver.remove = sdw_drv_remove;

Minor rebase issue: this version of the bus_type.c code is no longer
up-to-date, this patch creates a conflict with "soundwire: bus_type: fix
remove and shutdown support" merged by Vinod - should be in your
char-misc tree as well for 5.20.

++<<<<<<< HEAD

 +      drv->driver.remove = sdw_drv_remove;

 +      drv->driver.shutdown = sdw_drv_shutdown;

++=======

+       drv->driver.dev_groups = sdw_attr_groups;

+

+       if (drv->remove)

+               drv->driver.remove = sdw_drv_remove;

+

+       if (drv->shutdown)

+               drv->driver.shutdown = sdw_drv_shutdown;

++>>>>>>> soundwire: sysfs: have the driver core handle the creation of
the device groups


Fixing it locally and testing.

