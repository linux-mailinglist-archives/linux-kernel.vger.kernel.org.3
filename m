Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F276F54EB64
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378593AbiFPUkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiFPUkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:40:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E7D5DE49;
        Thu, 16 Jun 2022 13:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655412010; x=1686948010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3kyqj7rQYGnntBXVKFnHRuP3Q3HC8rJ+VtXx7y0r3mc=;
  b=SlIUK2d7mfB28gMtqN/IJ+hj88Jvgj9kVBHq/h7tEI38NmGAF/2a0BIS
   SRgYmceLYY6EdxVY8WAicJdtHuEI8yqGfDJhreV10WvLwgiplKnbVLdlo
   6MDsELvNPSPyN4hnWE5sg4KSN63ii5rS4Yfozy297BZz1Dli/Q6u3KTqS
   9aU80FhE+ztuQN1EUxRsl/6ndLUn6D8Z5yeoL6UTPe0AWaLLz9hUGWojE
   kD5UnGR8VsnZuVVS6ngXqwR27QcYYT7SMGSehv0NjMX/quahiU/iAvUT+
   7XR12WDK2k2UzEKKFkbtjgJetefzkx1KwJBenhwE/TOMuDfv9Q97ZwsG1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278143651"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278143651"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 13:40:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="641719392"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 13:40:09 -0700
Date:   Thu, 16 Jun 2022 13:39:49 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/core: Add sysfs attribute get_poison for list
 retrieval
Message-ID: <20220616203949.GB1529208@alison-desk>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <57644934bb7af8e1c692735f53c2c415a1ba16d1.1655250669.git.alison.schofield@intel.com>
 <20220616160412.00000c34@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616160412.00000c34@Huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 08:04:12AM -0700, Jonathan Cameron wrote:
> On Tue, 14 Jun 2022 17:10:28 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The sysfs attribute, get_poison, allows user space to request the
> > retrieval of a CXL devices poison list for its persistent memory.
> > 
> > From Documentation/ABI/.../sysfs-bus-cxl
> >         (WO) When a '1' is written to this attribute the memdev
> >         driver retrieves the poison list from the device. The list
> >         includes addresses that are poisoned or would result in
> >         poison if accessed, and the source of the poison. This
> >         attribute is only visible for devices supporting the
> >         capability. The retrieved errors are logged as kernel
> >         trace events with the label: cxl_poison_list.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Hi Alison,
> 
> I'm planning to throw together QEMU support for this and test
> it. In meantime a few quick comments / suggestions inline.

Thanks Jonathan.
I've tested with a test patch that returns contrived output payloads,
and will look fwd to trying out w qemu,

> 
> Thanks,
> 
> Jonathan
> 
> > ---
snip
> > +
> > +	if (!sysfs_streq(buf, "1")) {
> 
> Maybe kstrtobool?  If you do then fine to leave the documentation claiming
> it's tighter as that'll tell people who actually read it to expect to
> write a 1.
> 
Got it.

> > +		dev_err(dev, "%s: unknown value: %s\n", attr->attr.name, buf);
> 
> Feels noisy when I'd expect -EINVAL to be enough info to indicate an invalid
> parameter.
> 
Got it.

> > +		return -EINVAL;
> > +	}
> > +
> > +	rc = cxl_mem_get_poison_list(dev);
> > +	if (rc) {
> > +		dev_err(dev, "Failed to retrieve poison list %d\n", rc);
> 
> Here I'd expect the error code to returned on the write to probably be enough
> info so not sure this error print is useful either.
> 
Got it.

> > +
snip
> > +	if (a == &dev_attr_get_poison.attr) {
> > +		struct device *dev = container_of(kobj, struct device, kobj);
> > +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +
> > +		if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON,
> > +			      cxlds->enabled_cmds))
> 			      to_cxl_memdev(dev)->enabled_cmds))
> and drop the local variable is shorter and I don't htink it loses
> any readability.
> 
Got it.

Thanks Jonathan!
