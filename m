Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4084E4705D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbhLJQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:38:42 -0500
Received: from netrider.rowland.org ([192.131.102.5]:33725 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S243610AbhLJQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:38:40 -0500
Received: (qmail 644048 invoked by uid 1000); 10 Dec 2021 11:35:05 -0500
Date:   Fri, 10 Dec 2021 11:35:05 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        mathias.nyman@linux.intel.com, rajatja@google.com,
        chris.chiu@canonical.com, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] usb: core: enable remote wakeup function for usb
 controller
Message-ID: <YbOBuZ77BAdoAdew@rowland.harvard.edu>
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
 <1638956391-20149-2-git-send-email-zhuyinbo@loongson.cn>
 <YbEsCSwYLgQefQxU@rowland.harvard.edu>
 <fbd46e52-054c-8aea-2f06-3af74c95e5e0@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbd46e52-054c-8aea-2f06-3af74c95e5e0@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:27:30PM +0800, zhuyinbo wrote:
> 
> 
> 在 2021/12/9 上午6:04, Alan Stern 写道:
> > On Wed, Dec 08, 2021 at 05:39:51PM +0800, Yinbo Zhu wrote:
> > > The remote wake up function is a regular function on usb device and
> > > I think keeping it enabled by default will make the usb application
> > > more convenient and usb device remote wake up function keep enabled
> > > that ask usb controller remote wake up was enabled at first.
> > > 
> > > This patch only enable wake up on usb root hub device, among which,
> > 
> > You say the patch only affects root hub devices, but this doesn't appear
> > to be true.
> > 
> > > usb3.0 root hub doesn't be set wakeup node property but use command
> > > USB_INTRF_FUNC_SUSPEND to enable remote wake up function.
> > > 
> > > Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> > > ---
> > >   drivers/usb/core/hub.c | 20 ++++++++++++++++++--
> > >   include/linux/usb.h    |  4 +++-
> > >   2 files changed, 21 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > > index 86658a8..cb4b956 100644
> > > --- a/drivers/usb/core/hub.c
> > > +++ b/drivers/usb/core/hub.c
> > > @@ -2509,6 +2509,8 @@ static void set_usb_port_removable(struct usb_device *udev)
> > >    */
> > >   int usb_new_device(struct usb_device *udev)
> > >   {
> > > +	struct usb_host_config *config;
> > > +	int ncfg;
> > >   	int err;
> > >   	if (udev->parent) {
> > > @@ -2540,6 +2542,18 @@ int usb_new_device(struct usb_device *udev)
> > >   	udev->dev.devt = MKDEV(USB_DEVICE_MAJOR,
> > >   			(((udev->bus->busnum-1) * 128) + (udev->devnum-1)));
> > > +	for (ncfg = 0; ncfg < udev->descriptor.bNumConfigurations; ncfg++) {
> > > +		config = &udev->config[ncfg];
> > > +		if ((config->desc.bmAttributes & (1 << 5)) == 0)
> > > +			break;
> > > +		if (ncfg + 1 == udev->descriptor.bNumConfigurations) {
> > > +			err = usb_enable_remote_wakeup(udev);
> > > +			if (err)
> > > +				dev_dbg(&udev->dev,
> > > +				      "won't remote wakeup, err %d\n", err);
> > > +		}
> > > +	}
> > 
> > I don't see anything in there which treats root hubs differently from
> > other devices.
> > 
> Hi Alan Stern,
> 
> You can find following code, non-root-hub had removed Wakeup sysfs
> attributes and disabled wakeup and root-hub had added wakeup sysfs attibutes
> before call usb_new_device, so this patch was only enabled
> remote wakeup for root-hub device.
> int usb_new_device(struct usb_device *udev)
> {
>         if (udev->parent) {
>                 /* Initialize non-root-hub device wakeup to disabled;
>                  * device (un)configuration controls wakeup capable
>                  * sysfs power/wakeup controls wakeup enabled/disabled
>                  */
>                 device_init_wakeup(&udev->dev, 0);
>         }

Okay.  But in any case, you're doing this in the wrong place.  Remote 
wakeup capability depends on the configuration, so you must not enable 
in usb_new_device() before the configuration has been chosen.

Furthermore, remote wakeup gets turned on only at the time when the 
device is suspended.  We don't leave it on all the time.

> > Besides, enabling wakeup for root hubs is generally a bad idea.  Suppose
> > you closed a laptop's lid and then unplugged a USB device -- with wakeup
> > enabled, the unplug would cause the laptop to wake up again without your
> > knowledge.
> > 
> > Alan Stern
> when closed laptop's lid and then unplugged a non-hid usb device it doesn't
> cause laptop to wakeup. and if that usb device is hid type and cause laptop
> into wakeup state then system will continue into suspend state becuase
> system ask that need accepted a acpi lid open event.

Not all laptops have ACPI.

> and for laptop usb wakeup that as general ask bios to enable usb wakeup then
> if need do more things to enable usb wakeup I think this usb wakeup function
> isn't friendly and inconveient, so enable it by default.
> after add this patch, if want to use usb wakeup function it only need enable
> bios configure it think it is appropriate.

The decision about whether or not to enable remote wakeup for a USB 
device is a matter of policy.  It has to be decided by the user, not by 
the kernel.

This is why there are userspace tools, like Powertop, that 
automatically enable remote wakeup when devices are detected and that 
allow the user to control which devices get enabled.  Using these tools 
is easy and convenient -- that's why they exist -- so the kernel's 
interface does not need to be friendly.

Alan Stern
