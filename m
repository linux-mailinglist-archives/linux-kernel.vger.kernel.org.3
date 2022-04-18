Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4804506013
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiDRXL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiDRXLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:11:22 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209121DA65
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:08:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s137so21555584pgs.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pl4a1fMymhH/XaPiTy1w0Dc08PXzaBVwflpLSOoW8Yk=;
        b=jy1VZlNcq/9U5Ar0F5s7yclwR/2ytq2kRRt4Ot66e+/0Rjaq862/Zkd9XN88f4dXsF
         UUgCogzKzwuZt0iOzB+5xfW6FC+NLWYzAs6P5wItYRAb6fcHWKkRHSLtPZxo0HtkF+/z
         EXs89xdD8yLcudimZPW2W7TGRJpdOCmg9Nw8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pl4a1fMymhH/XaPiTy1w0Dc08PXzaBVwflpLSOoW8Yk=;
        b=gpUNBgEWd7rZIND67VKW5fFa+PKmfALB9W93uSF2iFOo9t3Epgmab20j6JP/DasnmU
         TGDQXQ+ydksCA4dxSOkVmjMTlpk7lyzqLE/oMtuLJCNo7uliBoWwNlNe5CrEYuKMoUHA
         53B+n/0wsACn1L467FfZHO0palHs4+fXs81QK6rw5yBcDYK6HtpTTlEqHSUCu71t8XmS
         YWo2DGWnQZ5G2tYovPOJJZV32zl2RwmXs7SFX2TV2VMvjG1PMgmGeKXjF+fu7GdNtuE8
         8tHAuLkE/JWPFb0wjCnqahq4PZ2dDA3H7xDJWfOyYkM52UI0IpfixkrVYL14XBImyzjs
         mYJA==
X-Gm-Message-State: AOAM532UYX1QoqaH4lmyyJ86h/CVGl9KdOQrkLlB2Mjqbej+S4VSkQfP
        Thb2KF49Bl+0vaBrDa+oRiBh4g==
X-Google-Smtp-Source: ABdhPJzrMMgiVgnGS1tb2dOQcYsLll9fc4XWRYNTU66SXevGjIRh1B/3P0/A/mZpsI05/pWOguDuNg==
X-Received: by 2002:aa7:9ad8:0:b0:50a:49e1:164c with SMTP id x24-20020aa79ad8000000b0050a49e1164cmr14593991pfp.8.1650323321628;
        Mon, 18 Apr 2022 16:08:41 -0700 (PDT)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y9-20020a62ce09000000b0050a6516573esm6959461pfg.67.2022.04.18.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 16:08:41 -0700 (PDT)
Date:   Mon, 18 Apr 2022 23:08:39 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_proto: Add peripheral
 charger count API
Message-ID: <Yl3vd4kfgwJXMs/w@chromium.org>
References: <20220415003253.1973106-1-swboyd@chromium.org>
 <20220415003253.1973106-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415003253.1973106-2-swboyd@chromium.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Stephen,

On Apr 14 17:32, Stephen Boyd wrote:
> Add a peripheral charger count API similar to the one implemented in the
> ChromeOS PCHG driver so we can use it to decide whether or not to
> register the PCHG device in the cros_ec MFD driver.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daisuke Nojiri <dnojiri@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: <chrome-platform@lists.linux.dev>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c     | 31 +++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |  1 +
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index c4caf2e2de82..42269703ca6c 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -832,6 +832,37 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_check_features);
>  
> +/**
> + * cros_ec_pchg_port_count() - Return the number of peripheral charger ports.
> + * @ec: EC device.
> + *
> + * Return: Number of peripheral charger ports, or 0 in case of error.
> + */
> +unsigned int cros_ec_pchg_port_count(struct cros_ec_dev *ec)
> +{
> +	struct cros_ec_command *msg;
> +	const struct ec_response_pchg_count *rsp;
> +	struct cros_ec_device *ec_dev = ec->ec_dev;
> +	int ret, count = 0;
> +
> +	msg = kzalloc(sizeof(*msg) + sizeof(*rsp), GFP_KERNEL);
> +	if (!msg)
> +		return 0;
> +
> +	msg->command = EC_CMD_PCHG_COUNT + ec->cmd_offset;
> +	msg->insize = sizeof(*rsp);
> +
> +	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> +	if (ret >= 0) {
> +		rsp = (const struct ec_response_pchg_count *)msg->data;
> +		count = rsp->port_count;
> +	}
> +	kfree(msg);

Can we use the wrapper function cros_ec_command() [1] here, which does
the kzalloc and msg construction?

Best regards,

-Prashant

[1] https://elixir.bootlin.com/linux/latest/source/drivers/platform/chrome/cros_ec_proto.c#L914
