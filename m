Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E3956B015
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiGHBfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbiGHBfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:35:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7E72EEE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 18:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657244118; x=1688780118;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tm/IK85Oh0pUEKR3BZoHT9X0SlIpsexuYWj1KxUMO7I=;
  b=kBkFM7SjV3t9vY2a2GbreaMh7KAM/17k1FCe2pMzUvvAHM/rMPX0QyBS
   e58S1SmNYaQikE6xDx7CfMfgIcHKbb4ruW7C9aAohrZUmFh7s9KMRCfoV
   lw9xiHNihU0pymth2pF/BprHOljZycDSEpAjKcVju/nHmFVdvxOE1+G6h
   ojBxkbMOYuFMaHDLICfWBzII/XzEfsTBvIF7bpbojUOQEkllLrmti4My2
   K3Avx1BJLBk0CVeEbmn8d9K/FeHC1p9AlIJBw5lqzPeITMg09Sxmj8+/V
   1cl1FQtZIMuGAHQ/7FdZwPshoE+k+qXLxETgLtZoh9liv8TgWZRfVlRkt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="281711990"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="281711990"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 18:35:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="661601894"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2022 18:35:16 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9ctn-000Mis-SK;
        Fri, 08 Jul 2022 01:35:15 +0000
Date:   Fri, 8 Jul 2022 09:34:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-for-viro 5/8]
 fs/cifs/smb2ops.c:4994:7: warning: variable 'length' is used uninitialized
 whenever 'if' condition is false
Message-ID: <202207080923.s0L0sZLm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/cifs-for-viro
head:   569e0acf4192ada33675e44b24701e679d87ebc9
commit: f398cb911105297654980b5973ff230323061fce [5/8] cifs: Change the I/O paths to use an iterator rather than a page list
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220708/202207080923.s0L0sZLm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 562c3467a6738aa89203f72fc1d1343e5baadf3c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f398cb911105297654980b5973ff230323061fce
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-for-viro
        git checkout f398cb911105297654980b5973ff230323061fce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/cifs/smb2ops.c:4994:7: warning: variable 'length' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (rdata->result != 0) {
                       ^~~~~~~~~~~~~~~~~~
   fs/cifs/smb2ops.c:5026:9: note: uninitialized use occurs here
           return length;
                  ^~~~~~
   fs/cifs/smb2ops.c:4994:3: note: remove the 'if' if its condition is always true
                   if (rdata->result != 0) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/cifs/smb2ops.c:4893:12: note: initialize the variable 'length' to silence this warning
           int length;
                     ^
                      = 0
   1 warning generated.


vim +4994 fs/cifs/smb2ops.c

c42a6abe301283 Pavel Shilovsky    2016-11-17  4880  
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4881  static int
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4882  handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
f398cb91110529 David Howells      2022-01-24  4883  		 char *buf, unsigned int buf_len, struct xarray *pages,
f398cb91110529 David Howells      2022-01-24  4884  		 unsigned int pages_len, bool is_offloaded)
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4885  {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4886  	unsigned int data_offset;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4887  	unsigned int data_len;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4888  	unsigned int cur_off;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4889  	unsigned int cur_page_idx;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4890  	unsigned int pad_len;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4891  	struct cifs_readdata *rdata = mid->callback_data;
0d35e382e4e96a Ronnie Sahlberg    2021-11-05  4892  	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4893  	int length;
74dcf418fe3446 Long Li            2017-11-22  4894  	bool use_rdma_mr = false;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4895  
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4896  	if (shdr->Command != SMB2_READ) {
3175eb9b577e82 Ronnie Sahlberg    2019-09-04  4897  		cifs_server_dbg(VFS, "only big read responses are supported\n");
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4898  		return -ENOTSUPP;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4899  	}
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4900  
511c54a2f69195 Pavel Shilovsky    2017-07-08  4901  	if (server->ops->is_session_expired &&
511c54a2f69195 Pavel Shilovsky    2017-07-08  4902  	    server->ops->is_session_expired(buf)) {
de9ac0a6e9efdf Rohith Surabattula 2020-10-28  4903  		if (!is_offloaded)
183eea2ee5ba96 Shyam Prasad N     2021-07-19  4904  			cifs_reconnect(server, true);
511c54a2f69195 Pavel Shilovsky    2017-07-08  4905  		return -1;
511c54a2f69195 Pavel Shilovsky    2017-07-08  4906  	}
511c54a2f69195 Pavel Shilovsky    2017-07-08  4907  
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4908  	if (server->ops->is_status_pending &&
66265f134acfb2 Pavel Shilovsky    2019-01-23  4909  			server->ops->is_status_pending(buf, server))
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4910  		return -1;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4911  
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4912  	/* set up first two iov to get credits */
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4913  	rdata->iov[0].iov_base = buf;
bb1bccb60c2ebd Pavel Shilovsky    2019-01-17  4914  	rdata->iov[0].iov_len = 0;
bb1bccb60c2ebd Pavel Shilovsky    2019-01-17  4915  	rdata->iov[1].iov_base = buf;
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4916  	rdata->iov[1].iov_len =
bb1bccb60c2ebd Pavel Shilovsky    2019-01-17  4917  		min_t(unsigned int, buf_len, server->vals->read_rsp_size);
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4918  	cifs_dbg(FYI, "0: iov_base=%p iov_len=%zu\n",
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4919  		 rdata->iov[0].iov_base, rdata->iov[0].iov_len);
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4920  	cifs_dbg(FYI, "1: iov_base=%p iov_len=%zu\n",
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4921  		 rdata->iov[1].iov_base, rdata->iov[1].iov_len);
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4922  
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4923  	rdata->result = server->ops->map_error(buf, true);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4924  	if (rdata->result != 0) {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4925  		cifs_dbg(FYI, "%s: server returned error %d\n",
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4926  			 __func__, rdata->result);
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4927  		/* normal error on read response */
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4928  		if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4929  			mid->mid_state = MID_RESPONSE_RECEIVED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4930  		else
ec678eae746dd2 Pavel Shilovsky    2019-01-18  4931  			dequeue_mid(mid, false);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4932  		return 0;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4933  	}
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4934  
1fc6ad2f10ad6f Ronnie Sahlberg    2018-06-01  4935  	data_offset = server->ops->read_data_offset(buf);
74dcf418fe3446 Long Li            2017-11-22  4936  #ifdef CONFIG_CIFS_SMB_DIRECT
74dcf418fe3446 Long Li            2017-11-22  4937  	use_rdma_mr = rdata->mr;
74dcf418fe3446 Long Li            2017-11-22  4938  #endif
74dcf418fe3446 Long Li            2017-11-22  4939  	data_len = server->ops->read_data_length(buf, use_rdma_mr);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4940  
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4941  	if (data_offset < server->vals->read_rsp_size) {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4942  		/*
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4943  		 * win2k8 sometimes sends an offset of 0 when the read
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4944  		 * is beyond the EOF. Treat it as if the data starts just after
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4945  		 * the header.
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4946  		 */
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4947  		cifs_dbg(FYI, "%s: data offset (%u) inside read response header\n",
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4948  			 __func__, data_offset);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4949  		data_offset = server->vals->read_rsp_size;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4950  	} else if (data_offset > MAX_CIFS_SMALL_BUFFER_SIZE) {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4951  		/* data_offset is beyond the end of smallbuf */
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4952  		cifs_dbg(FYI, "%s: data offset (%u) beyond end of smallbuf\n",
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4953  			 __func__, data_offset);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4954  		rdata->result = -EIO;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4955  		if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4956  			mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4957  		else
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4958  			dequeue_mid(mid, rdata->result);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4959  		return 0;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4960  	}
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4961  
c42a6abe301283 Pavel Shilovsky    2016-11-17  4962  	pad_len = data_offset - server->vals->read_rsp_size;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4963  
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4964  	if (buf_len <= data_offset) {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  4965  		/* read response payload is in pages */
c42a6abe301283 Pavel Shilovsky    2016-11-17  4966  		cur_page_idx = pad_len / PAGE_SIZE;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4967  		cur_off = pad_len % PAGE_SIZE;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4968  
c42a6abe301283 Pavel Shilovsky    2016-11-17  4969  		if (cur_page_idx != 0) {
c42a6abe301283 Pavel Shilovsky    2016-11-17  4970  			/* data offset is beyond the 1st page of response */
c42a6abe301283 Pavel Shilovsky    2016-11-17  4971  			cifs_dbg(FYI, "%s: data offset (%u) beyond 1st page of response\n",
c42a6abe301283 Pavel Shilovsky    2016-11-17  4972  				 __func__, data_offset);
c42a6abe301283 Pavel Shilovsky    2016-11-17  4973  			rdata->result = -EIO;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4974  			if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4975  				mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4976  			else
c42a6abe301283 Pavel Shilovsky    2016-11-17  4977  				dequeue_mid(mid, rdata->result);
c42a6abe301283 Pavel Shilovsky    2016-11-17  4978  			return 0;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4979  		}
c42a6abe301283 Pavel Shilovsky    2016-11-17  4980  
f398cb91110529 David Howells      2022-01-24  4981  		if (data_len > pages_len - pad_len) {
c42a6abe301283 Pavel Shilovsky    2016-11-17  4982  			/* data_len is corrupt -- discard frame */
c42a6abe301283 Pavel Shilovsky    2016-11-17  4983  			rdata->result = -EIO;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4984  			if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4985  				mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4986  			else
c42a6abe301283 Pavel Shilovsky    2016-11-17  4987  				dequeue_mid(mid, rdata->result);
c42a6abe301283 Pavel Shilovsky    2016-11-17  4988  			return 0;
c42a6abe301283 Pavel Shilovsky    2016-11-17  4989  		}
c42a6abe301283 Pavel Shilovsky    2016-11-17  4990  
f398cb91110529 David Howells      2022-01-24  4991  		/* Copy the data to the output I/O iterator. */
f398cb91110529 David Howells      2022-01-24  4992  		rdata->result = cifs_copy_pages_to_iter(pages, pages_len,
f398cb91110529 David Howells      2022-01-24  4993  							cur_off, &rdata->iter);
c42a6abe301283 Pavel Shilovsky    2016-11-17 @4994  		if (rdata->result != 0) {
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4995  			if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4996  				mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  4997  			else
c42a6abe301283 Pavel Shilovsky    2016-11-17  4998  				dequeue_mid(mid, rdata->result);
c42a6abe301283 Pavel Shilovsky    2016-11-17  4999  			return 0;
c42a6abe301283 Pavel Shilovsky    2016-11-17  5000  		}
f398cb91110529 David Howells      2022-01-24  5001  		rdata->got_bytes = pages_len;
c42a6abe301283 Pavel Shilovsky    2016-11-17  5002  
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5003  	} else if (buf_len >= data_offset + data_len) {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5004  		/* read response payload is in buf */
f398cb91110529 David Howells      2022-01-24  5005  		WARN_ONCE(pages && !xa_empty(pages),
f398cb91110529 David Howells      2022-01-24  5006  			  "read data can be either in buf or in pages");
f398cb91110529 David Howells      2022-01-24  5007  		length = copy_to_iter(buf + data_offset, data_len, &rdata->iter);
f398cb91110529 David Howells      2022-01-24  5008  		if (length < 0)
f398cb91110529 David Howells      2022-01-24  5009  			return length;
f398cb91110529 David Howells      2022-01-24  5010  		rdata->got_bytes = data_len;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5011  	} else {
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5012  		/* read response payload cannot be in both buf and pages */
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5013  		WARN_ONCE(1, "buf can not contain only a part of read data");
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5014  		rdata->result = -EIO;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  5015  		if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  5016  			mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  5017  		else
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5018  			dequeue_mid(mid, rdata->result);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5019  		return 0;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5020  	}
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5021  
ac873aa3dc2170 Rohith Surabattula 2020-10-29  5022  	if (is_offloaded)
ac873aa3dc2170 Rohith Surabattula 2020-10-29  5023  		mid->mid_state = MID_RESPONSE_RECEIVED;
ac873aa3dc2170 Rohith Surabattula 2020-10-29  5024  	else
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5025  		dequeue_mid(mid, false);
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5026  	return length;
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5027  }
4326ed2f6a16ae Pavel Shilovsky    2016-11-17  5028  

:::::: The code at line 4994 was first introduced by commit
:::::: c42a6abe3012832a68a371dabe17c2ced97e62ad CIFS: Add capability to decrypt big read responses

:::::: TO: Pavel Shilovsky <pshilov@microsoft.com>
:::::: CC: Steve French <smfrench@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
