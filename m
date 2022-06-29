Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D430F56060B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiF2Qm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiF2QmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:42:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B36D344FD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656520944; x=1688056944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bPbOCi835UprKA879XALTFC2A2QiLkA5fYyV2bRf1II=;
  b=lub3RWKe2Y8XhgtDP4qmJFFhlAlORdWfTJIL5FBTyH2bqTFvvFDafIXc
   GtBEo6InGmEVnnZZudD49hEIfxN02pWJUIyD4dzwSAWE3xct9bwq2356t
   Snm1D55I7QT2etJHCwHOVvUS4zRW985/wY+XOsR9oN+Izoq+ovn3UKfg7
   UXw08e1VbLBG7wDrkBubIt9XGKsosYIFKUu5GwHTx4wleSGA1ZAHHjb7E
   Z/SWECqZZLKr6AhWDKnIQcxWcitPFOtX4XyvIJ7VoyOyGLfpU0oT0uvu2
   O2SNa/NHGiL+NMpdc52HGsOrx3jKNERxc53tj6tKwxVItnXrYntAaXzLu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="307579803"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="307579803"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:42:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="917668632"
Received: from jwacker-mobl.amr.corp.intel.com (HELO [10.213.178.109]) ([10.213.178.109])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:42:23 -0700
Message-ID: <57c8a55a-ba27-0b53-e957-657386034e52@linux.intel.com>
Date:   Wed, 29 Jun 2022 11:42:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] ASoC: codecs: add wsa883x amplifier support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com
References: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
 <20220629090644.67982-3-srinivas.kandagatla@linaro.org>
 <352fac7e-597c-84af-d33b-bdff0e2acdb6@linux.intel.com>
 <c12b67b3-2024-2133-9fdb-3d90410a4501@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <c12b67b3-2024-2133-9fdb-3d90410a4501@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +static int wsa883x_update_status(struct sdw_slave *slave,
>>> +                 enum sdw_slave_status status)
>>> +{
>>> +    struct wsa883x_priv *wsa883x = dev_get_drvdata(&slave->dev);
>>> +
>>> +    if (status == SDW_SLAVE_ATTACHED && slave->dev_num > 0)
>>
>> do you actually need to test if slave->dev_num is > 0?
>>
> Few years back I think it was you who asked me to add this check.. :-)
> 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2073074.html

Oops!

My comment was valid in general but at the bus level. With the benefit
of hindsight, I don't think this comment is valid in this callback.

update_status is either called with UNATTACHED, or with ATTACHED/ALERT
after programming dev_num to a value > 0.

It's not wrong to leave the code as is, but it's likely to be an
always-true condition.
