Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDC3578F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiGSBPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGSBO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:14:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C1033E35;
        Mon, 18 Jul 2022 18:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658193297; x=1689729297;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vRLzmrrgm4kudf5+Ad7ww1gLuHUCo1/2XwRDw73KWgg=;
  b=KCZSY2Qb3s1uVc9mAeRyf/CKtFwzC7E70g1q1zIZEseIiHZ+EIGmOYWr
   wPfwF35GMPhN6a/Zmnvf/u+80FVs6Ia4T9reWyxh2oVQtkO1x6VLZzbjJ
   oqyBUdFV7xnCwjptt4b54CCwSfIAuF85OC6+R96lPWDEi3FMTvtYFVV9C
   4LSVNGw9++shZ9sSiyACVNGp0qZJ5xzJoN8KamK3dZ9w9n7oDK+HaUgtZ
   YUp0f8hvUOXMmaYf+dKeFqv1new/dUJH9DSw4087wU9NNVbBA+vTPfYS4
   HSGgbsXd3D72m0j579K2+XKFd33cIEX6yCo44UDcgm2UcRIFelcACXaK2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="372662843"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="372662843"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:14:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="739673156"
Received: from dukechan-mobl.gar.corp.intel.com ([10.215.250.179])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:14:54 -0700
Message-ID: <7ee301b76beb679f89e946dfb5921a2d853bd8dc.camel@intel.com>
Subject: Re: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes
 for the trip points
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Jul 2022 09:14:55 +0800
In-Reply-To: <04bd27a8-5148-c8eb-5687-83ef511618df@linaro.org>
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
         <20220715210911.714479-3-daniel.lezcano@linaro.org>
         <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
         <04bd27a8-5148-c8eb-5687-83ef511618df@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-18 at 15:21 +0200, Daniel Lezcano wrote:
>=20
> Hi Zhang,
>=20
> thanks for the review
>=20
> On 18/07/2022 07:28, Zhang Rui wrote:
> > On Fri, 2022-07-15 at 23:09 +0200, Daniel Lezcano wrote:
>=20
> [ ... ]
>=20
> > > Instead of taking the risk of breaking the existing platforms,
> > > use an
> > > array of temperature ordered trip identifiers and make it
> > > available
> > > for the code needing to browse the trip points in an ordered way.
> > >=20
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > ---
>=20
> [ ... ]
>=20
> > > +static void sort_trips_indexes(struct thermal_zone_device *tz)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i, j;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < tz->trip=
s; i++)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0tz->trips_indexes[i] =3D i;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < tz->trip=
s; i++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0for (j =3D i + 1; j < tz->trips; j++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int=
 t1, t2;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tz-=
>ops->get_trip_temp(tz, tz-
> > > > trips_indexes[i], &t1);
> >=20
> > This line can be moved to the upper loop.
>=20
> Right, thanks!
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tz-=
>ops->get_trip_temp(tz, tz-
> > > > trips_indexes[j], &t2);
> > > +
> >=20
> > what about the disabled trip points?
> >=20
> > we should ignore those trip points and check the return value to
> > make
> > sure we're comparing the valid trip_temp values.
>=20
> We don't have to care about, whatever the position, the corresponding
> trip id will be disabled by the trip init function before calling
> this=20
> one and ignored in the handle_thermal_trip() function

hah, I missed this one and replied to your latest reply directly.

The thing I'm concerning is that=C2=A0if we don't check the return value,
for a disabled trip point, the trip_temp (t1/t2) returned is some
random value, it all depends on the previous value set by last
successful .get_trip_temp(), and this may screw up the sorting.

thanks,
rui
>=20
>=20

