Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74144578F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiGSBBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGSBBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:01:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BCD60C3;
        Mon, 18 Jul 2022 18:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658192465; x=1689728465;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=f+oKCtf+9sEtPh+Jltu2AvrlNVaO3l9GNvtGWODslRg=;
  b=IT3Cn5+pXKtFTZAXvLe4q06JtwwyTqhqqralycGTXuqL7SGdtLno6tv0
   HIbDiNIQOCPf5cpsYxXUlQ8VKeyneX4h4cJXCwTVI1M7D1O3y2wud8+0/
   jgdexvF/ELhnzzHsQnb12HmIyYaIWesG118IIlioIFHenlLh5lgldt+x4
   DNL1745eptAL7WNaqQtPcrQaCV+klKhfIGx5fc/lsRSxXqDA1ffiW15y0
   7xlbDphYhosZwMWjEiK11uqFPzVsGF3XvipzsTfZV249mn7KW2nE825mn
   24PRkPqHZ/L73MY3naHEvW+pQHMSFmiDVklUE9ilx/VqAza752kG/TWvM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="350320153"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="350320153"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:01:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="724066804"
Received: from dukechan-mobl.gar.corp.intel.com ([10.215.250.179])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:01:01 -0700
Message-ID: <4063f7c1933c02f3681832f522a41e1bb5229f41.camel@intel.com>
Subject: Re: [PATCH v3 2/4] thermal/core: Avoid calling ->get_trip_temp()
 unnecessarily
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Jul 2022 09:01:03 +0800
In-Reply-To: <70a992e3-bf1c-0c33-c122-3c4730ffb232@linaro.org>
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
         <20220715210911.714479-2-daniel.lezcano@linaro.org>
         <aeb6a9d2447a8bbd7d386f88a7f72b33253776c7.camel@intel.com>
         <70a992e3-bf1c-0c33-c122-3c4730ffb232@linaro.org>
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

On Mon, 2022-07-18 at 16:04 +0200, Daniel Lezcano wrote:
> On 18/07/2022 06:59, Zhang Rui wrote:
> > On Fri, 2022-07-15 at 23:09 +0200, Daniel Lezcano wrote:
> > > As the trip temperature is already available when calling the
> > > function
> > > handle_critical_trips(), pass it as a parameter instead of having
> > > this
> > > function calling the ops again to retrieve the same data.
> > >=20
> > > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > ---
> > > =C2=A0=C2=A0 v3:
> > > =C2=A0=C2=A0=C2=A0 - Massaged the patch title and the description
> > > ---
> > > =C2=A0=C2=A0drivers/thermal/thermal_core.c | 8 ++------
> > > =C2=A0=C2=A01 file changed, 2 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/thermal/thermal_core.c
> > > b/drivers/thermal/thermal_core.c
> > > index d9f771b15ed8..f66036b3daae 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -340,12 +340,8 @@ void thermal_zone_device_critical(struct
> > > thermal_zone_device *tz)
> > > =C2=A0=C2=A0EXPORT_SYMBOL(thermal_zone_device_critical);
> > > =C2=A0=20
> > > =C2=A0=C2=A0static void handle_critical_trips(struct thermal_zone_dev=
ice
> > > *tz,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int trip, enum
> > > thermal_trip_type
> > > trip_type)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int trip, int trip_temp=
, enum
> > > thermal_trip_type trip_type)
> >=20
> > This indent cleanup belongs to patch 1/4.
>=20
> It is not an indent cleanup, the 'int trip_temp' is added in the
> parameters.

Sorry, I meant the indent cleanup in Patch 3/4 can be moved to 2/4.

thanks,
rui
>=20
> > Other than that,
> >=20
> > Reviewed-by: Zhang Rui <rui.zhang@intel.com>
>=20
> [ ... ]
>=20
>=20

