Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1B648AF78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiAKOZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbiAKOZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:25:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4161BC06173F;
        Tue, 11 Jan 2022 06:25:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0AB661680;
        Tue, 11 Jan 2022 14:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985D9C36AE3;
        Tue, 11 Jan 2022 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641911113;
        bh=/IPo1RolS++QLXVioz9gz4+MuXyyJR/0RVE3xDMRTBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Am8I2weNKecuHDWB6jPxReaapX1u/V7oGY4FJjTQevlnWSt/I1w4AENbYeDZBmv5T
         yMx43bhie7Akwh713LREv7r1Dz2+2K8sclixvKFhGObdyKx2ga9LhAXs58rclhAZwa
         KIma426Ba5N5s5e81fJbCz70botQ+SwdtkxSUwzs=
Date:   Tue, 11 Jan 2022 15:25:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Sing-Han Chen <singhanc@nvidia.com>
Subject: Re: [PATCH v2 1/1] ucsi_ccg: Check DEV_INT bit only when starting
 CCG4
Message-ID: <Yd2TRuUaZfG/+RQJ@kroah.com>
References: <20220111133643.589346-1-waynec@nvidia.com>
 <Yd2OTRrtP1XgxmHA@kroah.com>
 <a8b185cb-3f4b-9d57-7eb5-7c09dd3bb5aa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8b185cb-3f4b-9d57-7eb5-7c09dd3bb5aa@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 02:15:17PM +0000, Wayne Chang wrote:
> Hi Greg,
> Thanks for the review.
> 
> On 1/11/22 10:03 PM, Greg KH wrote:
> > 
> > 
> > On Tue, Jan 11, 2022 at 09:36:43PM +0800, Wayne Chang wrote:
> >> From: Sing-Han Chen <singhanc@nvidia.com>
> >>
> >> after driver sending the UCSI_START cmd, CCGx would
> >> clear Bit 0:Device Interrupt in the INTR_REG if CCGX
> >> reset successfully.
> >>
> >> however, there might be a chance that other bits in
> >> INTR_REG are not cleared due to internal data queued
> >> in PPM and cause the driver thinks CCGx reset failed.
> >>
> >> the commit checks bit 0 in INTR_REG and ignore other
> >> bits. ucsi driver would reset PPM later.
> >>
> >> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> >> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> >> ---
> >>   drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > What commit id does this fix?
> The change is to fix the defect of ucsi_ccg_init func based on the CCGx 
> spec.
> The original implementation's commit Id is i247c554a14aa1.

Great, can you resend this with a proper "Fixes:" tag on it?

thanks,

greg k-h
