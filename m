Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24910507C02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358044AbiDSVk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357589AbiDSVkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:40:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0572381A0;
        Tue, 19 Apr 2022 14:37:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso2422207wme.5;
        Tue, 19 Apr 2022 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7p1Gt5eSszIemMmYJqwsEeg+kDyMhPcJkhp2kyyqN4=;
        b=NLBk11woDKHHGDl+VCAXAD6pFS8dRoTN/afh+F7tONY2PHeyhamN+4bxUC1FGXTrWd
         Ro/Ez9H1ep36GkoEK1t7TYTBIs2pMvvjpjYxP9kPrmPiAQ/+AnPbZJkUBn7U+/XKbcV/
         VkGJLHqnguqnDpm+RaWAWaodYqZBneGIaC9WFD1qGmmq8TEOrYrXBxU7HP/4wjrufkp8
         e2R3ph3bY1mm0GZ3YT+Wy89g7x/5ai0K6jN41yzfgf8a2OIMmhVF3hhFb+8KdbkzLaHq
         7bqTVjiMNvnFjFuMqVORJKNiyl7+9jMlyoV3FmHLf6p4l+62AqUeFaFohFMaSFqIx4pM
         bY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7p1Gt5eSszIemMmYJqwsEeg+kDyMhPcJkhp2kyyqN4=;
        b=kzKQASPyTcEAewEWUTM/ky7LLU4dF5UIFg5MDx6IDclVEW4D8eI7U6k1XVyTNRWGi0
         WHNoovu4JW+c3Qyc7T7/W5g+HmPM/KN6MTtoyIB78lomLUhn4xplxe+CsoZfX01QuTod
         vgiiywgJqPtFn9Od7Sap+F1Tw6R1B06355GEHGJo3xUxeTwUI8pnujdnEgG2x5Y5sKIO
         wnuTl2t3EPXqY+fvo7rIvo8EuEiO4VbPFFNKnATZy53Ra1X5sY2QMmQS2hkkSe/aMJ+t
         14Mcs7+cIVSZeUmL8r9yAXtJAdHcxipRIlxY31Nev0m0hXMRVCr4z0yVJg7EbPDQ4kdu
         O/iw==
X-Gm-Message-State: AOAM531Rq8/S8i3uTubItyCDXSUSeu5VuklSDrGQ5/JANqZyF2AvDw5h
        SfdJ6mR9WYif9WPOjRbuYTtu9j2ENQnOtw==
X-Google-Smtp-Source: ABdhPJwpjpvhyGersigN6s/CjRmiwSIm/QL4n5iHY9MnK4ORxYthmslha9ekV1m8Z4I2nFjBoDF8jQ==
X-Received: by 2002:a7b:cf05:0:b0:38e:b707:1c3d with SMTP id l5-20020a7bcf05000000b0038eb7071c3dmr494093wmg.164.1650404259313;
        Tue, 19 Apr 2022 14:37:39 -0700 (PDT)
Received: from tpt440p.steeds.sam ([69.63.75.250])
        by smtp.gmail.com with ESMTPSA id n4-20020a1ca404000000b00392965e41d6sm6574512wme.39.2022.04.19.14.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:37:38 -0700 (PDT)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     sre@kernel.org, pali@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 0/1] power: supply: bq27xxx: expose battery data when CI=1
Date:   Tue, 19 Apr 2022 23:36:46 +0200
Message-Id: <20220419213647.1186284-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.2
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

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>

Sicelo A. Mhlongo (1):
  power: supply: bq27xxx: expose battery data when CI=1

 drivers/power/supply/bq27xxx_battery.c | 58 +++++++++++++-------------
 1 file changed, 28 insertions(+), 30 deletions(-)

-- 
2.35.2

