Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3258C289
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 06:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiHHE1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 00:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiHHE1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 00:27:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D72DF8C;
        Sun,  7 Aug 2022 21:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659932826; x=1691468826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=itU/psrTDiBxpg2uoXCJ31PzFcxLSRp3phhgRkOS+/4=;
  b=WfyII6hbq1dS+B/xVwIiSQVn8bSwvFambfwdknSfDSnkgs/QferMJxRu
   ylC4n03V0kwWBH6+Zp1LvnENid20bB2I5704CEkZBFRqqcmo9Yol3cSkF
   x28a7jH5JtY/ekNsRilqv3banmZTLZ8WqCTEn0CvcPwRID9DuKpnjFM/x
   U4HLCG5WtN4s/Y9DomdECJC3fOqkUdCkJDKsnJBpv9RJAzFdKedToqbqG
   5PsaWEH1j5Qz4lRCJQzvHTCg+bq5ro5+fXz5q27gXqiNaOidjCf9X+Upm
   wIynE62wXfSAQobiVYMmvU59jvRZ+uNA2jTuSv2+zLVbDcQSzmrdyRydV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="316404407"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="316404407"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 21:27:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="554761975"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Aug 2022 21:27:05 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKuM4-000Lsf-1P;
        Mon, 08 Aug 2022 04:27:04 +0000
Date:   Mon, 8 Aug 2022 12:26:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lin Ma <linma@zju.edu.cn>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Lin Ma <linma@zju.edu.cn>
Subject: Re: [PATCH v0] media: dvbdev: adopts refcnt to avoid UAF
Message-ID: <202208081225.fgMVwVrN-lkp@intel.com>
References: <20220807145952.10368-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807145952.10368-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lin-Ma/media-dvbdev-adopts-refcnt-to-avoid-UAF/20220807-230449
base:   git://linuxtv.org/media_tree.git master
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> include/media/dvbdev.h:203: warning: expecting prototype for dvb_device_get(). Prototype was for dvb_device_put() instead

vim +203 include/media/dvbdev.h

   187	
   188		void *priv;
 > 189	};
   190	
   191	/**
   192	 * dvb_device_get - Increase dvb_device reference
   193	 *
   194	 * @dvbdev:	pointer to struct dvb_device
   195	 */
   196	struct dvb_device *dvb_device_get(struct dvb_device *dvbdev);
   197	
   198	/**
   199	 * dvb_device_get - Decrease dvb_device reference
   200	 *
   201	 * @dvbdev:	pointer to struct dvb_device
   202	 */
 > 203	void dvb_device_put(struct dvb_device *dvbdev);
   204	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
