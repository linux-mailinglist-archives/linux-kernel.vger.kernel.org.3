Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876E4498590
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbiAXQ6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbiAXQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:58:54 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34366C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:58:54 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t32so15892492pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=QpweiVyIfmb5hj1sObeMoupM7nExebWp4y/78WjEl2o=;
        b=KDOcJo5VhtwHDYkRvxFLe2+8bdiG3/Uk+A59ZObbMymNhlfS5n75/xTEDHaC4pb2RW
         oJRWHcQb3z+pmIvLIXCmTMK1ddA7KKZGOJ8L/2qRnorzLU4l0QG0uJPDaFE1vB/Aj8N3
         Fo/+tT4g2b/ftcx6RppZOyB5biFw+pEfpxA6eg5rV1xrKK4APlmhwmrTlto+roVogi6h
         L+URhA9G81VATPDvfsLgNgLgKe93cjhhr9j7IOi3qzVgTgCkh26o1+z0ZVAyJwtbUuQL
         PPHgqFOgqaH3Pk+wjxq8ZQLekAjvcQEpzD61nodAygpv5M5Y0Tqemg7HWzKABeJliIvz
         lhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QpweiVyIfmb5hj1sObeMoupM7nExebWp4y/78WjEl2o=;
        b=ucmXIEDx0eXFfFIYmTPMEzz5ZNDxmmgDxZ6PBYgKLu1dwGvC1IfNLWRAP0RtpQLFlW
         ylFxbSpb/7iLM/VzcZoUbzZZ+dcJJJnGfCgjLv0Eltds1AWxgKcRxBizHIhblnjvtLf9
         /a3X6bfsnM7HIHjl49GlLfEus1aAH8U3eHieSg6zfVlbJJ4CxV2S22oXrvLtJw5dE/KL
         C8xcHlzTEO6EISR5Wo8f6MLPwDZDnergTeVHQENeetD6jp9eYr7DmXcmAvKsDTALSnXv
         U4ws+M2QTYRV/KuVe+z+ApswvKsNogbeQ8nn81htVyMr/2068LmVmO7IxO0tm8ui5L9z
         9o+A==
X-Gm-Message-State: AOAM533zK8VeLc7VrFVEhrgElFfS5h6jdT0Sm12V+iTNl2Ytp3ekPrB4
        uiYb9qXo3h0LbGVmqs57EbWE/w==
X-Google-Smtp-Source: ABdhPJzFFs4pNrvCJjliYLl0Xd2gUQ4IZdd9l1RcnT7MfpuqAkrcqgx4Kuk2LSLF5GEFQtg9h6gySw==
X-Received: by 2002:a63:3182:: with SMTP id x124mr12248537pgx.586.1643043533673;
        Mon, 24 Jan 2022 08:58:53 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id v4sm16849486pfu.202.2022.01.24.08.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:58:53 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
        rui.zhang@intel.com
Subject: Re: [PATCH v4 RESEND 0/2] Add a generic virtual thermal sensor
In-Reply-To: <20220111103346.2660639-1-abailon@baylibre.com>
References: <20220111103346.2660639-1-abailon@baylibre.com>
Date:   Mon, 24 Jan 2022 08:58:52 -0800
Message-ID: <7hilu9xe7n.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, Amit,

Alexandre Bailon <abailon@baylibre.com> writes:

> This series add a virtual thermal sensor.
> It could be used to get a temperature using some thermal sensors.
> Currently, the supported operations are max, min and avg.
> The virtual sensor could be easily extended to support others operations.
>
> Changes in v2:
> - Fix some warnings / errors reported by kernel test robot
> - rename some struct and functions with a more accurate name
> - update the dt bindings: rename type attribute to aggregation-function
> - factorize a little bit the aggregation functions
> Changes in v3:
> - Aggregate thermal zone instead of thermal sensors
> - Use try_get_module / put_module to prevent thermal providers to be removed
> - Update the bindings, to be more accurate
> Changes in v4:
> - Fix two warnings reported by kernel test robot

Any more feedback on this series?

Thanks,

Kevin
