Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBA254CF39
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350002AbiFOQ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349990AbiFOQ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:59:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CF52E084
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:59:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so2601417pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgYasgJyDkLKxGP7tFRjaW6ZIrdHuMDeEyRzo2a6X1Q=;
        b=gnmHEB9YtHSr56xHMm+Ju6lUiJNhW1rHa8GBLrPRWPAKDMVAH23PB6WOAVuUtiEyDn
         UkSMu1knR7p2h8iUbFoq+px2Oipj3Ep7zqXuNY1eAoL1Qk5WQnKsYclgY3ZunxMdEEmO
         pw5998B9AhlvSn2Q82yKmOzxD0rD6dOq9sjSLFnLr4j5aba5+5aY99Q7KjeagLLeEDX3
         QZzmCuBMtpj2NS1K0WnuqzUfFOzi7Z9GpkoF2cgglcA40uc4Sl8/CqNct3HdOEAe4OuV
         rzMgmQlP8UGyA7KdX5/5Pt4ob+KcVBCz3gvvl2Oh78LGcHvCPB+rKIwaFU7NkTXkjpIH
         SOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgYasgJyDkLKxGP7tFRjaW6ZIrdHuMDeEyRzo2a6X1Q=;
        b=WPCdsQ4kWYI9k0keMwOEedGIeuBmBCVa9vFLQaSNnePcDrlS66ZNaJJwIM7e0HOmUu
         U13VW5eCyHDOAWjMOn4zjUs38druvMZLyr1034Xni9TvPTGc9PGhL1EAIGmo9aMF0hku
         xoOt9VEM69CJpnxnjgI8oqDWRWuDfvLeZoZ1cia0Wfr19g5KJ6x9AImnhyj8x498+5Hi
         1AYNKr0DCUHHj2Bviral9bnxYbpZQUaQ1QKF7e/7bQYo+rBh98r1kNyh2k3pYJG2EeTu
         urSXksYceh4yURxPfTtczLe97Rceh2hnfepxHPcnMDGJpvFXEuiw3bGqGkcOMD8x7NBY
         QRlw==
X-Gm-Message-State: AJIora+VMOWGhcmaMe/uBsVyyQS2DgRF0JqZTmWkHEjiXDEbmae8sRpQ
        k1+Bd7XCWF+MY5DXcRcD5xAnkg==
X-Google-Smtp-Source: AGRyM1tnLfxVY9k3xmR/MfAeKNGvzGPQaEJLVgW4JQvZSmUXpNi8brcF++WTTbZZTcGSrY4lVeQTgg==
X-Received: by 2002:a17:902:b714:b0:168:f72d:b8d5 with SMTP id d20-20020a170902b71400b00168f72db8d5mr519478pls.66.1655312372688;
        Wed, 15 Jun 2022 09:59:32 -0700 (PDT)
Received: from localhost.localdomain ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id s194-20020a6377cb000000b003fd1111d73csm10618513pgc.4.2022.06.15.09.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:59:32 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: ipa: more multi-channel event ring work
Date:   Wed, 15 Jun 2022 11:59:24 -0500
Message-Id: <20220615165929.5924-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

This series makes a little more progress toward supporting multiple
channels with a single event ring.  The first removes the assumption
that consecutive events are associated with the same RX channel.

The second derives the channel associated with an event from the
event itself, and the next does a small cleanup enabled by that.

The fourth causes updates to occur for every event processed (rather
once).  And the final patch does a little more rework to make TX
completion have more in common with RX completion.

					-Alex

Alex Elder (5):
  net: ipa: don't assume one channel per event ring
  net: ipa: don't pass channel when mapping transaction
  net: ipa: pass GSI pointer to gsi_evt_ring_rx_update()
  net: ipa: call gsi_evt_ring_rx_update() unconditionally
  net: ipa: move more code out of gsi_channel_update()

 drivers/net/ipa/gsi.c         | 59 +++++++++++++++++++----------------
 drivers/net/ipa/gsi_private.h |  3 --
 drivers/net/ipa/gsi_trans.c   | 28 +++++------------
 3 files changed, 40 insertions(+), 50 deletions(-)

-- 
2.34.1

