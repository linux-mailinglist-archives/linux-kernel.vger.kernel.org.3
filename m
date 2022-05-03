Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5812517C0B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiECCvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiECCvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:51:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE637004
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 19:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651546096; x=1683082096;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PdH/bv51sKJFuqLzLM89Tf/dTK5EdMqj/axJzy0jC/E=;
  b=ZAHHh8npaM5FmsJkZrWQk4bKZg0kn5utmPvUvNSujv5Hp6biHmlzaL+A
   xG+1KMHpqoJzdIvoAlBNjRZjdqb1tZfZssBPnF68LUdk2XvjW5a+WYZIb
   KuZG9M/dbGaa4eehBbGeTnrvXOgf/191mOL2i610B1dMaoZhWqzWgjmc5
   351ksSik/mFi1oI6tlFAEAAsKReheEf7jWb+yQyenDaeXm8olFfhQ0j5L
   OQJ2z0xxJHwrs//9xE7VG51z8Q+g8ZIxFyiGi7YwtSWzyhxUVfYR9TBpV
   DXlAHqlJHUSoL2pkyTaiHtf+J2dUCmxNIAjw9pbfBZ+D3yE2+DelfH8FB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="330376028"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="330376028"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 19:48:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="516396048"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2022 19:48:14 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nliaD-000A5f-T7;
        Tue, 03 May 2022 02:48:13 +0000
Date:   Tue, 3 May 2022 10:47:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Steve French <stfrench@microsoft.com>
Subject: [samba-ksmbd:for-next 17/26] fs/cifs/smb2ops.c:4961:7: warning:
 variable 'length' is used uninitialized whenever 'if' condition is false
Message-ID: <202205031012.L7O6Uj9A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.samba.org/ksmbd.git for-next
head:   422ce10d22e2de32427ff611478747dd27af50f8
commit: fb82dff413832d7afbef54d40c2bd6828a0699a5 [17/26] cifs: Change the I/O paths to use an iterator rather than a page list
config: x86_64-randconfig-a011-20220502 (https://download.01.org/0day-ci/archive/20220503/202205031012.L7O6Uj9A-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add samba-ksmbd git://git.samba.org/ksmbd.git
        git fetch --no-tags samba-ksmbd for-next
        git checkout fb82dff413832d7afbef54d40c2bd6828a0699a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/cifs/smb2ops.c:4961:7: warning: variable 'length' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (rdata->result != 0) {
                       ^~~~~~~~~~~~~~~~~~
   fs/cifs/smb2ops.c:4993:9: note: uninitialized use occurs here
           return length;
                  ^~~~~~
   fs/cifs/smb2ops.c:4961:3: note: remove the 'if' if its condition is always true
                   if (rdata->result != 0) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/cifs/smb2ops.c:4860:12: note: initialize the variable 'length' to silence this warning
           int length;
                     ^
                      = 0
   1 warning generated.


vim +4961 fs/cifs/smb2ops.c

c42a6abe3012832 Pavel Shilovsky    2016-11-17  4847  
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4848  static int
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4849  handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
fb82dff413832d7 David Howells      2022-01-24  4850  		 char *buf, unsigned int buf_len, struct xarray *pages,
fb82dff413832d7 David Howells      2022-01-24  4851  		 unsigned int pages_len, bool is_offloaded)
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4852  {
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4853  	unsigned int data_offset;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4854  	unsigned int data_len;
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4855  	unsigned int cur_off;
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4856  	unsigned int cur_page_idx;
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4857  	unsigned int pad_len;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4858  	struct cifs_readdata *rdata = mid->callback_data;
0d35e382e4e96a4 Ronnie Sahlberg    2021-11-05  4859  	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4860  	int length;
74dcf418fe34465 Long Li            2017-11-22  4861  	bool use_rdma_mr = false;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4862  
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4863  	if (shdr->Command != SMB2_READ) {
3175eb9b577e82b Ronnie Sahlberg    2019-09-04  4864  		cifs_server_dbg(VFS, "only big read responses are supported\n");
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4865  		return -ENOTSUPP;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4866  	}
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4867  
511c54a2f69195b Pavel Shilovsky    2017-07-08  4868  	if (server->ops->is_session_expired &&
511c54a2f69195b Pavel Shilovsky    2017-07-08  4869  	    server->ops->is_session_expired(buf)) {
de9ac0a6e9efdff Rohith Surabattula 2020-10-28  4870  		if (!is_offloaded)
183eea2ee5ba968 Shyam Prasad N     2021-07-19  4871  			cifs_reconnect(server, true);
511c54a2f69195b Pavel Shilovsky    2017-07-08  4872  		return -1;
511c54a2f69195b Pavel Shilovsky    2017-07-08  4873  	}
511c54a2f69195b Pavel Shilovsky    2017-07-08  4874  
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4875  	if (server->ops->is_status_pending &&
66265f134acfb20 Pavel Shilovsky    2019-01-23  4876  			server->ops->is_status_pending(buf, server))
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4877  		return -1;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4878  
ec678eae746dd25 Pavel Shilovsky    2019-01-18  4879  	/* set up first two iov to get credits */
ec678eae746dd25 Pavel Shilovsky    2019-01-18  4880  	rdata->iov[0].iov_base = buf;
bb1bccb60c2ebd9 Pavel Shilovsky    2019-01-17  4881  	rdata->iov[0].iov_len = 0;
bb1bccb60c2ebd9 Pavel Shilovsky    2019-01-17  4882  	rdata->iov[1].iov_base = buf;
ec678eae746dd25 Pavel Shilovsky    2019-01-18  4883  	rdata->iov[1].iov_len =
bb1bccb60c2ebd9 Pavel Shilovsky    2019-01-17  4884  		min_t(unsigned int, buf_len, server->vals->read_rsp_size);
ec678eae746dd25 Pavel Shilovsky    2019-01-18  4885  	cifs_dbg(FYI, "0: iov_base=%p iov_len=%zu\n",
ec678eae746dd25 Pavel Shilovsky    2019-01-18  4886  		 rdata->iov[0].iov_base, rdata->iov[0].iov_len);
ec678eae746dd25 Pavel Shilovsky    2019-01-18  4887  	cifs_dbg(FYI, "1: iov_base=%p iov_len=%zu\n",
ec678eae746dd25 Pavel Shilovsky    2019-01-18  4888  		 rdata->iov[1].iov_base, rdata->iov[1].iov_len);
ec678eae746dd25 Pavel Shilovsky    2019-01-18  4889  
ec678eae746dd25 Pavel Shilovsky    2019-01-18  4890  	rdata->result = server->ops->map_error(buf, true);
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4891  	if (rdata->result != 0) {
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4892  		cifs_dbg(FYI, "%s: server returned error %d\n",
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4893  			 __func__, rdata->result);
ec678eae746dd25 Pavel Shilovsky    2019-01-18  4894  		/* normal error on read response */
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4895  		if (is_offloaded)
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4896  			mid->mid_state = MID_RESPONSE_RECEIVED;
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4897  		else
ec678eae746dd25 Pavel Shilovsky    2019-01-18  4898  			dequeue_mid(mid, false);
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4899  		return 0;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4900  	}
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4901  
1fc6ad2f10ad6f5 Ronnie Sahlberg    2018-06-01  4902  	data_offset = server->ops->read_data_offset(buf);
74dcf418fe34465 Long Li            2017-11-22  4903  #ifdef CONFIG_CIFS_SMB_DIRECT
74dcf418fe34465 Long Li            2017-11-22  4904  	use_rdma_mr = rdata->mr;
74dcf418fe34465 Long Li            2017-11-22  4905  #endif
74dcf418fe34465 Long Li            2017-11-22  4906  	data_len = server->ops->read_data_length(buf, use_rdma_mr);
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4907  
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4908  	if (data_offset < server->vals->read_rsp_size) {
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4909  		/*
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4910  		 * win2k8 sometimes sends an offset of 0 when the read
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4911  		 * is beyond the EOF. Treat it as if the data starts just after
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4912  		 * the header.
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4913  		 */
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4914  		cifs_dbg(FYI, "%s: data offset (%u) inside read response header\n",
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4915  			 __func__, data_offset);
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4916  		data_offset = server->vals->read_rsp_size;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4917  	} else if (data_offset > MAX_CIFS_SMALL_BUFFER_SIZE) {
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4918  		/* data_offset is beyond the end of smallbuf */
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4919  		cifs_dbg(FYI, "%s: data offset (%u) beyond end of smallbuf\n",
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4920  			 __func__, data_offset);
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4921  		rdata->result = -EIO;
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4922  		if (is_offloaded)
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4923  			mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4924  		else
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4925  			dequeue_mid(mid, rdata->result);
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4926  		return 0;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4927  	}
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4928  
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4929  	pad_len = data_offset - server->vals->read_rsp_size;
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4930  
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4931  	if (buf_len <= data_offset) {
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4932  		/* read response payload is in pages */
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4933  		cur_page_idx = pad_len / PAGE_SIZE;
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4934  		cur_off = pad_len % PAGE_SIZE;
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4935  
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4936  		if (cur_page_idx != 0) {
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4937  			/* data offset is beyond the 1st page of response */
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4938  			cifs_dbg(FYI, "%s: data offset (%u) beyond 1st page of response\n",
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4939  				 __func__, data_offset);
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4940  			rdata->result = -EIO;
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4941  			if (is_offloaded)
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4942  				mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4943  			else
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4944  				dequeue_mid(mid, rdata->result);
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4945  			return 0;
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4946  		}
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4947  
fb82dff413832d7 David Howells      2022-01-24  4948  		if (data_len > pages_len - pad_len) {
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4949  			/* data_len is corrupt -- discard frame */
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4950  			rdata->result = -EIO;
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4951  			if (is_offloaded)
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4952  				mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4953  			else
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4954  				dequeue_mid(mid, rdata->result);
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4955  			return 0;
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4956  		}
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4957  
fb82dff413832d7 David Howells      2022-01-24  4958  		/* Copy the data to the output I/O iterator. */
fb82dff413832d7 David Howells      2022-01-24  4959  		rdata->result = cifs_copy_pages_to_iter(pages, pages_len,
fb82dff413832d7 David Howells      2022-01-24  4960  							cur_off, &rdata->iter);
c42a6abe3012832 Pavel Shilovsky    2016-11-17 @4961  		if (rdata->result != 0) {
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4962  			if (is_offloaded)
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4963  				mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4964  			else
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4965  				dequeue_mid(mid, rdata->result);
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4966  			return 0;
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4967  		}
fb82dff413832d7 David Howells      2022-01-24  4968  		rdata->got_bytes = pages_len;
c42a6abe3012832 Pavel Shilovsky    2016-11-17  4969  
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4970  	} else if (buf_len >= data_offset + data_len) {
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4971  		/* read response payload is in buf */
fb82dff413832d7 David Howells      2022-01-24  4972  		WARN_ONCE(pages && !xa_empty(pages),
fb82dff413832d7 David Howells      2022-01-24  4973  			  "read data can be either in buf or in pages");
fb82dff413832d7 David Howells      2022-01-24  4974  		length = copy_to_iter(buf + data_offset, data_len, &rdata->iter);
fb82dff413832d7 David Howells      2022-01-24  4975  		if (length < 0)
fb82dff413832d7 David Howells      2022-01-24  4976  			return length;
fb82dff413832d7 David Howells      2022-01-24  4977                 rdata->got_bytes = data_len;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4978  	} else {
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4979  		/* read response payload cannot be in both buf and pages */
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4980  		WARN_ONCE(1, "buf can not contain only a part of read data");
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4981  		rdata->result = -EIO;
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4982  		if (is_offloaded)
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4983  			mid->mid_state = MID_RESPONSE_MALFORMED;
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4984  		else
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4985  			dequeue_mid(mid, rdata->result);
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4986  		return 0;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4987  	}
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4988  
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4989  	if (is_offloaded)
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4990  		mid->mid_state = MID_RESPONSE_RECEIVED;
ac873aa3dc21707 Rohith Surabattula 2020-10-29  4991  	else
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4992  		dequeue_mid(mid, false);
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4993  	return length;
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4994  }
4326ed2f6a16ae9 Pavel Shilovsky    2016-11-17  4995  

:::::: The code at line 4961 was first introduced by commit
:::::: c42a6abe3012832a68a371dabe17c2ced97e62ad CIFS: Add capability to decrypt big read responses

:::::: TO: Pavel Shilovsky <pshilov@microsoft.com>
:::::: CC: Steve French <smfrench@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
