Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2292B4AA112
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiBDUU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiBDUU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:20:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD451C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:20:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso141130pjt.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 12:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLARV2vLdWLNe3OrNFwcSKvwDX7YeJ8H8pVDXRolev4=;
        b=ND6Z5G67g+DxqXki7u9odJVfwkIKOrMaJ5SU5867ElihufYb/a9f5JSf5tVgRu/t7O
         EDPs6hyiXSQYbgVgy8aLchl6WVEpG+h5VYAc/wwiFPE/tzWC7s47ewqB04+ysgLxb1ns
         k98R/bMDTgRKp8JYJEB89ifjYvf1/LYmcldLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLARV2vLdWLNe3OrNFwcSKvwDX7YeJ8H8pVDXRolev4=;
        b=lZSJHAhtDAC7212gwMDdFZGIYlHAy+S4DseTYn7LG7ND5MApJql5POcHJ/wU6O2wlP
         A5gEH395CXpUu5+kUFvrln/k0RrVSV1US2FfuMMnCkIfvy004epWjPxaDIJH0Neu60ad
         R4mIIH3fQcF+aPCf9wd/xx7C5qP2w8PCi4f12Zw+XERbyu4lcXfs79keQipU7eFq67Yv
         a5UJrXt2Hp6OfZejJPXxEQBOHHVNyBGnL9a7eov3Pn7K49ipppdWlBzSvsUNhZ2sT4J9
         mR4u33/ojnq4Ar5vchKjfMeq8hr1YZwESiAioDUm79P544AL3SapjWm1SotvqXv7OSEt
         5s1w==
X-Gm-Message-State: AOAM531fad+vkzs+9Qlvp3VuBVS8AvH9AxaUeL2eq/jdj3ey03hqEJlg
        P3tOgUkV6yBxaTKD12bguMxo7A==
X-Google-Smtp-Source: ABdhPJzm3EO4H389nY6yX0Tt9nBk2CzFTDFDs0/faYX3/qgT+O8jdGNioVY+F+7LIKavGkvjo9EH5g==
X-Received: by 2002:a17:90b:3698:: with SMTP id mj24mr5035079pjb.220.1644006023368;
        Fri, 04 Feb 2022 12:20:23 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ba2:dd59:3b59:18bc])
        by smtp.gmail.com with ESMTPSA id q17sm3385561pfk.108.2022.02.04.12.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 12:20:22 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH 0/5] Input/HID: Consolidate ChromeOS Vivaldi keyboard logic
Date:   Fri,  4 Feb 2022 12:20:16 -0800
Message-Id: <20220204202021.895426-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-on to this thread[1] where we discussed the need to
support the vivaldi keyboard function row keys in the google hammer
driver. I've extracted the common code into a new vivaldi-keymap.c file
that can be used by the various keyboard drivers used on ChromeOS
devices to expose the function_row_physmap sysfs attribute. That's a
good place to keep the HID parsing logic for the vivaldi and hammer
keyboards too, so one function goes there for that as well. Finally, we
add support for the function row physmap attribute to the hammer driver.

Cc: Jiri Kosina <jikos@kernel.org> 
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Sean O'Brien" <seobrien@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>

Stephen Boyd (4):
  Input: atkbd: Convert function_row_physmap to u16 array
  Input: Extract ChromeOS vivaldi physmap show function
  HID: Extract vivaldi hid feature mapping for use in hid-hammer
  HID: google: Add support for vivaldi to hid-hammer

Zhengqiao Xia (1):
  HID: google: modify HID device groups of eel

 drivers/hid/Kconfig                   |   2 +
 drivers/hid/hid-google-hammer.c       |  97 +++++++++++++++-----
 drivers/hid/hid-vivaldi.c             |  88 +-----------------
 drivers/input/Kconfig                 |   7 ++
 drivers/input/Makefile                |   1 +
 drivers/input/keyboard/Kconfig        |   2 +
 drivers/input/keyboard/atkbd.c        |  27 +++---
 drivers/input/keyboard/cros_ec_keyb.c |  30 +++----
 drivers/input/vivaldi-keymap.c        | 125 ++++++++++++++++++++++++++
 include/linux/input/vivaldi-keymap.h  |  37 ++++++++
 10 files changed, 274 insertions(+), 142 deletions(-)
 create mode 100644 drivers/input/vivaldi-keymap.c
 create mode 100644 include/linux/input/vivaldi-keymap.h

[1] https://lore.kernel.org/r/nycvar.YFH.7.76.2201140935460.28059@cbobk.fhfr.pm

base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
https://chromeos.dev

