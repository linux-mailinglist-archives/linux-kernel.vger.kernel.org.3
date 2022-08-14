Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB31591F5C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 12:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiHNKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:03:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D081D317;
        Sun, 14 Aug 2022 03:03:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o22so6310471edc.10;
        Sun, 14 Aug 2022 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WHxiaSb1rJIu9R+4l2gEHdhyltoYWvxM1ZRzquRwQl0=;
        b=X+wo0w8MzLU4kGs4TRnTw5kEzw9LrwS55YxQc7qJBNKDvaE2yU6WqBS1aBImY6GmmS
         OXvGAU+iNQ2Rcl0gLG2gvtAiG+ea+no9zXcHIK5Iu34j5bhdo3dnTJqBsK1Cpm3ZkloI
         3hj7bYmF+2gTBYwmPzRzqS6vthsZ2U8ibVD1j59cS36s/tYtobth7b2TWjeVcE2Tp34R
         fvCAWIGkFSGNk2mF0uJ9qL5/Od6EvxtzGR4wLaqjsl5X84t0MNZ/Mw2RVWQJnScNCE2V
         uYCjvdxPAHXvR8KL00yj3o15N38ReHuYU5B6hPZEjbefoow6vvw1PWqagUF5nFbKcrV6
         huxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WHxiaSb1rJIu9R+4l2gEHdhyltoYWvxM1ZRzquRwQl0=;
        b=uPJX63+rM+lDWt8NFjADbuh97ZwRhsVZZqz+68s+Mtx8oJb/TA007IorHD5lWngUBB
         J7wSmzl+mbncjL2h61orFZ63k2PtyFLXL/OgT6xT8RTPFWqArqa/wwvFO+RMyAGaHgja
         7zFfxumTOPQF0ocF06N/mi5I0iUmoR9BbKA396yek0F6rnsyFtrPoorBdKEqrMX6bwWi
         tiQO9OAQBuER5hR1WMyKkC0lKya0/Ee9ASZj6v1oDhi2pYfvmtoN0hg31b9H/vUg+vQY
         kmuqals5Hua7cSmyuwBrhj3d1SwHmgK+2Uhh8FJBCchGyATXwRwQeZmG4UiDb7Zg9IBy
         iGHQ==
X-Gm-Message-State: ACgBeo2V5fXIyTexqt50AVaYSOSuehCRVkSW6c1N8Tr//AfJmX7tMEah
        TmGdqIei/9Ou2Dbis8mMwWE=
X-Google-Smtp-Source: AA6agR6pfODl4z8g5+0i3U/G2F8naB8pinZvLP9XUoURWyhHcN67EGwaG5aUxFgsihalBkIBjoqSCw==
X-Received: by 2002:a05:6402:2549:b0:440:5af7:f117 with SMTP id l9-20020a056402254900b004405af7f117mr10576010edb.259.1660471381510;
        Sun, 14 Aug 2022 03:03:01 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640206c900b0043cc7a3ff7fsm4450601edy.33.2022.08.14.03.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 03:03:01 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi-ng: mp: Avoid computing the rate twice
Date:   Sun, 14 Aug 2022 12:02:59 +0200
Message-ID: <3682564.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20220810014024.27568-1-samuel@sholland.org>
References: <20220810014024.27568-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 10. avgust 2022 ob 03:40:24 CEST je Samuel Holland napisal(a):
> ccu_mp_find_best() already computes a best_rate at the same time as the
> best m and p factors. Return it so the caller does not need to duplicate
> the division.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Other ccu_*_find_best() functions would also benefit with similar change.

Best regards,
Jernej


