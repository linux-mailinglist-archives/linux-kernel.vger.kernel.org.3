Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504E450882E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378568AbiDTMeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378556AbiDTMeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:34:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5198E40912;
        Wed, 20 Apr 2022 05:31:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q3so2050386wrj.7;
        Wed, 20 Apr 2022 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FgnqC9bRUlZPRTGJ0+j/kZyJEtMjStFTln7fWbmDgz4=;
        b=mfEYirzx76v7kG+/3n79xx810Nk0iF4FjcmEpr55et8kKbA+5kPuLnQnor3t8+4WN5
         JKWUtGNbS0EB4JlKh5F8EqFTPvmhXU2m6nQYU49r1vSStTlpToOaLP5kaq10lw5xAR/x
         ZlA9GUST0tgLmoYghedu0mbYPyQEM79EqfkRp10rCG745FEDgFOeGzvpYXIGTxmM8HGs
         oxVyPlTlvlpB32ez1EwZ953fz1FV5N+mUYWwm+lNTG3+HQlgZZ0eWzoGyRIyz1aVlupw
         pWNbabDsl4Gw1407ZFz+kySGDO7BQwzEnccH6evPzWHHM2c1HuwV2ZH2mN/jqZhbl7c1
         LKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FgnqC9bRUlZPRTGJ0+j/kZyJEtMjStFTln7fWbmDgz4=;
        b=rS9Ci/JVWvL4DPMCSBlGfehrVKF5crH0gZ8iTMpNDlRGa3Tp/mQl+BqxK7zi68HgwM
         KxWtEZvNneAI/M5oIBa7ii6F+/WY3M8lA+J73gdEzb2lluWYD8y5j7kVZ9/GaIzZb8YC
         9Xolru6qcReoWeEfPmebR+WvRkJ08uN01XJhsnK7RMjelpaiIb1vG/veIUv5Tfd/ou0H
         DPrMr+qGIH3Z678AGrU9g3bL2n8sgwq7nDlGOs4SZijJ/wi5g7MhX1EE5OIHZwTyb8a3
         q1QCh6XOOL8gVhaesJHybK6dOpdbXkgdz2I5IAMgOERF9r6qJ6j14vh9h222azDCtYTr
         c+Tg==
X-Gm-Message-State: AOAM530D15HuAiMMD2dCHS/vx1WbNyDpza9lG1ybRI/ZWMivCEAKwNXD
        LWAMd1Ec5ZmVIOXkMfB/VoU=
X-Google-Smtp-Source: ABdhPJzP1pkV5UtrWecTxbP1L1o82e4X/1/e6TahNaQTgZfRxAbn1HL/X7RCebkw34DpjMQwjMFTBg==
X-Received: by 2002:adf:d1c6:0:b0:20a:b006:85ec with SMTP id b6-20020adfd1c6000000b0020ab00685ecmr2069283wrd.334.1650457887536;
        Wed, 20 Apr 2022 05:31:27 -0700 (PDT)
Received: from tpt440p.steeds.sam ([41.84.241.188])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm21277277wmq.35.2022.04.20.05.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 05:31:26 -0700 (PDT)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     pali@kernel.org, sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2 0/1] power: supply: bq27xxx: expose battery data when CI=1
Date:   Wed, 20 Apr 2022 14:30:58 +0200
Message-Id: <20220420123059.1206443-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently discard capacity information provided by the chip when the
Capacity Inaccurate flag is set. However, in many cases, having this
stale data is better than no information at all.

Even if the chip has been fully reset, the datasheet shows that capacity
values (NAC specifically) can be seeded by using the WRTNAC facility of
the Control and Mode registers. After seeding, CI remains set, but the
capacity values are as accurate as the NAC value provided to WRTNAC is.

On the Nokia N900, such seed value can be obtained from rx51_battery,
which reads battery data directly from the battery's BSI pin. This can
be done in userspace via i2c access to the registers. With this patch,
once seeded, capacity values are available through the driver.

The patch was successfully tested on bq27200 on the Nokia N900.

Sicelo A. Mhlongo (1):
  power: supply: bq27xxx: expose battery data when CI=1

 drivers/power/supply/bq27xxx_battery.c | 59 ++++++++++++--------------
 1 file changed, 27 insertions(+), 32 deletions(-)

-- 
2.35.2

