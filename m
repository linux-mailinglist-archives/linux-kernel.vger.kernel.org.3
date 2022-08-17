Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A02596E29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbiHQMES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbiHQMEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:04:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461844C62A;
        Wed, 17 Aug 2022 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660737854; x=1692273854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sw03qyNAB0MNEYgJP3KDR/9fx3+F8UT/HeVmqYUt2GE=;
  b=Wip09kIPrY9+dtHdJJ1xkDqJ88AoZCotBUpwVJ1cbc7lXwkHwEStLNWl
   nA66f1taTPDa/jQk4A2v4piCtZ+MLBFAKWCWfiLlDkvZAjrqeFgA76d7f
   tiy0r+f0MSK+Qwxb8GO6U258dCYiN5I/tLZpD2q7hjf3fKDZk0c+iaz76
   yNxgdRD3gkOdCD8jv0rQ/txx0/Bq4dZkoAcShncBn4J9wm5LRmOfoaFP7
   b7WTS7bthyNuduy+HdmvhRZ0UtvJdNI9gnagQmw53uTriL/lUn2rTXuas
   ID85G38SR9ScRPX1uUO8aLn4tyxxWULYLOC5c1d0HCycvHZvnf9LttnQA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="356471447"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="356471447"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="583742759"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2022 05:04:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0BF04235; Wed, 17 Aug 2022 15:04:22 +0300 (EEST)
Date:   Wed, 17 Aug 2022 15:04:22 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     mario.limonciello@amd.com, gregkh@linuxfoundation.org,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: RE: [PATCH v4] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <YvzZRsyGR/hakhIo@black.fi.intel.com>
References: <20220817102450.63514-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817102450.63514-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 17, 2022 at 06:24:50PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
> Hi,
> 
> >> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> >>
> 
> >> +static int asmedia_nvm_validate(struct tb_switch *sw, unsigned int mode)
> >> +{
> >> +	struct tb_nvm *nvm;
> >> +	u32 val;
> >> +	u32 nvm_size;
> >> +	int ret = 0;
> >> +	unsigned int image_size;
> >> +
> >> +	switch (mode) {
> >> +	case NVM_UPGRADE:
> >> +		if (sw->no_nvm_upgrade)
> >> +			sw->no_nvm_upgrade = false;
> >> +
> >> +		break;
> >> +
> >> +	case NVM_ADD:
> >> +		nvm = tb_nvm_alloc(&sw->dev);
> >
> >This function does not only "validate" but it also creates the NVMem
> >devices and whatnot.
> >
> >Do you have some public description of the ASMedia format that I could
> >take a look? Perhaps we can find some simpler way of validating the
> >thing that works accross different vendors.
> >
> 
> ASMedia NVM format include rom file, firmware and security
> configuration information. And active firmware depend on this
> information for processing. We don't need to do any validation during
> firmware upgrade, so we haven't public description of the ASMedia
> format.
> 
> I think I use "validate" is not fit. This function mainly to create
> the NVMem devices and write. I will rename in the next patch.

So instead what you now do, I suggest that we move all the vendor
support out to nvm.c, that includes Intel too. What I mean by this is
that the tb_switch_nvm_add() would then look something like this:

tb_switch_nvm_add(sw)
{
	if (!nvm_readable(sw))
		return 0;

	nvm = tb_switch_nvm_alloc(sw);
	if (IS_ERR(nvm)) {
		if (PTR_ERR(nvm) == -EOPNOTSUPP) {
			dev_info(&sw->dev,
				"NVM format of vendor %#x is not known, disabling NVM upgrade\n",
				sw->config.vendor_id);
			return 0;
		}

		return PTR_ERR(nvm);
	}

	ret = tb_nvm_add_active(nvm, nvm->size, tb_switch_nvm_read);
	if (ret)
		...

	if (!sw->no_nvm_upgrade) {
		ret = tb_nvm_add_non_active(nvm, NVM_MAX_SIZE, tb_switch_nvm_write);
		if (ret)
			...
	}

	sw->nvm = nvm;
	...
}

And the tb_switch_nvm_alloc() resides in nvm.c and that one goes over an
array of supported vendors matching sw->config.vendor_id and if it finds
the match it will set nvm->vops to point the vendor specific operations
and in addition it will will populate rest of the nvm fields like this:

static const struct {
	u16 vendor;
	const struct tb_nvm_vendor_ops *vops;
} switch_nvm_vendors[] = {
	{ 0x8086, &intel_switch_nvm_ops },
	{ 0x8087, &intel_switch_nvm_ops },
	{ 0x174c, &asmedia_switch_nvm_ops },
};

tb_switch_nvm_alloc(sw)
{
	struct tb_nvm_vendor_ops *ops = NULL;
	int i;

	for (i = 0; i < ARRAY_SIZE(switch_nvm_vendors); i++) {
		if (switch_nvm_vendors[i].vendor == sw->config.vendor_id)
			vops = &switch_nvm_vendors[i].vops;
			break;
	}

	if (!vops)
		return ERR_PTR(-EOPNOTSUPP);

	nvm = tb_nvm_alloc(&sw->dev);
	if (IS_ERR(nvm))
		...

	nvm->vops = vops;
	ret = vops->populate(nvm);
	if (ret)
		...

	...
}

Then we would have all the vendor specific things in
intel_switch_nvm_ops and asmedia_switch_nvm_ops accordingly and the rest
of the code is generic USB4 stuff. We need to do the same for retimers
too at some point.
