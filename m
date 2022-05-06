Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8656051E26D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376458AbiEFXBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445068AbiEFXAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:00:49 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C70D7F;
        Fri,  6 May 2022 15:56:56 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id p3so4937802qvi.7;
        Fri, 06 May 2022 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jiMx1KNAzuMIgpn6LqdJi2ADhn7OHgQMCNsj9Mwa3ZA=;
        b=c/5NIlXsr1gsCXmvQZIu/ByrkSBvSPA+5yIMedNUlzuk0MlGc4OaZfDOL1mNTAOxlG
         kUR+qWhdKmBqEsad++XyNSmPXNZINRJLp/aTCcX4fwqnOurEq1imV3EQJJQTBuNxqHtX
         GE6jQqe/c/M8+QxdNfKZe26Gu1GvyqLT3fdgzRTn1wo6hx8UodL0REqq8g2YqCXaEzb3
         p85wKzLzRDYEJirBjxl8wueyU07H2uKTQLC4SASiotQOubBiMc8aRw9mDisu4UY5y/Yi
         UxyEF8F5a0q4ihRGht34Y65uVdkB+4Y8slAKx15y19kq/f7mq8hPaUn63xGxHISKcdBZ
         GcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jiMx1KNAzuMIgpn6LqdJi2ADhn7OHgQMCNsj9Mwa3ZA=;
        b=gMUSNYpJzqdhJnn/xNcwGrpBjiG3oxZI889uDJyIHrj9la4ARdx3NBgxe0v6m46yXJ
         mA9HYy45sKOT0aSBVxzY2Ra4sq1kqLYvSU+mPc8N7yjPzdXEGb1Qzj3rgHGADyPFRa9o
         8a1sDa0vG0lkMHiGICagKk7iyBWy+8wr+ceYCj7shuLrBQNk8WJgEulQE59nCiu/G2HW
         F7WhWohXvCyMygol0H0sOSTohtIVlfm7nQ9eewh6cNcy4hlbrcJO/rH1TbbVz4zPLum7
         6aZF+y7VRmc/Znsxc6/wheS58okRP5b+6wbp4yUaMl+vU3yGZHUj8R9oyOjIW4nR62HJ
         gGgA==
X-Gm-Message-State: AOAM531YjYGAHuSfQIXPL9DeTDjM96wRL2a7cdbo5VCDTWdnFShMvOnr
        KM1nxELvc9JkgWUpX8LK/cadATa2i+fVpw==
X-Google-Smtp-Source: ABdhPJxrDUwu4Z10IRKqRVGhaH8iLkEjQy2GN2YKD3abQzhKTiYSjD2JqGul25opJn2AVjn8yU3jhA==
X-Received: by 2002:a05:6214:1d08:b0:45a:a692:3bb2 with SMTP id e8-20020a0562141d0800b0045aa6923bb2mr4501663qvd.24.1651877815661;
        Fri, 06 May 2022 15:56:55 -0700 (PDT)
Received: from grrm.lan (bras-base-mtrlpq4809w-grc-17-70-53-205-21.dsl.bell.ca. [70.53.205.21])
        by smtp.gmail.com with ESMTPSA id q188-20020a37a7c5000000b0069fc13ce208sm3187880qke.57.2022.05.06.15.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:56:54 -0700 (PDT)
From:   Yannick Brosseau <yannick.brosseau@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        olivier.moysan@foss.st.com
Cc:     paul@crapouillou.net, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [PATCH 0/2] iio: adc: stm32: Fix ADC IRQ handling on STM32F4
Date:   Fri,  6 May 2022 18:56:15 -0400
Message-Id: <20220506225617.1774604-1-yannick.brosseau@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes to the STM32 ADC irq handling broke the STM32F4 platforms
These two patches bring it back to a working state.

Yannick Brosseau (2):
  iio: adc: stm32: Iterate through all ADCs in irq handler
  iio: adc: stm32: Fix check for spurious IRQs on STM32F4

 drivers/iio/adc/stm32-adc-core.c | 7 ++++++-
 drivers/iio/adc/stm32-adc.c      | 9 ++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.36.0

