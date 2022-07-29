Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A547E5851FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiG2PAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbiG2PAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:00:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AFF2BF6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659106846; x=1690642846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FK3X/i4IKUVcxCucyjEQGyuf8/mNmgO73urDBUCLv3U=;
  b=LrWnQOkXcsElygZx49mTS1RggI9A0lF6jCmnwVwyWLeqbpLPoItkZB+9
   MLleBFRNclEG85vivX1NoDcTLYmrKsTun9lhyogJf46v0LWTN7bom9pMv
   vVrFxsi0rte/JJN+bgT7LS+VOFmXGhlj5gLx1Q9/Azl7Zda8sQXUXAL2l
   prgPO9PA8O78/j+BzJX6WrPFs0NcYHAIKtYtBJA1GKIXZhi87iAE5XVVb
   NO9jbGvvYSBzeV2R89Lq4YGgYOAukGFwWJNXzcYxvv6GHfsXbFuzVUqjL
   DTy0UFGpqUA3f5azf/hxDKMQeMBLy/GhHT2DM0Zn76/wOCcANaUcHVb4k
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="314584055"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="314584055"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 08:00:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="604986191"
Received: from kaholo-mobl.amr.corp.intel.com (HELO [10.212.97.86]) ([10.212.97.86])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 08:00:42 -0700
Message-ID: <95dcb89d-bfc7-7bc4-5ec5-04537bc0758d@linux.intel.com>
Date:   Fri, 29 Jul 2022 10:00:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] soundwire: sysfs: remove sdw_slave_sysfs_init()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-4-gregkh@linuxfoundation.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220729135041.2285908-4-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> diff --git a/drivers/soundwire/sysfs_slave_dpn.c b/drivers/soundwire/sysfs_slave_dpn.c
> index c4b6543c09fd..a3fb380ee519 100644
> --- a/drivers/soundwire/sysfs_slave_dpn.c
> +++ b/drivers/soundwire/sysfs_slave_dpn.c
> @@ -283,6 +283,9 @@ int sdw_slave_sysfs_dpn_init(struct sdw_slave *slave)
>  	int ret;
>  	int i;
>  
> +	if (!slave->prop.source_ports && !slave->prop.sink_ports)
> +		return 0;
> +
>  	mask = slave->prop.source_ports;
>  	for_each_set_bit(i, &mask, 32) {
>  		ret = add_all_attributes(&slave->dev, i, 1);

I am struggling with this one since the driver is still adding
attributes manually. You mentioned in the other thread that

"
That's what the is_visible() callback is for in the groups structure,
you determine if the attribute is visable or not at runtime, you don't
rely on the driver itself to add/remove attributes, that does not scale
and again, is racy.
"

I interpret that as "there's still a race here", no?
