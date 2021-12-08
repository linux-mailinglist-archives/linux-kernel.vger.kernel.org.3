Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD2D46CCF4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhLHF1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhLHF1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:27:40 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376D6C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:24:09 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 71so1109651pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 21:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jN21r6OJSTFsgj9r64Hh1jCiMPIix6wU4qgpRwHwfG8=;
        b=hMsTpPd8gWi3Ujy3PvMKm2AhRb2ML1jyzMuE/erpda/1/AF+rUNIald/GfGViq/tLd
         o2y4W8cc2ICUanBvcqepDNezWtTFgQCoX+Qfcc5GqmL6Bn1U9t7Lny66rM704bugnGTq
         9X3HvHzswrV2tjhfCa9a4cA09icmI/vCPfxNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jN21r6OJSTFsgj9r64Hh1jCiMPIix6wU4qgpRwHwfG8=;
        b=H67a3qf8qkcY5cHGWKwLaP8P4kGyDO7fBeVTS7WCfiMZlx+d7M3YDaEc8KVF/Pff5C
         WX7L/vYTdKxX9/W0J4Y7BlGwKoCtQrx+FEwU2P/HwG9f4GVW7xY9K70QTsCBcRXZxKPy
         8gzHZq80iJUNz+kHQyB8imxU1P40qWI0M+pWPBH+2D8EAl8etaMoo5ye8G6vAFdMMbpP
         NZSpeKpJTywfJAV9lOnpyy/1YaKE4jTYFxm2JGxCk41pj9TeFpGW3eA5GV1QCXGtNOYw
         upfOLNSHv3o2A9t2KTtE/A0/g2NWGwUf/8bFklnnJ43nTET3wI2GyWh6QtEsGnjiVXzc
         AJNw==
X-Gm-Message-State: AOAM531Q8t1f8eKsn7Nl0xfrx9M7uGAK8cxUUO88ecqAmWgAza5qrzOM
        FHM658/3mD8fqCTcPd7UnRvNfQ==
X-Google-Smtp-Source: ABdhPJzlHAKuLFlj8TFLJdbJpyf/D+l9/UBbiFuXowho3aLkJt0awiY6BtPP69mJOwjO/M528bBz0w==
X-Received: by 2002:a63:8148:: with SMTP id t69mr28164809pgd.79.1638941048615;
        Tue, 07 Dec 2021 21:24:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id md6sm1202665pjb.22.2021.12.07.21.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:24:08 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:24:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: huawei: hinic: Use devm_kcalloc() instead of
 devm_kzalloc()
Message-ID: <202112072124.16F7CD13@keescook>
References: <20211208040311.GA169838@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208040311.GA169838@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:03:11PM -0600, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
