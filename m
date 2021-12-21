Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B9947BA21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhLUGpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:45:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39992 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhLUGpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:45:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF59EB811BD;
        Tue, 21 Dec 2021 06:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A51C36AE2;
        Tue, 21 Dec 2021 06:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640069142;
        bh=goIlnGus93hvXDGrhw7dEDYdP7pgUn4EDCYhcc1q5pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUpFU6+a+nCZ1UrmH5ILUDFqlzSIp3viUt9FUf5iZ+TNstdqEqmh5xuzVaaNLW2WE
         Eq6Jxjzc4gtXHlJzPp0Jwtfb2H0KkGYZynJPz8AEB2MeI+2K6I6B8FYqjaiJRgPdUQ
         5uknDYUZQcspX/0QeHWzKumEIDjZPBFna7k8ajuU=
Date:   Tue, 21 Dec 2021 07:45:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] nvmem: expose NVMEM cells in sysfs
Message-ID: <YcF4E82M89huIbSD@kroah.com>
References: <20211220064730.28806-1-zajec5@gmail.com>
 <20211220064730.28806-2-zajec5@gmail.com>
 <YcA4ArALDTjUedrb@kroah.com>
 <c49f2d6d-7974-5bc7-9bc1-ac265a23c2c0@gmail.com>
 <YcF1Kizcvgqa9ZT4@kroah.com>
 <d68ba301-7877-a8d8-8700-c601a4996818@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d68ba301-7877-a8d8-8700-c601a4996818@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 07:39:24AM +0100, Rafał Miłecki wrote:
> On 21.12.2021 07:33, Greg Kroah-Hartman wrote:
> > On Mon, Dec 20, 2021 at 09:39:43PM +0100, Rafał Miłecki wrote:
> > > Hi Greg,
> > > 
> > > On 20.12.2021 09:00, Greg Kroah-Hartman wrote:
> > > > On Mon, Dec 20, 2021 at 07:47:30AM +0100, Rafał Miłecki wrote:
> > > > >    static void nvmem_cell_entry_add(struct nvmem_cell_entry *cell)
> > > > >    {
> > > > > +	struct device *dev = &cell->nvmem->dev;
> > > > > +	int err;
> > > > > +
> > > > >    	mutex_lock(&nvmem_mutex);
> > > > >    	list_add_tail(&cell->node, &cell->nvmem->cells);
> > > > >    	mutex_unlock(&nvmem_mutex);
> > > > > +
> > > > > +	sysfs_attr_init(&cell->battr.attr);
> > > > > +	cell->battr.attr.name = cell->name;
> > > > > +	cell->battr.attr.mode = 0400;
> > > > > +	cell->battr.read = nvmem_cell_attr_read;
> > > > > +	err = sysfs_add_bin_file_to_group(&dev->kobj, &cell->battr,
> > > > > +					  nvmem_cells_group.name);
> > > > 
> > > > Why not just use the is_bin_visible attribute instead to determine if
> > > > the attribute should be shown or not instead of having to add it
> > > > after-the-fact which will race with userspace and loose?
> > > 
> > > I'm sorry I really don't see how you suggest to get it done.
> > > 
> > > I can use .is_bin_visible() callback indeed to respect nvmem->root_only.
> > 
> > Great.
> > 
> > > I don't understand addig-after-the-fact part. How is .is_bin_visible()
> > > related to adding attributes for newly created cells?
> > 
> > You are adding a sysfs attribute to a device that is already registered
> > in the driver core, and so the creation of that attribute is never seen
> > by userspace.  The attribute needs to be attached to the device _BEFORE_
> > it is registered.
> > 
> > Also, huge hint, if a driver has to call as sysfs_*() call, something is
> > wrong.
> > 
> > > Do you mean I can
> > > avoid calling sysfs_add_bin_file_to_group()?
> > 
> > Yes.
> > 
> > > Do you recall any existing example of such solution?
> > 
> > Loads.
> > 
> > Just add this attribute group to your driver as a default attribute
> > group and the driver core will create it for you if needed.
> > 
> > Or if you always need it, no need to mess sith is_bin_visible() at all,
> > I can't really understand what you are trying to do here at all.
> 
> Thanks a lot! In nvmem_register() first there is a call to the
> device_register() and only later cells get added. I suppose I just have
> to rework nvmem_register() order so that:
> 1. Cells are collected earlier. For each cell I allocate group attribute

No, add all of the attributes to the device at the beginning before you
register it, there's no need to allocate anything.

> 2. device_register() gets called

Yes.

thanks,

greg k-h
