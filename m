Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401DA5A43EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiH2HlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiH2HlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:41:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2909F4BD07;
        Mon, 29 Aug 2022 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661758876; x=1693294876;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fz7J/Y7mUf5DLvjGaLTmGi9JJkLfeFFeluiGCuYuXGA=;
  b=jHsXYnxdkYObW8blDzysE0Xrpe8ByozHoM/I3Qx1ZgWJ6u7NCo96CkDV
   nIWd5bxzIkF6htzixYrEYks4VWloGJdkPtRx4yZUu3tT37oGRSjStm7yW
   Gj5G4G4jL9pAhpFwtZUU3kBV9pKUQooN0Y+KWnQqVQEjCVgPq/tX00z+U
   PB+ny7izL/TIYMnATA9BxMFuh9zY0HPAb1LH+YeyEv93x3+m2McKm1O+3
   LPL8HOyhirIg3RnNOe7RQGHs0fk+7ql3c6OvLZESWuBGvgKRgz+rOzzMj
   G2CzSW3vCnrNOu7E0+zYznpNhP7pjnukZhRx5UUYcRVCBln7wyb6GZEzU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="295610894"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="295610894"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:41:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="640835783"
Received: from kvehmane-mobl1.ger.corp.intel.com ([10.251.220.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:41:13 -0700
Date:   Mon, 29 Aug 2022 10:41:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] serial: Add uart_xmit_advance() + fixes part (of a
 larger patch series)
In-Reply-To: <ac383256-65f2-e4ee-0142-65bdb9dd9dae@kernel.org>
Message-ID: <55cf3faf-2616-09c-57c3-35e7b11e55@linux.intel.com>
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com> <ac383256-65f2-e4ee-0142-65bdb9dd9dae@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2083064837-1661758877=:1928"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2083064837-1661758877=:1928
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 29 Aug 2022, Jiri Slaby wrote:

> On 25. 08. 22, 11:17, Ilpo Järvinen wrote:
> > Add uart_xmit_advance() helper to handle circular xmit buffer
> > advancement + accounting of Tx'ed bytes. Use it to fix a few drivers
> > that previously lacked to accounting for DMA Tx.
> > 
> > Greg,
> > I've a another series on top this which is tty-next material making the
> > rest of the drivers to use uart_xmit_advance(). That series obviously
> > depends on the patch 1/3 of this series so if you end up putting these
> > 3 patches into tty-linus, I'll need it to be merged into tty-next at
> > some point (I'm not in a big hurry with this so if you choose to delay
> > the merge, it's not a big deal).
> 
> Hi,
> could you hold off with the latter series? I'll send a v2 of TX path cleanup
> shortly. You'd then need to update much less places (if my series is
> accepted):
> https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=2d9ade0412f7e5edacc7f791ebbf773d6481b453
> https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=fd55062d74a8c137d30388c6e25ebd5c06a04517
> https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=a1df5129cc0cf174a8cd03e187c6a5e890d313e4
> 
> v1 was here (but was doing a call for every character):
> https://lore.kernel.org/all/20220411105405.9519-1-jslaby@suse.cz/

Sure, I can hold off a while (as long as we're speaking of reasonable 
timescales :-)). Looking into your patches, they also seemed to lack that 
icount.tx++ thing.

-- 
 i.

> > Ilpo Järvinen (3):
> >    serial: Create uart_xmit_advance()
> >    serial: tegra: Use uart_xmit_advance(), fixes icount.tx accounting
> >    serial: tegra-tcu: Use uart_xmit_advance(), fixes icount.tx accounting
> > 
> >   drivers/tty/serial/serial-tegra.c |  5 ++---
> >   drivers/tty/serial/tegra-tcu.c    |  2 +-
> >   include/linux/serial_core.h       | 17 +++++++++++++++++
> >   3 files changed, 20 insertions(+), 4 deletions(-)
> > 
> 
> thanks,
> 

--8323329-2083064837-1661758877=:1928--
