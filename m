Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C061F48BA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbiAKVyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245648AbiAKVyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:54:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C58C061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 13:54:25 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m13so1313962pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 13:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5f2yRwnca4po/TToI5ROjNbeo8iSZ748Ub/QrR0dHuc=;
        b=EcYu/L/5MbgCkc0L2lvz8kq++K/ZH0L6kyU96mHQoUta86MlYouS8n6Gtky3M+1Y1S
         wPhzlxv2PiVSZMVHyeV7aFt0UwW3dHGXMDdV419vMkzoTyRYfO4Yljqqg6AujFch4Drv
         fb107vvImyU7gNrGngWSnpx2pzPfC0aM9s424=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5f2yRwnca4po/TToI5ROjNbeo8iSZ748Ub/QrR0dHuc=;
        b=UwdSplB+EOoHr0SL50HpaBtYqB5DYN5rbOqubw4ren2gS87G7lWipQ+HAU8PWjYO4w
         ZWlvJhtYgVK948L0I003sc8Rd0oOwjJUDot5nQGTiNivjWYeKBL2glmckNPcq6TmWrg3
         oRhSG0N+z+IuM1b6/c3V+rBEH00eJq5zT2bbGetyL6P8LTldJxX4rS+ccjX9Yhn5E9gD
         UHcAzojUPSU3pddNSbdcfzeQWhoj80sdjWXHO/+2OZYCZld/T0LP4Sm7nJdbUcRiAqbm
         LW+i0sWWcH7i+IS3Nk9eftM3GXOIC5AP6XXAr8t/S0RpzILSX/iOzhO7CiA5GzAr69VF
         SjcA==
X-Gm-Message-State: AOAM532aw0YQG7pIS51ONi+P4Z+K471McnhQnVNK2S65gN20kBqVn4wY
        9XPJhsp4P5+aNdWOt3zUZQQLqQ==
X-Google-Smtp-Source: ABdhPJwIONtNTCuP+/Vo0J8+j1E+yBh8BAxbE5zlFWfqgTUvLrNDPMYJfbWwD35RGyvzDpCz9S3efA==
X-Received: by 2002:a63:1046:: with SMTP id 6mr5708874pgq.602.1641938065083;
        Tue, 11 Jan 2022 13:54:25 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f0a7:d33a:2234:5687])
        by smtp.gmail.com with UTF8SMTPSA id j16sm10322713pfu.216.2022.01.11.13.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 13:54:24 -0800 (PST)
Date:   Tue, 11 Jan 2022 13:54:23 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, jponduru@codeaurora.org,
        avuyyuru@codeaurora.org, bjorn.andersson@linaro.org,
        agross@kernel.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, evgreen@chromium.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: ipa: prevent concurrent replenish
Message-ID: <Yd38j7mR5vwqlSMZ@google.com>
References: <20220111192150.379274-1-elder@linaro.org>
 <20220111192150.379274-3-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220111192150.379274-3-elder@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 01:21:50PM -0600, Alex Elder wrote:
> We have seen cases where an endpoint RX completion interrupt arrives
> while replenishing for the endpoint is underway.  This causes another
> instance of replenishing to begin as part of completing the receive
> transaction.  If this occurs it can lead to transaction corruption.
> 
> Use a new atomic variable to ensure only replenish instance for an
> endpoint executes at a time.
> 
> Fixes: 84f9bd12d46db ("soc: qcom: ipa: IPA endpoints")
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
