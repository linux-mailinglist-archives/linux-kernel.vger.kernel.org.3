Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4584FB09A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 00:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242816AbiDJWH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 18:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiDJWH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 18:07:57 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549A843AE4;
        Sun, 10 Apr 2022 15:05:46 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id t2so14957773qtw.9;
        Sun, 10 Apr 2022 15:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nh3BY/EYiNfImd0QzFgK2E2ecYL3iEaaQiYQ9Tc14OM=;
        b=ozKeQyn3xHVnU1Fs4XtrInbFM+Rs/mT64TzGHHb1h2eJ1D9iYrqV4u78uTWwTXfDSA
         YuJo9IVQuCVWo5TnnMgiB4lK4fJV9PIajSBDMmRpy/RgnIFeJ7ao9awagrg9rLo14vvF
         2hPsaacF/EH5g36D2rWbPOWmL7qHjcAvitw6d1ARgRK8xr2ECtNOQVH6PfcUkXcp+zrV
         CQSdXFJvnDIpq/TLe4unKadPproWrkCQKhtgo3fJg0HsvR9FD/qTFp6GuF6XinCrANaO
         SxUnoEN14zghaFhESofrixnzWfjlDpYUt/Qi1KX57LpoltDYknZiDNC5q93OqjaABoLb
         TU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nh3BY/EYiNfImd0QzFgK2E2ecYL3iEaaQiYQ9Tc14OM=;
        b=zOAXdYvnQavSLbK2V9HfwHgxH9wUGuZ/MVsxU9Ja1oxoP4oOcA2Fhvy/+Y9FGZo3M7
         oXfATSXr5yp8WIATpJIxq39FMXAhboCFD8UTZeM+m+8S98i5BMQSj54OQxyBcgT2P5I2
         bgiFfAqLRi1cWkafI5hkQspPsx3vh090Bwxp/tYlCVImMkyj4YvtYndi2IQr6j31UYPu
         VM9V4C85+JTVzGyzvFsWTB5/HnoQIG9qsvW/voGNE0Q39CyePLOf4IC9VGD6pU5HYieM
         fSYjb9osV49wOt2bIyQIjYE+6SR4n+Af/oxZ2XOiNEza4omTMsXvHD8tyBLq1B5Xd1gc
         7jog==
X-Gm-Message-State: AOAM532RYpul/9cfL25FGAeqiMb2gHy4ljYNHADrWnhBkvTNB+DBwi90
        4BCzHkqiHR8x+HORd2MI4A==
X-Google-Smtp-Source: ABdhPJzgr+FOzRIqwc2a3t8I2DuFGic8dJ3+X2bw+UAscB5cws/CWCNQjMbC1Lxuu5P3bdrvfPBjKQ==
X-Received: by 2002:ac8:74d2:0:b0:2ed:130f:d69c with SMTP id j18-20020ac874d2000000b002ed130fd69cmr5007189qtr.49.1649628345308;
        Sun, 10 Apr 2022 15:05:45 -0700 (PDT)
Received: from arch.. ([2607:fb90:966:1288:8e89:a5ff:fe6f:56d3])
        by smtp.gmail.com with ESMTPSA id j18-20020ac85c52000000b002e1b9897ae7sm23593601qtj.10.2022.04.10.15.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 15:05:44 -0700 (PDT)
From:   Daniel Bomar <dbdaniel42@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bomar <dbdaniel42@gmail.com>
Subject: [PATCH 0/4] input: Implement an API for trigger rumble motors
Date:   Sun, 10 Apr 2022 17:04:49 -0500
Message-Id: <20220410220449.5071-1-dbdaniel42@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset extends the force feedback API to allow userspace to control
the force feedback motors underneath the triggers in some gamepads.

Patches 3 and 4 of this patchset implement this API in the xpad and
hid-microsoft drivers for the Xbox One controller over USB and bluetooth
respectively.

Daniel Bomar (4):
  input: uapi: Add trigger_left and trigger_right to ff_rumble_effect
    struct
  input: ff-memless: Add trigger left/right in ml_combine_effects
  input: xpad: Implement trigger rumble for Xbox One controllers
  input: hid-microsoft: Implement trigger rumble for Xbox One S over
    bluetooth

 drivers/hid/hid-microsoft.c   | 14 ++++++++++++--
 drivers/input/ff-memless.c    |  8 +++++++-
 drivers/input/joystick/xpad.c |  8 ++++++--
 include/uapi/linux/input.h    |  4 ++++
 4 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.35.1

