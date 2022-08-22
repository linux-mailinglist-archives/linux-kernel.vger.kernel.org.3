Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D670B59BC9E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiHVJTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiHVJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:18:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52BAB49F;
        Mon, 22 Aug 2022 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661159927; x=1692695927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PODeVLuIX9g0BxkQuwOWxZfhH1PA5lu7oTDDA6VcGDY=;
  b=c28ifSh33/npFdtCxASSDUnnvKUIOOKZZCyhPFV+cFgxC0Fn9PJr7sLK
   l9fTRE/jhAECfsHAKyK/KzgaDdES+Kw8AAoEpgnvxJKtxNK50mmjIEQoB
   Uyobwd/vKehQDrHlA8Dx0tY7ybChLDJQmdfYGCGnZelQ8Vb4Ae3T1SSo9
   qP8qT/h3ItO+F60WM5ebVJAmyIkTQXBW9EblXTjkcD+JJCOdJ+fCbYBrV
   mfgWWt3HEXsvAlQbpg1EUd1oSUBo+I+4S0E2+uzwMRyAj9TwQ6HY953M8
   4DMBRpdGcGRJdzDlxR+usJfj9uKCZskiid9IjKRxBUq9UOuMimsUp3S8p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="355097453"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="355097453"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 02:18:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="641961795"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 02:18:43 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 77AA020656;
        Mon, 22 Aug 2022 12:18:41 +0300 (EEST)
Date:   Mon, 22 Aug 2022 09:18:41 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] media: mt9m111: fix device power usage
Message-ID: <YwNJ8RpSR+oVxnS/@paasikivi.fi.intel.com>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-3-m.felsch@pengutronix.de>
 <YwMix1+Bm1jEbWqv@paasikivi.fi.intel.com>
 <20220822075426.qjgxue7sjehazga4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822075426.qjgxue7sjehazga4@pengutronix.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 09:54:26AM +0200, Marco Felsch wrote:
> Hi Sakari,
> 
> On 22-08-22, Sakari Ailus wrote:
> > Hi Marco,
> > 
> > On Thu, Aug 18, 2022 at 04:47:11PM +0200, Marco Felsch wrote:
> > > Currently the driver turn off the power after probe and toggle it during
> > > .stream by using the .s_power callback. This is problematic since other
> > > callbacks like .set_fmt accessing the hardware as well which will fail.
> > > So in the end the default format is the only supported format.
> > 
> > It'd be much better to add runtime PM support to the driver instead.
> 
> I got your point, but didn't have the time for it right now, I will drop
> the patch from my v2.

The API is different but generally involves doing more or less the same
what this and the 4th patch do together.

-- 
Sakari Ailus
