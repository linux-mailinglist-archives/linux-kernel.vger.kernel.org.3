Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4A94689DA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 09:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhLEHyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 02:54:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:30006 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231583AbhLEHyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 02:54:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="236980539"
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="236980539"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 23:51:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="542072928"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Dec 2021 23:51:24 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtmIt-000Jwh-JB; Sun, 05 Dec 2021 07:51:23 +0000
Date:   Sun, 5 Dec 2021 15:50:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/s390/scsi/zfcp_sysfs.c:675:18: sparse: sparse: symbol
 'zfcp_sdev_attrs' was not declared. Should it be static?
Message-ID: <202112051502.3n0KCWMq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79a72162048e42a677bc7336a9f5d86fc3ff9558
commit: d8d7cf3f7d073cea8c3e4c3a740d5d24744280d0 scsi: zfcp: Switch to attribute groups
date:   7 weeks ago
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20211205/202112051502.3n0KCWMq-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d8d7cf3f7d073cea8c3e4c3a740d5d24744280d0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d8d7cf3f7d073cea8c3e4c3a740d5d24744280d0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/s390/scsi/zfcp_sysfs.c:675:18: sparse: sparse: symbol 'zfcp_sdev_attrs' was not declared. Should it be static?

vim +/zfcp_sdev_attrs +675 drivers/s390/scsi/zfcp_sysfs.c

   646	
   647	static ssize_t zfcp_sysfs_scsi_zfcp_failed_store(struct device *dev,
   648						    struct device_attribute *attr,
   649						    const char *buf, size_t count)
   650	{
   651		struct scsi_device *sdev = to_scsi_device(dev);
   652		unsigned long val;
   653	
   654		if (kstrtoul(buf, 0, &val) || val != 0)
   655			return -EINVAL;
   656	
   657		zfcp_erp_set_lun_status(sdev, ZFCP_STATUS_COMMON_RUNNING);
   658		zfcp_erp_lun_reopen(sdev, ZFCP_STATUS_COMMON_ERP_FAILED,
   659				    "syufai3");
   660		zfcp_erp_wait(sdev_to_zfcp(sdev)->port->adapter);
   661	
   662		return count;
   663	}
   664	static DEVICE_ATTR(zfcp_failed, S_IWUSR | S_IRUGO,
   665			   zfcp_sysfs_scsi_zfcp_failed_show,
   666			   zfcp_sysfs_scsi_zfcp_failed_store);
   667	
   668	ZFCP_DEFINE_SCSI_ATTR(zfcp_in_recovery, "%d\n",
   669			      (atomic_read(&zfcp_sdev->status) &
   670			       ZFCP_STATUS_COMMON_ERP_INUSE) != 0);
   671	
   672	ZFCP_DEFINE_SCSI_ATTR(zfcp_status, "0x%08x\n",
   673			      atomic_read(&zfcp_sdev->status));
   674	
 > 675	struct attribute *zfcp_sdev_attrs[] = {
   676		&dev_attr_fcp_lun.attr,
   677		&dev_attr_wwpn.attr,
   678		&dev_attr_hba_id.attr,
   679		&dev_attr_read_latency.attr,
   680		&dev_attr_write_latency.attr,
   681		&dev_attr_cmd_latency.attr,
   682		&dev_attr_zfcp_access_denied.attr,
   683		&dev_attr_zfcp_failed.attr,
   684		&dev_attr_zfcp_in_recovery.attr,
   685		&dev_attr_zfcp_status.attr,
   686		NULL
   687	};
   688	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
