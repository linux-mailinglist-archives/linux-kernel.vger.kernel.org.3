Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062824F472E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbiDEVDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447329AbiDEPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:46:18 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A018D91565
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:21:08 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso4079128wma.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=m3vxItKXnUJTINlJEdj+JcIaXhSRzpBzJXMN0Ho5eps=;
        b=U/rCu1Z2QfNGh7871ZpZdN4wY/+Lh1Wn/I5Ha6phoPhUI3yRDteIeF+TZGPPbHc3Ai
         BBQSP1z5sD9b+wklr0ZXpHQDx20253jpVlFYCml1fsblFB2Q243A1smZeVhSbDbYut0u
         z7IHIiryy2SGXsp58k8lugrnBQWpAfe4UaUoIoiLNUWU6VPrmVSPjgLFVRjjlsnuviJh
         g2vIiFzGHXI6KSMbAEIY16WttCiHeVwLMIUVeWsgv9R9tws08lP2EReN2yTioJTEcmxr
         8dTXpSzd/4Gkzv5UDngHARkRMF8rXO+CxVkuFg6Z/c+C3T3Db9QNzs4r4LR3an7j0BQQ
         bBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=m3vxItKXnUJTINlJEdj+JcIaXhSRzpBzJXMN0Ho5eps=;
        b=dY+cr4XghiiNDq5E2AFWN39V7i2lWNwXnGfqAVwsLwohr/AdAMIHjCDtVin09lpR4X
         MTFTjJSmlwa8vC7wDNVPjXfz11j4P4tE9TfqvhodTb6XAajuKY0gp1Bm+C9JjmcTTgdb
         BboTdjOPdhGS/gUtiAW8FIenJ4SyVYQ1DU6Ens0bti0xtrCg1dvBW1KAxIRnw+Syln4a
         aGgnZVQQ5ykKJfG/HWjbUCFKTi+vWyAOzQs/tKNNjrmsV2DUIxLVYYWjliF2C0v0txD7
         8L1NJoEh/5Ks4swA2PkuQzgKDJqOdvig52XTp9M1BoCZIGjcNcafRku0quDyqMo7YtJD
         lipg==
X-Gm-Message-State: AOAM53120/yRG3VPGfYa7cDuI8ANawVrpoZWTS+dzkl6dZc3F2W+GrCM
        N38W+URgQ6ORP4AwSxHyV8yLNcyeFwMNIut98mg=
X-Google-Smtp-Source: ABdhPJwN5QFMBNAx6z4lJuIDDPZMY0wbemxu/vZ7lASsb58ZkL62PcBPIS8ol+sPOaL6RzriqT4z3Z6RSNAw7S3JJqU=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:4f87:b0:38c:adde:1d99 with
 SMTP id n7-20020a05600c4f8700b0038cadde1d99mr3320464wmq.16.1649168466877;
 Tue, 05 Apr 2022 07:21:06 -0700 (PDT)
Date:   Tue,  5 Apr 2022 14:19:53 +0000
Message-Id: <20220405141954.1489782-1-sebastianene@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH 0/2] Detect stalls on guest vCPUS
From:   Sebastian Ene <sebastianene@google.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, will@kernel.org,
        qperret@google.com, maz@kernel.org,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a mechanism to detect stalls on the guest vCPUS by creating a
per CPU hrtimer which periodically 'pets' the host backend driver.

This device driver acts as a soft lockup detector by relying on the host
backend driver to measure the elapesed time between subsequent 'pet' events.
If the elapsed time doesn't match an expected value, the backend driver
decides that the guest vCPU is locked and resets the guest. The host
backend driver takes into account the time that the guest is not
running. The communication with the backend driver is done through MMIO
and the register layout of the virtual watchdog is described as part of
the backend driver changes.

The host backend driver is implemented as part of:
https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817

Sebastian Ene (2):
  dt-bindings: watchdog: Add qemu,vm-watchdog compatible
  watchdog: Add a mechanism to detect stalls on guest vCPUs

 .../devicetree/bindings/watchdog/vm-wdt.yaml  |  44 ++++
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/vm-wdt.c                     | 215 ++++++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/vm-wdt.yaml
 create mode 100644 drivers/watchdog/vm-wdt.c

-- 
2.35.1.1094.g7c7d902a7c-goog

