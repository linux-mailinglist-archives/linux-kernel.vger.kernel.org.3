Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92014631C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbhK3LHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:07:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:5376 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236879AbhK3LHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:07:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234915673"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="234915673"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 03:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="654134689"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 30 Nov 2021 03:03:44 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Nov 2021 13:03:43 +0200
Date:   Tue, 30 Nov 2021 13:03:43 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        wonchung@google.com, bleung@chromium.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Rajat Jain <rajatja@google.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/4] usb: Use notifier for linking Type C ports.
Message-ID: <YaYFDwsw2hKdJrGj@kuha.fi.intel.com>
References: <20211124231028.696982-1-pmalani@chromium.org>
 <YaCrnMAEXnG+VO6d@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaCrnMAEXnG+VO6d@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On Fri, Nov 26, 2021 at 11:40:49AM +0200, Heikki Krogerus wrote:
> On Wed, Nov 24, 2021 at 03:10:06PM -0800, Prashant Malani wrote:
> > This series resolves the cyclic dependency error which was introduced by
> > commit 63cd78617350 ("usb: Link the ports to the connectors they are
> > attached to") which lead to it being reverted. The approach here is to
> > use a notifier to link a new Type C port to pre-existing USB ports
> > instead of calling an iterator of usb ports from the Type C connector
> > class. This allows commit 63cd78617350 ("usb: Link the ports to the
> > connectors they are attached to") to then be submitted without any
> > depmod cyclic dependency error.
> > 
> > The final patch removes the usb port iterator since it is no longer
> > needed.
> 
> This is not enough. Build the Type-C Class as a module and the USB bus
> statically, and the links will not get created.
> 
> I'm not sure you actually achieve much with this series, and I'm not
> sure this approach will ever fully solve the problem. As long as we
> have to declare API, we will have the circular dependency issue on our
> hands. But there are ways to avoid that.
> 
> There is for example the component framework (drivers/base/component.c)
> that I've been thinking about using here. In this case it would work
> so that you declare the USB Type-C part as your aggregate driver, and
> everything that is connected to it (so USB ports, DisplayPorts, TBT,
> etc.) would then just declare themselves as general components. Could
> you take a look at that?

I'm preparing a patch where I store all _PLDs in the ACPI tables, and
create list of devices that share it. I can convert port-mapper.c to
it and the component framework while at it.


Br,

-- 
heikki
