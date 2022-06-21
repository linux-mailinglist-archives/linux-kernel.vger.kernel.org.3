Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C550552CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348302AbiFUIZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348290AbiFUIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:24:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D5F24F0F;
        Tue, 21 Jun 2022 01:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655799829; x=1687335829;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=3xH9W0h2UUn1FENbUG0vdXjhd+Y076ZvG9N0zuwe7xc=;
  b=ZPY/teVw+N+79eiPAruPYpUzBfUrsgBIrA6XYW2mDCVaiIX5Rl0tQJsW
   MdCrCVLNZ+nuzivxPN2u6kdyH2nQHXrpbUVMOZiJDuKPZoaFj7ZyylXcE
   uHRwaXsomCkInePjEvhdMrFfnH5al9vV+TfhvaiN4b4uekviTxsm8F2aI
   mCGlt2jRaLeOG+uaPharxZ8ZYILw81zYtzq8AdyW29UZNUg5bjKHBOw+q
   qaSkuDSp5k2JoD2Zke6Zd8h5yWdo71oc3XPH3l7+nuMOePh/ZJtDcWGaj
   MFuBNe+ubQmxg6LVcLHjx2p3J93yU9IxTs8SRbIuMgWIlLEzwwj6PHTwM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="344054373"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="344054373"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 01:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="729737957"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jun 2022 01:23:46 -0700
Message-ID: <bf133cfd-8d9a-474e-989e-48fe383ecfbd@linux.intel.com>
Date:   Tue, 21 Jun 2022 11:25:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Content-Language: en-US
To:     Hongyu Xie <xy521521@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        125707942@qq.com, wangqi@kylinos.cn, xiongxin@kylinos.cn,
        Hongyu Xie <xiehongyu1@kylinos.cn>
References: <20220616083852.1264261-1-xiehongyu1@kylinos.cn>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v5 -next] usb: xhci: disable irq during initialization
In-Reply-To: <20220616083852.1264261-1-xiehongyu1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 16.6.2022 11.38, Hongyu Xie wrote:
> irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
> in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
> It's possible that you will receive thousands of interrupt requests
> after initialization for 2.0 roothub. And you will get a lot of
> warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
> disabled?". This amount of interrupt requests will cause the entire
> system to freeze.
> This problem was first found on a device with ASM2142 host controller
> on it.
> 
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> --
Thanks, added.
Did some non-functional cleanups, mostly to the old debug messages this patch
moves around:

https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?h=for-usb-linus&id=2d1fa9b0b08bb841fde9136c249f632eb04a1e00

Let me know if you disagree with the changes

-Mathias
