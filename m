Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409C44901C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiAQF7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiAQF7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:59:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3EDC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:59:33 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id x83so9926554pgx.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SEqaQCJKDxiFQ3pZ017weFeb+0dnjvIO+EowvolRqQo=;
        b=MStWzEQoU2/kESRCpGambaEvP2Cxi9hVDCklwBIuHO/nQ5lRbMccJUhxzRjZrvVsQR
         5AnAEAphxWtgj1HkV570g6Hp8zEORRxC7jlCANfq2t3lat/AegF7mL9w8OGfUPApbtXv
         6wsoshJHjDaE8zHkwM8NMN9tgaM3qZqcZQVPda7R2v7BCdvYZ/UVBuQF7AGQpj6G0uMQ
         r9sk45X4NuFyUXOXD/rV8u918PinANpazmUma4laOKuOfXtdzKh0+VaPa5Yqo2SDeKMY
         bqvE1w2LmC1ilPPxrdZavk1FCAzYpi2KLrk/HZVR00JRAfGpM/S2X4zKqUvwH6FojGfp
         dQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SEqaQCJKDxiFQ3pZ017weFeb+0dnjvIO+EowvolRqQo=;
        b=CkWULTOLFf5ytjFRa3jbhMNzAwOURBd+iA7dNdte0YhVaGUs1Q7qrO0NrFsbIf1+ZN
         4X1hUO1oS0PZEKvZzqxu1h5a7lQiXoE+EJaFaoXv6uynbQHdjGKlJpoY68mBlR+3JNzv
         H/bpR0Xi2F9dyr1+gmiazP3tVmryVRqxV/hYvuuAx+mCVVfTUbN9rkzNcWqM+fRCfFQ6
         +jjP+8z5s+BJ1+RQSJNvTYj2Hz6FzVvX0kD4dqR3KDjEq6rCPgnIVmVLitii1ogLnoFO
         O/n56ZoXkCunuEinQPkDo0BpvS6LejVg4yFKvrHf/woWsUWVYPwn8h+jYWlUd0I6N2r8
         BSOw==
X-Gm-Message-State: AOAM533p3WcP9N5x9Vv66lJJ2RcYE1Sg0tWeA/LzWV0gxBRCas7/QaAi
        x5n4arU2Nr7wFNlMtrUmFlVbzw==
X-Google-Smtp-Source: ABdhPJyPvEnUvSKO9RLm6mAtrfhvGGimgy8WJTS7FgOIsni8aTvBI9lhcnIJf29AgV+vQPoQEm6Xbg==
X-Received: by 2002:a63:2b02:: with SMTP id r2mr18084089pgr.530.1642399172344;
        Sun, 16 Jan 2022 21:59:32 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:bc3b:819f:7751:ac96])
        by smtp.gmail.com with ESMTPSA id b2sm12991291pfl.138.2022.01.16.21.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 21:59:31 -0800 (PST)
Date:   Mon, 17 Jan 2022 13:59:28 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        geert+renesas@glider.be, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fazilyildiran@gmail.com
Subject: Re: [PATCH] ASoC: mediatek: fix unmet dependency on GPIOLIB for
 SND_SOC_DMIC
Message-ID: <YeUFwPHyAfe2ex+0@google.com>
References: <20220117050324.68371-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117050324.68371-1-julianbraha@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 12:03:24AM -0500, Julian Braha wrote:
> This is because SND_SOC_MT8195_MT6359_RT1011_RT5682
> selects SND_SOC_DMIC without selecting or depending on
> GPIOLIB, depsite SND_SOC_DMIC depending on GPIOLIB.
> 
> This unmet dependency bug was detected by Kismet,
> a static analysis tool for Kconfig. Please advise
> if this is not the appropriate solution.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
