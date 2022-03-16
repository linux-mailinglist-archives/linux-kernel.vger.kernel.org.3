Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF624DB9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbiCPU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiCPU7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:59:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDE55A5BB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647464305; x=1679000305;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KYoTv7ruHgzjw0zYcgRtx7NngXpRKYqbmIlSecMOMPg=;
  b=DIZOfSbl8y38pugcJ6fFWUWz6gNQuXhXpc4YjCJfR/VjvBWKk2Rw5HiU
   CsuVYPCFXWYbLCsSfWL+/zK7Ellcn+Tx7jIKztggs0uYMaZr5uBduwfYo
   8xNItpXKWVMmvKyA0y4vrQiqegPzNQYOQW/9ahz6dqeZEChrfxG7QXyEw
   PCMejZGNbYQ/4bWrMNIVCYin6a8rc3NSwrd7p/c5LzCeq7UchBTk6dHZv
   UvWBMImPDq2AL8g+BqWDGURIF14SaOG223sqsT48pIXTRXwV7DrKsPxxE
   qS1uQGGjO15CJL4SHHyzKX7nIkZjZgP1hJody0r7oIauIkxZeIMLX2Vjw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="238873754"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="238873754"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 13:58:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="690722576"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 13:58:24 -0700
Date:   Wed, 16 Mar 2022 14:01:40 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220316140140.76bb24c6@jacob-builder>
In-Reply-To: <BN9PR11MB5276E98AE37EA912B01EB0B68C119@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
        <20220315143322.GW11336@nvidia.com>
        <BN9PR11MB5276E98AE37EA912B01EB0B68C119@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Wed, 16 Mar 2022 07:41:34 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, March 15, 2022 10:33 PM
> >=20
> > On Mon, Mar 14, 2022 at 10:07:07PM -0700, Jacob Pan wrote: =20
> > > +	/*
> > > +	 * Each domain could have multiple devices attached with
> > > shared or =20
> > per =20
> > > +	 * device PASIDs. At the domain level, we keep track of
> > > unique PASIDs =20
> > and =20
> > > +	 * device user count.
> > > +	 * E.g. If a domain has two devices attached, device A has
> > > PASID 0, 1;
> > > +	 * device B has PASID 0, 2. Then the domain would have PASID
> > > 0, 1, 2.
> > > +	 */ =20
> >=20
> > A 2d array of xarray's seems like a poor data structure for this task. =
=20
>=20
Perhaps i mis-presented here, I am not using 2D array. It is an 1D xarray
for domain PASIDs only. Then I use the existing device list in each domain,
adding another xa to track per-device-domain PASIDs.
> besides that it also doesn't work when we support per-device PASID
> allocation in the future. In that case merging device PASIDs together is
> conceptually wrong.
>=20
Sorry, could you elaborate? If we do per-dev PASID allocation, we could use
the ioasid_set for each pdev, right?

> >=20
> > AFACIT this wants to store a list of (device, pasid) tuples, so a
> > simple linked list, 1d xarray vector or a red black tree seems more
> > appropriate..
> >  =20
>=20
> this tuple can well serve per-device PASID. =F0=9F=98=8A
>=20
I commented on the other email, but a simple list of tuples could have
duplicated devices since each dev could attach multiple PASIDs, right?
Should we still do two level then?

> Thanks
> Kevin


Thanks,

Jacob
