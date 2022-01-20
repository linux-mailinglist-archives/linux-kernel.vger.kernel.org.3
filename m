Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1C4953CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiATSCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:02:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:51549 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233557AbiATSCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642701720; x=1674237720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TF7EhkH6yB6RnHB40fIMGf6Q1t1Vymj4PS+rdAdW8zU=;
  b=DGTtM/5ApNBGucfC+zMviuIxQHBjc8Gj5YnO0ifbjBdMCH39uWbIcYYI
   VYC1Np6eL5GtScghrC+xtjGaRgsMbgtEf2WjI5A6C0DsCG9ZCLWloWXBh
   uSOM+aLofJoJQ+ax44o2cojf94f9ZV4s2b1HP+c0cRPLeVKPqkv7mfLNS
   pASkSYnResIeir2xdJF7a2nx7n0eHduzOBpY7O/9qucOd24kbzqGUD7ey
   f1lUxfjBeH7+Q3/OXDa5zDz7dZPWMjvvGm7O7VduqKvvLMjBowsAL6iLz
   mHEpkl4qZNWhKIlP57DajAzSCQwtblxEk5qTd7myZxKzUuwncUhKYUvCX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="245206616"
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="245206616"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 10:01:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="672633592"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 10:01:52 -0800
Date:   Thu, 20 Jan 2022 10:01:51 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH 5/5] x86/sysfs: Add PPIN in sysfs under cpu topology
Message-ID: <Yemjj26elXuOcegg@agluck-desk2.amr.corp.intel.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220107225442.1690165-6-tony.luck@intel.com>
 <YellN/3VCasDI3OD@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YellN/3VCasDI3OD@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 02:35:51PM +0100, Borislav Petkov wrote:
> On Fri, Jan 07, 2022 at 02:54:42PM -0800, Tony Luck wrote:
> > +#define topology_ppin(cpu)			(cpu_data(cpu).ppin)
> 
> That looks unused. No need to add it.


It "looks" unused, But thanks to the obscurity of CPP macros using ## to
concatenate tokens it is needed.

This harmless looking line:

define_id_show_func(ppin, "%llx");

is transmogrified by this:

#define define_id_show_func(name, fmt)					\
static ssize_t name##_show(struct device *dev,				\
			   struct device_attribute *attr, char *buf)	\
{									\
	return sysfs_emit(buf, fmt "\n", topology_##name(dev->id));	\
                                         ^^^^^^^^^^^^^^^

                                         This becomes topology_ppin
}


Will fix the other stuff and rebase to latest so part 4 applies.

Thanks for the review.

-Tony
