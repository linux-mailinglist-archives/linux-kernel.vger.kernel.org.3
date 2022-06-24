Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17079559673
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiFXJWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiFXJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:22:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E6E69FB7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:22:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1o4fWT-0001bX-2p; Fri, 24 Jun 2022 11:22:41 +0200
Message-ID: <1a694037c631c298c6952cdf4bf54fcc6d2f08e9.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/4] drm/etnaviv: add simple moving average (SMA)
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Date:   Fri, 24 Jun 2022 11:22:39 +0200
In-Reply-To: <20220621072050.76229-2-christian.gmeiner@gmail.com>
References: <20220621072050.76229-1-christian.gmeiner@gmail.com>
         <20220621072050.76229-2-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Am Dienstag, dem 21.06.2022 um 09:20 +0200 schrieb Christian Gmeiner:
> This adds a SMA algorithm inspired by Exponentially weighted moving
> average (EWMA) algorithm found in the kernel.
> 
Still not sure about this one. I _feel_ that a simple moving average
over a period of one second does not do a good job of reflecting the
real GPU load for a bursty workload, where EWMA might be better suited.
But then I also don't have a real informed opinion to offer on this.

Regards,
Lucas

> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_sma.h | 53 +++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_sma.h
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sma.h b/drivers/gpu/drm/etnaviv/etnaviv_sma.h
> new file mode 100644
> index 000000000000..81564d5cbdc3
> --- /dev/null
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_sma.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 Etnaviv Project
> + */
> +
> +#ifndef __ETNAVIV_SMA_H__
> +#define __ETNAVIV_SMA_H__
> +
> +#include <linux/bug.h>
> +#include <linux/compiler.h>
> +
> +/*
> + * Simple moving average (SMA)
> + *
> + * This implements a fixed-size SMA algorithm.
> + *
> + * The first argument to the macro is the name that will be used
> + * for the struct and helper functions.
> + *
> + * The second argument, the samples, expresses how many samples are
> + * used for the SMA algorithm.
> + */
> +
> +#define DECLARE_SMA(name, _samples) \
> +    struct sma_##name { \
> +        unsigned long pos; \
> +        unsigned long sum; \
> +        unsigned long samples[_samples]; \
> +    }; \
> +    static inline void sma_##name##_init(struct sma_##name *s) \
> +    { \
> +        BUILD_BUG_ON(!__builtin_constant_p(_samples));	\
> +        memset(s, 0, sizeof(struct sma_##name)); \
> +    } \
> +    static inline unsigned long sma_##name##_read(struct sma_##name *s) \
> +    { \
> +        BUILD_BUG_ON(!__builtin_constant_p(_samples));	\
> +        return s->sum / _samples; \
> +    } \
> +    static inline void sma_##name##_add(struct sma_##name *s, unsigned long val) \
> +    { \
> +        unsigned long pos = READ_ONCE(s->pos); \
> +        unsigned long sum = READ_ONCE(s->sum); \
> +        unsigned long sample = READ_ONCE(s->samples[pos]); \
> +      \
> +        BUILD_BUG_ON(!__builtin_constant_p(_samples));	\
> +      \
> +       WRITE_ONCE(s->sum, sum - sample + val); \
> +       WRITE_ONCE(s->samples[pos], val); \
> +       WRITE_ONCE(s->pos, pos + 1 == _samples ? 0 : pos + 1); \
> +    }
> +
> +#endif /* __ETNAVIV_SMA_H__ */


