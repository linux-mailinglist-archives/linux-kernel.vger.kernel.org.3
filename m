Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B403D4AD2B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348739AbiBHIEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348734AbiBHIEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:04:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4445C0401F5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644307454; x=1675843454;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:to:cc:subject:from:message-id:date;
  bh=AUUalteisJVotgwm2A5rb5kQMU4MKwe9fDedhXPmsdY=;
  b=Lo76UWkFk/9FWrrDs9rnscSbbfHCwb5k0JPPPD2AjJ9QxmDsVz9SCnwm
   IBIsjJmh0upCDP491Awpm+wNjAXyR1JeatXc6AgbsRvEmxPIomMiJWRfr
   u6V1dU58CKOL68NWWD5wvj8gmFxam+mpdyIGclgo5GjKuE8IxbIoCTMS4
   fDUda3xI8JafcDqwsO2RYWjzq6FE09Z7IerN+btLCovtov8rKTWJEv6gO
   F1xYGFoKClVn8TRgTVw2GaxRfLIVTrWjRlzMjqCjwNL2NHZ7Q2rcf1tNM
   dPf3WuQmsFXSZGiSFxGl5A45Fty/ZBgrM0IC+ZOT98Ec6biUy9LXyLj5u
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="249105310"
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="249105310"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 00:04:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="540492714"
Received: from zimmerer-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.39.149])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 00:04:10 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <877da7rlzr.fsf@intel.com>
References: <20220127120508.11330-1-zhi.a.wang@intel.com> <20220207073247.GA24327@lst.de> <DM4PR11MB5549FE45F8098368114ADE75CA2C9@DM4PR11MB5549.namprd11.prod.outlook.com> <20220207083535.GA25345@lst.de> <877da7rlzr.fsf@intel.com>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [PATCH 1/3] i915/gvt: Introduce the mmio_table.c to support VFIO new mdev API
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <164430744744.6827.16056768203919410118@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Tue, 08 Feb 2022 10:04:07 +0200
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jani Nikula (2022-02-07 12:48:08)
> On Mon, 07 Feb 2022, Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, Feb 07, 2022 at 08:28:13AM +0000, Wang, Zhi A wrote:
> >> 1) About having the mmio_table.h, I would like to keep the stuff in a
> >> dedicated header as putting them in intel_gvt.h might needs i915 guys
> >> to maintain it.
> >> 2) The other one is about if we should move the mmio_table.c into
> >> i915 folder. I guess we need the some comments from Jani. In the
> >> current version that I am testing, it's still in GVT folder. Guess we
> >> can submit a patch to move it to i915 folder later if Jani is ok
> >> about that.
> >
> > Yes, let's have Jani chime in on these.  They're basically one and the
> > same issue.  This code will have to be built into into the core i915
> > driver even with my planned split, which is kindof the point of this
> > exercise.  I think it makes sense to use the subdirectories as boundari=
es
> > for where the code ends up and not to declarare maintainership boundari=
es,
> > but it will be up to the i915 and gvt maintainers to decide that.
>=20
> Agreed. If there's going to be a gvt.ko, I think all of gvt/ should be
> part of that module, nothing more, nothing less.
>=20
> The gvt related files in i915/ should probably be named intel_gvt* or
> something, ditto for function naming, and we'll probably want patches
> touching them be Cc'd to intel-gfx list.
>=20
> Joonas, Rodrigo, Tvrtko, thoughts?

Agreed on above. I don't think we expect much changes on the golden MMIO
state capture set.

Regards, Joonas
