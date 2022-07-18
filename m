Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04686578DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiGRW7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbiGRW7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:59:23 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557102F014
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:22 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so10499911otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=62y54wQxB5Ga3NFTlaQlQOLlwSf/Xs6fX8rzpQ+b4NE=;
        b=xeNVIxJIQGfmaCIF0FuGOVeMGZsPxdGgO4m0U7Etg9XEKTyE2fZQWlB5awqxEfHrzR
         ru+gQpjkDGRUEPS/+SHyHTah/uirFcFjYUa1s8EGKFcZD7gjoriEmukvNwZVxKcG7nrU
         VnwDgyhJuy7qRQ0v9i9fjr0BqlLyEokCE4KPJrCmIJTegyAPrc+evYpIMr9sWkUbs/2V
         79m3pEBPRvH99k6xzR7P7C3WGKfoIx1Y7SMjp+onMeFLRY0fH+4OKZtfLFGGfNCLu4IS
         51OrGwI+EGlUIoYPi3HEJ3BNbOH/Cl+e5B3pJLO10Io5jyqnyaYqGLL8jkN8QY/0Yd+T
         p2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62y54wQxB5Ga3NFTlaQlQOLlwSf/Xs6fX8rzpQ+b4NE=;
        b=xOtsT/Fc0omhzxrDQOchaZXAio2GzIWVudF7S1SQy0GV5VwY57L0pITReNIzGgq3wH
         nBGtO/DieDh2jQzPwJUKdNkQ6aEKqINFoMp2M2TvC2AKIZZdOVo/vtL8XoQx5Uo3O7Yk
         y5wlntgzony/rE/HVbY3BX1m9pW8xCOL8NEF/BPaFvm5VCIMCOkTOPSauzv5xg7W39kL
         v5AcA+nU3ufDMgf4vBtmg5FBdKI1Z+CJD10bZgSYXEn811oOq4MGJYbPwXcR4YI7Ks8M
         2UcJx/OK75/3qSfCPbw+S2V487n5dO/USalhV3+NGkQsIFBbLjcucUdXBoF9yIaL6zry
         ylKQ==
X-Gm-Message-State: AJIora+eV1TiZ/CiJHEHCrkVzmKD1KcyKej1UEbuSVL2fOX8ExVal9oH
        6xx+2nhONB30UhL/RePUJZ0EVr8OddHfBw==
X-Google-Smtp-Source: AGRyM1u4xgWpcB3MTEEaiDUTpGZZrIEArX+mVcAS0lu3qMxLRot0DnvnH9s/exLkIl9stcVu5tO0sA==
X-Received: by 2002:a05:6830:3706:b0:61c:5d4c:7a26 with SMTP id bl6-20020a056830370600b0061c5d4c7a26mr11459899otb.250.1658185161387;
        Mon, 18 Jul 2022 15:59:21 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j10-20020a4a908a000000b0041ba304546csm5330931oog.1.2022.07.18.15.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:59:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 4/8] rpmsg: qcom: glink: replace strncpy() with strscpy_pad()
Date:   Mon, 18 Jul 2022 17:59:06 -0500
Message-Id: <165817634384.1905814.11996354687051888253.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220501103520.111561-4-krzysztof.kozlowski@linaro.org>
References: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org> <20220501103520.111561-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2022 12:35:16 +0200, Krzysztof Kozlowski wrote:
> The use of strncpy() is considered deprecated for NUL-terminated
> strings[1]. Replace strncpy() with strscpy_pad(), to keep existing
> pad-behavior of strncpy, similarly to commit 08de420a8014 ("rpmsg:
> glink: Replace strncpy() with strscpy_pad()").  This fixes W=1 warning:
> 
>   In function ‘qcom_glink_rx_close’,
>     inlined from ‘qcom_glink_work’ at ../drivers/rpmsg/qcom_glink_native.c:1638:4:
>   drivers/rpmsg/qcom_glink_native.c:1549:17: warning: ‘strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
>    1549 |                 strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
> 
> [...]

Applied, thanks!

[4/8] rpmsg: qcom: glink: replace strncpy() with strscpy_pad()
      commit: 766279a8f85df32345dbda03b102ca1ee3d5ddea

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
