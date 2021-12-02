Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20414663FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358120AbhLBMyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:54:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:4207 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358111AbhLBMyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:54:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="260696335"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="260696335"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 04:50:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="745949030"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 04:50:49 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 69CBC2036B;
        Thu,  2 Dec 2021 14:50:47 +0200 (EET)
Date:   Thu, 2 Dec 2021 14:50:47 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: ipu3: don't use recursion at the Kernel
Message-ID: <YajBJ8W8e6UdDrcU@paasikivi.fi.intel.com>
References: <cf020b6a04b3a9d7f08750927b1d100f63ff4689.1638445455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf020b6a04b3a9d7f08750927b1d100f63ff4689.1638445455.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Thu, Dec 02, 2021 at 12:44:26PM +0100, Mauro Carvalho Chehab wrote:
> The Kernel stack is too small. Doing recursions there is a very
> bad idea, as, if something gets wrong, it could lead to data
> corruption. So, re-implement cio2_check_fwnode_graph() to avoid
> recursion.

Any decent compiler should be able to optimise out tail recursion.

But is checking the secondary pointer even needed these days?
fwnode_graph_get_next_endpoint() does that already, it's not something
drivers should be required to do.

-- 
Kind regards,

Sakari Ailus
