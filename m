Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC16646EB62
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbhLIPiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:38:15 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41260 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbhLIPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:38:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D4256CE2686
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FD4C341C3;
        Thu,  9 Dec 2021 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639064077;
        bh=aH6Sek2cOBYDzbM47BDo0ekUAm94enjEV3jGklza7iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+8MjoOrClUrX/wR6TQtiOuyEpiE09lsu/iy5FlTuP+OPbCmL6P5XJloWUlyEnQ4C
         5QeOEBMflneoIFzFw+0YdZV/yFXfY0EYVZUZkW0K1grMlPQy9uAGAXcMZhzeF/cntv
         ELbpElzLWZGU3bhkemo07XpzUh9r5rwilexAI8yE=
Date:   Thu, 9 Dec 2021 16:34:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Russ Weight <russell.h.weight@intel.com>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        "Gong, Richard" <richard.gong@intel.com>
Subject: Re: [RFC PATCH 0/5] Firmware Upload Framework
Message-ID: <YbIiCkhaAqWvsm2g@kroah.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
 <8b7bbdcd-ef48-9f48-10c0-021c41575522@redhat.com>
 <YZVV98XoiI3NQHQ1@ripper>
 <2a7e266f-6646-dff5-5682-b81df4d39237@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a7e266f-6646-dff5-5682-b81df4d39237@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 07:15:06AM -0800, Tom Rix wrote:
> 
> On 11/17/21 11:20 AM, Bjorn Andersson wrote:
> > On Mon 15 Nov 05:57 PST 2021, Tom Rix wrote:
> > 
> > > On 11/10/21 5:13 PM, Russ Weight wrote:
> > > > The Firmware Upload framework provides a common API for uploading firmware
> > > > files to target devices. An example use case involves FPGA devices that
> > > > load FPGA, Card BMC, and firmware images from FLASH when the card boots.
> > > > Users need the ability to update these firmware images while the card is
> > > > in use.
> > > > 
> > > > Device drivers that instantiate the Firmware Upload class driver will
> > > > interact with the target device to transfer and authenticate the firmware
> > > > data. Uploads are performed in the context of a kernel worker thread in
> > > > order to facilitate progress indicators during lengthy uploads.
> > > > 
> > > > This driver was previously submitted in the context of the FPGA sub-
> > > > system as the "FPGA Image Load Framework", but the framework is generic
> > > > enough to support other devices as well. The previous submission of this
> > > > patch-set can be viewed here:
> > > > 
> > > > https://marc.info/?l=linux-kernel&m=163295640216820&w=2
> > > > 
> > > > The n3000bmc-sec-update driver is the first driver to use the Firmware
> > > > Upload API. A recent version of these patches can be viewed here:
> > > > 
> > > > https://marc.info/?l=linux-kernel&m=163295697217095&w=2
> > > > 
> > > > I don't think I am duplicating any functionality that is currently covered
> > > > in the firmware subsystem. I appreciate your feedback on these patches.
> > > This may be a common api for fpga/dfl-, but it is not likely common for
> > > general devices.
> > > 
> > During my years of hacking on device drivers I've run into the need for
> > being able to reflash/update firmware in things such as touchscreen
> > controllers, hdmi bridges, usb network devices and (embedded) usb hubs.
> > 
> > The implementation typically manifest itself as some sysfs or debugfs
> > knob which when written triggers a request_firmware() followed by the
> > operation to write the content to flash. But the result is often quite
> > hacky and requires that you store the firmware-to-be-written in some
> > path that will be looked at by request_firmware() - and hence these
> > patches often doesn't end up upstream.
> > 
> > So I'm certainly in favor of some generic way for drivers to expose an
> > interface for userspace to flash new firmware to their associated
> > hardware.
> 
> The image to be loaded is not really firmware and not really a partial
> reconfiguration image.  It is both.

The kernel does not care.  It is a "blob of data to be sent to the
device".  Traditionally we have called this "firmware", and so the api
is called that.  But it could be anything, the kernel does not parse it
or care at all, it is just a pipe from userspace to the device to
transfer the data.

> Which image is used depends on the end user's workload for the n3000 and
> could change and need reloading day to day.
> 
> Because the n3000 is unusable without this change, I would like to see
> updating working first for the n3000.
> 
> Then the interface generalized as other devices are found that have a
> similar use case.
> 
> This is a device specific feature so it should go somewhere like
> drivers/fpga/dfl-n3000-update.c

Then have that driver call the firmware api, that's what it is there
for.

thanks,

greg k-h
