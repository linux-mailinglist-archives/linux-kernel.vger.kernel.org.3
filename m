Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA4563298
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiGALar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiGALap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:30:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940D782383;
        Fri,  1 Jul 2022 04:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656675044; x=1688211044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3kPfOHfjIBf7W20Epp+1WTMTDsoD04Mm5nrBBI9O6RE=;
  b=HOjYwk0qCOVGuXSDIeUCPbXoq36CsWyihD/FWRzteyOTvoxLgBTzo9zM
   dOPvLNwCSlIVgrDTX8EN8Lf/uw0HWBrVEAYYrIsqMSm2YIT01Qa8hGaDG
   H2ZKGlzzGrONK8l9FXC9up3jVqPG1Pu8KV/q7/tmtkohTb0en1mQRP+cP
   ZHra8m+4ldBs8khoMdl416LD1pvGJ0PgeUCX9gGZKfk7xNvMDYVSFqTLW
   KLJFxq6aVuZBDcUBWdET92yQ7sklUul/7PVmEdMGhblD4dt0GKwDF8wXP
   lfhqOSXrvxteBWYlA8REF75PBEsa4kzKeLTDdEyzM2DNdcatKCzSqCBva
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="263030934"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="263030934"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 04:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="648317252"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2022 04:30:42 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7ErB-000DtL-D9;
        Fri, 01 Jul 2022 11:30:41 +0000
Date:   Fri, 1 Jul 2022 19:30:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pm@vger.kernel.org, Richard Gong <richard.gong@amd.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/10] HID: usbhid: Set USB mice as s2idle wakeup
 resources
Message-ID: <202207011931.a4oqLMtN-lkp@intel.com>
References: <20220701023328.2783-10-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701023328.2783-10-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on drm-misc/drm-misc-next hid/for-next linus/master v5.19-rc4 next-20220701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PM-suspend-Introduce-pm_suspend_preferred_s2idle/20220701-103534
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220701/202207011931.a4oqLMtN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a9119143a2d1f4d0d0bc1fe0d819e5351b4e0deb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/54a1cce9cd825e0570d307b44a695f04bba77fd2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/PM-suspend-Introduce-pm_suspend_preferred_s2idle/20220701-103534
        git checkout 54a1cce9cd825e0570d307b44a695f04bba77fd2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hid/usbhid/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hid/usbhid/hid-core.c:1200:8: error: call to undeclared function 'pm_suspend_preferred_s2idle'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           if (pm_suspend_preferred_s2idle() &&
                               ^
   drivers/hid/usbhid/hid-core.c:1200:8: note: did you mean 'pm_suspend_default_s2idle'?
   include/linux/suspend.h:343:20: note: 'pm_suspend_default_s2idle' declared here
   static inline bool pm_suspend_default_s2idle(void) { return false; }
                      ^
   1 error generated.


vim +/pm_suspend_preferred_s2idle +1200 drivers/hid/usbhid/hid-core.c

  1060	
  1061	static int usbhid_start(struct hid_device *hid)
  1062	{
  1063		struct usb_interface *intf = to_usb_interface(hid->dev.parent);
  1064		struct usb_host_interface *interface = intf->cur_altsetting;
  1065		struct usb_device *dev = interface_to_usbdev(intf);
  1066		struct usbhid_device *usbhid = hid->driver_data;
  1067		unsigned int n, insize = 0;
  1068		int ret;
  1069	
  1070		mutex_lock(&usbhid->mutex);
  1071	
  1072		clear_bit(HID_DISCONNECTED, &usbhid->iofl);
  1073	
  1074		usbhid->bufsize = HID_MIN_BUFFER_SIZE;
  1075		hid_find_max_report(hid, HID_INPUT_REPORT, &usbhid->bufsize);
  1076		hid_find_max_report(hid, HID_OUTPUT_REPORT, &usbhid->bufsize);
  1077		hid_find_max_report(hid, HID_FEATURE_REPORT, &usbhid->bufsize);
  1078	
  1079		if (usbhid->bufsize > HID_MAX_BUFFER_SIZE)
  1080			usbhid->bufsize = HID_MAX_BUFFER_SIZE;
  1081	
  1082		hid_find_max_report(hid, HID_INPUT_REPORT, &insize);
  1083	
  1084		if (insize > HID_MAX_BUFFER_SIZE)
  1085			insize = HID_MAX_BUFFER_SIZE;
  1086	
  1087		if (hid_alloc_buffers(dev, hid)) {
  1088			ret = -ENOMEM;
  1089			goto fail;
  1090		}
  1091	
  1092		for (n = 0; n < interface->desc.bNumEndpoints; n++) {
  1093			struct usb_endpoint_descriptor *endpoint;
  1094			int pipe;
  1095			int interval;
  1096	
  1097			endpoint = &interface->endpoint[n].desc;
  1098			if (!usb_endpoint_xfer_int(endpoint))
  1099				continue;
  1100	
  1101			interval = endpoint->bInterval;
  1102	
  1103			/* Some vendors give fullspeed interval on highspeed devides */
  1104			if (hid->quirks & HID_QUIRK_FULLSPEED_INTERVAL &&
  1105			    dev->speed == USB_SPEED_HIGH) {
  1106				interval = fls(endpoint->bInterval*8);
  1107				pr_info("%s: Fixing fullspeed to highspeed interval: %d -> %d\n",
  1108					hid->name, endpoint->bInterval, interval);
  1109			}
  1110	
  1111			/* Change the polling interval of mice, joysticks
  1112			 * and keyboards.
  1113			 */
  1114			switch (hid->collection->usage) {
  1115			case HID_GD_MOUSE:
  1116				if (hid_mousepoll_interval > 0)
  1117					interval = hid_mousepoll_interval;
  1118				break;
  1119			case HID_GD_JOYSTICK:
  1120				if (hid_jspoll_interval > 0)
  1121					interval = hid_jspoll_interval;
  1122				break;
  1123			case HID_GD_KEYBOARD:
  1124				if (hid_kbpoll_interval > 0)
  1125					interval = hid_kbpoll_interval;
  1126				break;
  1127			}
  1128	
  1129			ret = -ENOMEM;
  1130			if (usb_endpoint_dir_in(endpoint)) {
  1131				if (usbhid->urbin)
  1132					continue;
  1133				if (!(usbhid->urbin = usb_alloc_urb(0, GFP_KERNEL)))
  1134					goto fail;
  1135				pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
  1136				usb_fill_int_urb(usbhid->urbin, dev, pipe, usbhid->inbuf, insize,
  1137						 hid_irq_in, hid, interval);
  1138				usbhid->urbin->transfer_dma = usbhid->inbuf_dma;
  1139				usbhid->urbin->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
  1140			} else {
  1141				if (usbhid->urbout)
  1142					continue;
  1143				if (!(usbhid->urbout = usb_alloc_urb(0, GFP_KERNEL)))
  1144					goto fail;
  1145				pipe = usb_sndintpipe(dev, endpoint->bEndpointAddress);
  1146				usb_fill_int_urb(usbhid->urbout, dev, pipe, usbhid->outbuf, 0,
  1147						 hid_irq_out, hid, interval);
  1148				usbhid->urbout->transfer_dma = usbhid->outbuf_dma;
  1149				usbhid->urbout->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
  1150			}
  1151		}
  1152	
  1153		usbhid->urbctrl = usb_alloc_urb(0, GFP_KERNEL);
  1154		if (!usbhid->urbctrl) {
  1155			ret = -ENOMEM;
  1156			goto fail;
  1157		}
  1158	
  1159		usb_fill_control_urb(usbhid->urbctrl, dev, 0, (void *) usbhid->cr,
  1160				     usbhid->ctrlbuf, 1, hid_ctrl, hid);
  1161		usbhid->urbctrl->transfer_dma = usbhid->ctrlbuf_dma;
  1162		usbhid->urbctrl->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
  1163	
  1164		set_bit(HID_STARTED, &usbhid->iofl);
  1165	
  1166		if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
  1167			ret = usb_autopm_get_interface(usbhid->intf);
  1168			if (ret)
  1169				goto fail;
  1170			set_bit(HID_IN_POLLING, &usbhid->iofl);
  1171			usbhid->intf->needs_remote_wakeup = 1;
  1172			ret = hid_start_in(hid);
  1173			if (ret) {
  1174				dev_err(&hid->dev,
  1175					"failed to start in urb: %d\n", ret);
  1176			}
  1177			usb_autopm_put_interface(usbhid->intf);
  1178		}
  1179	
  1180		if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT) {
  1181			switch (interface->desc.bInterfaceProtocol) {
  1182			/* Some keyboards don't work until their LEDs have been set.
  1183			 * Since BIOSes do set the LEDs, it must be safe for any device
  1184			 * that supports the keyboard boot protocol.
  1185			 * In addition, enable remote wakeup by default for all keyboard
  1186			 * devices supporting the boot protocol.
  1187			 */
  1188			case USB_INTERFACE_PROTOCOL_KEYBOARD:
  1189				usbhid_set_leds(hid);
  1190				device_set_wakeup_enable(&dev->dev, 1);
  1191				break;
  1192			/*
  1193			 * Windows configures USB mice to be a wakeup source from Modern
  1194			 * Standby, and users have expectations that s2idle wakeup sources
  1195			 * behave the same.  Thus setup remote wakeup by default for mice
  1196			 * supporting boot protocol if the system supports s2idle and the user
  1197			 * has not disabled it on the kernel command line.
  1198			 */
  1199			case USB_INTERFACE_PROTOCOL_MOUSE:
> 1200				if (pm_suspend_preferred_s2idle() &&
  1201				    pm_suspend_default_s2idle())
  1202					device_set_wakeup_enable(&dev->dev, 1);
  1203				break;
  1204			}
  1205		}
  1206	
  1207		mutex_unlock(&usbhid->mutex);
  1208		return 0;
  1209	
  1210	fail:
  1211		usb_free_urb(usbhid->urbin);
  1212		usb_free_urb(usbhid->urbout);
  1213		usb_free_urb(usbhid->urbctrl);
  1214		usbhid->urbin = NULL;
  1215		usbhid->urbout = NULL;
  1216		usbhid->urbctrl = NULL;
  1217		hid_free_buffers(dev, hid);
  1218		mutex_unlock(&usbhid->mutex);
  1219		return ret;
  1220	}
  1221	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
