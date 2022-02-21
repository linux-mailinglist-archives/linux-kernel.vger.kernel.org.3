Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F06B4BE4CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349612AbiBURH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:07:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbiBURHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:07:22 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564381D32F;
        Mon, 21 Feb 2022 09:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645463218; x=1676999218;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RZDvFcjNGzHfz6QJapWn9VmEfw3si9l1wOlygRoWuG8=;
  b=dTldcRvdL3TB43GX5oDmRRR/PGPqswjY6qzz358+VfG7PXy/sIAQBN+z
   IXcQxTqPugT/eK4Wq1k86h5a+npMe1JhsrB2tOV+qaQlV+FeOJ3myApo1
   u/TqhPLAMvm1Tav2wJaboMtYvaYcz36tr5QXCSpbHIhSdVD07t80hkORk
   Xzyhej/xJMeXrp8/sxvZOTudXf1g3dIkcr5PcovtxG0vgc49Hy0C2hObf
   n4W2j5UqoiJEms+WZzQV8xuPak7oy3EuP/XdGj6/V4ZyvXM1KzN7Iqcif
   kHENspKkPin3hFWciYa/acff6MvN57KpA5AoxhMsku7tUifAoS0vMuI5a
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="232164088"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="232164088"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 09:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="636723005"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2022 09:06:57 -0800
Received: from bazacche-MOBL.amr.corp.intel.com (unknown [10.209.98.194])
        by linux.intel.com (Postfix) with ESMTP id B2092580C7E;
        Mon, 21 Feb 2022 09:06:57 -0800 (PST)
Message-ID: <8cb2722299ecf8b4c6d24ff28a0a19024dcb41f0.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] platform/x86/intel: pmt: Remove bin_attribute mmap
 support to runtime pm
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>, mgross@linux.intel.com,
        rjw@rjwysocki.net, srinivas.pandruvada@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Mon, 21 Feb 2022 09:06:57 -0800
In-Reply-To: <5ba6e52c-d7e9-39fc-cb84-963a403385ca@redhat.com>
References: <20220214213258.1929462-1-david.e.box@linux.intel.com>
         <20220214213258.1929462-2-david.e.box@linux.intel.com>
         <5ba6e52c-d7e9-39fc-cb84-963a403385ca@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-21 at 10:05 +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/14/22 22:32, David E. Box wrote:
> > PMT devices need to support runtime D3. However, binary attributes
> > don't
> > provide access to open/release methods that could be used to
> > control
> > runtime pm. Therefore, remove the mmap operation. The data may
> > still be
> > accessed with read() calls.
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > V0 comments:
> > 
> > I expect that this is an undesirable solution because of the ABI
> > change.
> > I don't know if anyone is using this ABI outside of our Intel tools
> > which
> > are willing to make this change. I'd rather find a solution to keep
> > the
> > mmap support. I initially wrote a patch to simply add the missing
> > open and
> > release callbacks to binary attributes but this was thought to be
> > too heavy
> > handed in our internal review. I'm open to suggestions. Thanks.
> 
> We really cannot go and break userspace API like this. Even if you
> are
> dropping mmap support from the Intel tools; and we assume that the
> Intel
> tools are the only consumer, then we still cannot drop mmap support
> because users may install a new kernel without updating the tools.
> 
> The never break userspace rule applies here and that is a very clear
> and hard rule.
> 
> So please respin the series using the approach with open and release
> callbacks.

Thanks Hans. I'll send out that series for comment.

David

