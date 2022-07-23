Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA46357F13B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 21:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiGWT6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 15:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 15:57:50 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDF315A27
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PwVH6vt15LeATQ38DNL3tNTLJeOyYpoLWnS4bRbeGts=;
  b=OtE8DUoTHO4xgxAPWNvpcPNMR4EBVL/BuskmX7G7tNtDbrpx/inXoewk
   jafGANyMyRXNgDDr4x8BWbw8LDWvaT0Nb/eOvXs4kuHJV5nEepABL84w5
   fr57XaW6KIwIayD0PiFNIp5VZ1wi2kAH0JxwlSm9G7vrtXKAJQLqaIa68
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.93,189,1654552800"; 
   d="scan'208";a="46678311"
Received: from ip-153.net-89-2-7.rev.numericable.fr (HELO hadrien) ([89.2.7.153])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 21:57:46 +0200
Date:   Sat, 23 Jul 2022 21:57:46 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Dave Jiang <dave.jiang@intel.com>
cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: [djiang:cxl-security 14/16] drivers/cxl/security.c:174:59-60: disable:
 first occurrence line 177, second occurrence line 181 (fwd)
Message-ID: <alpine.DEB.2.22.394.2207232156500.2855@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Double initialization of disable, with different values.  See lies 177 and
181.

julia

---------- Forwarded message ----------
Date: Sat, 23 Jul 2022 13:06:56 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: [djiang:cxl-security 14/16] drivers/cxl/security.c:174:59-60: disable:
    first occurrence line 177, second occurrence line 181

CC: kbuild-all@lists.01.org
BCC: lkp@intel.com
CC: linux-kernel@vger.kernel.org
TO: Dave Jiang <dave.jiang@intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git cxl-security
head:   a9e386b59eef5db739f0706d734daa39759dab96
commit: dd8bf96f3460deaf322b580b58df9f59d33ea99f [14/16] nvdimm/cxl/pmem: Add support for master passphrase disable security command
:::::: branch date: 29 hours ago
:::::: commit date: 34 hours ago
config: ia64-randconfig-c031-20220721 (https://download.01.org/0day-ci/archive/20220723/202207231241.SmvofeIK-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

cocci warnings: (new ones prefixed by >>)
>> drivers/cxl/security.c:174:59-60: disable: first occurrence line 177, second occurrence line 181

vim +174 drivers/cxl/security.c

6d0464a727cb70c Dave Jiang 2022-07-12  173
fcbefd0f597c3ba Dave Jiang 2022-07-06 @174  static const struct nvdimm_security_ops __cxl_security_ops = {
fcbefd0f597c3ba Dave Jiang 2022-07-06  175  	.get_flags = cxl_pmem_get_security_flags,
5dce760e11e79cb Dave Jiang 2022-07-11  176  	.change_key = cxl_pmem_security_change_key,
6a299141fd67c72 Dave Jiang 2022-07-12 @177  	.disable = cxl_pmem_security_disable,
4aac0070d1a6c80 Dave Jiang 2022-07-12  178  	.freeze = cxl_pmem_security_freeze,
abef64ac4e6fcd4 Dave Jiang 2022-07-12  179  	.unlock = cxl_pmem_security_unlock,
6d0464a727cb70c Dave Jiang 2022-07-12  180  	.erase = cxl_pmem_security_passphrase_erase,
dd8bf96f3460dea Dave Jiang 2022-07-13 @181  	.disable = cxl_pmem_security_disable_master,
fcbefd0f597c3ba Dave Jiang 2022-07-06  182  };
fcbefd0f597c3ba Dave Jiang 2022-07-06  183

:::::: The code at line 174 was first introduced by commit
:::::: fcbefd0f597c3baeb916aca4f94bcbfca3571763 cxl/pmem: Introduce nvdimm_security_ops with ->get_flags() operation

:::::: TO: Dave Jiang <dave.jiang@intel.com>
:::::: CC: Dave Jiang <dave.jiang@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
