Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEADA4BA38C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbiBQOtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:49:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiBQOtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:49:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88008165C02;
        Thu, 17 Feb 2022 06:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645109335; x=1676645335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KJwcvMoVWYzSvXk8gggEbeaq4OR5k43plCA9oRGkcUE=;
  b=n/jWqSN7Wkj97X26J0b4lm6BKYhdMUSq+B7pvWmORtY2ZVzXvU/Cyr/4
   4uecPGT4PodbSOf2id/UCHTD72Ox9hzpBH/MGGQupNrDGznJ1SR/j9HiX
   HWWrfzY3ZAIGFwG7pTPDdX7fw6nLdN5/n2p9TrXKjDn51w35BqmH+qLtX
   P3lEfgDA2bfnUILaBihEFZT9FE2On4cDkSW32fEpM5ZpIsExy+1D86KN9
   O9u8jgTAnTz42Vkmi2e8IX+dPSQumznY1wwmmSkAeVPmOB8fC3ysEJa/7
   w21XHZlSgbTHa89gp0XfEqiD71ZMcwZLW//ZQIz9tzalaFOLFJtBe7tZc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="275477578"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="275477578"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 06:48:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="545641327"
Received: from mylly.fi.intel.com (HELO [10.237.72.51]) ([10.237.72.51])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2022 06:48:51 -0800
Message-ID: <b9099ac3-a5fa-1aba-92a3-05a7212525ab@linux.intel.com>
Date:   Thu, 17 Feb 2022 16:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: Re: [PATCH] counter: Stop using dev_get_drvdata() to get the counter
 device
Content-Language: en-US
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
References: <YfzPcyusGwAOkys6@shinobu>
 <20220204082556.370348-1-u.kleine-koenig@pengutronix.de>
 <YgHKekl9rJ2jH5j4@shinobu>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <YgHKekl9rJ2jH5j4@shinobu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2/8/22 03:42, William Breathitt Gray wrote:
> On Fri, Feb 04, 2022 at 09:25:56AM +0100, Uwe Kleine-König wrote:
>> dev_get_drvdata() returns NULL since commit b56346ddbd82 ("counter: Use
>> container_of instead of drvdata to track counter_device") which wrongly
>> claimed there were no users of drvdata. Convert to container_of() to
>> fix a null pointer dereference.
>>
>> Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Fixes: b56346ddbd82 ("counter: Use container_of instead of drvdata to track counter_device")
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> I'll pick this up and apply it to my tree.
> 
Perhaps late but I hit this same issue, patch here fixes it and I wanted 
to confirm it.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
