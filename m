Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2652348C7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245701AbiALQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:03:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:20565 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230223AbiALQDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642003431; x=1673539431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ZH57BU3oxlV3IbXCo/thwlhOdYvfQE8HVQJ+VmBSOA=;
  b=CEYr8kObsFhm4ek7EdvQFa//a50BvNTkSP0Zb5d+5XNN2olcjWup4jyG
   hAhrUmVa/IkArSfT4FbLQKCv2LHYDuTRhOS05eCsogu3bucJF91TF1mrM
   fTtimxVTSPE/tzch72K7ESj0TBWahgSba1Oenc4h1gFt21wsSVdy14rbC
   dW9NZHkmPEKFtqTGlc7cTy40ba54Fi+JpZTdiqaAdM6XsCv3dJPPoeGpu
   gZdAm8nwmfW4UBMiuzhoqsiqnyoE//ikjd0dritT7IK+mK3XXzWLBhvjx
   zPSz4VFhSnHXxiDqdznobc4DZGI6tis+N0hCPAYcCFuWQg0P3sdeTX1qv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="330112509"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="330112509"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 08:03:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="613611965"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 08:03:36 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 930E52017F;
        Wed, 12 Jan 2022 18:03:34 +0200 (EET)
Date:   Wed, 12 Jan 2022 18:03:34 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Shawn Tu <shawnx.tu@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [sailus-media-tree:master 15/16]
 drivers/media/i2c/hi847.c:2700:49: error: passing argument 2 of
 'v4l2_subdev_get_try_format' from incompatible pointer type
Message-ID: <Yd771idbGaGVU9OQ@paasikivi.fi.intel.com>
References: <202201122346.jc4ZqZm5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201122346.jc4ZqZm5-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Wed, Jan 12, 2022 at 11:18:55PM +0800, kernel test robot wrote:
>    drivers/media/i2c/hi847.c: In function 'hi847_set_format':
> >> drivers/media/i2c/hi847.c:2700:49: error: passing argument 2 of 'v4l2_subdev_get_try_format' from incompatible pointer type [-Werror=incompatible-pointer-types]
>     2700 |                 *v4l2_subdev_get_try_format(sd, cfg, fmt->pad) = fmt->format;
>          |                                                 ^~~
>          |                                                 |
>          |                                                 struct v4l2_subdev_pad_config *

There's been an API change in how the sub-device try state is stored and
accessed. The patch changing the other drivers is:

<URL:https://git.linuxtv.org/sailus/media_tree.git/commit/?id=0d346d2a6f54f06f36b224fd27cd6eafe8c83be9>

Could you make similar changes to the hi847 driver? I'll then squash that
patch into the current patch adding the driver.

-- 
Kind regards,

Sakari Ailus
