Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A837B5AEB1F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiIFNvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbiIFNs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:48:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91578D68;
        Tue,  6 Sep 2022 06:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471567; x=1694007567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=875CevRVJe80L7/rtpiMmo6eouC3PweRugFAgUKQzIA=;
  b=CWeXbFsbUwURNngJZSEnO5kBPyMb8gAh+81qEjsTXm3W/Y/YjUwLe600
   FfOX4WXEnQiQ7GtijHHMlePn3FFjAsihXLnRyZGjJ9hxxec0fdlYZ9cBM
   vLxzw9u6k11la5lsgflW52biXJOi0eGVemZTjaU5TbV1vQ0YqsGNy3RAe
   T7GTyon2yMoapd2mINhj3Ch8ksPVKpOgWkBbCRi3m6XhoBjaAHkFBKQjq
   fM6lskGAXi+5NhMxy0R90VEPIZksy/Krrlqn4q6763nm9idiulYtdgAX2
   cGin830Vz7EeIHIlTtts/iXpTfVxksA9ZMPWYtQeUEw03s6qU9AeD5sIi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276331670"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276331670"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="614095396"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2022 06:37:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1F37C235; Tue,  6 Sep 2022 16:37:47 +0300 (EEST)
Date:   Tue, 6 Sep 2022 16:37:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, sanju.mehta@amd.com,
        mario.limonciello@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
 on AMD USB4 controller
Message-ID: <YxdNKx1OFKsgBUBu@black.fi.intel.com>
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWgGKIAvsxwSz85@black.fi.intel.com>
 <CAAd53p4iV=ne5bDGZ6FxE9bBUVoFh=eXF9_oMPvPzjVj=UVoog@mail.gmail.com>
 <YxWqSYDWe0NitSkL@black.fi.intel.com>
 <CAAd53p6bSmTPavjA0v6tybc6=HrwiDn0JGzXwVOG_m5EVw1p1w@mail.gmail.com>
 <YxYXH5dqKqPANeVX@black.fi.intel.com>
 <CAAd53p5tYG=mAR-RSr1g_iznmmcCy1QpthG5vQzr99AP4QLJyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p5tYG=mAR-RSr1g_iznmmcCy1QpthG5vQzr99AP4QLJyg@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 08:57:20PM +0800, Kai-Heng Feng wrote:
> On Mon, Sep 5, 2022 at 11:34 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Mon, Sep 05, 2022 at 11:21:36PM +0800, Kai-Heng Feng wrote:
> > > > Hmm, so you see the actual hotplug but the tunneled PCIe link may not be
> > > > detected? Does the PCIe "Card Present" (or Data Link Layer Active)
> > > > status change at all or is it always 0?
> > >
> > > It changes only after tb_switch_add() is called.
> >
> > I doubt tb_switch_add() does anything but instead it is the established
> > PCIe tunnel that then shows up as it toggles the Card Present bit or so.
> > But that should also trigger PME if the root port is in D3 so you should
> > see this wake if everything works accordingly (unless I'm missing
> > something).
> 
> You are right. Sometimes it may still fail to detect hotplugged device
> right after tb_switch_add().
> At which point PCIe tunnels are established? Is it after tb_scan_port()?

They are established when userspace writes "1" to ../authorized of the
device (not automatically).

On Ubuntu that's boltd that handles this so you may need to disable it
before you do the experiment.

> I found that it's cleaner to wakeup hotplug ports via iterating device
> link consumers at the end of tb_scan_port().
> 
> According to your commit b2be2b05cf3b1c7b499d3b05decdcc524879fea7
> ("thunderbolt: Create device links from ACPI description"), it states
> "The _DSD can be added to tunneled USB3 and PCIe ports, and is needed to
> make sure the USB4 NHI is resumed before any of the tunneled ports so
> the protocol tunnels get established properly before the actual port
> itself is resumed. Othwerwise the USB/PCI core find the link may not be
> established and starts tearing down the device stack."
> 
> So isn't waking them up a logical thing to do here?

No they should wake up themselves.

> > So if you do this:
> >
> > 1. Boot the system up, nothing connected
> > 2. Plug in the TBT/USB4 device but do not authorize the PCIe tunnel
> > 3. Wait for the TBT/USB4 domain to enter sleep (runtime suspend)
> > 4. Authorize the PCIe tunnel
> >
> >   # echo 1 > .../authorized
> >
> > The established PCIe tunnel should trigger PME and the root port then
> > should be able to detect the PCIe link. Can you add full dmesg with
> > "thunderbolt.dyndbg=+p" in the command line to the bug?
> 
> dmesg attached. Unfortunately there's no PME.

Hmm, attached to where? Forgot to attach? ;-)
