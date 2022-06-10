Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3254592A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 02:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiFJAa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 20:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiFJAa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 20:30:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08222C12E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654821052; x=1686357052;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ElC5/vrGK81B1vG9DhjSFK/X+qtdP0hbu7/JdDZXK94=;
  b=YhzIx4zXh5Irlq0EAzO2QV94kga0kTWt8HKOyz/0Hpk+opvvn9PvpH8K
   xoYdYzleho7bzPXwd1RyuNhwFNiirpk+OczTzXTHn+P3Ag7Po+zMjmrVC
   V8dEdDy4EjMQnke+BwX+RdTccBp2P4FoPKwc6CRuM7GnhpPawpYknI4zx
   vXxgFykNQDoh75yiDG7jml/0tQe2ri/8m/qelHl9j/6GuQTL9JG7qW03S
   oBB9C39nSb33acjrcmtyXqD0Xxl9SXFriBi90gcz7/45WYYm8A0uaV0V2
   6SjcsMUdXCkRgf/cx4dFhuy+t2BcXft988ORetIv8rIkd3Z8iCUNPPx0g
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341533770"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="341533770"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 17:30:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="827901500"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 17:30:51 -0700
Date:   Thu, 9 Jun 2022 17:30:43 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Mark Brown <broonie@kernel.org>
cc:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH v1] regmap: add generic indirect regmap support
In-Reply-To: <YqHH+oX/90KXv8dN@sirena.org.uk>
Message-ID: <alpine.DEB.2.22.394.2206091655490.1640209@rhweight-WRK1>
References: <20220607013755.594554-1-tianfei.zhang@intel.com> <Yp9PdZn2Xu/oqiA8@sirena.org.uk> <alpine.DEB.2.22.394.2206071714420.3001206@rhweight-WRK1> <YqB9O8HhZV2tXo8g@sirena.org.uk> <BN9PR11MB548315C03B09D841B6392E63E3A49@BN9PR11MB5483.namprd11.prod.outlook.com>
 <YqHH+oX/90KXv8dN@sirena.org.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Jun 2022, Mark Brown wrote:

> On Wed, Jun 08, 2022 at 11:54:26PM +0000, Zhang, Tianfei wrote:
>
>>>> Would a different name help?
>>>
>>> This wouldn't address the major problem which is...
>>>
>>>>>> +	writel(0, ctx->base + INDIRECT_CMD_OFF);
>>>>>> +	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
>>>>>> +				 (!cmd), INDIRECT_INT_US,
>>> INDIRECT_TIMEOUT_US);
>>>>>> +	if (ret)
>>>>>> +		dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn",
>>>>>> +__func__, cmd);
>>>
>>>>> ...and this doesn't look particularly generic, it looks like it's
>>>>> for some particular controller/bridge?
>>>
>>> ...that this appears to be entirely specific to some particular device, it's got
>>> things like hard coded register addresses and timeouts which mean it can't be
>>> reused.
>>
>> Yet, this is a register access hardware controller/bridge widely used in FPGA IP blocks, like PMCI, HSSI.
>> How about we change the patch title like this:
>
>> regmap: add indirect register controller support
>
> No, please enage with my feedback above.
>

Hi Mark,

I think part of the confusion is that this patch should have been included 
in a patch set that actually uses this regmap.  This patch really should 
be included with the following:

https://lore.kernel.org/all/20220607032833.3482-1-tianfei.zhang@intel.com

The hard coded register definitions are offsets to the passed in void 
__iomem base address.  This set of registers provides the semantics of 
indirect register read/write to whatever the register set is connected 
to on the back end.  Conceptually this could be considered a specific type 
indirect register access controller, but currently we have very different 
backend implementations in RTL.  Part of our intent is to have consistent 
register interfaces for our FPGA IP so multiple drivers can reuse this 
regmap.

I totally agree the hardcoded timeout values used for polling should be 
parameterized.

We would like to submit a v2 patch set that combines this patch with the 
first consumer of the regmap, PMCI.  We would also parameterize the 
timeout values, but most importantly the name must be better.  It is a 
long name, but how about something like "Intel FPGA Indirect Register 
Interface"?

Matthew Gerlach
