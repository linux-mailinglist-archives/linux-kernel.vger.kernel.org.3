Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E5358C208
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbiHHD0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiHHD0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:26:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40394DFE5;
        Sun,  7 Aug 2022 20:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659929167; x=1691465167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bOeEbQASG8qYDkYJbxcsIUMSn9m3cJLEwP0JygTYejw=;
  b=RZeFJKwcGDqZsZwhWgouJVIv2SLE4VaAQSBNXHLRYXo274EET15TAUxW
   rR8RgdMBddin1WBjHWHQl1a/0MQrXqvCcXIn56OwO2UDvSnSww/ey1AHO
   25jMLGrzcg+0oYqYAx4KIFBHZHCI7b54lEIok4H0ejPi1gNHYPVAS2BZR
   T/varMc9QP3Ny83CUN6zZ+wR2zuF3wOqtpjlVMcRSmPysWz0xML1XD1/B
   ISa8mXsa2Nk7acph52tkEQTBxQtjZkabb4ehGJkH2jNcoaasi0m38GKDL
   Uxauo/nXoVrk0JpoCWcBm9Zo/h66XL7lZFsWosUq0hCmVdGnBlzlE5ZOg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="376786101"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="376786101"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 20:26:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="931870261"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2022 20:26:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKtP1-000Lqj-1H;
        Mon, 08 Aug 2022 03:26:03 +0000
Date:   Mon, 8 Aug 2022 11:25:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Jinlin <lijinlin3@huawei.com>, lduncan@suse.com,
        cleech@redhat.com, michael.christie@oracle.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mark.mielke@gmail.com
Cc:     kbuild-all@lists.01.org, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: Re: [PATCH] scsi: iscsi: iscsi_tcp: Fix null-ptr-deref while calling
 getpeername()
Message-ID: <202208081109.mO6WgY4E-lkp@intel.com>
References: <20220802101939.3972556-1-lijinlin3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802101939.3972556-1-lijinlin3@huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next linus/master v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Jinlin/scsi-iscsi-iscsi_tcp-Fix-null-ptr-deref-while-calling-getpeername/20220802-173945
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
config: powerpc-randconfig-s051-20220801 (https://download.01.org/0day-ci/archive/20220808/202208081109.mO6WgY4E-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/ccc367df3fdba07b24eeda721ca928cce50f40d2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Jinlin/scsi-iscsi-iscsi_tcp-Fix-null-ptr-deref-while-calling-getpeername/20220802-173945
        git checkout ccc367df3fdba07b24eeda721ca928cce50f40d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/iscsi_tcp.c:798:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int fd @@     got struct file *file @@
   drivers/scsi/iscsi_tcp.c:798:26: sparse:     expected unsigned int fd
   drivers/scsi/iscsi_tcp.c:798:26: sparse:     got struct file *file
   drivers/scsi/iscsi_tcp.c:852:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int fd @@     got struct file *file @@
   drivers/scsi/iscsi_tcp.c:852:26: sparse:     expected unsigned int fd
   drivers/scsi/iscsi_tcp.c:852:26: sparse:     got struct file *file

vim +798 drivers/scsi/iscsi_tcp.c

   777	
   778	static int iscsi_sw_tcp_conn_get_param(struct iscsi_cls_conn *cls_conn,
   779					       enum iscsi_param param, char *buf)
   780	{
   781		struct iscsi_conn *conn = cls_conn->dd_data;
   782		struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
   783		struct iscsi_sw_tcp_conn *tcp_sw_conn = tcp_conn->dd_data;
   784		struct sockaddr_in6 addr;
   785		struct socket *sock;
   786		int rc;
   787	
   788		switch(param) {
   789		case ISCSI_PARAM_CONN_PORT:
   790		case ISCSI_PARAM_CONN_ADDRESS:
   791		case ISCSI_PARAM_LOCAL_PORT:
   792			spin_lock_bh(&conn->session->frwd_lock);
   793			if (!tcp_sw_conn || !tcp_sw_conn->sock) {
   794				spin_unlock_bh(&conn->session->frwd_lock);
   795				return -ENOTCONN;
   796			}
   797			sock = tcp_sw_conn->sock;
 > 798			fget(sock->file);
   799			spin_unlock_bh(&conn->session->frwd_lock);
   800	
   801			if (param == ISCSI_PARAM_LOCAL_PORT)
   802				rc = kernel_getsockname(sock,
   803							(struct sockaddr *)&addr);
   804			else
   805				rc = kernel_getpeername(sock,
   806							(struct sockaddr *)&addr);
   807			spin_lock_bh(&conn->session->frwd_lock);
   808			sockfd_put(sock);
   809			spin_unlock_bh(&conn->session->frwd_lock);
   810			if (rc < 0)
   811				return rc;
   812	
   813			return iscsi_conn_get_addr_param((struct sockaddr_storage *)
   814							 &addr, param, buf);
   815		default:
   816			return iscsi_conn_get_param(cls_conn, param, buf);
   817		}
   818	
   819		return 0;
   820	}
   821	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
