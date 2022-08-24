Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA15A0355
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbiHXVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiHXVlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:41:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E0C2723
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661377308; x=1692913308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u55x3BMC6IdX0hvusvjBKoB9KItycF/ELPuKXOiG878=;
  b=gS4KbHPssnrAbUf+yMx6R3/E5BBaHFY4EqmAHmFni2d3YhWOkQ53v2ug
   MboVBj5ykoX1R5QpnlU9mqGt7MMZ4OCYDDHKEO8Y9/rS9U1GFTFer+5jU
   YwiF57oX34unEywQe12x0xSQkVf+OsoxJdeMCpQPE0MZS1c2OTeEwNYLX
   tH+vwmRCw5vY94YKtUJnAA1FaOmYIDd+EfuBOkv7kufo8u3xeQQUBRxHY
   zimaw3aOXtq0ziy5S+xyCLk5GicYKQ+tHsjI0dib+scQZrueb/kuso6M2
   DZ7bINK7p4DMo4V+helUwpDhjrCugZKHDs3YDiZA/o5HOf1sm1jJVCSHa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291651068"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="291651068"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 14:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="938069235"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2022 14:41:47 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQy8A-0001FH-2D;
        Wed, 24 Aug 2022 21:41:46 +0000
Date:   Thu, 25 Aug 2022 05:41:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [axboe-block:io_uring-6.0 14/14] io_uring/net.c:1053:36: warning:
 variable 'addr' is uninitialized when used here
Message-ID: <202208250535.oP4RWEEL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git io_uring-6.0
head:   0596fa5ef9aff29219021fa6f0117b604ff83d09
commit: 0596fa5ef9aff29219021fa6f0117b604ff83d09 [14/14] io_uring/net: save address for sendzc async execution
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220825/202208250535.oP4RWEEL-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=0596fa5ef9aff29219021fa6f0117b604ff83d09
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block io_uring-6.0
        git checkout 0596fa5ef9aff29219021fa6f0117b604ff83d09
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> io_uring/net.c:1053:36: warning: variable 'addr' is uninitialized when used here [-Wuninitialized]
                           return io_setup_async_addr(req, addr, issue_flags);
                                                           ^~~~
   io_uring/net.c:978:42: note: initialize the variable 'addr' to silence this warning
           struct sockaddr_storage __address, *addr;
                                                   ^
                                                    = NULL
   1 warning generated.


vim +/addr +1053 io_uring/net.c

   975	
   976	int io_sendzc(struct io_kiocb *req, unsigned int issue_flags)
   977	{
   978		struct sockaddr_storage __address, *addr;
   979		struct io_ring_ctx *ctx = req->ctx;
   980		struct io_sendzc *zc = io_kiocb_to_cmd(req, struct io_sendzc);
   981		struct io_notif_slot *notif_slot;
   982		struct io_kiocb *notif;
   983		struct msghdr msg;
   984		struct iovec iov;
   985		struct socket *sock;
   986		unsigned msg_flags;
   987		int ret, min_ret = 0;
   988	
   989		if (!(req->flags & REQ_F_POLLED) &&
   990		    (zc->flags & IORING_RECVSEND_POLL_FIRST))
   991			return -EAGAIN;
   992	
   993		if (issue_flags & IO_URING_F_UNLOCKED)
   994			return -EAGAIN;
   995		sock = sock_from_file(req->file);
   996		if (unlikely(!sock))
   997			return -ENOTSOCK;
   998	
   999		notif_slot = io_get_notif_slot(ctx, zc->slot_idx);
  1000		if (!notif_slot)
  1001			return -EINVAL;
  1002		notif = io_get_notif(ctx, notif_slot);
  1003		if (!notif)
  1004			return -ENOMEM;
  1005	
  1006		msg.msg_name = NULL;
  1007		msg.msg_control = NULL;
  1008		msg.msg_controllen = 0;
  1009		msg.msg_namelen = 0;
  1010	
  1011		if (zc->addr) {
  1012			if (req_has_async_data(req)) {
  1013				struct io_async_msghdr *io = req->async_data;
  1014	
  1015				msg.msg_name = &io->addr;
  1016			} else {
  1017				ret = move_addr_to_kernel(zc->addr, zc->addr_len, &__address);
  1018				if (unlikely(ret < 0))
  1019					return ret;
  1020				msg.msg_name = (struct sockaddr *)&__address;
  1021			}
  1022			msg.msg_namelen = zc->addr_len;
  1023		}
  1024	
  1025		if (zc->flags & IORING_RECVSEND_FIXED_BUF) {
  1026			ret = io_import_fixed(WRITE, &msg.msg_iter, req->imu,
  1027						(u64)(uintptr_t)zc->buf, zc->len);
  1028			if (unlikely(ret))
  1029				return ret;
  1030		} else {
  1031			ret = import_single_range(WRITE, zc->buf, zc->len, &iov,
  1032						  &msg.msg_iter);
  1033			if (unlikely(ret))
  1034				return ret;
  1035			ret = io_notif_account_mem(notif, zc->len);
  1036			if (unlikely(ret))
  1037				return ret;
  1038		}
  1039	
  1040		msg_flags = zc->msg_flags | MSG_ZEROCOPY;
  1041		if (issue_flags & IO_URING_F_NONBLOCK)
  1042			msg_flags |= MSG_DONTWAIT;
  1043		if (msg_flags & MSG_WAITALL)
  1044			min_ret = iov_iter_count(&msg.msg_iter);
  1045	
  1046		msg.msg_flags = msg_flags;
  1047		msg.msg_ubuf = &io_notif_to_data(notif)->uarg;
  1048		msg.sg_from_iter = io_sg_from_iter;
  1049		ret = sock_sendmsg(sock, &msg);
  1050	
  1051		if (unlikely(ret < min_ret)) {
  1052			if (ret == -EAGAIN && (issue_flags & IO_URING_F_NONBLOCK))
> 1053				return io_setup_async_addr(req, addr, issue_flags);
  1054	
  1055			if (ret > 0 && io_net_retry(sock, msg.msg_flags)) {
  1056				zc->len -= ret;
  1057				zc->buf += ret;
  1058				zc->done_io += ret;
  1059				req->flags |= REQ_F_PARTIAL_IO;
  1060				return io_setup_async_addr(req, addr, issue_flags);
  1061			}
  1062			if (ret == -ERESTARTSYS)
  1063				ret = -EINTR;
  1064			req_set_fail(req);
  1065		} else if (zc->flags & IORING_RECVSEND_NOTIF_FLUSH) {
  1066			io_notif_slot_flush_submit(notif_slot, 0);
  1067		}
  1068	
  1069		if (ret >= 0)
  1070			ret += zc->done_io;
  1071		else if (zc->done_io)
  1072			ret = zc->done_io;
  1073		io_req_set_res(req, ret, 0);
  1074		return IOU_OK;
  1075	}
  1076	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
