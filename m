Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45DB54F58F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381737AbiFQKgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380868AbiFQKgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:36:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD086AA76
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:36:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eo8so5679321edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfXZuA91UZ4UABMZy8DvtEqMCyRJz53qHahMYZKumBw=;
        b=lmM32/gxFg7OFSU0yBpZAixUFMlBMbbCmASnojBrHELKXKmA/HwcH31fYEoFlvCRp9
         JpFdyLF37tHd1nlHoFARAwe/JkIN/DkgdFFmXWY1t+NBP1iti0U3iPQjNp5NBMOVt2tT
         QWyzXUgQhUE3uF4MIm4N9sbGtuqvaKCTuUzM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfXZuA91UZ4UABMZy8DvtEqMCyRJz53qHahMYZKumBw=;
        b=TReEz3dzuIiyZbZmRWWSKod56glVhsksrHpuBaePkIkrL10EicmFqr5qylJ96Jmr2S
         /T4qmW6czYZUDpSM/HlHPmZRTqRSlEZ0KoRY3dz7q0aGqNruHiaASibfIx7eqhVfVtca
         gCAtMI7nP8ezzg++85Xhnk5kWpdi6PEiFdDahfoJHQxW2CIWnomkgP8ekpJqsFNAPK0a
         FU+4WzZDeQIDkaw9kMnS0awRU+jIj/CxdNTkf9G7688debnj+9BBwcNSMXeasfrqvJ7O
         A2wHbgAGOEFN7XmVY05Jb2/3TFK1BCp23tvRVibtU2lAIgNYMJ8SXHDFsSUyPZGqSo7G
         6eDw==
X-Gm-Message-State: AJIora/yune94SMHZdntNHTzbbfFmacWyTfBitWcn05Ld6PWyfGJYjKb
        w79Iv7g2pIlY965vyU6pkgRJmX2rbmCnaw==
X-Google-Smtp-Source: AGRyM1vBKGhE3blGgCFCpYyuox87WSMLlm8qxDeWkaQmL1yM658hXKm4My3ek8swl8FEvWv61VI0IQ==
X-Received: by 2002:aa7:dd85:0:b0:435:64d1:5ba with SMTP id g5-20020aa7dd85000000b0043564d105bamr1608968edv.389.1655462209698;
        Fri, 17 Jun 2022 03:36:49 -0700 (PDT)
Received: from alco.corp.google.com ([2620:0:1059:10:a86e:90:fb4:466e])
        by smtp.gmail.com with ESMTPSA id z19-20020a056402275300b004319b12371asm3704340edd.47.2022.06.17.03.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 03:36:48 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 0/8] uvcvideo: Fix handling of power_line_frequency
Date:   Fri, 17 Jun 2022 12:36:37 +0200
Message-Id: <20220617103645.71560-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is a new version of "[PATCH v3 0/7] uvcvideo: Fix handling
of power_line_frequency", with an attempt to generalize the
UVC_QUIRK_LIMITED_POWERLINE quirk that it introduced and turn it into a
control mappings override mechanism.

The goal is still to support the UVC 1.5 power line frequency control
extra option (patch 1/7), and work around an issue with devices that do
not implement support for disabling the power line frequency (patches
2/7 to 7/7).


Changelog v7:
- Support minimum for V4L2_CTRL_TYPE_MENU
  Fix uvc_query_v4l2_menu

Changelog v6:
- Add support for per-device control mapping overrides
  Fix invalid memory access
- Support minimum for V4L2_CTRL_TYPE_MENU
  New patch
- Limit power line control for Quanta UVC Webcam
  Fix id

Ricardo Ribalda (8):
  media: uvcvideo: Add missing value for power_line_frequency
  media: uvcvideo: Add support for per-device control mapping overrides
  media: uvcvideo: Support minimum for V4L2_CTRL_TYPE_MENU
  media: uvcvideo: Limit power line control for Quanta UVC Webcam
  media: uvcvideo: Limit power line control for Chicony Easycamera
  media: uvcvideo: Limit power line control for Chicony Easycamera
  media: uvcvideo: Limit power line control for Quanta cameras
  media: uvcvideo: Limit power line control for Acer EasyCamera

 drivers/media/usb/uvc/uvc_ctrl.c   | 90 ++++++++++++++++++++++++------
 drivers/media/usb/uvc/uvc_driver.c | 89 +++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  2 +
 3 files changed, 165 insertions(+), 16 deletions(-)

-- 
2.36.1.476.g0c4daa206d-goog

