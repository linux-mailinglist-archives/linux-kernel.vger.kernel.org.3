Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1FE5A7137
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiH3W6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiH3W6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:58:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C26682F8E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:58:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p8-20020a17090ad30800b001fdfc8c7567so2211902pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=19gKfO2YDbR1tWt1JPXALLMo6GyTndA+o+AoPOLFBAs=;
        b=cuBC6/5JrePt4mhJwmjB8G1ozut0+vlf2xAHpQSwWj9zRxbFHMMhFKL/8Qv5I0z9Ec
         mIhgGk99Tpt9MXjTxh2SvzCAvuyLxzK9AL8lkILTWZc1hZLy4RbiFwPW8P7qPTOjDa9N
         FCon6w5dPmosnUNTDoa2i7YYBPM0403jlqK3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=19gKfO2YDbR1tWt1JPXALLMo6GyTndA+o+AoPOLFBAs=;
        b=lpifFKpaq8Y1ATB5ta47EWo0gWyewKNk//F0MqZtJ86xe3tcL2fHtSZX6pW+qkaYU7
         u1ajBFmxo99W9+7NZPzemW48VyNoSvXLKq6/IXYn8sejOOoaX1o/c4CvtROf6wLG9G+T
         1HemjkMe0JyX5tU92Atv06D8eRWbriIlUidcAc78pHpkp2MfVD0qz61kiNzfiKxFEV1H
         maUGVZak4trv+D/Apq4MFcnJ4lNn8l/U95KV12AGKahe+q5QRzfM+Y1U+lg0fuSF1mDj
         s4hilImfXsh11PGtfm9eSeQ8wXoKYstGcqE3yzAfskkhHo3se1evJMGcCunuhbtVRkXI
         wHQg==
X-Gm-Message-State: ACgBeo1YRHRJLuI56w+hVjHoKNEV/brIiyBqhRegwHIVnuqfelAOZ5oF
        qlb0ECXTnVTbCpnTt/lsFXAOrQ==
X-Google-Smtp-Source: AA6agR7FX/ULITnzjbZuJ8dxIpYtuHEfPjEMHXQv0zaQxxGVpiyL6dIVjMuXdVDc3x962k1HOIh3jg==
X-Received: by 2002:a17:902:db05:b0:172:f759:f99d with SMTP id m5-20020a170902db0500b00172f759f99dmr23137940plx.76.1661900313631;
        Tue, 30 Aug 2022 15:58:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5f34:2f6:2856:188e])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001743be790b4sm10083539plb.215.2022.08.30.15.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 15:58:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 0/4] platform/chrome: Minor cleanups to cros_typec_switch
Date:   Tue, 30 Aug 2022 15:58:27 -0700
Message-Id: <20220830225831.2362403-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small cleanup patch pile for the new cros_typec_switch driver.

Stephen Boyd (4):
  platform/chrome: cros_typec_switch: Add missing newline on printk
  platform/chrome: cros_typec_switch: Remove impossible condition
  platform/chrome: cros_typec_switch: Use PTR_ERR_OR_ZERO() to simplify
  platform/chrome: cros_typec_switch: Inline DRV_NAME

 drivers/platform/chrome/cros_typec_switch.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)


base-commit: 1a8912caba02522f612d465a4849ce98915b96ad
-- 
https://chromeos.dev

