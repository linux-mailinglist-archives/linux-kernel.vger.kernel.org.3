Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05065483BB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiADFf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiADFfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:35:55 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2CCC061761;
        Mon,  3 Jan 2022 21:35:55 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v25so31781899pge.2;
        Mon, 03 Jan 2022 21:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u2Pf8pL2sVNEV7RbPPp0t2wGeTaqpnDUjJrN+zp8KiE=;
        b=jFpMTVOBa4Pyj3tbO/IZP5DVS7wZGi3Y4vdlGLBvAX/DtHv37MC9hLXh/Mv3uC1vRg
         mLzepdjFsgReescZv00/TWjtzCqALN+wt1VPNaDdAjiJKmlNTaZk+n7DBpn+6q9BHw5F
         OFWFf64S/A+0t6Bo06p+hNVycb+cATnaVW1G+s0y7/4ljwUq+azSCazHXVAM39h1BJcz
         afMZyci1PNM51T5yzEFScrBctAQsExBIgjU6kq5JoB4CJrZ4WWzV498UPYd8jCml1rMi
         3lSeIKAT4MDQLyZsB0uKa+Ntc26DnYkSak/SZFZMdwxCO/c980j5lgxJfxzt7FxND1aC
         K/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u2Pf8pL2sVNEV7RbPPp0t2wGeTaqpnDUjJrN+zp8KiE=;
        b=EUOXvdIN07dLVhzXVVk6G/y4LQf4+Qp2TPU/LbgS/2fp+u6zwyKvMbVNap0yNFgaHo
         klJHcDhCgOMgXErK9D9Uyon/EFTj8jnmoMdRukhvU9w1LQvVxrw9QcCN//HyuWSAvVIs
         qChyea75yb71Zlbk637Hn0daOwsxLcAZjfV6OQ5UcKeiTq8GElSJZHUZoTlzbFQeVLYJ
         k7pQZHxQAdEuofBzmG6lK60tYYsGz9Zv721aYkDjQSbPwDVC1jIQbgEHMq+FA4RADK4t
         qhhrmYy8NX2YTmc9Rzsqsanfjp0lakqQ8dm123lQwCsLjyVAe4I2QJ+Vc5opPLMy3k7V
         wKKg==
X-Gm-Message-State: AOAM532ONQoTK4L1UY39gAwqVAJNZgQ5uzI/zxnVLH/vnHoBJA5mERaM
        uj9KFf58OcSR92KTVTg1ym7hjjKArGM=
X-Google-Smtp-Source: ABdhPJwTKX8jq1BmccHVqcQC5afDPa6EXhNwUkUHLz/s5et7MaY8OBWbUozTp8hnhmQ1vF3cP51P8A==
X-Received: by 2002:a63:9a01:: with SMTP id o1mr43165100pge.449.1641274554454;
        Mon, 03 Jan 2022 21:35:54 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a7d6:43d7:bbe3:3573])
        by smtp.gmail.com with ESMTPSA id k23sm1029996pji.3.2022.01.03.21.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 21:35:53 -0800 (PST)
Date:   Mon, 3 Jan 2022 21:35:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     paul@crapouillou.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Input: gpio-keys: Avoid clearing twice some memory
Message-ID: <YdPct/+LBMWTZSeM@google.com>
References: <d6ee621b9dd75b92f8831db365cee58dc2025322.1640813136.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6ee621b9dd75b92f8831db365cee58dc2025322.1640813136.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 10:26:56PM +0100, Christophe JAILLET wrote:
> bitmap_parselist() already clears the 'bits' bitmap, so there is no need
> to clear it when it is allocated. This just wastes some cycles.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.

-- 
Dmitry
