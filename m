Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB554F1ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382703AbiDDWJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379349AbiDDRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:01:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC693ED39
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:59:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b15so11885390edn.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9yJQc0wkhnwMDhgXpgCEfPM9bu3vOLPPiNhGs87tdw=;
        b=cgzwMQNJrkEkuA/TSpVw6ciE+AieAtsIUBAX0inodIP9kosF+epgt0L0EnhY8Z9Dq9
         kXrcX81qBx3Q7UBgZbAOjmYZrAOZGfpwoQF1NvDKCCGvlkvhvcuHO4WrBHhz2U74SaEY
         yGz9bYq2L1EQDNZ8orhmVvYivWFaRt8lrvnUF+f0K4ElLK6f4wUydgxDANLzF3m5Ygcx
         0nO5acxv0nuE1jwJcjwhow5VDytwsOkLCOobrY5Yl+b1js/TQF1HfysRSxsxIc6Oics8
         j1ITZLN/ltYeBvypuH7UAWz5bTKtDIVObpgrMNbtPPy1wtf/uHmOzEGEB886B+n8kAh5
         Vctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9yJQc0wkhnwMDhgXpgCEfPM9bu3vOLPPiNhGs87tdw=;
        b=0Mpu/SjGFZ68EQd1TgjYB8rZ1ULiGVwjpbbF7qDy2fLil3C9YGbISRd2/6Qd3wDhVw
         +pIznzPgytaKKA0p8ZyzawF/U8NGCZFrdvX0HXkiOy+BEQPoyo9Flk98E/KSUhEnrl1O
         ApnWL5cMzd8Q4bL2fdMyRnHRFlizCt9dVWOQX6qaRZB9ytA5lr/UXSpj2i8JLoO2xrEM
         e0nC8eSRmEB3h0iC/Y1a6mfJBvCXBDGpDDGu0AgKXYNY4d8GZDn1i08vCrjgFF+5lzUD
         Ci/4LbNMCOXDIT1H/pVjTN2JUS5vlNKteMB6o9KeCc2dn4I435OXx0Zr98V3slq65jg0
         JSgA==
X-Gm-Message-State: AOAM532J9XRdh7ASP7Bkr0PQq7qGf5/AzqxZEdKoCGkZrnBK85Kft51C
        tQmyQaSfUIMGqiFVqC0KdgxQrw==
X-Google-Smtp-Source: ABdhPJzBhdE3FgiK+1M2zu1kC8mpq7C8emkC1dljmr9hgg9ou7CPhZBlTrACZ/AtTHyx2qnVlgtpJg==
X-Received: by 2002:aa7:c1cd:0:b0:419:fdb:e17e with SMTP id d13-20020aa7c1cd000000b004190fdbe17emr1156256edp.364.1649091579797;
        Mon, 04 Apr 2022 09:59:39 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bp11-20020a170907918b00b006e6d451dc36sm2938072ejb.49.2022.04.04.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:59:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pinctrl: samsung: staticize fsd_pin_ctrl
Date:   Mon,  4 Apr 2022 18:59:33 +0200
Message-Id: <164909156896.1676419.11230425886960608496.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331194526.52444-1-krzysztof.kozlowski@linaro.org>
References: <20220331194526.52444-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 31 Mar 2022 21:45:26 +0200, Krzysztof Kozlowski wrote:
> struct fsd_pin_ctrl is not used outside of the file, so it can be made
> static.  This fixes sparse warning:
> 
>   drivers/pinctrl/samsung/pinctrl-exynos-arm64.c:773:31: sparse:
>     symbol 'fsd_pin_ctrl' was not declared. Should it be static?
> 
> 
> [...]

Applied, thanks!

[1/1] pinctrl: samsung: staticize fsd_pin_ctrl
      commit: abb860ac7e3f022a233f34b12d035d49abfc114d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
