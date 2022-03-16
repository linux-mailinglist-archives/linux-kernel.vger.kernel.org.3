Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA964DB3C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356869AbiCPO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiCPO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:56:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF6566AE4;
        Wed, 16 Mar 2022 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647442529; x=1678978529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hSZezmWlLRnJispv91DeDwlHSOXFgX7BmpKgikab/4Q=;
  b=ZMgq3Dhxiy2526C/Hk4og9XQkNWPcuzAaS3/NYZpQK/R55oOxaTWSFMw
   OpdITwxgCKQaA3Rg4TeOSe7rFcokm1YqKsTZarg5y4mwIwEhxmguuKjQm
   ML7/fapB9+xmavczx/bE/M9SIojyCcJd2XyjOr3OckPG9MPpA/mXb0Tjq
   7IKptN0GqeDadfOLvv68gOQwl7by+fdsaobQh+t8Bk2DzFCTQDOOMrXex
   m1FMSKQ79o7iooPsxDQPpoc0o9W+6rpVUA2BfEDirtN+DU1WtUWj4Pw1P
   viRpSszy09HnwTCjADUor2TdU6jvZXcYI4ymN2KLpp1dNOclJ+EYFk0HQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256806766"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256806766"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 07:41:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="516364599"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 07:41:45 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 16 Mar 2022 16:39:30 +0200
Date:   Wed, 16 Mar 2022 16:39:30 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] thunderbolt: Automatically authorize PCIe tunnels when
 IOMMU is active
Message-ID: <YjH2om/NSxLQQe2H@lahna>
References: <20220315213008.5357-1-mario.limonciello@amd.com>
 <YjGD7N++F+ioISHb@lahna>
 <BL1PR12MB5157349C626E3818B813D9A0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjHpNloXEvPpv1In@lahna>
 <BL1PR12MB5157719E9A5C0EEBB652141BE2119@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5157719E9A5C0EEBB652141BE2119@BL1PR12MB5157.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:48:49PM +0000, Limonciello, Mario wrote:
> [Public]
> 
> > > > IOMMU is active
> > > >
> > > > Hi Mario,
> > > >
> > > > On Tue, Mar 15, 2022 at 04:30:08PM -0500, Mario Limonciello wrote:
> > > > > Historically TBT3 in Linux used "Thunderbolt security levels" as a primary
> > > > > means of "security" against DMA attacks. This mean that users would
> > need
> > > > to
> > > > > ack any device plugged in via userspace.  In ~2018 machines started to
> > use
> > > > > the IOMMU for protection, but instead of dropping security levels a
> > > > > convoluted flow was introduced:
> > > > > * User hotplugs device
> > > > > * Driver discovers supported tunnels
> > > > > * Driver emits a uevent to userspace that a PCIe tunnel is present
> > > > > * Userspace reads 'iommu_dma_protection' attribute (which currently
> > > > >   indicates an Intel IOMMU is present and was enabled pre-boot not
> > that
> > > > >   it's active "now")
> > > > > * Based on that value userspace then authorizes automatically or
> > prompts
> > > > >   the user like how security level based support worked.
> > > >
> > > > There are legitimate reasons to disable PCIe tunneling even if the
> > IOMMU
> > > > bits are in place. The ACPI _OSC allows the boot firmware to do so and
> > > > our "security levels" allows the userspace policy to do the same. I
> > > > would not like to change that unless absolutely necessary.
> > >
> > > Actually I intentionally left that in the RFC patch, to only do this based off
> > > of tb_acpi_may_tunnel_pcie, so I think that should still work as you
> > described
> > > if boot firmware turned off PCIe tunneling.
> > 
> > Right but if the user still wants to disable it, like say you are
> > travelling and you want to be sure that no PCIe devices get attached
> > while your laptop is charging from a public "charging station" (whatever
> > is the right term).
> 
> So wouldn't you flip the default in BIOS setup to disable PCIe tunnels then for
> this use case?

What if you are on Chromebook? Or something where this is not user
configurable?

> Otherwise with how it is today you end up with the PCIe tunnel created in the
> boot FW and then coming into the OS if it's the same path the tunnel stays
> in place with no opportunity for userspace to authorize it, no?

The boot FW does not need to support CM capabilites nor does it need to
provide the ACPI _OSC.
