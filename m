Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D9F4AD12C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347080AbiBHFji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347189AbiBHFjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:39:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494EC03FEC9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:38:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p22-20020a17090adf9600b001b8783b2647so1114132pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 21:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rVZQRRRcZIvdySc3NwZCT7uSR6arJIL8Zq9GUUOZI4k=;
        b=K1gzDYX3SbFK6ldfd2O/NmU+kuDtNqSbcy09BOW2CNdaqoz5YU3B20cIl7WoyQQdnb
         ylFHcebmkeNDFZA0ENi3Q/60FUXtcUvrU53HjKGtbezpcxU+h53TsE2ZXXY649qtftqL
         y0fLQ3aGARL4CdxpDFLa1WXIFSkZ9jMfHKfrMXB2jhsZZuKKJW3CR8FziESwRfWljo4D
         C2HzoBMofn8Gb58JNuLin1y/GPfUKVzT8jmbSjlBVgXF1ny2qVjgY9ukzabRXqVlBmI1
         fAJcdSd0lKkMyB/j6hX9ayC/nXWINOq8rs7iMxoUt4PrSgIdQV9MlmCYgpi49ole2qgm
         q09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rVZQRRRcZIvdySc3NwZCT7uSR6arJIL8Zq9GUUOZI4k=;
        b=LZnDHJcY7Dvy8U1Y1gSoZ27KeoV8bf7TYbic22mmKwyBkfhMxULzMsT0ev42NRdjYd
         vWL6H293S7wjV2hQzCEqodFIql3GCETIS0Fzyjy+h7+dKKmZkLKmnX2Q8m/MG5COexG6
         V50xg1mkHkIqkoeIhQy5kdkVHdbkFDGNPzwrAlXLj/u8Yp+2q6WaQl809DINjQOfQDM1
         AxPYWl7U+GYfJykIH59YtQd5N1Gah35HHYoI9QF7NvhR4G11JI6LzR1Ls38Vj0mK8aSM
         J3BIQxXFT3zZEZhYsZT0LSq7y8YassZ9xd2rxuXSvltmk+IP2f9PfHHb5xMjepYoPk3L
         Hrhw==
X-Gm-Message-State: AOAM531jbzc/oX7bfiNL2LZ0RhcY1G/sNPxH3bxXnSjc5nA1moIhphm+
        AxbnaXkF4CkJdO2DnL3ZP9RNPg==
X-Google-Smtp-Source: ABdhPJzayIYRi1rOKJtoeQ2AgpTBrY12q1CwtfUNoU9a1c3DIlBM7Fl9mXtD4LNAmM1qtAY93XWYOA==
X-Received: by 2002:a17:90a:ab17:: with SMTP id m23mr2609289pjq.212.1644298690076;
        Mon, 07 Feb 2022 21:38:10 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4b6f:f14d:be50:86a])
        by smtp.gmail.com with ESMTPSA id 20sm1128467pjf.15.2022.02.07.21.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 21:38:09 -0800 (PST)
Date:   Tue, 8 Feb 2022 13:38:07 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_typec: Configure muxes at
 start of port update
Message-ID: <YgIBv2SQdwXm7RLt@google.com>
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207214026.1526151-4-pmalani@chromium.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:40:28PM +0000, Prashant Malani wrote:
> There are situations where the mux state reported by the Embedded
> Controller (EC), might lag the partner "connected" state. So, the mux
> state might still suggest that a partner is connected, while the PD
> "connected" state, being in Try.SNK (for example) suggests that the
> partner is disconnected.
> 
> In such a scenario, we will end up sending a disconnect command to the
> mux driver, followed by a connect command, since the mux is configured
> later. Avoid this by configuring the mux before
> registering/disconnecting a partner.

I failed to understand the description.  It looks like some protocol details.
Could you provide some brief explanation in the commit message?

On a related note, followed up the example scenario, which one of the
understanding is the most applicable:
1) The disconnect followed by a connect is suboptimal.  The patch cleans it.
2) The disconnect followed by a connect is a bug.  The patch fixes it.

> @@ -965,6 +965,11 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Update the switches if they exist, according to requested state */
> +	ret = cros_typec_configure_mux(typec, port_num, &resp);
> +	if (ret)
> +		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);

It used the fact that the function returns `ret` at the end.  After the move,
the block is no longer the last thing before function returns.

Does it make more sense to return earlier if cros_typec_configure_mux() fails?
Does the rest of code need to be executed even if cros_typec_configure_mux()
fails?

> @@ -980,11 +985,6 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  	if (typec->typec_cmd_supported)
>  		cros_typec_handle_status(typec, port_num);
>  
> -	/* Update the switches if they exist, according to requested state */
> -	ret = cros_typec_configure_mux(typec, port_num, &resp);
> -	if (ret)
> -		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
> -
>  	return ret;

If the function decides to return earlier, it can be `return 0;`.
