Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A974AB90C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbiBGKtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiBGKsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:48:19 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6230C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644230898; x=1675766898;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mVOHb531swiHoNSO2HEJyxs7QHmBeZIo9CLzkP+bSBs=;
  b=njWc2Ux7QL2Gkijvr+g39YJYG84Bs9L9yYh3kCs41EIhynn7tJHNk+Hn
   Ph0igDAQSP9tjZrlzMZv/Ys7ahDtgz2Vcy7XYR61iY8vWuLEkgAPUFaI0
   Wn2BjfWDXLRvqvNyZqnskHDl15Xwp0rgScfIv+aEnV2KVxw/2YXjW54Uh
   AWI/xMmbqiNDzp5QGQvJ2OX292w3PlNaQ/GuCY3aax/r7IXpT9cjRdhoX
   vmVgw5PEk/QTmcimxS2vmEKbe6PLAMWdfjviETLcEvxNvbm/mIwckTzDl
   1fN64FtnfKtuBIgLRaZzenHjIAqhmctW8bnfzn0gqlcioDBDVxlv2Em4Q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="236092078"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="236092078"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 02:48:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="700420240"
Received: from nbaca1-mobl.ger.corp.intel.com (HELO localhost) ([10.252.18.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 02:48:14 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [PATCH 1/3] i915/gvt: Introduce the mmio_table.c to support
 VFIO new mdev API
In-Reply-To: <20220207083535.GA25345@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220127120508.11330-1-zhi.a.wang@intel.com>
 <20220207073247.GA24327@lst.de>
 <DM4PR11MB5549FE45F8098368114ADE75CA2C9@DM4PR11MB5549.namprd11.prod.outlook.com>
 <20220207083535.GA25345@lst.de>
Date:   Mon, 07 Feb 2022 12:48:08 +0200
Message-ID: <877da7rlzr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Feb 2022, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Feb 07, 2022 at 08:28:13AM +0000, Wang, Zhi A wrote:
>> 1) About having the mmio_table.h, I would like to keep the stuff in a
>> dedicated header as putting them in intel_gvt.h might needs i915 guys
>> to maintain it.
>> 2) The other one is about if we should move the mmio_table.c into
>> i915 folder. I guess we need the some comments from Jani. In the
>> current version that I am testing, it's still in GVT folder. Guess we
>> can submit a patch to move it to i915 folder later if Jani is ok
>> about that.
>
> Yes, let's have Jani chime in on these.  They're basically one and the
> same issue.  This code will have to be built into into the core i915
> driver even with my planned split, which is kindof the point of this
> exercise.  I think it makes sense to use the subdirectories as boundaries
> for where the code ends up and not to declarare maintainership boundaries,
> but it will be up to the i915 and gvt maintainers to decide that.

Agreed. If there's going to be a gvt.ko, I think all of gvt/ should be
part of that module, nothing more, nothing less.

The gvt related files in i915/ should probably be named intel_gvt* or
something, ditto for function naming, and we'll probably want patches
touching them be Cc'd to intel-gfx list.

Joonas, Rodrigo, Tvrtko, thoughts?

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
