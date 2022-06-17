Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE8054F94C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382798AbiFQOkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382591AbiFQOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:40:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7F3983E;
        Fri, 17 Jun 2022 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655476847; x=1687012847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ta2YQsulj3jZHsDIUgd4bbq30vgKTah6y6arAvOavz4=;
  b=Wc4MgatVSs6c8pbM7yzqIoAkfiwf7TPv6nN4/YpQjO6+dCnhBAWU5UFJ
   koTkDZn3l43wKWx5Kukv21t/8HoStbeylItOWbliBLEpSzngmG0/x25FI
   cqQQofDk+X3JNrgct3xsUGWgUxaYKCkxo8LOvu7dFF0Ngw32SCzGcr/yX
   Zpxu9o7ORW2pbDXuMHJDK+pe1PvNb8sChRuCWnpzx7vjn6/peJ6IhIvoV
   ruq8Y/JI5wBI0ejtgqPDaRBRaaG3sQb0Fi+dGOAZmBA0ZbSbmNbS1Tay1
   jrT98P9Evrjvs14lDnTZKTUfSC7ixPjoXR5GP1m0a0OAKezjXCUdc6wTt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280570680"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280570680"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 07:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="590137364"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jun 2022 07:40:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2D9P-000PW1-O6;
        Fri, 17 Jun 2022 14:40:43 +0000
Date:   Fri, 17 Jun 2022 22:40:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lei He <helei.sig11@bytedance.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, dhowells@redhat.com, mst@redhat.com
Cc:     kbuild-all@lists.01.org, arei.gonglei@huawei.com,
        jasowang@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, pizhenwei@bytedance.com,
        helei.sig11@bytedance.com, f4bug@amsat.org, berrange@redhat.com
Subject: Re: [PATCH 4/4] virtio-crypto: support ECDSA algorithm
Message-ID: <202206172202.d2j2nFUX-lkp@intel.com>
References: <20220617070754.73667-6-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617070754.73667-6-helei.sig11@bytedance.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on herbert-crypto-2.6/master linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Lei-He/virtio-crypto-support-ECDSA-algorithm/20220617-151113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220617/202206172202.d2j2nFUX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d335068e54f1217848445185702d75739116b1fe
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lei-He/virtio-crypto-support-ECDSA-algorithm/20220617-151113
        git checkout d335068e54f1217848445185702d75739116b1fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/crypto/virtio/virtio_crypto_akcipher_algs.o: in function `virtio_crypto_ecdsa_max_size':
>> drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:602: undefined reference to `ecdsa_max_signature_size'


vim +602 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c

   596	
   597	static unsigned int virtio_crypto_ecdsa_max_size(struct crypto_akcipher *tfm)
   598	{
   599		struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
   600		struct virtio_crypto_ecdsa_ctx *ecdsa_ctx = &ctx->ecdsa_ctx;
   601	
 > 602		return ecdsa_max_signature_size(ecdsa_ctx->curve);
   603	}
   604	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
