Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E34355F9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiF2IBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiF2IBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:01:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A4C3A180;
        Wed, 29 Jun 2022 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656489680; x=1688025680;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WHNxBwFyCDQy6cuNHc3PF7S5yF5y0JypR1dM+vNMif0=;
  b=RSFTrMHXi+wvh1QlAN10xG/rMSKHUkTGoFNKP3qPdtAEGe1Xi1rsp4qz
   k04Yginf2J3hRT4I10eDe4JvPrViWs/j0iZtl0sMEYQ/hz+3mUUM+x713
   6ucSz1pB45jDm1uMVcraZvy0pjX9kNvRwR530RCtm9xpiQ7XKg0Bb711d
   +oTM2A5rnI9GdUXPcJxBH6d/shsbF6uVYgqTYddC+K5JKH5BW7ySTaqqH
   E0YfcQRSTN/+2IBKnz3XQ8S8OKX9wwYNXlvoZL38zRFYLapoSLJkeF4An
   kPVm96k9dRWCP/6JurfYChZfEFW6mMslSBt8GlEco/4sJN9wNIPGHlBQ0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270722287"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="270722287"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 01:01:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="647279382"
Received: from dsummer-mobl.ger.corp.intel.com ([10.252.38.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 01:01:13 -0700
Date:   Wed, 29 Jun 2022 11:01:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, miquel.raynal@bootlin.com,
        phil.edworthy@renesas.com, kernel@esmil.dk,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] serial: 8250: dw: Fix NULL pointer dereference
In-Reply-To: <20220629000232.3440704-3-jeremy.linton@arm.com>
Message-ID: <f70f0a6-1023-6833-fe6c-e82ca8e418d3@linux.intel.com>
References: <20220629000232.3440704-1-jeremy.linton@arm.com> <20220629000232.3440704-3-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does cd16044d7c38 ("serial: 8250: dw: enable using pdata with ACPI") work 
for you? (Currently in tty-linus branch).

-- 
 i.


On Tue, 28 Jun 2022, Jeremy Linton wrote:

> Similarly to e6a08c6949cb, ACPI machines don't have
> a pdata setup, leading to a null pointer dereference
> when dw8250_handle_irq runs.
> 
> Fixes: aa63d786cea2 ("serial: 8250: dw: Add support for DMA flow controlling devices")
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 53e488beb8c2..06f80090cbb9 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -237,10 +237,13 @@ static int dw8250_handle_irq(struct uart_port *p)
>  	struct dw8250_data *d = to_dw8250_data(p->private_data);
>  	unsigned int iir = p->serial_in(p, UART_IIR);
>  	bool rx_timeout = (iir & 0x3f) == UART_IIR_RX_TIMEOUT;
> -	unsigned int quirks = d->pdata->quirks;
> +	unsigned int quirks = 0;
>  	unsigned int status;
>  	unsigned long flags;
>  
> +	if (d->pdata)
> +		quirks = d->pdata->quirks;
> +
>  	/*
>  	 * There are ways to get Designware-based UARTs into a state where
>  	 * they are asserting UART_IIR_RX_TIMEOUT but there is no actual
> 

