Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC54A3C78
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 02:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357308AbiAaBWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 20:22:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:14704 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbiAaBWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 20:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643592123; x=1675128123;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xRBCzaGRkvMwM18UcD20qytUURheOa28BU/hbCau9PQ=;
  b=ZE5pOS0YNGdEHzWNQSD/6DZGurKbbgnMzMzqeeJT0+YIVCzcc6IV9Z3r
   6i34FupNpOXdJ977wMHFGPTnLBrQFODB6xr5MbFYadDLEKcpBeqNAcqaz
   Mt7XzGpHM+vB1jtg6nVB1LNUGA8Tl4QGqMQYcxU3XLJPBd+fSBmUSOeyO
   KWHXPrqkVNZNdTSC6EQCZLz3K2qkKdarFodExlg7/AHsPRYGQlPEiLQAR
   IQFFjrVVod9OYjDXgPeOEZsyOgHjTEth/PEy7NBCclPRSdTuNs2TLKsoC
   RO9U5mziyN3hrOcMAELdf0eh0NLNTzWp2eP+APr6oXsMBhLfdxowUiGV/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="246221873"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="246221873"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 17:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="770632130"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2022 17:22:01 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nELOK-000RDK-Py; Mon, 31 Jan 2022 01:22:00 +0000
Date:   Mon, 31 Jan 2022 09:21:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [linux-stable-rc:queue/4.4 9764/9999] drivers/hid/wacom_sys.c:1737:
 undefined reference to `usb_hid_driver'
Message-ID: <202201310959.QRbF6sHC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.4
head:   a15b489d4e8e800e14eb78294d86d816e6e14723
commit: 203226dcfd74f4d42bf7efcb6e1d08b12cde59a3 [9764/9999] HID: wacom: fix problems when device is not a valid USB device
config: i386-randconfig-r024-20220131 (https://download.01.org/0day-ci/archive/20220131/202201310959.QRbF6sHC-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=203226dcfd74f4d42bf7efcb6e1d08b12cde59a3
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.4
        git checkout 203226dcfd74f4d42bf7efcb6e1d08b12cde59a3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/built-in.o: in function `wacom_probe':
>> drivers/hid/wacom_sys.c:1737: undefined reference to `usb_hid_driver'


vim +1737 drivers/hid/wacom_sys.c

  1691	
  1692	static int wacom_probe(struct hid_device *hdev,
  1693			const struct hid_device_id *id)
  1694	{
  1695		struct wacom *wacom;
  1696		struct wacom_wac *wacom_wac;
  1697		struct wacom_features *features;
  1698		int error;
  1699		unsigned int connect_mask = HID_CONNECT_HIDRAW;
  1700	
  1701		if (!id->driver_data)
  1702			return -EINVAL;
  1703	
  1704		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
  1705	
  1706		/* hid-core sets this quirk for the boot interface */
  1707		hdev->quirks &= ~HID_QUIRK_NOGET;
  1708	
  1709		wacom = kzalloc(sizeof(struct wacom), GFP_KERNEL);
  1710		if (!wacom)
  1711			return -ENOMEM;
  1712	
  1713		hid_set_drvdata(hdev, wacom);
  1714		wacom->hdev = hdev;
  1715	
  1716		/* ask for the report descriptor to be loaded by HID */
  1717		error = hid_parse(hdev);
  1718		if (error) {
  1719			hid_err(hdev, "parse failed\n");
  1720			goto fail_parse;
  1721		}
  1722	
  1723		wacom_wac = &wacom->wacom_wac;
  1724		wacom_wac->features = *((struct wacom_features *)id->driver_data);
  1725		features = &wacom_wac->features;
  1726		features->pktlen = wacom_compute_pktlen(hdev);
  1727		if (features->pktlen > WACOM_PKGLEN_MAX) {
  1728			error = -EINVAL;
  1729			goto fail_pktlen;
  1730		}
  1731	
  1732		if (features->check_for_hid_type && features->hid_type != hdev->type) {
  1733			error = -ENODEV;
  1734			goto fail_type;
  1735		}
  1736	
> 1737		if (hid_is_usb(hdev)) {
  1738			struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
  1739			struct usb_device *dev = interface_to_usbdev(intf);
  1740	
  1741			wacom->usbdev = dev;
  1742			wacom->intf = intf;
  1743		}
  1744	
  1745		mutex_init(&wacom->lock);
  1746		INIT_WORK(&wacom->work, wacom_wireless_work);
  1747	
  1748		error = wacom_allocate_inputs(wacom);
  1749		if (error)
  1750			goto fail_allocate_inputs;
  1751	
  1752		/*
  1753		 * Bamboo Pad has a generic hid handling for the Pen, and we switch it
  1754		 * into debug mode for the touch part.
  1755		 * We ignore the other interfaces.
  1756		 */
  1757		if (features->type == BAMBOO_PAD) {
  1758			if (features->pktlen == WACOM_PKGLEN_PENABLED) {
  1759				features->type = HID_GENERIC;
  1760			} else if ((features->pktlen != WACOM_PKGLEN_BPAD_TOUCH) &&
  1761				   (features->pktlen != WACOM_PKGLEN_BPAD_TOUCH_USB)) {
  1762				error = -ENODEV;
  1763				goto fail_shared_data;
  1764			}
  1765		}
  1766	
  1767		/* set the default size in case we do not get them from hid */
  1768		wacom_set_default_phy(features);
  1769	
  1770		/* Retrieve the physical and logical size for touch devices */
  1771		wacom_retrieve_hid_descriptor(hdev, features);
  1772		wacom_setup_device_quirks(wacom);
  1773	
  1774		if (features->device_type == WACOM_DEVICETYPE_NONE &&
  1775		    features->type != WIRELESS) {
  1776			error = features->type == HID_GENERIC ? -ENODEV : 0;
  1777	
  1778			dev_warn(&hdev->dev, "Unknown device_type for '%s'. %s.",
  1779				 hdev->name,
  1780				 error ? "Ignoring" : "Assuming pen");
  1781	
  1782			if (error)
  1783				goto fail_shared_data;
  1784	
  1785			features->device_type |= WACOM_DEVICETYPE_PEN;
  1786		}
  1787	
  1788		wacom_calculate_res(features);
  1789	
  1790		wacom_update_name(wacom);
  1791	
  1792		error = wacom_add_shared_data(hdev);
  1793		if (error)
  1794			goto fail_shared_data;
  1795	
  1796		if (!(features->device_type & WACOM_DEVICETYPE_WL_MONITOR) &&
  1797		     (features->quirks & WACOM_QUIRK_BATTERY)) {
  1798			error = wacom_initialize_battery(wacom);
  1799			if (error)
  1800				goto fail_battery;
  1801		}
  1802	
  1803		error = wacom_register_inputs(wacom);
  1804		if (error)
  1805			goto fail_register_inputs;
  1806	
  1807		if (hdev->bus == BUS_BLUETOOTH) {
  1808			error = device_create_file(&hdev->dev, &dev_attr_speed);
  1809			if (error)
  1810				hid_warn(hdev,
  1811					 "can't create sysfs speed attribute err: %d\n",
  1812					 error);
  1813		}
  1814	
  1815		if (features->type == HID_GENERIC)
  1816			connect_mask |= HID_CONNECT_DRIVER;
  1817	
  1818		/* Regular HID work starts now */
  1819		error = hid_hw_start(hdev, connect_mask);
  1820		if (error) {
  1821			hid_err(hdev, "hw start failed\n");
  1822			goto fail_hw_start;
  1823		}
  1824	
  1825		/* Note that if query fails it is not a hard failure */
  1826		wacom_query_tablet_data(hdev, features);
  1827	
  1828		/* touch only Bamboo doesn't support pen */
  1829		if ((features->type == BAMBOO_TOUCH) &&
  1830		    (features->device_type & WACOM_DEVICETYPE_PEN)) {
  1831			error = -ENODEV;
  1832			goto fail_hw_start;
  1833		}
  1834	
  1835		/* pen only Bamboo neither support touch nor pad */
  1836		if ((features->type == BAMBOO_PEN) &&
  1837		    ((features->device_type & WACOM_DEVICETYPE_TOUCH) ||
  1838		    (features->device_type & WACOM_DEVICETYPE_PAD))) {
  1839			error = -ENODEV;
  1840			goto fail_hw_start;
  1841		}
  1842	
  1843		if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
  1844			error = hid_hw_open(hdev);
  1845	
  1846		if ((wacom_wac->features.type == INTUOSHT ||
  1847		    wacom_wac->features.type == INTUOSHT2) &&
  1848		    (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)) {
  1849				wacom_wac->shared->touch_input = wacom_wac->touch_input;
  1850		}
  1851	
  1852		return 0;
  1853	
  1854	fail_hw_start:
  1855		if (hdev->bus == BUS_BLUETOOTH)
  1856			device_remove_file(&hdev->dev, &dev_attr_speed);
  1857	fail_register_inputs:
  1858		wacom_clean_inputs(wacom);
  1859		wacom_destroy_battery(wacom);
  1860	fail_battery:
  1861		wacom_remove_shared_data(wacom);
  1862	fail_shared_data:
  1863		wacom_clean_inputs(wacom);
  1864	fail_allocate_inputs:
  1865	fail_type:
  1866	fail_pktlen:
  1867	fail_parse:
  1868		kfree(wacom);
  1869		hid_set_drvdata(hdev, NULL);
  1870		return error;
  1871	}
  1872	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
