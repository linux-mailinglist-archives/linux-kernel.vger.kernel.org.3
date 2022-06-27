Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393FB55CCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiF0JQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiF0JQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:16:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FE060E8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r18so4163869edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VqBk/8Hwtlk5l1lEMXH4Lz9X+gANSMIiMS6ItePJCEo=;
        b=z8KsPADtEjBi3xPkm+J4AOtWRV2sE0stBnlXjJKnKTBOTlAQBOQb5uYJ2xmpolq5U3
         ocCJsZeUor7iToT21YjzM6HZhP8rVlUv6zq+N2mCD2UcYZ5ZnrkAgK8HQDzDPNLKvbHP
         Bf8PGXlvq2HXMv+fJlRtZKQbd0KDJkwHerPohyYx+PD97+7xj0N2qLz8SSZ8/hYSFIpQ
         vKuTgax0ILAtxlPHsvrO0gxWE8VYZ4q7nJbkT3g+jXMYDrqt8gtqoGIjTuebQEOZSpmm
         EVmBdKx8B2suyA2rpUhm+q9p4Ew9gwpwOlUiFiiohDlQlozH/NzUI1c52+fgI2vyGOHS
         SUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqBk/8Hwtlk5l1lEMXH4Lz9X+gANSMIiMS6ItePJCEo=;
        b=P2ftCdeamAteH1FzDIYnhR+i3xtsvCFH1r3DwQXw6JdiPrckHMtmqHw0mjFq4fadNL
         lyqwW0zVpaGQPYmEl30IZj+SOVNlcOJZGOTNN6pimMbqyQHi6nCTiWy7NKXujAJ+lCEc
         RwB4EX2GnYmzhTVFG+aeRrFbAl3uIc3SedJmjMoj8MZyGru5swuqkZNKUuSVHzzfyIGR
         ZflTjUcYJqXFi2NrurKuV3wBJRVrJ50vM0Bs9UPY64lknPPBI+vu3IM6xlr/GNATgewU
         KcNOug11GcqRvLU7X6EMpeULdwbFdVjzPe+XnGCMxOdeXb6AK+uVTIPJJOOIVuhfgpDy
         ZYDA==
X-Gm-Message-State: AJIora//f1FpAhZ3g84cSYPlya+mOLY0IQfXYHzSVxuo/mNNtZ1ixEr3
        2FazndCCKOJ9aCFTF9PH8yLKSg==
X-Google-Smtp-Source: AGRyM1sIlY9+BFEaIrTAiYrbO/fYxIU8/y7+0k9+W6N9ST4u5b7lpn0NtO1pJLt2xZL3cWjGiLzQ+A==
X-Received: by 2002:a05:6402:94e:b0:437:8d58:4ece with SMTP id h14-20020a056402094e00b004378d584ecemr6511659edz.396.1656321369928;
        Mon, 27 Jun 2022 02:16:09 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        jh80.chung@samsung.com, ulf.hansson@linaro.org, robh+dt@kernel.org
Subject: Re: (subset) [PATCH 4/5] ARM: dts: s5pv210: align SDHCI node name with dtschema
Date:   Mon, 27 Jun 2022 11:15:45 +0200
Message-Id: <165632135507.81841.18368489193365782587.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220626120342.38851-5-krzysztof.kozlowski@linaro.org>
References: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org> <20220626120342.38851-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2022 14:03:41 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects "mmc".
> 
> 

Applied, thanks!

[4/5] ARM: dts: s5pv210: align SDHCI node name with dtschema
      https://git.kernel.org/krzk/linux/c/6a82ef85c4a4de42214e0c5a79242d54436541c3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
