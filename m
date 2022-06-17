Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77EE54FC82
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383434AbiFQRuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiFQRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:50:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516FC49F95;
        Fri, 17 Jun 2022 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655488249; x=1687024249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5u5FYKOyuT299I3BoB0ioyZU3Fi1j7bhWjLsZJxMg3Y=;
  b=DU2+fq8rkY2laCFr+xcqzL2GATsPcM29fQ2Eliyk57FKJFZ9CvrSpkId
   /Ni6EiDZSRgdEVrN1L+aGPux39sBPOuNxulaJUC7YME93cbhkFUBi11p/
   lVYeFvJEF4Vo5n4LzkF718S5DWa2LwTZV6mzDTDQpB81zX+GuBzJxBmQx
   8wEdgoOd2X3auWdcvcHuVAxYMiOlTGd7RaRio/4UnvysiETmvMm7eDnYo
   zMa1/NIroOmVMUnmYUEKvHw1KHqeW3YjLY/qlI3Jzxj7nOQZlG7qfSFhI
   2OXWnrdPRfu2LoljI1k7rYoMFsVZX0cNBSfDzo5VIYRlKJkI4R2HTibaX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277093888"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277093888"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 10:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="912682470"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2022 10:27:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2Fl8-000PdZ-60;
        Fri, 17 Jun 2022 17:27:50 +0000
Date:   Sat, 18 Jun 2022 01:27:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lei He <helei.sig11@bytedance.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, dhowells@redhat.com, mst@redhat.com
Cc:     kbuild-all@lists.01.org, arei.gonglei@huawei.com,
        jasowang@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, pizhenwei@bytedance.com,
        helei.sig11@bytedance.com, f4bug@amsat.org, berrange@redhat.com
Subject: Re: [PATCH 4/4] virtio-crypto: support ECDSA algorithm
Message-ID: <202206180117.Jk42sS41-lkp@intel.com>
References: <20220617070754.73667-6-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617070754.73667-6-helei.sig11@bytedance.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220618/202206180117.Jk42sS41-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/intel-lab-lkp/linux/commit/d335068e54f1217848445185702d75739116b1fe
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lei-He/virtio-crypto-support-ECDSA-algorithm/20220617-151113
        git checkout d335068e54f1217848445185702d75739116b1fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ecdsa_max_signature_size" [drivers/crypto/virtio/virtio_crypto.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
