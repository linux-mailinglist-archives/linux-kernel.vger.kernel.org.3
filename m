Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5247BC25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhLUIss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbhLUIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:48:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 00:48:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 185-20020a1c01c2000000b00345b7a50a7bso736697wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 00:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1i5pKI1yaREcKWwm6ZJnOKOfClamYbFLkl1l05ao+P8=;
        b=HQm25Al+ByvO5NoxVLT6E2bOaIW00vE1JmEXCieAXBxovaFIyAYZfOTy/dfzM8wCor
         2LzCgJRBDePMbyMT7vJh1HejDv+didIEK83TpaMo8K1PMHNmNSO/zsc/C3+iXMyqSdi5
         862caE7jCLOYHd8d0UvKgyOvqQH3siuYAmAD7nUVzEhmpnqpTSHf0E5DTB8VcwlZT8cK
         XKEQyhdc1Szz+LjctphbTSUyyUyXdP94E94SL+75PejtPoSOU3gP9SLjNnL4hr3N2xDD
         hS/+zFa307qcAJhjwZLgSr7jh/9b5mdLHRnqIY4SbTBtHsi14frXjshWNfWMRZ6mj2cJ
         gAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1i5pKI1yaREcKWwm6ZJnOKOfClamYbFLkl1l05ao+P8=;
        b=BfVxFbNakMwEfbqKYzKhrIpcHkw83LmHLXocB/MU7A4tqwRCpWTxIldDisJsdFBNCU
         hmOFW+CKLJgyZWQIYsUPcFrmqvCTPiUoa4Bt09kHP7VJ+SnpvRLaJu3ldhuOhDyZvHQY
         zAydoRaRA36KI480OC7cRYJWaPifF2oadhXCmV8Av6x7UYAgt1jiOZ1e8LF5GjyPL3L5
         d9AsbUKDCuSejqkV64tbQS6emdOKulHwXcAtrrN47wzN2neZUf9m48fsjFo3BGN4eRua
         TVFbi8oBp1+J1ZRfNZv9JWMOZBzVdUChkpvwstj1EibkHxx/K9eLShF3LK0auaPEZXRT
         xUMg==
X-Gm-Message-State: AOAM531ZIfIltpo/mLaRf6V09U8CA6hemVv96wrbRHruViCGsDxwzBvZ
        8c90sSZWW5qBY7mRyujPxIg6gg==
X-Google-Smtp-Source: ABdhPJxvds/JbvO7IudFfvfu5aJ1k1xE1AzlajsT7HSscMA4YfLFPB7yjLj0mUO3zC46G30PkUhW1A==
X-Received: by 2002:a1c:1b8c:: with SMTP id b134mr1700891wmb.44.1640076525242;
        Tue, 21 Dec 2021 00:48:45 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id n4sm18317859wrc.1.2021.12.21.00.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 00:48:44 -0800 (PST)
Date:   Tue, 21 Dec 2021 08:48:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: rk808: add reboot support to rk808.c
Message-ID: <YcGU6pQqfEPBqjrO@google.com>
References: <20211220144654.926112-1-pgwipeout@gmail.com>
 <trinity-c54ecce4-7a39-4143-b136-f53c9b40ffd1-1640018026851@3c-app-gmx-bap45>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-c54ecce4-7a39-4143-b136-f53c9b40ffd1-1640018026851@3c-app-gmx-bap45>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021, Frank Wunderlich wrote:

> Hi
> 
> > Gesendet: Montag, 20. Dezember 2021 um 15:46 Uhr
> > Von: "Peter Geis" <pgwipeout@gmail.com>
> > @@ -749,6 +791,9 @@ static int rk808_remove(struct i2c_client *client)
> >  	if (pm_power_off == rk808_pm_power_off)
> >  		pm_power_off = NULL;
> >
> > +	if (of_property_read_bool(np, "rockchip,system-power-controller"))
> > +		unregister_restart_handler(&rk808_restart_handler);
> > +
> >  	return 0;
> >  }
> 
> this change misses a declaration
> 
> struct device_node *np = client->dev.of_node;

How did this compile when you tested it?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
