Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5FE4DB1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbiCPN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiCPN7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:59:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F4E443F1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:58:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a1so1718191wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6vRm7DFQWhptVouBz9lNoj2sjJPbt8GKE52QtweUyM=;
        b=PKKdDEqaCO10/rc/G4bcQjaSk1hrihkTPnkC4h9ITtWhr52dOC+zBfUgLtBqp09rzZ
         E6fMWCnh8R36SaKUEMGMCBQIupa5jYlORDOvgycd4XSnmq3RQ8hux8mweEpmihLQHfFN
         iX2Su/t3Qa0mzEHn0OE6eMd0PnJzfc61emUZKeWW/Nm5DwA8xmrghfdFgTDWmbCWBMpf
         hfRxhIJWj4mWGZLPVnbZxSGMdbWYxVO6cVfGXfxcmhbw728WHbriSj5S9mhaL6kJ73F2
         rw5U7L/zko4L4yOMKFvdPIRq/oQHwoxP/nmLo1L9ooniPu9eOphnA5wUG68jppspRBao
         iQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b6vRm7DFQWhptVouBz9lNoj2sjJPbt8GKE52QtweUyM=;
        b=q0l9q9h7OOtreUrWzacuyBtQKlZTtYas3dcPJWm6S9mfmAtYMyWpBQWxYFZl5bE2PC
         ZNWsxwJsdgTTn5F59EH1sY/E7C1kRN2+iZ+QEcFK8upuoTFyfGJ7iMW4PemNUTVJEYSn
         jLjOdBKGDMrqq+2rCdVYCqa1Psu5Iz7OFE956b293jElPRFsSNdbiG12IadKg64CKAQf
         04uUJvfkRDovFj1IAlApIbjX9vY5S9AQNNvuvGq0IdlvFfIJU6Lw2V4/pKDAKIxrHqMo
         ESXuovFVerlylbFqRhWuNUgJRlrGUeLlTe2uboxoZVUQcYQdx1VMlhYGa9jobYAC2w06
         LMgg==
X-Gm-Message-State: AOAM533OSBwGW/lZBTnUuHPifdy/Ca28GbBhU9nSnF7jxUB4BRVpMAUf
        a92Qrq2Xyf7SkYxGaEam9Y78fQ==
X-Google-Smtp-Source: ABdhPJwzHiIKP0+Q4q4J7rkc1uIhEVZWdpLU0KdF04jlKVLkBlHig0tKFYV5ztMniLZCI56EUEETXw==
X-Received: by 2002:adf:ab06:0:b0:1f1:de8b:ecd with SMTP id q6-20020adfab06000000b001f1de8b0ecdmr114110wrc.156.1647439110584;
        Wed, 16 Mar 2022 06:58:30 -0700 (PDT)
Received: from localhost.localdomain ([37.173.241.155])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b00389a420e1ecsm1790563wmb.37.2022.03.16.06.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 06:58:30 -0700 (PDT)
From:   Nicolas Belin <nbelin@baylibre.com>
To:     narmstrong@baylibre.com, andrzej.hajda@intel.com,
        robert.foss@linaro.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH 0/3] drm: bridge: it66121: Add audio support
Date:   Wed, 16 Mar 2022 14:57:30 +0100
Message-Id: <20220316135733.173950-1-nbelin@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the audio support on the it66121 HDMI bridge.

Patch 1 updates the ITE 66121 HDMI bridge bindings in order to support
audio.

Patch 2 sets the register page length or window length of the ITE 66121
HDMI bridge to 0x100 according to the documentation.

Patch 3 contains the actual driver modifications in order to add the
audio support on the ITE 66121 HDMI bridge.

Nicolas Belin (3):
  dt-bindings: display: bridge: it66121: Add audio support
  drm: bridge: it66121: Fix the register page length
  drm: bridge: it66121: Add audio support

 .../bindings/display/bridge/ite,it66121.yaml  |   3 +
 drivers/gpu/drm/bridge/ite-it66121.c          | 629 +++++++++++++++++-
 2 files changed, 631 insertions(+), 1 deletion(-)

-- 
2.25.1

