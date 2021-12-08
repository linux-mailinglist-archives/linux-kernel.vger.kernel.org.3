Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8C446D4D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhLHNyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:54:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:9516 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232916AbhLHNyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:54:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="225089517"
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="225089517"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 05:50:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="564104799"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2021 05:50:45 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muxLI-0000cC-JB; Wed, 08 Dec 2021 13:50:44 +0000
Date:   Wed, 8 Dec 2021 21:50:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, rjliao@codeaurora.org,
        hbandi@codeaurora.org
Subject: Re: [PATCH] Bluetooth: btqca: sequential validation
Message-ID: <202112082116.coCA1rOT-lkp@intel.com>
References: <1638952007-32222-1-git-send-email-quic_saluvala@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638952007-32222-1-git-send-email-quic_saluvala@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on linux/master linus/master v5.16-rc4 next-20211208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sai-Teja-Aluvala/Bluetooth-btqca-sequential-validation/20211208-162834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: x86_64-randconfig-a015-20211207 (https://download.01.org/0day-ci/archive/20211208/202112082116.coCA1rOT-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1d58d86c5374c4c82aa1ec8638036667c114f83e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sai-Teja-Aluvala/Bluetooth-btqca-sequential-validation/20211208-162834
        git checkout 1d58d86c5374c4c82aa1ec8638036667c114f83e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btqca.c:144:5: warning: no previous prototype for function 'qca_send_patch_config_cmd' [-Wmissing-prototypes]
   int qca_send_patch_config_cmd(struct hci_dev *hdev, enum qca_btsoc_type soc_type)
       ^
   drivers/bluetooth/btqca.c:144:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int qca_send_patch_config_cmd(struct hci_dev *hdev, enum qca_btsoc_type soc_type)
   ^
   static 
   1 warning generated.


vim +/qca_send_patch_config_cmd +144 drivers/bluetooth/btqca.c

   143	
 > 144	int qca_send_patch_config_cmd(struct hci_dev *hdev, enum qca_btsoc_type soc_type)
   145	{
   146		struct sk_buff *skb;
   147		int err = 0;
   148		u8 cmd[5] = {EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0};
   149		u8 rlen = 0x02;
   150		struct edl_event_hdr *edl;
   151		u8 rtype = EDL_PATCH_CONFIG_CMD;
   152	
   153		bt_dev_dbg(hdev, "QCA Patch config");
   154	
   155		skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CONFIG_CMD_LEN,
   156				cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
   157		if (IS_ERR(skb)) {
   158			err = PTR_ERR(skb);
   159			bt_dev_err(hdev, "Sending QCA Patch config failed (%d)", err);
   160			return err;
   161		}
   162		if (skb->len != rlen) {
   163			bt_dev_err(hdev, "QCA Patch config cmd size mismatch len %d", skb->len);
   164			err = -EILSEQ;
   165			goto out;
   166		}
   167		edl = (struct edl_event_hdr *)(skb->data);
   168		if (!edl) {
   169			bt_dev_err(hdev, "QCA Patch config with no header");
   170			err = -EILSEQ;
   171			goto out;
   172		}
   173		if (edl->cresp != EDL_PATCH_CONFIG_RES_EVT || edl->rtype != rtype) {
   174			bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
   175			 edl->rtype);
   176			err = -EIO;
   177			goto out;
   178		}
   179	out:
   180		kfree(skb);
   181		if (err)
   182			bt_dev_err(hdev, "QCA Patch config cmd failed (%d)", err);
   183	
   184		return err;
   185	}
   186	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
