Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE8C50495E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 22:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiDQUG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 16:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiDQUGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 16:06:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2C02F017;
        Sun, 17 Apr 2022 13:04:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so15677009pjn.3;
        Sun, 17 Apr 2022 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jPuI+te+6ekLRSVFeGNTGv7BgMLvj2GxqJ3CTUvgqMo=;
        b=B0d0bIfNjaYegQA0MmmYngYCnZbq44m/jQPc2TUOQMdnvZbG7jIVoqiqCwLXAADoOK
         7AJA1vDZpomwmvbSZ5SNF1XSkNk9wUm+bt1vlYtQHXj6SJWY6azGbJbXVhXq97QyUKb6
         ZdRyReuVdW2uFXH90CVscLLwxwGlVpfSXeMgLQQUYCRtdnSlLcfcIfyTtGigALqSYHBv
         ++QvLceq7p2m9OOcRM6ALXhe1jnUts1ko0CO7TxmZ5VlUkFjidm6moEDSpNG+hr4tGwH
         qzpz3mO9tWOPKpezA7H/9iq15R4CUU9s5PsbLJyIJinJM7CqN4X5VGE9hds5tr0yNhv3
         gjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jPuI+te+6ekLRSVFeGNTGv7BgMLvj2GxqJ3CTUvgqMo=;
        b=aCtNkifWMcObXLqOMDgGeq9Fp+k3gCNGCQt4EHbhsGXJCbhnrHyPwXhvU5N2Q4YdPu
         fCClPSOT3tvTCHMe4g8WwDPBcbNJbunnZoqOnoMfm+w9oeTVzOh9F2bsroUo3gADTPTw
         wZhmAviTrGomKvp9y9569i9TrYlhBFD76b/mM/6jUer5XttavvSVvuSr8IkANG1Qk5hT
         DLmX6ciGoRgdlNR8habHk791M8xU9E1GtrYx0DCvwmo696Ael/UWX+G/IpHA5rMHMi2E
         EdYq9OIYYX0nUTaObd0FlThPyeqOIhB8eK3iRcUPYV7puJZpUa0D3xFtdar0flxtKp2F
         gbFA==
X-Gm-Message-State: AOAM5316VVfWhskyX4fXjH+fo87O+xUWcXAXTd4h8RgJZSXwbUpjB+HZ
        d4JKNsIH4XoJ/SHOLukcbNc=
X-Google-Smtp-Source: ABdhPJxdgNVNe26ms4URqaZo2a09C7RHegIQDlhTHqPJwjlmLapgazbZ2qp9gjuGxDARAXVt4YqG6w==
X-Received: by 2002:a17:90b:390f:b0:1d2:853c:5b99 with SMTP id ob15-20020a17090b390f00b001d2853c5b99mr3942160pjb.8.1650225858683;
        Sun, 17 Apr 2022 13:04:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1752:34a6:ebd3:cc40])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a00198900b00508379f2121sm9761650pfl.52.2022.04.17.13.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 13:04:17 -0700 (PDT)
Date:   Sun, 17 Apr 2022 13:04:14 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     "G, Manjunath Kondaiah" <manjugk@ti.com>,
        Felipe Balbi <balbi@ti.com>,
        "Poddar, Sourav" <sourav.poddar@ti.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: omap4-keypad - Fix pm_runtime_get_sync() error
 checking
Message-ID: <YlxyvvvWAEc+kRNM@google.com>
References: <20220412070131.19848-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412070131.19848-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 07:01:26AM +0000, Miaoqian Lin wrote:
> If the device is already in a runtime PM enabled state
> pm_runtime_get_sync() will return 1, so a test for negative
> value should be used to check for errors.
> 
> Fixes: f77621cc640a ("Input: omap-keypad - dynamically handle register offsets")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied, thank you.

-- 
Dmitry
