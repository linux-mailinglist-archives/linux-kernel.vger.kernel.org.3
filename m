Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155EE4E6088
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbiCXInN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349113AbiCXInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:43:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593C69BB9F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:41:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD56A61787
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D153C340EC;
        Thu, 24 Mar 2022 08:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648111295;
        bh=4/KsVtzb5NjKE245a2eQ6mnCNwtRLjMhlbASbRN9IHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oiCEH7gLLBICu0prjoQuOETzaVFota8EVkj8Z2jxs26fHwTxY9wTZ5/lqMd5QtqF7
         EVCEqdZGcIDcmTTKNddI5HwhSlGOQFKuBbFFYHN3aNxXbsYBVhjazzLtvMr5Lmhhji
         San9Xqz5xQiLbeSaWhc1LjoTg1mFl3pfsSgoqUzA=
Date:   Thu, 24 Mar 2022 09:41:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oh Eomji <eomji.oh@samsung.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v1 3/3] sound: usb: Exynos usb audio offloading driver
Message-ID: <YjwutlpkvA6xubKy@kroah.com>
References: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
 <CGME20220324081350epcas2p227458cb1b530f04a9990bcfc8c3b5703@epcas2p2.samsung.com>
 <1648109444-196321-4-git-send-email-eomji.oh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648109444-196321-4-git-send-email-eomji.oh@samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 05:10:44PM +0900, Oh Eomji wrote:
> This is for usb audio offloading. usb audio offloading processes usb
> audio stream data directly from the audio box even if ap usb enters
> suspend, there is no problem in stream data transmission. This obtains
> power saving effect while using usb audio device.
> 
> AP usb and audio usb f/w communicate via AUDIO IPC. By performing AUDIO
> IPC in the vendor operations, abox can access and control the xhci to
> transmit the data directly.
> 
> The types of commands and data delivered through AUDIO IPC include the
> following (AP USB <-> AUDIO USB f/w) :
> 1. usb audio connection/disconnection status
> 2. xhci memory information
> 3. full descriptor for usb audio device
> 4. UAC(usb audio class) control command
> 
> Signed-off-by: Oh Eomji <eomji.oh@samsung.com>
> ---
>  sound/usb/Kconfig            |   9 +
>  sound/usb/Makefile           |   2 +
>  sound/usb/exynos_usb_audio.c | 560 +++++++++++++++++++++++++++++++++++++++++++
>  sound/usb/exynos_usb_audio.h | 150 ++++++++++++
>  4 files changed, 721 insertions(+)
>  create mode 100644 sound/usb/exynos_usb_audio.c
>  create mode 100644 sound/usb/exynos_usb_audio.h
> 
> diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
> index 059242f..70252a3 100644
> --- a/sound/usb/Kconfig
> +++ b/sound/usb/Kconfig
> @@ -27,6 +27,15 @@ config SND_USB_AUDIO
>  config SND_USB_AUDIO_USE_MEDIA_CONTROLLER
>  	bool
>  
> +config SND_EXYNOS_USB_AUDIO
> +	tristate "EXYNOS USB Audio offloading module"
> +	depends on SND_USB_AUDIO
> +	help
> +	 Say Y here to include support for Exynos USB Audio ABOX offloading.
> +
> +	 To compile this driver as a module, choose M here: the module
> +	 will be called exynos-usb-audio-offloading.
> +
>  config SND_USB_UA101
>  	tristate "Edirol UA-101/UA-1000 driver"
>  	select SND_PCM
> diff --git a/sound/usb/Makefile b/sound/usb/Makefile
> index 9ccb21a..bf019c7 100644
> --- a/sound/usb/Makefile
> +++ b/sound/usb/Makefile
> @@ -28,6 +28,8 @@ snd-usbmidi-lib-objs := midi.o
>  
>  # Toplevel Module Dependency
>  obj-$(CONFIG_SND_USB_AUDIO) += snd-usb-audio.o snd-usbmidi-lib.o
> +obj-$(CONFIG_SND_EXYNOS_USB_AUDIO) += exynos-usb-audio-offloading.o
> +exynos-usb-audio-offloading-y += exynos_usb_audio.o
>  
>  obj-$(CONFIG_SND_USB_UA101) += snd-usbmidi-lib.o
>  obj-$(CONFIG_SND_USB_USX2Y) += snd-usbmidi-lib.o
> diff --git a/sound/usb/exynos_usb_audio.c b/sound/usb/exynos_usb_audio.c
> new file mode 100644
> index 0000000..456cc78
> --- /dev/null
> +++ b/sound/usb/exynos_usb_audio.c
> @@ -0,0 +1,560 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Are you sure about this license?  I have to ask, sorry.

> +/*
> + *   USB Audio offloading Driver for Exynos
> + *
> + *   Copyright (c) 2017 by Kyounghye Yun <k-hye.yun@samsung.com>
> + *
> + */
> +
> +
> +#include <linux/bitops.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/ctype.h>
> +#include <linux/usb.h>
> +#include <linux/usb/audio.h>
> +#include <linux/usb/audio-v2.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/io.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/completion.h>
> +
> +#include <sound/pcm.h>
> +#include "../../../sound/usb/exynos_usb_audio.h"

Did this patch just break the build?  It should not need this type of
.../../../ mess.

> +#include "usbaudio.h"
> +#include "helper.h"
> +#include "card.h"
> +#include "quirks.h"
> +
> +static struct exynos_usb_audio *usb_audio;
> +static struct snd_usb_audio_vendor_ops exynos_usb_audio_ops;
> +
> +struct hcd_hw_info *g_hwinfo;
> +EXPORT_SYMBOL_GPL(g_hwinfo);
> +int otg_connection;
> +EXPORT_SYMBOL_GPL(otg_connection);
> +int usb_audio_connection;
> +EXPORT_SYMBOL_GPL(usb_audio_connection);

Why are these exported?  Who uses them?  And why generic names for a
driver-specific variable?  And what do they do and how are they
accessed?

No one in this patch series needs these exports, so why are they
exported?

> +
> +static void exynos_usb_audio_set_device(struct usb_device *udev)
> +{
> +	usb_audio->udev = udev;
> +	usb_audio->is_audio = 1;

boolean?

How do you know?  Did you check?

And why a single static variable?

> +}
> +
> +static int exynos_usb_audio_unmap_all(void)
> +{
> +	/*
> +	 * TODO: unmapping pcm buffer, usb descriptor, Device Context,
> +	 * Input Context, ERST, URAM.
> +	 */

If this is not completed, just don't have the function at all.

Why isn't this done?

> +
> +	return 0;
> +}
> +
> +static int exynos_usb_audio_pcmbuf(struct usb_device *udev, int iface)
> +{
> +	if (!usb_audio->is_audio || !otg_connection)
> +		return -1;

Do not make up error values.  Use correct ones.


> +
> +	/*
> +	 * TODO: Transmit the DRAM address that contains the xhci device
> +	 * information,and the DMA address required for operation to the abox
> +	 * usb f/w.
> +	 */

So this function does nothing?

Does this driver even work properly?  Where is the  missing logic?

> +
> +	return 0;
> +}
> +
> +static int exynos_usb_audio_setrate(int iface, int rate, int alt)
> +{
> +	if (!usb_audio->is_audio || !otg_connection)
> +		return -1;
> +
> +	/*
> +	 * TODO: Notify the abox usb f/w the audio sample rate supported by
> +	 * the interface of the connected audio device.
> +	 */

Same as above.

Does this driver actually work on real hardware?  Or is this just a
"fake" driver that is never intended for anyone to use just to allow the
hooks to be added to the kernel tree?

What hardware has this driver worked on?  Can I take the pixel6 device
today and replace their out-of-tree driver with this one and will it
work properly?  If not, what is missing?

> +
> +	return 0;
> +}
> +
> +static int exynos_usb_audio_setintf(struct usb_device *udev, int iface, int alt, int direction)
> +{
> +	struct hcd_hw_info *hwinfo = g_hwinfo;
> +	u64 in_offset, out_offset;
> +
> +	if (!usb_audio->pcm_open_done)
> +		return -EPERM;

How is that a permission error?

> +
> +	if (!usb_audio->is_audio || !otg_connection)
> +		return -1;

Again, no fake error numbers.

> +
> +	if (direction) {
> +		/* IN EP */
> +		if (!usb_audio->indeq_map_done ||
> +			(hwinfo->in_deq != hwinfo->old_in_deq)) {
> +			/* TODO: Transmit pcm interface number, alt setting
> +			 * number to abox usb f/w
> +			 */

Fix all TODO please before resubmitting.

> +			usb_audio->indeq_map_done = 1;
> +			in_offset = hwinfo->in_deq % PAGE_SIZE;

Why does PAGE_SIZE matter?

> +		}
> +
> +		if (hwinfo->fb_out_deq) {
> +			if (!usb_audio->fb_outdeq_map_done ||
> +					(hwinfo->fb_out_deq != hwinfo->fb_old_out_deq)) {
> +				/* TODO: Transmit pcm interface number,
> +				 * alt setting number to abox usb f/w
> +				 */
> +				usb_audio->fb_outdeq_map_done = 1;
> +				out_offset = hwinfo->fb_out_deq % PAGE_SIZE;
> +			}
> +		}
> +	} else {
> +		/* OUT EP */
> +		if (!usb_audio->outdeq_map_done ||
> +			(hwinfo->out_deq != hwinfo->old_out_deq)) {
> +			/* TODO: Transmit pcm interface number, alt setting
> +			 * number to abox usb f/w
> +			 */
> +			usb_audio->outdeq_map_done = 1;
> +			out_offset = hwinfo->out_deq % PAGE_SIZE;
> +		}
> +
> +		if (hwinfo->fb_in_deq) {
> +			if (!usb_audio->fb_indeq_map_done ||
> +					(hwinfo->fb_in_deq != hwinfo->fb_old_in_deq)) {
> +				/* TODO: Transmit pcm interface number,
> +				 * alt setting number to abox usb f/w
> +				 */
> +				usb_audio->fb_indeq_map_done = 1;
> +				in_offset = hwinfo->fb_in_deq % PAGE_SIZE;
> +			}
> +		}
> +	}
> +
> +	/* one more check connection to prevent kernel panic */
> +	if (!usb_audio->is_audio || !otg_connection)
> +		return -1;
> +
> +	/* TODO: Notify abox usb f/w a dequeue pointer */
> +
> +	return 0;
> +}
> +
> +static int exynos_usb_audio_hcd(struct usb_device *udev)
> +{
> +	struct hcd_hw_info *hwinfo = g_hwinfo;
> +
> +	/* back up each address for unmap */
> +	usb_audio->dcbaa_dma = hwinfo->dcbaa_dma;
> +	usb_audio->save_dma = hwinfo->save_dma;
> +	usb_audio->in_ctx = hwinfo->in_ctx;
> +	usb_audio->out_ctx = hwinfo->out_ctx;
> +	usb_audio->erst_addr = hwinfo->erst_addr;
> +	usb_audio->speed = hwinfo->speed;
> +	usb_audio->use_uram = hwinfo->use_uram;
> +
> +	/*
> +	 * TODO: DCBAA, Device Context, Input Context, URAM, ERST mapping
> +	 * and notify abox usb f/w the address about xhci h/w resource to
> +	 * directly control the xhci in abox.
> +	 */
> +
> +	return 0;
> +}
> +
> +static int exynos_usb_audio_desc(struct usb_device *udev)
> +{
> +	int configuration, cfgno, i;
> +	unsigned char *buffer;
> +	u64 desc_addr;
> +	u64 offset;
> +
> +	configuration = usb_choose_configuration(udev);
> +
> +	cfgno = -1;
> +	for (i = 0; i < udev->descriptor.bNumConfigurations; i++) {
> +		if (udev->config[i].desc.bConfigurationValue ==
> +				configuration) {
> +			cfgno = i;
> +			break;
> +		}
> +	}
> +
> +	if (cfgno == -1)
> +		cfgno = 0;
> +
> +	/* need to memory mapping for usb descriptor */
> +	buffer = udev->rawdescriptors[cfgno];
> +	desc_addr = virt_to_phys(buffer);
> +	offset = desc_addr % PAGE_SIZE;
> +
> +	/* store address information */
> +	usb_audio->desc_addr = desc_addr;
> +	usb_audio->offset = offset;
> +
> +	desc_addr -= offset;
> +
> +	/*
> +	 * TODO: Notify the abox usb f/w that all descriptors have been recived
> +	 * from the connected usb audio device, and that copy and memory mapping
> +	 * have beed completed so that it can be used in abox usb f/w
> +	 */
> +
> +	return 0;
> +}
> +
> +static int exynos_usb_audio_conn(struct usb_device *udev, int is_conn)
> +{
> +
> +	/* TODO: Notify abox usb f/w whether usb device is connected or not */
> +	if (!is_conn) {
> +		if (usb_audio->is_audio) {
> +			usb_audio->is_audio = 0;
> +			usb_audio->usb_audio_state = USB_AUDIO_REMOVING;
> +		}
> +	} else {
> +		cancel_work_sync(&usb_audio->usb_work);
> +		usb_audio->indeq_map_done = 0;
> +		usb_audio->outdeq_map_done = 0;
> +		usb_audio->fb_indeq_map_done = 0;
> +		usb_audio->fb_outdeq_map_done = 0;
> +		usb_audio->pcm_open_done = 0;
> +		reinit_completion(&usb_audio->discon_done);
> +		usb_audio->usb_audio_state = USB_AUDIO_CONNECT;
> +		usb_audio_connection = 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int exynos_usb_audio_pcm(bool is_open, bool direction)
> +{
> +	if (!usb_audio->is_audio || !otg_connection)
> +		return -1;
> +
> +	if (is_open)
> +		usb_audio->pcm_open_done = 1;
> +
> +	/* TODO: Notify the abox usb f/w the pcm open/close status */
> +
> +	return 0;
> +}
> +
> +static void exynos_usb_audio_work(struct work_struct *w)
> +{
> +	/* Don't unmap in USB_AUDIO_TIMEOUT_PROBE state */
> +	if (usb_audio->usb_audio_state != USB_AUDIO_REMOVING)
> +		return;
> +
> +	exynos_usb_audio_unmap_all();
> +	usb_audio->usb_audio_state = USB_AUDIO_DISCONNECT;
> +	usb_audio_connection = 0;
> +	complete(&usb_audio->discon_done);
> +}
> +
> +static int exynos_usb_scenario_ctl_info(struct snd_kcontrol *kcontrol,
> +			      struct snd_ctl_elem_info *uinfo)
> +{
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	uinfo->count = 1;
> +	uinfo->value.integer.min = AUDIO_MODE_NORMAL;
> +	uinfo->value.integer.max = AUDIO_MODE_CALL_SCREEN;
> +	return 0;
> +}
> +
> +static int exynos_usb_scenario_ctl_get(struct snd_kcontrol *kcontrol,
> +			 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct exynos_usb_audio *usb = snd_kcontrol_chip(kcontrol);
> +
> +	ucontrol->value.integer.value[0] = usb->user_scenario;
> +	return 0;
> +}
> +
> +static int exynos_usb_scenario_ctl_put(struct snd_kcontrol *kcontrol,
> +			 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct exynos_usb_audio *usb = snd_kcontrol_chip(kcontrol);
> +	int changed = 0;
> +
> +	if (usb->user_scenario !=
> +	     ucontrol->value.integer.value[0]) {
> +		usb->user_scenario = ucontrol->value.integer.value[0];
> +		changed = 1;
> +	}
> +
> +	return changed;
> +}
> +
> +static int exynos_usb_add_ctls(struct snd_usb_audio *chip,
> +				unsigned long private_value)
> +{
> +	struct snd_kcontrol_new knew = {
> +		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
> +		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
> +		.name = "USB Audio Mode",
> +		.info = exynos_usb_scenario_ctl_info,
> +		.get = exynos_usb_scenario_ctl_get,
> +		.put = exynos_usb_scenario_ctl_put,
> +	};
> +
> +	int err;
> +
> +	if (!chip)
> +		return -ENODEV;
> +
> +	knew.private_value = private_value;
> +	usb_audio->kctl = snd_ctl_new1(&knew, usb_audio);
> +	if (!usb_audio->kctl)
> +		return -ENOMEM;
> +
> +	err = snd_ctl_add(chip->card, usb_audio->kctl);
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}
> +
> +int exynos_usb_audio_init(struct device *dev, struct platform_device *pdev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct device_node *np_abox;
> +	struct platform_device *pdev_abox;
> +	int ret = 0;
> +
> +	if (!usb_audio) {
> +		usb_audio = kmalloc(sizeof(struct exynos_usb_audio), GFP_KERNEL);
> +		if (!usb_audio)
> +			return -ENOMEM;
> +	}
> +
> +	np_abox = of_parse_phandle(np, "abox", 0);
> +	if (!np_abox)
> +		return -EPROBE_DEFER;
> +
> +	pdev_abox = of_find_device_by_node(np_abox);
> +	if (!pdev_abox)
> +		return -EPROBE_DEFER;
> +
> +	init_completion(&usb_audio->in_conn_stop);
> +	init_completion(&usb_audio->out_conn_stop);
> +	init_completion(&usb_audio->discon_done);
> +	usb_audio->abox = pdev_abox;
> +	usb_audio->hcd_pdev = pdev;
> +	usb_audio->udev = NULL;
> +	usb_audio->is_audio = 0;
> +	usb_audio->is_first_probe = 1;
> +	usb_audio->user_scenario = AUDIO_MODE_NORMAL;
> +	usb_audio->usb_audio_state = USB_AUDIO_DISCONNECT;
> +	usb_audio_connection = 0;
> +
> +	INIT_WORK(&usb_audio->usb_work, exynos_usb_audio_work);
> +
> +	/* interface function mapping */
> +	ret = snd_vendor_set_ops(&exynos_usb_audio_ops);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(exynos_usb_audio_init);

Why are you exporting functions that are never called?


> +
> +/* card */
> +static int exynos_usb_audio_connect(struct usb_interface *intf)
> +{
> +	struct usb_interface_descriptor *altsd;
> +	struct usb_host_interface *alts;
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +	int timeout = 0;
> +
> +	alts = &intf->altsetting[0];
> +	altsd = get_iface_desc(alts);
> +
> +	if ((altsd->bInterfaceClass == USB_CLASS_AUDIO ||
> +		altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC) &&
> +		altsd->bInterfaceSubClass == USB_SUBCLASS_MIDISTREAMING) {
> +	} else {
> +		if (usb_audio->usb_audio_state == USB_AUDIO_REMOVING) {
> +			timeout = wait_for_completion_timeout(
> +				&usb_audio->discon_done,
> +				msecs_to_jiffies(DISCONNECT_TIMEOUT));
> +
> +			if ((usb_audio->usb_audio_state == USB_AUDIO_REMOVING)
> +					&& !timeout) {
> +				usb_audio->usb_audio_state =
> +					USB_AUDIO_TIMEOUT_PROBE;
> +			}
> +		}
> +
> +		if ((usb_audio->usb_audio_state == USB_AUDIO_DISCONNECT)
> +			|| (usb_audio->usb_audio_state == USB_AUDIO_TIMEOUT_PROBE)) {
> +			exynos_usb_audio_set_device(udev);
> +			exynos_usb_audio_hcd(udev);
> +			exynos_usb_audio_conn(udev, 1);
> +			exynos_usb_audio_desc(udev);
> +		} else {
> +			return -EPERM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void exynos_usb_audio_disconn(struct usb_interface *intf)
> +{
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +
> +	exynos_usb_audio_conn(udev, 0);
> +}
> +
> +/* clock */
> +static int exynos_usb_audio_set_interface(struct usb_device *udev,
> +		struct usb_host_interface *alts, int iface, int alt)
> +{
> +	unsigned char ep;
> +	unsigned char numEndpoints;
> +	int direction;
> +	int i;
> +	int ret = 0;
> +
> +	if (alts != NULL) {
> +		numEndpoints = get_iface_desc(alts)->bNumEndpoints;
> +		if (numEndpoints < 1)
> +			return -22;
> +		if (numEndpoints == 1)
> +			ep = get_endpoint(alts, 0)->bEndpointAddress;
> +		else {
> +			for (i = 0; i < numEndpoints; i++) {
> +				ep = get_endpoint(alts, i)->bmAttributes;
> +				if (!(ep & 0x30)) {
> +					ep = get_endpoint(alts, i)->bEndpointAddress;
> +					break;
> +				}
> +			}
> +		}
> +		if (ep & USB_DIR_IN)
> +			direction = SNDRV_PCM_STREAM_CAPTURE;
> +		else
> +			direction = SNDRV_PCM_STREAM_PLAYBACK;
> +
> +		ret = exynos_usb_audio_setintf(udev, iface, alt, direction);
> +	}
> +
> +	return ret;
> +}
> +
> +/* pcm */
> +static int exynos_usb_audio_set_rate(int iface, int rate, int alt)
> +{
> +	int ret;
> +
> +	ret = exynos_usb_audio_setrate(iface, rate, alt);
> +
> +	return ret;
> +}
> +
> +static int exynos_usb_audio_set_pcmbuf(struct usb_device *dev, int iface)
> +{
> +	int ret;
> +
> +	ret = exynos_usb_audio_pcmbuf(dev, iface);
> +
> +	return ret;
> +}
> +
> +static int exynos_usb_audio_set_pcm_intf(struct usb_interface *intf,
> +					int iface, int alt, int direction)
> +{
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +	int ret;
> +
> +	ret = exynos_usb_audio_setintf(udev, iface, alt, direction);
> +
> +	return ret;
> +}
> +
> +static int exynos_usb_audio_pcm_control(struct usb_device *udev,
> +			enum snd_vendor_pcm_open_close onoff, int direction)
> +{
> +	int ret = 0;
> +
> +	if (onoff == 1) {
> +		ret = exynos_usb_audio_pcm(1, direction);
> +	} else if (onoff == 0) {
> +		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
> +			reinit_completion(&usb_audio->out_conn_stop);
> +		else if (direction == SNDRV_PCM_STREAM_CAPTURE)
> +			reinit_completion(&usb_audio->in_conn_stop);
> +
> +		if (!usb_audio->pcm_open_done)
> +			return 0;
> +
> +		ret = exynos_usb_audio_pcm(0, direction);
> +	}
> +
> +	return ret;
> +}
> +
> +static int exynos_usb_audio_add_control(struct snd_usb_audio *chip)
> +{
> +	int ret;
> +
> +	if (chip != NULL)
> +		ret = exynos_usb_add_ctls(chip, 0);
> +	else
> +		ret = usb_audio->user_scenario;
> +
> +	return ret;
> +}
> +
> +static int exynos_usb_audio_set_pcm_binterval(const struct audioformat *fp,
> +				 const struct audioformat *found,
> +				 int *cur_attr, int *attr)
> +{
> +	if (usb_audio->user_scenario >= AUDIO_MODE_IN_CALL) {
> +		if (fp->datainterval < found->datainterval) {
> +			found = fp;
> +			cur_attr = attr;
> +		}
> +	} else {
> +		if (fp->datainterval > found->datainterval) {
> +			found = fp;
> +			cur_attr = attr;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* Set interface function */
> +static struct snd_usb_audio_vendor_ops exynos_usb_audio_ops = {
> +	/* card */
> +	.connect = exynos_usb_audio_connect,
> +	.disconnect = exynos_usb_audio_disconn,
> +	/* clock */
> +	.set_interface = exynos_usb_audio_set_interface,
> +	/* pcm */
> +	.set_rate = exynos_usb_audio_set_rate,
> +	.set_pcm_buf = exynos_usb_audio_set_pcmbuf,
> +	.set_pcm_intf = exynos_usb_audio_set_pcm_intf,
> +	.set_pcm_connection = exynos_usb_audio_pcm_control,
> +	.set_pcm_binterval = exynos_usb_audio_set_pcm_binterval,
> +	.usb_add_ctls = exynos_usb_audio_add_control,
> +};
> +
> +int exynos_usb_audio_exit(void)
> +{
> +	/* future use */

What needs to be done here?

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(exynos_usb_audio_exit);

Why did you export a function that does nothing?

> +
> +MODULE_AUTHOR("Jaehun Jung <jh0801.jung@samsung.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Exynos USB Audio offloading driver");
> +
> diff --git a/sound/usb/exynos_usb_audio.h b/sound/usb/exynos_usb_audio.h
> new file mode 100644
> index 0000000..13707744
> --- /dev/null
> +++ b/sound/usb/exynos_usb_audio.h
> @@ -0,0 +1,150 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*   USB Audio Driver for Exynos
> + *
> + *   Copyright (c) 2017 by Kyounghye Yun <k-hye.yun@samsung.com>
> + *
> + */
> +
> +#ifndef __LINUX_USB_EXYNOS_AUDIO_H
> +#define __LINUX_USB_EXYNOS_AUDIO_H
> +
> +#include "../../../sound/usb/usbaudio.h"
> +
> +/* for KM */
> +
> +#define USB_AUDIO_MEM_BASE	0xC0000000
> +
> +#define USB_AUDIO_SAVE_RESTORE	(USB_AUDIO_MEM_BASE)
> +#define USB_AUDIO_DEV_CTX	(USB_AUDIO_SAVE_RESTORE+PAGE_SIZE)
> +#define USB_AUDIO_INPUT_CTX	(USB_AUDIO_DEV_CTX+PAGE_SIZE)
> +#define USB_AUDIO_OUT_DEQ	(USB_AUDIO_INPUT_CTX+PAGE_SIZE)
> +#define USB_AUDIO_IN_DEQ	(USB_AUDIO_OUT_DEQ+PAGE_SIZE)
> +#define USB_AUDIO_FBOUT_DEQ	(USB_AUDIO_IN_DEQ+PAGE_SIZE)
> +#define USB_AUDIO_FBIN_DEQ	(USB_AUDIO_FBOUT_DEQ+PAGE_SIZE)
> +#define USB_AUDIO_ERST		(USB_AUDIO_FBIN_DEQ+PAGE_SIZE)
> +#define USB_AUDIO_DESC		(USB_AUDIO_ERST+PAGE_SIZE)
> +#define USB_AUDIO_PCM_OUTBUF	(USB_AUDIO_MEM_BASE+0x100000)
> +#define USB_AUDIO_PCM_INBUF	(USB_AUDIO_MEM_BASE+0x800000)
> +
> +#if defined(CONFIG_SOC_S5E9815)
> +#define USB_AUDIO_XHCI_BASE	0x12210000
> +#define USB_URAM_BASE		0x122a0000
> +#define USB_URAM_SIZE		(SZ_1K * 24)
> +#elif defined(CONFIG_SOC_S5E9935)
> +#define USB_AUDIO_XHCI_BASE	0x10B00000
> +#define USB_URAM_BASE		0x02a00000
> +#define USB_URAM_SIZE		(SZ_1K * 24)

Shouldn't this information come from a DT file?


> +#else
> +#error

Error what?

> +#endif
> +
> +#define USB_AUDIO_CONNECT		(1 << 0)
> +#define USB_AUDIO_REMOVING		(1 << 1)
> +#define USB_AUDIO_DISCONNECT		(1 << 2)
> +#define USB_AUDIO_TIMEOUT_PROBE	(1 << 3)

BIT()?

> +
> +#define DISCONNECT_TIMEOUT	(500)
> +
> +#define AUDIO_MODE_NORMAL		0
> +#define AUDIO_MODE_RINGTONE		1
> +#define AUDIO_MODE_IN_CALL		2
> +#define AUDIO_MODE_IN_COMMUNICATION	3
> +#define AUDIO_MODE_CALL_SCREEN		4
> +
> +#define	CALL_INTERVAL_THRESHOLD		3
> +
> +#define USB_AUDIO_CONNECT		(1 << 0)
> +#define USB_AUDIO_REMOVING		(1 << 1)
> +#define USB_AUDIO_DISCONNECT		(1 << 2)
> +#define USB_AUDIO_TIMEOUT_PROBE	(1 << 3)
> +
> +#define DISCONNECT_TIMEOUT	(500)

What units is this in?

> +
> +struct host_data {
> +	dma_addr_t out_data_dma;
> +	dma_addr_t in_data_dma;
> +	void *out_data_addr;
> +	void *in_data_addr;

Why void pointers?  io pointers?

Again, does this code even work?

confused,

greg k-h
