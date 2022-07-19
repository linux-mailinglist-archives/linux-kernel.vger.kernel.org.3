Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888E857A1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbiGSOkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiGSOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:39:57 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C818854ACD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:35:57 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n138so10688330iod.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BjWGlK630QXayY7IJgfAR9lOEt/Zu0JUnJ3PIy+Dok=;
        b=WF/dbHsOdzJ1VTngL102ErO61fUWa0iCm76xtFZijwQCoZc9fWP6CbuAEq2wYqyuWA
         sHg+et+tbk4UjBTy7aJVlMCkSdUDQbrcDatNEJqX0IcSWsE0+aM8emv9waHZNruTEeG3
         WV7ctcsHv1yhExgWPo2j32CzPjJOOCBBM6hnqYsGlpFtOhPzV2TIezbgTOQvWU+/hwR2
         Ghas3GoExiJ6uKXsnEoMZJMszKTatZy8O20xqpHLi2pHza9BFqhXlGMgYAgA0DqHeLXS
         iaIUBfvmaIWh1sEBdt/sg5vc/8bZyxSCZ0n5UnHovgcdXJWeNBIQYZ8Mv3c3V+sUfQ3g
         3MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BjWGlK630QXayY7IJgfAR9lOEt/Zu0JUnJ3PIy+Dok=;
        b=lLIWxGDGvfSsECZX65YErzjz8HjavOkD15JSjx7EZZkQ8QY6TDrsSBq5VFOxcKjulu
         6apRUSB/9wRSRh8V7t7f232xKap/wVSSDg9vbdcrtA5u+aislkY/bPbrbAmW0bY7Nogu
         AjPbBKCqt7ARx3JO0RiphhEnIMmGmqaXrRISe+W8RNSLW2+DG3NfBw1+3cG8F7EkakuP
         /XDQOyDU46YDFbh+3b7uhv9DbAx/G5BZcXOJy1RxjG37rm0S6bfSPiVc9d1RpVuk2sSE
         +zzXrSuSn8Lvtxt9lPPwAnrBAzuTNOLOViDhnb7fbiw5w5Yq81pRxBvN5cV8YbypkJZ8
         pteA==
X-Gm-Message-State: AJIora9rGRF60fuiACH6HDM4vGHuw9PB7n8jymG05jJN8eQyqpAywIgx
        fiOqowCwT3fzRG0vPXN/DGgblg==
X-Google-Smtp-Source: AGRyM1sr1oAIhANTJzfCV4iqPvLmtDzqH7kfijam2HMWSxAXMQaxSqWzgC4JjZ3eYhP+jQe6LXTOEQ==
X-Received: by 2002:a05:6602:1681:b0:678:9e4e:cd76 with SMTP id s1-20020a056602168100b006789e4ecd76mr15009127iow.80.1658241357200;
        Tue, 19 Jul 2022 07:35:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id t16-20020a056602141000b00675a83bc1e3sm7286559iov.13.2022.07.19.07.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:35:56 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: ipa: small transaction updates
Date:   Tue, 19 Jul 2022 09:35:48 -0500
Message-Id: <20220719143553.280908-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

This series includes three changes to the transaction code.  The
first adds a new transaction list that represents a distinct state
that has not been maintained.  The second moves a field in the
transaction information structure, and reorders its initialization
a bit.  The third skips a function call when it is known not to be
necessary.

The last two are very small "leftover" patches.

					-Alex

Alex Elder (5):
  net: ipa: add a transaction committed list
  net: ipa: rearrange transaction initialization
  net: ipa: skip some cleanup for unused transactions
  net: ipa: report when the driver has been removed
  net: ipa: fix an outdated comment

 drivers/net/ipa/gsi.c       |  5 ++-
 drivers/net/ipa/gsi.h       |  6 ++-
 drivers/net/ipa/gsi_trans.c | 89 +++++++++++++++++++++++--------------
 drivers/net/ipa/ipa_main.c  |  2 +
 4 files changed, 65 insertions(+), 37 deletions(-)

-- 
2.34.1

