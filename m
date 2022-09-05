Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2565ACD18
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiIEHuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbiIEHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:50:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B61BE9D;
        Mon,  5 Sep 2022 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662364221; x=1693900221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rY1TCG8yN4ejyittlrT4eiFuc0Mo/U8I/RU+8hrtv2c=;
  b=IaldhKnjFj2Z735w4m+DRkx6nvpI87IBESH10rKbuD0FkeSC0QRrWtG7
   BR2y9Hj1LK4hDynz6HJcEd3dXdnclqvENOBp+fUoCz/I32ohqsA+gT4Pe
   lGMpt9PP8jRRlqzxplCdqg3W9zGNkxQOTkHEFutlFtYxBX2kE0xFilkjI
   SKeWS40jb4HfFtjes+UzPGr/dFv4af8mL/zQtKj7j6bOjcDYIMYZwd3w9
   Bq2Pe0KjqhFCm0Rv65yQUdY4O4XkRbr6aB7qDz2wyJPirHm2fUoyGfTx8
   h7cuHglrA9gbxjb0bfeOvhvAlsdwZF21Brk9GMtjzfzw2wk6AZFu3wBQU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="382630819"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="382630819"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="609599751"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 05 Sep 2022 00:50:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 71CC586; Mon,  5 Sep 2022 10:50:33 +0300 (EEST)
Date:   Mon, 5 Sep 2022 10:50:33 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, sanju.mehta@amd.com,
        mario.limonciello@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
 on AMD USB4 controller
Message-ID: <YxWqSYDWe0NitSkL@black.fi.intel.com>
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWgGKIAvsxwSz85@black.fi.intel.com>
 <CAAd53p4iV=ne5bDGZ6FxE9bBUVoFh=eXF9_oMPvPzjVj=UVoog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p4iV=ne5bDGZ6FxE9bBUVoFh=eXF9_oMPvPzjVj=UVoog@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 03:26:28PM +0800, Kai-Heng Feng wrote:
> Hi Mika,
> 
> On Mon, Sep 5, 2022 at 3:06 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Mon, Sep 05, 2022 at 02:56:22PM +0800, Kai-Heng Feng wrote:
> > > AMD USB4 can not detect external PCIe devices like external NVMe when
> > > it's hotplugged, because card/link are not up:
> > >
> > > pcieport 0000:00:04.1: pciehp: pciehp_check_link_active: lnk_status = 1101
> >
> > I think the correct solution is then to block them from runtime
> > suspending entirely.
> 
> Do you mean disable runtime suspend completely? Or just block runtime
> suspend for a period?

Completely. The port should enter D3 if it cannot wake up and Linux does
not even enable runtime PM for such ports unless they declare
"HotPlugSupportInD3" in their ACPI description:

https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3

So that property should not be there if they cannot wake up.

> > > Use `lspci` to resume pciehp bridges can find external devices.
> > >
> > > A long delay before checking card/link presence doesn't help, either.
> > > The only way to make the hotplug work is to enable pciehp interrupt and
> > > check card presence after the TB switch is added.
> > >
> > > Since the topology of USB4 and its PCIe bridges are siblings, hardcode
> > > the bridge ID so TBT driver can wake them up to check presence.
> >
> > Let's not add PCI things into TBT driver unless absolutely necessary.
> 
> OK. It's getting harder as different components are intertwined
> together on new hardwares...
> 
> >
> > At least on Intel hardware the PCIe hotplug is signaled by SCI when the
> > root port is in D3, I wonder if AMD has something similar.
> 
> Yes those root ports are resumed to D0 when something is plugged. They
> however fail to detect any externel PCIe devices.

Hmm, so you see the actual hotplug but the tunneled PCIe link may not be
detected? Does the PCIe "Card Present" (or Data Link Layer Active)
status change at all or is it always 0?
