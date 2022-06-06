Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8AC53F176
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiFFVOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiFFVOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:14:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871DAAF308;
        Mon,  6 Jun 2022 14:14:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d14so12460325wra.10;
        Mon, 06 Jun 2022 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YmrPNNtOBq+9JzdsAI7pGeIetIT35ohZzZpKBjsR0sM=;
        b=krnByREAlieaT/YieoQECd4AESlhGieDlD5VNa9heTv6fjEanrPCWBcR+u4euLtQbj
         LuYXEY9Dpv69Hr6QTbVreWrpAdNltTlp9Of4yRyqBj6Rv0Sb4zFp+voF/a+xlGXAHdf6
         sg5+60HlBdY4i9otXqkuerTIDt2ZOTKnP5Krnx+Y6/ZXp4M7OecTfGei0lMETTm7DN+a
         cNtq5zySTLp1IY6NJNBL+hMFu8m5J6LZRlLZyST0BY7g4dcZK4RfiNGmmQ+5HdXRly2w
         fNSSEu2/AZHVEeVhw7f9VR8fVUN11TWnznxTVl0N1B1XUM3+yqy2i3K/x2EROGp1xMx1
         fa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YmrPNNtOBq+9JzdsAI7pGeIetIT35ohZzZpKBjsR0sM=;
        b=J3TW/DHKZdgVRW3aZ9BMny+mBGks1tHITr8GiCafHY6qLNTjwldiWev3PVEC9ncoBR
         B3ZQ5kLGjMAHmJ4LWBWjPejPJUzv4w52/xfmf5z2PB3W/dAxOO1jHmvy/tytMoqiSpX4
         eAPFs3QrabqMVvVTCbdsbfnoqi19iPBQ919ZqBLOUAzAUCO8c/bRB4kJxFxQ+fQQQYGq
         VVcB9KtXfS88DEP+f0k2jpbVRaZ6YKbhhlLAa7N6FDNxIqZRwIbuUFnXyZGhuN0B10IB
         t8WEUJ8pRH0lnFTfLdwt37AR641SC49iQWllBkLVJrcIiwcAvyP5euFiJkFt2S4tpI2G
         dENQ==
X-Gm-Message-State: AOAM532ikaT5uBXM00L2IgUSu8h08zyhf03f+SyKgF9Hwn6t98n6yrlE
        VEyWwW7IYq56mzrg5FQ3EnA=
X-Google-Smtp-Source: ABdhPJwBEcE8NFT3BuH35Zqpn31zKlX00spaa4ApKSwBvyTlcFgmf6+Q/FqUd+aq41o0g6YwS3TmZA==
X-Received: by 2002:a5d:54cc:0:b0:210:3d9f:4770 with SMTP id x12-20020a5d54cc000000b002103d9f4770mr23322826wrv.122.1654550074012;
        Mon, 06 Jun 2022 14:14:34 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id ay1-20020a5d6f01000000b0020fee88d0f2sm21145210wrb.0.2022.06.06.14.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:14:33 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi-ng: Deduplicate ccu_clks arrays
Date:   Mon, 06 Jun 2022 23:14:31 +0200
Message-ID: <2631629.mvXUDI8C0e@kista>
In-Reply-To: <20220531043539.41549-1-samuel@sholland.org>
References: <20220531043539.41549-1-samuel@sholland.org>
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

Dne torek, 31. maj 2022 ob 06:35:39 CEST je Samuel Holland napisal(a):
> The ccu_clks arrays are used to link ccu_common objects to a platform
> device during probe. There is no requirement that the clk_hw inside the
> ccu_common object ever gets registered with the clock framework. So the
> drivers do not need a separate ccu_clks array for each CCU variant.
> A single array per driver, containing the union of the CCU clocks from
> all variants, is sufficient.
> 
> Let's save some space by combining the ccu_clks arrays in each driver.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!


