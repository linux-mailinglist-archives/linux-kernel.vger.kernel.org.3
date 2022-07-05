Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF85660A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiGEBUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiGEBUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:20:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881BD2DC;
        Mon,  4 Jul 2022 18:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656984043; x=1688520043;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nCiN/Jz7RaTKec/xvaYJ5gfSVdZpNNJhnyeiC7HP6/c=;
  b=nUmtNk1lrBhsAXHwmDjooJSTRIqU26zA/vQ2KUtNeACIf7JYOfFt84nb
   IKTWXpowIGBQV9wmwL7bhZKusqDTRs71sE1oOuTOfnlkFhvcUDDtlsx7o
   jn3/FwE38HvQY06zpPcqWfO/GNMEybCgMCt3268F4Dg1pKMcsZD421ZBn
   qxVvAtm9698q6eXGtqRGAj+unyV6O8xZ/Scil5mY9TWrr89ydYubEWP4d
   V7cx+pJD0BbDB6GeMTbQQaEDmC3ivth/tJrJoLhXWyyP8nuhRoSCMKcXp
   D2tP9E8Dlf4IeUFwmP+G15bATYFoydFU87x7F5P/QGll0FxuUNeZfmg5a
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="344900412"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="344900412"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 18:20:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="619565707"
Received: from shuangy2-mobl.ccr.corp.intel.com ([10.249.171.213])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 18:20:40 -0700
Message-ID: <0c525d16f34bedd1ea4ee4b7516c9dee5a92d419.camel@intel.com>
Subject: Re: [PATCH v3 11/12] thermal/of: Use thermal trips stored in the
 thermal zone
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>
Date:   Tue, 05 Jul 2022 09:20:38 +0800
In-Reply-To: <f16d855b-28b0-b4ee-0e42-7293d0e61c21@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
         <20220703183059.4133659-12-daniel.lezcano@linexp.org>
         <6c7e1865e7e68ac0f035680044eb878ced715a1b.camel@intel.com>
         <f16d855b-28b0-b4ee-0e42-7293d0e61c21@linexp.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-04 at 23:24 +0200, Daniel Lezcano wrote:
> On 04/07/2022 16:14, Zhang Rui wrote:
> > On Sun, 2022-07-03 at 20:30 +0200, Daniel Lezcano wrote:
> > > Now that we have the thermal trip stored in the thermal zone in a
> > > generic way, we can rely on them and remove one indirection we
> > > found
> > > in the thermal_of code and do one more step forward the removal
> > > of
> > > the
> > > duplicated structures.
> > > 
> > > Cc: Alexandre Bailon <abailon@baylibre.com>
> > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > Cc; Eduardo Valentin <eduval@amazon.com>
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> > > ---
> 
> [ ... ]
> 
> > >   EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
> > >   
> > > @@ -139,9 +134,7 @@ EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
> > >    */
> > >   bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
> > > int
> > > trip)
> > >   {
> > > -	struct __thermal_zone *data = tz->devdata;
> > > -
> > > -	if (!data || trip >= data->ntrips || trip < 0)
> > > +	if (trip >= tz->ntrips || trip < 0)
> > >   		return false;
> > >   
> > >   	return true;
> > > @@ -161,12 +154,7 @@ EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
> > >   const struct thermal_trip *
> > >   of_thermal_get_trip_points(struct thermal_zone_device *tz)
> > >   {
> > > -	struct __thermal_zone *data = tz->devdata;
> > > -
> > > -	if (!data)
> > > -		return NULL;
> > > -
> > > -	return data->trips;
> > > +	return tz->trips;
> > >   }
> > >   EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
> > 
> > what is the difference between
> > of_thermal_get_ntrips/of_thermal_get_trip_points and
> > thermal_zone_get_ntrips/thermal_zone_get_trips as introduced in
> > this
> > patch series?
> > 
> > we need to remove the duplications.
> 
> There is no difference between those functions. There are 34 more 
> patches in the pipe to be sent after this series to do more cleanups
> and 
> remove code duplication.
> 
Good to know.

It would be nice to have a cover letter to describe the whole picture,
including this patch series and the following patches in your queue.

thanks,
rui

