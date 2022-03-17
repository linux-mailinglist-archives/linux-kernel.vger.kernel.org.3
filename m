Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B6A4DBF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiCQGbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiCQGbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:31:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF99F3BC;
        Wed, 16 Mar 2022 23:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647498616; x=1679034616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+EitQhRNu6NXwpeAYT82YbKRTfk60BrW2G0bXEc4/dM=;
  b=hR6bS457FRlHdvbERexGJO4WsnkoQj/mCtSsnbNWIEd9Nn+U13BBGc8S
   MOUXf/l0pg15B9zGGSAgcxUqpRkKi7DcoxFYZfq6+ZEnUcvw55G/p9oJN
   XDeAXnceek9z56HOkPutT4xENHLi4Zbk0Kf8ShgeHxvBjeRYRaEUpKKgN
   ty3zNqjKQ2BC4fQ7WenhjdYHV9GV4JxR7FRJhIUPmfsS0BTIj5bdsf/QI
   alVjy6NSoLBduQpFtS6fgVwWHE+e+SzEQe3ZSNwIZdMdZr7QeQm87yqdU
   GR3QVOzft+BTAifYNfZS3gG5tidEaYuGU3v9szvEWJwOfE2T30FKug/19
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="320005909"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="320005909"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 23:30:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="714916184"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 23:30:13 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 17 Mar 2022 08:30:10 +0200
Date:   Thu, 17 Mar 2022 08:30:10 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjLVcnl1qfdoDf48@lahna>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna>
 <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna>
 <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Wed, Mar 16, 2022 at 06:34:51PM +0000, Limonciello, Mario wrote:
> > Might it be reasonable for the Thunderbolt core to check early on if any
> > tunnelled ports are not marked as external facing, and if so just tell
> > the user that iommu_dma_protection is off the table and anything they
> > authorise is at their own risk?
> > 
> > Robin.
> 
> How about in iommu_dma_protection_show to just check that all the device
> links to the NHI are marked as untrusted?

Actually this does not work either because we have pre-USB4 systems out
there that are using firmware based connection manager and do not set
the "device links" (as it is only needed for USB4 software based
connection manager systems).

So only thing we can use is the ->external_facing (and ->untrusted) as
those exists in all these systems (well assuming the BIOS provided them
but this is Microsoft requirement in the same way with the DMAR bit).

[For those who are not familiar with the connection manager, it is the
 software or firmware that actually creates the tunnels over the
 Thunderbolt/USB4 fabric. In Intel systems up to Alder Lake it used to be
 firmware based, and from Alder Lake and beyond it is software based
 meaning that the Linux Thunderbolt driver creates the tunnels. Apple
 systems have been software based from the beginnning.]
