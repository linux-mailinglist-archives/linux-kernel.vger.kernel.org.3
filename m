Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC59E5AD3A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbiIENSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiIENSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:18:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F7143613;
        Mon,  5 Sep 2022 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662383912; x=1693919912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l7PXA5WXmZ3Cd9WKA4pRuidjuNgifKc+YFuQzYQyPYg=;
  b=WUW2MccY6eJO6Gt+kmrw0Xyk4H2pwodV7pr8WRIsTJbBSU/aUdXz5v9M
   CX2nSp3AbbOKiLZQGWHWoeUrqzHgaeuWuIipyV9vpdfVfOlizcN0Y3KRd
   DHFo1tteCkbF81VhpURj8YBnqhSLr0uVafvNwA/qkaolBjcwGGrazLWrT
   DsVyq7pmbZXFvUquJd3QiNGFcyWHZxaUj8lEGb3jTcw3UHpFG1i6Bij3Q
   8qz7hPQr5DrLnndgDdqyqc8qzXVUhUxE4OGModkWWoETIkHsRGuMhU65M
   US1CFwYKP24RyGj/7qiZExC/DhdLPAkFK98F0jCXTklJ1rSIyV1tjejUQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="296391069"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="296391069"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 06:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="564766174"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Sep 2022 06:18:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 287D014F; Mon,  5 Sep 2022 16:18:29 +0300 (EEST)
Date:   Mon, 5 Sep 2022 16:18:29 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, sanju.mehta@amd.com,
        mario.limonciello@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
 on AMD USB4 controller
Message-ID: <YxX3JeQLbciJ+hhc@black.fi.intel.com>
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWgGKIAvsxwSz85@black.fi.intel.com>
 <CAAd53p4iV=ne5bDGZ6FxE9bBUVoFh=eXF9_oMPvPzjVj=UVoog@mail.gmail.com>
 <YxWqSYDWe0NitSkL@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxWqSYDWe0NitSkL@black.fi.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 05, 2022 at 10:50:33AM +0300, Mika Westerberg wrote:
> > Yes those root ports are resumed to D0 when something is plugged. They
> > however fail to detect any externel PCIe devices.
> 
> Hmm, so you see the actual hotplug but the tunneled PCIe link may not be
> detected? Does the PCIe "Card Present" (or Data Link Layer Active)
> status change at all or is it always 0?

I wonder if we are simply missing the required delays here? Looking at
the lspci dump in the bugzilla you refer the root port 03.1 supports
active link reporting:

		LnkCap:	Port #247, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp+

So when the link goes back to L0 (D3 -> D0 transition) the kernel should
issue the 100+ ms reset delay in pci_bridge_wait_for_secondary_bus():

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c#n5045

can you check if that is happening? It should show up in the dmesg when
CONFIG_PCI_DEBUG=y but I don't see it in yours.
