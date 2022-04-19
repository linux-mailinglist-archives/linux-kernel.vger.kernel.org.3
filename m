Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750DF5068EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350702AbiDSKru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242383AbiDSKrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:47:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91735F84
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:45:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k23so32010029ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOnjnfeakbqxFzlK8WkGiM7/RlXkR35voEUsVEYGghQ=;
        b=tNXPvrwRPrdwtbEB6lfJ77vq1rmFE1peqJp+MEymzAs4HuSiZ1r8m7NzH5wm5i9ClY
         h5PCv5fKO2Lmsb4KVyPd/pTCevqjkyJZ+YJcoHhZRR2IBUUPvDkVkkVbVtaRx47Xi3wc
         ZJw73ZZqtLNGx2Y9sGA4bi/3dxv9NZLXqxHaUzHZaXeb1UUkGO4+t6hxuP+bP9P7Qbyj
         TqubiWZuvGYEQHCONAYFy4g6sSBRIJCXlmR3HBwkVc9SCRrAXIrz91a0up1ybzN4d2uz
         Z5EvD03pTLuw6h8JKtq5CikQjs9zD8H1WNCZlL8hQ8Tjzgcjif6RuL6xYIWAu105Oc5F
         PAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOnjnfeakbqxFzlK8WkGiM7/RlXkR35voEUsVEYGghQ=;
        b=3lPPVaXkcBQA9d6Tk+loOd/BuRtVqcG1mrRZGxFiLY2wN3R3jGhDY/4dcZ97zW/VAu
         aZZ5QRUHE5H/f3/fR4n1bEbYD71Dq4Z7GwuNcIdVw3p3oM0MhTB0asilE36jlf5qaAya
         fORO3Z7iq8KkVNG2PTE0/4/cvI/g3AVxYoNbpODmdhXs8XmydpUjBD7Ip+NuGm009Vap
         qt+jMhEOVVUfqkrm46e886nV2lj5jE2ChdPD7xQuZUdnpcgrESwNRnFk3hbtTa1CBGt9
         idqrzJlO0by1TznP1yk+Xpmjm0KimPQjACZ0Zrw/sfeh5ZEZCSptgr9UZacfx0z63wU9
         LtGQ==
X-Gm-Message-State: AOAM531XI5fcMjkpZTt8pj3/TWm7/FEz02DNZ0t44YiStQk+JLvWusVv
        genyuaBZcYlGrJXTqlKw781FNA==
X-Google-Smtp-Source: ABdhPJwOv8CJlZYU1crBAvi9zb4I0S0FXWyIFlzCT55QknepxGI6r8t/MWtUJDhx9ZpPgsX2Ft5Nrw==
X-Received: by 2002:a17:907:96ab:b0:6e8:8eac:5c15 with SMTP id hd43-20020a17090796ab00b006e88eac5c15mr12969020ejc.355.1650365099298;
        Tue, 19 Apr 2022 03:44:59 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t12-20020a056402020c00b00422e7556951sm6010555edv.87.2022.04.19.03.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 03:44:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v2] ARM: s3c: mark as deprecated and schedule removal
Date:   Tue, 19 Apr 2022 12:44:56 +0200
Message-Id: <165036509377.184867.10089560951309894557.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407072319.75614-1-krzysztof.kozlowski@linaro.org>
References: <20220407072319.75614-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 7 Apr 2022 09:23:19 +0200, Krzysztof Kozlowski wrote:
> The Samsung S3C24xx and S3C64xx platforms are very old designs. S3C2416
> was introduced in 2008 and S3C6410 in 2009/2010.  They are not widely
> available anymore - out-of-stock on FriendlyArm (one of manufacturers of
> boards) and only few specialist stores still offer them for quite a high
> price.
> 
> The community around these platforms was not very active, so I suspect
> no one really uses them anymore. Maintenance takes precious time so
> there is little sense in keeping them alive if there are no real users.
> 
> [...]

Applied, thanks!

[1/1] ARM: s3c: mark as deprecated and schedule removal
      commit: 436ce66003d5020ca02cd096761d3214e9a91d82

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
