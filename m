Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD36E55DDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiF0SQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 14:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiF0SQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:16:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019EDDF65
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656353807; x=1687889807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0AYAzsEWyo4yFxZTHzMfXilEELFUvEgMUnws3EOqCig=;
  b=MVUdB9Vc1SD0/cab3n+ULZyVrOMTPUMGpTXzmpr528erXZ0/tn26gF7k
   eKwYSWqPRalX8aRde0xlVRT76viRKw0gWJIGYF9LReDb+tqDRIN59zovQ
   dqVJGdcuRuluyWn0bckK5evN5dFNft0XViZQ4RZRrPH11lsg4EdfyOdrN
   pxzotc2ZY7VGrD7aa+R8c2/M8Ta3kam9QD0/nUkJAyrJ02aZRfHnCkrBD
   AF559CmQqs09dA684+JdhlwcY2MwNQD2xL2+eRHrArK63igikwgx1KmsZ
   xRZ4fXSDx0Elreid/wSiuY4/plDtKCali4yPl2Qc5riEl7E1PxBK9xMxL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="307003856"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="307003856"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 11:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="657795102"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2022 11:16:43 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5tHu-0008qx-Ss;
        Mon, 27 Jun 2022 18:16:42 +0000
Date:   Tue, 28 Jun 2022 02:16:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [isilence:zc_v3 24/28] io_uring/net.c:862:41: warning: cast from
 pointer to integer of different size
Message-ID: <202206280255.6yEuIf06-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/isilence/linux zc_v3
head:   cd0bc816ae8dbc546df5c09cee92459ad759c4d1
commit: d9672980cdc25db17837152a58f2fea95c2c8e99 [24/28] io_uring: sendzc with fixed buffers
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220628/202206280255.6yEuIf06-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/isilence/linux/commit/d9672980cdc25db17837152a58f2fea95c2c8e99
        git remote add isilence https://github.com/isilence/linux
        git fetch --no-tags isilence zc_v3
        git checkout d9672980cdc25db17837152a58f2fea95c2c8e99
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   io_uring/net.c: In function 'io_sendzc':
>> io_uring/net.c:862:41: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     862 |                                         (u64)zc->buf, zc->len);
         |                                         ^


vim +862 io_uring/net.c

   827	
   828	int io_sendzc(struct io_kiocb *req, unsigned int issue_flags)
   829	{
   830		struct sockaddr_storage address;
   831		struct io_ring_ctx *ctx = req->ctx;
   832		struct io_sendzc *zc = io_kiocb_to_cmd(req);
   833		struct io_notif_slot *notif_slot;
   834		struct io_notif *notif;
   835		struct msghdr msg;
   836		struct iovec iov;
   837		struct socket *sock;
   838		unsigned msg_flags;
   839		int ret, min_ret = 0;
   840	
   841		if (issue_flags & IO_URING_F_UNLOCKED)
   842			return -EAGAIN;
   843		sock = sock_from_file(req->file);
   844		if (unlikely(!sock))
   845			return -ENOTSOCK;
   846	
   847		notif_slot = io_get_notif_slot(ctx, zc->slot_idx);
   848		if (!notif_slot)
   849			return -EINVAL;
   850		notif = io_get_notif(ctx, notif_slot);
   851		if (!notif)
   852			return -ENOMEM;
   853	
   854		msg.msg_name = NULL;
   855		msg.msg_control = NULL;
   856		msg.msg_controllen = 0;
   857		msg.msg_namelen = 0;
   858		msg.msg_managed_data = 1;
   859	
   860		if (zc->zc_flags & IORING_SENDZC_FIXED_BUF) {
   861			ret = io_import_fixed(WRITE, &msg.msg_iter, req->imu,
 > 862						(u64)zc->buf, zc->len);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
