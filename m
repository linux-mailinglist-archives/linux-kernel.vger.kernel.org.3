Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C3646CCD2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhLHFJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhLHFJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:09:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EDFC061756
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:05:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso1173914pjl.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 21:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+rZCR20RPDGoAf8CztEP+MjH3/Q78QqNLnDRFO/ZKK4=;
        b=nm0VC0YOkSo4x8TCDSUgMFzzKJ2PNlINViWVZ953gIxiFkJI/38qV3fs2GL3GvUl6r
         07TVvuHsG/PS9EtTPUfx3lL8eivNM6YZdG1YTWCmr0xouhVqLjPssISeGlHfq41GxNNB
         sj5RCGLqqaWakdgek2IMut7ZXnJy+5SBrFRMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+rZCR20RPDGoAf8CztEP+MjH3/Q78QqNLnDRFO/ZKK4=;
        b=wiluS4gBIG9F8TD6HNnPijMFWFs0RKQoRjFts4M1A7PZZco+ty8YiwpVFulsI1maRc
         tU2ot7uToPZc7wprkYntckNylst6htbb1ifD2AUbaOgicNeo0/rtN25z+WVWIt+z7/VL
         WCqWkid89wFLiHWCSPDwvKzqFngqOeOEw/YRY2mJ+tDvf8mqn6qQ/3HPXtdUXEqizoSm
         Qve3EsCOK8tOyamHLS1AI3Xu7TA5sJMlGTwmug3QnUmJ07aCrDWwnKi3Oqqc5NL0ZU6y
         E5dfmHi8azJ1gfEy8oMSykRvl7C3oJ2PRf7to7Fe4Lx7eKMshIXzRy9yDcJxeUy81ThS
         EDsg==
X-Gm-Message-State: AOAM532wpPPyf14HQ+3w44nPIAvti87dkhoC0SNyXJ0aACQInlKUswYZ
        xT5aK2ua2K3e/FB5WkthxGk0rQ==
X-Google-Smtp-Source: ABdhPJxig7g3enolr5gubLSCeyG6bgCaRSItQUy8n1rTsmpgNRh1QTcEN7S5aT+2hUUJPSbAQtPIvQ==
X-Received: by 2002:a17:90a:b015:: with SMTP id x21mr4665247pjq.84.1638939928718;
        Tue, 07 Dec 2021 21:05:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j6sm1446050pfu.205.2021.12.07.21.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:05:28 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:05:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     George Cherian <gcherian@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] crypto: cavium - Use kcalloc() instead of kzalloc()
Message-ID: <202112072105.8935E88@keescook>
References: <20211208012459.GA145349@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208012459.GA145349@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 07:24:59PM -0600, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
