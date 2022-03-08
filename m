Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117BA4D1532
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346018AbiCHKxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbiCHKxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:53:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD143AD0;
        Tue,  8 Mar 2022 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646736743; x=1678272743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zk3clbFlUlJ7Oe1mWROvit8ti6FKGIp6FYYxamndiUE=;
  b=HHKKWMrZGlr863qtuzsoFM5ZJPvRJF2EXPJqKJUyVk33XGlSe9y0X9l5
   I8uc1Aq0mzUyx6mOrcfNibzCFIdZb0Vl+2WJO0jv0BXZ518WABbd0QogF
   gDkHyECUZqP10kN5OIn7V5kP/0BFylLefEvBWdufsAAHnIvxZb8kDRFOr
   YS6pI17EblnG5GMQxESDBsH9yyqlgK/oweZw+3zqcWE88qKeWTyub+juu
   lboDY6vRTyx+X3+cgA9F891Aq634R0yVjtN/aZq2N7wOu4s0E+THSvIMa
   CDBslh3gw73Q9prGJ4/HYA2ojLkp+BhluArWUygqGP1Xmr+mwQpNlmWDv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254845101"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254845101"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:52:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="632195958"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2022 02:52:19 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRXRy-0001I5-Vm; Tue, 08 Mar 2022 10:52:18 +0000
Date:   Tue, 8 Mar 2022 18:51:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: Re: [PATCH v1 2/4] usb: host: add xhci hooks for USB offload
Message-ID: <202203081848.5KEiXYSo-lkp@intel.com>
References: <891095110.61646375404257.JavaMail.epsvc@epcpadp3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <891095110.61646375404257.JavaMail.epsvc@epcpadp3>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daehwan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on krzk/for-next]
[also build test ERROR on char-misc/char-misc-testing v5.17-rc7]
[cannot apply to usb/usb-testing next-20220308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220304-143406
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
config: arm-hisi_defconfig (https://download.01.org/0day-ci/archive/20220308/202203081848.5KEiXYSo-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2b6a5d700c2bbb0a3ccfcd6e83a7f7b2ea049db9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220304-143406
        git checkout 2b6a5d700c2bbb0a3ccfcd6e83a7f7b2ea049db9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/usb/host/xhci.c:4361:5: warning: no previous prototype for 'xhci_address_device' [-Wmissing-prototypes]
    4361 | int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
         |     ^~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci.c: In function 'xhci_vendor_get_ops':
>> drivers/usb/host/xhci.c:4459:20: error: 'struct xhci_hcd' has no member named 'vendor_ops'
    4459 |         return xhci->vendor_ops;
         |                    ^~
   drivers/usb/host/xhci.c:4460:1: error: control reaches end of non-void function [-Werror=return-type]
    4460 | }
         | ^
   cc1: some warnings being treated as errors


vim +4459 drivers/usb/host/xhci.c

  4360	
> 4361	int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
  4362	{
  4363		return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS);
  4364	}
  4365	EXPORT_SYMBOL_GPL(xhci_address_device);
  4366	
  4367	static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
  4368	{
  4369		return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY);
  4370	}
  4371	
  4372	/*
  4373	 * Transfer the port index into real index in the HW port status
  4374	 * registers. Caculate offset between the port's PORTSC register
  4375	 * and port status base. Divide the number of per port register
  4376	 * to get the real index. The raw port number bases 1.
  4377	 */
  4378	int xhci_find_raw_port_number(struct usb_hcd *hcd, int port1)
  4379	{
  4380		struct xhci_hub *rhub;
  4381	
  4382		rhub = xhci_get_rhub(hcd);
  4383		return rhub->ports[port1 - 1]->hw_portnum + 1;
  4384	}
  4385	
  4386	/*
  4387	 * Issue an Evaluate Context command to change the Maximum Exit Latency in the
  4388	 * slot context.  If that succeeds, store the new MEL in the xhci_virt_device.
  4389	 */
  4390	static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
  4391				struct usb_device *udev, u16 max_exit_latency)
  4392	{
  4393		struct xhci_virt_device *virt_dev;
  4394		struct xhci_command *command;
  4395		struct xhci_input_control_ctx *ctrl_ctx;
  4396		struct xhci_slot_ctx *slot_ctx;
  4397		unsigned long flags;
  4398		int ret;
  4399	
  4400		spin_lock_irqsave(&xhci->lock, flags);
  4401	
  4402		virt_dev = xhci->devs[udev->slot_id];
  4403	
  4404		/*
  4405		 * virt_dev might not exists yet if xHC resumed from hibernate (S4) and
  4406		 * xHC was re-initialized. Exit latency will be set later after
  4407		 * hub_port_finish_reset() is done and xhci->devs[] are re-allocated
  4408		 */
  4409	
  4410		if (!virt_dev || max_exit_latency == virt_dev->current_mel) {
  4411			spin_unlock_irqrestore(&xhci->lock, flags);
  4412			return 0;
  4413		}
  4414	
  4415		/* Attempt to issue an Evaluate Context command to change the MEL. */
  4416		command = xhci->lpm_command;
  4417		ctrl_ctx = xhci_get_input_control_ctx(command->in_ctx);
  4418		if (!ctrl_ctx) {
  4419			spin_unlock_irqrestore(&xhci->lock, flags);
  4420			xhci_warn(xhci, "%s: Could not get input context, bad type.\n",
  4421					__func__);
  4422			return -ENOMEM;
  4423		}
  4424	
  4425		ret = xhci_vendor_sync_dev_ctx(xhci, udev->slot_id);
  4426		if (ret) {
  4427			spin_unlock_irqrestore(&xhci->lock, flags);
  4428			xhci_warn(xhci, "%s: Failed to sync device context failed, err=%d",
  4429				  __func__, ret);
  4430			return ret;
  4431		}
  4432	
  4433		xhci_slot_copy(xhci, command->in_ctx, virt_dev->out_ctx);
  4434		spin_unlock_irqrestore(&xhci->lock, flags);
  4435	
  4436		ctrl_ctx->add_flags |= cpu_to_le32(SLOT_FLAG);
  4437		slot_ctx = xhci_get_slot_ctx(xhci, command->in_ctx);
  4438		slot_ctx->dev_info2 &= cpu_to_le32(~((u32) MAX_EXIT));
  4439		slot_ctx->dev_info2 |= cpu_to_le32(max_exit_latency);
  4440		slot_ctx->dev_state = 0;
  4441	
  4442		xhci_dbg_trace(xhci, trace_xhci_dbg_context_change,
  4443				"Set up evaluate context for LPM MEL change.");
  4444	
  4445		/* Issue and wait for the evaluate context command. */
  4446		ret = xhci_configure_endpoint(xhci, udev, command,
  4447				true, true);
  4448	
  4449		if (!ret) {
  4450			spin_lock_irqsave(&xhci->lock, flags);
  4451			virt_dev->current_mel = max_exit_latency;
  4452			spin_unlock_irqrestore(&xhci->lock, flags);
  4453		}
  4454		return ret;
  4455	}
  4456	
  4457	struct xhci_vendor_ops *xhci_vendor_get_ops(struct xhci_hcd *xhci)
  4458	{
> 4459		return xhci->vendor_ops;
  4460	}
  4461	EXPORT_SYMBOL_GPL(xhci_vendor_get_ops);
  4462	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
