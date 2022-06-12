Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5BB547946
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 10:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiFLI0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 04:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiFLI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 04:26:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEB3193CD;
        Sun, 12 Jun 2022 01:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F44FB80B9D;
        Sun, 12 Jun 2022 08:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4A2C34115;
        Sun, 12 Jun 2022 08:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655022377;
        bh=14mzqdFI7iJLi1HTR4d5kl7ygjqohZQNeOJ6BSWdimw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VyH73/008+5LxB9Ogx25+1icpnsDGptkrbn2wN1IgxFeB18V8kkbnLsoNXfQ7t0N/
         om3Njs14Jdispru2ljdbS8I0ZvbQ1mpHdyN4yJqFjVXPVRZruAYIvU/2QG8oLHqBRp
         G0lJ4Uv4sQqu1ZGUnhJKfhOyxWQSnSQGZRdh2ZxmLgRFAZG7HVkHaWo/NsWSBhdtdi
         kEdvwtzC0dZhe4b0eius39heRY5Y5AoAc0HvyHx1Dy76zdi9bm0RYIi3t0tzDaQs+I
         sNnoCJ1o+sCBqRQNktEWnWpXoOq5w4Jdun4IDlXzWZaZjj0aj91dtBKaDCFaHPMA8i
         +89xFu5KOQ9rQ==
Received: by pali.im (Postfix)
        id 7355A93F; Sun, 12 Jun 2022 10:26:14 +0200 (CEST)
Date:   Sun, 12 Jun 2022 10:26:14 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell XPS 13 7390 to fan control
 whitelist
Message-ID: <20220612082614.ha47sydl5jj2k5rp@pali>
References: <20220612041806.11367-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220612041806.11367-1-W_Armin@gmx.de>
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

On Sunday 12 June 2022 06:18:06 Armin Wolf wrote:
> A user reported that the program dell-bios-fan-control
> worked on his Dell XPS 13 7390 to switch off automatic
> fan control.
> Since it uses the same mechanism as the dell_smm_hwmon
> module, add this model to the fan control whitelist.
> 
> Compile-tested only.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 071aa6f4e109..16c10ac84a91 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1365,6 +1365,14 @@ static const struct dmi_system_id i8k_whitelist_fan_control[] __initconst = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>  	},
> +	{
> +		.ident = "Dell XPS 13 7390",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 13 7390"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
>  	{ }
>  };
> 
> --
> 2.30.2
> 
