Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A255A56BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiH2WG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH2WGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:06:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E2D88DFF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:06:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l3so9282369plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=PVgk1cYgmYdP4/z4FGNSnk6B21vheryH4WleroFD7+c=;
        b=H1qAkZGA4OVOv6X6d5+8sVRSkog8oFm3MWrQR/VztA7mi2MZAkkNCv8kA981Qq03Fx
         MUJmWhQAQRkde2/NnKvlNpZIUfiPRfurvuynlPO9SVIBUaNUcv+DBHHCwK9SBZdKgcfP
         32Hlchfx3ykLEVe0oBHty7ikUk5Ly7kAHhY3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PVgk1cYgmYdP4/z4FGNSnk6B21vheryH4WleroFD7+c=;
        b=RCRG+WUp8T/kpGe02YIudMyBKCRuzw3cqGVr5UwzQP5Dls2sL8pJy00n71FyC/eYNz
         dPab36rE09SY4s2aQNfokvGrqEJHaxMnbtKWf8UmVERbjkeUTL4sIR8wEB3N4zvdjojy
         Kv/PJzthUO8m+4lm27ceqf5tr10OEGJsUjE2AAoNA0Gb2WgEky8BcJUIC5BdgPOGs7Ut
         SvSl/UHecc2L2Pla5gQp8d576iRI4l7Wyilzt16Nj6/ZwbNUweKRY4x37Yduxq6MW/zc
         l3V504XvI8VLlMubgvCm5AiN7tm7Clbon7iml7Bz7ZeSPeekBst3FHqIS/XIU3LxSxkI
         XVmQ==
X-Gm-Message-State: ACgBeo0v6OVm+mqZgEM0mk7hH+kGBzIiWcKPcPCZFxpNbpCpPYyJjrZL
        9U8ioCLPK0RJrwFDJYGyN3Pdfg==
X-Google-Smtp-Source: AA6agR5YscpVPaUvYDy7+TR/YvEO+8Cce/NhVhMaYXtHKDHqYrGOwq2jWuhNHtLxJ3DZyjsxf7V8/g==
X-Received: by 2002:a17:90a:7343:b0:1fd:d6fc:b2f with SMTP id j3-20020a17090a734300b001fdd6fc0b2fmr6219851pjs.65.1661810812073;
        Mon, 29 Aug 2022 15:06:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902a38a00b0016bdeb58611sm3271966pla.112.2022.08.29.15.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 15:06:51 -0700 (PDT)
Date:   Mon, 29 Aug 2022 15:06:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] can: etas_es58x: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202208291506.869166F4CE@keescook>
References: <Yw00w6XRcq7B6ub6@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw00w6XRcq7B6ub6@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:50:59PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length array
> declaration in union es58x_urb_cmd with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for a flexible-array member in a union.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
