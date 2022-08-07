Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C240858BBE1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiHGQmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 12:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiHGQmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 12:42:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BFA2BD2;
        Sun,  7 Aug 2022 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659890566; x=1691426566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6OhnfoBiaZTWht7GA1P70bu9k1nEE2U220KaOY5t++U=;
  b=I+o538DMnKwBE6TRfOH7N995fVGxZRqG81pSE3MSrDFyM8rJKLJ8CrfX
   oPj/QfXZU5zOsuozFx/2HEja7oKUlRGzfwfZPz7FURPq3VO5ILy6HiHEY
   tCwSeHyIBcnKzklF/+tM6H88Gi1gNu96SGXweeGOg5sTJzCcspa/rdWAG
   Vhve+CA8kTE+eSYSvaCp6q53dstmF3yzRw7ODPT579P/3F3/dn+msn23U
   S02uOUYlBzWVc3RfxHuFJbaGJMnzMPV/xk8u81DCFstlVS8IlK0i64QHg
   ij6nUA2w/dZy7HZA38s+jp2ql3ps5mIH7azv6psC4hbbNwaeRaeOlYqpa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="352174740"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="352174740"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 09:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="693502765"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2022 09:42:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKjMP-000LTb-2U;
        Sun, 07 Aug 2022 16:42:41 +0000
Date:   Mon, 8 Aug 2022 00:41:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Jinlin <lijinlin3@huawei.com>, lduncan@suse.com,
        cleech@redhat.com, michael.christie@oracle.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mark.mielke@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH] scsi: iscsi: iscsi_tcp: Fix null-ptr-deref while calling
 getpeername()
Message-ID: <202208080020.xQk6IIBw-lkp@intel.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on jejb-scsi/for-next linus/master v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Jinlin/scsi-iscsi-iscsi_tcp-Fix-null-ptr-deref-while-calling-getpeername/20220802-173945
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
config: x86_64-randconfig-r033-20220801 (https://download.01.org/0day-ci/archive/20220808/202208080020.xQk6IIBw-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ccc367df3fdba07b24eeda721ca928cce50f40d2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Jinlin/scsi-iscsi-iscsi_tcp-Fix-null-ptr-deref-while-calling-getpeername/20220802-173945
        git checkout ccc367df3fdba07b24eeda721ca928cce50f40d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/scsi/iscsi_tcp.c:798:8: error: incompatible pointer to integer conversion passing 'struct file *' to parameter of type 'unsigned int' [-Wint-conversion]
                   fget(sock->file);
                        ^~~~~~~~~~
   include/linux/file.h:48:39: note: passing argument to parameter 'fd' here
   extern struct file *fget(unsigned int fd);
                                         ^
   drivers/scsi/iscsi_tcp.c:852:8: error: incompatible pointer to integer conversion passing 'struct file *' to parameter of type 'unsigned int' [-Wint-conversion]
                   fget(sock->file);
                        ^~~~~~~~~~
   include/linux/file.h:48:39: note: passing argument to parameter 'fd' here
   extern struct file *fget(unsigned int fd);
                                         ^
   2 errors generated.


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
