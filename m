Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F524C1B33
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbiBWS4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiBWS4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:56:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E953EF00;
        Wed, 23 Feb 2022 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645642548; x=1677178548;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6ATkQ3SPbHg1uNzvDgcRhzJ0i/tVyFJ14GLbD7i2C7I=;
  b=Z5/x7cgfL+wmN5LEhS37WJvKKPLWSaRlotoTzQF2MKTgFjLfdsy6OOBA
   yl77mbCSfpfewHpLCcw2hWYjUxH7EmSGGWkKFwSpzb2ubIxv9IpckgohI
   LfK/7l69ren13/A/hsWrY1pgYw2y3WJ4OGC6zuC/AGQ4R5DY65RQMwbyS
   mbtCl56MqosSCmLqDfbS4V9I3fdnR/2dgxqKjXaw3pwap2IFh3i77dFM2
   ur1PpMupnZFcLJVSlevSZiHVEBnKnj2RFGSxsnpXZiGKnKwRPXnBNKyaS
   x1xtliB71CJvUZxfR6MBghQJ3pNOBew0Atb8248V6rAFV+z7aA4yTA6Tm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251792689"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="251792689"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 10:55:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="491319470"
Received: from aacunaco-mobl1.amr.corp.intel.com (HELO [10.209.144.93]) ([10.209.144.93])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 10:55:37 -0800
Message-ID: <6e79238c-2ceb-0ae7-2b37-7ffac777db60@linux.intel.com>
Date:   Wed, 23 Feb 2022 12:14:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] soundwire: qcom: add wake up interrupt support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220221104127.15670-1-srinivas.kandagatla@linaro.org>
 <20220221104127.15670-4-srinivas.kandagatla@linaro.org>
 <5e050d4c-e3d2-35fb-ca49-7be53579bc31@linux.intel.com>
 <1cb4e02f-f040-23bd-44d0-0675429332bd@linaro.org>
 <49099bcb-35e9-0bea-9658-006caed3ab33@linux.intel.com>
 <ee14c940-85c9-6c14-5738-e055801407ab@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ee14c940-85c9-6c14-5738-e055801407ab@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> Not following, sorry. if you use pm_runtime functions and it so happens
>> that the resume already started, then those routines would wait for the
>> resume to complete.
> yes that is true,
> 
> TBH, I was trying to reproduce the issue since morning to collect some
> traces but no luck so far, I hit these issues pretty much rarely. Now
> code has changed since few months back am unable to reproduce this
> anymore. Or it might be just the state of code I had while writing this up.
> 
> But when I hit the issue, this is how it looks like:
> 
> 1. IRQ Wake interrupt resume parent.
> 
> 2. parent is in middle of resuming
> 
> 3. Slave Pend interrupt in controller fired up
> 
> 4. because of (3) child resume is requested and then the parent resume
> blocked on (2) to finish.
> 
> 5. from (2) we also trying to resume child.
> 
> 6. (5) is blocked on (4) to finish which is blocked on (2) to finish
> 
> we are dead locked. Only way for me to avoid dead lock was to wake the
> child up after IRQ wake interrupts.

Maybe a red-herring, but we're seen cases like this where we called
pm_runtime_get_sync() while resuming, that didn't go so well. I would
look into the use of _no_pm routines if you are already trying to resume.

