Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A100B578FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiGSBf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGSBfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:35:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A065AC;
        Mon, 18 Jul 2022 18:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658194523; x=1689730523;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Daq2xXWkoDn5zcMm4IbkEQfZ0YPJ1v07/pppZb9gHPw=;
  b=FY7bCJTu0uVgH+DrVlBOuup531Up8IbqSPwzSuqYUD33oPj1EDiF+MAg
   5M2vh/nq5kJg69TbdksTah///IsewLGdkfbC12PHBHrPBMTsttx4ClMlr
   GgscoWSfbjf+JA+ncAUc2DO3amXYVJBdtZfqP5Mrm/uZF60sS5Yp5b34Q
   MHXBelk5No6QASlBlvWyMajo8woYc0of68UGrO2ApWMrrJ8JTI5ySlmDt
   DF98/kRtx7j9+Ziz3d+jxs+2cq0cKtAKuT7J5p1EixS2bpEkg1VtrZ+YG
   C27X/ANUxRmM3zleTiVGS4ReS7dkNDRzuxo2FL7Wjk17I1C2qCt7pQ8y6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="312045932"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="312045932"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:35:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="594657384"
Received: from dukechan-mobl.gar.corp.intel.com ([10.215.250.179])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:35:19 -0700
Message-ID: <70468d71603329d781f18380f0271699744c876f.camel@intel.com>
Subject: Re: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes
 for the trip points
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Jul 2022 09:35:21 +0800
In-Reply-To: <7ee301b76beb679f89e946dfb5921a2d853bd8dc.camel@intel.com>
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
         <20220715210911.714479-3-daniel.lezcano@linaro.org>
         <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
         <04bd27a8-5148-c8eb-5687-83ef511618df@linaro.org>
         <7ee301b76beb679f89e946dfb5921a2d853bd8dc.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-19 at 09:14 +0800, Zhang Rui wrote:
> On Mon, 2022-07-18 at 15:21 +0200, Daniel Lezcano wrote:
> >=20
> > Hi Zhang,
> >=20
> > thanks for the review
> >=20
> > On 18/07/2022 07:28, Zhang Rui wrote:
> > > On Fri, 2022-07-15 at 23:09 +0200, Daniel Lezcano wrote:
> >=20
> > [ ... ]
> >=20
> > > > Instead of taking the risk of breaking the existing platforms,
> > > > use an
> > > > array of temperature ordered trip identifiers and make it
> > > > available
> > > > for the code needing to browse the trip points in an ordered
> > > > way.
> > > >=20
> > > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > ---
> >=20
> > [ ... ]
> >=20
> > > > +static void sort_trips_indexes(struct thermal_zone_device *tz)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i, j;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < tz->tr=
ips; i++)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0tz->trips_indexes[i] =3D i;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < tz->tr=
ips; i++) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0for (j =3D i + 1; j < tz->trips; j++) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int=
 t1, t2;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tz-=
>ops->get_trip_temp(tz, tz-
> > > > > trips_indexes[i], &t1);
> > >=20
> > > This line can be moved to the upper loop.
> >=20
> > Right, thanks!
> >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tz-=
>ops->get_trip_temp(tz, tz-
> > > > > trips_indexes[j], &t2);
> > > > +
> > >=20
> > > what about the disabled trip points?
> > >=20
> > > we should ignore those trip points and check the return value to
> > > make
> > > sure we're comparing the valid trip_temp values.
> >=20
> > We don't have to care about, whatever the position, the
> > corresponding
> > trip id will be disabled by the trip init function before calling
> > this=20
> > one and ignored in the handle_thermal_trip() function
>=20
> hah, I missed this one and replied to your latest reply directly.
>=20
> The thing I'm concerning is that=C2=A0if we don't check the return value,
> for a disabled trip point, the trip_temp (t1/t2) returned is some
> random value, it all depends on the previous value set by last
> successful .get_trip_temp(),

or uninitialized value from the stack, but still random value every
time we invoke .get_trip_temp() for the same trip point.

-rui

>  and this may screw up the sorting.
>=20
> thanks,
> rui
> >=20
> >=20
>=20

