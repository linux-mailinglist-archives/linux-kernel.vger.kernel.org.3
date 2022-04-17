Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ECA5048B1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiDQR5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiDQR5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:57:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1242C28
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v15so15311617edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OILYgrcMHgfS0MAxmoEH1VbxpcKZui0oVM3USNBv13c=;
        b=P5JmW2KvKOzg8qOf35NH2HDiMtRbk+FunpBhn4lw3vrTLmTtwn+zfCxWydq2GbZqDD
         pv+pniNDd2S/dD7GxQkyq73AAJJMRC3xnzIBhA/5JPwOYbYL/WTEEVEnfvM9qeYANwUV
         EQsvajbm7ra+t55FY2WbCC10lvtFqiJ4vrvGRogBav8w81z9ZHgb7VA6vi57p0fgUxC3
         nwKUSibDC1N+eyAhY1tj/8cLwp30FSiF+hxlXaR3loHhAw/qS5RTbQeymMNwZBlWcpvB
         0KOybdRncJsJqu7B+H8Fntd4y1iFNknSdkmOZ4x17GwBJ2KYCcbJZa7HWXJmHkJCFO91
         Y8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OILYgrcMHgfS0MAxmoEH1VbxpcKZui0oVM3USNBv13c=;
        b=UAsEfXX9NIFaUKBwEqabnB99Lmn7T/f9MYcT0JtT+QvYUR1UYTZ/xrVuyzIn4VAZVg
         CMA//hIeJSR7rxLDML87xWtP+XvuOTbHyW7L65FYPEhksDlMLSuxtD7h3K81GTwb/Q00
         L/+wZRA7UesdOfR9sF+TsRJBHlIx2V2m/GWZW1ROlhzpXDDhojA9xY1pRJ9dCIRGBs24
         /hCZ79Z4cg/fdUv/c942lEQEDc99j8R3DdqsqlbABj/s+0gZdTdHwcKIJs6p5QrEOZ/P
         qqqttogT0dURnHqRkiOApwWzHt7C1cRDle2t+FD57ii7vnV+SYA88DqUCw2FZwK2FMiI
         2G3w==
X-Gm-Message-State: AOAM531uxljhUcBvnXvd5kENZtqKUneIOOTv3dewiP0K8tXb392ZNyxG
        kycLthzpRldunbG8WwAztXXr91eK/Io=
X-Google-Smtp-Source: ABdhPJwqZKjheh+2KqPTKOUweCixJfif8kv973dXy3667xA5l9SqWcbZHJ5+FUDWF3oeidpQTGO5Xw==
X-Received: by 2002:aa7:ce05:0:b0:41d:6857:549e with SMTP id d5-20020aa7ce05000000b0041d6857549emr8844788edv.251.1650218087587;
        Sun, 17 Apr 2022 10:54:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id jw12-20020a17090776ac00b006e87137194esm3719409ejc.150.2022.04.17.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 10:54:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v4 0/8] staging: r8188eu: fix and clean up some firmware code
Date:   Sun, 17 Apr 2022 19:54:33 +0200
Message-Id: <20220417175441.13830-1-straube.linux@gmail.com>
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

This series fixes wrong size of struct rt_firmware_hdr in the first
patch and does some cleanups in rtl8188e_firmware_download() in the
other patches.

Tested on x86_64 with Inter-Tech DMG-02.

v4:
- Keep the in-line comments of struct rt_firmware_hdr.

v3:
- Splitted the first patch into two separate patches.
- Added back logging the firmware version only once.
- Included the compile time check for size of rt_firmware_hdr from
  patch 8/8 of v2 in the patch that replaces the hardcoded size.

v2:
- Added a patch to check size of struct rt_firmware_hdr at compile time.

Michael Straube (8):
  staging: r8188eu: fix struct rt_firmware_hdr
  staging: r8188eu: convert u32 fields of rt_firmware_hdr to __le32
  staging: r8188eu: clean up comments in struct rt_firmware_hdr
  staging: r8188eu: rename fields of struct rt_firmware_hdr
  staging: r8188eu: use sizeof instead of hardcoded firmware header size
  staging: r8188eu: remove variables from rtl8188e_firmware_download()
  staging: r8188eu: use pr_info_once() to log the firmware version
  staging: r8188eu: check firmware header existence before access

 drivers/staging/r8188eu/core/rtw_fw.c | 84 +++++++++++----------------
 1 file changed, 34 insertions(+), 50 deletions(-)

-- 
2.35.1

