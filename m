Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DED473123
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbhLMQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:03:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:10837 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240386AbhLMQC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639411376; x=1670947376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=980G/17/cPf9ib/kPiRwCuEEfBn5w1Rt8kaFq1oJ674=;
  b=ct1d8MIPc4y/5nj7WEDT+vo98yenVnpUt1hYqoF3m7NigsTQzDOMXLMT
   uoyVk9JBL/rcjVOIWwPxcogiHnxkwo38W3QMWv24yGTkK+35RIqjHVYCN
   O9/+gtB2iSpTYKid6YjAD0tV/eLxjEuuM4sig9C+qzXEVgLWlqTR6SfIN
   JcXiZwP+G6eGGZzpdw2dUT3f8LEIKk4fFYYjugOBG7l1kZjBHs/8fkIY3
   1um7naHKrAZRzYnacW3rX4YQB22L0Ax+gOL1y7R1jsLPBp1mu4zg5zUUS
   IVHZwFdhkY+8uUHoq7x6jSFoTV/Vy4oj/uCGl3of90aqkhwn3JV1lFyfd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="302143278"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="302143278"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 08:02:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="660894514"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 08:02:24 -0800
Date:   Mon, 13 Dec 2021 08:02:23 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/7] drm/i915: Replace kmap() with kmap_local_page()
Message-ID: <20211213160223.GN3538886@iweiny-DESK2.sc.intel.com>
References: <20211210232404.4098157-1-ira.weiny@intel.com>
 <20211210232404.4098157-2-ira.weiny@intel.com>
 <YbcMhzfm31aL5fzx@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbcMhzfm31aL5fzx@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 01:04:07AM -0800, Christoph Hellwig wrote:
> On Fri, Dec 10, 2021 at 03:23:58PM -0800, ira.weiny@intel.com wrote:
> > -		vaddr = kmap(page);
> > +		vaddr = kmap_local_page(page);
> >  		memcpy(vaddr, data, len);
> > -		kunmap(page);
> > +		kunmap_local(vaddr);
> 
> memcpy_to_page?

Opps!  Yea!

David, Daniel,

Do you prefer me to resent the entire series or reply to this message with a
V2?

Ira
