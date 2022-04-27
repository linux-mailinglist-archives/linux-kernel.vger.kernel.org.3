Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A9351124C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358741AbiD0HXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbiD0HXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:23:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1731CFF8;
        Wed, 27 Apr 2022 00:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651044006; x=1682580006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HwM8nfr+sAMSwiE6LUzMo0EfJPHJ3P1NXafGW7GSrxQ=;
  b=DmrU8RuuiubvlFFbd0Ht/w2YoM8lApLU41fHjTztvCiaSrHaR3GLpOAd
   AeAC8sqO2RdsAARMwUd+0TmRCClADA91tALmfXXGGATF9mQ6pfMVaq1ct
   tD9rmYlhsRwsFcWxfjeO4z4hyq95ooq9ZuX/o+TD7DB/1X90Nr57idwV+
   cjK+Y+2JQdqWBsL4JUoSYxvpZV1KXOTo0MNBt7YxPScQO08872wSebt63
   VIYWwbQSAtgZav/cQyjupOJs8RmLOM96Vx9zrbwGyakOwN8Ai4vHO+hp9
   gpEBl8F6RJRCrb8pbV/mFubnyA6kukbPiiRDd/+jr+qqaaL63B31598u1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="246409277"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="246409277"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="705422204"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Apr 2022 00:20:02 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Apr 2022 10:20:01 +0300
Date:   Wed, 27 Apr 2022 10:20:01 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] usb: core: acpi: Use the sysdev pointer instead
 of controller device
Message-ID: <YmjuofeN89UvqDMf@kuha.fi.intel.com>
References: <20220425121340.1362-1-heikki.krogerus@linux.intel.com>
 <20220425121340.1362-2-heikki.krogerus@linux.intel.com>
 <CAHp75Vdch3shuX6D6YU8=JrFLKq4h_WNYAQPd_bj-hmV6QoQkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdch3shuX6D6YU8=JrFLKq4h_WNYAQPd_bj-hmV6QoQkg@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:18:24PM +0200, Andy Shevchenko wrote:
> On Mon, Apr 25, 2022 at 3:41 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > The controller device (hcd) does not always have the ACPI
> > companion assigned to it at all. We can not rely on it when
> > finding the ACPI companion for the root hub. Instead we need
> > to use the sysdev pointer here.
> 
> ...
> 
> >         if (!udev->parent) {
> >                 /* root hub is only child (_ADR=0) under its parent, the HC */
> 
> I believe the comment can be amended now to point out that we use the
> physical device representing the parent of this child, and not
> (always) a direct parent of the device in terms of Linux device model.

Okay, I'll try to improve the comment.

> > -               adev = ACPI_COMPANION(udev->dev.parent);
> > +               adev = ACPI_COMPANION(udev->bus->sysdev);
> >                 return acpi_find_child_device(adev, 0, false);
> >         }

thanks,

-- 
heikki
