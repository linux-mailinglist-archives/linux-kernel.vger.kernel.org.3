Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B385AC422
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiIDLjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 07:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiIDLi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 07:38:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C094B41D1E;
        Sun,  4 Sep 2022 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662291536; x=1693827536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PjBXyuU0GSqxV+SzW5bu1E+l0xNAPR+t/RTIkbhji6A=;
  b=YE21nnurie4j8ebnGai9dGIcdKGyReeekipz1ZNfN9w7rWQy7Tw0v4y0
   klQytZ36Afy71UqIaNBjN2RpmxuJ+dFJVJGFGUjjEQ53m/HUcexGZ8r8X
   94t+es3YYu4eSM9FSuv5kIUVS6JC5DJ6+f2QP/r76xbEj24PObfoQASBd
   sXzrPZCRZ7TMvlJFjIAt5nbF7EKRp/+skWGfQnDt+hZE6ovcxxZYPQ3pF
   wDK1nf0l+tTo42QfhcvKtajQUf4eYJza7rnVbYMmcVw8AtQhR/3kT2GaI
   a7xlRC6okyWdrBb1whpE9cFu70aYZ2GZChBS+jHAwWHP9y4fPcuBA9EPM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="294974099"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="294974099"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 04:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="646603052"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 04 Sep 2022 04:38:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 76C8486; Sun,  4 Sep 2022 14:39:08 +0300 (EEST)
Date:   Sun, 4 Sep 2022 14:39:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Szuying Chen <chensiying21@gmail.com>, gregkh@linuxfoundation.org,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v8 3/3] thunderbolt: To extend ASMedia NVM formats.
Message-ID: <YxSOXFfVxL45egIr@black.fi.intel.com>
References: <20220902094010.2170-1-chensiying21@gmail.com>
 <20220902094010.2170-4-chensiying21@gmail.com>
 <a71d8b25-ac83-92fc-ef4a-99a673362364@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71d8b25-ac83-92fc-ef4a-99a673362364@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Fri, Sep 02, 2022 at 08:32:41AM -0500, Limonciello, Mario wrote:
> On 9/2/2022 04:40, Szuying Chen wrote:
> > From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> > 
> > The patch add ASMedia NVM formats.
> > 
> > Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> > ---
> > v7->v8: Fix the no_nvm_upgrade bit setting on suggestion by Mika.
> > 
> >   drivers/thunderbolt/nvm.c | 40 +++++++++++++++++++++++++++++++++++++++
> >   drivers/thunderbolt/tb.c  |  2 +-
> >   2 files changed, 41 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
> > index 878d705bd0cb..8393d82dd108 100644
> > --- a/drivers/thunderbolt/nvm.c
> > +++ b/drivers/thunderbolt/nvm.c
> > @@ -12,9 +12,16 @@
> > 
> >   #include "tb.h"
> > 
> > +/* ID of Router */
> > +#define ROUTER_VENDOR_ID_ASMEDIA 0x174c
> > +
> >   /* Switch NVM support */
> >   #define NVM_CSS		0x10
> > 
> > +/* ASMedia specific NVM offsets */
> > +#define ASMEDIA_NVM_DATE	0x1c
> > +#define ASMEDIA_NVM_VERSION	0x28
> > +
> >   static DEFINE_IDA(nvm_ida);
> > 
> >   /**
> > @@ -120,11 +127,43 @@ static int intel_nvm_validate(struct tb_switch *sw)
> >   	return 0;
> >   }
> > 
> > +static int asmedia_nvm_version(struct tb_switch *sw)
> > +{
> > +	struct tb_nvm *nvm = sw->nvm;
> > +	u32 val;
> > +	int ret;
> > +
> > +	/* ASMedia get version and date format is xxxxxx.xxxxxx */
> > +	ret = nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
> > +	if (ret)
> > +		return ret;
> > +
> > +	nvm->major = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> > +
> > +	ret = nvm_read(sw, ASMEDIA_NVM_DATE, &val, sizeof(val));
> > +	if (ret)
> > +		return ret;
> > +
> > +	nvm->minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
> > +
> > +	/*
> > +	 * Asmedia NVM size fixed on 512K. We currently have no plan
> > +	 * to increase size in the future.
> > +	 */
> > +	nvm->nvm_size = SZ_512K;
> 
> Any chance this can also be gleamed from your NVM?  It would future proof
> the kernel code if you did come up with a need to change it in the future
> some day rather than hardcoding.
> 
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct tb_nvm_vendor_ops intel_switch_nvm_ops = {
> >   	.read_version = intel_nvm_version,
> >   	.validate = intel_nvm_validate,
> >   };
> > 
> > +static const struct tb_nvm_vendor_ops asmedia_switch_nvm_ops = {
> > +	.read_version = asmedia_nvm_version,
> 
> I recall an earlier version of your patch series was reading the customer ID
> as well.  Would it make sense to have an `asmedia_nvm_validate` that checks
> this matches?

It seems the customer ID was the same 0x28 offset than the
ASMEDIA_NVM_VERSION so I guess it was just renamed.

> 
> Or any other safety validation that the image is good the kernel might want
> to do?  Checksum or signature or anything?
> 
> Even if the hardware does all these verifications it's much easier to debug
> problems if the kernel can do a first line verification to tell you what is
> wrong with the image instead of trying to trace an error code from the
> hardware.

I agree.
