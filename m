Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3144F551186
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiFTHa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbiFTHa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:30:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4F6BF7B;
        Mon, 20 Jun 2022 00:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655710256; x=1687246256;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mhv8xk0rZVx/HkTij8ilPzWj/N5QCpIiNO5whtqVVio=;
  b=likvlEBqyaQATRtx9v/S/9mCwvG2HM/gzRfR7NJV9OD15CqMiH++IX6a
   8isEINrg5g4UXVtWqFJiAI5BddHy3pJWr7x2C5OSlKXd0GMQkvODgPtRl
   tvPCVIZOqybSATnHlRuBU4c3IZzOXErWFjSH16Wshyhsy2Vfu3IZG6RZ0
   HYJSigwE8Ay6XdyyLZdtEOcWlh3rHq87ro/QZC2hZBRJrh76lHs8Y7SCX
   eXUshQulAz7m4tWx5PTN0D2EhDlK21Ggk17u2RTk5GayLsJaS/rqv2Ef3
   +HENW7IGwxDT/x+O08+xfooZgFfggFheYo5utPCRQXMgIczH+xeRhD3Mm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259649705"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259649705"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:30:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642988988"
Received: from lspinell-mobl1.ger.corp.intel.com ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:30:43 -0700
Date:   Mon, 20 Jun 2022 10:30:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Marcin Wojtas <mw@semihalf.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>, miquel.raynal@bootlin.com,
        jaz@semihalf.com, upstream@semihalf.com
Subject: Re: [PATCH] serial: 8250: dw: enable using pdata with ACPI
In-Reply-To: <20220619074030.1154429-1-mw@semihalf.com>
Message-ID: <4dcc3bb4-ea76-527d-701b-289d1d24d73c@linux.intel.com>
References: <20220619074030.1154429-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-7461550-1655710245=:2433"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-7461550-1655710245=:2433
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sun, 19 Jun 2022, Marcin Wojtas wrote:

> Commit 3242fe805b52 ("serial: 8250: dw: Move the USR register to pdata")

That commit id is not correct, please fix.

Other than that,
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> caused NULL-pointer dereference when booting with ACPI by unconditional
> usage of the recently added pdata.
> 
> In order to fix that and prevent similar issues in future, hook the
> default version of this structure in dw8250_acpi_match table.
> 
> Fixes: 3242fe805b52 ("serial: 8250: dw: Move the USR register to pdata")
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 24 ++++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index f57bbd32ef11..3b79bd5c9c9d 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -773,18 +773,18 @@ static const struct of_device_id dw8250_of_match[] = {
>  MODULE_DEVICE_TABLE(of, dw8250_of_match);
>  
>  static const struct acpi_device_id dw8250_acpi_match[] = {
> -	{ "INT33C4", 0 },
> -	{ "INT33C5", 0 },
> -	{ "INT3434", 0 },
> -	{ "INT3435", 0 },
> -	{ "80860F0A", 0 },
> -	{ "8086228A", 0 },
> -	{ "APMC0D08", 0},
> -	{ "AMD0020", 0 },
> -	{ "AMDI0020", 0 },
> -	{ "AMDI0022", 0 },
> -	{ "BRCM2032", 0 },
> -	{ "HISI0031", 0 },
> +	{ "INT33C4", (kernel_ulong_t)&dw8250_dw_apb },
> +	{ "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
> +	{ "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
> +	{ "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
> +	{ "80860F0A", (kernel_ulong_t)&dw8250_dw_apb },
> +	{ "8086228A", (kernel_ulong_t)&dw8250_dw_apb },
> +	{ "APMC0D08", (kernel_ulong_t)&dw8250_dw_apb},
> +	{ "AMD0020", (kernel_ulong_t)&dw8250_dw_apb },
> +	{ "AMDI0020", (kernel_ulong_t)&dw8250_dw_apb },
> +	{ "AMDI0022", (kernel_ulong_t)&dw8250_dw_apb },
> +	{ "BRCM2032", (kernel_ulong_t)&dw8250_dw_apb },
> +	{ "HISI0031", (kernel_ulong_t)&dw8250_dw_apb },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
> 

-- 
 i.

--8323329-7461550-1655710245=:2433--
