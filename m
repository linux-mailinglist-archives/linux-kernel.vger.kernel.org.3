Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F70588FEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbiHCP5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiHCP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:57:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2465FBB;
        Wed,  3 Aug 2022 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659542268; x=1691078268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mOIJWP9CHMh9BXUsNu+7KhdpzZU4fbVzJUvkLwDE/es=;
  b=QbLDW4YmZiS65dZx1CEWrJvy79Ep5fHw6NRbMfoKG2x7kGTK7/BY9h6x
   4wOzSyXCu4Yttk7YXpHABiHcQeP1ccKivAF9ajUtM2IAtaDeFTXQqgZH9
   3G6wg+5dsLfVYjJk1XM6SgU1owwjSHYty/DBhKZWt1AZSAkz5zpq3cfPY
   PVSoQEhX5Kq6cih3ZnGk99CaHgS9i/QXq2WdNN/zyAW1JpakaRN4jV7uf
   aFGnNS31xAV0B5CN4q1WsBUKqH1PnqzwXMc3z6uCwp9Rlg7YZ1X1RDt/B
   aie24LNOk7vE8wdI3IBU83h0SnFW7qr2Etc8hZPH6p0CNzWYWcVsaoWvM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="287270048"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="287270048"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 08:57:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="729250577"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 08:57:44 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Aug 2022 18:57:42 +0300
Date:   Wed, 3 Aug 2022 18:57:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Benson Leung <bleung@google.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@intel.com>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmalani@google.com
Subject: Re: [PATCH] Supporting wake on DP hot events behind TBT/USB4 routers
Message-ID: <Yuqa9vjEBjWAMyf9@lahna>
References: <20220803010139.GA32634@rajth-NUC10i7FNH>
 <YuoJceCfuJ4RKon5@lahna>
 <CANLzEkucqXP6fU1OZ0+B4p10SXiR7-BJa+dn5xjp20UhE8UsEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLzEkucqXP6fU1OZ0+B4p10SXiR7-BJa+dn5xjp20UhE8UsEg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

On Wed, Aug 03, 2022 at 08:15:49AM -0700, Benson Leung wrote:
> Hi Mika,
> 
> On Tue, Aug 2, 2022 at 10:37 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Wed, Aug 03, 2022 at 06:31:39AM +0530, Rajat Khandelwal wrote:
> > > Current implementation doesn't allow user to go into system suspend
> > > and simultaneously project the screen on an external display connected
> > > to a TBT/USB4 device. This patch enables this feature.
> > >
> > > Let me know what you think about this.
> >
> > Please prefix patches to follow the sybsystem style. For Thunderbolt it
> > should be "thunderbolt: ....".
> >
> > This will cause any monitor plug to wake up the system and I'm not sure
> > we want that, at least to be default behaviour. If you have a regular
> > Type-C (non-USB4/TBT) dock and you plug in a monitor to that, does it
> > wake up?
> 
> Speaking for Google and our ChromeOS USB-C policy, yes, if the host is
> in S0iX or S3, an already attached USB-C docking station in DP Alt
> Mode will respond to a display attach via HPD via an Alert message in
> USB PD. We called this feature wake-on-dock.
> 
> We implemented wake-on-dock for DP Alt Mode in the EC, since our EC
> handles USB PD anyway, and is handling the PD Alert message which
> contains the HPD status.
> 
> However, when the dock supports USB4 or Thunderbolt, those modes don't
> involve USB PD for device attach, so our EC doesn't have the role of
> waking the system, so something else on the system must, which is this
> feature being discussed.

Okay understood. Thanks for explaining!
