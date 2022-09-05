Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8935AD6A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbiIEPev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbiIEPen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:34:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AC313E87;
        Mon,  5 Sep 2022 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662392082; x=1693928082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xyfIktsZgiPCthxn1bCTekhDbusq67xgMuCvjpVPHQY=;
  b=RmzSd5OOZh+Ogc31OtcNd+d7pgxIwFlFSDPNSRk7wRGipvQp2w2/DGIy
   g7bX945bgcvECwpaNLJy3XPANa6BSUmYNhR6nYYA3leIMa9nxn8nWdVVQ
   5UK3QF1vOIBDB4nO1sTdlwA/DV6n1vjbmwSQUfkIQKxUFb1t+itzKLouu
   g/T7dpBWmW49RTossUjJNErMMDZlNBF15honO78hWOOS/ttWiNZxj78Zu
   Bi4eGrR4eZNZ1xDwkQw24KxWj5PnMyTxI4MmgATwtBYwU3yE/82oYHrTr
   CYK0qDqoz5Og+kZEL3Qw7oou6Pig2BTF5cBxSHdZasIFooITt64biWVKC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="382710231"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="382710231"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 08:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="756075896"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Sep 2022 08:34:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9AD3014F; Mon,  5 Sep 2022 18:34:55 +0300 (EEST)
Date:   Mon, 5 Sep 2022 18:34:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, sanju.mehta@amd.com,
        mario.limonciello@amd.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
 on AMD USB4 controller
Message-ID: <YxYXH5dqKqPANeVX@black.fi.intel.com>
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWgGKIAvsxwSz85@black.fi.intel.com>
 <CAAd53p4iV=ne5bDGZ6FxE9bBUVoFh=eXF9_oMPvPzjVj=UVoog@mail.gmail.com>
 <YxWqSYDWe0NitSkL@black.fi.intel.com>
 <CAAd53p6bSmTPavjA0v6tybc6=HrwiDn0JGzXwVOG_m5EVw1p1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6bSmTPavjA0v6tybc6=HrwiDn0JGzXwVOG_m5EVw1p1w@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 11:21:36PM +0800, Kai-Heng Feng wrote:
> > Hmm, so you see the actual hotplug but the tunneled PCIe link may not be
> > detected? Does the PCIe "Card Present" (or Data Link Layer Active)
> > status change at all or is it always 0?
> 
> It changes only after tb_switch_add() is called.

I doubt tb_switch_add() does anything but instead it is the established
PCIe tunnel that then shows up as it toggles the Card Present bit or so.
But that should also trigger PME if the root port is in D3 so you should
see this wake if everything works accordingly (unless I'm missing
something).

So if you do this:

1. Boot the system up, nothing connected
2. Plug in the TBT/USB4 device but do not authorize the PCIe tunnel
3. Wait for the TBT/USB4 domain to enter sleep (runtime suspend)
4. Authorize the PCIe tunnel

  # echo 1 > .../authorized

The established PCIe tunnel should trigger PME and the root port then
should be able to detect the PCIe link. Can you add full dmesg with
"thunderbolt.dyndbg=+p" in the command line to the bug?
