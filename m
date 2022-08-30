Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87D5A648D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiH3NUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiH3NUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:20:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B1223BEE;
        Tue, 30 Aug 2022 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661865595; x=1693401595;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/ijE9BGuWCakQ1nusZPEmzMxKtmth5A9VqsOhZVOJpM=;
  b=JFbT/thbs2ot8K62D2yNjQ+1STQQ1pVThRPmTkvw+PHBwt9tkmdTFc0+
   +TEt4I04BodsA+Xw3f2pdhzkwIuhGNtJ8mrHjIQk4eNqhLXMNRKiwRTA8
   RLpFCO3vNHwDnqwTkj3jTT1jxsQ4XjftIDvVUZ9abW4QOx6z/kNUcYC+u
   z1yiY63/WE5y6uVg0eDJTBYv7WbWsJbYMGTGX1nqT4N1GWt1Ctw3R0FdG
   z9Dpwp3wDp8pHzlK+xrhHB99AqDGJ9afMe0exKmPrimSGK3ACZSxnZGlO
   he+OOdIA5CAND1Rju2at9/BPOfvBGXindlT1x49HPRbWKBT9Lm3JOiOho
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="293915245"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="293915245"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:19:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="641370618"
Received: from arnesgom-mobl.ger.corp.intel.com ([10.252.54.235])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:19:41 -0700
Date:   Tue, 30 Aug 2022 16:19:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] serial: Add uart_xmit_advance() + fixes part (of
 a larger patch series)
In-Reply-To: <20220830131343.25968-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <c83d6b94-b589-ebbf-303f-1de084bc5676@linux.intel.com>
References: <20220830131343.25968-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-122507739-1661865583=:1864"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-122507739-1661865583=:1864
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 30 Aug 2022, Ilpo Järvinen wrote:

> Add uart_xmit_advance() helper to handle circular xmit buffer
> advancement + accounting of Tx'ed bytes. Use it to fix a few drivers
> that previously lacked to accounting for DMA Tx.
> 
> Greg,
> I've a another series on top this which is tty-next material making the
> rest of the drivers to use uart_xmit_advance(). That series obviously
> depends on the patch 1/3 of this series so if you end up putting these
> 3 patches into tty-linus, I'll need it to be merged into tty-next at
> some point (I'm not in a big hurry with this so if you choose to delay
> the merge, it's not a big deal).

This merge, btw, is no longer that important because I agreed with Jiri to 
wait for his tx loop rewrite series.

-- 
 i.

> v2:
> - Correct tags
> 
> Ilpo Järvinen (3):
>   serial: Create uart_xmit_advance()
>   serial: tegra: Use uart_xmit_advance(), fixes icount.tx accounting
>   serial: tegra-tcu: Use uart_xmit_advance(), fixes icount.tx accounting
> 
>  drivers/tty/serial/serial-tegra.c |  5 ++---
>  drivers/tty/serial/tegra-tcu.c    |  2 +-
>  include/linux/serial_core.h       | 17 +++++++++++++++++
>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> 
--8323329-122507739-1661865583=:1864--
