Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656B94DB1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346137AbiCPNni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243280AbiCPNnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:43:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161D41337;
        Wed, 16 Mar 2022 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647438139; x=1678974139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=momPsxoKPNJVtZlhvwNbwSbe8YRFEMNcFz37imYur0M=;
  b=gLh2OQ09MecChtK/W/klfHL6ueoxvF+vTD8htvpwDSfbw2AhmqXQLf1J
   Ab+bzyUG3aNMujf9XdaqNma1skYIug8ckjOeg4EeXuVFNeClayh0PP4Kt
   A5QbL1YKIa81UxaYVeLAkMy575Qgfltj0r5KOT5kje4pKlOc7CHdishEN
   Rd+jQlbMZXlz1sBzNbWWG5uwQFjpVjpEiXjfR1MGlk9/JGbOYsMSipym6
   elP9GYOlQLdrCkUo41Td3dAuEPaKhT+zAb7Nv2NU66H3yb2mMAaltL1l/
   9ymIf89X/k6IpOO6FDrB/Ri+ohxXJWcoZr0BlQnqdH7+mySqXn5kt5ie/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236535317"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="236535317"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 06:42:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="644674084"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 06:42:16 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 16 Mar 2022 15:42:14 +0200
Date:   Wed, 16 Mar 2022 15:42:14 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] thunderbolt: Automatically authorize PCIe tunnels when
 IOMMU is active
Message-ID: <YjHpNloXEvPpv1In@lahna>
References: <20220315213008.5357-1-mario.limonciello@amd.com>
 <YjGD7N++F+ioISHb@lahna>
 <BL1PR12MB5157349C626E3818B813D9A0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5157349C626E3818B813D9A0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:06:24PM +0000, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
> 
> 
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Wednesday, March 16, 2022 01:30
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Andreas Noever <andreas.noever@gmail.com>; Michael Jamet
> > <michael.jamet@intel.com>; Yehezkel Bernat <YehezkelShB@gmail.com>;
> > open list:THUNDERBOLT DRIVER <linux-usb@vger.kernel.org>; open list
> > <linux-kernel@vger.kernel.org>
> > Subject: Re: [RFC] thunderbolt: Automatically authorize PCIe tunnels when
> > IOMMU is active
> > 
> > Hi Mario,
> > 
> > On Tue, Mar 15, 2022 at 04:30:08PM -0500, Mario Limonciello wrote:
> > > Historically TBT3 in Linux used "Thunderbolt security levels" as a primary
> > > means of "security" against DMA attacks. This mean that users would need
> > to
> > > ack any device plugged in via userspace.  In ~2018 machines started to use
> > > the IOMMU for protection, but instead of dropping security levels a
> > > convoluted flow was introduced:
> > > * User hotplugs device
> > > * Driver discovers supported tunnels
> > > * Driver emits a uevent to userspace that a PCIe tunnel is present
> > > * Userspace reads 'iommu_dma_protection' attribute (which currently
> > >   indicates an Intel IOMMU is present and was enabled pre-boot not that
> > >   it's active "now")
> > > * Based on that value userspace then authorizes automatically or prompts
> > >   the user like how security level based support worked.
> > 
> > There are legitimate reasons to disable PCIe tunneling even if the IOMMU
> > bits are in place. The ACPI _OSC allows the boot firmware to do so and
> > our "security levels" allows the userspace policy to do the same. I
> > would not like to change that unless absolutely necessary.
> 
> Actually I intentionally left that in the RFC patch, to only do this based off
> of tb_acpi_may_tunnel_pcie, so I think that should still work as you described
> if boot firmware turned off PCIe tunneling.

Right but if the user still wants to disable it, like say you are
travelling and you want to be sure that no PCIe devices get attached
while your laptop is charging from a public "charging station" (whatever
is the right term).
