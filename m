Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0730D4EAB77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiC2KkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiC2Kjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:39:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0F9C1C81
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:38:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r23so20202715edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQgKzNISqArDY7LULCiNgr15+k+211SoiUzs0z+KaHk=;
        b=UafYkExBfrtQOkXs0hiJM5CMmnfNeMYqVP9WjVGEnnYq+gIQ3xdUWTxcy/UMuNABxN
         8fOy8AAvQlkGODvupjseBTyoFNfY41656+6Dv5N+h3UI4mrkHKy+r8C0b8y/1aE61UHM
         YSxkkPuYQA4GFSzaWkjCEY2IfqOExj/vJD54dWbqNlHlei076q/v7lodTN1YOoQtJqHQ
         IEcvF3s/eknTjgcjt2RHSLwEHIsxqeIZNVIhso/nmf4IdoKhGPDUtqNpbJEG7mCsySlM
         rGX1m5UZlppE2qqfI5wfyosT12B7RpiI7zSPQBSZfc0SAMVDmIg3JxdaS0d8AvHiuVw4
         /Avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQgKzNISqArDY7LULCiNgr15+k+211SoiUzs0z+KaHk=;
        b=EMxDTCFV0/UKGvI9Al2LoVbI/ijrs04cyMPXvVV8ZVqpYfKie/86cdYlu3jCtk3qu5
         eVPcMZaPKSOKGu0PVJWda+4U0ARLyTjnx2oRYE6vL15ECnBkh4+8bisIyC+SVIY6l1T5
         bjAk/sSdCRpeqdwHDVret2T+cYx2zFDDhMcu+HRaB64cDJ54bAy1xXuaC+FJDa85sJi/
         q9IsZpsOLaW4p9VU69vZcWTmgqR4xLA2CUj4ZlJRWUVwXpU04gl5Ss4sQ6svTUJlFrAk
         KpFACPM0weS+W+KULKLap2J+IPoHUOvqjjp4M+1aCYhqfNZ/7H/BFNvE2zg0AL0VOWed
         yxTg==
X-Gm-Message-State: AOAM530lNOiZTsiDfNx/ClVYbzrxyxFfN3lsalkKI5aNYvyuzJP5ks58
        1Lx30Khxmke1kSGrmGDR9Jg=
X-Google-Smtp-Source: ABdhPJy8d/gjPOB0IPI+Kq7Zf45dYINkXtS4XeQL8gIcXyfg86a5K8JVNWNO4bhu8TAyEtmaUG3eHA==
X-Received: by 2002:aa7:cac4:0:b0:418:85b7:adec with SMTP id l4-20020aa7cac4000000b0041885b7adecmr3641052edt.231.1648550286161;
        Tue, 29 Mar 2022 03:38:06 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id qw39-20020a1709066a2700b006e03017d60csm7058151ejc.54.2022.03.29.03.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:38:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: refactor two small functions
Date:   Tue, 29 Mar 2022 12:37:52 +0200
Message-Id: <20220329103756.6740-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This series refactors two small functions to improve readability.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (4):
  staging: r8188eu: refactor rtw_usb_bulk_size_boundary()
  staging: r8188eu: refactor rtw_inc_and_chk_continual_urb_error()
  staging: r8188eu: convert rtw_usb_bulk_size_boundary() to bool
  staging: r8188eu: convert rtw_inc_and_chk_continual_urb_error() to
    bool

 drivers/staging/r8188eu/include/usb_ops.h | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

-- 
2.35.1

