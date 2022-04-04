Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E7B4F1E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382276AbiDDWJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379363AbiDDRDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:03:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A8C40A27
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:01:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g22so11915431edz.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaDWQWz1kiQwWpxivLYYrV+X0cEZrsrmIAZxsaFLj0s=;
        b=gAScoclBpW6c8jHDTbBeFYVOa8Vb+lZKB19UpeLijcAa46WH1Ox68XOcWSaAUa6OBV
         regey1nP+Y3uKapqeAPAX4mWaPulwjzHqwqatwf8SxMB4kos9WXVww5xOBhuXmjC13Jg
         9LDRvPL3S9pXoljZ8d3MmIY96mHXRSlQc0i/huBbI0IptKdGmuAe8HbMgFq0jCVbJQL9
         k92n27ryfAkqptSU5w4CditBkdG1Qciyzig70GNy9Bafz2/+PS6+2XTB19NdgaENJ6f1
         OS1hhUufxYUb3RelMQPm/CTPokqCVWknj9w5a+Rl5K2SdT1rIIasATZT5878meuX85RI
         OTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaDWQWz1kiQwWpxivLYYrV+X0cEZrsrmIAZxsaFLj0s=;
        b=GSYUD/6c0f+m+rFHtpn7bJICjneOUV1QNt4Qt4OslAN0UF2rMDrmTl6BrqzOJGmBF8
         x9Mo/NUlxq9RNLigWxuJ/7dBm/PaM4CqmRDcHTno+ibpVWU5rK+/ajc6fOqbJNhwTeHO
         aH6f3UCKIskP8yqmBzxHqYVABzh5L6e1ltLCYk8C3SMVN6SnRGPxuSBV4Cmb61WEy3rz
         XhxRMZckKscqCblP+wdZN43n1cFm5050tXvtYwzR5WF/QpVOgXnJXCpeq9bTYxxDuTGx
         cnTbWdyfhDrIwgx2fM/Z3VoYkbnTqixchVdKDpOdB/0P9fyaDdRTQ+fpxJtgCpa0GNWM
         x/1g==
X-Gm-Message-State: AOAM530ecqObc5ny86V8Vjxv4dQ/CHM8ZvC5PgS+guZs93PCWZLKl0Xr
        8RiP6Fy8n/6q0/OBoBk49W5VEg==
X-Google-Smtp-Source: ABdhPJztm/eMGvOu12ArL6gqzftWaXUdqGzWTTBrItmoOSsRyFaBAtJtYP+WVN7AQinWoayC6HgN7A==
X-Received: by 2002:a05:6402:2043:b0:41c:da2c:2d5a with SMTP id bc3-20020a056402204300b0041cda2c2d5amr1132137edb.373.1649091712122;
        Mon, 04 Apr 2022 10:01:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm4557770ejz.57.2022.04.04.10.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:01:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        kernel-janitors@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH] ARM: s3c: s3c24xx: fix typos in comments
Date:   Mon,  4 Apr 2022 19:01:42 +0200
Message-Id: <164909169269.1688455.6988886329557682550.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318103729.157574-5-Julia.Lawall@inria.fr>
References: <20220318103729.157574-5-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 11:37:00 +0100, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> 

Applied, thanks!

[1/1] ARM: s3c: s3c24xx: fix typos in comments
      (squashed)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
