Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F39346CCBB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbhLHE6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbhLHE6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:58:49 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E426C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 20:55:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id iq11so1080080pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 20:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cNfiJvO3fejBotE5iySezNhtEJJwER74TgDA97YhjHw=;
        b=dFvbWj1YTb2rkTnoh4vumG6c98xkqmedsvStrzVGBcOXL5hS1P5l1JINBDvAe4CWYs
         C56jIevPqd1PVb3iikh9OpUZjBNpFhNIf2ZOp6sBPFhhVkk/Y9HyfWCJKJ7Zxsg+jYgr
         j26v5mM52Dd72VrH2kqFsdsH+aEdxKoaZ3JAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cNfiJvO3fejBotE5iySezNhtEJJwER74TgDA97YhjHw=;
        b=0utZxk5BK5PyQSs6VhQvGTML9sAC8Bmmj8Od3f92JyNpR4xGdcB+ToAY3Hph+yyJaB
         Jd8M0YG4Joj1eFwAxlBY2G6XnMsihCeBqKZ2VOi0c8UTENfkUH8F23ZaLRZTpqQz3upV
         16QA37WO7jnfKwW3mqhqIw9aoqEZy7E3bMyb7QAWX1wkXhL1HsXXt11ZXG2hKn/QVZ++
         ZoiuFoIJbcrRt9AIoEmhBXR1fpHRyaW0kYCOuSSJob/guzr1WBWjvBudS/3LqfXJeLSv
         j6Gmh8I8rOdVbSEzz2lkoXspWK8kie1IMGJc/wF2HXe3rsoRcea0n+dAHvTjUPezchPn
         hUyw==
X-Gm-Message-State: AOAM531tKNfrTviybcb/5lorz+UOfi7x9sFBnyPXx2CDmWPe1r0637kh
        WU77AG97JFMaYo/jsayT4bRSVS23Tfx+2w==
X-Google-Smtp-Source: ABdhPJzS2d4ffr4Pk1pU3l5zZk+LeQbBGpywoHPpAOS/5wf7KsRFrJSCYOl6vgYqGytySqvqn2Y0Gw==
X-Received: by 2002:a17:902:860b:b0:143:87bf:648f with SMTP id f11-20020a170902860b00b0014387bf648fmr56650710plo.11.1638939317886;
        Tue, 07 Dec 2021 20:55:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16sm992605pgu.93.2021.12.07.20.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 20:55:17 -0800 (PST)
Date:   Tue, 7 Dec 2021 20:55:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: at_xdmac: Use struct_size() in
 devm_kzalloc()
Message-ID: <202112072055.3708E99@keescook>
References: <20211208001013.GA62330@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208001013.GA62330@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 06:10:13PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version, in
> order to avoid any potential type mistakes or integer overflows that, in
> the worst scenario, could lead to heap overflows.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
