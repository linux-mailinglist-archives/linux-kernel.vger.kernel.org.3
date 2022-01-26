Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD8C49C640
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbiAZJYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiAZJYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:24:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73556C06161C;
        Wed, 26 Jan 2022 01:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12A9061634;
        Wed, 26 Jan 2022 09:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB0AC340E3;
        Wed, 26 Jan 2022 09:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643189072;
        bh=l20yKtsUSI4mgOKxddtDWngh/tY6qswigMDBeh4k7QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huGm3cxCLa63acaifTo51S3IsROUex9pnjol9oX92CRjE7kZvHxMGwFRftgDjcnYN
         JsZfEZu0UQJMvIeN8oWo6yBZ2FUfU0eqDiyYFXK0Wb/rQJjB5y7iRcYdOV/wbMBboK
         ZjIPczGSqhaShx6MC2Pvzn7E/jTA5j+zPgZ70Z16a2dINKYFVtB1lmLg10gRaSnCpZ
         GyS6IGj462U8GnyLqiyu94fPQRKfDqp4ZoNtrwkaf0Ybl4AFeWD4U4A6wMgmQiexiQ
         TjXmtDCtIeb1391Gs4ZV8s21abJEH613BhF6uTeyMkn6SqaeWTG7HQkDyD7qa6JNpg
         BSiBJYvCYSFFw==
Date:   Wed, 26 Jan 2022 17:24:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        y.bas@phytec.com
Subject: Re: [PATCH RESEND 1/2] ARM: dts: imx6: phyFLEX: add missing pmic mfd
 subdevices
Message-ID: <20220126092426.GJ4686@dragon>
References: <20211216115529.2331475-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216115529.2331475-1-andrej.picej@norik.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 12:55:28PM +0100, Andrej Picej wrote:
> phyFLEX PMIC DA9063 has also RTC and watchdog support. Add both
> mfd subdevices so they can be used.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> index f3236204cb5a..2ec154756bbc 100644
> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> @@ -205,6 +205,14 @@ vdd_mx6_high_reg: ldo11 {
>  				regulator-always-on;
>  			};
>  		};
> +
> +		pmic_rtc: rtc {

Maybe a more specific label like the following?

		da9063_rtc: rtc

And it's more aligned with da9063_wdog below.

> +			compatible = "dlg,da9063-rtc";
> +		};
> +
> +		da9063_wdog: wdt {

watchdog for the node name.

Shawn

> +			compatible = "dlg,da9063-watchdog";
> +		};
>  	};
>  };
>  
> -- 
> 2.25.1
> 
