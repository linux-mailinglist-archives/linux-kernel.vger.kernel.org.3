Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F304D6F41
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiCLNmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCLNmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:42:42 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE6520D52F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jIWLe4id2pphmT2MeKt/vBQuoe1+YXhwtnePeFkSgto=;
  b=uwNwmXR/S8PUl4t8MsevhHxKNVH8FDrwTttZwJpScqFZt09yNv4fFCA8
   X/8LaeHAFT39+Vmv8lx3ESd8iP4JidGIG+mGvvR1FCrmae4vUnJzRsyEa
   zS5ApXP9RxELnTzND6UjIIlNGTxLeAKQaGJcLxceLsyF8Ioa7YYVvxagv
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,175,1643670000"; 
   d="scan'208";a="8361977"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 14:41:35 +0100
Date:   Sat, 12 Mar 2022 14:41:34 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Jens Axboe <axboe@kernel.dk>
cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [axboe-block:for-5.18/io_uring 19/25] fs/io_uring.c:4338:42-56:
 duplicated argument to && or || (fwd)
Message-ID: <alpine.DEB.2.22.394.2203121440550.18925@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sqe->buf_index appears twice.

---------- Forwarded message ----------
Date: Sat, 12 Mar 2022 03:22:42 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: [axboe-block:for-5.18/io_uring 19/25] fs/io_uring.c:4338:42-56:
    duplicated argument to && or ||

CC: kbuild-all@lists.01.org
BCC: lkp@intel.com
CC: linux-kernel@vger.kernel.org
TO: Jens Axboe <axboe@kernel.dk>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.18/io_uring
head:   bcbb7bf6ccde7cb969a5642879832bc84ebf06a3
commit: 4f57f06ce2186c31c3da52386125dc57b1cd6f96 [19/25] io_uring: add support for IORING_OP_MSG_RING command
:::::: branch date: 23 hours ago
:::::: commit date: 27 hours ago
config: csky-randconfig-c004-20220310 (https://download.01.org/0day-ci/archive/20220312/202203120306.eNEnYxKX-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>


cocci warnings: (new ones prefixed by >>)
>> fs/io_uring.c:4338:42-56: duplicated argument to && or ||

vim +4338 fs/io_uring.c

2b188cc1bb857a Jens Axboe 2019-01-07  4334
4f57f06ce2186c Jens Axboe 2022-03-10  4335  static int io_msg_ring_prep(struct io_kiocb *req,
4f57f06ce2186c Jens Axboe 2022-03-10  4336  			    const struct io_uring_sqe *sqe)
4f57f06ce2186c Jens Axboe 2022-03-10  4337  {
4f57f06ce2186c Jens Axboe 2022-03-10 @4338  	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index ||
4f57f06ce2186c Jens Axboe 2022-03-10  4339  		     sqe->rw_flags || sqe->splice_fd_in || sqe->buf_index ||
4f57f06ce2186c Jens Axboe 2022-03-10  4340  		     sqe->personality))
4f57f06ce2186c Jens Axboe 2022-03-10  4341  		return -EINVAL;
4f57f06ce2186c Jens Axboe 2022-03-10  4342
4f57f06ce2186c Jens Axboe 2022-03-10  4343  	if (req->file->f_op != &io_uring_fops)
4f57f06ce2186c Jens Axboe 2022-03-10  4344  		return -EBADFD;
4f57f06ce2186c Jens Axboe 2022-03-10  4345
4f57f06ce2186c Jens Axboe 2022-03-10  4346  	req->msg.user_data = READ_ONCE(sqe->off);
4f57f06ce2186c Jens Axboe 2022-03-10  4347  	req->msg.len = READ_ONCE(sqe->len);
4f57f06ce2186c Jens Axboe 2022-03-10  4348  	return 0;
4f57f06ce2186c Jens Axboe 2022-03-10  4349  }
4f57f06ce2186c Jens Axboe 2022-03-10  4350

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
