Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAFD599984
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347891AbiHSKCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347482AbiHSKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:02:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDE1F4CBA;
        Fri, 19 Aug 2022 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660903355; x=1692439355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E6FdEgHUmQc8Q5gyJFQn/n5xf7ASsR5QDlILY8+o774=;
  b=X/f4mOIgrXffXK2awkQvCkC4DSqBuCpbAq9Jkkmp5owOKcQiCSdo84BO
   WUnNVQu+FzQ71DPOpBjXvA+BtuoMbSrry6y+DE5c51wT3blUnLVghTuWs
   WqL68YU8A6JzJC5dvw6JKdh3EzFfP0VnI5xWJDkhoSRkqxLvSc8TSELQd
   cl8kpf5CT1Ux0xVrP3Mqc1f1vxGJrNTk307SiS7PZyrl1HRfl3eiQhWXy
   fabqnyQR7zQZzTmGeLeVpf047rq04KNL11G5Bh0dkvKVek4YqFbpvr2wN
   u5T/S+3+zzHX/5aLVsvpYuaI3lLINgT+lsZE7MGo2yof9+U1rCNZWx1GZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="294257210"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="294257210"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 03:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="750467167"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 19 Aug 2022 03:02:31 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 19 Aug 2022 13:02:30 +0300
Date:   Fri, 19 Aug 2022 13:02:30 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        rajmohan.mani@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/6] ACPI: New helper function
 acpi_dev_get_memory_resources() and a new ACPI ID
Message-ID: <Yv9ftg2MVx+okmzC@kuha.fi.intel.com>
References: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
 <Yv6PLl4aLPzHTJTQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv6PLl4aLPzHTJTQ@kroah.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 18, 2022 at 09:12:46PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 16, 2022 at 01:16:23PM +0300, Heikki Krogerus wrote:
> > Hi,
> > 
> > The helper function returns all memory resources described for a
> > device regardless of the ACPI descriptor type (as long as it's
> > memory), but the first patch introduces new ACPI ID for the IOM
> > controller on Intel Meteor Lake and also separately modifies the
> > driver so that it can get the memory resource from Address Space
> > Resource Descriptor.
> > 
> > An alternative would have been to introduce that helper function first
> > so we would not need to modify the driver when the new ID is added,
> > but then the helper would also need to be applied to the stable kernel
> > releases, and that does not feel necessary or appropriate in this
> > case, at least not IMO.
> > 
> > So that's why I'm proposing here that we first add the ID, and only
> > after that introduce the helper, and only for mainline. That way the
> > patch introducing the ID is the only that goes to the stable releases.
> > 
> > If that's okay, and these don't have any other problems, I assume it's
> > OK if Rafael takes all of these, including the ID?
> 
> I took the id now, for 6.0-final as it seems to be totally independant
> of the other commits (otherwise you would not have tagged it for the
> stable tree.)
> 
> The remainder should probably be resent and send through the acpi tree.

Okay. The last patch depends on that ID patch, so Rafael, you need to
handle that conflict with immutable branch I guess. Or should we just
skip that patch for now?

I think another way to handle this would be that Greg, you take the
whole series.

thanks,

-- 
heikki
