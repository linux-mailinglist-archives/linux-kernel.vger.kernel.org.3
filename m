Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8932153EA90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbiFFNmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiFFNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:42:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A825DC1;
        Mon,  6 Jun 2022 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654522926; x=1686058926;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TJzIGaY2NNdLCVpz1fV6eNpKvahRQfNMGYTni/eJge0=;
  b=dcxWDpT00prEt9NMDlhfXcOsWjZnT32NVaL/jCw3cQ9lqwqj5ioymtrb
   6cvNbDvrivyvclkAOM8if3adI8/1Yi0ct7GwPeGZYr0R+6JP998EuyPvY
   HENV3RhXiD46GhRHq+0JoRVPWdig5h3XT0VpAS03ZPfp66yloR3RnKQiO
   7m2GwLukbK1xgMtG9bIOFlty7kpQXxLL0h/OVhRA3YnEeu4k+5XF7qQwf
   U+bWh4nxGtLI5Vbgb4QtjIuwLngcywZXsrVMwHkAo7vZxyV2PZqAG0a/V
   eKtF/Rytl5g1hTVsUWLodpGK7YsBJMuWtPySecUrSh0tAL9t6/KImpXxb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="264594191"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="264594191"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:42:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635605053"
Received: from amkossek-mobl1.ger.corp.intel.com ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 06:42:01 -0700
Date:   Mon, 6 Jun 2022 16:41:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/6] serial: 8250: Store to lsr_save_flags after lsr
 read
In-Reply-To: <20220606131124.53394-2-ilpo.jarvinen@linux.intel.com>
Message-ID: <fb32bda5-ea44-da8d-493a-a043b8619022@linux.intel.com>
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com> <20220606131124.53394-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1584012708-1654522922=:1547"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1584012708-1654522922=:1547
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 6 Jun 2022, Ilpo Järvinen wrote:

> Not all LSR register flags are preserved across reads. Therefore, LSR
> readers must store the non-preserved bits into lsr_save_flags.
> 
> This fix was initially mixed into feature commit f6f586102add ("serial:
> 8250: Handle UART without interrupt on TEMT using em485"). However,
> that feature change had a flaw and it was reverted to make room for
> simpler approach providing the same feature. The embedded fix got
> reverted with the feature change.
> 
> Re-add the lsr_save_flags fix and properly mark it's a fix.
> 
> Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
> Link: https://lore.kernel.org/all/1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com/T/#m1737eef986bd20cf19593e344cebd7b0244945fc
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@penugtronix.de>

It seems that Uwe managed to mistype his email for the A-by which I just 
happily copy-pasted.

Greg, please let me know if you want me to resend the series (or if you 
will just change it on the fly while applying).

-- 
 i.

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 4998799abae2..c5e0f925f4b6 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1511,6 +1511,8 @@ static inline void __stop_tx(struct uart_8250_port *p)
>  		unsigned char lsr = serial_in(p, UART_LSR);
>  		u64 stop_delay = 0;
>  
> +		p->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
> +
>  		if (!(lsr & UART_LSR_THRE))
>  			return;
>  		/*
> 

--8323329-1584012708-1654522922=:1547--
