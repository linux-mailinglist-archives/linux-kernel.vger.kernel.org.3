Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C356BD56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbiGHPsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiGHPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:48:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C8DE84
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:48:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o4so31106453wrh.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 08:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4TnFR2Q9YmCmADU+mpEOsvnqVimQx/GMp9QcmpwALM=;
        b=ZvpY9fbp5EIY4ryVuzlfHXcQ3yT/bykq2Fhoy2n4xuzuIpt7PntezNCTVWCpb/zwVD
         Ix8aIt0HB2ey6V4mn+74JJHEcEK6N/i4vguikAoVEiVFeBqzv0zvhbhxjFgZ5xwSa5tu
         HWH9L5m/8e45tE3rYvDnNPAaFdGS8e9rQbAX/HBEjwiw4VnBZ5sPj8REHRnQvn2DrOf/
         qLvwxjM6OotYWiMhjqyL7S3uCTIxosirRkmziGJDt1dWdRxbROFJICpWiOrX8WSJ9EV6
         D9dC6inqsr3NJW3gYyivs++DhpeaBVx20bBG5+lJGCGnlwHj5GKI423Sn2pizRec4ZEc
         0rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4TnFR2Q9YmCmADU+mpEOsvnqVimQx/GMp9QcmpwALM=;
        b=Z5kJx1cgCGzxjvOf3rz2m4HOdTy5d0/WE78+s7bWS0/AAzEFhimViDaGSoM8xhgRdZ
         TK9iQcpTxyCRBkdz3Jq2ocWDgNlwqzSo9+hCU1DzsXUcgLGX2Iz4yFBSA0rCa3tH2xzM
         F5mDIJgdCdZ/C4UZIJM5y9Imnxrf8Yvgx8x/MTEjqYvm3FG7yKZw61q/RqtslvCKBtrG
         mE0ajHAWtEEREuU/Nn/MsHRNFCaNJA92B7B70kLeWDpjm8GFSR+2nFDbrZLn7SJOKYaZ
         d42+OjRqk04S58FD6T4MlN27qv28cK/lP1PYwPm7v2Bh+cA3taf1dQeVhS9fH3HnKgqs
         yLpg==
X-Gm-Message-State: AJIora+e3o7ybYyqDuDOLhTiAoQvmpd4AHTNCjdXqRos2wx6yL6sQzvb
        ROzoP6VHkMUU/DcrsCCBpQGpqlRNoUm5Qg==
X-Google-Smtp-Source: AGRyM1ttmvmjEiqRAegnp9UX0GrMdPHyD2e0mr9WMZkxNN1oQmYPf4Ht2TM9jVSRluTD382HdSwZ+Q==
X-Received: by 2002:a05:6000:992:b0:21d:9240:4337 with SMTP id by18-20020a056000099200b0021d92404337mr2600512wrb.323.1657295315219;
        Fri, 08 Jul 2022 08:48:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6297:9b4f:f1ed:cde0])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003a03e63e428sm3869870wmq.36.2022.07.08.08.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 08:48:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.19-rc6
Date:   Fri,  8 Jul 2022 17:48:32 +0200
Message-Id: <20220708154832.67452-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following fixes from the GPIO subsystem.

Best Regards,
Bartosz Golaszewski

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc6

for you to fetch changes up to c8e27a4a5136e7230f9e4ffcf132705bf56864cc:

  gpiolib: cdev: fix null pointer dereference in linereq_free() (2022-07-07 12:18:18 +0200)

----------------------------------------------------------------
gpio fixes for v5.19-rc6

- fix a build error in gpio-vf610
- fix a null-pointer dereference in the GPIO character device code

----------------------------------------------------------------
Kent Gibson (1):
      gpiolib: cdev: fix null pointer dereference in linereq_free()

Leon Romanovsky (1):
      gpio: vf610: fix compilation error

 drivers/gpio/gpio-vf610.c   | 1 +
 drivers/gpio/gpiolib-cdev.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)
