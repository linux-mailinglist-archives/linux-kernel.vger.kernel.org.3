Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49633534990
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345064AbiEZD6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiEZD6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:58:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4DC0383;
        Wed, 25 May 2022 20:58:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gh17so762690ejc.6;
        Wed, 25 May 2022 20:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryz8jK++qtmZIXX/BrHOdAAZhVGZsYPnM6ClGJVY9A8=;
        b=S55ylpkB6fuQ1PGbn2P5P5UhWWx3kcHmsG5HZK2jwVXe3Iut3SBezShGT5njxgq0mw
         U5N6A9FvK3mKOgPk4kgzaVpVF3AppJ77RBHGiOYyY9YZcQD8pZDdfQrZG2sKzkQRH3pZ
         3keWop+G5WWoLubILTEGID6J4xVzuSjYi+ypH6scBniDH3Rw3FRz2/5g3OiuCAIOSLv9
         PLH7AIckToq3Cr9HYCRCjXEhNp1/P8aMJOBaZZKTmER9kkM8qT2jzshXPU0UfbIDwVBm
         X34TpIvBBgFl4PUCRfo38txv0UlYPx1a+P9yEZJMVbxHpmGggLgRjd4sRAP5VNJPP/V7
         VCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryz8jK++qtmZIXX/BrHOdAAZhVGZsYPnM6ClGJVY9A8=;
        b=XnSmBqvlDfzpIgnASFyY/6a1OD26B3mxB5v/LNKdDXbpDf9BS55K7kjuBDrzBmJ+l5
         ubDCpuzReWE97O+1p7Gtj7xh3Y72iO3qYkYb4iK6MDrIwdHZCWacnfA8+gBfoI+4WSuD
         IPDzXRXBSHJu2deG79ejvM/J6+6P4dcPapx+W+virgSOYCA+qU+NacELI7rzP54sAb/c
         xFWvLAWYjh19tWqCKpQikjuqwsmdwo/G/E3x8l5W6/UBH7AXBHOGaKh07IyK18UNS3mK
         FTZOKnjyMF853QJXo0FwG7djpyXIP3ZncqQJpywcsi57FjrMs1ptMWV43HT+nMWthPME
         xX4A==
X-Gm-Message-State: AOAM531HY5rmkBUMLsBiJED9SjvESZn2HjlEgADVnzPrqAWdpIhHG8Jk
        KQV57Tk6ZgNdWqml7ORFG2U=
X-Google-Smtp-Source: ABdhPJwt1RobKJEH1XYuez7hTKhtcGRGQk/3RRcwsTtYnW2cjHSbunaO1Y8OFENQajFFIbcBpkC07A==
X-Received: by 2002:a17:907:9496:b0:6ff:1012:1b9c with SMTP id dm22-20020a170907949600b006ff10121b9cmr6168784ejc.457.1653537527084;
        Wed, 25 May 2022 20:58:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id c13-20020a50d64d000000b0042617ba63cfsm206621edj.89.2022.05.25.20.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 20:58:46 -0700 (PDT)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 0/2] Correct "div4" clocks in Exynos7885
Date:   Thu, 26 May 2022 07:58:38 +0200
Message-Id: <20220526055840.45209-1-virag.david003@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The div4 clocks in Exynos7885 were mistakenly set to have the wrong
parents making them and their children display 2x the actual clockrate.
This in turn lead to the DTSI getting the wrong clocks for UART, since
that's the configuration it worked properly with. This was noticed by
Sam Protsenko [1] but since it worked this way and not the other way
around, I didn't think much of it.

[1] https://lore.kernel.org/linux-samsung-soc/CAPLW+4k3Vmg0W0jVsTChHTG8+eeg=5QF+actz1Tk0vNV9w-y-A@mail.gmail.com/

David Virag (2):
  clk: samsung: exynos7885: Correct "div4" clock parents
  arm64: dts: exynos: Correct UART clocks on Exynos7885

 arch/arm64/boot/dts/exynos/exynos7885.dtsi | 12 ++++++------
 drivers/clk/samsung/clk-exynos7885.c       |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.35.1

