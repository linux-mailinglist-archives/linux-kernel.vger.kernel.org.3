Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39B5A99E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiIAOQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiIAOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:16:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732716053B;
        Thu,  1 Sep 2022 07:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662041717; x=1693577717;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=05RL3g8OWmDmgUcrIsAA0vVdIFlqQrXnm5dJQvoz/cs=;
  b=KYg4lKKonbaa5DZGikT956NwJgepJsPaUSi9zIMKMF9QRlUTzYmo5+s7
   JrrkRGzKsiinjRzjbbLBwKTlKt58g9fuedNb5uIX9SDXImBq2sblq/PBB
   03m3Mcurotmb3HZCJF9HLXTjWsZyJlMbokjbRMHX4YTPjTAp6cVl2zrkY
   GON6/nWUFLqE4cEjoti4IJPIph6zd/28yVYZysR4xPmQkXHPUvj3IYjOW
   FOuF42JM2Da36S2btdP4D1Gy+AL79orM+08rzhUNKwbPi5fwp+hEwuphK
   7RZ7RxswTI5ljXQUibun1HR47vlg6ZpqXCkqiM/PbH337VOS8jV1t7Hdf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="321874069"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="321874069"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 07:15:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="673864317"
Received: from rmalliu-mobl.amr.corp.intel.com ([10.249.44.65])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 07:15:13 -0700
Date:   Thu, 1 Sep 2022 17:15:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] serial: Add uart_xmit_advance() + fixes part (of
 a larger patch series)
In-Reply-To: <YxC66RkxUSVJxWRe@kroah.com>
Message-ID: <30e3b86f-c349-d2b7-d6d3-aeec24efb4f5@linux.intel.com>
References: <20220830131343.25968-1-ilpo.jarvinen@linux.intel.com> <c83d6b94-b589-ebbf-303f-1de084bc5676@linux.intel.com> <YxC66RkxUSVJxWRe@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1306882037-1662041286=:1599"
Content-ID: <5f85378f-68f0-fe2b-39d1-e2fa490fbc8@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1306882037-1662041286=:1599
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <7fb0bdb7-c439-acf5-14fb-d1d7b56f414@linux.intel.com>

On Thu, 1 Sep 2022, Greg Kroah-Hartman wrote:

> On Tue, Aug 30, 2022 at 04:19:40PM +0300, Ilpo Järvinen wrote:
> > On Tue, 30 Aug 2022, Ilpo Järvinen wrote:
> > 
> > > Add uart_xmit_advance() helper to handle circular xmit buffer
> > > advancement + accounting of Tx'ed bytes. Use it to fix a few drivers
> > > that previously lacked to accounting for DMA Tx.
> > > 
> > > Greg,
> > > I've a another series on top this which is tty-next material making the
> > > rest of the drivers to use uart_xmit_advance(). That series obviously
> > > depends on the patch 1/3 of this series so if you end up putting these
> > > 3 patches into tty-linus, I'll need it to be merged into tty-next at
> > > some point (I'm not in a big hurry with this so if you choose to delay
> > > the merge, it's not a big deal).
> > 
> > This merge, btw, is no longer that important because I agreed with Jiri to 
> > wait for his tx loop rewrite series.
> 
> Ok, I'll drop this series for now.

It's not what I meant.

I've a follow-up series on top of this which depeds on uart_xmit_advance() 
being available (thus I'd have need it in tty-next). However, now I'm 
postponing the follow-up series while Jiri sorts out the tx loops.

This first part of the series and Jiri's tx loop series don't even touch 
the same files.

I guess I should resend these if you dropped these from your queue?


-- 
 i.
--8323329-1306882037-1662041286=:1599--
