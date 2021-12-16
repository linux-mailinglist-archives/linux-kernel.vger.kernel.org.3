Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87B8476EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhLPKjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:39:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236122AbhLPKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639651158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XfBA2TCl0x+zU9XbvY6+8Ucf2k8HwGWdAzkC/kmtjEY=;
        b=GBQ4Dv88ZNsp5A/np/M8ZukydrjQBvdsLV9CpS6OTte7JCRqyVmZzwNIbKOYXL94viE2T3
        hkXXJ8ocsjjTrRXEhu4kXapy7dVrzTMsx2SvCRpHHoQTWSDbirpYipQsP9RaQr5a3sZoev
        IoTcNqpdZeAC2wzimyeyob4RSrbgpJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-NWCYb3uiNOOrOh3jACKPEw-1; Thu, 16 Dec 2021 05:39:17 -0500
X-MC-Unique: NWCYb3uiNOOrOh3jACKPEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742741023F4D;
        Thu, 16 Dec 2021 10:39:15 +0000 (UTC)
Received: from localhost (unknown [10.39.193.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10C9510A402C;
        Thu, 16 Dec 2021 10:39:14 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
In-Reply-To: <20211216000229.7a284661.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20211201141110.94636-1-thuth@redhat.com>
 <8512bb0a-a34a-09b0-65f3-781f3d092364@linux.ibm.com>
 <87k0g8scx1.fsf@redhat.com>
 <1eb9ca5c-b1bb-b768-64ee-e4a1b31bb171@linux.ibm.com>
 <6aaf6c60-a258-29e3-fcec-82c77d3945a4@redhat.com>
 <87tufaqbex.fsf@redhat.com> <20211216000229.7a284661.pasic@linux.ibm.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Thu, 16 Dec 2021 11:39:13 +0100
Message-ID: <87r1acrfzi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 15 Dec 2021 13:51:02 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Wed, Dec 15 2021, Thomas Huth <thuth@redhat.com> wrote:
>> 
>> > On 14/12/2021 22.55, Tony Krowiak wrote:  
>> >> 
>> >> 
>> >> On 12/13/21 11:11, Cornelia Huck wrote:  
>> >>> One possibility is simply blocking autoload of the module in userspace by
>> >>> default, and only allow it to be loaded automatically when e.g. qemu-kvm
>> >>> is installed on the system. This is obviously something that needs to be
>> >>> decided by the distros.
>> >>>
>> >>> (kvm might actually be autoloaded already, so autoloading vfio-ap would
>> >>> not really make it worse.)  
>> >> 
>> >> Of the vfio_ccw module is automatically loaded, then the kvm
>> >> module will also get loaded. I startup up a RHEL8.3 system and
>> >> sure enough, the vfio_ccw module is loaded along with the
>> >> kvm, vfio and mdev modules. If this is true for all distros, then
>> >> it wouldn't make much difference if the vfio_ap module is
>> >> autoloaded too.  
>> >
>> > I think I don't mind too much if we auto-load vfio-ap or not - but I think 
>> > we should make it consistent with vfio-ccw. So either auto-load both modules 
>> > (if the corresponding devices are available), or remove the 
>> > MODULE_DEVICE_TABLE() entries from both modules?  
>> 
>> I think we really need to take a step back and think about the purpose
>> of adding a MODULE_DEVICE_TABLE()... basically, it declares which types
>> of devices on a certain bus a driver supports, in a way that can be
>> consumed by userspace (after file2alias.c worked on it).
>
> I did a quick search to locate where this semantic was codified. But
> I didn't find the place neither Documentation/ nor in the header where
> MODULE_DEVICE_TABLE is defined.

This is rather ancient code pre-dating git; the mechanism as it is now
came in during the 2.5 device model redesign and introduction of udev,
IIRC.

>
>> 
>> Userspace typically uses this to match devices it is notified about to
>> drivers that could possibly drive those devices. In general, the
>> assumption is that you will want to have the drivers for your devices
>> loaded. In some cases (drivers only used in special cases, like here),
>> it might be a better idea to autoload the drivers only under certain
>> circumstances (e.g. if you know you're going to run KVM guests).
>
> Does RHEL do this, or would RHEL do this out of the box? I.e.
> would we end up preserving old behavior when this fix hits the distro,
> or would the end user end up with kvm and vfio_ap loaded (out of the
> box)?
>
> What would be the mechanism of choice to implement if kvm loaded and
> APs present/hotplugged load vfio_ap, otherwise don't in the userspace?
>
> Sorry I'm not very familiar with this whole modules auto-loading
> business, so I may be asking obvious questions. But a quick google
> search did not help me.

See /usr/lib/udev/rules.d/80-drivers.rules -- modules are automatically
loaded based on the alias when a device is added. Autoload can be also
be prevented; see the 'blacklist' directive in man 5 modprobe.d, which
will basically prevent autoloading based on the module-based aliases
(you will have to load the modules directly instead.) This is likely to
be the case on other distros as well.

An option would be to e.g. add a 'blacklist' statement for vfio-ap, and
have the qemu-kvm package install a udev rule that loads vfio-ap if any
supported ap devices are added.

>
>> 
>> My main point, however, is that we're talking about policy here: whether
>> a potentially useful driver should be loaded or not is a decision that
>> should be made by userspace. Not providing a MODULE_DEVICE_TABLE does
>> not look like the right solution, as it deprives userspace of the
>> information to autoload the driver, if it actually wants to do so.
>> 
>
> I'm sympathetic to this reading of the situation, but I'm not sure
> it is as black and white as stated.
>
> I think the current state of affairs in the vfio_ap module is clearly a
> bug.

Yes, the current code is simply wrong.

>
> One can argue that not auto-loading vfio_ap and kvm per default out of
> the box is not a bug. I mean the tooling (chzdev) seems to do fine
> without this and just assuming that both kvm and vfio_ap will be needed
> just because we have APs seems wrong.
>
> One of the more important guiding principles of Linux kernel development
> is no userspace regressions. And I think suddenly getting vfio_ap and kvm
> loaded just because we have AP devices can be thought of as a regression.

I disagree, that does not have anything to do with regressions.

>
> So I'm sympathetic to Harald's view as well.
>
> Of course there is the solution that the distros should really make sure
> the old behavior is preserved, or some smart behavior is introduced. But
> regarding smart, I believe "if you have devices that are configured for
> vfio_ap pass-through (with chzdev), then the vfio_ap module should get
> loaded" is pretty much as smart as it gets. So blacklisting the module
> by default in the distros looks like a viable option. If that is what
> we want, we should probably ask the distros, because I don't think
> it is just obviously their job to figure out that they have to do so.
>

I don't think the *zdev tools are the right place to control this in
general, I'd prefer to do it with generic tools (see above). But the
most important part is to configure this in userspace (and just fix the
kernel). Nothing prevents anyone from doing their own thing :)

> Disclaimer: I might be wrong about the current behavior, I didn't verify
> my claims
>
> Also what does vfio-pci do? As far as I can tell vfio-pci does not
> participate in module auto loading just because there are pci devices.
> The have some smart override I don't quite understand:
> https://patchwork.ozlabs.org/project/linux-pci/patch/20210826103912.128972-11-yishaih@nvidia.com/
> Before, I don't think they had a MODULE_DEVICE_TABLE:
> https://elixir.bootlin.com/linux/v5.8.18/source/drivers/vfio/pci/vfio_pci.c

I don't think it makes sense to look at pci for inspiration here; they
have a myriad of different device types, while ap only has a few (and
probably not that many different ones on a given system), and css only
has one that really matters.

