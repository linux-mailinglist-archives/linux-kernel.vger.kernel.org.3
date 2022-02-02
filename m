Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E44A6C6D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbiBBHpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:45:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:20531 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234558AbiBBHpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643787906; x=1675323906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mUhOSEsTR510GwEtGL9hBhvUnZQ9NLqY2OCniJGKvBw=;
  b=Z5geL2vs8osyZE/CbfjUOswXcEjH7VloL6GPjvX3oCxODwkf+h7bAoii
   fpzMTff/QHrIH7uB1SFijTc2TAqI5spvoTuhh6Q5DxflXm6bar1yLRFqw
   7M6APegKq96aLQzjiSlC9Wi52dS78duAmG8sEtmXzoSZme3Qc8rMKRb9e
   8tFP+hPONRC1t8dcp9WXdeLTx7T06czQcQN9evxNOm7RZ1X4HiTKUY/kx
   UYB4GHZGCchab42T/81K5ShEEy9pf2IVuXlnBqZnVGjU+BvUndWqVI1fT
   cCCcJyQ9SGr6aLOk3xNNgBd2E68IG4N1FZH+05hJFLS46gAaVwYTfHoR+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="245453443"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="245453443"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 22:22:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="480001246"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 22:22:41 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nF92O-000UDY-HZ; Wed, 02 Feb 2022 06:22:40 +0000
Date:   Wed, 2 Feb 2022 14:22:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 3/4] usb: typec: Factor out non-PD fwnode properties
Message-ID: <202202021458.xcH4F4SQ-lkp@intel.com>
References: <20220201032440.5196-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201032440.5196-3-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on robh/for-next v5.17-rc2 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Samuel-Holland/dt-bindings-vendor-prefixes-Add-willsemi/20220201-112541
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: openrisc-randconfig-m031-20220201 (https://download.01.org/0day-ci/archive/20220202/202202021458.xcH4F4SQ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/usb/typec/class.c:1919 typec_get_fw_cap() warn: unsigned 'cap->type' is never less than zero.
drivers/usb/typec/class.c:1926 typec_get_fw_cap() warn: unsigned 'cap->data' is never less than zero.

vim +1919 drivers/usb/typec/class.c

  1896	
  1897	int typec_get_fw_cap(struct typec_capability *cap,
  1898			     struct fwnode_handle *fwnode)
  1899	{
  1900		const char *cap_str;
  1901		int ret;
  1902	
  1903		/*
  1904		 * This fwnode has a "compatible" property, but is never populated as a
  1905		 * struct device. Instead we simply parse it to read the properties.
  1906		 * This it breaks fw_devlink=on. To maintain backward compatibility
  1907		 * with existing DT files, we work around this by deleting any
  1908		 * fwnode_links to/from this fwnode.
  1909		 */
  1910		fw_devlink_purge_absent_suppliers(fwnode);
  1911	
  1912		cap->fwnode = fwnode;
  1913	
  1914		ret = fwnode_property_read_string(fwnode, "power-role", &cap_str);
  1915		if (ret < 0)
  1916			return ret;
  1917	
  1918		cap->type = typec_find_port_power_role(cap_str);
> 1919		if (cap->type < 0)
  1920			return cap->type;
  1921	
  1922		/* USB data support is optional */
  1923		ret = fwnode_property_read_string(fwnode, "data-role", &cap_str);
  1924		if (ret == 0) {
  1925			cap->data = typec_find_port_data_role(cap_str);
> 1926			if (cap->data < 0)
  1927				return cap->data;
  1928		}
  1929	
  1930		/* Get the preferred power role for a DRP */
  1931		if (cap->type == TYPEC_PORT_DRP) {
  1932			cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
  1933	
  1934			ret = fwnode_property_read_string(fwnode, "try-power-role", &cap_str);
  1935			if (ret == 0) {
  1936				cap->prefer_role = typec_find_power_role(cap_str);
  1937				if (cap->prefer_role < 0)
  1938					return cap->prefer_role;
  1939			}
  1940		}
  1941	
  1942		return 0;
  1943	}
  1944	EXPORT_SYMBOL_GPL(typec_get_fw_cap);
  1945	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
