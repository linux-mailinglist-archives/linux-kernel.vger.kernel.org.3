Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44B549D81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348995AbiFMTW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348932AbiFMTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:21:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594583204D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:18:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g186so6135739pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=juaci2PeoXcL+nqMkUy89lNr7q7tNb6TUDgIbRhaIWw=;
        b=dk7XnnMMUNUZeH5USqPH5eZIK+N/ookTgsHOsMjDEB6TfQFu+xplzvknAaEAA5K+U3
         9B7t0ZBMgJWojLC47fY0XfkYlL/VJR9bHUdpolFbttYo2cJv6A0NQ9Lmdl92WCPvbg5b
         Hm+WOdccIVztYuewNGEy2w0KaMbSSDh/s0weK5Re7WDlkkZ0B8r6qYHhPUAuuAfLT8jK
         GrTTMM9Uk0JHQjr162JVES4M8b+4QHCCXq2cVckkoMk1DGxLgSY4TvLmeM/kMGauQRvK
         oNKt4avN8PfrMNbTKKm6MP6rtIBrTaJKF2KLoSEn5XU4pEdGVAUksxL/ykuyyUwnpitp
         OYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=juaci2PeoXcL+nqMkUy89lNr7q7tNb6TUDgIbRhaIWw=;
        b=naoa4IdQAsdOka0cChFo2mxeFEOiYe7bg1wDvRvZwalaaGgLSV4gRnw31QivRQ08zS
         oTIGaKK0Kqb4Ei1uSe8dGFwnfb3YND9k/igUUr96zx50/pNrkh9dj/yOHrYG+CvnCJwn
         wiOFds3U14cTNfS+MSzmtrEtSCrI+fKLhw7nEzj54d5pqzR8eMX9WLJz0A/tZ915WUEu
         QcVWEcNRF7LRbiR7HO1GgagnPAZxlwfBEXQcU0azEdvjrlh8pYEij9M4Zdf3Wif5H6JL
         /2ReyBs53G0Gg4vUmOFycSZEsf8/bDSx1zIJXBT9+c+sbUgiD+gtrJuIX/vy3LUKIem5
         p+sw==
X-Gm-Message-State: AOAM5318qb7E3E5/DoHBHYlqVB2/5A1YfKcA9o8PlwEQnPTH+tdJZBW0
        cNyIYiaizl4J2nWC0Pjz4h0ZQw==
X-Google-Smtp-Source: ABdhPJwcTcXOF9xRG3dPFI9a4nx8eDN+e296+S49xU51P+CvYepm9W234zBxio3nRmKFJRYBFiXIbw==
X-Received: by 2002:a63:28c:0:b0:3c1:6f72:7288 with SMTP id 134-20020a63028c000000b003c16f727288mr551294pgc.564.1655140683760;
        Mon, 13 Jun 2022 10:18:03 -0700 (PDT)
Received: from localhost.localdomain ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id u17-20020a62d451000000b0050dc762812csm5646641pfl.6.2022.06.13.10.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:18:03 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] net: ipa: simplify completion statistics
Date:   Mon, 13 Jun 2022 12:17:53 -0500
Message-Id: <20220613171759.578856-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch in this series makes the name used for variables
representing a TRE ring be consistent everywhere.  The second
renames two structure fields to better represent their purpose.

The last four rework a little code that manages some tranaction and
byte transfer statistics maintained mainly for TX endpoints.  For
the most part this series is refactoring.  The last one also
includes the first step toward no longer assuming an event ring is
dedicated to a single channel.

					-Alex

Alex Elder (6):
  net: ipa: use "tre_ring" for all TRE ring local variables
  net: ipa: rename two transaction fields
  net: ipa: introduce gsi_trans_tx_committed()
  net: ipa: simplify TX completion statistics
  net: ipa: stop counting total RX bytes and transactions
  net: ipa: rework gsi_channel_tx_update()

 drivers/net/ipa/gsi.c         | 77 +++++++++++++++++------------------
 drivers/net/ipa/gsi.h         |  2 +-
 drivers/net/ipa/gsi_private.h |  9 ++++
 drivers/net/ipa/gsi_trans.c   | 68 +++++++++++++++----------------
 drivers/net/ipa/gsi_trans.h   | 15 +++----
 5 files changed, 87 insertions(+), 84 deletions(-)

-- 
2.34.1

