Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89D3495A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378743AbiAUGhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:37:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:52154 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348774AbiAUGhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642747058; x=1674283058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PrB7+txqACOqvxAdRJEN6Ri06z0Sf+hn/heR9Ndq8fo=;
  b=dsm/XPkFuzKxhf5oocuMDuxQTJb2gHgjVKcEw032lDG0lS5v4xIAKOEv
   zawatnrYfAkAuBLqnCtDMbAD24k9Ob4nhmDC9xwng+CcQlEZmvmRLQ6y8
   exStfBflh7zl3nQe/KkxPnygLx6Jvj63iOWIh0h0e5lRc77PiQ+MaVBb+
   z3kNt5q8Nl5UIdgx35egGcHSgNnlYukIzXEjbjiLoXlsGhuM/6kQPXMgQ
   bzyMBeippg0iW+NVJ0UlNUjnOg2vpTk42+H0Iguu2IbVq2fDO/jjUB9vJ
   U5VM8esYZWXnvPtlz01XOyQfTNA8d7YbHiobt5nsG+0435QHdtIuQxrmh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="245530561"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="245530561"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 22:37:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="616400090"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2022 22:37:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAnYE-000F0y-Qp; Fri, 21 Jan 2022 06:37:34 +0000
Date:   Fri, 21 Jan 2022 14:36:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhenwei pi <pizhenwei@bytedance.com>, mst@redhat.com,
        arei.gonglei@huawei.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        helei.sig11@bytedance.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 3/3] virtio-crypto: implement RSA algorithm
Message-ID: <202201211427.TgczsUOo-lkp@intel.com>
References: <20220121022438.1042547-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121022438.1042547-4-pizhenwei@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhenwei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master linux/master linus/master v5.16 next-20220121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: hexagon-randconfig-r026-20220120 (https://download.01.org/0day-ci/archive/20220121/202201211427.TgczsUOo-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d4baf3b1322b84816aa623d8e8cb45a49cb68b84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fa1045d13dd16399ab0287c599719a977892cf05
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
        git checkout fa1045d13dd16399ab0287c599719a977892cf05
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/crypto/virtio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/crypto/virtio/virtio_crypto_akcipher_algo.c:276:5: warning: no previous prototype for function 'virtio_crypto_rsa_do_req' [-Wmissing-prototypes]
   int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
       ^
   drivers/crypto/virtio/virtio_crypto_akcipher_algo.c:276:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
   ^
   static 
   1 warning generated.


vim +/virtio_crypto_rsa_do_req +276 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c

   275	
 > 276	int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
   277	{
   278		struct akcipher_request *req = container_of(vreq, struct akcipher_request, base);
   279		struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
   280		struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
   281		struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
   282		struct virtio_crypto *vcrypto = ctx->vcrypto;
   283		struct data_queue *data_vq = vc_req->dataq;
   284		struct virtio_crypto_op_header *header;
   285		struct virtio_crypto_akcipher_data_req *akcipher_req;
   286		int ret;
   287	
   288		vc_req->sgs = NULL;
   289		vc_req->req_data = kzalloc_node(sizeof(*vc_req->req_data),
   290			GFP_KERNEL, dev_to_node(&vcrypto->vdev->dev));
   291		if (!vc_req->req_data)
   292			return -ENOMEM;
   293	
   294		/* build request header */
   295		header = &vc_req->req_data->header;
   296		header->opcode = cpu_to_le32(vc_akcipher_req->opcode);
   297		header->algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
   298		header->session_id = cpu_to_le64(ctx->session_id);
   299	
   300		/* build request akcipher data */
   301		akcipher_req = &vc_req->req_data->u.akcipher_req;
   302		akcipher_req->para.src_data_len = cpu_to_le32(req->src_len);
   303		akcipher_req->para.dst_data_len = cpu_to_le32(req->dst_len);
   304	
   305		ret = __virtio_crypto_akcipher_do_req(vc_akcipher_req, req, data_vq);
   306		if (ret < 0) {
   307			kfree_sensitive(vc_req->req_data);
   308			vc_req->req_data = NULL;
   309			return ret;
   310		}
   311	
   312		return 0;
   313	}
   314	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
