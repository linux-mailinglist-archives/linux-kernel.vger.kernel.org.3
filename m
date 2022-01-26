Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C349C245
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbiAZDqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiAZDql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:46:41 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF5C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:46:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso4917993pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 19:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pI42JEyzuhM9XP9S2B0qht3sN8ahR7m3AOT5MMQP4FQ=;
        b=D6kT0sP/t1E3PbdkyvGmKM6apVV9zZpYhxNU1dIXDhsy3fYvpDfBP1PNMJVzmvjqng
         DwTg6FO+MAuKkmSj8Op7sWZFo49YVdGZNHu0eceL2w1bpalQwEJ1B3x09FI7XTUtunx+
         qpXrgsQzkaNDJZSwTTsOtXSeDg3sA72Ijv8UAaPCoPXHFPeTJGuR0ds+rucjAC8z1kc4
         Vztdf2ihgdfx5ANU8Uh+vJm5Yox9DrLTyMk6rAOG1eXIGeqG/CvVhgF1U/rDiM1gop9+
         alVr4o78r2Be4keKyUkwOO5yuSYd/3mPGsUQaMHmQyxNkMh88JNo+rNjDJ0YM8mMGydR
         D7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pI42JEyzuhM9XP9S2B0qht3sN8ahR7m3AOT5MMQP4FQ=;
        b=4cUzF96EsXeR6Y/ShnYpA2TrYPA0NFlxmOvlZkIdPCNZBEIhrf/pHktLajDkt+udN/
         ykUd8cDh2GyupwvDoejC2sWEdrFVJxInhz1YL9wUeJXwBvzj97NTeQdC7q4aa5rb2Dep
         BYaLEBRNqtrvytSPoMgWd8oij58+b3uhoScwFtwgnlO+qEQyI2EQ8gtYq7XR9RwQl84k
         esrrhbpIwiRpa8EIVt39BwkHx4YAHZNqzyfxBn7vd3lCfwkyLsStwWrIBpwf+D1v1e7g
         rTonAgWMWA/wrYZAuUwglju44zgGVNkNZk/lUOf9UzzBaUloG0h8FC/HhM764ul2jfbq
         Bzvw==
X-Gm-Message-State: AOAM533yPO41W8h/HN8ozsT6/lNWocSImS7B2xWo3uASHOchOjZ0wW2V
        SCJBN3WPCjv656UwlHml8Cf/tg==
X-Google-Smtp-Source: ABdhPJyWyj2aq6Rt9HOz4rbheeewVvi27szFsChfclVNFfScINlb/JGt2ooBV0UBGVcm+23MbbMmkQ==
X-Received: by 2002:a17:902:db0b:b0:14b:28f9:cb92 with SMTP id m11-20020a170902db0b00b0014b28f9cb92mr17961252plx.65.1643168801099;
        Tue, 25 Jan 2022 19:46:41 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:69af:7f25:2010:2c85])
        by smtp.gmail.com with ESMTPSA id 20sm15310319pgz.59.2022.01.25.19.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 19:46:40 -0800 (PST)
Date:   Wed, 26 Jan 2022 11:46:38 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC device
Message-ID: <YfDEHoYkLc6zjSxj@google.com>
References: <20220126012203.2979709-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126012203.2979709-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:22:03AM +0000, Prashant Malani wrote:
> Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
> Reported-by: Alyssa Ross <hi@alyssa.is>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

With a minor comment,
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

> @@ -1076,6 +1076,12 @@ static int cros_typec_probe(struct platform_device *pdev)
>  
>  	typec->dev = dev;
>  	typec->ec = dev_get_drvdata(pdev->dev.parent);
> +

I would prefer to remove the blank line to make it look like an integrated block.

> +	if (!typec->ec) {
> +		dev_err(dev, "couldn't find parent EC device\n");
> +		return -ENODEV;
> +	}
> +
