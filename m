Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE2B4FFACE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiDMQBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbiDMQBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:01:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AFB6622F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649865535; x=1681401535;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=JnWL7ROdxTxxwnskrbDlqVPcD3G/D03X59HpmS6dpuE=;
  b=F2bWO29R2qboyBJS8JqL8mKUZPmYnDpD6qEgs51cdaKSQdYNCRFnUFeS
   xzLiD5XQTr52yHDTyar0pg932zlS1ZsqvwNrhj+rohXoHkd3x/6DOhFLm
   SB4a4gQvdI/OUAMnsik9BkddonLi2k/zeMHz54MhdF/MJL3nRsZkTQTqg
   HfKn2C/GSVrn63zStPuPCF/CI4jBGG7H27Dl7valvn+rHteTHATj+qz3I
   SXoJCdRqTB/1b7dm8udQZpqE7ljEV7yzXbTTwDJeNcIazRhB9sMHysaUd
   AbhPeWT2cDd9a6sLy80XP+OsoEZNFQArlV6l7XHABghEaha+n4M1RuvEa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="287735257"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="287735257"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:58:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="573329667"
Received: from jardanow-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.150.86])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:58:50 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: refactor the i915 GVT support and move to the modern mdev API v3
In-Reply-To: <20220413154642.GA28095@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220411141403.86980-1-hch@lst.de>
 <82c13d8e-1cb4-2873-86e9-16fd38e15b27@intel.com>
 <20220413154642.GA28095@lst.de>
Date:   Wed, 13 Apr 2022 18:58:47 +0300
Message-ID: <871qy1geko.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Apr 13, 2022 at 01:47:05PM +0000, Wang, Zhi A wrote:
>> > the GVT code in the i915 is a bit of a mess right now due to strange
>> > abstractions and lots of indirect calls.  This series refactors various
>> > bits to clean that up.  The main user visible change is that almost all
>> > of the GVT code moves out of the main i915 driver and into the kvmgt
>> > module.
>> 
>> Hi Christoph:
>> 
>> Do you want me to merge the GVT-g patches in this series? Or you want them to get merged from your side?
>
> The two option here are drm tree via gvt and i915 trees or the vfio
> tree, neither of which really is my tree.
>
> We already have a fair bit of vfio changes at the tail end of the series,
> and Jason has some more that should sit on top of it, and I have some
> more that I haven't sent yet.
>
> So if we could get the MMIO table and Makefile cleanups into a topic
> branch that we could pull into the vfio tree and merge it through that
> that would seem easiest to me, assuming that is ok with the i915, drm
> and vfio maintainers.

AFAICS the changes are mostly to gvt/, and at least I'm fine with the
minor changes to i915 (in this series and in my two patches) being
merged via whichever tree you all see fit.

Acked-by: Jani Nikula <jani.nikula@intel.com>

Joonas, Tvrtko, Rodrigo, chime in now if you have any issues with that.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
