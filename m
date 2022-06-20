Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A20552381
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbiFTSFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbiFTSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:05:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB66193E9;
        Mon, 20 Jun 2022 11:05:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so1936916wmb.5;
        Mon, 20 Jun 2022 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzVrUYmO17yrijTGC8PKHrWXMneEU7w31zdlDGiRk5U=;
        b=e+H8utqjn4E+QAoW6aHYo76iY7iMM3A/+8R2ULMYcgA/JbSfknVLqPSj1SuZ2+UusW
         jLJ3mVkYXD5NzvjAJFef0dtR/LDj5EXmIkWsqT7rRJnMzSVGHqowiaA76xnfGv8uS1lE
         oKjJz5WfPEJwACxzoUXUJe1imMN/kT7jjCk6xrqImrHrZuX8FPWpkCwM5W4UEMuXj3a6
         PaZ8cpKrB4SgxWRghKQtdbPUkLm4qAj+9hblezb9vH2CfwrnOGOD/K84Xv/AXqFgasFc
         xKJGEb/WA9JNwEuPnUskBXXP97oKsRiImyn15bVuTpr1x/Bi4jxdiRFaIg1yJFM2Luft
         6OCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzVrUYmO17yrijTGC8PKHrWXMneEU7w31zdlDGiRk5U=;
        b=u0DNKNqzr8tZTxNSXoG1t/pOCn0DK54V5i+04j2m2Wy9+evn0fYNnqXEowOC9B9ETL
         jj/vUdKQWZPb04gcM3sHBcG2Dn2kxetwl0435Hi1XVoUPBHOq8ZjDbPT8RLzF9SUthy6
         QmWfnPSzNLVnBODUD2tmFUgU5t3OmN/Ct+kIDwiV66yBGVEQwowlWKOBdcu07qpjVrAB
         QL5JmSdBLfEFphqt7zGd1gMX/idr0GAP82OMfBxgZ63nm9smU+lZO1TfPF5HsGDuqMpf
         +B4NOAp+a55nfy49isoUtlhh4y+NPK9Ul/WO6+DP5C/SWdGFb6hayOfXY5ob5KjcJUhe
         4xmA==
X-Gm-Message-State: AJIora/OR5ad+OduBGZwSLFcvMnbsAOngHfaEBj6ybgfw399Nbxn/NI/
        iLlQ4LF7amdsw6Dl3bezx5o=
X-Google-Smtp-Source: AGRyM1veM01CXfNAOVpjK0AAbOBs01ym5WDwguf/bcQ7947+LgzPhWD4VRFxxaUBr0rWUkW1ru0cug==
X-Received: by 2002:a05:600c:5112:b0:397:53f5:e15b with SMTP id o18-20020a05600c511200b0039753f5e15bmr26292661wms.93.1655748314161;
        Mon, 20 Jun 2022 11:05:14 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b0039c95b31e66sm20753397wms.31.2022.06.20.11.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 11:05:13 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: clock: Add compatible for D1 DE2 clocks
Date:   Mon, 20 Jun 2022 20:05:12 +0200
Message-ID: <1915294.usQuhbGJ8B@kista>
In-Reply-To: <20220411044002.37579-1-samuel@sholland.org>
References: <20220411044002.37579-1-samuel@sholland.org>
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

Dne ponedeljek, 11. april 2022 ob 06:40:01 CEST je Samuel Holland napisal(a):
> Allwinner D1 contains a display engine 2.0. Its clock controller
> matches the layout of the H5 DE2 clocks (2 mixers, no rotation engine,
> and separate resets), so use that compatible as a fallback.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!

Best regards,
Jernej


