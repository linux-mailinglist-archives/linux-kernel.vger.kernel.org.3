Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94F2597561
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbiHQRvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiHQRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:51:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52E67B786
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:51:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p18so12601623plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kWck20S1B+F14QNxCoJfAR+/3TD94IN6T9hA3skKazc=;
        b=GXH9jSMPPj0o5jJEYkmfhqF7ueKW2cVKn5uh7+RxeTQWuYByj4vGGyqPH6i0mhj5cz
         mfGUvN8CWxJGdJ/ICESAHxubo2RBuu5lcCX2w7Iv8vNe3yrYCTjpUnfKkgON3lGRSzWC
         9UUIvAtWE8REDTU+FFo46bIrT4szc86T8Cv73RVOcKZEM/Evy802fBjGSle4DQDdp7dL
         XFq/gz/YEW35sSql3gwF0yQM6gg4s9LzTF48yBvdxXRdvWqM6iR+zJRWLCEWKTeExiwT
         9wgbpLoBgMkA83yJ6KAwrMVBnKUjJTa4tlSsAAaL2lRs/k+bNAJfey1AYeUOWdyi36hG
         n5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kWck20S1B+F14QNxCoJfAR+/3TD94IN6T9hA3skKazc=;
        b=lnRUZDXMDOJ6z6f2zGZ3mPJiv/N6Ie+/Wgnk637ilCckBHB+7tissO1ArKwBKEx4Im
         x3zmUTHHIBIjj8aSljYQhpfw7rc10+hnlDV0sw2wxf39bNUT6p6NWWazPp4g5yjaEh8F
         r8nbB8eGdpPpIZknKy+QoKX7fhQqB7gfANyOysGrrUSdwBwKAYUe8sq77TgZGR1aYLOw
         JaWFDszSn/aVebW/eFy4Qc49oKH6JJjC2pxNofSL7mRQdEDzTwTFAh+rrGKWTL1v+X49
         5R2jS91zzUSALUgJk793eyXp5xix8xrTJWveQJLQBxM2mG/BdujdpX/0LSSS0+94AvLU
         BQCw==
X-Gm-Message-State: ACgBeo1sqLfDVupiag4wKUYzlVoPZv3ARSfQz9AjHgZQx5h7wWWXJJvv
        W4d6Mrzy/DqKALn28OhD7r7FLUYokBbrByoA
X-Google-Smtp-Source: AA6agR5ZYLi82ql41LRFSL9bT86RXgUa8FyjSpMspI7A3p4dVht9dllCbmBkniKzTS6fRHwZiL+LiQ==
X-Received: by 2002:a17:90b:278b:b0:1f7:66b6:a86d with SMTP id pw11-20020a17090b278b00b001f766b6a86dmr4940147pjb.115.1660758697173;
        Wed, 17 Aug 2022 10:51:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8f80:973::5f])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7991d000000b0052f0a616a87sm10734127pff.168.2022.08.17.10.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:51:36 -0700 (PDT)
From:   Nate Yocom <nate@yocom.org>
To:     dmitry.torokhov@gmail.com
Cc:     nate@yocom.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hadess@hadess.net
Subject: [PATCH v4 0/3] Input: joystick: xpad: Add X-Box Adaptive Controller support
Date:   Wed, 17 Aug 2022 10:51:31 -0700
Message-Id: <20220817175134.15084-1-nate@yocom.org>
X-Mailer: git-send-email 2.30.2
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

Adds support for the X-Box Adaptive Controller, which is protocol
compatible with the XTYPE_XBOXONE support in the driver with two deltas:

 - The X-Box button sets 0x02 as its activation ID, where others set
   0x01
 - The controller has an additional Profile button with 4 active states,
   which this change maps to an Axis control with 4 possible values

Patch series adds device to the supported table, adds support for the
Profile button, and adds support for the X-Box button as distinct changes.

Signed-off-by: Nate Yocom <nate@yocom.org>

Nate Yocom (3):
  Input: joystick: xpad: Add X-Box Adaptive Controller support
  Input: joystick: xpad: Add X-Box Adaptive Controller Profile button
  Input: joystick: xpad: Add X-Box Adaptive Controller XBox button

 v2: Fix warning Reported-by: kernel test robot <lkp@intel.com>
 v3: Break into multi-part and remove VID/PID check for XBox button
 v4: Rename Layer -> Profile as suggested by Bastien Nocera <hadess@hadess.net>

 drivers/input/joystick/xpad.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)


base-commit: 15205c2829ca2cbb5ece5ceaafe1171a8470e62b
-- 
2.30.2

