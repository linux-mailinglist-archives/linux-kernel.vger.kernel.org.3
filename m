Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7497B47E0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347358AbhLWJEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:04:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39866 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347339AbhLWJEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:04:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7594FB81F9F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F06C36AE9;
        Thu, 23 Dec 2021 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640250288;
        bh=GLtZZPLmwbU+EfifaiOw0EMJpcnVumWosfcpIfQSxmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FVf5U7fxSnn2gRKpJIxZxZ/1Q7MfiRk2/Qoh8zjQssn1Ps6pi0ynw/W2m8HqbZjw5
         Sw5NM+EmlbUaiytVsKEw4JQEwfL5Db8LqQrm6dOZawUldJ9GjEjUdi+2DBuqsSwm/k
         L00mbrYTwkuWxYyLyK7SdfT4Ds4346xyCoGeVhB0=
Date:   Thu, 23 Dec 2021 10:04:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronak Jain <ronakj@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>
Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add support for runtime features
Message-ID: <YcQ7qynk9vk336b+@kroah.com>
References: <20211206112101.24955-1-ronak.jain@xilinx.com>
 <20211206112101.24955-2-ronak.jain@xilinx.com>
 <YcGbvXzvLtgBo+sq@kroah.com>
 <BYAPR02MB448806DCF28EA41AFE4B3D0EA47E9@BYAPR02MB4488.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB448806DCF28EA41AFE4B3D0EA47E9@BYAPR02MB4488.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 08:55:09AM +0000, Ronak Jain wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, December 21, 2021 2:48 PM
> > To: Ronak Jain <ronakj@xilinx.com>
> > Cc: Michal Simek <michals@xilinx.com>; linux-kernel@vger.kernel.org; Rajan
> > Vaja <RAJANV@xilinx.com>; corbet@lwn.net; linux-arm-
> > kernel@lists.infradead.org; arnd@arndb.de; Sai Krishna Potthuri
> > <lakshmis@xilinx.com>
> > Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add support for runtime features
> > 
> > On Mon, Dec 06, 2021 at 03:20:59AM -0800, Ronak Jain wrote:
> > > Add support for runtime features by using an IOCTL call. The features
> > > can be enabled or disabled from the firmware as well as the features
> > > can be configured at runtime by querying IOCTL_SET_FEATURE_CONFIG id.
> > >  Similarly, the user can get the configured values of features by
> > > querying IOCTL_GET_FEATURE_CONFIG id.
> > >
> > > Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
> > > ---
> > > Changes in v4:
> > > - Update commit message
> > >
> > > Changes in v3:
> > > - Resolved merged conflict
> > >
> > > Changes in v2:
> > > - Resolved merged conflict
> > > - Update commit message
> > > ---
> > >  drivers/firmware/xilinx/zynqmp.c     | 27 +++++++++++++++++++++++++++
> > >  include/linux/firmware/xlnx-zynqmp.h | 25 +++++++++++++++++++++++++
> > >  2 files changed, 52 insertions(+)
> > 
> > I still get merge conflicts with this change:
> > 
> > checking file drivers/firmware/xilinx/zynqmp.c Hunk #1 succeeded at 1156
> > (offset 27 lines).
> > checking file include/linux/firmware/xlnx-zynqmp.h
> > Hunk #1 FAILED at 126.
> > Hunk #2 succeeded at 376 (offset 17 lines).
> > Hunk #3 FAILED at 435.
> > Hunk #4 succeeded at 697 (offset 31 lines).
> > 2 out of 4 hunks FAILED
> > 
> > 
> > What branch/tree are you making it against?
> > 
> I have created patches on the master branch of https://github.com/torvalds/linux.

Please work against linux-next, it has the combined work of everyone
else as well.

thanks,

greg k-h
