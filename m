Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD19A46CCF8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhLHF2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhLHF14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:27:56 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4803EC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:24:25 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so3540928pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 21:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3LWpn27xpBvngeaGA+vOksGc0Why3OU0y9bZknS30xY=;
        b=M3HJ4FCR8wWK0d84r93J2nDa4lCm1c5zm1NoLHg5U9JpTIqEWmrj5XLpDFuFhBW1cy
         7PZwxRg+A4t5xGsPeAVZ3rA3sTbQTJuk6KGYiaFrgIpK7U0cCM2waeIjsjvVPMq9plwA
         FQCFWQkSiqiQXMZtTCCFh5ESNIlrSp1NZ25ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3LWpn27xpBvngeaGA+vOksGc0Why3OU0y9bZknS30xY=;
        b=1q89hDaop50pWiznkKxBRoED6GeGwBmRKmJQPYucTww47xURg0QBXLh0eLwZBP0Rws
         ht1UYMd9p1cVWz90DD1dAfSCqvS3TFXwvLQvPkC1eBNz39/I7yWeI7Ks4trVkxFLaSw1
         +ngIye280CZELlFqizyYObeCk47DkCg6mZLsb90+S/YP/6e1RFo42X1qvWjsxppK8iFw
         YJnRcyPfptfuW4/pxgLlADV8FvwB5eqn7cr109z7TLN5ogivhmWdjyqhusDDwy+5fnAr
         p2oECqVx6z5yZkGfp3p+haKORb1HTJMmxtMXtA+6PRFUzm1Unk7R00GT3IgTcEBupzru
         xoTA==
X-Gm-Message-State: AOAM532WaiBQx9BXcxGgaqJoQ7z1IxMHowBrYyxNIzjbw72JEzop4RDj
        fIPwqRgWC162ZN7zNGgzTD8ktA==
X-Google-Smtp-Source: ABdhPJyxArWbqyNOBKeJzP4ix4N263bd5ndDZkW6Qg7gzPdWajoqDpQ0Jb17t5yCQuGAHGQfNHPupg==
X-Received: by 2002:a17:90a:657:: with SMTP id q23mr4510814pje.21.1638941064876;
        Tue, 07 Dec 2021 21:24:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j1sm1634961pfu.47.2021.12.07.21.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:24:24 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:24:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] crypto: marvell/octeontx - Use kcalloc() instead
 of kzalloc()
Message-ID: <202112072124.B4642C7@keescook>
References: <20211208041721.GA171099@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208041721.GA171099@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:17:21PM -0600, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
