Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58214FED9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiDMDgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiDMDf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:35:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E43D58
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:33:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u2so591130pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFDMYEJJJV4Dm4yq2iSPTcjmX9mNaLzAYx2JFyM8cxU=;
        b=UQYAdhGry+SuSzcGGY9z2ZyE0Fmpw7Zl5XqiQsCx1LE+kdYD7uNE/J+kjhveH3HQAV
         wGoUNxLBXw1pQjCyPJnbNrY/2J9tDkjLEkg7sQABZVTX8zm1JU29wTf3AP2isq2wnuX6
         Fsen15PJeUG5cP5g/ckjxlFriKKe1viowIJrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFDMYEJJJV4Dm4yq2iSPTcjmX9mNaLzAYx2JFyM8cxU=;
        b=NZS/GNFd+F5cBZKfbQcxfHIgQVOKStnsQtEcPwSpeKNqF/SbrqhwDUpCGwzeiFRD3H
         mGok1UkoFWxIxde2IHfck4YieWNXT+Pt0yxCZ2FjXLH4g7fRt01IrROAxblBfrNNa/K6
         Lonlj5AHug7o5W+n4lKsA+iF7xWEJCGgGA74/5AHbuhcoysQgKZgQaaLZWf3zRc5f6mr
         s41cQDnBJpAWo0IKxjd94LPtQ7OgRSDvVvlFI2nta4vVGR44Zl9LFxPJeV3ELOPXvuFn
         lKdyVxZTCFGVCxj9ocBqAO38nkU+GSU0FHaiohWO1wdWMyZeSLapaSy8rJMytZE8Jg8z
         SONg==
X-Gm-Message-State: AOAM532TFuZ1Euk7Xt/i0klb42KE7KqGOM9F/Y7scKQ58H+pmHJUvbNf
        FGGTf20kfnhASJc0dJk4jwkk5A==
X-Google-Smtp-Source: ABdhPJxo/Vu7AljpfVLohpoNHB6gSDViR/XOVE6fP0sezT0TZemgRYmKXJC1JNokbplnSB6Im1W5LQ==
X-Received: by 2002:a63:770c:0:b0:39d:adf2:ba83 with SMTP id s12-20020a63770c000000b0039dadf2ba83mr1811498pgc.184.1649820817164;
        Tue, 12 Apr 2022 20:33:37 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:87b3:e0ea:c924:6d1f])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00230a00b004faa0f67c3esm39788276pfh.23.2022.04.12.20.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 20:33:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH 0/2] Input: cros-ec-keyb: Don't register keyboard if doesn't exist
Date:   Tue, 12 Apr 2022 20:33:32 -0700
Message-Id: <20220413033334.1514008-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're registering a keyboard input device on detachable chromebooks when
that input device doesn't generate any events. This patch series stops
doing that to save some runtime memory and to help userspace understand
that there really isn't a keyboard present when the keyboard is
detached. The second patch is an RFC because it should be picked up
through arm-soc tree, not input tree.

Stephen Boyd (2):
  Input: cros-ec-keyb: Only register keyboard if rows/columns exist
  arm64: dts: qcom: sc7180-trogdor: Remove cros-ec keyboard from
    detachables

 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 5 +++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 5 +++++
 drivers/input/keyboard/cros_ec_keyb.c                 | 9 +++++++++
 3 files changed, 19 insertions(+)

Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
https://chromeos.dev

