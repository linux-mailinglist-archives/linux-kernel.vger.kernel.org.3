Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2918D46DDFE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbhLHWIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:08:31 -0500
Received: from netrider.rowland.org ([192.131.102.5]:58195 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233375AbhLHWIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:08:30 -0500
Received: (qmail 588686 invoked by uid 1000); 8 Dec 2021 17:04:57 -0500
Date:   Wed, 8 Dec 2021 17:04:57 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] usb: core: enable remote wakeup function for usb
 controller
Message-ID: <YbEsCSwYLgQefQxU@rowland.harvard.edu>
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
 <1638956391-20149-2-git-send-email-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638956391-20149-2-git-send-email-zhuyinbo@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 05:39:51PM +0800, Yinbo Zhu wrote:
> The remote wake up function is a regular function on usb device and
> I think keeping it enabled by default will make the usb application
> more convenient and usb device remote wake up function keep enabled
> that ask usb controller remote wake up was enabled at first.
> 
> This patch only enable wake up on usb root hub device, among which,

You say the patch only affects root hub devices, but this doesn't appear 
to be true.

> usb3.0 root hub doesn't be set wakeup node property but use command
> USB_INTRF_FUNC_SUSPEND to enable remote wake up function.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  drivers/usb/core/hub.c | 20 ++++++++++++++++++--
>  include/linux/usb.h    |  4 +++-
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 86658a8..cb4b956 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2509,6 +2509,8 @@ static void set_usb_port_removable(struct usb_device *udev)
>   */
>  int usb_new_device(struct usb_device *udev)
>  {
> +	struct usb_host_config *config;
> +	int ncfg;
>  	int err;
>  
>  	if (udev->parent) {
> @@ -2540,6 +2542,18 @@ int usb_new_device(struct usb_device *udev)
>  	udev->dev.devt = MKDEV(USB_DEVICE_MAJOR,
>  			(((udev->bus->busnum-1) * 128) + (udev->devnum-1)));
>  
> +	for (ncfg = 0; ncfg < udev->descriptor.bNumConfigurations; ncfg++) {
> +		config = &udev->config[ncfg];
> +		if ((config->desc.bmAttributes & (1 << 5)) == 0)
> +			break;
> +		if (ncfg + 1 == udev->descriptor.bNumConfigurations) {
> +			err = usb_enable_remote_wakeup(udev);
> +			if (err)
> +				dev_dbg(&udev->dev,
> +				      "won't remote wakeup, err %d\n", err);
> +		}
> +	}

I don't see anything in there which treats root hubs differently from 
other devices.

Besides, enabling wakeup for root hubs is generally a bad idea.  Suppose 
you closed a laptop's lid and then unplugged a USB device -- with wakeup 
enabled, the unplug would cause the laptop to wake up again without your 
knowledge.

Alan Stern
