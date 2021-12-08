Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9F546CCC5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhLHFGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLHFGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:06:46 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAB0C061756
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:03:14 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so3510116pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 21:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kCLAEL6kwfeKwN41NqOO8AEPYIdaucdm15Lf3Sx9vGs=;
        b=EmL1YzZJoM5WiBJHVcjdeIDGwc1JlQ1PdJiFDy98ILZTPhEUBxVnt4M5HX+U581wIv
         uqGuShQVj9Jl8+X40vY81ET7pJffG8xzdRFVAmuXdUcDq/Ma7YKYWXbbcGkoFOIiTO/g
         vveSftJZgGYoDS30XYcmKpOiW66zLf9ucvDU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kCLAEL6kwfeKwN41NqOO8AEPYIdaucdm15Lf3Sx9vGs=;
        b=VhLPpdGl0Wsg8k6VG8TdmsEh1MLpQoM73n/FDh6XU95YrAlK7o3zkSKlevlDocfMe6
         /qGd4ztv7gB3RI3c4YDCKAo+bzA73BG1xbit8fgx1V1VdGRri6CypTQxM3+rdmviGjOj
         t/qH+SJmlrWIHp5giaEq7w2CP/ZEU3HKFgqacfQDSHBuBOyMn6G3cmF5N0ot/fdcyQKm
         pSGSu6qtC1eVWGHyGHaKwKkxZbi3w39m9i830C1Xq9PIfTb0iX7QKA5jJfgcBqZdNQh8
         RdA9UrvxX1IaL/BXjeZsZmEn4ngBkfc1gMD/Fxh9qjTYcSpoTY+xPvWn+aL5+7b8tMjx
         Gf1g==
X-Gm-Message-State: AOAM532l0UBedaRy+Ml6F68kPsTdseo90X8jbreCyemBDl2uplOnHZmP
        NGzdAxmMOHOpkoTIKqINlj+C4A==
X-Google-Smtp-Source: ABdhPJwqQ2aJIiM7EKW+gY82ckZLzZBXQcnNTkc7eHxf/nqb4I+6lr0SS/4d1jYIyyTj0+P5GK2Zwg==
X-Received: by 2002:a17:903:185:b0:141:f5f3:dae with SMTP id z5-20020a170903018500b00141f5f30daemr57078699plg.56.1638939794470;
        Tue, 07 Dec 2021 21:03:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h1sm1452743pfh.219.2021.12.07.21.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:03:14 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:03:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: hinic: Use devm_kcalloc() instead of
 devm_kzalloc()
Message-ID: <202112072103.D37C42F69@keescook>
References: <20211208003527.GA75483@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003527.GA75483@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 06:35:27PM -0600, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
