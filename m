Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E82B5ACC98
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiIEHJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbiIEHHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:07:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA243F303;
        Mon,  5 Sep 2022 00:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662361612; x=1693897612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A7WgH2YC9MYu+ut79TNe9XnT7dapamgPhsxVjVLfNFg=;
  b=aDHTGlArHHbcwlt4PGenwfCENLpzWzy9y6petWA7xURAi88YcI4ntTKK
   FfcnK4a58Pi4Ng8Zjjn7RDjC7ZBvhg+YTRpNJwEGxqerwwaSCqwkOiW66
   D19tWeksUVm6TDCa9/orG53mnto1AM0uSlIbRvuasVXgHh09bLPZRMc2G
   s2HP07/jrQ0eSXmxQwREKICkajEjlf0lsSLwskp6d1QEEHY+06AUcjpZ1
   OIBIO79tXLtBo7QBT+p7+ZfKd/1N+RxkAEzLKDisT//9qFwmiuANM2p4T
   78ySuABVrA/ssh001HxBrGshJ5I6hPINjFFVvUPU4uMgZJbffq3L8kK6b
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="279340078"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="279340078"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="941997223"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2022 00:06:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CF67C86; Mon,  5 Sep 2022 10:07:04 +0300 (EEST)
Date:   Mon, 5 Sep 2022 10:07:04 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, sanju.mehta@amd.com,
        mario.limonciello@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
 on AMD USB4 controller
Message-ID: <YxWgGKIAvsxwSz85@black.fi.intel.com>
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 05, 2022 at 02:56:22PM +0800, Kai-Heng Feng wrote:
> AMD USB4 can not detect external PCIe devices like external NVMe when
> it's hotplugged, because card/link are not up:
> 
> pcieport 0000:00:04.1: pciehp: pciehp_check_link_active: lnk_status = 1101

I think the correct solution is then to block them from runtime
suspending entirely.

> Use `lspci` to resume pciehp bridges can find external devices.
> 
> A long delay before checking card/link presence doesn't help, either.
> The only way to make the hotplug work is to enable pciehp interrupt and
> check card presence after the TB switch is added.
> 
> Since the topology of USB4 and its PCIe bridges are siblings, hardcode
> the bridge ID so TBT driver can wake them up to check presence.

Let's not add PCI things into TBT driver unless absolutely necessary.

At least on Intel hardware the PCIe hotplug is signaled by SCI when the
root port is in D3, I wonder if AMD has something similar.
