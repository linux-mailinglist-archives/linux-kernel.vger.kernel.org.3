Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2146D54816C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbiFMIYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbiFMIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:24:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695031A391;
        Mon, 13 Jun 2022 01:24:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F7336119E;
        Mon, 13 Jun 2022 08:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A91C3411F;
        Mon, 13 Jun 2022 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655108666;
        bh=IZZImem7yP8mew285Mm9kWxGAoTV5+jeTPIc7Odvr44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DICSzJqenxSiiW540Lw5yHKekG3GuL386/sspERbKPvfIBMWnsKiOXKZAF2YDbSxt
         e0MjNmvVPNII0JLTlh+wnocWEcSDow9fTRQO3MjmGGUKi57YefRsBFkx6GZOxyXylC
         sWQav6po5GtidTN8kbUytP1wKTir94kbLcls54lcZLdhGTJ8Pc/CX9tNpIHIxeCTSP
         eVatICn5ktd0mA1/TAOESOM0ih5M05em+K3gUZ3XzhyNcPYC5t4bZPgn8xPcMTpsOS
         TZQE5ihbtd8B7lKm6ikGO6duHuVWYDJV0EapQFfLaugsrYvQ+dc1eSR+RUgLd1YNhP
         ijezXfcCQ8C0w==
Received: by pali.im (Postfix)
        id 99B5CB57; Mon, 13 Jun 2022 10:24:23 +0200 (CEST)
Date:   Mon, 13 Jun 2022 10:24:23 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell G5 5590 to DMI table
Message-ID: <20220613082423.bs7r2iz7rjklxcnb@pali>
References: <20220612232208.27901-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220612232208.27901-1-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2022 01:22:08 Armin Wolf wrote:
> According to Bug 215983 at bugzilla.kernel.org,
> the Dell G5 5590 supports the SMM interface and
> can thus be loaded with ignore_dmi being set.
> Add the model the DMI table to allow for
> automatic loadig on this model.
> 
> Compile-tested only.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 16c10ac84a91..d419885dd771 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1131,6 +1131,13 @@ static const struct i8k_config_data i8k_config_data[] __initconst = {
>  };
> 
>  static const struct dmi_system_id i8k_dmi_table[] __initconst = {
> +	{
> +		.ident = "Dell G5 5590",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G5 5590"),
> +		},
> +	},
>  	{
>  		.ident = "Dell Inspiron",
>  		.matches = {
> --
> 2.30.2
> 
