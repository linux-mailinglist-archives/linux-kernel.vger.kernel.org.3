Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD14A777E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiBBSHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiBBSHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:07:00 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC5EC061714;
        Wed,  2 Feb 2022 10:07:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id me13so58313ejb.12;
        Wed, 02 Feb 2022 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ma7yN3YVsnBY91NgNwHFGydIC7ujN7S83S2CFfG+gRM=;
        b=Xu/UWZdb7B9+ItD8kFA3Bki2eWLDaWwoyK3TUdZju9y9JPymPMH/4zEDdKyzU+zxrh
         gKqbAq8LEM23UL0IYE9B4ZRrC+m0YFAt4stoE2cyGB36329D4XbPk+7E+9YqH4o2PJxc
         4ALfh5ZZSDXHVX757h99ZrMVNiSjqyJ0c5dPKQLuUqwJrx3WFJtkGMIfYN5CK9F8Zso0
         q+/rwuqaUdFJVOO9c324pg4nKz89VcaKfWyH+EgrU1twORCGgOsUDejzYzmGWv60Vd/h
         vJ4re/cUCPgLGPuGnsyjxJSQy1fC8tvFSw3yYYz+yHzUnPa5Gnn9uuKCkPn8W1r0nAS5
         mmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ma7yN3YVsnBY91NgNwHFGydIC7ujN7S83S2CFfG+gRM=;
        b=eT8jZC2hrw2TMZaLQmA5y2i/p/uPI9Q0WC9Cg4GmJ3cnTO3w+FtseY1KcSPrI09Ypz
         4PPyJRMRoHnjwppWFCGlp1UXGPURTp3s63YSPsjodYyk2jV9+Lhf439hrCk0lY/JvxEr
         ZI0Fvz9fyGtHxqjMxlWim/yQQuuVW2w0qriFAxXn0wu+FjWD7YJxynQqHHLXb+f3ZC2n
         cQg8ZZdFDakOPY8CJtrKhVBNFoTbx4lYZznJA96H9yHXfoayz74QVQcjsxNTGb/3rXBr
         4Q9i/ZlBxhN/OkRt2pKJSDSPtfDXg4xz7ATmj6mhQ3Fm7Xf7HYIvvg5PzrpQYvar1kwA
         ev4g==
X-Gm-Message-State: AOAM533qiuqqFAJdwfCXnihnQsFAwH1EYqlhAMkXPbpWDQJRDtqJdjx3
        UOsgDGk2zfd8U+zGqRaK6X8=
X-Google-Smtp-Source: ABdhPJxtyYJqvq5ScrRD6iklI4Q9hPZFkOrkHigYBiZZaVUECPjqt16QRY4o2ycbjHNxzWzFEPxSQQ==
X-Received: by 2002:a17:906:30c9:: with SMTP id b9mr26742139ejb.377.1643825218949;
        Wed, 02 Feb 2022 10:06:58 -0800 (PST)
Received: from localhost.localdomain (p4fd5939b.dip0.t-ipconnect.de. [79.213.147.155])
        by smtp.gmail.com with ESMTPSA id ee37sm3223005edb.106.2022.02.02.10.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 10:06:58 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, eugen.hristev@microchip.com,
        adrian.hunter@intel.com, nicolas.ferre@microchip.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH 0/5] Use of_device_get_match_data() helper
Date:   Wed,  2 Feb 2022 19:06:43 +0100
Message-Id: <20220202180648.1252154-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

*** BLURB HERE ***

Bean Huo (5):
  mmc: wmt-sdmmc: Use of_device_get_match_data() helper
  mmc: sdhci-tegra: Use of_device_get_match_data() helper
  mmc: sdhci-omap: Use of_device_get_match_data() helper
  mmc: sdhci-of-at91: Use of_device_get_match_data() helper
  mmc: davinci: Use of_device_get_match_data() helper

 drivers/mmc/host/davinci_mmc.c   | 6 ++----
 drivers/mmc/host/sdhci-of-at91.c | 6 ++----
 drivers/mmc/host/sdhci-omap.c    | 7 +------
 drivers/mmc/host/sdhci-tegra.c   | 6 ++----
 drivers/mmc/host/wmt-sdmmc.c     | 7 ++-----
 5 files changed, 9 insertions(+), 23 deletions(-)

-- 
2.25.1

