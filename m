Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CD44DA5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352364AbiCOWtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350376AbiCOWtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:49:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FE238BD5;
        Tue, 15 Mar 2022 15:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647384499; x=1678920499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P9qMja6/fAMvM2ugsrl1pMMJHX9GWLFIsNE39aB8ACc=;
  b=lYAZCEqQF/XjKWym3CuxUKQqkPAOZRnZPcNb86AfUTzCJqy6nyl51PoD
   kltMw7N4v43wVHP5JNV+q+K509r6brylvyVg5eGEgZkjWPjIwmn2pzfyM
   wsw4XrtucRbGYWY70eWpXyaKb6ivQGOq1BhZ6fjZsf+pfkjqdUo63mhoa
   2QyDnABOq+fAFRDnvWtsjXDFcKQGnopmHl90ccaVcxEAaeGbkrjuHULJI
   Hzg8nmV+gd2XatDE7uuYHtozecsRPqZkgGC9u0CNwwtEdpeBw7YZZfAOq
   tPpli5+AcPoPDJnG83KiFA8Rbcxw4jy9J52z5qezM2SrVx5ZmQutct6QM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281213578"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="281213578"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 15:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="516072862"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2022 15:48:16 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUFxf-000Bag-Nu; Tue, 15 Mar 2022 22:48:15 +0000
Date:   Wed, 16 Mar 2022 06:47:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        arnaud.pouliquen@foss.st.com
Subject: Re: [PATCH] rpmsg: virtio: set dst address on first message received
Message-ID: <202203160614.sjUMuSy8-lkp@intel.com>
References: <20220315153856.3117676-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315153856.3117676-1-arnaud.pouliquen@foss.st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

I love your patch! Perhaps something to improve:

[auto build test WARNING on remoteproc/rpmsg-next]
[also build test WARNING on v5.17-rc8 next-20220315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/rpmsg-virtio-set-dst-address-on-first-message-received/20220315-234049
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rpmsg-next
config: s390-randconfig-s031-20220313 (https://download.01.org/0day-ci/archive/20220316/202203160614.sjUMuSy8-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/ef182a34773917f6bf876b37485031962393a1cd
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Arnaud-Pouliquen/rpmsg-virtio-set-dst-address-on-first-message-received/20220315-234049
        git checkout ef182a34773917f6bf876b37485031962393a1cd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/rpmsg/virtio_rpmsg_bus.c:756:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dst @@     got restricted __rpmsg32 [usertype] src @@
   drivers/rpmsg/virtio_rpmsg_bus.c:756:36: sparse:     expected unsigned int [usertype] dst
   drivers/rpmsg/virtio_rpmsg_bus.c:756:36: sparse:     got restricted __rpmsg32 [usertype] src

vim +756 drivers/rpmsg/virtio_rpmsg_bus.c

   727	
   728		/*
   729		 * We currently use fixed-sized buffers, so trivially sanitize
   730		 * the reported payload length.
   731		 */
   732		if (len > vrp->buf_size ||
   733		    msg_len > (len - sizeof(struct rpmsg_hdr))) {
   734			dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
   735			return -EINVAL;
   736		}
   737	
   738		/* use the dst addr to fetch the callback of the appropriate user */
   739		mutex_lock(&vrp->endpoints_lock);
   740	
   741		ept = idr_find(&vrp->endpoints, __rpmsg32_to_cpu(little_endian, msg->dst));
   742	
   743		/* let's make sure no one deallocates ept while we use it */
   744		if (ept)
   745			kref_get(&ept->refcount);
   746	
   747		mutex_unlock(&vrp->endpoints_lock);
   748	
   749		if (ept) {
   750			rpdev = ept->rpdev;
   751			if (rpdev->ept == ept && rpdev->dst == RPMSG_ADDR_ANY) {
   752				/*
   753				 * First message received from the remote side on the default endpoint,
   754				 * update channel destination address.
   755				 */
 > 756				rpdev->dst = msg->src;
   757			}
   758	
   759			/* make sure ept->cb doesn't go away while we use it */
   760			mutex_lock(&ept->cb_lock);
   761	
   762			if (ept->cb)
   763				ept->cb(ept->rpdev, msg->data, msg_len, ept->priv,
   764					__rpmsg32_to_cpu(little_endian, msg->src));
   765	
   766			mutex_unlock(&ept->cb_lock);
   767	
   768			/* farewell, ept, we don't need you anymore */
   769			kref_put(&ept->refcount, __ept_release);
   770		} else
   771			dev_warn_ratelimited(dev, "msg received with no recipient\n");
   772	
   773		/* publish the real size of the buffer */
   774		rpmsg_sg_init(&sg, msg, vrp->buf_size);
   775	
   776		/* add the buffer back to the remote processor's virtqueue */
   777		err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
   778		if (err < 0) {
   779			dev_err(dev, "failed to add a virtqueue buffer: %d\n", err);
   780			return err;
   781		}
   782	
   783		return 0;
   784	}
   785	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
