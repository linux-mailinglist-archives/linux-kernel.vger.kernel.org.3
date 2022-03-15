Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649574DA48C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351954AbiCOVWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244518AbiCOVWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:22:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAF25BD26
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647379279; x=1678915279;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TNxtE1A6OO9CxPl8L+HGA5J4pbco3V3lCXf823b3+BM=;
  b=fhwtUyz16U9AM/1mSW/WfTpPKHmjswca07QpiJFR2yKoNkZKZZiLm9gY
   yE5Q1+8OaLA9QxANEJl2LTuSfzjPc6Hdn1QffkVsvpfnoReBd9iwhButD
   yiM3pW89rlQC/R7rAsGKhLL+9QdYmZYkL9py2NOBTz894JIAgnv008p1Y
   x0hOhbHo0kmo4LDm7ZzW4EJONncEC5l1lUfRM9LeddvXy4RABVofR6dyM
   NSYEdLzfgkerDdCE+tosaxkVHmFcL3LambMOUYPAxOAKBSqTSM2SjFQfN
   9D7FcmGhbdjxwWYiBV1zj7ulXF+290i/F0i6yrVOlzxmBEYoT2uX68TUd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255255335"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="255255335"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:21:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="613410758"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:21:11 -0700
Date:   Tue, 15 Mar 2022 14:24:27 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API
 users
Message-ID: <20220315142427.21687ac2@jacob-builder>
In-Reply-To: <20220315170507.GH11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
        <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
        <20220315142216.GV11336@nvidia.com>
        <20220315093135.5c11066d@jacob-builder>
        <20220315170507.GH11336@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, 15 Mar 2022 14:05:07 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 15, 2022 at 09:31:35AM -0700, Jacob Pan wrote:
>=20
> > > IMHO it is a device mis-design of IDXD to require all DMA be PASID
> > > tagged. Devices should be able to do DMA on their RID when the PCI =20
>=20
> > IDXD can do DMA w/ RID, the PASID requirement is only for shared WQ
> > where ENQCMDS is used. ENQCMDS has the benefit of avoiding locking
> > where work submission is done from multiple CPUs.
> > Tony, Dave? =20
>=20
> This is what I mean, it has an operating mode you want to use from the
> kernel driver that cannot do RID DMA. It is a HW mis-design, IMHO.
>=20
> Something like PASID0 in the ENQCMDS should have triggered RID DMA.
>=20
That would simplify things a lot, it would be just a device change I think.
=46rom IA pov, only ENQCMD will #GP if PASID=3D=3D0. I will bring this back t=
o HW
team to consider for future generations.

> > > In any case I think we are better to wait for an actual user for multi
> > > DMA API iommu_domains to come forward before we try to build an API
> > > for it. =20
> >=20
> > What would you recommend in the interim? =20
>=20
> Oh, I mean this approach at a high level is fine - I was saying we
> shouldn't try to broaden it like Robin was suggesting without a driver
> that needs multiple iommu_domains for the DMA API.
>=20
Got it. Thanks for the clarification.

> Jason


Thanks,

Jacob
