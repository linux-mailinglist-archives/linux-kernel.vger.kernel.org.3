Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154584DB6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348758AbiCPRUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiCPRUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:20:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177695AA4A;
        Wed, 16 Mar 2022 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647451139; x=1678987139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VaMyY87ToqjB9wkrkICrM9Cibhn7xEkgoFrLOxNQfiE=;
  b=PhP3gqSNyni3OAe5KStY9t1J9KQl3f4f48gnZ+6PljioyN5YPfFrL640
   v1vxOKppgcPo4jZmABylIB1XS+h0aL/zxVkOGrN2Sp8vztfMzbkJ6wxm/
   zyV/NLwtKNgl0YMxaBPOv38PftuNg3O5zMYVrAzPy4aoDdSeRix+OlJmc
   KtjQPutKQ92KmdxL3MNePmpYlsdkk45g7RgB+pJV/0SBxyJWIlLGRNZlV
   jrZzsz0YaeVK1s/o+s6X9dgRf6kMEGJ2y4BIo1Tb3QVL5FwdYvPbwp4Sm
   cixg4eqgYS4IUoQuPpKMEbeayntzIQTEoVDuPWT+yRyMoFBZBcti/dAFZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255500186"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="255500186"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 10:18:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="581003689"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 10:18:53 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 16 Mar 2022 19:18:49 +0200
Date:   Wed, 16 Mar 2022 19:18:49 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        mario.limonciello@amd.com, hch@lst.de
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjIb+XOGZbWKpQDa@lahna>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna>
 <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 16, 2022 at 02:49:09PM +0000, Robin Murphy wrote:
> > What we want is to make sure the Tunneled PCIe ports get the full IOMMU
> > protection. In case of the discrete above it is also fine if all the
> > devices behind the PCIe root port get the full IOMMU protection. Note in
> > the integrated all the devices are "siblings".
> 
> Ah, OK, I wasn't aware that the NHI isn't even the right thing in the first
> place :(
> 
> Is there an easy way to get from the struct tb to a PCI device representing
> the end of its relevant tunnel, or do we have a circular dependency problem
> where the latter won't appear until we've authorised it (and thus the IOMMU
> layer won't know about it yet either)?

The PCIe root ports (and the PCIe downstream ports) are there already
even without "authorization".

There is a way to figure out the "tunneled" PCIe ports by looking at
certain properties and we do that already actually. The BIOS has the
following under these ports:

https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

and the ports will have dev->external_facing set to 1. Perhaps looking
at that field helps here?
