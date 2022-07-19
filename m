Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D3C57A183
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiGSOaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239546AbiGSO3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:29:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD125FACE;
        Tue, 19 Jul 2022 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658240241; x=1689776241;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6PAXqYH/NtVLRyLe2sv7ux6nLdISex8fMwmJ79lrbUo=;
  b=nncN1c8oYkRD3wkpyhekzipqYeQ7eh1QmHx5hlbIzDm/m/XjhWp+bQdX
   tPwwIcGyzMl+JPadr6F9V+85G7NxEJbJ3fLE8hyldMARuGNY5EnuyYEO4
   E30hISSnK5MOI3C1k3H2YwjthTFPyXoOqMJMigkVgPp4AMFTgdm2JQ+OJ
   YOUi+RzTfSQ3XHWACwb5F6bSipUS95hMv8idGvTIJG0ZCBv1904UMkxYC
   TR7NR0IJqTLUdLe5k8iFb7Rx0e1uapj+PPCY5GxgA1p7eH3yigjx69pqX
   1Uf7HNBqBQBBiKhqoyceAL/4X84W92cJ4Jjdtsfy1HqIdty87L+XD2yfs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="287247085"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="287247085"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:17:21 -0700
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="630344929"
Received: from dukechan-mobl.gar.corp.intel.com ([10.215.250.179])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:17:17 -0700
Message-ID: <e3bfb483aa6ce09756b38b3a568fac819b154beb.camel@intel.com>
Subject: Re: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes
 for the trip points
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Jul 2022 22:17:20 +0800
In-Reply-To: <c0d3e523-d75a-d837-313f-bf46f3fab3b4@linaro.org>
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
         <20220715210911.714479-3-daniel.lezcano@linaro.org>
         <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
         <04bd27a8-5148-c8eb-5687-83ef511618df@linaro.org>
         <7ee301b76beb679f89e946dfb5921a2d853bd8dc.camel@intel.com>
         <c0d3e523-d75a-d837-313f-bf46f3fab3b4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-19 at 09:22 +0200, Daniel Lezcano wrote:
> On 19/07/2022 03:14, Zhang Rui wrote:
> > On Mon, 2022-07-18 at 15:21 +0200, Daniel Lezcano wrote:
> > >=20
> > > Hi Zhang,
> > >=20
> > > thanks for the review
> > >=20
> > > On 18/07/2022 07:28, Zhang Rui wrote:
> > > > On Fri, 2022-07-15 at 23:09 +0200, Daniel Lezcano wrote:
> > >=20
> > > [ ... ]
> > >=20
> > > > > Instead of taking the risk of breaking the existing
> > > > > platforms,
> > > > > use an
> > > > > array of temperature ordered trip identifiers and make it
> > > > > available
> > > > > for the code needing to browse the trip points in an ordered
> > > > > way.
> > > > >=20
> > > > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > > ---
> > >=20
> > > [ ... ]
> > >=20
> > > > > +static void sort_trips_indexes(struct thermal_zone_device
> > > > > *tz)
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i, j;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < tz->=
trips; i++)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0tz->trips_indexes[i] =3D i;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < tz->=
trips; i++) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0for (j =3D i + 1; j < tz->trips; j++) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
int t1, t2;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
tz->ops->get_trip_temp(tz, tz-
> > > > > > trips_indexes[i], &t1);
> > > >=20
> > > > This line can be moved to the upper loop.
> > >=20
> > > Right, thanks!
> > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
tz->ops->get_trip_temp(tz, tz-
> > > > > > trips_indexes[j], &t2);
> > > > > +
> > > >=20
> > > > what about the disabled trip points?
> > > >=20
> > > > we should ignore those trip points and check the return value
> > > > to
> > > > make
> > > > sure we're comparing the valid trip_temp values.
> > >=20
> > > We don't have to care about, whatever the position, the
> > > corresponding
> > > trip id will be disabled by the trip init function before calling
> > > this
> > > one and ignored in the handle_thermal_trip() function
> >=20
> > hah, I missed this one and replied to your latest reply directly.
> >=20
> > The thing I'm concerning is that=C2=A0if we don't check the return
> > value,
> > for a disabled trip point, the trip_temp (t1/t2) returned is some
> > random value, it all depends on the previous value set by last
> > successful .get_trip_temp(), and this may screw up the sorting.
>=20
> The indexes array is the same size as the trip array, that makes the=20
> code much less prone to errors.
>=20
> To have the same number of trip points, the index of the disabled
> trip=20
> must be inserted also in the array. We don't care about its position
> in=20
> the indexes array because it is discarded in the handle_trip_point()=20
> function anyway. For this reason, the random temperature of the
> disabled=20
> trip point and the resulting position in the sorting is harmless.
>=20
> It is made on purpose to ignore the return value, so we have a
> simpler code.
>=20
Let's take below case for example,
say, we have three trip points 0, 1, 2, and trip point 1 is broken and
disabled.

trip temp for trip point 0 is 10 and for trip point 2 is 20.
.get_trip_temp(tz, 1, &t) fails, and t is an uninitialized random value


Initial:
   trip_indexes[0]=3D0,trip_indexes[1]=3D1,trip_indexes[2]=3D2
step1:
   i=3D0,j=3D1
   get trip temp for trip point trip_indexes[0]=3D0 and trip_indexes[1]=3D1
   trip point 1 returns trip temp 5, and it swaps with trip point 0
   so
   trip_indexes[0]=3D1,trip_indexes[1]=3D0,trip_indexes[2]=3D2
step2:
   i=3D0,j=3D2
   get trip temp for trip point trip_indexes[0]=3D1 and trip_indexes[2]=3D2
   trip point 1 returns trip temp 25, and it swaps with trip point 2
   so
   trip_indexes[0]=3D2,trip_indexes[1]=3D0,trip_indexes[2]=3D1

And the sorting is broken now.

please correct me if I'm missing anything.

thanks,
rui
